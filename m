Return-Path: <linux-kernel+bounces-425072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11E9DBD20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2190281C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4B1C3F27;
	Thu, 28 Nov 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="chqbx4g/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDC1C3041
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827421; cv=none; b=FAFifqzTbVr0VkhqYXYtj3JIxUThRi4rwQCMavVjror13v7pWzvD/69DwRPMEAHNC+bLRN+sg7E97tcvcyX8P9tm4mJtXDv9wN3MgM/oKG99mzLfyxOLCy3tClHLOnzDtqvk84agL2Jjmol8o5Ey4NNCtGloI7stxzRHACV+/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827421; c=relaxed/simple;
	bh=Q4Tfi5Qfqy25dRIC9gKGMmWxUW4s/pk/KYi8auysg9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBdXPtAqrPSu0QmRG8CzucyKAR4QIvrXbhxvcGOkVtqm3Z/Xl0aYl2jCue+TRmHqL5lo/G3zi0V8QtGs+MQZlHRPANiUQF4l/fzyGww+BlbuHsfWUhn10AEEZw++lJsHI4bcYiSkNyqgB5s7aEmFng66f+4vh0pwTGGLlml2/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=chqbx4g/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so950141a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732827419; x=1733432219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TrNpATxGIaM9NuuyjevUaLUjPIqRHdht58keqytoI2A=;
        b=chqbx4g/lEwPGinlhMe8SDVBRNiKWCaG6nPPdhYlB2zHkICda14x7QKmGKcDiZBAF0
         mA3oX7I6wA17EASwTRfQTovYLcVPnmAVdiUeZSTu30xSy+R7MhZGAUfwUNKiTT1Sez67
         bkPqyJSWdby4S0TMO/ZOaizHO/8vq3m1huKwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827419; x=1733432219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrNpATxGIaM9NuuyjevUaLUjPIqRHdht58keqytoI2A=;
        b=Wela2g3rsHl9H6wDF5qVP+Z7cvrXmW//UQs531CKBn/ES6XvpOaT7TS/Bb+0kZbQpn
         7Ter92Oxeu+zXymfbbobfg8rzdY86wTOcQoZtz5s/aXBmE8bR7go/B9CTGPEDqDmUTf6
         HwG9yxP7i0GAoQ22sXJlBl3/BLNvfbt5eOg7fTd4insYu0CUfhNDkKundSDck5k0ZWqn
         2zEfkP0q5VxJKDed9TTUHvTEgyS2tsxiKntaVkNMobmHi5gLY9CEG6ed+9HX6mY4padM
         tzwOr0lwEZLUl8lF7OcOo/qqgoEufWpYRQFtiAZnYMlYCynJbRfStoNyYmyL9UEa9UXg
         if2g==
X-Forwarded-Encrypted: i=1; AJvYcCWts6Ee0OrMEC223QZrjdLPLyg6hUR7ygYhn5JAq5H797ORYvkKroyehT7vhlkXVVeK+ttrGKLAQvFS1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywln9RS4UOMtIaPmxr+pG1qrrt/uAkPhybG6L/kTY3Yn3Pq8SXu
	VSlVnHllQBZeJLx6y4MJ9xDyQWDwrrsDyMhuKqHkjCk2T+KI20/6cN7VRDvNrogKHJYrLBUNO9c
	=
X-Gm-Gg: ASbGnct6tjR19abR7h4sM6dIMQUC8DZWIP98c95iTt0DgDkq0x+si17Hn0bq9nbVQEW
	W49YIodgfWYbVUTr7a/g3MRqWIVCl1epRKpy0Ei3MsrleHOo8EMDRNwPmH5+/6vnBdMUekLhBgb
	x7eGX5u/ooPKz4AlJFADtz03yeg89fNzmOF9YeVq81g5vOUfgira8YnPesk99HK7LUeHNTi7rpo
	PBNJ2zNgVFnOW9eyvv1wqSNWLeYcLUG0v/pjjsWM7cRYzC5duVx1N2SXMmf9z41n5B+yzxRWF7V
	Dy2UhmK4Du7J6KMG
X-Google-Smtp-Source: AGHT+IEIdh3GZwbOYbcan1cyzBjR1AVZ0u3idvaOu/hJpABV0cSVt2VaEO1YVWXnPHbC2FN/d+SpPQ==
X-Received: by 2002:a17:90b:3b41:b0:2ea:5c01:c1ba with SMTP id 98e67ed59e1d1-2ee097bd261mr9807297a91.23.1732827419454;
        Thu, 28 Nov 2024 12:56:59 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa66e9fsm3925562a91.29.2024.11.28.12.56.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 12:56:57 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1132685b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:56:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7mVPrdgUQ81ozH7iiXiFVii8HqAVvC/xH4HWMT8A/2tmKNGbwYLy0s+rOr8q9t4AIJDGen8ZlUXbs7cQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:8c9:b0:71e:6c67:2ebf with SMTP id
 d2e1a72fcca58-72530035bcfmr11554555b3a.11.1732827416684; Thu, 28 Nov 2024
 12:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-2-eb8722531b8c@chromium.org> <20241127093506.GE31095@pendragon.ideasonboard.com>
 <CANiDSCtAxfnKbfEBedaDMvMJX49axeENp=gYPF65pKtgt5_XcQ@mail.gmail.com> <20241128205130.GC25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128205130.GC25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 21:56:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCutaABNtchncmJcuBC+F43Rh4Yg39D_5FXNPu=1AfPXZA@mail.gmail.com>
