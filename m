Return-Path: <linux-kernel+bounces-187836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8671F8CD934
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D643EB219EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485E482DE;
	Thu, 23 May 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8+1TTu2"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1221362
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485925; cv=none; b=lkesziN9VNUnjNSlRyJyy+RsYSkW+4dzH+IxSoz8fKG3VNLQ+s47P9qDBWT+BQITAJ2im9LzwU79boA4Yz/fSNDve02++YsobpFfrUcwhaqDg4WA6wZC8fEv0n0jKk6wnlclcrusw4szGb0w42Q8+HXolr20OS6Tk5LzDEs3fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485925; c=relaxed/simple;
	bh=pnw9VeQPGfJdSLKumcNoyt5s/XJHQHU8QW0nMsUL9ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pajqn6MxkAV1Grxdzyr/GJDlDTX+93OeiPkHvBaIfvDbqouDvlSW2oHaOkorO9Yy16Y3znkHKdR/q37mU441d1wW2ruakBgjWNEQwfaciSt01Ih1tZ6iRhcmJTHpXh4mqiBaW0PwUvud3XbUR1lOPXxpdKgnn8v8mntIZ2dLRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C8+1TTu2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ab8e80775eso8613186d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716485922; x=1717090722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V7pd3riIwcFxlFCmDZlVupOcyB0VJETE06xBJZgKWg=;
        b=C8+1TTu25RP6qCQoMsz8BmmuXlLHXiCoTwUenKCZVTtarHdH0s+D0DgRKd14drgnoc
         fg1qNRwq7uVjWyXq+Yo9s1Q0r+qd/4i+ujh6I1hh1SQ/ZjQo/GWhMjDv1QFbqf/K7GNb
         71XO61yEBm0jGcmTdR1YFwIaBYZ1FXDQKxfOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716485922; x=1717090722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V7pd3riIwcFxlFCmDZlVupOcyB0VJETE06xBJZgKWg=;
        b=flROJirkPQvEXIVGZEojU7qrq/Rn7NPwNaNIWqCkjmwQQQXJBgCrVzm2G82xKAq0u6
         z7H9TQFIE+ZcxYGhMZe2mrBJ1p2n80B696a5x3/UezZduwl0dtqr0BiWijv2Q5Zfm36q
         1WRh01Wxc+HY/e6O8SBPPF96v7QQ639j2Wcv7XdHkIpp5zcv/kZl9DVttInOH1k7eyO2
         4OlyHWJ7ljrNR7REvNt1yXr7Cuk6/ognMVfF/ctNgueh/z5n1g0Cz0PlF4mWZZlyns4Z
         8wdu8UXBqkhZIV2YsXcucXhym9AmaVYAJkiIHjOzY+2zrOmwcgFVo9xE/5e3AMi3bA5y
         fTsA==
X-Forwarded-Encrypted: i=1; AJvYcCX47mgPmSBtwJnmlls85Txyc2cXFPb4QPap9MjMsOD1NWviFgPvp3VFRKmbz0XVW2VDIZ+y+5ch5B8yeBEI+aJoyTqnlnKZHurJuPg8
X-Gm-Message-State: AOJu0YwypenXGYl4AIhUoZu0qkELMHWjA5idstuE1tgPLaRpAY7SRdAt
	gAIeFX82yj4sCRvksU08fdzqYAmb9f0Tz3qizK0gpyyfmZsCj2rQXrM22YxD1JT1s1vNYmKCWoZ
	5K4UhQK+91gsGQ6lORg5tb5AIe0sm9/KMiPdr
X-Google-Smtp-Source: AGHT+IHQgR2gc3LizfC2ko6q8LeiuyYMUEWsyT2fSihHx5KYglA8Ke5ClBuzgiE2YuOwbWhrCtTujkxGm22gnzfgME0=
X-Received: by 2002:a05:6214:519a:b0:6ab:8b8c:61ef with SMTP id
 6a1803df08f44-6ab8f5faedbmr47040786d6.31.1716485922659; Thu, 23 May 2024
 10:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521065107.30371-1-wenst@chromium.org> <20240521065107.30371-2-wenst@chromium.org>
 <CAFLszTgJpaWzJneZ-uReEGrE85MgGYOjJKxOL7jGCYMuVMPKUg@mail.gmail.com> <CAGb2v67MQDep8gfPWgeQoew8URAZyPw6ocGEMxMnwzYYRa0PYg@mail.gmail.com>
In-Reply-To: <CAGb2v67MQDep8gfPWgeQoew8URAZyPw6ocGEMxMnwzYYRa0PYg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 May 2024 11:38:31 -0600
Message-ID: <CAFLszTh5M+4Vp8oR3t-=6vsROgVJa0NU4egfJu2QuugjAfbrsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/make_fit: Drop fdt image entry compatible string
To: wens@kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ChenYu,

On Thu, 23 May 2024 at 11:30, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Fri, May 24, 2024 at 1:19=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Chen-Yu,
> >
> > On Tue, 21 May 2024 at 00:51, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > >
> > > According to the FIT image spec, the compatible string in the fdt ima=
ge
> >
> > Can you please add a link to where it says this in the spec? I cannot
> > find it after a short search.
>
> (Quick reply from my other email before I forget.)
>
> From the FIT source file format document, found in U-boot source
> "doc/usage/fit/source_file_format.rst", or on the website:
> https://docs.u-boot.org/en/latest/usage/fit/source_file_format.html
>
> Under "'/images' node" -> "Conditionally mandatory property", the
> "compatible" property is described as "compatible method for loading imag=
e."
>
> I'll add the reference in the next version.

OK thank you.

There is also a spec version at [1] - it might be worth adding mention
of this explicitly for the fdt nodes.

Regards,
Simon

[1] https://github.com/open-source-firmware/flat-image-tree/

>
>
> ChenYu
>
> > I believe this patch is correct. Since the information is in the
> > configuration node it does not need to be in the FDT.
> >
> > > node or any image node specifies the method to load the image, not th=
e
> > > compatible string embedded in the FDT or used for matching.
> > >
> > > Drop the compatible string from the fdt image entry node.
> > >
> > > While at it also fix up a typo in the document section of output_dtb.
> > >
> > > Fixes: 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  scripts/make_fit.py | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > > index 3de90c5a094b..263147df80a4 100755
> > > --- a/scripts/make_fit.py
> > > +++ b/scripts/make_fit.py
> > > @@ -190,7 +190,7 @@ def output_dtb(fsw, seq, fname, arch, compress):
> > >      Args:
> > >          fsw (libfdt.FdtSw): Object to use for writing
> > >          seq (int): Sequence number (1 for first)
> > > -        fmame (str): Filename containing the DTB
> > > +        fname (str): Filename containing the DTB
> > >          arch: FIT architecture, e.g. 'arm64'
> > >          compress (str): Compressed algorithm, e.g. 'gzip'
> > >
> > > @@ -211,7 +211,6 @@ def output_dtb(fsw, seq, fname, arch, compress):
> > >          fsw.property_string('type', 'flat_dt')
> > >          fsw.property_string('arch', arch)
> > >          fsw.property_string('compression', compress)
> > > -        fsw.property('compatible', bytes(compat))
> > >
> > >          with open(fname, 'rb') as inf:
> > >              compressed =3D compress_data(inf, compress)
> > > --
> > > 2.45.0.215.g3402c0e53f-goog
> > >
> >
> > Regards,
> > Simon
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

