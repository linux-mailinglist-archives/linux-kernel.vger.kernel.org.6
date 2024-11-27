Return-Path: <linux-kernel+bounces-423310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75E9DA5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E09B165CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EF196C6C;
	Wed, 27 Nov 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhyNTsUe"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0962195FD1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703045; cv=none; b=LtUVjFMFdyTZCyvBOMQiHAiYqga+ndT9rLwhbD0hJOdpCga4eOvI64ea18ikYyGZOutf58EPWL8IUQ5RABL3WD1pFgsZ0Uv0QGgfPwe0XIaIZghjlIXzpbS+AHdIg0P0Ly+i/aAKDHdPSN6xk7+vGP314LbiFdT8idy68gPxHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703045; c=relaxed/simple;
	bh=s/29r5n/PffnCPwFdcBMy5Ksy9kXK58eqgRjZWRApcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omUG/aabSbg73HtGU63GqnQy/cALMwk93KKarvnpmr4SQ1CY3AnbFroXZ/Jk3HC6e17nc4a6Je+XiJAAVs7BAYDeIha8vWKNssiPE/ZQtmYngmO8dAm3mk8p2wgsHtYKyVTNMQmu9FvZySPE+4nkT7qCmboOaOymn0+tTPnR2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mhyNTsUe; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-296bf028170so2483484fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732703042; x=1733307842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0bQ1CUfBZuSK4RB9yLrSNIGe1uMoD/kYv5gCJtf/9U=;
        b=mhyNTsUeK1aU63Gc2rzIlCwgjHY4WYFbrkCaz0tW0miNZGQAsng7YvW815e+krHGLJ
         Kh6FzSr0+DYpXxK/oMf8+qlO6m6s/5OsODrMdahrK1Cp4FkJNqVXSQe1pi4i3yPPAVj7
         tCoxNov4Uv5EzOlSnRkWwFr44U5kMfofhmdu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732703042; x=1733307842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0bQ1CUfBZuSK4RB9yLrSNIGe1uMoD/kYv5gCJtf/9U=;
        b=lpI6E7b/ljqw0DitKSawEEtCDE60lzk3XXvavxio48hz4cvGqX3Oqr0IB9/g1Y2hqn
         9dFAEZark6vY8a44MyO4aZUI/3JjZZL0w9Q0YSLuafgSNtHJLPGqO0+JqHlNd58bU57m
         Kh1QD3Y8/nC+gruGpT78aNRSp6v04MrZDzrnxqYp0sEs5gDJ2he1ZT6ad2D9tm/AnI3g
         lc6RzGL4N3dRj/n9ny2YYpx/GWFiaxrNl+95OLyfkXsc2dViKxCNKTreBHN+ZY16O/l0
         wa/ZUa2cK6aOehskP9L7IG1dP5Qfg78SItOnb6Sgg+wU7tSXndC92dG1Kj7MhlJTkhx8
         iyVg==
X-Forwarded-Encrypted: i=1; AJvYcCWfkGHVfEXURuNbhVP4cfi/6C6LJDmXp5Jv5VCnyhOvN8AJOxQMVZoVm1PA2KSQSX2ufzeiNmQQmLaJL5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5s+AwRDT0MyMKmb7X5bKULTotdkWyQM7n3yKLC9HohQrv10S/
	2KaTuHmH+gFApJQuDxVx7yBn+L1dEyie7zoDaxyHTDj7DA6iBC5vHsBqDH+7sEmlbPsn+gkV5hc
	=
X-Gm-Gg: ASbGncvZal7Vbno4qPjqm02oG1UVPSsLW2BGLPWOYiWCV935K0XpuA91mLbtp/TJZSY
	9v4GXbKhiKIyEEd2vuG9wAO/Wlie2zwfiFBYJW8Wc+gy3YUo7iqFJNv3aw24XLqRnik+Zwlshze
	TCSBLL+XyzSg66ByBwPkZ9iqrjBXqG/A8mOIf7jp73Tz4CvB9l0tZjNuyEloTLFmjmDiXpHfgk2
	PlAwGBYuKVP2ng839o7cCWrdPSw1X/KtBZkH3F5UFQejcJXt8cLCqk9lmWYTKBzrVa69BrnqTp8
	QG0Yls/pAefH
