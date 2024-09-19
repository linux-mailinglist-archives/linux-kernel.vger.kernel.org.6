Return-Path: <linux-kernel+bounces-333304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DCE97C6B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA341F2822E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1D194C8D;
	Thu, 19 Sep 2024 09:14:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01633D8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737295; cv=none; b=OJCLXd9B6iaJjlG4ibswBhfhunqJUBpMAa/4KlTKZISuhWrZ1uYTnceKBViX0kbf7VgBjVTJ2b5WV/pFudicHnWd5L/S1bDjQ4TlRxxQCYbtkMDgSqW2bK18EK8nPRpHcVlHH7XU8YGqCbHtu6yjODsSUevaGUUilDZnSkUeeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737295; c=relaxed/simple;
	bh=/Bop51NWsFXZqPBpDi2uoPivsk+HiblKv2mVbioil0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgX+XA/+mjCW3Za5WU6TDgLOXM3yWmH3ZAzX86bhPrT9+cBc+IYXT/QMmq9N2rk28z46STA/KU0QT7TrsY5dM/NrJPt0yWYW4AAALmu8DMM0A3gbnOXVR/ps0iVLVlu4VO7SD0O3m6Y8ZaxELFM+ROmRGCMzkgMJjfpCks23hlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0451007;
	Thu, 19 Sep 2024 02:15:22 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF2B3F71A;
	Thu, 19 Sep 2024 02:14:50 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:14:45 +0200
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
Message-ID: <ZuvrhZjBuKLdJ9N0@J2N7QTR9R3>
References: <000000000000f362e80620e27859@google.com>
 <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org>
 <Ztm56ZxiqlTL6ntA@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXHHRvWBPOoxOU=S0BY6fkEhs1j1qBvrygBH7pKwnbcJXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHHRvWBPOoxOU=S0BY6fkEhs1j1qBvrygBH7pKwnbcJXA@mail.gmail.com>

On Thu, Sep 05, 2024 at 04:25:57PM +0200, Ard Biesheuvel wrote:
> On Thu, 5 Sept 2024 at 16:03, Mark Rutland <mark.rutland@arm.com> wrote:
> > Putting the KASAN issue aside (which I'll handle in a separate thread),
> > I think there is a real issue here with LLVM.
> >
> > What's going on here is that .idmap.text ends up more than 128M away
> > from .head.text, so the 'b primary_entry' at the start of the Image
> > isn't in range:
> >
> > | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text
> > | ffff800080000000 g       .head.text     0000000000000000 _text
> > | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
> > | ffff8000889df0e0 g       .rodata.text   000000000000006c primary_entry
> >
> > ... as those are ~128MiB apart.
> >
> > When building with GCC those end up ~101MiB apart:
> >
> > | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text
> > | ffff800080000000 g       .head.text     0000000000000000 _text
> > | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
> > | ffff8000865ae0e0 g       .rodata.text   000000000000006c primary_entry
> >
> > When that happens, LLD makes the header branch to a veneer/thunk:
> >
> > | ffff800080000000 <_text>:
> > | ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
> > | ffff800080000004:       14003fff        b       ffff800080010000 <__AArch64AbsLongThunk_primary_entry>
> >
> > ... and unfortunately, that veneer/thunk uses a literal with the
> > statically-linked TTBR1 address of primary_entry:
> >
> > | ffff800080010000 <__AArch64AbsLongThunk_primary_entry>:
> > | ffff800080010000:       58000050        ldr     x16, ffff800080010008 <__AArch64AbsLongThunk_primary_entry+0x8>
> > | ffff800080010004:       d61f0200        br      x16
> > | ffff800080010008:       889df0e0        .word   0x889df0e0
> > | ffff80008001000c:       ffff8000        .word   0xffff8000
> >
> ...
> > LLVM folk, is there any existing option to ask LLD to use ADRP+ADD for
> > the veneer/thunk? ... and if not, would it be possible to add an option
> > for that?
> >
> 
> ld.lld takes --pic-veneer, which (from looking at the llvm sources)
> appears to do what we need here.

Ah; now I take another look I see that's in the man page and is also
supported by GNU LD, so I'll spin a patch to use that.

Thanks for the pointer!

Mark.

