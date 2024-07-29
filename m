Return-Path: <linux-kernel+bounces-266063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F993FA45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33792282FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B1158A3C;
	Mon, 29 Jul 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="OrAlPM3f"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401015531B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269256; cv=none; b=u/e/1HAiQV2ehIET3ckLB/2XxAcpxFHNvdB2xUTNF09pmdioywFysaliFSKX1dqA9WOiOk+q0yyj3baHnAOrBpGWes9a0iyymrmfIT9iQ69M/Zh/bRMOqVVQ47fy/uAIHZyEJy7qbR5jZHjRX/j6arIuGD6Vo0LawIQ6olAtB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269256; c=relaxed/simple;
	bh=VzzlpDI8yrqclND6EkTE8UJaIi2N1WtoJSCvFolZL0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfl9RDNsCQvr41H+qQAafwG67WQVjUn2ojwOH0BhDT6owbCDVTxYL8vp3WuRJ8KLGPB/TOdASH1Vz29vr3nA7RGnV7B/PD0hgIOJm83N0HJ1qAHfBuZSMNIZtDFgeCiY0sCzol6O4Xf0fmOvvq509kcFoyUa+Xh6W+kd6FRIsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=OrAlPM3f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5a93ce94so2634185ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1722269254; x=1722874054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOUb0oXyQacVNiPrQp/JMZEy85xMirR5PUw/pntrNdo=;
        b=OrAlPM3fFS7Mot4LFckFGvVA4kmwMNskVrkaMImjGzLWoTf6AD/b3ooLWP/5dHMMXw
         QvoMYOwLcJbi86Lu8GTlbab+5J75SwZH4Ta2np0HAx2eM4uZgs8xJ/M49rSbGN1qPWiR
         B9x0PgtDWK/jWMvKfopFGhr1AoGg7znlNZ3atCiLAZzCfdxZkhqP0aM10/CSWXTQnZyn
         KUw2FYZpY9Vg9SjOXpiuDw4JwkaxV8yZz268gzx/gEvcxE8vKilS15jFaD3lrBhn0k8T
         Sqh+6Xa974IbJUqU3zC9/yNHZKmfw1QPPgqN3TkWHdIjrCsSq1IOIlH0gS+g5Uule/on
         yjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269254; x=1722874054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOUb0oXyQacVNiPrQp/JMZEy85xMirR5PUw/pntrNdo=;
        b=Ilmh4BdXim6B5MdewBYuR0J/yCd+5o9lN4vR/CixoLVjk8oYBi/Vtw1+otdbaX9tuJ
         OaFx9PbHXQ0C8q/Fa4U/VzzquPM1S/kJEd124+dEr6YjAvAZb6bbW3yT1bHzhcbg++Xt
         Txy/OUpkEn8YuvgX/Pu4AKZQ9y5GtutU5E86hu9Rrw6Fjq5pllWtUwvPsS0lxReEbbCS
         Gjy6MsPgR52rJrI11SlA5PNiRox7VXfoRJFRzxnu5psGDRzFfbUeYlveq1QN5JD7jKgn
         ej4TaMeGq+Zyg5z5M7xl9uwwIBANqmP9NT11G/KFyK++th+m/YRJxMmoJIbeDyTwuN1M
         Y5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVkIa10O+wROSNFPdVP4MWLzr3vx3KMuNZ19Y6gHLKnu6XvmWhOaqlWc6NNuzVb/p3C0z6M3678KER1Spw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4bew3X4rzo1TGe7mHlWQGc9lv1u9qVSncAkVv84UZCGIkAgn
	2Pj2+Ci+SNis3FaG15DKbiMe3sUfowm+1sykJoiEGamWxra4oHADTGJ5dZpjFoc=
X-Google-Smtp-Source: AGHT+IHcnvU1UQZVhJRSE9ZYxrGZmqD6hoguKJM36G/iE5MUpp+XuLdHjemhcCL1DDRLI1CvLQEnLA==
X-Received: by 2002:a17:902:7448:b0:1fd:aac9:a722 with SMTP id d9443c01a7336-1fed6c0c1c4mr96330785ad.4.1722269253588;
        Mon, 29 Jul 2024 09:07:33 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9e8fcsm85090885ad.249.2024.07.29.09.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:07:33 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:07:30 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	zhuqiuer <zhuqiuer1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: vfp: Use asm volatile in fmrx/fmxr macros
