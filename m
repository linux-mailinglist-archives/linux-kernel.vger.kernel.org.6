Return-Path: <linux-kernel+bounces-188705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC48CE592
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631A2B20D23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3347B84FCE;
	Fri, 24 May 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SaX4pnE8"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E1381BB
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555681; cv=none; b=kIksL+Ja0tku061XtZzEOxpmjj+q71TljbCQicM9BL0rbOVALJXN/ZpGmEph4iVfDb7W3rXbwVygyZOrntfMyyMEN6SogvMct0mdWKwEQ33Tey9M4wr+ZUfiSQUjKf6itiQlmCEJ/+7g5nyCb5TLQzEbYXRWOy75YPLUYVATt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555681; c=relaxed/simple;
	bh=tN6XxBkDWgoF2UquDxuqkyQ0zebhpcacvCM6gy5DfEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyfCToHYkR+hB9zofFAzxhPtQLq+SxonTrb4xxWyZJWHciACSeLyLXqqhZcgnLSR5bTEYdtMuTKi6rTHbBte0s0S4IFXBSzQONFnxAagUHEgzIsjhdzUPMwe+4VyaUqofmoWeX3t4bBVRemyRO+APANqnycsLGR7xfFEpuUwNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SaX4pnE8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2cc8c4b8aso4860293eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716555679; x=1717160479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om5PFd0wycPy9DndNUp2OMWfvO1kKpP8J8RtZYLYNRE=;
        b=SaX4pnE89X5NRKekc5Ie4k6dGdZ5qgF7Kd8AWNcI8HWnfdK/l9jbBM9a2KE0PTTDl4
         WRSv0btLJhhfCKyioWN+kra0bUxwf7KA7OSMyMHFWFqWlz6InA0zMs2UL59sf9eDR1tk
         QeQSGtPC4Ct7dHlSpEi9/Owq7tDhhUH0udyWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716555679; x=1717160479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om5PFd0wycPy9DndNUp2OMWfvO1kKpP8J8RtZYLYNRE=;
        b=AU75lFVFTDZbvR59vVMNqAe3ZRzlhQlIaEdnC/0zQzyFzMlbDm35ctV5Im7NasIcmh
         I2Cwkm+BwXTpT2s/uhQxHW5pthHtHBUbP7gQBmXc6DuhWbcoMwG1f17K74JZwkr2IJFq
         4ADOageFmqo9VG0LKIKeRkYPPLY8yp8TOjKrX0hLT9n8Daa0nvz++DHO5T9bxj5mMI+g
         PYCT+HAZ5GCCaM+PLU2pqQ7FtoqKQsVxh+YRRw5T71JVePisjDel2JUqRoF/hWvxIBzF
         CDu3xkvLOKjPavulZjHwSgfoQUgXbhsatdHzTLcdL18SmJyI/+oLgKARKdACbsRbFdV5
         DQxw==
X-Forwarded-Encrypted: i=1; AJvYcCVQnvJuxyt8cTS0xl4TWFarAtuxR3gv6VRNJhApztXEH5wr6HEoRiZgLc7J+8EBYRq9KqEC5DB5310p8Y5VL4xqBP4KfTw6dpJg/gE8
X-Gm-Message-State: AOJu0YwzNm0fz8JeImY6/V0Iqhq9m9sr9IJR7xYKzjYxP5MAusilcH6x
	UJ5R/jmxk1TD+V1lPKlGR2NsRq4s9c7QoQndxfof8ImKOzIgxNa2TVyftCxlidoTP7PyNRh448H
	ZEQCzTRIpUkp8yQ1eAWUa+HldMDVHYxYTlLej
X-Google-Smtp-Source: AGHT+IGVfrTU7zewsgA4NrCb8hon5XFyEh1hQSBkElhbm4S4rtlA5NVITA9tGeDRdzgvtX7FYig1l3xEhLMmhRMn4h4=
X-Received: by 2002:a05:6358:5328:b0:186:27ce:639c with SMTP id
 e5c5f4694b2df-197e50cb1efmr304204955d.18.1716555678560; Fri, 24 May 2024
 06:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521065107.30371-1-wenst@chromium.org> <20240521065107.30371-2-wenst@chromium.org>
 <CAFLszTgJpaWzJneZ-uReEGrE85MgGYOjJKxOL7jGCYMuVMPKUg@mail.gmail.com>
 <CAGb2v67MQDep8gfPWgeQoew8URAZyPw6ocGEMxMnwzYYRa0PYg@mail.gmail.com>
 <CAFLszTh5M+4Vp8oR3t-=6vsROgVJa0NU4egfJu2QuugjAfbrsw@mail.gmail.com> <CAGXv+5Eajy55kAcNzyZtsp9MJhD7EnNONW-JYsoadctaTjnxgA@mail.gmail.com>
