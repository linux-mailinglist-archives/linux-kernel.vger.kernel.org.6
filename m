Return-Path: <linux-kernel+bounces-284849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C809505D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA38282E23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1F19ADA6;
	Tue, 13 Aug 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l4pR/OhI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463074206D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554116; cv=none; b=DoobjBxcp6/N3//bOjnJImatUbNf8FDEuDDcClowd37jGOHzXR2xvk4nBOsm2uKhlDkx5acaaIL0Q3pra+ly4t+LD2TB9H1IWBNBZSZNSXZ44HZisOZvh6caTm1xkv1mPj0MoFa99ZO1ty/eqNZGojNGrw45POko1WSizAndh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554116; c=relaxed/simple;
	bh=OW9ZXqxEkr9RUH5IYYordISjGdWv1zhb8JCl6eodq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwUMb8rzAKU8/MagYkXrapMqIuXT4Jag2IQEr9jUxQXT3nbUR4eAEDf/SdEfczhG6ZXE9ui1jKkroIAY9Ji7jt0VfmyNZVGA8pTUgsC9zroKbhN/SXounpaJk1MRc07YkAm4FVlwDn9CBNrbcoE9GTNQEorgurTikox/OFzVBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l4pR/OhI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so79322566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723554113; x=1724158913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ3qkhG6IpTE9k1+4JdfEiuc6iwsZmU2tud2hbQlnTM=;
        b=l4pR/OhIHnwk6fDl4BcrY+KrVRyVAubIrh/Y/i6RzHb4DxJRwbYJf3MvXhcPgZ7xQ6
         auVl3r6XtHWFF86hOy1H/d/UPTxAkD16rmuNoXEGy35BCnGtNOZ2/QRMkY1jBVvDkXKG
         ptPqbHXDNmLAs9/l2qdwu5PpLiWeH0JH1fWIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554113; x=1724158913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ3qkhG6IpTE9k1+4JdfEiuc6iwsZmU2tud2hbQlnTM=;
        b=TTB245cGMnCVx2axKjgSK20DaUezcF8phsGBxoBdCTPdxroy1gA1VHm1rw4XuODsvJ
         8C8mkWNB5DErKWqkFyfnOGNTYmQkPOv3sQMJs4diyuuqVleVfXbrmg6bazq8V2lpWi6y
         bA9b/S8IBRg9iylVfo6h6QlxzqmJEjtNdBjko4yG++xXOiD+1ROzQo5cr6QHZAlLmzTO
         SxDppGa4p4lhPp8/Mf/1b3BpQV4jw1p7Y/3SIgXNS+zy1rEJ5/PcpYKyxetpDBT3Gmfl
         2iQD9u9QKZO030LJAlcpnEUg2aXelJxdq4pjIJEiwIiKK1hojxbHserlSxmrqUZckT/G
         jnrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvRAJ5qYwqEZieObdRZ9Yj5OuqFsQ+QrPlRCxjAX66VEnmUVMFURXvESWM/1nlTBdThA2+xgjrQOsKS1ndaXGTiAbNCDHyttlYUDBy
X-Gm-Message-State: AOJu0YwWyJThkoBiFaX6oZs89g4Q0lBikslnEBHpV3tEWFIIO93sFvUN
	eY9S4hWjBggZ6BEOL2ciJ8hwgKkUJeiDezNi3VrymkoCaDsXhqmOaLb/Ut3fxEwfNki48eC27VB
	9ZQ==
X-Google-Smtp-Source: AGHT+IHeQe0fmCJgri1XqpVrZ1Fnm/qv6tGZ1VRtTdUpl48Ya2ISncGhdQ58XQr1F6hajNAno18fAw==
X-Received: by 2002:a17:907:efd5:b0:a7a:929f:c0cf with SMTP id a640c23a62f3a-a80ed1efeedmr267495166b.21.1723554112746;
        Tue, 13 Aug 2024 06:01:52 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f475ccsm70229566b.14.2024.08.13.06.01.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:01:52 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso6414410a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:01:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH7lJ6RlUyrcdbQ1Ordq7LJh4U/BjRlOBG2f7CmoxDtn4RWvYC0sUmRXDByon9NW2NS7bpbG+2OqfuB5yrUFiB+pP/OG6GWq0WZkgc