Message-ID: <Zqe-Qmo_ZgRHxLx6@mozart.vkv.me>
References: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
 <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com>
 <Zqa4SAyPKPuaXdgg@mozart.vkv.me>
 <CAMj1kXGLXGqA4JvuWNLk_-cu5_soKpbyDaZxwjOo5LVTdZt71w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGLXGqA4JvuWNLk_-cu5_soKpbyDaZxwjOo5LVTdZt71w@mail.gmail.com>

On Monday 07/29 at 09:12 +0200, Ard Biesheuvel wrote:
> On Sun, 28 Jul 2024 at 23:29, Calvin Owens <calvin@wbinvd.org> wrote:
> >
> > On Sunday 07/28 at 19:09 +0200, Ard Biesheuvel wrote:
> > > (cc Arnd, Nathan, zhuqiuer)
> > >
> > > On Sun, 28 Jul 2024 at 10:21, Calvin Owens <calvin@wbinvd.org> wrote:
> > > > <snip>
> > > >
> > > > Crudely grepping for vmsr/vmrs instructions in the otherwise nearly
> > > > idential text for vfp_support_entry() makes the problem obvious:
> > > >
> > > >     vmlinux.llvm.good [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> > > >     vmlinux.llvm.good [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> > > >     vmlinux.llvm.good [0xc0101d20] <+152>: vmsr   fpexc, r7
> > > >     vmlinux.llvm.good [0xc0101d38] <+176>: vmrs   r4, fpexc
> > > >     vmlinux.llvm.good [0xc0101d6c] <+228>: vmrs   r0, fpscr
> > > >     vmlinux.llvm.good [0xc0101dc4] <+316>: vmsr   fpexc, r0
> > > >     vmlinux.llvm.good [0xc0101dc8] <+320>: vmrs   r0, fpsid
> > > >     vmlinux.llvm.good [0xc0101dcc] <+324>: vmrs   r6, fpscr
> > > >     vmlinux.llvm.good [0xc0101e10] <+392>: vmrs   r10, fpinst
> > > >     vmlinux.llvm.good [0xc0101eb8] <+560>: vmrs   r10, fpinst2
> > > >
> > > >     vmlinux.llvm.bad  [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> > > >     vmlinux.llvm.bad  [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> > > >     vmlinux.llvm.bad  [0xc0101d20] <+152>: vmsr   fpexc, r7
> > > >     vmlinux.llvm.bad  [0xc0101d30] <+168>: vmrs   r0, fpscr
> > > >     vmlinux.llvm.bad  [0xc0101d50] <+200>: vmrs   r6, fpscr  <== BOOM!
> > > >     vmlinux.llvm.bad  [0xc0101d6c] <+228>: vmsr   fpexc, r0
> > > >     vmlinux.llvm.bad  [0xc0101d70] <+232>: vmrs   r0, fpsid
> > > >     vmlinux.llvm.bad  [0xc0101da4] <+284>: vmrs   r10, fpinst
> > > >     vmlinux.llvm.bad  [0xc0101df8] <+368>: vmrs   r4, fpexc
> > > >     vmlinux.llvm.bad  [0xc0101e5c] <+468>: vmrs   r10, fpinst2
> > > >
> > > > I think LLVM's reordering is valid as the code is currently written: the
> > > > compiler doesn't know the instructions have side effects in hardware.
> > > >
> > > > Fix by using "asm volatile" in fmxr() and fmrx(), so they cannot be
> > > > reordered with respect to each other. The original compiler now produces
> > > > working kernels on my hardware with DYNAMIC_DEBUG=n.
> > > >
> > > > This is the relevant piece of the diff of the vfp_support_entry() text,
> > > > from the original oopsing kernel to a working kernel with this patch:
> > > >
> > > >          vmrs r0, fpscr
> > > >          tst r0, #4096
> > > >          bne 0xc0101d48
> > > >          tst r0, #458752
> > > >          beq 0xc0101ecc
> > > >          orr r7, r7, #536870912
> > > >          ldr r0, [r4, #0x3c]
> > > >          mov r9, #16
> > > >         -vmrs r6, fpscr
> > > >          orr r9, r9, #251658240
> > > >          add r0, r0, #4
> > > >          str r0, [r4, #0x3c]
> > > >          mvn r0, #159
> > > >          sub r0, r0, #-1207959552
> > > >          and r0, r7, r0
> > > >          vmsr fpexc, r0
> > > >          vmrs r0, fpsid
> > > >         +vmrs r6, fpscr
> > > >          and r0, r0, #983040
> > > >          cmp r0, #65536
> > > >          bne 0xc0101d88
> > > >
> > > > Fixes: 4708fb041346 ("ARM: vfp: Reimplement VFP exception entry in C code")
> > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > ---
> > > >  arch/arm/vfp/vfpinstr.h | 48 ++++++++++++++++++++++-------------------
> > > >  1 file changed, 26 insertions(+), 22 deletions(-)
> > > >
> > >
> > > Thanks for the patch, and for the excellent analysis.
> > >
> > > Note that this fix has been proposed in the past, as well as another
> > > one addressing the same issue, but we've been incredibly sloppy
> > > getting it merged.
> > >
> > > https://lore.kernel.org/linux-arm-kernel/20240410024126.21589-2-zhuqiuer1@huawei.com/
> > > https://lore.kernel.org/linux-arm-kernel/20240318093004.117153-2-ardb+git@google.com/
> >
> > Ah sorry for missing that, I searched for the symptom not the cure.
> >
> > > What both of us appear to have missed is that there are two versions
> > > of these routines, which should either be dropped (as they are
> > > obsolete now that the minimum binutils version is 2.25) or fixed up as
> > > well, as you do below.
> > >
> > > Anyone have any thoughts on using a memory clobber as opposed to
> > > volatile? I think volatile means that the access cannot be elided, but
> > > it is unclear to me whether that implies any ordering. A 'memory'
> > > clobber implies that globally visible state is updated, which seems
> > > like a stronger guarantee to me.
> >
> > My thinking was that if 'asm volatile' is sufficient, it will suppress
> > less optimization than the clobber, since the clobber might force the
> > compiler to assume unrelated memory could have been modified when it
> > really never is. But I'm not sure about that.
> >
> > Out of curiousity, I tried it both ways with the same compiler just now,
> > the only tiny difference in the emitted vfp_support_entry() is here:
> >
> >         --- /volatile   2024-07-28 13:28:59.890505404 -0700
> >         +++ /memclobber 2024-07-28 13:28:59.890505404 -0700
> >          str r0, [r5, #0x4]
> >          vmrs r7, fpexc
> >          tst r7, #1073741824
> >          bne 0xc0101d28
> >          orr r7, r7, #1073741824
> >          bic r0, r7, #-2147483648
> >          vmsr fpexc, r0
> >         +ldr r8, [pc, #0x26c]
> >          ldr r0, [r5, #0x8]
> >         -ldr r8, [pc, #0x268]
> >          add r6, r5, #224
> >          ldr r0, [r8, r0, lsl #2]
> >          cmp r0, r6
> >          beq 0xc0101d18
> >
> 
> Right. So it doesn't matter in practice - good to know.
> 
> So in the 'volatile' case, I guess we are relying on the compiler not
> reordering those with respect to each other, which should be
> sufficient to ensure that we do not access VFP status register before
> enabling the VFP unit via the control register, as all are accessed
> using inline asm.
> 
> In any case, this should go into the patch system.
> https://www.armlinux.org.uk/developer/patches/section.php?section=0

Done:
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9410/1

Thanks,
Calvin

> Note to self and other: follow-up with a patch that removes
> CONFIG_AS_VFP_VMRS_FPINST, which is no longer needed.

