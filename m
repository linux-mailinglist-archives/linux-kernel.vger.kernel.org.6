Return-Path: <linux-kernel+bounces-341314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1B987E21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8482B1F23463
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA315DBDD;
	Fri, 27 Sep 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGwdcjX7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B32E630
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417372; cv=none; b=nt7encVEWnxyG56QkpjyDfwgk5j7IdkeHp8GmE1x6YMhf8pZ5yZTerO4EOpBGTzKb+8RYuFb+c0S82w9TgOmucLRi0pZf0PVUtvh+kLsM4lgWVh86V25DN4SqEtDjtpRUr/v74IknWldcNTId0GjrmjhIyHw2blEEfa3IZofv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417372; c=relaxed/simple;
	bh=Kx9p7KAXHEb1W87nvLBVV7UJ9XGp3iPC5gxdEK1znf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNZKmDPp19uaBNLEHJwlpNHtxE1jhGRMni/8BjcnCFZm7P1j+EvICGpUIb9wwVBcikTTiFpuOgEYW5LBl0vITkZ+KdSWh27pZY3fawI3tQBo5POHGfIqgSoT7D3LMZF+CRRgBKkEPCrV4qtFWKr40Bh3rWjcTOyvCfdyHshNo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGwdcjX7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71b20ffd809so963301b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727417370; x=1728022170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmOMe5qK2Lg+Es6RT+a0fd+2XWPUEHna9V7jTHkY51o=;
        b=AGwdcjX7LlcF4bM/dAD24NOQUVQOvtzAfB1YIpfe5rUIMQKKhdcYuZJO69sH4zts1p
         57h+APPHK2mtOuGMUhNqCMzus8R5P+YBuA+xcTiVLGPZ21gaCKXos5HM+trfkX4VZyTB
         BZ1418vBVLtvtfUl8NK3Z2N1iv9JcRU9ogBi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727417370; x=1728022170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmOMe5qK2Lg+Es6RT+a0fd+2XWPUEHna9V7jTHkY51o=;
        b=rvZBSRlKkm6/1w1vbpDV/tZBWWslmnSidiWnDXdqRdyrb8I824yI9Nn2UfRn++5Rp5
         0+QwcloIHVoCWL+XQin0GxuxgbKvuXu6M4LLJCgIxzahT+B3w9dq2vwjtcGi8i6D6FYa
         +mCTsEPNgnWe+ECCVuRwT/lgS7jqWsf+dZ+zWemFv8axL65l1GwrbH6mFqnJctOlmyQJ
         bdg4jhe7U0NZMdAfOg9llYqPJjao+amC/oK4FMn3wFNCZKRA6R/hJCGdMc+C2c/QXKpI
         pnw09DQ6EJQLwLID+D3xNIpJx3UCWyA0TWgIBNwr4E+RL3ZW/xr8Xuadqygx+hrGsvvE
         qb+w==
X-Forwarded-Encrypted: i=1; AJvYcCUVLfg/8Ne9QgTV226cLEezL3YKXgeh1V7TLULi39JMYJ5obH2ZbPudYV2MgF/VJXgAcjDVxt7ObRhD39I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrE1R1mjjE1a10kcO+Ueuu+wbCSNB2jeLpRFCSKJ4tO85FiI7
	LiaOBeBIRvx7Z32Y+hzkb7rncR6ntiv1t61Y51NMDOtZ1NaLC03Thz5mptjcPqye9bskc8DZNNU
	=
X-Google-Smtp-Source: AGHT+IHyOVcjHgewFu4p+cFz+Z16jiM8V733q+Yes8ioPcLC4HQziwTRRktk+ISSoVsFWvpRPG5OlA==
X-Received: by 2002:a05:6a20:b58b:b0:1d3:de2:e7b4 with SMTP id adf61e73a8af0-1d4fa67c622mr2981243637.11.1727417370099;
        Thu, 26 Sep 2024 23:09:30 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5ed0e9sm859269a12.57.2024.09.26.23.09.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 23:09:28 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7178df70f28so1493024b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:09:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwtRBoVOSrexEC2vwmP98DkzJ248GFu2WA13OPH2C3Lju2ESJxtlvd4k60GPAVIroqGTCCtj8BR8u8p4w=@vger.kernel.org
X-Received: by 2002:a05:6a00:14c6:b0:714:241d:a323 with SMTP id
 d2e1a72fcca58-71b26057a1fmr4051856b3a.17.1727417367137; Thu, 26 Sep 2024
 23:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-guenter-mini-v7-0-690441953d4a@chromium.org>
 <20240926-guenter-mini-v7-1-690441953d4a@chromium.org> <20240926143940.GI21788@pendragon.ideasonboard.com>
