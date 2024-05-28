Return-Path: <linux-kernel+bounces-191933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B508E8D1645
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473821F2360E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8B13C900;
	Tue, 28 May 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UqJUxAKv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080B17580
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885094; cv=none; b=ZPY32d1q2xFFCbJPbfX1A/5EwbbI9aoDao/3el0d7m0nBZa38W4IVhawGmNARPEMTzjZO7gomiacFnGh8fRaR8WQQ10+2cek5g0YH/6hasq02iyefhMGXweoJgTgfDbucMSxS4tspEamgzSc3SBFlzme6ai+NSICtmeCjTh7gjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885094; c=relaxed/simple;
	bh=RwuBIHtznA/hyz21dAojIRc65YO6rBNxlBTR+bfBkPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tivV1AH0XDeeNJZoxQ/NPsKn6PrnqEtL7vWqigjyg9we28Ygnc8r88wdTkDwQA03j9SZTZVkaeeC0OSFgvh2JWAEnSjajjhptFnKU9Llf7divZvJO4u8mx8bi4eDJZF+0ZqEsXC4OZfQNQY7Du2mXnFlyu8kdhNkrmHwhCGhx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UqJUxAKv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-523b20e2615so621327e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716885089; x=1717489889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFYUpzA6pM4m4rSYWLPXboECnNuEYZJwJD08pfbA3OU=;
        b=UqJUxAKvcLc2rP0LgjEH/YAVRMqxXFE3VoI0lwJX3xnUvsGV5E4xP1lxqE+650JZFA
         njdZHi1r8pkjB6x1khZMlxu0dp7eSmXYiSM6sC0ecaEJTMfoU+OJ3kR5y6rtFSrDG/VC
         7amcOcsis1jcS1vYzaogAtFGdsBxWgSdpc3so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885089; x=1717489889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFYUpzA6pM4m4rSYWLPXboECnNuEYZJwJD08pfbA3OU=;
        b=PUalTN4tCy2TrRyYRX9dACxxQ+IBAVEcjphIkvSTsMttMQyG5re4e0CrGbZrBabcrX
         2NOSsRxSEXyYIpEj+51F4LWTYGNqU1ZI/xel39WzYpM+vixKx8/SFT7F1f7b42wS/pQO
         BG62w4itw0slz3Zayu5nOT9epqlVNLDrnJZRHFAn+YdhTG/YOl4evCnOj0HlCD8mwGfO
         8LVHCE55RGhtgcg7LUyHhzwxmwOO28eOjDJD0Gt1yelwwuCmHSCeydmbeYNKl+bOUn10
         qn8hbaOuxj7isQczhBsp9/kRbBrimS9m2QD9fWUGcN4UvbK8e6sh8zLb/N3tkKpL8HWI
         cJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUaSL7bBydZ2PkKgeJQAbo0vu8c+VPmBMRR84fZcNFApXC2mBD9D0imsJaT3JJRJ90btR8krIRz6LGPwMYfYqcg2EBJnepwF7PUnEnQ
X-Gm-Message-State: AOJu0Yy6SUBZvERIOtInMKWL2Nem8UV+1ESXw5GsXtheeBVIWU2UvDxc
	+SWN2L98nyM+uX7JsCg4IoefIvMNW7LhRUXReWQsHmT4aGSw7i629sytJm9zfW6nzgHgHUwzPjT
	hQCotXNAVv/xrNukF17IzI43M3tom46kadeGpzHH0ZTBDgds=
X-Google-Smtp-Source: AGHT+IGu4tkJyfHdf+OrG6LxWgWVjFmH1sYDmdqTxRucdD+zK/9ZDLeLFIlAQWrMRdJh1zHGMDSKRxAK0yb2+LSGI4s=
X-Received: by 2002:a19:e04b:0:b0:51e:245a:8ed3 with SMTP id
 2adb3069b0e04-529646de3d0mr7018224e87.28.1716885089209; Tue, 28 May 2024
 01:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521065107.30371-1-wenst@chromium.org> <20240521065107.30371-2-wenst@chromium.org>
 <CAFLszTgJpaWzJneZ-uReEGrE85MgGYOjJKxOL7jGCYMuVMPKUg@mail.gmail.com>
 <CAGb2v67MQDep8gfPWgeQoew8URAZyPw6ocGEMxMnwzYYRa0PYg@mail.gmail.com>
 <CAFLszTh5M+4Vp8oR3t-=6vsROgVJa0NU4egfJu2QuugjAfbrsw@mail.gmail.com>
 <CAGXv+5Eajy55kAcNzyZtsp9MJhD7EnNONW-JYsoadctaTjnxgA@mail.gmail.com> <CAFLszTjeQdwEp1AgL8geK7AZFwQqDfTkdzj4V2JkYqU4F7Em4Q@mail.gmail.com>
