Return-Path: <linux-kernel+bounces-386909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726E9B4988
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EEA1F2373D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252C206040;
	Tue, 29 Oct 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzilBobj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AC1DF960
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204423; cv=none; b=fa065Jo0uDp2Zp8y0s+MocWN7t8cFK/TVHfHZca0RLiPZeQIqTCZSe44qzBIfIwJrCtoTZnY0Og6N420XH3GMVpJyUg47xq3zKkXoeEb24r5lPtfW41GzkrM9Dlbq27tyrCOlFq+YEA8MOAhtbhI/fGcSvg4/kKOS5mtyrP3l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204423; c=relaxed/simple;
	bh=ALNpfuYu8YjEgDCmT13LYtKo+Ht8dICxX9CtbVBeHaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDqjJ/MiA8k6OBe4EnkRAdpZv2s3MdIkZhRc9OV+rbAvfTVErr008Of/G75LNv7qZuYMesGRkPKoOyGpLhjOhiD8OpjQ0AlMMPmOaONxeJvPOT5s23xSdBuyLBK85tMRCQX1tOKx+PiL/pv9f/eQap0kmqYv+0sg6Cry1bTvhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KzilBobj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbcd71012so56787795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730204421; x=1730809221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62g7Pp/7Y21i31lD0JuePq5yK0xXKJofoigz9znaSi0=;
        b=KzilBobjORw9IRidHox7GcfvTg17MZQvBxy/sANEMpVh9chw8OKSPRnVhuajxBHp2C
         SLZl/uOSIOaNc9cnfcwner0kFMtPsgGxA1XZBDXYqQAnD0V2tKggwTp7C1b8djlWlq8H
         dgjxJLgzTrhfPbr/+wAHgyIMFiVyD1dN4rLd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204421; x=1730809221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62g7Pp/7Y21i31lD0JuePq5yK0xXKJofoigz9znaSi0=;
        b=EmTUL8VZHTlcO3+e3N/mWoaINIR4gLB8KrJQX17Yr57p7mS4oIJz6pLSjccyrefCmQ
         zriK8hVX1ijjDkdeIM5fP+yunAT0zT/HqkLE41LWcNP1EAGB/9kiOgbo2h9Izt7u8Rn7
         erseCRC0JZdzIFm1Tnz2q+T+BlmH9arO02bqArxOKkz1garziRJ0rS4R8dHoxwDWobsf
         wND/NT64w4w0QGo474cC8vbGGREGE7fVKaIu2usn2iPU9f+xyALL6oAMajGxub6wiw3g
         R/grH+vplWlVUqFWJih9jI3/524SaKzL4ufHLLFkIy/6i/zBD74pq0BzSlUhGkqtbPtL
         Ws4w==
X-Forwarded-Encrypted: i=1; AJvYcCUdvEmGzYGjZbdF3bSPfg6N02B3o3KZiahfaEye7VzUMdQOq1htkHUA29pR0Hu4i5dTgoyl0b8bi4KhJ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+vZQ+UlHl3vW98hOkeSn1AoTQRgCSG1hJX8vl91IBGHlG0bu
	1emEL/7Yw4xS2myBMNpSu2fbz2XnedEQzHt8fEGHgOYXdfSqGbvY+dUTXF147e1hl5vcuKZ9A4A
	=
X-Google-Smtp-Source: AGHT+IEeXVbCPDSV2nstnQWJlnJdqx47lexg9iIC0Oh/HjBbQL4RuIb05vpMUL6dG3tzeO5lUeaZGQ==
X-Received: by 2002:a17:902:ce03:b0:20c:81f2:3481 with SMTP id d9443c01a7336-210c69e5f99mr157076815ad.22.1730204420833;
        Tue, 29 Oct 2024 05:20:20 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44183sm64807845ad.11.2024.10.29.05.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:20:19 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7206304f93aso2665710b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3YV07mX/9WYl4kiga6CDzTCQuwo93DrWFFcHwAkzecTeLOkGVWjHUjI6mdj/Xp0ePx8rXpZyGtzOSqwc=@vger.kernel.org
