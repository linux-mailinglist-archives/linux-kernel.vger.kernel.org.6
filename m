Return-Path: <linux-kernel+bounces-427787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6349E05A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2F428D7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16E207A13;
	Mon,  2 Dec 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OCl6nNXR"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90719207A04
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150977; cv=none; b=EY6eubId1o1+thOrZwbocZKh0pKqycgIk2ijO/ifTtZtLIHkNfn+yBus6NvzaTCjYNTb2XPRq9oavgsL7sJScc9SWHr0879j9i9+Q6Key0SAZck5eWUVJvu5Y9dQzU3D14NTyO5Dc6CV+5ZCuPBGJtrQToiYRX/P9xjgygE3kJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150977; c=relaxed/simple;
	bh=2m9GEJVF/yr5wEzb8uE3X2lDkqsav3aOKC6bdyMfmYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIRqndGKh7S/BjXkFgCWDQzUT94yh8QbMErFO2UJUR+7SzvpFgyfT53lE5Iqcbk2go/dUIYvDFWV98Zd6TNKd/Biy5MguPDwh4ZtEHOW1TM5MJL9tml4BA3EeMtoJaCMFGv0upwwJsLdltRlsfp+lcMokgKNQmAjriVETvuXP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OCl6nNXR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee88b57ac0so1358791a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733150974; x=1733755774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7HoIuRb1js2kiTuc3xiIAH76Um1J8d7m/3jS2ThDmu8=;
        b=OCl6nNXR7QRCR2avNOQZEUTivTQpWHAZx5uaPiF0nMS4dGhvxdrYpIwv9SBjSwtm0P
         yQM671rld3gIB2LTgFPPL/rkzN2qTVPFvG9jvSB5QdPC/EI3Ahgf6eTomS7dLnJE9/Dj
         P8b+8NH35jHWMvHBVE+13F7C7XAdkTZUlV8kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150974; x=1733755774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HoIuRb1js2kiTuc3xiIAH76Um1J8d7m/3jS2ThDmu8=;
        b=j8imUEerBZqw5VGwFztMtlM8D0sbtLLS4sOV8jOJRrDkbvOX1YVmGWy/94r1BhUq8P
         Q1DP8T2D/QLovD0CXz5mwM+dgwiheQARKaVXCZ2YYppMf5cKfGnwJezB25UdQcvxfbkH
         GUVEbYEAed1m12LxZSalwOZdArc4kPr5G1hlAbX70XaqG+9mBaC6TgdXifJEyYfcIp+R
         ecehdVUvtf2LsFOk+K4aBgNhsNPZ1+YCcEACB5xmYLtRYLyG8GZrqKttM3uv7yMlwfEP
         CDF2mbjSyqGokbRXwmvDYi7PbiRxNREeftknKsWtJQZ+af0/wMHtu4bxZfjllH0712+Z
         kGEA==
X-Forwarded-Encrypted: i=1; AJvYcCWHfP+1Lp8mfLSKAeVAqwOBs7RNRmyxkzF5IfHqFeLkkn2e7hJeXkGmTyLbWYQTRPVjg5/OiJqcGIvSNm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Yzu3F/zjlmrPvci8TVDUv91Kf9rwgi0I3fD9rA7Xy7x/JfoL
	2hBCmSmVLMHx0at7QHCFYMAPymQDGCJl78V2ysUGItB8IPeg79ZJxetTMM6rda/9Qxx/WyAo1Wo
	=
X-Gm-Gg: ASbGnct4NVp0oQ6/4HDEMpit3eSE/Tt7wJJ19EeysZiMwln/RWxtjuY2W/2MCB+sTCb
	qDzrfvyNb0QcoVvLcvZuvgZz6rqHTpReQKlYhXOFVODXIpAO/d1bfEIoLr4C4LiIPre1d/MbdWF
	zXAJOFx9/N7V6s3PzO78kyzgiQwgwfInloBdUis6kJEBdgc1ojsKFgaYQ38yxRIkm7GspJty9bW
	cOGPCKtD/o0ucRZyn3im+M+d6lTc+2fnbsKheET80FwLhMcvyw9Q28H8jRyc169leEiaocKHyHu
	/YULxIgQPkDc
X-Google-Smtp-Source: AGHT+IHf07j6l18Cgd0ianFtATydoNi+n/TbojpAfIZTmNG8dJhI+Z78KHn05hLGiLAp98LbfGrYGQ==
X-Received: by 2002:a17:90a:c884:b0:2ee:823e:39c4 with SMTP id 98e67ed59e1d1-2ee823e3a9bmr15990894a91.7.1733150974511;
        Mon, 02 Dec 2024 06:49:34 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eea942f6a8sm2956298a91.41.2024.12.02.06.49.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:49:33 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee88b57ac0so1358753a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:49:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjG+3PWv8B3dB3ZC2h3FxZSzfVkH8PKDxckorAlWRgAVT+CMYfAfYxMKPKoyK1rw0vvI8qodECrfl/tSU=@vger.kernel.org
