Return-Path: <linux-kernel+bounces-425151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B39DBE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D7B2267E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258FC125;
	Fri, 29 Nov 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOYHb5rz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD492749C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839706; cv=none; b=aSWCycp8lXGXsMtmzZ5Xw7QTz3idHuvWJO/puXwfMt2ud1euBQ/axP2qxwfcxVUFaHl2ys3usFb+foKKuWsV2tRy7qzXaGs3fRP2uIWom0YipXe1kcrqvAQZ9wFNR8DaZMEzNsCr09D0DTjiZesMkYn5CMqvSa/3nejiqChEj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839706; c=relaxed/simple;
	bh=0oqamsEkXX4bYHIVWICaGV7yM8vIVxO5+Ns44FFffEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2VzZrcqi1dlhWOay5ZlTMwNIGGn54/BNobG/3B2GOAXcjj/qoZfWMyIcnfB6WqyLQZiF8p2FvnpvDpbAWIgLc3MKwbeMt4FhM77Sor3VF7dagMx83GqOpVHq3YGxROZiNKpc3btqDSpZf/BAmaQVhaz2ltsrkIGTYJBuxvxTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cOYHb5rz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21527bb7eb0so7305705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732839704; x=1733444504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e63Qh8yDCGpehSbTHGGffUHGEEyMaGUtLTTzMlKXbLM=;
        b=cOYHb5rz3Cr9QSy1GOAKDi7jEJan4GCeueKcjGuBeisKyRfvyQvPTBXjW8vZIOMQPp
         /NYetlpyI177TpSUrUM/BEyCo7N+9iQhG+DYaQFUSOKq/9AVdNWn+rxD/SY2Bkk8sop1
         Zqs2lCdKivmwO7mQGvUrbIXwrXjBlRoHaelis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839704; x=1733444504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e63Qh8yDCGpehSbTHGGffUHGEEyMaGUtLTTzMlKXbLM=;
        b=X2mSQ42bhumhCot24/8NIom6a3wMFn1stbdz49aqGylr87rgg3lFTI2d7pe3kzgBiL
         kgjBKpgCUam31oByJDn5yK9Yjs9+CL72kjGffB5scSlaC1j7x36ogffwer943gXsCt7P
         NeE4d8sNLh8anEcoZk1WL4BFRBHktWG20VWUr1ZaYhE2SAi4uYr+6y+gWxd+zg5gCjP+
         Aycau0qmFmwPLnJUN7RYz1F2Tk1yn9CZbNRGzwuHOCmveVjhDN0QDbS7LljhH8ZJT5CT
         u27uq/yW48ucp6a+OEm9RdgW4Ppl8NjWRQsqUzvyjhmJ43R9kaVgLN9RGqMoVoEwrJfL
         t4/g==
X-Forwarded-Encrypted: i=1; AJvYcCXUl958kxvrfwhua7JFPenfqionywOEyc7yYuWSumow9W8/uTvEtXIyw4NLFLsB4M/4aYJRVtYi5TX5Rjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstOy0GFSHXKM4maNr4w0wV46hpbUGu38UIi9D6MhsfJszZWA/
	YMOWpAlB/HBxYb4Q9wx2pxS73tXubQXP8WfvgPGCY5bBbzypQinQUgBV7CWW2ZBHv0wwhjvJtqw
	=
X-Gm-Gg: ASbGnct9neuR0DetREdyZ1HzxxqdaP0stnntihNv7psJniLtrjyTjTIbPm7dzx2H9+g
	JTgEtPKyE2gMUFzGk/TwhJ8Se+z3Tty8G4YmTlgKs0cOak272FTu/fS2mvFpNRognfjjOjcpu3q
	93WoNFh69cdjAjOAnMeFHB+7FWY66j9IrxqBwpdZmHyKT/zAS+bkekpoFHX95Ai6EzSaUK1QF48
	kXxXWidoB5sAEYD0zutoaf5m4LzEZ0trwsGOFpA0hw6vZj7IWVt+2cgNbSLUWL6Ym1ZkTobcRif
	S3O56ErwDb+L
