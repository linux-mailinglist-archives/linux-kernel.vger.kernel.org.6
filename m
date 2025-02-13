Return-Path: <linux-kernel+bounces-512186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66818A3355F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044AA167F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425B14A0B5;
	Thu, 13 Feb 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGkf6lhO"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3E146588
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412871; cv=none; b=mPH1c1mqwdo5+Werh92VhAB9N9WG/8Sollygx5PlQkYrTAMp6bxKBuy7Ti6C/Ux4Ha5/WQKdIND9xPCtLfC3Wba174sL4WH9ByxfoS3l/AIsQCyRgoxsUwy4KHUWNZYC5CnqTfMDTGlGKRE8Ji8mAjrrtu8jH3Sko/YeWmcsdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412871; c=relaxed/simple;
	bh=3PIHBmoy0seNBIy2FQHhZdVyAzTTwAN2uS3hnjKoanc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxGL92zpEvDq8i79g0yUyfVd2vYR5PjXOjBqBrOG5bePuLedwjoJyTYJtAwVWnfcqldF4bJckcJpEOXKB1T5CC2ovPWYNdnk+PD/HD5N7fkfdoALo1qZnwgYngfmXa+/5xz0pJuuZduWQip7yuJ6/PoHXbpvb7xUk7eNuB8kE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGkf6lhO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa0f70bfecso92863a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412869; x=1740017669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQHZ1MNiRO7J9/m5/3KSSXsM44H/ZZPpBbjCPfO644w=;
        b=QGkf6lhObjuECF1MLsDd/V03qJBy31W2b4tsMvKRPowIvF2TpNcau1ryRvY0FAlgAe
         kzuUhd11r83zsnEBv3oVXisOezqlPtP0gFA0ibIGCPNnAmt4JeNqpSfyJ1Ccr9qE7Huw
         fRpLiLLG5daMHLxFCzrZ+pyeP4WUPYRF+/169Yaf6BGAIwI6D12q7FV6CokiPuAPL2Vv
         PYS4NnOMCm4qncahNr26RCuK/vcHJqz+W3Qj4hFeIVsycWBZi9+/iTJUQWMRkZii//9i
         Ez+ZeGIWZDXt2ilbzJHk8eD6tw7+lEwUB67wdIZQK1csQRyc3Kg+d4ype68U82ALRn+l
         WNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412869; x=1740017669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQHZ1MNiRO7J9/m5/3KSSXsM44H/ZZPpBbjCPfO644w=;
        b=tOfizq3NZlWK6qCmyezwd8SinII5LE1hGwbNDGvwQXvZzkkavCYNCdFgBXu8iEmxr7
         W4a68WMf/HxO8qKpuYCNFN6sFsOLvZqSbE1MaX1DPt5dLJ/lCjp5HE/cbxQY6Rjct7zp
         H/DBBad6DKtHljbZlD9EIfG2FPOEJVWRt15/xQGmA8JTil974TYpp4u1iIxdcrKpCv+G
         JCCX/HLaDaJNJZZK4ieVhAQq1rDR0CP7ztfbeJ3QiWDqDJIUlPlo6B4jvUjMuNUFFP4s
         BpHy0J2YJN3xNcuj5T+n+Eh1nraCzN5pMjyX4Q5Jjr3hs1hbqXLAynnSIQgoWqHGY0qV
         15Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU828r+HhX2c/jbpFcFR27aJ2oTJb0SFbvMNUzhABmYdxI273nPwAr5fUaMhB+0IF0JAGYtTrLCQt3mk0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy582RvDMdJ1H/40tnlGRLaxtRGEFdcQdn9l0XXu/shqnOHJcRS
	KlJYncFj1OXnHAa83qOlbD/uMx/Pr4w33Nanp/nMv6k6yujZAPDl7tmG/ZsUcIp8Wcno1aYYd+z
	ZfTbQPROSD+eVPZHk2ioCuWwGnw==
X-Gm-Gg: ASbGncvxsPGOAsiQxje0rsYv1HgdKEFmJB9F6PKnvIze/5DfItQ3U8k7ynrsfvDX3/b
	cq9Z1KRANfvTHZv1o5mp1YjdJbVcqtTZ+8kqnAP7uvtlF/K9huONy/mAqf4/waAXLChQnT3F3rQ
	==
