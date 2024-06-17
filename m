Return-Path: <linux-kernel+bounces-217856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA890B53C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ADA1C20DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108CF1C290;
	Mon, 17 Jun 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ILVf9eDx"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7517BA8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638138; cv=none; b=Ns6YAfNLdRPLihz0zyRskcBdxaTvWZcXGqrBn7dVrMg3Ynn/i5EUWXjDlPQ5uAMdPZ4dyGRNVhjL9ZCzNXynL+OutAFZf5PLlrTZ+GcwAI14FO1maUk5Yr5JR6qq8nl5jtKkvBQPqtMk66GFmruodAIa9RVUAdWRIEulGj/5/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638138; c=relaxed/simple;
	bh=AQ2SE0RH62XIYQ3Ernt2eE7UxS8NnWu8VvwS4vqeMkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaZa1lBuJEfqpXhaO1aeL2q4lEL1dHLR/uy6LGu1VqWARpTOMpz4h324SpcvjSc2F2FjqILb/YbGTdtzBEO2nEp8tk6nMse0GjxGQHjD/N2Cyv5+jf1IlJlR6YX/ikIZl1+a8qkuBi6C7eKwvxBoPzY6LtY55HLZVYjdYB+doRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ILVf9eDx; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5bb36de2171so2349744eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718638134; x=1719242934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlVlomx5sxYTMMcPGMNO+1cr2atFOWJw4tpHzK2RLUQ=;
        b=ILVf9eDx26eGc0AjAtYjwCS3YzKWHl4zy5qcFoGI97L/O81fmiF6hjqbw37cO+7EJd
         FMASWepbXCjB7SZeWbzF5WbUY9spDpt2tyPyzlKDiz18uhjeO7QCNHC5xKl/qo7hGjvM
         mCJe8PI/oNG7YwZkTg71fPvDBiqwOnEjUhbzssS1SZlZU5k0ZwjdxxRtwMWVDu4Yq2fB
         Ug/uzgxV0Axiz4g2lwAhcK3BA8YkAJ2SBePM88GdW5a8f4HasOpXPw5ZgghzE6Uk2cKr
         fbGxl603EJypCD/vaoOhEo5dVRYLVjQhxSlQ1mup3/6x/c+y1dSfm3wSW6mD+8k0yy7V
         7Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638134; x=1719242934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlVlomx5sxYTMMcPGMNO+1cr2atFOWJw4tpHzK2RLUQ=;
        b=Ngwml5/f9Uil8bG4Pj8PIc8MJMHUhi3yFRusaTuLBAVdsHiL6zxwmVL4HkqMBHCwaM
         eCENdrlYVvLuI/LV+FAQse8pc5Eum30+ebgEAAPCmWlAlJ02inz8K2dGiX1aYmXQEPP1
         JAZcwG5hDHY+GTqWqEPXYmv7wb9KOlgCSsnbMJquC99gW0/9pZzO7fCR/LhIjxNUunyO
         tn4V5sqoCZREgfxytDfTMtoaHh+yE6AhhmqtKaGYij1KrNQfukXEGWzb5Fh1ITrhAAns
         3+whIhlwX+I10FtAAVB1z5YF4S8uVsXid51jq5RiILKAH2s5LN12THabks8hqPCpG8k8
         xwig==
X-Forwarded-Encrypted: i=1; AJvYcCWaW593W0uovpjZ1VqGpnsDwLgUtKY8jABZMvOBm1l/LgcBSrsWgX/DvV3nt7EHO3ddanwr3zEficWJVw/x4C5WANX1oUILJyGS/JA6
X-Gm-Message-State: AOJu0Yw5ybunHbFVLR/oj31MZRCkTQLfTrypH7AirdbxzoN17T0qGA1U
	Y9zhQHiJgseCzKDxFeBAgyAkoJ+2l9QMzLOe6w/lB+d7epeUKC6+L55fjzPpoG5IL+woAB/1177
	XSPmffB/q5oIhWGu42xpaD6Mul8TIOEQAUG+O4Q==
X-Google-Smtp-Source: AGHT+IEvpsPwfQeZ/F68nF68Id+smXv/SHAWkQKFDcj9xghyMm1bgW9VRwCatWoay2IL1Zbv45XqJ2AisQj7k/JHDM0=
X-Received: by 2002:a05:6870:899b:b0:254:a694:e678 with SMTP id
 586e51a60fabf-25842af7008mr10457150fac.37.1718638134130; Mon, 17 Jun 2024
 08:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei> <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
 <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com> <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
 <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