X-Received: by 2002:a17:907:d2d9:b0:a7a:ae85:f245 with SMTP id
 a640c23a62f3a-a80ed258d19mr244135166b.38.1723554111718; Tue, 13 Aug 2024
 06:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
 <20240813-smatch-clock-v1-1-664c84295b1c@chromium.org> <ce0ed949-5e57-4193-8190-9e4aa9cb62be@stanley.mountain>
In-Reply-To: <ce0ed949-5e57-4193-8190-9e4aa9cb62be@stanley.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 15:01:37 +0200
X-Gmail-Original-Message-ID: <CANiDSCu6BUdJt1sjmbOq2s4KU1JUN9D+HfnvSG6OqMhD-dKekw@mail.gmail.com>
Message-ID: <CANiDSCu6BUdJt1sjmbOq2s4KU1JUN9D+HfnvSG6OqMhD-dKekw@mail.gmail.com>
Subject: Re: [PATCH 1/6] media: ar0521: Refactor ar0521_power_off()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Tue, 13 Aug 2024 at 14:54, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Tue, Aug 13, 2024 at 12:13:48PM +0000, Ricardo Ribalda wrote:
> > Factor out all the power off logic, except the clk_disable_unprepare(),
> > to a new function __ar0521_power_off().
> >
> > This allows ar0521_power_on() to explicitly clean-out the clock during
> > the error-path.
> >
> > The following smatch warning is fixed:
> > drivers/media/i2c/ar0521.c:912 ar0521_power_on() warn: 'sensor->extclk' from clk_prepare_enable() not released on lines: 912.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
>
> It's better to just ignore false positives...  The problem here is that
> Smatch can't track that to_ar0521_dev(dev_get_drvdata(dev))->sensor is the same
> as sensor.  What I could do is say that "this frees *something* unknown" so
> let's silence the warning."
>
> The problem is that check_unwind.c is not very granular.  It just marks things
> as allocated and freed.  I could make it more granular so the free and the
> alloc have to match.  Or we could match based on the type.  This frees a
> "struct ar0521_dev" so mark all those as freed in the caller.
>
> >  drivers/media/i2c/ar0521.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
> > index 09331cf95c62..2c528db31ba6 100644
> > --- a/drivers/media/i2c/ar0521.c
> > +++ b/drivers/media/i2c/ar0521.c
> > @@ -835,7 +835,7 @@ static const struct initial_reg {
> >            be(0x0707)), /* 3F44: couple k factor 2 */
> >  };
> >
> > -static int ar0521_power_off(struct device *dev)
> > +static void __ar0521_power_off(struct device *dev)
> >  {
> >       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> >       struct ar0521_dev *sensor = to_ar0521_dev(sd);
> > @@ -850,6 +850,16 @@ static int ar0521_power_off(struct device *dev)
> >               if (sensor->supplies[i])
> >                       regulator_disable(sensor->supplies[i]);
> >       }
> > +}
> > +
> > +static int ar0521_power_off(struct device *dev)
> > +{
> > +     struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +     struct ar0521_dev *sensor = to_ar0521_dev(sd);
> > +
> > +     clk_disable_unprepare(sensor->extclk);
> > +     __ar0521_power_off(dev);
>
> You had intended to remove the clk_disable_unprepare() from __ar0521_power_off()
> but forgot so these are double unprepares.

Ups, thanks for catching it :)

Will send as v2, unless you fix it in smatch first ;P

Regards!

>
> regards,
> dan carpenter
>
> > +
> >       return 0;
> >  }
> >
> > @@ -908,7 +918,8 @@ static int ar0521_power_on(struct device *dev)
> >
> >       return 0;
> >  off:
> > -     ar0521_power_off(dev);
> > +     clk_disable_unprepare(sensor->extclk);
> > +     __ar0521_power_off(dev);
> >       return ret;
> >  }
> >
> >
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >



-- 
Ricardo Ribalda

