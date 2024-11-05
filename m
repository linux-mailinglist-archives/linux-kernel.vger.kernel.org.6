Return-Path: <linux-kernel+bounces-396695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8F9BD0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2B286AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4615FA74;
	Tue,  5 Nov 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LF/39Dv/"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1A15EFB9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821016; cv=none; b=iymwHZvDiResQL2J64/w9IfCDimNsQUDYwX8zI6YFp/WLrhmrfXaqk/gWd/T5fopPudPjTXNvwWpqfRpHrDFbjqZoR/5z0KPlqsLQjga+lQ17cY+iXG0xbGuoLvSU3wYlcuuetpQr8jC5w5KDrs7GSpXZRaH5n0YnJyUKbCqsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821016; c=relaxed/simple;
	bh=aOsZwqmB0KpZlBipWrBUXvdGKccveZF1oHmlW64bCgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6LRJGGlpIU5JzeJpEe0AFtB39Bnclecfm7wSLeAxo5DMdCyLoosIKF7950rftjygIMZE0GA6+Ey58kPYKaV18yHTsBvSE0redLIupIQviPodb6nzG+CVq1oUcsd8IgTj/K1XL83wndYlIbrC60U7Rv8Imh92rJK28YjgtInbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LF/39Dv/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3663402a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730821014; x=1731425814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gYhyNkQSfvX8YoGKzdMuoui6AtbcgZ00ytCvX4WlVI=;
        b=LF/39Dv/nf+49CrXsYS1dOCXItTMCyQzk7DOycCU/vK1HPurOPEv/grxmsj+9x6bG1
         LnBt7XSiqFh3sxZ+MbTcQMe9oTUZ1SzCfjmxHjiuceQJCSK8A/mY6kOmC/lZ5C7uLt9D
         YSDFlm3AgEgO/Dy3s+H/NWNPwv8OGOxZ4rRhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821014; x=1731425814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gYhyNkQSfvX8YoGKzdMuoui6AtbcgZ00ytCvX4WlVI=;
        b=j7tUfDjttTnW4xuIHHcI180tb+GiPJgErLWBq5PVij5VYmV3Mo3yZUWiMGc1QpfXAS
         E6CXtX1SbJiCHXqnTBkKwr9T7LZdXUnSBK0rsBod4ed9KdiEA1ADAp3+G/aNDCUy8xbr
         V/n+N4P6UXC9ltMFppGKB81JPiTABs1/eZxfGCvV3Bb9GF9OQq8r596/OHwqI48pypQo
         gCgOMqT9oqHLrwYj5DqkDHo+OmUneibQG993Kiidc6etlQZUqT/5NJ+ATu4B7yZZ+97E
         YgzruOePuVfwKmnN5yZw+gmPO/lPyTM7IHkbuRc0QQcdEYbrmesRNY+15h9/KB2gl2cZ
         v8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWKkZvtkWYcdDur8yAti4nQLw9AsS+lmHsR/uTBr5nEgbsLzBx2sX3YfRsI6eH/Yv5YJIhlxLEO3EbxzA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAfPKYo+IBt08O1E29FSyeWbDN2mw/F8LKWeWfDqrvoOSwOZD
	+Y3a2GwX5gWZo1a4KIOMFUcLwOKNgYddVylzpQSOYCzi44OHwY5DJL5NN6emQvhDzCJy0u/FxvU
	=
