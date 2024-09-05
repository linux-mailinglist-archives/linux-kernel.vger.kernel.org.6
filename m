Return-Path: <linux-kernel+bounces-317218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5B96DB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B32E1F270C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0119DF68;
	Thu,  5 Sep 2024 14:03:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BA19DF43
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545029; cv=none; b=Qn+jE2Zu1TsUmW77ZN4bLG0V9zTkFiX6ieNwiqOI1cpNkIYGvLuFGocbVXRGY7ijFHRlrMSvwSpK2QnjKlbpkb314pHXPT897+zeHYEjzdlS19cstKI1woC+80dBMreGkjtLNkpfkRiRxInCMFtjmkeuyXrCvNMRwAr+90OhQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545029; c=relaxed/simple;
	bh=htu0Nvpe4IfY0NtyRQnv/eIJUyKFKNjpyhdvPje3PKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpbSNur/sdE2U2avrwecjyAcHx0rEyOMtV3t4R4tmQDPTlRH3IpeLRFEhgf8mi3CbuedIHUo6daD4oj+0G1adYi0BQKsPqf283nbUL7pmbnhqVw4EbzCg6dVhfsNXf3h57nBYvDMuCSB2sIJvXpPDNtd5i/9pHtBkP32y0dVsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96223FEC;
	Thu,  5 Sep 2024 07:04:12 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517DB3F73F;
	Thu,  5 Sep 2024 07:03:44 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:03:34 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	ardb@kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
Message-ID: <Ztm56ZxiqlTL6ntA@J2N7QTR9R3.cambridge.arm.com>
References: <000000000000f362e80620e27859@google.com>
 <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wmjwvatn.wl-maz@kernel.org>

[adding Ard and LLVM folk; there's a question right at the end after
some context]

On Sat, Aug 31, 2024 at 06:52:52PM +0100, Marc Zyngier wrote:
> On Fri, 30 Aug 2024 10:52:54 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
> > 
> > +Marc, as this is his branch.
> >
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm64
> 
> As it turns out, this isn't specific to this branch. I can reproduce
> it with this config on a vanilla 6.10 as a KVM guest. Even worse,
> compiling with clang results in an unbootable kernel (without any
> output at all).
> 
> Mind you, the binary is absolutely massive (130MB with gcc, 156MB with
> clang), and I wouldn't be surprised if we were hitting some kind of
> odd limit.

Putting the KASAN issue aside (which I'll handle in a separate thread),
I think there is a real issue here with LLVM.

What's going on here is that .idmap.text ends up more than 128M away
from .head.text, so the 'b primary_entry' at the start of the Image
isn't in range:

| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text        
| ffff800080000000 g       .head.text     0000000000000000 _text
| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
| ffff8000889df0e0 g       .rodata.text   000000000000006c primary_entry

... as those are ~128MiB apart.

When building with GCC those end up ~101MiB apart:

| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text        
| ffff800080000000 g       .head.text     0000000000000000 _text
| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
| ffff8000865ae0e0 g       .rodata.text   000000000000006c primary_entry

When that happens, LLD makes the header branch to a veneer/thunk:

| ffff800080000000 <_text>:
| ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
| ffff800080000004:       14003fff        b       ffff800080010000 <__AArch64AbsLongThunk_primary_entry>

... and unfortunately, that veneer/thunk uses a literal with the
statically-linked TTBR1 address of primary_entry:

| ffff800080010000 <__AArch64AbsLongThunk_primary_entry>:
| ffff800080010000:       58000050        ldr     x16, ffff800080010008 <__AArch64AbsLongThunk_primary_entry+0x8>
| ffff800080010004:       d61f0200        br      x16
| ffff800080010008:       889df0e0        .word   0x889df0e0
| ffff80008001000c:       ffff8000        .word   0xffff8000

... so as soon as the CPU tries to branch there it'll take a synchronous
exception since either:

(a) The MMU is off, and that's larger than the physical address size.

(b) The MMU is on, but there's no TTBR1 mapping.

We can bodge around this instance by manually open-coding a veneer with
ADRP+ADD+BR after the header, and having the header branch to that, but
AFAICT we have no guarantee that other early asm or PI C code won't hit
the same problem.

It'd be good if we could convince LLD to use ADRP+ADD, since we already
rely on the entire kernel image falling within 2GiB for data
relocations. I'm not sure if it doesn't support using ADRP+ADD in
veneers or if we're doing something that prevents it from using ADRP+ADD
in the veneer.

By comparison, if I force the branch range to be longer, GCC 14.1.0 and
GNU LD 2.4.20 use ADRP+ADD for the veneer, and the resulting kernel
boots successfully.

I tested that by hacking some .rodata between .head.text and .idmap.text
with:

| char hack_force_veneer[SZ_128M] __ro_after_init;

... which forces a ~230MiB branch range using the config above:

| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text        
| ffff800080000000 g       .head.text     0000000000000000 _text
| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
| ffff80008e5be0e0 g       .rodata.text   000000000000006c primary_entry

... with the generated code being:

| ffff800080000000 <__efistub__text>:
| ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
| ffff800080000004:       14004001        b       ffff800080010008 <__primary_entry_veneer>
...
| ffff800080010008 <__primary_entry_veneer>:
| ffff800080010008:       d0072d70        adrp    x16, ffff80008e5be000 <__idmap_text_start>
| ffff80008001000c:       91038210        add     x16, x16, #0xe0
| ffff800080010010:       d61f0200        br      x16

LLVM folk, is there any existing option to ask LLD to use ADRP+ADD for
the veneer/thunk? ... and if not, would it be possible to add an option
for that?

I realise it shouldn't matter for most users, but it'd be nice to avoid
the boobytrap for anyone building test kernels.

Mark.

