Return-Path: <linux-kernel+bounces-265234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A663893EE31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5223B23698
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A082D9A;
	Mon, 29 Jul 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWnlpVDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398C823DD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237135; cv=none; b=DLqmq35v6lWOmR6bm0GbQAGRt/RfmrMZOX+zLP8JBElBTbrJOEOjl50KUKKe+Q9CX5dJnMV7O6e+/XY+POM5sNY7vhR8etFM01UqnW3i71bWslRtOZN52K5LJvZ3Qn22fieSqjG6wLKy0P34XY0m0i65UxydjkvnP1mHKq9U2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237135; c=relaxed/simple;
	bh=eBCRSSd7Dws5+jAo9xjMd44kHCQ/FRtcnOK6uGlAGcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/SW/lDlU7fkMAo1N/Tk9M5ZaCTRNpDvY9RJuVBrUGtEt9RYdRoeHpgIuCYB36EkZPU352vsrMC1F1zqkO5Q7uCRPYys2RpVeC/sXXLkyeqsezG9jI0yrsEyN9kTysRuVK7zWu2Ysenq3oVlFTSmty6XI2nPYtoovHg5GacFCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWnlpVDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8933C4AF0B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722237134;
	bh=eBCRSSd7Dws5+jAo9xjMd44kHCQ/FRtcnOK6uGlAGcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IWnlpVDZokaDvtRelgkfoY5+kdnNNpDUe2up8GEHNYWXCnANd2YiDIsr/y3R6e5cW
	 sn1Lk6vZqAsumoTFAj0kj0DLMIDM9ajdEBdJUG4iCoDGfGF99iuBOTyKNhbCzczCf8
	 6MMq5BojGakzZeX1tmtJ9sDyfDpP0tY9n+pEMbtxtD98WypK6ivIC3cqksNFnd+huE
	 wruxgr5LAG+Q45hrLH5gDdSUZchA19YFkhbOvJphSUNWnBkup3QzfL6rvlSILhwqWQ
	 sEN0O9BdwG9f8JTES+HRvELRSLssRksu+lXWWOWvl6EajnOYvzZeM9+zey9vhmnE1q
	 hBAZ0QsbAarGA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2884613e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:12:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUghptU+ZcYNPS5VVTFSLV1Fd8sLZR2HxE2PEwQo/2TXtJtn6hjAw1SfGEjWq12osW09fO7sv2pjoyQdXzSXNHfwmEgpB5OUPqlo/t
X-Gm-Message-State: AOJu0YxcIFyJv4BYy5X3jsqTrGgvY3Yt6OmAk9sVFGlpi4dll4DpFpxZ
	TJLH2WhLAWkIW55BZyyUzXpy0zjg0yay+tvsfw6/rf6eKpuglnhhvULeP977AwQfaYiM1VRibbL
	S+I14cBQW7nriTEO8NihmNe05QCk=
X-Google-Smtp-Source: AGHT+IFnef/vRpNCO/nGNNTc/W+7DxUXiYCIUaVOigziXQKfil5xfPG52mox5PZAJvFrG3eRLr7cOf8J7BXU92d7wDU=
X-Received: by 2002:a05:6512:360b:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-5309b27b28emr3413033e87.27.1722237133228; Mon, 29 Jul 2024
 00:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
 <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com> <Zqa4SAyPKPuaXdgg@mozart.vkv.me>
