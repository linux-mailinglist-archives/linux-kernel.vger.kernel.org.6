Return-Path: <linux-kernel+bounces-256195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B3934A87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13F32847B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE17F7C3;
	Thu, 18 Jul 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B67/8SEi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF77FBA1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292984; cv=none; b=DzCGU7lSWlkbhPJk7E+FETOn4p7PD1APBxtpXQUxWU8XBDX5frhc+OeiPOQFLJmhJO1JEmjZEfSRKDYBBcabBC9QKEZdNXMzch8ucdLUIgrKJefEYSUqi+I5CT0HghvCVNvnwuiGE/Vjcg1UxYKC8Q1hywIx4j1bj2ZTPrsHils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292984; c=relaxed/simple;
	bh=ufHGR84Ts7TyIV1HbNK0pVDmWcDSKSrL7sy3BOnKJxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WHKLwWFUt9IJDw/w2294ad3sjW1uvG0z0GLqNxdiQuLavoH+yfLjY9NteN4AvKmeB2EQ11z0X3OVzDgAZPvZiBXPjUWjssJqDNO5P3g+SOmOGugwc9v5dJaF5gOu80S98F8d5CUqCyXi1gypHpQCI3e9Ia8dqaMxfFLHtX7rQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=B67/8SEi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46I8twLp3139901
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 18 Jul 2024 01:55:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46I8twLp3139901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1721292959;
	bh=p1bS2PJReKAboFX8GdS8kSgPNgi46JIAfAMiwdA5Yj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B67/8SEiq4HXk/Qj3qNV/vqxZ70XizOTTxgavbjeWSiRe5JnQUcgmnCALCxJWPs7w
	 UCkiTfMl7EnbfhDka3XVQESnRJlKOiiHJybldCTuR/XAAYtyNKLTuzufH1R0dspYjB
	 pUy7PUD+372vUbj2MPvRnIKBq28tALlo4Op/1EJUsiLwW3sxyrPKO7jDWAgD7HEbTA
	 Hk+hWtuBVputeneA2qQFns2SdqYsLOsIpNdyfGZmOkIHZXbifkhcH9BjlWpjPLF/oF
	 PphKMav1C9CbF0emWJu9oEaXxjh52p6UBlXRUGfID8PtHYhDLhQftVvKT0GaqcrtFA
	 unjVBau/+rNew==
Date: Thu, 18 Jul 2024 01:55:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Use_=5F=5FASM=5FSIZE?=
 =?US-ASCII?Q?=28=29_to_reduce_ifdeffery_in_cpuflags=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4bs7meRq_iTqq1nSzpkSzEQqLkM8S=x4=zqtX6Fo9qQPQ@mail.gmail.com>
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com> <CAFULd4bs7meRq_iTqq1nSzpkSzEQqLkM8S=x4=zqtX6Fo9qQPQ@mail.gmail.com>
Message-ID: <77174D9A-79DE-44A7-85E0-63B0BFE343C2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 18, 2024 1:52:17 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Thu, Jul 18, 2024 at 8:36=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wro=
te:
>> >Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf=2E
>> >
>> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> >Cc: Ingo Molnar <mingo@kernel=2Eorg>
>> >Cc: Borislav Petkov <bp@alien8=2Ede>
>> >Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >---
>> > arch/x86/boot/cpuflags=2Ec | 10 +++-------
>> > 1 file changed, 3 insertions(+), 7 deletions(-)
>> >
>> >diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2Ec
>> >index d75237ba7ce9=2E=2Eaacabe431fd5 100644
>> >--- a/arch/x86/boot/cpuflags=2Ec
>> >+++ b/arch/x86/boot/cpuflags=2Ec
>> >@@ -2,6 +2,7 @@
>> > #include <linux/types=2Eh>
>> > #include "bitops=2Eh"
>> >
>> >+#include <asm/asm=2Eh>
>> > #include <asm/processor-flags=2Eh>
>> > #include <asm/required-features=2Eh>
>> > #include <asm/msr-index=2Eh>
>> >@@ -36,13 +37,8 @@ static int has_fpu(void)
>> >  * compressed/ directory where it may be 64-bit code, and thus needs
>> >  * to be 'pushfq' or 'popfq' in that case=2E
>> >  */
>> >-#ifdef __x86_64__
>> >-#define PUSHF "pushfq"
>> >-#define POPF "popfq"
>> >-#else
>> >-#define PUSHF "pushfl"
>> >-#define POPF "popfl"
>> >-#endif
>> >+#define PUSHF __ASM_SIZE(pushf)
>> >+#define POPF __ASM_SIZE(popf)
>> >
>> > int has_eflag(unsigned long mask)
>> > {
>>
>> Just use pushf/popf=2E gas hasn't needed that suffix for a long time as=
 far as I know=2E
>
>Unfortunately, clang does not do the right thing when pushf/popf
>without suffix are used=2E
>
>arch/x86/boot/cpuflags=2Ec compiles to:
>
>00000000 <has_eflag>:
>   0:    9c                       pushf
>   1:    9c                       pushf
>   2:    66 5a                    pop    %edx
>   4:    66 89 d1                 mov    %edx,%ecx
>   7:    66 31 c1                 xor    %eax,%ecx
>   a:    66 51                    push   %ecx
>   c:    9d                       popf
>   d:    9c                       pushf
>   e:    66 59                    pop    %ecx
>  10:    9d                       popf
>  11:    66 31 ca                 xor    %ecx,%edx
>  14:    66 31 c9                 xor    %ecx,%ecx
>  17:    66 85 c2                 test   %eax,%edx
>  1a:    0f 95 c1                 setne  %cl
>  1d:    66 89 c8                 mov    %ecx,%eax
>  20:    66 c3                    retl
>
>instead of:
>
>00000000 <has_eflag>:
>   0:    66 9c                    pushfl
>   2:    66 9c                    pushfl
>   4:    66 5a                    pop    %edx
>   6:    66 89 d1                 mov    %edx,%ecx
>   9:    66 31 c1                 xor    %eax,%ecx
>   c:    66 51                    push   %ecx
>   e:    66 9d                    popfl
>  10:    66 9c                    pushfl
>  12:    66 59                    pop    %ecx
>  14:    66 9d                    popfl
>  16:    66 31 ca                 xor    %ecx,%edx
>  19:    66 31 c9                 xor    %ecx,%ecx
>  1c:    66 85 c2                 test   %eax,%edx
>  1f:    0f 95 c1                 setne  %cl
>  22:    66 89 c8                 mov    %ecx,%eax
>  25:    66 c3                    retl
>
>Please note missing 0x66 operand size override prefixes with pushfl
>and popfl=2E This is 16bit code, operand prefixes are mandatory to push
>32-bit EFLAGS register (ID flag lives in bit 21)=2E
>
>So, the original patch is the way to go=2E
>
>Uros=2E
>

You do know that has_eflag can be completely elided on x86-64, or you can =
use %z with one of the register operands=2E

One more reason why clang really needs to shape up=2E