In-Reply-To: <CAGXv+5Eajy55kAcNzyZtsp9MJhD7EnNONW-JYsoadctaTjnxgA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 24 May 2024 07:01:06 -0600
Message-ID: <CAFLszTjeQdwEp1AgL8geK7AZFwQqDfTkdzj4V2JkYqU4F7Em4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/make_fit: Drop fdt image entry compatible string
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: wens@kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ChenYu,

On Fri, 24 May 2024 at 00:30, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi Simon,
>
> On Fri, May 24, 2024 at 1:38=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi ChenYu,
> >
> > On Thu, 23 May 2024 at 11:30, Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > On Fri, May 24, 2024 at 1:19=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Chen-Yu,
> > > >
> > > > On Tue, 21 May 2024 at 00:51, Chen-Yu Tsai <wenst@chromium.org> wro=
te:
> > > > >
> > > > > According to the FIT image spec, the compatible string in the fdt=
 image
> > > >
> > > > Can you please add a link to where it says this in the spec? I cann=
ot
> > > > find it after a short search.
> > >
> > > (Quick reply from my other email before I forget.)
> > >
> > > From the FIT source file format document, found in U-boot source
> > > "doc/usage/fit/source_file_format.rst", or on the website:
> > > https://docs.u-boot.org/en/latest/usage/fit/source_file_format.html
> > >
> > > Under "'/images' node" -> "Conditionally mandatory property", the
> > > "compatible" property is described as "compatible method for loading =
image."
> > >
> > > I'll add the reference in the next version.
> >
> > OK thank you.
> >
> > There is also a spec version at [1] - it might be worth adding mention
> > of this explicitly for the fdt nodes.
>
> It seems that this is already mentioned?
>
> See https://github.com/open-source-firmware/flat-image-tree/blob/main/sou=
rce/chapter2-source-file-format.rst?plain=3D1#L343

I see that but I am suggesting that it could explicitly mention that
the FDT should not have a compatible string for the model...that
should only be in the configuration node.

>
> It looks like it was copied from U-boot directly.

Yes mostly it is the same, but there were some changes. It has evolved
slowly over the years but the bones of it is stable.

Regards,
Simon

>
>
> Regards,
> ChenYu
>
> > Regards,
> > Simon
> >
> > [1] https://github.com/open-source-firmware/flat-image-tree/
> >
> > >
> > >
> > > ChenYu
> > >
> > > > I believe this patch is correct. Since the information is in the
> > > > configuration node it does not need to be in the FDT.
> > > >
> > > > > node or any image node specifies the method to load the image, no=
t the
> > > > > compatible string embedded in the FDT or used for matching.
> > > > >
> > > > > Drop the compatible string from the fdt image entry node.
> > > > >
> > > > > While at it also fix up a typo in the document section of output_=
dtb.
> > > > >
> > > > > Fixes: 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> > > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > ---
> > > > >  scripts/make_fit.py | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > > > > index 3de90c5a094b..263147df80a4 100755
> > > > > --- a/scripts/make_fit.py
> > > > > +++ b/scripts/make_fit.py
> > > > > @@ -190,7 +190,7 @@ def output_dtb(fsw, seq, fname, arch, compres=
s):
> > > > >      Args:
> > > > >          fsw (libfdt.FdtSw): Object to use for writing
> > > > >          seq (int): Sequence number (1 for first)
> > > > > -        fmame (str): Filename containing the DTB
> > > > > +        fname (str): Filename containing the DTB
> > > > >          arch: FIT architecture, e.g. 'arm64'
> > > > >          compress (str): Compressed algorithm, e.g. 'gzip'
> > > > >
> > > > > @@ -211,7 +211,6 @@ def output_dtb(fsw, seq, fname, arch, compres=
s):
> > > > >          fsw.property_string('type', 'flat_dt')
> > > > >          fsw.property_string('arch', arch)
> > > > >          fsw.property_string('compression', compress)
> > > > > -        fsw.property('compatible', bytes(compat))
> > > > >
> > > > >          with open(fname, 'rb') as inf:
> > > > >              compressed =3D compress_data(inf, compress)
> > > > > --
> > > > > 2.45.0.215.g3402c0e53f-goog
> > > > >
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