X-Google-Smtp-Source: AGHT+IEsDNFpHOMsAP4I7ox4IRlaqdIUDs/7fYnjQ1XREGtMhSsnsI/hyOBxkZ1x3ofGUEFTg+0GRA==
X-Received: by 2002:a17:902:d550:b0:20c:3d9e:5f2b with SMTP id d9443c01a7336-21501f7a22fmr105603505ad.57.1732839703724;
        Thu, 28 Nov 2024 16:21:43 -0800 (PST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215361fd5a6sm9201795ad.94.2024.11.28.16.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 16:21:41 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee3737d2b5so567865a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvnjVP33z0uRJNt3AKqtN5rlmJHKrLt20JEBei6rP0pibWHprPDNgb6nEu7ckiIdIoibP8KWrIsbrUUzk=@vger.kernel.org
X-Received: by 2002:a17:90b:548f:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2ee095bff07mr10855096a91.27.1732839700516; Thu, 28 Nov 2024
 16:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-1-510aab9570dd@chromium.org> <20241128221649.GE25731@pendragon.ideasonboard.com>
 <CANiDSCuEPPoLjukjoO_BVVsRL22kebUnCxo3eTKJqMRg6J0fSw@mail.gmail.com> <20241128222807.GG25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128222807.GG25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 01:21:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCt2SyDn48OsdNVV4aieWvpDBzEiAxboONprOuqkbBYf+Q@mail.gmail.com>
Message-ID: <CANiDSCt2SyDn48OsdNVV4aieWvpDBzEiAxboONprOuqkbBYf+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 23:28, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Nov 28, 2024 at 11:25:25PM +0100, Ricardo Ribalda wrote:
> > On Thu, 28 Nov 2024 at 23:17, Laurent Pinchart wrote:
> > > On Wed, Nov 27, 2024 at 12:14:49PM +0000, Ricardo Ribalda wrote:
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
> > >
> > > s/). A/), a/
> > >
> > > > that it is properly handled.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> > > >  drivers/media/usb/uvc/uvcvideo.h |  8 +++++++-
> > > >  3 files changed, 45 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 4fe26e82e3d1..b6af4ff92cbd 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> > >
> > > How about adding
> >
> > SGTM.
> >
> > >
> > > static void uvc_ctrl_set_handle(struct uvc_control *ctrl, uvc_fh *handle)
> > > {
> > >         if (handle) {
> > >                 if (!ctrl->handle)
> > >                         handle->pending_async_ctrls++;
> > >                 ctrl->handle = handle;
> > >         } else if (ctrl->handle) {
> > >                 ctrl->handle = NULL;
> > >                 if (!WARN_ON(!handle->pending_async_ctrls))
> >
> > Unless you think otherwise. I will make this:
> >
> > WARN_ON(!handle->pending_async_ctrls);
> > if (handle->pending_async_ctrls)
> >    handle->pending_async_ctrls--;
>
> I'm fine with that, I went back and forth between the two.
>
> > The double negation is difficult to read. I am pretty sure the
> > compiler will do its magic and merge the two checks.
> >
> > >                         handle->pending_async_ctrls--;
> > >         }
> > > }

Now that I think about it. Now that we have inverted the patches 1 and
2 we need to add the following change to your function:

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d8d4bd2254ec..5ce9be812559 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1584,8 +1584,14 @@ static void uvc_ctrl_set_handle(struct
uvc_control *ctrl, struct uvc_fh *handle)
        /* chain->ctrl_mutex must be held. */

        if (handle) {
-               if (!ctrl->handle)
-                       handle->pending_async_ctrls++;
+               if (ctrl->handle) {
+                       if (ctrl->handle == handle)
+                               return;
+                       WARN_ON(!ctrl->handle->pending_async_ctrls);
+                       if (ctrl->handle->pending_async_ctrls)
+                               ctrl->handle->pending_async_ctrls--;
+               }
+               handle->pending_async_ctrls++;
                ctrl->handle = handle;
        } else if (ctrl->handle) {
                ctrl->handle = NULL;

Otherwise, if the control is handled by another fh,
pending_async_ctrls will be unbalanced.

> > >
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
> > > This would become
> > >
> > >         handle = ctrl->handle;
> > >         uvc_ctrl_set_handle(ctrl, NULL);
> > >
> > > >
> > > >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> > > >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > > > @@ -2046,8 +2051,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >       mapping->set(mapping, value,
> > > >               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> > > >
> > > > -     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > > > +     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > > > +             if (!ctrl->handle)
> > > > +                     handle->pending_async_ctrls++;
> > > >               ctrl->handle = handle;
> > > > +     }
> > >
> > > Here
> > >
> > >         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > >                 uvc_ctrl_set_handle(ctrl, handle);
> > >
> > > >
> > > >       ctrl->dirty = 1;
> > > >       ctrl->modified = 1;
> > > > @@ -2770,6 +2778,32 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> > > > +             for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > > > +                     struct uvc_control *ctrl = &entity->controls[i];
> > > > +
> > > > +                     if (ctrl->handle != handle)
> > > > +                             continue;
> > > > +
> > > > +                     ctrl->handle = NULL;
> > > > +                     if (WARN_ON(!handle->pending_async_ctrls))
> > > > +                             continue;
> > > > +                     handle->pending_async_ctrls--;
> > >
> > > And here
> > >
> > >                         uvc_ctrl_set_handle(ctrl, NULL);
> > >
> > > It seems less error-prone to centralize the logic. I'd add a
> > > lockdep_assert() in uvc_ctrl_set_handle(), but there's no easy access to
> > > the chain there.
> > >
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
> > > > index 07f9921d83f2..c68659b70221 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -337,7 +337,10 @@ struct uvc_video_chain {
> > > >       struct uvc_entity *processing;          /* Processing unit */
> > > >       struct uvc_entity *selector;            /* Selector unit */
> > > >
> > > > -     struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > > > +     struct mutex ctrl_mutex;                /*
> > > > +                                              * Protects ctrl.info and
> > > > +                                              * uvc_fh.pending_async_ctrls
> > > > +                                              */
> > > >
> > > >       struct v4l2_prio_state prio;            /* V4L2 priority state */
> > > >       u32 caps;                               /* V4L2 chain-wide caps */
> > > > @@ -612,6 +615,7 @@ struct uvc_fh {
> > > >       struct uvc_video_chain *chain;
> > > >       struct uvc_streaming *stream;
> > > >       enum uvc_handle_state state;
> > > > +     unsigned int pending_async_ctrls;
> > > >  };
> > > >
> > > >  struct uvc_driver {
> > > > @@ -797,6 +801,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
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

