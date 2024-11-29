Return-Path: <linux-kernel+bounces-425951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D09DECE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482E1B212DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640A1A2550;
	Fri, 29 Nov 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pj/Yexjv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A28189BAD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915425; cv=none; b=WYYfI96DSUXqWv6QVem4FJ2JgIvUZHP7yPDZ0Pxge+zzS5PE27WDtksdAQcd0FH/VfwOORdYc1Vj7cPrwbbKvaHhBFFQ46Hy+cVq3qkCi0XmdiYAwWU+ed6PqK+zRivKyh1QhPQVJwYZ3UwcLHJvU9v1h5bf6etT+mXA6XPWFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915425; c=relaxed/simple;
	bh=H+pt1YX92D8b0xsAk6x1oHhj9BYBNM6ur0sFrZX8/r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsikWilaYIEG46XmoRAcoPAGhxb0anana6VHJK8SMPjYDzfzpLlUg9mQoGK+mNzyJAg2ehYHxHWD01E97xzkym6XtvWgJRLB+rCsVR8F3nGAx2ECDkdkSkuM4opsB12Jxrn5ucvo76v01KZR5ERPZnhcwkRJuoqH8WdT0KTbJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pj/Yexjv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7250906bc63so1690238b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915423; x=1733520223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+yDaUyQ9Dovj6g5WwtyLbdYrdVmmg1F93HxsG1jRsE=;
        b=Pj/Yexjv7PNhFbG0H7oRIEkB7UB5x+cIVtj+4CxtMhInayiyzIHEto6CFjmEHprPnE
         RHvEBk6DF+LkFClnJrLxzoC4ezrR78V8vgP3Ka5mPR5+ICilga+UjqPiOJ+HmHNUY0le
         e7LpjmtS3QTSPO8qTzYNRrIRaiN0FIiEEUpw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915423; x=1733520223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+yDaUyQ9Dovj6g5WwtyLbdYrdVmmg1F93HxsG1jRsE=;
        b=Egjy51D0w1XQk9enimuiZfFtHa7h9a5z6Iw75ndDGHbFC63OuwOL2PicJ5IuJg2cyK
         SmLXv+RH5ntHQv1+ayo+IoSFC8Ma+DM76AaVk5swpmWvqvPUv8rScGO7P+XRoQe/6j71
         A1zxHHbqEHc4o4bze/p1sxLuaI5Gdp6hkszWPifPcNeKocyRvIkinFVqrFsYtdrpSFzM
         JHxbzV/bXxoixr8+cKStICS079qudEAsy6VXGWytLxZNSt2AwSw8J4XoTqb1oeiXfX/N
         IC6vBonTX37G8Wj3dXzxFHMzKQwojKl2P9OKcvbp4nEEtLy8ik++wyu3XIlNYxTPlrCO
         2/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJSg5H9AYEHlgMyWLYnlqEbSX+SqnOaFLps0eSvkVr1XUKnIrc3JBcsiLhLN7gb1lbEHFaxxtnwJjk6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvfhK7TG/4O6UBFEgtvKEJFsg3i0AX38x5e2NeLE2Beq4uzw8
	HZTY5ZIKJAKiearNku/gH4LwkF2s/OnGDv5BEaZ6LvPvoc59pjlRWGfotRZyIVoDjG13jhDxBrA
	=
X-Gm-Gg: ASbGncu7gBLS2MvcuCInAb/QijBTh2y+QXFLY1VVPe/OoddA99O6DAJerBWvLGErFF6
	SKfi6ADaokzNBH2HKLXw4FooDRg64IwsuincP8EgkMLVQclYe1kvxlxqvgQzVb6R1Edgs7FoWUC
	2tPjZZYq7sSjbx+GIIoCwl/m1en53FGFJaGNGOXFcuIiRg4tPPR/yEQPHvXt9CC2TxumubIaLCP
	HPWjQrej7pATBH6dcNhi1X2MKRh95LJlzYCgwhIgNJsiUf+fJzx9Jng229WJI8HrY9ePUiq+PtQ
	0tX1Zqk89YDCsbs1
X-Google-Smtp-Source: AGHT+IHl4dt38TnhpXn47YAq876cAcwj2qriduMlbKTSii7HH+3v3z4iMxiJSOS1NdwKt6hywl82+Q==
X-Received: by 2002:a17:90b:4f85:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2ee25b06600mr12927165a91.15.1732915423095;
        Fri, 29 Nov 2024 13:23:43 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b2b97f6sm3744857a91.53.2024.11.29.13.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 13:23:41 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso1565290b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:23:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKvBwvO0bPwiAU1NmAKeOZJtV2R0oOuFWAsFKBa3lvF3nfRDMn/M3DRCI8QYLfWSwFVE7qjTyFnc+qMl8=@vger.kernel.org
X-Received: by 2002:a17:90b:8f:b0:2ee:4b72:fb47 with SMTP id
 98e67ed59e1d1-2ee4b72fcfbmr8253541a91.6.1732915420986; Fri, 29 Nov 2024
 13:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org> <20241129-uvc-fix-async-v3-2-ab675ce66db7@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v3-2-ab675ce66db7@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 22:23:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCsRRBs8dEbyamD+xj1t_M_x6r9MU2_T4RmzEwHygxz_ZQ@mail.gmail.com>
Message-ID: <CANiDSCsRRBs8dEbyamD+xj1t_M_x6r9MU2_T4RmzEwHygxz_ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 20:25, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> When an async control is written, we copy a pointer to the file handle
> that started the operation. That pointer will be used when the device is
> done. Which could be anytime in the future.
>
> If the user closes that file descriptor, its structure will be freed,
> and there will be one dangling pointer per pending async control, that
> the driver will try to use.
>
> Clean all the dangling pointers during release().
>
> To avoid adding a performance penalty in the most common case (no async
> operation), a counter has been introduced with some logic to make sure
> that it is properly handled.
>
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
>  drivers/media/usb/uvc/uvcvideo.h |  9 +++++++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 88ef8fdc2be2..0a79a3def017 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1579,6 +1579,23 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
>         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
>  }
>
> +static void uvc_ctrl_set_handle(struct uvc_control *ctrl, struct uvc_fh *handle)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> +
> +       if (handle) {
> +               if (WARN_ON(ctrl->handle))
> +                       return;
> +               handle->pending_async_ctrls++;
> +               ctrl->handle = handle;
> +       } else if (ctrl->handle) {
> +               ctrl->handle = NULL;
> +               if (WARN_ON(!handle->pending_async_ctrls))
> +                       return;
> +               handle->pending_async_ctrls--;
This is wrong, handle is NULL here. Sorry about that.

Uploading a new version.

> +       }
> +}
> +
>  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>                            struct uvc_control *ctrl, const u8 *data)
>  {
> @@ -1589,7 +1606,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       uvc_ctrl_set_handle(ctrl, NULL);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2047,7 +2064,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> -               ctrl->handle = handle;
> +               uvc_ctrl_set_handle(ctrl, handle);
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2770,6 +2787,29 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> +       list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> +               for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> +                       struct uvc_control *ctrl = &entity->controls[i];
> +
> +                       if (ctrl->handle != handle)
> +                               continue;
> +
> +                       uvc_ctrl_set_handle(ctrl, NULL);
> +               }
> +       }
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
> @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>                       struct uvc_xu_control_query *xqry);
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> +
>  /* Utility functions */
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
>
> --
> 2.47.0.338.g60cca15819-goog
>


-- 
Ricardo Ribalda

