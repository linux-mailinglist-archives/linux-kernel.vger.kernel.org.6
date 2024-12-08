Return-Path: <linux-kernel+bounces-436564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF59E87A1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD37281A57
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C061474B7;
	Sun,  8 Dec 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZQWAofzu"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B49126BFA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688574; cv=none; b=uHvPPHvbVwGq33XfmpQc8Ioi49+Cyi6x97GQy8Sik6exCCDPWc5Hr5NraOvX5AGp6l/ITlVbTDxwx/L6clKm9YFLqa3xUiPZgdar0a5Ll8Lmm3ULAIB6/vXAiom7azNcw4MtKR4fKnmIqSxSfxpVNQoZmeW8dW8mQ1+PLPzWtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688574; c=relaxed/simple;
	bh=tDolt7CdTcOAuj3WjqpFgrueMTWHOLF8Meouj6r0xp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhSqUc7ikdu8UASigmT4TyaCoiAkNMN3r3v3/Ns5WYs+8xSWIorMUP3iD6eepSOW/uNvkK29vhhuHmcQXI8UHbVTJLxOrI/PkhRvA15wue/cX2s1vNUShb6zW9ck9DXPhPzdKopQpBdX/CdOTfViAgk3PbQr4RtVbyLDr6k4bRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZQWAofzu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so793296a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733688572; x=1734293372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLhwkBOgmbpT4U5gL2AOUVQiIkPnhXXcl0f3hXuuoIA=;
        b=ZQWAofzufO4nwMIlnsf74t8dswlARWh9PnqxFmuecHOuchN7m1ZCT/3jI9nH135W4P
         YLNUGaLn+LPMQdGYR1+JbNjOLZNqS1Rq14aC/CWDLy2yyJfZraC7CJsYPQ0PAP8Uax2c
         964a6UEvHKCvNtTY1VcCwDS7qA1cZNO/s1OWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733688572; x=1734293372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLhwkBOgmbpT4U5gL2AOUVQiIkPnhXXcl0f3hXuuoIA=;
        b=E+4fd03WKYJW+7oJ5+Y9Yg7oK25H9K1xmo3X8g9F56D4au2bt1jKE2ZP67/LltGy6Z
         dMVh8f5SFJ8vnLCCf5kKBFlRba9zCGBnEupvAf5SCmjZLMWyOMTf+4qZCwLiqOLdgO5G
         h2cTHVgevv7WYtNvUZ9Pl1fzX7/LK8zlNfrfETOkD0t/7pjA6kF1ahrG1nh3kSS2zBkx
         Af5oRxOxd5789Xo4MOHJoaS3cEN5i/WyGxLpE+G5gMA973JDW7tR2pIfFtvQqNLEquBa
         njIlDPqzZzsf8l1FQiTnBkEi+qq+qPUwQbMq2SxqkAoTwQ3JsxV6QbknbGLR18tDqdf+
         O+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU762y+py592fKNZbq4JsnrnAwSUBdVrmrAw3ASSDGvx1SlCX8LqcSi8V0mBucCggXbABzbEe16Lqk0wYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rfUtzX436dlF6tFvgmO5UuhLkuuWxT4AY+MlUVrDWe84co94
	wfTwk4CiJjdXbyTMXMci0+k22jAVl/XQHZfkq9GmhtgkTZ33qM1BYBGjoJGA04TU6T3rZRxiso8
	=
X-Gm-Gg: ASbGncv0E66BXHb6PvZrE4FMYYY0gJlozSjU3pG4u0l1EuDTza2jZCxSRVKxMQt7YgB
	P99lXvrxlCz9i3gMiboTKqb15W/RPJ96GCTdTwbUp7PO7Ak9No97M9Z+oEBHkA91UPOYXmKfh2q
	JmiMYx9Gzo251Eu6H5kpuZE2G7W6AtSpmdVu1sRUORd1AszcfaWgUPOXrART72AqZhZVdH7jZSR
	p2861k2yICbnkF0gp3rfdedqzzP7JaWuhmi5UIu3ONjVYhO4Gv+3mXnL/qITo2DYWppJXu8E2fE
	43YBMEShgJyitQCm