X-Google-Smtp-Source: AGHT+IHTDGYY2TJrV5V3eAgzZMQtMqPNm0rS/aND9zTBvW2pmaPuWEMzwB/u6tsFqO3xwB8Tihlcbg==
X-Received: by 2002:a17:90b:3c49:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e94c2b3825mr24844916a91.10.1730821013522;
        Tue, 05 Nov 2024 07:36:53 -0800 (PST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db18717sm9873539a91.35.2024.11.05.07.36.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:36:52 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21116b187c4so39307635ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:36:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLDc55QbgeN2hkno34jEiQz9Wq30szn6dNAcRzsFizV42sOLaMuyQZHG7oGpyaKEL7SVRxz9J1feVg4ys=@vger.kernel.org
X-Received: by 2002:a17:90b:2247:b0:2e2:cf63:224c with SMTP id
 98e67ed59e1d1-2e94c52f356mr22199796a91.35.1730821011691; Tue, 05 Nov 2024
 07:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-uvc-rmrefcount-v1-1-123f56b01731@chromium.org> <20241105144340.GQ27775@pendragon.ideasonboard.com>
In-Reply-To: <20241105144340.GQ27775@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 Nov 2024 16:36:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCvtaFxPvsJRQRo3RG54RZef2crs1Vk5TkA9XdoZNoqr5w@mail.gmail.com>
Message-ID: <CANiDSCvtaFxPvsJRQRo3RG54RZef2crs1Vk5TkA9XdoZNoqr5w@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Remove refcounted cleanup
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, 5 Nov 2024 at 15:43, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Nov 05, 2024 at 02:32:39PM +0000, Ricardo Ribalda wrote:
> > After commit c9ec6f173636 ("media: uvcvideo: Stop stream during unregister")
> > we have some guarantee that userspace will not be able to access any of
> > our internal structures after disconnect().
> >
> > This means that we can do the cleanup at the end of disconnect and make
> > the code more resilient to races.
> >
> > This change will also enable the use of devres functions in more parts
> > of the code.
>
> That's the wrong direction, let's not go there, especially given that
> this doesn't fix anything. Strong nack on my side, especially given how
> many of your previous patches introduced race conditions. It's not

They have also fixed some race conditions... keep the discussion
professional please.

I think this only proves that uvc code is quite complicated. It also
lacks a lot of consistency with the rest of the drivers in media (and
in the kernel in general)
that is exactly what this patch tries to fix.


> broken, don't touch it. A better use of your time would be to fix the
> unplug race issue at the subsystem level.

Now memory is allocated during uvc_probe(), but it is not freed until
after disconnect() if userspace has a videodevice open.
Luckily userspace now cannot interfere with the driver after
disconnect(), so lets make use of that property to simplify the code.

As the commit message says, with this change we can start using devm_
functions and we will have less chances to make mistakes
Eg: no  more
- this cleanout belongs to uvc_register_video_device vs uvc_delete
- devm_ function fails because it is called too late

This patch fixes a class of bugs. I would really appreciate it if you
can review it.
I have moved it to its own patchset:
https://patchwork.linuxtv.org/project/linux-media/patch/20241105-uvc-rmrefcount-v1-1-123f56b01731@chromium.org/
I am planning to send more patches on top of it making use of devres


Regards!

>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 24 +++++-------------------
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 -
> >  2 files changed, 5 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index a96f6ca0889f..2735fccdf454 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1868,16 +1868,12 @@ static int uvc_scan_device(struct uvc_device *dev)
> >  /*
> >   * Delete the UVC device.
> >   *
> > - * Called by the kernel when the last reference to the uvc_device structure
> > - * is released.
> > - *
> > - * As this function is called after or during disconnect(), all URBs have
> > + * As this function is called during disconnect(), all URBs have
> >   * already been cancelled by the USB core. There is no need to kill the
> >   * interrupt URB manually.
> >   */
> > -static void uvc_delete(struct kref *kref)
> > +static void uvc_delete(struct uvc_device *dev)
> >  {
> > -     struct uvc_device *dev = container_of(kref, struct uvc_device, ref);
> >       struct list_head *p, *n;
> >
> >       uvc_status_cleanup(dev);
> > @@ -1919,14 +1915,6 @@ static void uvc_delete(struct kref *kref)
> >       kfree(dev);
> >  }
> >
> > -static void uvc_release(struct video_device *vdev)
> > -{
> > -     struct uvc_streaming *stream = video_get_drvdata(vdev);
> > -     struct uvc_device *dev = stream->dev;
> > -
> > -     kref_put(&dev->ref, uvc_delete);
> > -}
> > -
> >  /*
> >   * Unregister the video devices.
> >   */
> > @@ -2009,7 +1997,7 @@ int uvc_register_video_device(struct uvc_device *dev,
> >       vdev->v4l2_dev = &dev->vdev;
> >       vdev->fops = fops;
> >       vdev->ioctl_ops = ioctl_ops;
> > -     vdev->release = uvc_release;
> > +     vdev->release = video_device_release_empty;
> >       vdev->prio = &stream->chain->prio;
> >       if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT)
> >               vdev->vfl_dir = VFL_DIR_TX;
> > @@ -2045,7 +2033,6 @@ int uvc_register_video_device(struct uvc_device *dev,
> >               return ret;
> >       }
> >
> > -     kref_get(&dev->ref);
> >       return 0;
> >  }
> >
> > @@ -2160,7 +2147,6 @@ static int uvc_probe(struct usb_interface *intf,
> >       INIT_LIST_HEAD(&dev->entities);
> >       INIT_LIST_HEAD(&dev->chains);
> >       INIT_LIST_HEAD(&dev->streams);
> > -     kref_init(&dev->ref);
> >       atomic_set(&dev->nmappings, 0);
> >
> >       dev->udev = usb_get_dev(udev);
> > @@ -2300,7 +2286,7 @@ static int uvc_probe(struct usb_interface *intf,
> >
> >  error:
> >       uvc_unregister_video(dev);
> > -     kref_put(&dev->ref, uvc_delete);
> > +     uvc_delete(dev);
> >       return -ENODEV;
> >  }
> >
> > @@ -2319,7 +2305,7 @@ static void uvc_disconnect(struct usb_interface *intf)
> >               return;
> >
> >       uvc_unregister_video(dev);
> > -     kref_put(&dev->ref, uvc_delete);
> > +     uvc_delete(dev);
> >  }
> >
> >  static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 07f9921d83f2..feb8de640a26 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -578,7 +578,6 @@ struct uvc_device {
> >
> >       /* Video Streaming interfaces */
> >       struct list_head streams;
> > -     struct kref ref;
> >
> >       /* Status Interrupt Endpoint */
> >       struct usb_host_endpoint *int_ep;
> >
> > ---
> > base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
> > change-id: 20241105-uvc-rmrefcount-010d98d496c5
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

