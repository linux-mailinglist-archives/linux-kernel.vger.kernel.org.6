Return-Path: <linux-kernel+bounces-215793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C729F90970E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5421C2221D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C41BDDF;
	Sat, 15 Jun 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXF6tCKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DC18C08
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441141; cv=none; b=Zn1qdD8cGWVPelUDDuObkOyhYX7gxO3r7qFM0vnBczlg+iT4yT+Qyp3LSvqyWTqhCNgNRQcQL85CjLiqEaqmH3JJH7dxw9I5Rcx9KluQVyTZuyFqzWBdgynbt+WkCFtr5Q9wixIwNypqZOxgEbpC26rfOKcp7t02oA7tDFhtHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441141; c=relaxed/simple;
	bh=GdLmPax7aWiaByiSGY+x7MgyDxVdt9d2Knc1iA0FO3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itzB8reQJfVr9GfHSZ+RjheTrG+KB/7a2SAHM+tPRB6NYtMWeoddIsZHhPHUcCYVZlof72Sdf86YI285YI0mZj3GXN72prew+3X3Qp56pn/CMDMEK70XYIOcsYO1lP8tKLAvlM23LFGVUDzZEg0p+S0qV+YAUsj6xfmzQ3t1ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXF6tCKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722AC4AF4D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718441141;
	bh=GdLmPax7aWiaByiSGY+x7MgyDxVdt9d2Knc1iA0FO3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hXF6tCKjymD4Un5DImf0JQnw657JedpiHmR7OS/HByUX2eODkZOKZjZNu0b9yRhtF
	 bHoXafNNzNonBRGr1/mHLNErZFDmKFjAkukcRCPiN6QZY8HrnySSiYsM3ePRG4Kszx
	 uziqTEadEPp0EmeqPYxwrA4Z6TlGVFB9IIBbZbnw+1cAQM5ypNsi9R0JS8+l8Kl5k1
	 enD2Nhpc5SGBU39+xl+2lggKHaMjN4Ow4OpH7ucE/V6+cY4UtEyKfEpmeKZy3813Fq
	 elQjWAdn+l7kDkDAPFcY1RBcdZd/NzMeIZV+vVIbaRjuaLdJKWE2Kxn+/yD11Z8syx
	 4kHvUzxdYUV1w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so27444471fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:45:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsbkGaupyut6s6sQt866iB4CRht4IH61wnmbb50RP88xe6VSP/kdhjB+bcf6it5DJfqqnLfrAmww1T+PGFYs30TS7+2ruu2+V4ncRX
X-Gm-Message-State: AOJu0Yxk+DowOK1M5rMoL56egdCeDhxGD8jPgV4YwObsBc4Nz9gVnGo5
	vkUmaEbeTEg0HWPJul8EYI4LKCzdI+hhM/1w1SfBRxybPicI9YHlXuw367ubWRRzcSOFdCczP4q
	XPKPxGe6stjhjkR2RQdI+dy6NF7A=
X-Google-Smtp-Source: AGHT+IEVM22B/EuKUmrelPZLEXzizCVWyeA9QiNIHwKIOQYWvp6+DfuEyUVZbFamRHdNm2nfmNSC4hDTvVd3JQbS0No=
X-Received: by 2002:a2e:9cc8:0:b0:2eb:fd86:f141 with SMTP id
 38308e7fff4ca-2ec0e5b87f8mr29134151fa.6.1718441139247; Sat, 15 Jun 2024
 01:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604150741.30252-1-xry111@xry111.site> <20240605054328.GA279426@thelio-3990X>
 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
 <20240605062548.GF279426@thelio-3990X> <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn> <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
 <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn> <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
 <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn> <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
In-Reply-To: <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Jun 2024 16:45:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
Message-ID: <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>
Cc: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, WANG Xuerui <kernel@xen0n.name>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, mengqinggang@loongson.cn, 
	cailulu@loongson.cn, wanglei@loongson.cn, luweining@loongson.cn, 
	Yujie Liu <yujie.liu@intel.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao and Jinyang,

On Fri, Jun 7, 2024 at 4:29=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Fri, 2024-06-07 at 15:14 +0800, Jinyang He wrote:
> > >      Note: on RISC-V and LoongArch, the stack slot for the previous f=
rame
> > >      pointer is stored at fp[-2] instead of fp[0]. See [Consider
> > >      standardising which stack slot fp points
> > >      to](https://github.com/riscv-non-isa/riscv-elf-psabi-doc/issues/=
18)
> > >      for the RISC-V discussion.
> >
> > In most cases the $fp is saved at cfa-16. But for va args, something
> > becomes different at LoongArch (I do not know the case of riscv), the
> > $fp isn't saved at cfa-16. (e.g. printk?)
>
> Oops indeed.  Even with a very simple case:
>
> int sum(int a, int b) {
>         return a + b;
> }
>
> with -fno-omit-frame-pointer we get:
>
> sum:
>         addi.d  $r3,$r3,-16
>         st.d    $r22,$r3,8
>         addi.d  $r22,$r3,16
>         ld.d    $r22,$r3,8
>         add.w   $r4,$r4,$r5
>         addi.d  $r3,$r3,16
>         jr      $r1
>
> So for leaf functions (where we don't save $ra) $fp is saved at cfa-8.
>
> > I feel that the update_cfi_state should be arch specific. I believe
> > that some logic can be reused, but each arch may have its own logic.
>
> I agree it now.
What is the conclusion about the clang part now? And for the original
-mno-thin-add-sub problem, do you have some way to fix it in the root?
I think we needn't rush, there are some weeks before 6.10 released.

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

