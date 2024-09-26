Return-Path: <linux-kernel+bounces-339908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80299986C12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8E1F24F25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13371176231;
	Thu, 26 Sep 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTzke3Rq"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B501171C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328825; cv=none; b=IlEmmV7MwwJsVfGNJreM9MCD/vMTJvrVvuteWMjXNrWZBpKbbhlMh6/PO1YLPL6yIZw9LI0OBPH8PDApZfpg01g36QmDq7U1cuCORe4fOFiUk5MFRM2uYI5KcpC8tZ3qkXBRHQm1h69hrOZsKfYaf38N7k/CdiDHQf7rhLQcndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328825; c=relaxed/simple;
	bh=YbC4jWqkKUqySBlGJiLBNg14VzONLxp7za+XkZ2Kjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5R1tW1cZQxwkGn5hgPOhqYp3arSShH1o8IhMQTWkBamfJlQrSaeQI7gXkknXYxw6WN3AqZ6ujSJ7iXPlPnSJMGEtq9YGLJkMZcvnVJ+E8aNiXyRh36vvLZXPuk5EPGr/SamA97e70WKhP/IMoG1/aH5UEMO0MF6hnJoVL10IDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NTzke3Rq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so325396a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727328822; x=1727933622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIXNYxR8AP85uHThBvVIybLML7OEF9X+mqNWFeDgQd8=;
        b=NTzke3RqSqCKoCwIKiKLnI2RPjKrZzNKoPOJSfg3Y/K8Y0NfL3wE9oaIRcOu1nghoT
         dq58h9dgIGnwPVnreFAxmwcEroMuBCVtKbUnxxT4Wv9llbfXpy3Q31dTyhxx0DQlEhiO
         iYdwIgna+261EqcSf1D6IQtEJSA3+mWvT7n/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727328822; x=1727933622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIXNYxR8AP85uHThBvVIybLML7OEF9X+mqNWFeDgQd8=;
        b=Xrmbitk8LDTXwJR16hdQjwxC6ijofprPzYUBkGFbvoWxiXNdvNLmc7YzP3IuoBz+/b
         DtC3ZozSYpLorccc4HUBaX0GU47+1FAuLKahgdiP+3CsJK9gKGJzd5MndEChu9KSvfp+
         iF2AGTM4CVd6w36CG/KgRBkNrQCLepbfyJ6NWtXpSbLvNzqXI2VoJjEr8Mt+5bxaf9J5
         EcLcmMI97rrB/KFjofpOzDkQ6cpZdgkpift3S5Mk7JO34ERukUtMSoTRUN9iEg3dcmgq
         RNrdMDfZbjTH43k39DFS7hudarba0txdLt1nV2gqczss3ZC79ScO5X8O3WyGFVMmj8Yx
         RLKA==
X-Forwarded-Encrypted: i=1; AJvYcCVlJ5gEwFoLR05a/uW8ZLS9uykxb2+4TCtIVoOV8U+UfGpi8WHHxy5kaI7A0aY/+EvrStCtmn5ilW/HAuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKVkzbzGaGGOCebvEewTmznvZuDb47nKLceCm1pqaDkZPGwu0
	tyb8eC1AJ3wMlz2xNCx4aaj3V4j8eRvyPD9yTHdj6fX+4K9ovA0XhII71O0pv54mqIrGIjFTJVw
	=
X-Google-Smtp-Source: AGHT+IGFdc0pUvPLWPiH3utyVYuNGKUY2SluLXVqwEkNp9DtbN+iIwiP6utXNpHhjn5BlKj1c1x/pg==
X-Received: by 2002:a17:90b:4c04:b0:2da:88b3:d001 with SMTP id 98e67ed59e1d1-2e06ae7a972mr5382653a91.18.1727328822152;
        Wed, 25 Sep 2024 22:33:42 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e21fd9asm2452890a91.33.2024.09.25.22.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 22:33:40 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2053525bd90so4774445ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:33:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmrgHmuDPXvdgrn7Fhb/xZzrk7KlkkYByU0DSkeLgPeQF6nWJVIeFLpfq2QcaN6sTPJOjvqDKXDi/0LU0=@vger.kernel.org
X-Received: by 2002:a17:903:1245:b0:206:ae39:9f4 with SMTP id
 d9443c01a7336-20afc440f9bmr82421225ad.20.1727328819818; Wed, 25 Sep 2024
 22:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
 <20240614-guenter-mini-v6-2-7b7fdc3b21b3@chromium.org> <20240925191537.GB30399@pendragon.ideasonboard.com>