X-Received: by 2002:a05:6a20:4b11:b0:1d9:c6c8:b354 with SMTP id
 adf61e73a8af0-1d9c6c8bb78mr6513354637.15.1730204418853; Tue, 29 Oct 2024
 05:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org> <20241028-hpd-v2-3-18f6e79154d7@chromium.org>
 <20241028203437.3eb5268d@jic23-huawei>
In-Reply-To: <20241028203437.3eb5268d@jic23-huawei>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 29 Oct 2024 13:20:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
Message-ID: <CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: Add channel type for attention
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan

On Mon, 28 Oct 2024 at 21:34, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 28 Oct 2024 10:12:23 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Add a new channel type representing if the user's attention state to the
> > the system. This usually means if the user is looking at the screen or
> > not.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> >  drivers/iio/industrialio-core.c         | 1 +
> >  include/uapi/linux/iio/types.h          | 1 +
> >  tools/iio/iio_event_monitor.c           | 2 ++
> >  4 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 89943c2d54e8..d5a2f93bd051 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2339,3 +2339,10 @@ KernelVersion: 6.10
> >  Contact:     linux-iio@vger.kernel.org
> >  Description:
> >               The value of current sense resistor in Ohms.
> > +
> > +What:                /sys/.../iio:deviceX/in_attention_raw
> > +KernelVersion:       6.13
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Boolean value representing the user's attention to the system.
> > +             This usually means if the user is looking at the screen or not.
>
> Hmm. I should have thought of this when I replied to suggest a new channel type.
> The question is 'units' for a decision.
>
> Last time we hit something like this where processing is used to make a decision
> we decided to at least allow for the concept of 'certainty'.
>
> The idea being that smarter sensors would tell us something about how sure they
> are that the attention is on the device.
> The analogy being with activity detection. See in_activity_walking_input
> in Documentation/ABI/testing/sysfs-bus-iio
>
> Do you think that would be appropriate here as well?  For this device
> it would take the values 0 and 100 rather than 0 and 1.

For the particular device that I want to support, they are giving me a
value of 1 and 0, and the example from usb.org seems to work the same
way (Logical Maximum of 1)
https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf

I have no problem multiplying my value by 100 if you think there will
be a use case for that. It will not have a major performance impact on
the driver.

You decide ;)

>
>
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 6a6568d4a2cb..bdfb51275b68 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -95,6 +95,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >       [IIO_DELTA_VELOCITY] = "deltavelocity",
> >       [IIO_COLORTEMP] = "colortemp",
> >       [IIO_CHROMATICITY] = "chromaticity",
> > +     [IIO_ATTENTION] = "attention",
> >  };
> >
> >  static const char * const iio_modifier_names[] = {
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index f2e0b2d50e6b..12886d4465e4 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -51,6 +51,7 @@ enum iio_chan_type {
> >       IIO_DELTA_VELOCITY,
> >       IIO_COLORTEMP,
> >       IIO_CHROMATICITY,
> > +     IIO_ATTENTION,
> >  };
> >
> >  enum iio_modifier {
> > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > index 8073c9e4fe46..ed9a677f1028 100644
> > --- a/tools/iio/iio_event_monitor.c
> > +++ b/tools/iio/iio_event_monitor.c
> > @@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >       [IIO_DELTA_VELOCITY] = "deltavelocity",
> >       [IIO_COLORTEMP] = "colortemp",
> >       [IIO_CHROMATICITY] = "chromaticity",
> > +     [IIO_ATTENTION] = "attention",
> >  };
> >
> >  static const char * const iio_ev_type_text[] = {
> > @@ -183,6 +184,7 @@ static bool event_is_known(struct iio_event_data *event)
> >       case IIO_DELTA_VELOCITY:
> >       case IIO_COLORTEMP:
> >       case IIO_CHROMATICITY:
> > +     case IIO_ATTENTION:
> >               break;
> >       default:
> >               return false;
> >
>


-- 
Ricardo Ribalda