X-Google-Smtp-Source: AGHT+IFtuaMfWP0X/S3VrdkBBBjgIA8Qk6PZZC7htk83x70v+BLRcCHvXr6gTMjoF07HbkK+dTnJeA==
X-Received: by 2002:a17:90a:c88f:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2ef69f0b077mr17549960a91.12.1733688572427;
        Sun, 08 Dec 2024 12:09:32 -0800 (PST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffb5fcb7sm7704458a91.0.2024.12.08.12.09.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 12:09:30 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso1165785ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 12:09:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOU58umD7jqyWcSExvHp5Nwy7rwKsnaZN1aAh1eFmQDvj7HPvtJnRzR4HATuFoQrt3yWJNqiE8e7nlE0k=@vger.kernel.org
X-Received: by 2002:a17:902:fc4d:b0:216:3dc5:1240 with SMTP id
 d9443c01a7336-2163dc515d4mr53882835ad.45.1733688568741; Sun, 08 Dec 2024
 12:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org> <20241208163851.41c47c3f@jic23-huawei>
In-Reply-To: <20241208163851.41c47c3f@jic23-huawei>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 8 Dec 2024 21:09:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCsD2gGBPVaFMU4uhtpWf3dUr4-MA5MpcjZRcLMgBmtjZg@mail.gmail.com>
X-Gm-Features: AZHOrDljjJs2pi977K4dUh9IOYsTVktxzHjXF2FzE_KTvdtIKS-5f-wvx8t2_EE
Message-ID: <CANiDSCsD2gGBPVaFMU4uhtpWf3dUr4-MA5MpcjZRcLMgBmtjZg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Merge information from different channels
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan


On Sun, 8 Dec 2024 at 17:39, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 05 Dec 2024 12:59:20 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > The device only provides a single scale, frequency and hysteresis for
> > all the channels. Fix the info_mask_* to match the reality of the
> > device.
> >
> > Without this patch:
> > in_attention_scale
> > in_attention_hysteresis
> > in_attention_input
> > in_attention_offset
> > in_attention_sampling_frequency
> > in_proximity_scale
> > in_proximity_sampling_frequency
> > in_proximity_offset
> > in_proximity0_raw
> > in_proximity_hysteresis
> >
> > With this patch:
> > hysteresis
> > scale
> > sampling_frequency
> > in_attention_input
> > in_attention_offset
> > in_proximity0_offset
> > in_proximity0_raw
> >
> > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> whilst perhaps not ideal use of the ABI, what is there today is not wrong
> as such.  If the ABI above was all introduce in the recent patch I might
> be fine adjusting it as you suggestion. However it wasn't, in_proximity_scale
> has been there a long time so this would be an ABI change.
> Those are generally only ok if there is a bug.
>
> Drivers are always allowed to provide finer granularity than necessary
> so in this case I don't see this as a bug.

Is it ok that changing the attention_sampling frequency the
proximity_sampling frequency changes as well?
(Just asking for my own education, not complaining :) )

Also, what about ?:
in_attention_scale
in_attention_hysteresis
in_attention_input
in_attention_offset
in_attention_sampling_frequency
in_proximity0_scale
in_proximity0_sampling_frequency
in_proximity0_offset
in_proximity0_raw
in_proximity0_hysteresis

Would that be acceptable? I think that if we are giving the false
impression that every sampling frequency is independent we should go
all the way in. WDYT?

Thanks!

ps: this patch is in the queue in case you missed it
https://lore.kernel.org/linux-iio/20241122-fix-processed-v2-1-b9f606d3b519@chromium.org/

That one is a real fix for the driver :)

>
> Jonathan
>
>
> > ---
> >  drivers/iio/light/hid-sensor-prox.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> > index e8e7b2999b4c..f21d2da4c7f9 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -49,9 +49,11 @@ static const u32 prox_sensitivity_addresses[] = {
> >  #define PROX_CHANNEL(_is_proximity, _channel) \
> >       {\
> >               .type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> > -             .info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > -                                   BIT(IIO_CHAN_INFO_PROCESSED),\
> > -             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> > +             .info_mask_separate = \
> > +             (_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > +                             BIT(IIO_CHAN_INFO_PROCESSED)) |\
> > +             BIT(IIO_CHAN_INFO_OFFSET),\
> > +             .info_mask_shared_by_all = \
> >               BIT(IIO_CHAN_INFO_SCALE) |\
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> >               BIT(IIO_CHAN_INFO_HYSTERESIS),\
> >
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241203-fix-hid-sensor-62e1979ecd03
> >
> > Best regards,
>


-- 
Ricardo Ribalda