Message-ID: <CANiDSCutaABNtchncmJcuBC+F43Rh4Yg39D_5FXNPu=1AfPXZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 21:51, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 27, 2024 at 11:23:48AM +0100, Ricardo Ribalda wrote:
> > On Wed, 27 Nov 2024 at 10:35, Laurent Pinchart wrote:
> > > On Wed, Nov 27, 2024 at 07:46:11AM +0000, Ricardo Ribalda wrote:
> > > > When an async control is written, we copy a pointer to the file handle
> > > > that started the operation. That pointer will be used when the device is
> > > > done. Which could be anytime in the future.
> > > >
> > > > If the user closes that file descriptor, its structure will be freed,
> > > > and there will be one dangling pointer per pending async control, that
> > > > the driver will try to use.
> > > >
> > > > Clean all the dangling pointers during release().
> > > >
> > > > To avoid adding a performance penalty in the most common case (no async
> > > > operation). A counter has been introduced with some logic to make sure
> > > > that it is properly handled.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> > > >  drivers/media/usb/uvc/uvcvideo.h |  3 +++
> > > >  3 files changed, 43 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 5d3a28edf7f0..51a53ad25e9c 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> > > >       mutex_lock(&chain->ctrl_mutex);
> > > >
> > > >       handle = ctrl->handle;
> > > > -     ctrl->handle = NULL;
> > > > +     if (handle) {
> > > > +             ctrl->handle = NULL;
> > > > +             WARN_ON(!handle->pending_async_ctrls);
> > > > +             if (handle->pending_async_ctrls)
> > > > +                     handle->pending_async_ctrls--;
> > > > +     }
> > >
> > > There's at least one other location where ctrl->handle is reset to NULL.
> >
> > That assignment is not needed. I added a patch to remove it in the next version.
> >
> > > >
> > > >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> > > >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > > > @@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >       mapping->set(mapping, value,
> > > >               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> > > >
> > > > -     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > > > +     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > > > +             if (!ctrl->handle)
> > > > +                     handle->pending_async_ctrls++;
> > > >               ctrl->handle = handle;
> > >
> > > Is this protected by ctrl_mutex ?
> >
> > yes, uvc_ctrl_set is only called by uvc_ioctl_s_try_ext_ctrls that
> > calls uvc_ctrl_begin
>
> You're right. I think I figured out after writing this part of the
> review, and forgot to delete it. Sorry.
>
> > I will send another patch to add an annotation to the function to make
> > it explicit.
> >
> > > Please be careful about locking and race conditions, taking the time to
> > > double check will help getting your patches merged faster.
> > >
> > > > +     }
> > > >
> > > >       ctrl->dirty = 1;
> > > >       ctrl->modified = 1;
> > > > @@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> > > >       return 0;
> > > >  }
> > > >
> > > > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > > > +{
> > > > +     struct uvc_entity *entity;
> > > > +
> > > > +     guard(mutex)(&handle->chain->ctrl_mutex);
> > > > +
> > > > +     if (!handle->pending_async_ctrls)
> > > > +             return;
> > > > +
> > > > +     list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > > > +             int i;
> > >
> > > unsigned int
> > >
> > > I wonder if these days you could event write
> > >
> > >                 for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > >
> > > > +
> > > > +             for (i = 0; i < entity->ncontrols; ++i) {
> > > > +                     struct uvc_control *ctrl = &entity->controls[i];
> > > > +
> > > > +                     if (!ctrl->handle || ctrl->handle != handle)
> > >
> > > Given that handle can't be null, you can write
> > >
> > >                         if (ctrl->handle != handle)
> > >
> > > > +                             continue;
> > > > +
> > > > +                     ctrl->handle = NULL;
> > > > +                     if (WARN_ON(!handle->pending_async_ctrls))
> > > > +                             continue;
> > >
> > > Is this needed ? If we find more controls for this handle than
> > > pending_async_ctrls, decrementing it below 0 will case the WARN_ON() at
> > > the end of this function to trigger, isn't that enough ?
> >
> > I want to know if the warning is triggered because I have too many
> > pending_async_ctrls or too little.
>
> You could also print the value of pending_async_ctrls at the end, it
> would give you that information, and tell you how many you're missing.
> Not a big deal, and I don't expect that warning to be triggered.

The issue is that the variable is unsigned. it will show a weird
number... And making it signed seems incorrect.

I also do not expect it to be triggered. For now I will keep it as is.
If you have a strong opinion against it I will change it.


>
> > > > +                     handle->pending_async_ctrls--;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     WARN_ON(handle->pending_async_ctrls);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Cleanup device controls.
> > > >   */
> > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > index 97c5407f6603..b425306a3b8c 100644
> > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
> > > >
> > > >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> > > >
> > > > +     uvc_ctrl_cleanup_fh(handle);
> > > > +
> > > >       /* Only free resources if this is a privileged handle. */
> > > >       if (uvc_has_privileges(handle))
> > > >               uvc_queue_release(&stream->queue);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 07f9921d83f2..2f8a9c48e32a 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -612,6 +612,7 @@ struct uvc_fh {
> > > >       struct uvc_video_chain *chain;
> > > >       struct uvc_streaming *stream;
> > > >       enum uvc_handle_state state;
> > > > +     unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
> > >
> > > The kernel does it the other way around, it lists in the documentation
> > > of the lock what data it protects.
> > >
> > > >  };
> > > >
> > > >  struct uvc_driver {
> > > > @@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > > >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> > > >                     struct uvc_xu_control_query *xqry);
> > > >
> > > > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > > > +
> > > >  /* Utility functions */
> > > >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> > > >                                           u8 epaddr);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