In-Reply-To: <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 17 Jun 2024 10:28:42 -0500
Message-ID: <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:10=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> On 17.06.2024 16:48, David Lechner wrote:
> > On 6/17/24 8:38 AM, Alisa-Dariana Roman wrote:
> >> On 17.06.2024 16:22, David Lechner wrote:
> >>> On Mon, Jun 17, 2024 at 4:35=E2=80=AFAM Alisa-Dariana Roman
> >>> <alisadariana@gmail.com> wrote:
> >>>>
> >>>> On 15.06.2024 15:08, Jonathan Cameron wrote:
> >>>>> On Wed, 12 Jun 2024 16:03:05 -0500
> >>>>> David Lechner <dlechner@baylibre.com> wrote:
> >>>>>
> >>>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
> >>>>>> function to reduce boilerplate code.
> >>>>>>
> >>>>>> Error messages have changed slightly since there are now fewer pla=
ces
> >>>>>> where we print an error. The rest of the logic of selecting which
> >>>>>> supply to use as the reference voltage remains the same.
> >>>>>>
> >>>>>> Also 1000 is replaced by MILLI in a few places for consistency.
> >>>>>>
> >>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>>>
> >>>>> Complicated bit of code, but seems correct.
> >>>>> However, it crossed with Alisa-Dariana switching adding a
> >>>>> struct device *dev =3D &spi->dev to probe() that I picked up earlie=
r
> >>>>> today.
> >>>>>
> >>>>> I could unwind that but given Alisa-Dariana has a number of
> >>>>> other patches on this driver in flight, I'd like the two of you
> >>>>> to work out the best resolution between you.  Maybe easiest option
> >>>>> is that Alisa-Dariana sends this a first patch of the next
> >>>>> series I should pick up.
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Jonathan
> >>>> I will add this patch to my series and send it shortly.
> >>>>
> >>>> Kind regards,
> >>>> Alisa-Dariana Roman.
> >>>
> >>> Great, thanks!
> >>
> >> Just one quick question:
> >>
> >> I am getting two such warnings when running the checkpatch script:
> >>
> >> WARNING: else is not generally useful after a break or return
> >> #1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
> >> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n"=
);
> >> +    } else {
> >>
> >> Should I switch the last two branches to get rid of the warnings or ju=
st ignore them?
> >>
> >
> > In the other patches, I was able to reorder things to avoid this
> > warning, but since this one was more complicated, I just ignored
> > this warning.
> >
> > We can't just remove the else in this case because the return
> > is inside of an `else if`.
>
>         /* AVDD can optionally be used as reference voltage */
>         ret =3D devm_regulator_get_enable_read_voltage(dev, "avdd");
>         if (ret =3D=3D -ENODEV || ret =3D=3D -EINVAL) {
>                 /*
>                  * We get -EINVAL if avdd is a supply with unknown voltag=
e. We
>                  * still need to enable it since it is also a power suppl=
y.
>                  */
>                 ret =3D devm_regulator_get_enable(dev, "avdd");
>                 if (ret)
>                         return dev_err_probe(dev, ret,
>                                              "Failed to enable AVDD suppl=
y\n");
>
>                 avdd_mv =3D 0;
>         } else if (ret >=3D 0) {
>                 avdd_mv =3D ret / MILLI;
>         } else {
>                 return dev_err_probe(dev, ret, "Failed to get AVDD voltag=
e\n");
>         }
>
> Would switching the last two branches, in order to get rid of the
> warnings, make the code harder to understand?
>

I did it in the other order because usually we like to handle the
error case first.

To make it more like the other patches, we could do something like
this. The only thing i don't like about it is that `ret` on the very
last line could come from two different places. But it is logically
sound in the current form.

    /* AVDD can optionally be used as reference voltage */
    ret =3D devm_regulator_get_enable_read_voltage(dev, "avdd");
    if (ret =3D=3D -ENODEV || ret =3D=3D -EINVAL) {
        /*
         * We get -EINVAL if avdd is a supply with unknown voltage. We
         * still need to enable it since it is also a power supply.
         */
        ret =3D devm_regulator_get_enable(dev, "avdd");
        if (ret)
            return dev_err_probe(dev, ret,
                         "Failed to enable AVDD supply\n");
    } else if (ret < 0) {
        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
    }

    avdd_mv =3D ret <=3D 0 ? 0 : ret / MILLI;