In-Reply-To: <20240926143940.GI21788@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 27 Sep 2024 08:09:11 +0200
X-Gmail-Original-Message-ID: <CANiDSCvObXTU7kFAXqY5_Jz0BQayZDuV1ozwMTW8zC3FyRoo6g@mail.gmail.com>
Message-ID: <CANiDSCvObXTU7kFAXqY5_Jz0BQayZDuV1ozwMTW8zC3FyRoo6g@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] media: uvcvideo: Refactor the status irq API
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Tomasz Figa <tfiga@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Thu, 26 Sept 2024 at 16:39, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Thu, Sep 26, 2024 at 05:49:57AM +0000, Ricardo Ribalda wrote:
> > There are two different use-cases of uvc_status():
> >
> > - adding/removing a user when the camera is open/closed
> > - stopping/starting when the camera is suspended/resumed
> >
> > Make the API reflect these two use-cases and move all the refcounting
> > and locking logic to the uvc_status.c file.
> >
> > No functional change is expected from this patch.
> >
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 13 ++--------
> >  drivers/media/usb/uvc/uvc_status.c | 53 ++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c   | 22 +++++-----------
> >  drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
> >  4 files changed, 65 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index f0febdc08c2d..31e8942f1ef8 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
> >       INIT_LIST_HEAD(&dev->streams);
> >       kref_init(&dev->ref);
> >       atomic_set(&dev->nmappings, 0);
> > -     mutex_init(&dev->lock);
> >
> >       dev->udev = usb_get_dev(udev);
> >       dev->intf = usb_get_intf(intf);
> > @@ -2288,10 +2287,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
> >       /* Controls are cached on the fly so they don't need to be saved. */
> >       if (intf->cur_altsetting->desc.bInterfaceSubClass ==
> >           UVC_SC_VIDEOCONTROL) {
> > -             mutex_lock(&dev->lock);
> > -             if (dev->users)
> > -                     uvc_status_stop(dev);
> > -             mutex_unlock(&dev->lock);
> > +             uvc_status_suspend(dev);
> >               return 0;
> >       }
> >
> > @@ -2322,12 +2318,7 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
> >                               return ret;
> >               }
> >
> > -             mutex_lock(&dev->lock);
> > -             if (dev->users)
> > -                     ret = uvc_status_start(dev, GFP_NOIO);
> > -             mutex_unlock(&dev->lock);
> > -
> > -             return ret;
> > +             return uvc_status_resume(dev);
> >       }
> >
> >       list_for_each_entry(stream, &dev->streams, list) {
> > diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> > index a78a88c710e2..e438ae5af2e8 100644
> > --- a/drivers/media/usb/uvc/uvc_status.c
> > +++ b/drivers/media/usb/uvc/uvc_status.c
> > @@ -257,6 +257,8 @@ int uvc_status_init(struct uvc_device *dev)
> >       unsigned int pipe;
> >       int interval;
> >
> > +     mutex_init(&dev->status_lock);
> > +
> >       if (ep == NULL)
> >               return 0;
> >
> > @@ -302,18 +304,22 @@ void uvc_status_cleanup(struct uvc_device *dev)
> >       kfree(dev->status);
> >  }
> >
> > -int uvc_status_start(struct uvc_device *dev, gfp_t flags)
> > +static int uvc_status_start(struct uvc_device *dev, gfp_t flags)
> >  {
> > +     lockdep_assert_held(&dev->status_lock);
> > +
> >       if (dev->int_urb == NULL)
> >               return 0;
> >
> >       return usb_submit_urb(dev->int_urb, flags);
> >  }
> >
> > -void uvc_status_stop(struct uvc_device *dev)
> > +static void uvc_status_stop(struct uvc_device *dev)
> >  {
> >       struct uvc_ctrl_work *w = &dev->async_ctrl;
> >
> > +     lockdep_assert_held(&dev->status_lock);
> > +
> >       /*
> >        * Prevent the asynchronous control handler from requeing the URB. The
> >        * barrier is needed so the flush_status change is visible to other
> > @@ -350,3 +356,46 @@ void uvc_status_stop(struct uvc_device *dev)
> >        */
> >       smp_store_release(&dev->flush_status, false);
> >  }
> > +
> > +int uvc_status_resume(struct uvc_device *dev)
> > +{
> > +     guard(mutex)(&dev->status_lock);
> > +
> > +     if (dev->status_users)
> > +             return  uvc_status_start(dev, GFP_NOIO);
>
> Double space afer return. I'll fix when applying.
>
> > +
> > +     return 0;
> > +}
> > +
> > +void uvc_status_suspend(struct uvc_device *dev)
> > +{
> > +     guard(mutex)(&dev->status_lock);
> > +
> > +     if (dev->status_users)
> > +             uvc_status_stop(dev);
> > +}
> > +
> > +int uvc_status_get(struct uvc_device *dev)
> > +{
> > +     int ret = 0;
> > +
> > +     guard(mutex)(&dev->status_lock);
> > +
> > +     if (!dev->status_users)
> > +             ret = uvc_status_start(dev, GFP_KERNEL);
> > +     if (!ret)
> > +             dev->status_users++;
>
> Thanks for the scoped guard, we can write
>
>         if (!dev->status_users) {
>                 int ret = uvc_status_start(dev, GFP_KERNEL);
>                 if (ret)
>                         return ret;
>         }
>
>         dev->status_users++;
>
>         return 0;
>
> which I think is nicer to read. If that's fine with you I'll do this
> locally, not need to a new version.

Thanks! indeed it looks nicer :)
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +
> > +     return ret;
> > +}
> > +
> > +void uvc_status_put(struct uvc_device *dev)
> > +{
> > +     guard(mutex)(&dev->status_lock);
> > +
> > +     if (dev->status_users == 1)
> > +             uvc_status_stop(dev);
> > +     WARN_ON(!dev->status_users);
> > +     if (dev->status_users)
> > +             dev->status_users--;
> > +}
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index f4988f03640a..97c5407f6603 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -628,20 +628,13 @@ static int uvc_v4l2_open(struct file *file)
> >               return -ENOMEM;
> >       }
> >
> > -     mutex_lock(&stream->dev->lock);
> > -     if (stream->dev->users == 0) {
> > -             ret = uvc_status_start(stream->dev, GFP_KERNEL);
> > -             if (ret < 0) {
> > -                     mutex_unlock(&stream->dev->lock);
> > -                     usb_autopm_put_interface(stream->dev->intf);
> > -                     kfree(handle);
> > -                     return ret;
> > -             }
> > +     ret = uvc_status_get(stream->dev);
> > +     if (ret) {
> > +             usb_autopm_put_interface(stream->dev->intf);
> > +             kfree(handle);
> > +             return ret;
> >       }
> >
> > -     stream->dev->users++;
> > -     mutex_unlock(&stream->dev->lock);
> > -
> >       v4l2_fh_init(&handle->vfh, &stream->vdev);
> >       v4l2_fh_add(&handle->vfh);
> >       handle->chain = stream->chain;
> > @@ -670,10 +663,7 @@ static int uvc_v4l2_release(struct file *file)
> >       kfree(handle);
> >       file->private_data = NULL;
> >
> > -     mutex_lock(&stream->dev->lock);
> > -     if (--stream->dev->users == 0)
> > -             uvc_status_stop(stream->dev);
> > -     mutex_unlock(&stream->dev->lock);
> > +     uvc_status_put(stream->dev);
> >
> >       usb_autopm_put_interface(stream->dev->intf);
> >       return 0;
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index b7d24a853ce4..07f9921d83f2 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -563,8 +563,6 @@ struct uvc_device {
> >
> >       const struct uvc_device_info *info;
> >
> > -     struct mutex lock;              /* Protects users */
> > -     unsigned int users;
> >       atomic_t nmappings;
> >
> >       /* Video control interface */
> > @@ -586,6 +584,8 @@ struct uvc_device {
> >       struct usb_host_endpoint *int_ep;
> >       struct urb *int_urb;
> >       struct uvc_status *status;
> > +     struct mutex status_lock; /* Protects status_users */
> > +     unsigned int status_users;
> >       bool flush_status;
> >
> >       struct input_dev *input;
> > @@ -752,8 +752,10 @@ int uvc_register_video_device(struct uvc_device *dev,
> >  int uvc_status_init(struct uvc_device *dev);
> >  void uvc_status_unregister(struct uvc_device *dev);
> >  void uvc_status_cleanup(struct uvc_device *dev);
> > -int uvc_status_start(struct uvc_device *dev, gfp_t flags);
> > -void uvc_status_stop(struct uvc_device *dev);
> > +int uvc_status_resume(struct uvc_device *dev);
> > +void uvc_status_suspend(struct uvc_device *dev);
> > +int uvc_status_get(struct uvc_device *dev);
> > +void uvc_status_put(struct uvc_device *dev);
> >
> >  /* Controls */
> >  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