In-Reply-To: <CAFLszTjeQdwEp1AgL8geK7AZFwQqDfTkdzj4V2JkYqU4F7Em4Q@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 28 May 2024 16:31:18 +0800
Message-ID: <CAGXv+5HhwBx0qGSB=V6O1gXjrTDjhwMRsWe5a4VSP6+suwwU3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/make_fit: Drop fdt image entry compatible string
To: Simon Glass <sjg@chromium.org>
Cc: wens@kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 9:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi ChenYu,
>
> On Fri, 24 May 2024 at 00:30, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, May 24, 2024 at 1:38=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi ChenYu,
> > >
> > > On Thu, 23 May 2024 at 11:30, Chen-Yu Tsai <wens@kernel.org> wrote:
> > > >
> > > > On Fri, May 24, 2024 at 1:19=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Chen-Yu,
> > > > >
> > > > > On Tue, 21 May 2024 at 00:51, Chen-Yu Tsai <wenst@chromium.org> w=
rote:
> > > > > >
> > > > > > According to the FIT image spec, the compatible string in the f=
dt image
> > > > >
> > > > > Can you please add a link to where it says this in the spec? I ca=
nnot
> > > > > find it after a short search.
> > > >
> > > > (Quick reply from my other email before I forget.)
> > > >
> > > > From the FIT source file format document, found in U-boot source
> > > > "doc/usage/fit/source_file_format.rst", or on the website:
> > > > https://docs.u-boot.org/en/latest/usage/fit/source_file_format.html
> > > >
> > > > Under "'/images' node" -> "Conditionally mandatory property", the
> > > > "compatible" property is described as "compatible method for loadin=
g image."
> > > >
> > > > I'll add the reference in the next version.
> > >
> > > OK thank you.
> > >
> > > There is also a spec version at [1] - it might be worth adding mentio=
n
> > > of this explicitly for the fdt nodes.
> >
> > It seems that this is already mentioned?
> >
> > See https://github.com/open-source-firmware/flat-image-tree/blob/main/s=
ource/chapter2-source-file-format.rst?plain=3D1#L343
>
> I see that but I am suggesting that it could explicitly mention that
> the FDT should not have a compatible string for the model...that
> should only be in the configuration node.

I sent a pull request on GitHub. The mailing list seemed very empty.

ChenYu

> >
> > It looks like it was copied from U-boot directly.
>
> Yes mostly it is the same, but there were some changes. It has evolved
> slowly over the years but the bones of it is stable.
>
> Regards,
> Simon
>
> >
> >
> > Regards,
> > ChenYu
> >
> > > Regards,
> > > Simon
> > >
> > > [1] https://github.com/open-source-firmware/flat-image-tree/
> > >
> > > >
> > > >
> > > > ChenYu
> > > >
> > > > > I believe this patch is correct. Since the information is in the
> > > > > configuration node it does not need to be in the FDT.
> > > > >
> > > > > > node or any image node specifies the method to load the image, =
not the
> > > > > > compatible string embedded in the FDT or used for matching.
> > > > > >
> > > > > > Drop the compatible string from the fdt image entry node.
> > > > > >
> > > > > > While at it also fix up a typo in the document section of outpu=
t_dtb.
> > > > > >
> > > > > > Fixes: 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> > > > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > > ---
> > > > > >  scripts/make_fit.py | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > > > > > index 3de90c5a094b..263147df80a4 100755
> > > > > > --- a/scripts/make_fit.py
> > > > > > +++ b/scripts/make_fit.py
> > > > > > @@ -190,7 +190,7 @@ def output_dtb(fsw, seq, fname, arch, compr=
ess):
> > > > > >      Args:
> > > > > >          fsw (libfdt.FdtSw): Object to use for writing
> > > > > >          seq (int): Sequence number (1 for first)
> > > > > > -        fmame (str): Filename containing the DTB
> > > > > > +        fname (str): Filename containing the DTB
> > > > > >          arch: FIT architecture, e.g. 'arm64'
> > > > > >          compress (str): Compressed algorithm, e.g. 'gzip'
> > > > > >
> > > > > > @@ -211,7 +211,6 @@ def output_dtb(fsw, seq, fname, arch, compr=
ess):
> > > > > >          fsw.property_string('type', 'flat_dt')
> > > > > >          fsw.property_string('arch', arch)
> > > > > >          fsw.property_string('compression', compress)
> > > > > > -        fsw.property('compatible', bytes(compat))
> > > > > >
> > > > > >          with open(fname, 'rb') as inf:
> > > > > >              compressed =3D compress_data(inf, compress)
> > > > > > --
> > > > > > 2.45.0.215.g3402c0e53f-goog
> > > > > >
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