In-Reply-To: <Zqa4SAyPKPuaXdgg@mozart.vkv.me>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Jul 2024 09:12:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLXGqA4JvuWNLk_-cu5_soKpbyDaZxwjOo5LVTdZt71w@mail.gmail.com>
Message-ID: <CAMj1kXGLXGqA4JvuWNLk_-cu5_soKpbyDaZxwjOo5LVTdZt71w@mail.gmail.com>
Subject: Re: [PATCH] ARM: vfp: Use asm volatile in fmrx/fmxr macros
To: Calvin Owens <calvin@wbinvd.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	clang-built-linux <clang-built-linux@googlegroups.com>, zhuqiuer <zhuqiuer1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 23:29, Calvin Owens <calvin@wbinvd.org> wrote:
>
> On Sunday 07/28 at 19:09 +0200, Ard Biesheuvel wrote:
> > (cc Arnd, Nathan, zhuqiuer)
> >
> > On Sun, 28 Jul 2024 at 10:21, Calvin Owens <calvin@wbinvd.org> wrote:
> > > <snip>
> > >
> > > Crudely grepping for vmsr/vmrs instructions in the otherwise nearly
> > > idential text for vfp_support_entry() makes the problem obvious:
> > >
> > >     vmlinux.llvm.good [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> > >     vmlinux.llvm.good [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> > >     vmlinux.llvm.good [0xc0101d20] <+152>: vmsr   fpexc, r7
> > >     vmlinux.llvm.good [0xc0101d38] <+176>: vmrs   r4, fpexc
> > >     vmlinux.llvm.good [0xc0101d6c] <+228>: vmrs   r0, fpscr
> > >     vmlinux.llvm.good [0xc0101dc4] <+316>: vmsr   fpexc, r0
> > >     vmlinux.llvm.good [0xc0101dc8] <+320>: vmrs   r0, fpsid
> > >     vmlinux.llvm.good [0xc0101dcc] <+324>: vmrs   r6, fpscr
> > >     vmlinux.llvm.good [0xc0101e10] <+392>: vmrs   r10, fpinst
> > >     vmlinux.llvm.good [0xc0101eb8] <+560>: vmrs   r10, fpinst2
> > >
> > >     vmlinux.llvm.bad  [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> > >     vmlinux.llvm.bad  [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> > >     vmlinux.llvm.bad  [0xc0101d20] <+152>: vmsr   fpexc, r7
> > >     vmlinux.llvm.bad  [0xc0101d30] <+168>: vmrs   r0, fpscr
> > >     vmlinux.llvm.bad  [0xc0101d50] <+200>: vmrs   r6, fpscr  <== BOOM!
> > >     vmlinux.llvm.bad  [0xc0101d6c] <+228>: vmsr   fpexc, r0
> > >     vmlinux.llvm.bad  [0xc0101d70] <+232>: vmrs   r0, fpsid
> > >     vmlinux.llvm.bad  [0xc0101da4] <+284>: vmrs   r10, fpinst
> > >     vmlinux.llvm.bad  [0xc0101df8] <+368>: vmrs   r4, fpexc
> > >     vmlinux.llvm.bad  [0xc0101e5c] <+468>: vmrs   r10, fpinst2
> > >
> > > I think LLVM's reordering is valid as the code is currently written: the
> > > compiler doesn't know the instructions have side effects in hardware.
> > >
> > > Fix by using "asm volatile" in fmxr() and fmrx(), so they cannot be
> > > reordered with respect to each other. The original compiler now produces
> > > working kernels on my hardware with DYNAMIC_DEBUG=n.
> > >
> > > This is the relevant piece of the diff of the vfp_support_entry() text,
> > > from the original oopsing kernel to a working kernel with this patch:
> > >
> > >          vmrs r0, fpscr
> > >          tst r0, #4096
> > >          bne 0xc0101d48
> > >          tst r0, #458752
> > >          beq 0xc0101ecc
> > >          orr r7, r7, #536870912
> > >          ldr r0, [r4, #0x3c]
> > >          mov r9, #16
> > >         -vmrs r6, fpscr
> > >          orr r9, r9, #251658240
> > >          add r0, r0, #4
> > >          str r0, [r4, #0x3c]
> > >          mvn r0, #159
> > >          sub r0, r0, #-1207959552
> > >          and r0, r7, r0
> > >          vmsr fpexc, r0
> > >          vmrs r0, fpsid
> > >         +vmrs r6, fpscr
> > >          and r0, r0, #983040
> > >          cmp r0, #65536
> > >          bne 0xc0101d88
> > >
> > > Fixes: 4708fb041346 ("ARM: vfp: Reimplement VFP exception entry in C code")
> > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > ---
> > >  arch/arm/vfp/vfpinstr.h | 48 ++++++++++++++++++++++-------------------
> > >  1 file changed, 26 insertions(+), 22 deletions(-)
> > >
> >
> > Thanks for the patch, and for the excellent analysis.
> >
> > Note that this fix has been proposed in the past, as well as another
> > one addressing the same issue, but we've been incredibly sloppy
> > getting it merged.
> >
> > https://lore.kernel.org/linux-arm-kernel/20240410024126.21589-2-zhuqiuer1@huawei.com/
> > https://lore.kernel.org/linux-arm-kernel/20240318093004.117153-2-ardb+git@google.com/
>
> Ah sorry for missing that, I searched for the symptom not the cure.
>
> > What both of us appear to have missed is that there are two versions
> > of these routines, which should either be dropped (as they are
> > obsolete now that the minimum binutils version is 2.25) or fixed up as
> > well, as you do below.
> >
> > Anyone have any thoughts on using a memory clobber as opposed to
> > volatile? I think volatile means that the access cannot be elided, but
> > it is unclear to me whether that implies any ordering. A 'memory'
> > clobber implies that globally visible state is updated, which seems
> > like a stronger guarantee to me.
>
> My thinking was that if 'asm volatile' is sufficient, it will suppress
> less optimization than the clobber, since the clobber might force the
> compiler to assume unrelated memory could have been modified when it
> really never is. But I'm not sure about that.
>
> Out of curiousity, I tried it both ways with the same compiler just now,
> the only tiny difference in the emitted vfp_support_entry() is here:
>
>         --- /volatile   2024-07-28 13:28:59.890505404 -0700
>         +++ /memclobber 2024-07-28 13:28:59.890505404 -0700
>          str r0, [r5, #0x4]
>          vmrs r7, fpexc
>          tst r7, #1073741824
>          bne 0xc0101d28
>          orr r7, r7, #1073741824
>          bic r0, r7, #-2147483648
>          vmsr fpexc, r0
>         +ldr r8, [pc, #0x26c]
>          ldr r0, [r5, #0x8]
>         -ldr r8, [pc, #0x268]
>          add r6, r5, #224
>          ldr r0, [r8, r0, lsl #2]
>          cmp r0, r6
>          beq 0xc0101d18
>

Right. So it doesn't matter in practice - good to know.

So in the 'volatile' case, I guess we are relying on the compiler not
reordering those with respect to each other, which should be
sufficient to ensure that we do not access VFP status register before
enabling the VFP unit via the control register, as all are accessed
using inline asm.

In any case, this should go into the patch system.
https://www.armlinux.org.uk/developer/patches/section.php?section=0

Note to self and other: follow-up with a patch that removes
CONFIG_AS_VFP_VMRS_FPINST, which is no longer needed.

