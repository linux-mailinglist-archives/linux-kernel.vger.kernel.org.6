Return-Path: <linux-kernel+bounces-415901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86DF9D3DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A17284AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426051B14FA;
	Wed, 20 Nov 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="it4OyP09"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125F1AA7B1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113818; cv=none; b=gW6xhsAtmG0WHvlFbDcp6kIDn+hyE+7ebJ0cqsSstq5f10V5Lc0A9jqHWzpxdntVy2PkXXWAH871gdGENbTEgeZWbAe68At4bfzKCDng9+MGZWl9GcLMZMVHJa0mTnKYQU3fkTH1CkLGg4U0wLYqK1oRGdYMSezn+iciUIDHKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113818; c=relaxed/simple;
	bh=3H0qJXOUKg7BZKQpQxV+nwwmTnCQUnU4BeIQFsGiWSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw1MQJQn4y7hLiCdMuhju680OtX8yd7RqNOe+uNDzcOga8oKnqu+LhrYC+Ha1VY4eTWr8rZD2uv3N7g0UPX6n4lofaOsHxrg/jK0sS7Cjah/V+6+nz673sbCzsCJ6BggfNNFOTsifrtnZFeZgdMUVhVJ4SKsxODeaRxKMekEGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=it4OyP09; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cd76c513cso56506705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732113815; x=1732718615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2sFP2NARD2FOImCkIlq0O7UZoSIEEdwWYR8ebMsnZM=;
        b=it4OyP09FSmSZIpygN0zZDQGfhOvALZTOGADlKCz6qFL3ZzLWaBmkqXndLYcRQbRnx
         sFE77HI2pHhnab8CTneKrza6oemJPmgtfgO8jE1GbBmJiZJS4UMK/qo2gLyRrJ34xjk3
         Uj4Tt/19w+Kn/n/72sLRzRsw5QMMUppwjaKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113815; x=1732718615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2sFP2NARD2FOImCkIlq0O7UZoSIEEdwWYR8ebMsnZM=;
        b=bcoJIlKIVbY0OvZirJGJ652MHfBzQWwLD7hYDHRnUrf5+5NeiuNPa1dTwt12b9JEGo
         9D+jSH0nl9Apq/BmrCMH7bOZ3V8Rq3aErKjJn8T3b4wb9GIIpM3pkNky3EbPr2icmms3
         zFJXsXcvg4fi37OcoAvTXFyOgu08zJQEenbFb0KouafHLl+oZpaT63nKiFEJcp1EHF95
         7gV2mqH9JOM4yP6z507wh3keGXxFTK5uQr7c/sJEqYWcbby2aGMbFvQ8DGpR0SqjxurN
         B+EEgAEJpQwba2kjfeCKz0bWV2ipquQMQ8QVOXC6Y8MpIMBNwibjBJ3/HsNIQgK9FMaH
         abYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvfrGNJRqUQHS77tpQTwKHklRV1KLgHNMiQ7dNsnM34Klelz5PI7vOD+W3VUTcy7SpxHs8Su0haQSf22M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tx7IfD7NvOurIkHms6uNPgatzS6MTLM4dFeCcNb26VtpCPJ3
	MVeqUVRq/xPHFdfiCRLOLUidkeWP1qJe1Hoaspq/TWszyTc7wnbv82b7cxn8PwxiVc/UgyEiAps
	=
X-Google-Smtp-Source: AGHT+IHrqFJWz0s59g9FgRfIcR+Hkel493W1WmHhcvI3BqlDeTy/+0hsTKksJsdNlcr/vqEUW3RGfg==
X-Received: by 2002:a17:902:d4c3:b0:212:5ba8:882b with SMTP id d9443c01a7336-2126cb4cdfbmr24710825ad.57.1732113815363;
        Wed, 20 Nov 2024 06:43:35 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f46765sm90642425ad.203.2024.11.20.06.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:43:34 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so4913538a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:43:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvTh6DaQEyBpcFe9MHTi+bJo1RsI6mpbI3t8D4+fK3SXx4499DcS4ILVXXTm00EzVREv9dglT2MJp+TuI=@vger.kernel.org
X-Received: by 2002:a05:6a20:9f09:b0:1db:d980:440e with SMTP id
 adf61e73a8af0-1ddae5e0c52mr4938722637.14.1732113813781; Wed, 20 Nov 2024
 06:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
 <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org> <20241120140526.GW12409@pendragon.ideasonboard.com>
In-Reply-To: <20241120140526.GW12409@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 15:43:22 +0100
X-Gmail-Original-Message-ID: <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com>
Message-ID: <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Wed, 20 Nov 2024 at 15:05, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Nov 18, 2024 at 05:16:51PM +0000, Ricardo Ribalda wrote:
> > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > requested from a control if it can fit in less bytes.
> > Eg: Returning 0xab instead of 0x00ab.
> > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> >
> > Extend the returned value from the camera and return it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..e165850397a0 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >
> >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> >                               UVC_CTRL_CONTROL_TIMEOUT);
> > -     if (likely(ret == size))
> > +     if (ret > 0) {
> > +             if (size == ret)
> > +                     return 0;
>
> Why is this within the ret > 0 block ? I would write
>
>         if (likely(ret == size))
>                 return 0;
>
>         if (ret > 0) {
>
> > +
> > +             /*
> > +              * In UVC the data is represented in little-endian by default.
>
> By default, or always ?
>
> > +              * Some devices return shorter control packages that expected
>
> What's a "control package" ?

usb control transfers.
>
> I think you meants "than expected", not "that expected".
>
> > +              * if the return value can fit in less bytes.
> > +              * Zero all the bytes that the device have not written.
> > +              */
>
> Do we want to apply this workaround to GET_INFO and GET_LEN, or can we
> restrict it to GET_CUR, GET_MIN, GET_MAX and GET_RES ?

I believe that the original behaviour before
a763b9fb58be ("media: uvcvideo: Do not return positive errors in
uvc_query_ctrl()")
was used for all types. I think the safest thing to do is to go back
to the old behaviour.

Let me know what you prefer.


>
> > +             memset(data + ret, 0, size - ret);
> > +             dev_warn_once(&dev->udev->dev,
> > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                           uvc_query_name(query), cs, unit, ret, size);
> >               return 0;
> > +     }
> >
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

