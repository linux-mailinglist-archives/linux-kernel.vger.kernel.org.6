Return-Path: <linux-kernel+bounces-426993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1969DFAFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B12162E14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F21F9418;
	Mon,  2 Dec 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MNyh+7Dl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B1F8EFA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123953; cv=none; b=qvKmGncsO9ry6mOiwTv8DrBp+uYQXWROny+imaqRSIOoBjsnWCM8/oHnFGDgyrKJ/PoCQ5Q1dw3RLebhnaFbhVPpbNZSOAR5sPYW1lMnmcSPPCKVv/I0xIlBwPsWFbfqyaLM1QCKuIM6fPCUx7HAe+ZZhhmjd9XJm+oNX4O+g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123953; c=relaxed/simple;
	bh=hf+j1g7yW69ryzI+X5FfA9uPgl1kewffZVhpIIVWCJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFNsqPJnVtDJDBra/5Me+jA20dGUgPUbhIu8KfgD1bN5UDPBlr0qYaIMPu+HFJ4C82n0vsi1cAen2DFvQaEbyZCAo7tlkYzOlPumlgkYdjgmibACG+oPKtKe1V69x+HfUBDbdjjiiJTZ3azUYsfpbh5gJwDjqBqp6VPoDGVZC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MNyh+7Dl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215909152c5so5802375ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 23:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733123951; x=1733728751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPZJ5SXB7m8Dqvv2I1ZRy2n3cYkDrshlZ9d02Y7QxTY=;
        b=MNyh+7Dl58GhBlHZN8ICMIMeT4kpLWYVnIoJ3LrRmWasQTLTj8+tNsHiDAs3NPocx/
         WhzBEjP4AUs6b3gFsrll/S7fu5Q3Ulef+0yfjhvDvfOeIck11Y94IU1wwkAltzjwpO5I
         V27X9eaiPwfEhZdZJIQ24futDFDr6YZUem++E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733123951; x=1733728751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPZJ5SXB7m8Dqvv2I1ZRy2n3cYkDrshlZ9d02Y7QxTY=;
        b=da0meLygr4xA/8qMvQmq5XUaWvbIYGVc5g1qwJj4XtSggoNgtH0hp7Ls9t2Im8EBT5
         w9zqr7Tvah9XaDNkg1XVIrOaoSU8OWonWQYu2qQWloY3EVWRqveJTRI95/Kfjte1GhaW
         euRkT7GPxBcHYJ1PEzNSTXogdBHXvyLdiG4AsWEoiNmnKrlandZ/YK79dFprJqtWBnkb
         Np0M8X5PfFszoj5xi2n2a0+M7AD9vtFiDbVipp6ZzppzUyjyS0zOQq6vIAYrOqJlhBNx
         Jlk8duU/XSqVO8sX/jGiovwrsPxcvoqxKYGmvN59+V0Fl+3dQtgiOUL/7jyxgzxsimzy
         UxYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ShmgtRayoBLgNlmhTK3agFd+Q5atZC/+J9h+uXREwp23fL56u3J83zYQ6HE8RiHg3gc7eUA3nwzQiNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6nTP9IdfQbACWxmzukSnR4Bw4NgiYe7gNXlFYwoG+DqYUmZf
	YqEitF5mMSuT9BvDvCHyFfV9xQWq2DFxxq/OkqguawjvN+C2zhS/SCUqNf0aeAPXBcMb9iOdvFw
	=
X-Gm-Gg: ASbGncsrlledp85ZuQjqJZrocpOd1q9eLRfyLLpalGOmA4IVdSAv2dbQRX8o0NccfXW
	qK11Ioyz25kYd+4694vJEAnwKQd+KUJotvxxoxtVat5f7JMCfRyyRjFosQbzowsBImj78BaDrzl
	0piwBKksOkYr3nibRCBV7+cmqJjtUyIqrXtAT8Q+ZnLf/L+rpHFX2OVn/2a63E3ncRhAYYvOVKe
	WD9Tr11c+uNMymawKBpQSrX/jiK/n8K5b4qB7fCvwxJyRphS9ma3FvEMYgrTiPaMtNXQEzOkGR1
	KN5/Gj/EjBAD