X-Google-Smtp-Source: AGHT+IGS99rFjs63+p5M/mPCjXjeP9TSQY2W8qYOK3bPTMzWoNjQ8bC1LZazecNe8uGqOR3363cwGA==
X-Received: by 2002:a05:6871:5e06:b0:277:d8ee:6dda with SMTP id 586e51a60fabf-29dc4198fb1mr2355195fac.23.1732703042362;
        Wed, 27 Nov 2024 02:24:02 -0800 (PST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29724490f17sm4622533fac.6.2024.11.27.02.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 02:24:01 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29687cd1924so3617917fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:24:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxdKSpWAQFv7nt/MsM2HohRyzETHOEZmpIsBK9BV/iIbe+zn8hk6Bu3POOZTF+0pm30u10ly2wvBCHec4=@vger.kernel.org
X-Received: by 2002:a05:6808:1b0a:b0:3e7:b956:976f with SMTP id
 5614622812f47-3ea6dbc8c56mr3367948b6e.11.1732703039945; Wed, 27 Nov 2024
 02:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-2-eb8722531b8c@chromium.org> <20241127093506.GE31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127093506.GE31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 11:23:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCtAxfnKbfEBedaDMvMJX49axeENp=gYPF65pKtgt5_XcQ@mail.gmail.com>
Message-ID: <CANiDSCtAxfnKbfEBedaDMvMJX49axeENp=gYPF65pKtgt5_XcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 07:46:11AM +0000, Ricardo Ribalda wrote:
> > When an async control is written, we copy a pointer to the file handle
> > that started the operation. That pointer will be used when the device is
> > done. Which could be anytime in the future.
> >
> > If the user closes that file descriptor, its structure will be freed,
> > and there will be one dangling pointer per pending async control, that
> > the driver will try to use.
> >
> > Clean all the dangling pointers during release().
> >
> > To avoid adding a performance penalty in the most common case (no async
> > operation). A counter has been introduced with some logic to make sure
> > that it is properly handled.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  3 +++
> >  3 files changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 5d3a28edf7f0..51a53ad25e9c 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >       mutex_lock(&chain->ctrl_mutex);
> >
> >       handle = ctrl->handle;
> > -     ctrl->handle = NULL;
> > +     if (handle) {
> > +             ctrl->handle = NULL;
> > +             WARN_ON(!handle->pending_async_ctrls);
> > +             if (handle->pending_async_ctrls)
> > +                     handle->pending_async_ctrls--;
> > +     }
>
> There's at least one other location where ctrl->handle is reset to NULL.

That assignment is not needed. I added a patch to remove it in the next version.

>
> >
> >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       mapping->set(mapping, value,
> >               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> > -     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > +     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > +             if (!ctrl->handle)
> > +                     handle->pending_async_ctrls++;
> >               ctrl->handle = handle;
>
> Is this protected by ctrl_mutex ?

yes, uvc_ctrl_set is only called by uvc_ioctl_s_try_ext_ctrls that
calls uvc_ctrl_begin

I will send another patch to add an annotation to the function to make
it explicit.

>
> Please be careful about locking and race conditions, taking the time to
> double check will help getting your patches merged faster.
>
> > +     }
> >
> >       ctrl->dirty = 1;
> >       ctrl->modified = 1;
> > @@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >       return 0;
> >  }
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > +{
> > +     struct uvc_entity *entity;
> > +
> > +     guard(mutex)(&handle->chain->ctrl_mutex);
> > +
> > +     if (!handle->pending_async_ctrls)
> > +             return;
> > +
> > +     list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > +             int i;
>
> unsigned int
>
> I wonder if these days you could event write
>
>                 for (unsigned int i = 0; i < entity->ncontrols; ++i) {
>
> > +
> > +             for (i = 0; i < entity->ncontrols; ++i) {
> > +                     struct uvc_control *ctrl = &entity->controls[i];
> > +
> > +                     if (!ctrl->handle || ctrl->handle != handle)
>
> Given that handle can't be null, you can write
>
>                         if (ctrl->handle != handle)
>
> > +                             continue;
> > +
> > +                     ctrl->handle = NULL;
> > +                     if (WARN_ON(!handle->pending_async_ctrls))
> > +                             continue;
>
> Is this needed ? If we find more controls for this handle than
> pending_async_ctrls, decrementing it below 0 will case the WARN_ON() at
> the end of this function to trigger, isn't that enough ?

I want to know if the warning is triggered because I have too many
pending_async_ctrls or too little.


>
> > +                     handle->pending_async_ctrls--;
> > +             }
> > +     }
> > +
> > +     WARN_ON(handle->pending_async_ctrls);
> > +}
> > +
> >  /*
> >   * Cleanup device controls.
> >   */
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 97c5407f6603..b425306a3b8c 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
> >
> >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> >
> > +     uvc_ctrl_cleanup_fh(handle);
> > +
> >       /* Only free resources if this is a privileged handle. */
> >       if (uvc_has_privileges(handle))
> >               uvc_queue_release(&stream->queue);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 07f9921d83f2..2f8a9c48e32a 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -612,6 +612,7 @@ struct uvc_fh {
> >       struct uvc_video_chain *chain;
> >       struct uvc_streaming *stream;
> >       enum uvc_handle_state state;
> > +     unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
>
> The kernel does it the other way around, it lists in the documentation
> of the lock what data it protects.
>
> >  };
> >
> >  struct uvc_driver {
> > @@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                     struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                           u8 epaddr);
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