X-Google-Smtp-Source: AGHT+IHIkBr3pYJm76SXWmZ2zzEJ/LCZRj6CMKJkCT2JbrxZUxZIMASlszVBZnGeU8tA9/FNLqIVZJMs7NneeJIwe8Y=
X-Received: by 2002:a17:90b:1c8b:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2fbf5bb33cemr3422595a91.1.1739412869129; Wed, 12 Feb 2025
 18:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120190720.322926-1-chenyuan0y@gmail.com> <20250210173358.GI1868108@google.com>
 <CALGdzuqnAtyWSfgqpFbw-fVGvYnYHRGbSH2v8BUSJnpYPXR5Sw@mail.gmail.com> <20250211150614.GX1868108@google.com>
In-Reply-To: <20250211150614.GX1868108@google.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 20:14:18 -0600
X-Gm-Features: AWEUYZljrVtnnZtVkVfQJRvHf4VIqPEFvzkw1kWf1XkPkdvWENhk5KW9AUzCiyI
Message-ID: <CALGdzuoVS+RtmwH-zqWsDQtQD7-nS0PN58X75z5uuAjfWpuUiw@mail.gmail.com>
Subject: Re: [PATCH] mfd: ene-kb3930: Fix potential NULL pointer dereference
To: Lee Jones <lee@kernel.org>
Cc: lkundrak@v3.sk, linux-kernel@vger.kernel.org, zijie98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much for your insights!
I will resubmit the patch.

-Chenyuan

On Tue, Feb 11, 2025 at 9:06=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 10 Feb 2025, Chenyuan Yang wrote:
>
> > On Mon, Feb 10, 2025 at 11:34=E2=80=AFAM Lee Jones <lee@kernel.org> wro=
te:
> > >
> > > On Mon, 20 Jan 2025, Chenyuan Yang wrote:
> > >
> > > > The off_gpios could be NULL. Add missing check in the kb3930_probe(=
).
> > > > This is similar to the issue fixed in commit
> > > > https://patchwork.kernel.org/project/linux-fbdev/patch/202401141439=
21.550736-1-andriy.shevchenko@linux.intel.com/> >
> > > > Fixes: ede6b2d1dfc0 ("mfd: ene-kb3930: Add driver for ENE KB3930 Em=
bedded Controller")
> > > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > > ---
> > > >  drivers/mfd/ene-kb3930.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
> > > > index fa0ad2f14a39..60824d847bf0 100644
> > > > --- a/drivers/mfd/ene-kb3930.c
> > > > +++ b/drivers/mfd/ene-kb3930.c
> > > > @@ -162,6 +162,8 @@ static int kb3930_probe(struct i2c_client *clie=
nt)
> > > >                       devm_gpiod_get_array_optional(dev, "off", GPI=
OD_IN);
> > > >               if (IS_ERR(ddata->off_gpios))
> > > >                       return PTR_ERR(ddata->off_gpios);
> > > > +             if (!ddata->off_gpios)
> > > > +                     return -ENOMEM;
> > >
> > > I don't see many other call sites checking for NULL - why is this
> > > different?
> >
> > It looks like other places using devm_gpiod_get_array_optional do
> > check for a NULL return value, such as in
> > drivers/iio/resolver/ad2s1210.c, drivers/mtd/maps/physmap-core.c, and
> > this patch commit:
> > https://patchwork.kernel.org/project/linux-fbdev/patch/20240114143921.5=
50736-1-andriy.shevchenko@linux.intel.com/.
> >
> > > What about IS_ERR_OR_NULL() instead?
> >
> > Yes, that sounds good. However, I have a question=E2=80=94what error nu=
mber
> > should be returned in this case?
>
> I just took a closer look and don't thing returning on NULL is correct.
>
> The call is *_optional() meaning that NULL is an acceptable value.
>
> I believe that this is the correct solution:
>
> diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
> index fa0ad2f14a39..9460a67acb0b 100644
> --- a/drivers/mfd/ene-kb3930.c
> +++ b/drivers/mfd/ene-kb3930.c
> @@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
>                         devm_gpiod_get_array_optional(dev, "off", GPIOD_I=
N);
>                 if (IS_ERR(ddata->off_gpios))
>                         return PTR_ERR(ddata->off_gpios);
> -               if (ddata->off_gpios->ndescs < 2) {
> +               if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
>                         dev_err(dev, "invalid off-gpios property\n");
>                         return -EINVAL;
>                 }
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