X-Google-Smtp-Source: AGHT+IFjwr52q7bai62K+2wJJQatI6G2fYBxAHKnFuXonAzJKi9eLwiRZYDZjeCKZNz7oMAOED6hkA==
X-Received: by 2002:a17:902:dace:b0:215:64ef:8702 with SMTP id d9443c01a7336-21564ef8a06mr107527085ad.7.1733123950577;
        Sun, 01 Dec 2024 23:19:10 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21569983298sm30353875ad.224.2024.12.01.23.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 23:19:08 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb2e749c5so696871a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 23:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjcvgmireSrFKtzg5eiKfpOAdO9fXziUrfLnVEGOPY9ONFg0/8fZ8FMqOkoc6vQlQ8gixmFBC52Ejy5BA=@vger.kernel.org
X-Received: by 2002:a17:90b:17d0:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ee8abd742amr9239433a91.36.1733123947424; Sun, 01 Dec 2024
 23:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
 <20241129-uvc-fix-async-v4-2-f23784dba80f@chromium.org> <CANiDSCv3986=KjwWOXsKGZ58+YMViHeHvam=ax7iKr=x_h_pRw@mail.gmail.com>
In-Reply-To: <CANiDSCv3986=KjwWOXsKGZ58+YMViHeHvam=ax7iKr=x_h_pRw@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 08:18:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCuWwVRdxUR4_Sxt8wCg+459p34t02AdOeD22LaG+AU2pw@mail.gmail.com>
Message-ID: <CANiDSCuWwVRdxUR4_Sxt8wCg+459p34t02AdOeD22LaG+AU2pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 18:15, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> nit:
>
> After sleeping on it. I think this could be nicer expressed  with:
> uvc_ctrl_get_handle and uvc_ctrl_put_handle
>
> Let me know what do you prefer:
>
>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 88ef8fdc2be2..d4a010cdf805 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1579,6 +1579,35 @@ static void uvc_ctrl_send_slave_event(struct
> uvc_video_chain *chain,
>         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
>  }
>
> +static int uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
We can even:  lockdep_assert_held(&handle->chain->ctrl_mutex);
> +
> +       if (handle == ctrl->handle) /* Nothing to do here. */
> +               return 0;
> +
> +       /* We can't change the original handler. */
> +       if (ctrl->handle)
> +               return -EBUSY;
> +
> +       ctrl->handle = handle;
> +       handle->pending_async_ctrls++;
> +       return 0;
> +}
> +
> +static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct
> uvc_control *ctrl)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> +
> +       if (!ctrl->handle) /* Nothing to do here.*/
> +               return;
> +
> +       ctrl->handle = NULL;
> +       if (WARN_ON(!handle->pending_async_ctrls))
> +               return;
> +       handle->pending_async_ctrls--;
> +}
> +
>  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>                            struct uvc_control *ctrl, const u8 *data)
>  {
> @@ -1589,7 +1618,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       uvc_ctrl_put_handle(handle, ctrl);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2046,8 +2075,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>         mapping->set(mapping, value,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> -               ctrl->handle = handle;
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +               uvc_ctrl_get_handle(handle, ctrl);
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2770,6 +2799,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
>         return 0;
>  }
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> +{
> +       struct uvc_entity *entity;
> +
> +       guard(mutex)(&handle->chain->ctrl_mutex);
> +
> +       if (!handle->pending_async_ctrls)
> +               return;
> +
> +       list_for_each_entry(entity, &handle->chain->dev->entities, list)
> +               for (unsigned int i = 0; i < entity->ncontrols; ++i)
> +                       uvc_ctrl_put_handle(handle, &entity->controls[i]);
> +
> +       WARN_ON(handle->pending_async_ctrls);
> +}
> +
>  /*
>   * Cleanup device controls.
>   */
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 97c5407f6603..b425306a3b8c 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
>
>         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>
> +       uvc_ctrl_cleanup_fh(handle);
> +
>         /* Only free resources if this is a privileged handle. */
>         if (uvc_has_privileges(handle))
>                 uvc_queue_release(&stream->queue);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index ce688b80e986..e0e4f099a210 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -340,7 +340,11 @@ struct uvc_video_chain {
>         struct uvc_entity *processing;          /* Processing unit */
>         struct uvc_entity *selector;            /* Selector unit */
>
> -       struct mutex ctrl_mutex;                /* Protects ctrl.info */
> +       struct mutex ctrl_mutex;                /*
> +                                                * Protects ctrl.info,
> +                                                * ctrl.handle and
> +                                                * uvc_fh.pending_async_ctrls
> +                                                */
>
>         struct v4l2_prio_state prio;            /* V4L2 priority state */
>         u32 caps;                               /* V4L2 chain-wide caps */
> @@ -615,6 +619,7 @@ struct uvc_fh {
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> +       unsigned int pending_async_ctrls;
>  };
>
>  struct uvc_driver {
> @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain
> *chain, u32 v4l2_id,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>                       struct uvc_xu_control_query *xqry);
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> +
>  /* Utility functions */
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
>
> On Fri, 29 Nov 2024 at 22:30, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
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
> > operation), a counter has been introduced with some logic to make sure
> > that it is properly handled.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 54 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
> >  3 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 88ef8fdc2be2..bc96fb475b9c 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1579,6 +1579,33 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
> >         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
> >  }
> >
> > +static void uvc_ctrl_set_handle(struct uvc_control *ctrl, struct uvc_fh *handle)
> > +{
> > +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> > +
> > +       if (handle) {
> > +               if (handle == ctrl->handle) /* Nothing to do here. */
> > +                       return;
> > +
> > +               /* We can't change the original handler. */
> > +               if (WARN_ON(ctrl->handle))
> > +                       return;
> > +
> > +               ctrl->handle = handle;
> > +               handle->pending_async_ctrls++;
> > +               return;
> > +       }
> > +
> > +       if (!ctrl->handle) /* Nothing to do here.*/
> > +               return;
> > +
> > +       handle = ctrl->handle;
> > +       ctrl->handle = NULL;
> > +       if (WARN_ON(!handle->pending_async_ctrls))
> > +               return;
> > +       handle->pending_async_ctrls--;
> > +}
> > +
> >  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >                            struct uvc_control *ctrl, const u8 *data)
> >  {
> > @@ -1589,7 +1616,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >         mutex_lock(&chain->ctrl_mutex);
> >
> >         handle = ctrl->handle;
> > -       ctrl->handle = NULL;
> > +       uvc_ctrl_set_handle(ctrl, NULL);
> >
> >         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >                 s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -2047,7 +2074,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> >         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> > -               ctrl->handle = handle;
> > +               uvc_ctrl_set_handle(ctrl, handle);
> >
> >         ctrl->dirty = 1;
> >         ctrl->modified = 1;
> > @@ -2770,6 +2797,29 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >         return 0;
> >  }
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > +{
> > +       struct uvc_entity *entity;
> > +
> > +       guard(mutex)(&handle->chain->ctrl_mutex);
> > +
> > +       if (!handle->pending_async_ctrls)
> > +               return;
> > +
> > +       list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > +               for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > +                       struct uvc_control *ctrl = &entity->controls[i];
> > +
> > +                       if (ctrl->handle != handle)
> > +                               continue;
> > +
> > +                       uvc_ctrl_set_handle(ctrl, NULL);
> > +               }
> > +       }
> > +
> > +       WARN_ON(handle->pending_async_ctrls);
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
> >         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> >
> > +       uvc_ctrl_cleanup_fh(handle);
> > +
> >         /* Only free resources if this is a privileged handle. */
> >         if (uvc_has_privileges(handle))
> >                 uvc_queue_release(&stream->queue);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index ce688b80e986..e0e4f099a210 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -340,7 +340,11 @@ struct uvc_video_chain {
> >         struct uvc_entity *processing;          /* Processing unit */
> >         struct uvc_entity *selector;            /* Selector unit */
> >
> > -       struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > +       struct mutex ctrl_mutex;                /*
> > +                                                * Protects ctrl.info,
> > +                                                * ctrl.handle and
> > +                                                * uvc_fh.pending_async_ctrls
> > +                                                */
> >
> >         struct v4l2_prio_state prio;            /* V4L2 priority state */
> >         u32 caps;                               /* V4L2 chain-wide caps */
> > @@ -615,6 +619,7 @@ struct uvc_fh {
> >         struct uvc_video_chain *chain;
> >         struct uvc_streaming *stream;
> >         enum uvc_handle_state state;
> > +       unsigned int pending_async_ctrls;
> >  };
> >
> >  struct uvc_driver {
> > @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                       struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                             u8 epaddr);
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

