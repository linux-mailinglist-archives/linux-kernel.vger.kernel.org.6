Return-Path: <linux-kernel+bounces-255407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC6934068
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311C51F21A36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E7181CF8;
	Wed, 17 Jul 2024 16:28:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27EE181BA0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233717; cv=none; b=k7BT97SlszmRavqpdwtPhNhJRc8xSACyWMzvQJCNEegF68hmJd55CDmbl9oj3f0z1aK/4YtW8gUeIpN1HXqn7Uo2STCPInpH/Eac4Sdn0xOOKNdoL/u349NAC/gKLzunZCdeCc/w/KHlOfCBMyWciJDInpzIrYIzQWJoDRI5Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233717; c=relaxed/simple;
	bh=CDVZaVI6ZoRtIGoowBWkAbttMNY9inmaCVN2kxSlq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQxzdDceh3H3nugk503XhA2VbR34HktYt+6XNmQZqq2dnllGVrhXP7sesvyeBbKfSD6n3Y/l0KH+hczlayd21QI3b1EZ9XyZDiS2KYJhWQ7D++081ockdpk/Bv+jANFfJUITxaMzNibW/KG9YnQpk/AldMfz9LtqsOTRTpPDfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75AEC1063;
	Wed, 17 Jul 2024 09:28:59 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44BB3F766;
	Wed, 17 Jul 2024 09:28:32 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:28:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jakub Jelinek <jakub@gcc.gnu.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Alex Coplan <alex.coplan@arm.com>,
	Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: RESEND: GCC asm goto outputs workaround (Was: "Re: [PATCH 1/3]
 arm64: start using 'asm goto' for get_user() when") available
Message-ID: <ZpfxLrJAOF2YNqCk@J2N7QTR9R3.cambridge.arm.com>
References: <20240709161022.1035500-1-torvalds@linux-foundation.org>
 <20240709161022.1035500-2-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709161022.1035500-2-torvalds@linux-foundation.org>

[resending as I messed up the LKML address; sorry!]

Hi Linus,

As a heads-up, this is tickling a GCC bug with asm goto outputs in GCC
versions prior to 14.1.0, and the existing asm_goto_output() workaround
doesn't seem to be sufficent. More details on that below, and I've added
LKML and the usual folk to CC, including compiler folk who looked into
this area before. The gist is that in the paths where we jump to a goto
label GCC may erroneously omit assignments to variables which get
assigned an output of the asm in the non-branching case.

The big question is can we actually workaround this, or do we need to
bite the bullet and say that we need GCC 14.1.0 or later?

I spotted that while preparing a fixup for a thinko with
_ASM_EXTABLE_##type##ACCESS_ERR(), where we put the error code (-EFAULT)
into the value register. That *should* be benign, since in the faulting
case we subsequently assign 0, but due to the compiler bug GCC discards
that later assignment...

On Tue, Jul 09, 2024 at 09:01:59AM -0700, Linus Torvalds wrote:
> -#define __get_mem_asm(load, reg, x, addr, err, type)			\
> +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> +#define __get_mem_asm(load, reg, x, addr, label, type)			\
> +	asm_goto_output(						\
> +	"1:	" load "	" reg "0, [%1]\n"			\
> +	_ASM_EXTABLE_##type##ACCESS_ERR(1b, %l2, %w0)			\
> +	: "=r" (x)							\
> +	: "r" (addr) : : label)

Ignoring the compiler bug, the extable entry should be:

	_ASM_EXTABLE_##type##ACCESS(1b, %l2)

... since we don't have an error variable, and we don't intend to move
-EFAULT into the value destination register (which the extable fixup
handler will do for the 'error' value register).

I'll send a fixup for that, but the more pressing issue is
miscompilation, which seems to be the issue fixed in GCC in:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921

... which we tried to work around in commits:

  4356e9f841f7fbb9 ("work around gcc bugs with 'asm goto' with outputs")
  68fb3ca0e408e00d ("update workarounds for gcc "asm goto" issue")

... which we currently try to workaround that issue with the
asm_goto_output() macro:

| #define asm_goto_output(x...) \
|         do { asm volatile goto(x); asm (""); } while (0)

... but testing indicates that's insufficient on arm64 and x86_64, and
even with that I see GCC erroneously omitting assignments to variables
in the 'goto' paths, where those are assigned an output in the non-goto
path.

As a reduced test case I have:

| #define asm_goto_output(x...) \
|         do { asm volatile goto(x); asm (""); } while (0)
| 
| #define __good_or_bad(__val, __key)                                     \
| do {                                                                    \
|         __label__ __failed;                                             \
|         unsigned long __tmp;                                            \
|         asm_goto_output(                                                \
|         "       cbnz    %[key], %l[__failed]\n"                         \
|         "       mov     %[val], #0x900d\n"                              \
|         : [val] "=r" (__tmp)                                            \
|         : [key] "r" (__key)                                             \
|         :                                                               \
|         : __failed);                                                    \
|         (__val) = __tmp;                                                \
|         break;                                                          \
| __failed:                                                               \
|         (__val) = 0xbad;                                                \
| } while (0)
| 
| unsigned long get_val(unsigned long key);
| unsigned long get_val(unsigned long key)
| {
|         unsigned long val = 0xbad;
| 
|         __good_or_bad(val, key);
| 
|         return val;
| }

... which GCC 13.2.0 (at -O2) compiles to:

| 	cbnz    x0, .Lfailed
| 	mov     x0, #0x900d
| .Lfailed:
| 	ret

... where the assignment to '__val' in the '__failed' case has been
omitted.

If I add an 'asm("");' immediately after the '__failed' label, before the
assignment, GCC 13.2.0 generates:

| 	cbnz    x0, .Lfailed
| 	mov     x0, #0x900d
| 	ret
| .Lfailed:
| 	mov     x0, #0xbad
| 	ret

... where the assignment is retained as we'd hope.

GCC 14.1.0 generates the later sequence regardless of the presence of an asm
after the __failed label.

Can anyone from the GCC side comment as to whether placing the dummy asm("")
block after the goto labels is a sufficient workaround, or whether that's just
avoiding the issue by chance?

Further examples below.

With current mainline, building the following:

| #include <linux/uaccess.h>
| #include <linux/types.h>
| 
| noinline unsigned long test_get_user(unsigned long __user *ptr);
| noinline unsigned long test_get_user(unsigned long __user *ptr)
| {
|         unsigned long val;
| 
|         if (!access_ok(ptr, sizeof(*ptr)))
|                 return 0xdead;
|     
|         if (get_user(val, ptr))
|                 val = 0x900d;
|     
|         return val;
| }

GCC 13.2.0, arm64 defconfig + ARM64_TAGGED_ADDR_ABI=n generates:

|         mov     x1, #0xffffffffffff8
|         cmp     x0, x1
|         b.hi    .Laccess_not_ok
|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
| .Lextable_fixup:
|         ret
| .Laccess_not_ok:
|         mov     x0, #0xdead
|         ret

... entirely omitting the assignment to 'val' in the error path.

GCC 14.1.0, arm64 defconfig + ARM64_TAGGED_ADDR_ABI=n generates:

|         mov     x1, #0xffffffffffff8
|         cmp     x0, x1
|         b.hi    .Laccess_not_ok
|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
|         ret
| .Laccess_not_ok:
|         mov     x0, #0xdead
|         ret
| .Lextable_fixup:
|         mov     x0, #0x900d
|         ret

... with the expected assignment to 'val' in the error path.

On x86 we don't see this for regular get_user() because that calls
out-of-line asm rather than using asm goto with outputs. However
unsafe_get_user() usage does get miscompiled on both arm64 and x86_64.
In the unsafe_* case we generally don't manipulate the value register in
the error path, so we largely don't notice, but this is fragile.

With current mainline, building the following:

| #include <linux/uaccess.h>
| #include <linux/types.h>
| 
| noinline unsigned long test_unsafe_get_user(unsigned long __user *ptr);
| noinline unsigned long test_unsafe_get_user(unsigned long __user *ptr)
| {
|         unsigned long val;
| 
|         unsafe_get_user(val, ptr, Efault);
|         return val;
| 
| Efault:
|         val = 0x900d;
|         return val;
| }

GCC 13.2.0, arm64 defconfig generates:

|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
| .Lextable_fixup:
|         ret

GCC 13.2.0, x86_64 defconfig + MITIGATION_RETPOLINE=n generates:

|         endbr64
|         mov    (%rdi),%rax
| .Lextable_fixup:
|         ret

... omitting the assignment to 'val' in the error path.

GCC 14.1.0, arm64 defconfig generates:

|         and     x0, x0, #0xff7fffffffffffff
|         ldtr    x0, [x0]
|         ret
| .Lextable_fixup:
|         mov     x0, #0x900d                     // #36877
|         ret

GCC 14.1.0, x86_64 defconfig + MITIGATION_RETPOLINE=n generates:

|         endbr64
|         mov    (%rdi),%rax
|         ret
| .Lextable_fixup:
|         mov    $0x900d,%eax
|         ret

... with the expected assignment to 'val' in the error path.

Mark.