X-Received: by 2002:a17:90a:b115:b0:2ee:843c:3170 with SMTP id
 98e67ed59e1d1-2ee843c36e7mr13753754a91.3.1733150972698; Mon, 02 Dec 2024
 06:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-2-6658c1fe312b@chromium.org> <79da5e62-acb0-4bf5-a1c0-f2000fae0167@redhat.com>
In-Reply-To: <79da5e62-acb0-4bf5-a1c0-f2000fae0167@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 15:49:20 +0100
X-Gmail-Original-Message-ID: <CANiDSCu3BjC1JsnmgX5eEapBpzHw+HZUw58iiyVfe4KqEDCWVA@mail.gmail.com>
Message-ID: <CANiDSCu3BjC1JsnmgX5eEapBpzHw+HZUw58iiyVfe4KqEDCWVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] media: uvcvideo: Remove dangling pointers
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans


On Mon, 2 Dec 2024 at 15:44, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
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
> >  drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
> >  3 files changed, 60 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 9a80a7d8e73a..af1e38f5c6e9 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1579,6 +1579,37 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
> >       uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
> >  }
> >
> > +static void uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> > +{
> > +     lockdep_assert_held(&handle->chain->ctrl_mutex);
> > +
> > +     if (ctrl->handle)
> > +             dev_warn_ratelimited(&handle->stream->dev->udev->dev,
> > +                                  "UVC non compliance: Setting an async control with a pending operation.");
> > +
> > +     if (handle == ctrl->handle)
> > +             return;
> > +
> > +     if (ctrl->handle)
> > +             ctrl->handle->pending_async_ctrls--;
> > +
> > +     ctrl->handle = handle;
> > +     handle->pending_async_ctrls++;
> > +}
>
> Maybe simplify this to:

I do not think that we can do that simplification.

If we do that, the original file handle `pending_async_ctrls` value
will be out of sync.

Let me know if you do not agree to delete your reviewed-by


Thanks!
>
> static void uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> {
>         lockdep_assert_held(&handle->chain->ctrl_mutex);
>
>         if (!ctrl->handle)
>                 handle->pending_async_ctrls++;
>         else
>                 dev_warn_ratelimited(&handle->stream->dev->udev->dev,
>                                      "UVC non compliance: Setting an async control with a pending operation.");
>
>         ctrl->handle = handle;
> }
>
> ?
>
> Otherwise the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>



>
> Regards,
>
> Hans
>
>
>
>
> > +static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> > +{
> > +     lockdep_assert_held(&handle->chain->ctrl_mutex);
> > +
> > +     if (ctrl->handle != handle) /* Nothing to do here.*/
> > +             return;
> > +
> > +     ctrl->handle = NULL;
> > +     if (WARN_ON(!handle->pending_async_ctrls))
> > +             return;
> > +     handle->pending_async_ctrls--;
> > +}
> > +
> >  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >                          struct uvc_control *ctrl, const u8 *data)
> >  {
> > @@ -1589,7 +1620,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >       mutex_lock(&chain->ctrl_mutex);
> >
> >       handle = ctrl->handle;
> > -     ctrl->handle = NULL;
> > +     if (handle)
> > +             uvc_ctrl_put_handle(handle, ctrl);
> >
> >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -1865,7 +1897,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> >
> >               if (!rollback && handle &&
> >                   ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > -                     ctrl->handle = handle;
> > +                     uvc_ctrl_get_handle(handle, ctrl);
> >       }
> >
> >       return 0;
> > @@ -2774,6 +2806,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> > +     list_for_each_entry(entity, &handle->chain->dev->entities, list)
> > +             for (unsigned int i = 0; i < entity->ncontrols; ++i)
> > +                     uvc_ctrl_put_handle(handle, &entity->controls[i]);
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
> > index 07f9921d83f2..92ecdd188587 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -337,7 +337,11 @@ struct uvc_video_chain {
> >       struct uvc_entity *processing;          /* Processing unit */
> >       struct uvc_entity *selector;            /* Selector unit */
> >
> > -     struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > +     struct mutex ctrl_mutex;                /*
> > +                                              * Protects ctrl.info,
> > +                                              * ctrl.handle and
> > +                                              * uvc_fh.pending_async_ctrls
> > +                                              */
> >
> >       struct v4l2_prio_state prio;            /* V4L2 priority state */
> >       u32 caps;                               /* V4L2 chain-wide caps */
> > @@ -612,6 +616,7 @@ struct uvc_fh {
> >       struct uvc_video_chain *chain;
> >       struct uvc_streaming *stream;
> >       enum uvc_handle_state state;
> > +     unsigned int pending_async_ctrls;
> >  };
> >
> >  struct uvc_driver {
> > @@ -797,6 +802,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                     struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                           u8 epaddr);
> >
>


-- 
Ricardo Ribalda

