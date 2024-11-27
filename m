Return-Path: <linux-kernel+bounces-423116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931B9DA312
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1213B25ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CBF14EC60;
	Wed, 27 Nov 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HvEVI+Ai"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B961114
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692432; cv=none; b=Tzruxolq4lsPXz8IjGQFY+QZWQFLDbHOxen943UuXdBCuubNxsPo0uYNA3GUnDqQz4qWG7zWUXRTp8+onlsE7zRqqMFR7bwV7PylUvz9rDGie51EnSfryCDa645UFPw++Qb/y8InSPDKqzu6WbV6QnMuZLOlIgh2P7/pams7yoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692432; c=relaxed/simple;
	bh=VEeTdkPIshGtUMIjF1+MQ8SsBy4eSEWr18q7NQ2DlmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ubxb091blUOybVw5FtNXdtMH0WPl66US9nitcXsZHL3S/RnlZaTk0G1eDKYo3KVNfyk8r4PCUBJAB95TtpNFYZZP8tW0oJjswg20wfInC5PgpGWsi8Tu8cCuaMzYCsxo+yvdCpGad2w96uDIzot+US15FSlhPx7cJD3Mi4QOjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HvEVI+Ai; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7252f48acf2so536338b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692429; x=1733297229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWsPbH9Ey/0wa0vmOqHRbHISu5d2cxb8zw/sMgDSg6c=;
        b=HvEVI+Ai3EYvp31aVBnvk2dDhrveVJCi+PgDquQl2J7X6mLVdzn4a3vxH0DKHkV6BF
         2NakHs1ibnxQp2BpQmUnUDviE65sWC9i8wvcTawTtwDYQXxsHILi+IeTCDj9dy2B/5of
         IdYoEN8niU7vKF+TRlJjLZuqR7AXwf80CJx5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692429; x=1733297229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWsPbH9Ey/0wa0vmOqHRbHISu5d2cxb8zw/sMgDSg6c=;
        b=FQfOOH00zgIQ65lKCuEqH6xauzO06MjLZcSlHsWHujMB25hdZm+cXYXvKiFzZvXrhY
         cmtMLu856pZdgBD49LqJdjKE1JzmiLvQk3vqU4cwQE05V9ZuCqSbH/G6jO/blrFNg7+s
         U/ouULDqpmRycOyNtxROxIfRJyvzct9chJ5Ssl4cA4EjDyBqB/7Qv6BRNC7/ZVzlMDWU
         sdG311F1GUx/EqFeOVTD3uHBSg0t1bV8uyo139ybPL/ANQXXVW6cG0zVW5TY2IkhTjOY
         yAfZNKqwyganfq0yZIMoKexqbtNEoHzalcXnJfPm074og5zR1pFxVdWdaNF7v7i2kMsE
         RzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQhkPHydSuONgD56hbEuSHYnanGtoE31YpmSgufMMx4yb9ycW5hJ306o1K1B/35GIV70gZcf4e1MQG5mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzji7qg90bC+u2YVPCZ2A4ptinmvybTCjB7Tis6lbXAFu/Ckty
	YLvJeeg1UVXFzmAn494z59uqRs5RrH7/OBksUAb+NufsPmiW26fSy4VdqjSK0VdqAUryFJYSb+k
	=
X-Gm-Gg: ASbGncuWlo9H1bxf0UT4yQPVS5o3OSIVbrqNaCLVT7Cm284FvW6SAW0sh3Hlt045P1d
	lKoNj+66wq+MGno7j9K7+WgthiZaswdbHR6g/H4pIlfediAmhSGl0pDF1sUwMBFhwDSmixjPM8b
	uPJSL5jF9Cw3VOBOSUY6YjQLWa9Tur3Cy4+tPzE27hw1VZuGl8BMfu7CPndnlj9RXOzk+omDYCL
	iD6zDz2xyDd2gFp6T3uEA5LSbBpK+c5UsvJyWf3vl1v6NYnbqlhboMt0C7Goc2qOXnj3PRPpqeC
	IEPZSeMR6KvTza4D
X-Google-Smtp-Source: AGHT+IE5tw2e1pOb/xjqlTGt6fPLYpkD/b5/gc2Wqn9OuTCyavRZJaI8tvotprO2e5zfd1Vb5/WrWw==
X-Received: by 2002:a05:6a00:ccd:b0:724:6dcd:6c46 with SMTP id d2e1a72fcca58-7253006e0b2mr3426817b3a.14.1732692429250;
        Tue, 26 Nov 2024 23:27:09 -0800 (PST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc4c28sm9894192a12.3.2024.11.26.23.27.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:27:08 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7252f48acf2so536305b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:27:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/0mLx4+AotlEaI6zLxspWOLRK6TMujzdshb4Jv/vU0oRYn2zO+wFiPf2yzHUDiFhcHHkONW6wtKAYumg=@vger.kernel.org
X-Received: by 2002:a05:6a00:3c91:b0:724:f6a2:7b77 with SMTP id
 d2e1a72fcca58-7253013312cmr3529250b3a.17.1732692427462; Tue, 26 Nov 2024
 23:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org> <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 08:26:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCu+v+nf3tifsbybf8a5Ea54c7ag4B61BDkN9FA9ogM+SA@mail.gmail.com>
Message-ID: <CANiDSCu+v+nf3tifsbybf8a5Ea54c7ag4B61BDkN9FA9ogM+SA@mail.gmail.com>
Subject: Re: [PATCH 2/9] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[Resending in plain text, seem like today is not may day]

On Tue, 26 Nov 2024 at 17:20, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> When an async control is written, we copy a pointer to the file handle
> that started the operation. That pointer will be used when the device is
> done. Which could be anytime in the future.
>
> If the user closes that file descriptor, its structure will be freed,
> and there will be one dangling pointer per pending async control, that
> the driver will try to use.
>
> Keep a counter of all the pending async controls and clean all the
> dangling pointers during release().
>
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
>  drivers/media/usb/uvc/uvcvideo.h |  3 +++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5d3a28edf7f0..11287e81d91c 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       if (handle) {
> +               ctrl->handle = NULL;
> +               WARN_ON(!handle->pending_async_ctrls)
There is obviously a missing semicolon here.
I screwed it up when I reordered the patches to move it to the first
part of the set.
Luckily we have CI :).

You can see the fixed version here:
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commits/b4/uvc-granpower-ng

I do not plan to resend the whole series until there are more comments.
But I am sending the first two patches as a new set, they are fixes. I
will also send the last patch alone, it is unrelated to this.

> +               if (handle->pending_async_ctrls)
> +                       handle->pending_async_ctrls--;
> +       }
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>         mapping->set(mapping, value,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> +               if (!ctrl->handle)
> +                       handle->pending_async_ctrls++;
>                 ctrl->handle = handle;
> +       }
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> +               int i;
> +
> +               for (i = 0; i < entity->ncontrols; ++i) {
> +                       struct uvc_control *ctrl = &entity->controls[i];
> +
> +                       if (!ctrl->handle || ctrl->handle != handle)
> +                               continue;
> +
> +                       ctrl->handle = NULL;
> +                       if (WARN_ON(!handle->pending_async_ctrls))
> +                               continue;
> +                       handle->pending_async_ctrls--;
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
> index 07f9921d83f2..2f8a9c48e32a 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -612,6 +612,7 @@ struct uvc_fh {
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> +       unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
>  };
>
>  struct uvc_driver {
> @@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
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