In-Reply-To: <20240925191537.GB30399@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Sep 2024 07:33:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCvOMV6J1cTnGdmnsUCzj=N9vXNFVSm6LQC8LfOCNPu9=Q@mail.gmail.com>
Message-ID: <CANiDSCvOMV6J1cTnGdmnsUCzj=N9vXNFVSm6LQC8LfOCNPu9=Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] media: uvcvideo: Refactor the status irq API
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Tomasz Figa <tfiga@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Wed, 25 Sept 2024 at 21:15, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Fri, Jun 14, 2024 at 12:41:28PM +0000, Ricardo Ribalda wrote:
> > There are two different use-cases of uvc_status():
>
> I'd add a blank line here, and remove the leading tabs from the next two
> lines.
>
> >       - adding/removing a user when the camera is open/closed
> >       - stopping/starting when the camera is suspended/resumed
> >
> > Make the API reflect these two use-cases and move all the refcounting
> > and locking logic to the uvc_status.c file.
>
> If my understanding is correct, this doesn't introduce any functional
> change, and is not a dependency of further patches in the series. I
> don't have a strong opinion on the refactoring itself, so I'm fine with
> it, but I'd like a mention in the commit message that no functional
> change is introduced.
>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 13 ++-------
> >  drivers/media/usb/uvc/uvc_status.c | 55 ++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c   | 22 +++++----------
> >  drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
> >  4 files changed, 67 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 55132688e363..c8c0352af1e5 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2135,7 +2135,6 @@ static int uvc_probe(struct usb_interface *intf,
> >       INIT_LIST_HEAD(&dev->streams);
> >       kref_init(&dev->ref);
> >       atomic_set(&dev->nmappings, 0);
> > -     mutex_init(&dev->lock);
> >
> >       dev->udev = usb_get_dev(udev);
> >       dev->intf = usb_get_intf(intf);
> > @@ -2301,10 +2300,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
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
> > @@ -2335,12 +2331,7 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
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
> > index a78a88c710e2..375a95dd3011 100644
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
> > +static int __uvc_status_start(struct uvc_device *dev, gfp_t flags)
>
> Do we need a double underscore prefix here and for the stop() function ?
>
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
> > +static void __uvc_status_stop(struct uvc_device *dev)
> >  {
> >       struct uvc_ctrl_work *w = &dev->async_ctrl;
> >
> > +     lockdep_assert_held(&dev->status_lock);
> > +
> >       /*
> >        * Prevent the asynchronous control handler from requeing the URB. The
> >        * barrier is needed so the flush_status change is visible to other
> > @@ -350,3 +356,48 @@ void uvc_status_stop(struct uvc_device *dev)
> >        */
> >       smp_store_release(&dev->flush_status, false);
> >  }
> > +
> > +int uvc_status_resume(struct uvc_device *dev)
> > +{
> > +     int ret = 0;
> > +
> > +     mutex_lock(&dev->status_lock);
> > +     if (dev->status_users)
> > +             ret = __uvc_status_start(dev, GFP_NOIO);
> > +     mutex_unlock(&dev->status_lock);
> > +
> > +     return ret;
>
> Now that we have scoped guards, this can be written as
>
>         guard(mutex)(&dev->status_lock);
>
>         if (!dev->status_users)
>                 return 0;
>
>         return __uvc_status_start(dev, GFP_NOIO);
>
> > +}
> > +
> > +void uvc_status_suspend(struct uvc_device *dev)
> > +{
> > +     mutex_lock(&dev->status_lock);
> > +     if (dev->status_users)
> > +             __uvc_status_stop(dev);
> > +     mutex_unlock(&dev->status_lock);
>
>         guard(mutex)(&dev->status_lock);
>
>         if (dev->status_users)
>                 __uvc_status_stop(dev);
>
> Same below.
>
> > +}
> > +
> > +int uvc_status_get(struct uvc_device *dev)
> > +{
> > +     int ret = 0;
> > +
> > +     mutex_lock(&dev->status_lock);
> > +     if (!dev->status_users)
> > +             ret = __uvc_status_start(dev, GFP_KERNEL);
> > +     if (!ret)
> > +             dev->status_users++;
> > +     mutex_unlock(&dev->status_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +void uvc_status_put(struct uvc_device *dev)
> > +{
> > +     mutex_lock(&dev->status_lock);
> > +     if (dev->status_users == 1)
> > +             __uvc_status_stop(dev);
> > +     WARN_ON(!dev->status_users);
>
> Is this needed, or could we keep the original code ?
>
>         if (--dev->status_users == 0)
>                 __uvc_status_stop(dev);

I'd prefer to keep the code. When I was playing with the granular PM
it was very nice to display a WARN and make sure that status_users was
never underflowed.


>
> All those comments are quite minor, the next version will have my R-b.
>
> > +     if (dev->status_users)
> > +             dev->status_users--;
> > +     mutex_unlock(&dev->status_lock);
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
> > index 6fb0a78b1b00..00b600eb058c 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -555,8 +555,6 @@ struct uvc_device {
> >
> >       const struct uvc_device_info *info;
> >
> > -     struct mutex lock;              /* Protects users */
> > -     unsigned int users;
> >       atomic_t nmappings;
> >
> >       /* Video control interface */
> > @@ -578,6 +576,8 @@ struct uvc_device {
> >       struct usb_host_endpoint *int_ep;
> >       struct urb *int_urb;
> >       struct uvc_status *status;
> > +     struct mutex status_lock; /* Protects status_users */
> > +     unsigned int status_users;
> >       bool flush_status;
> >
> >       struct input_dev *input;
> > @@ -744,8 +744,10 @@ int uvc_register_video_device(struct uvc_device *dev,
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
> >  extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

