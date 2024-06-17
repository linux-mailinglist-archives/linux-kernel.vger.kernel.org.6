Return-Path: <linux-kernel+bounces-216815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650F90A730
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522A8B2BE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9D18C35E;
	Mon, 17 Jun 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MzTV+Ujy"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BA188CCE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608943; cv=none; b=lsd+GEY5OVxsMpHRgdMUK51ukhgyhNXO9OmHTVZfBbyflIcb7juMdqbGg8PW5xTKYMgpTrb7QF5llKvtYue85VQoeHCVMyC3yCl7YG378mfLmw/CjR53tFN6MvAYzYqmihcB+aZouIo187gNBW/aMH7TtM9E+DlGuEwsPEEVS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608943; c=relaxed/simple;
	bh=EFNldt9oc31BBroDOkUyJUbk2o4DNigh/XsiF4ogy9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KV7dTZXFPsVULXtkr/YJS8WnwUIWBRK1tR0kt9lxxyQejtEYyGlwwl0kE1hm+77t1O+REWAVfz24Wc6xjcb6ODTpWbZDcoGKipmn5OyuSiFIEt/LulGXkB6xycijrBaG0EdXL3DRtsCiETJeoWOENB65NswyWmgzr0JlsSzAZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MzTV+Ujy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cc7e85b4bso3356102a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718608940; x=1719213740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aFFKDT/kzIPthRB43TtXXoQ3gwMY3tRaFeq+i+fnC0=;
        b=MzTV+UjylwfaAEzEPvuN2sAdCYBLpJ55HnE4eEaHw/La9NFqt4a0PkZJAeT6/0yuxt
         4GzrZm+CNvnS2xxByX52lEkQXtXXTj2t1XZNvKBecZxy2jFaHv68beIal0LZU5nLUUXl
         pl7C83uks9BDiBvZA8109KWTj9vNE8oe0RQDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608940; x=1719213740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aFFKDT/kzIPthRB43TtXXoQ3gwMY3tRaFeq+i+fnC0=;
        b=YGnGHfchz9SWt97EBNUGDq3Xwcok7xdvsSLG1mMpFjcjhGK0B5VBU14MJIHLfI39TT
         T2NNybVK6TS/6oMfxdOYJpvtauml0Xbgj83l+81iD9VEL4mw6tMeK7Rf28o+DjwU085v
         mO8dfRDBT3fA3jmUmTMKZ0E0+V0qKkzMc49lCKgJRRNaK19P2dqsgThD84uhMuDpd1t2
         sVuqlur1e32At/8P9Tu4/GKGUQGZQ0SK/c5mkrjcSLHjBGdXNd81eyK5LYLDYt4I8/ED
         KIIA/dDuTKM4PtbfSkN7qgqnsHpP4mdLtUnmv5YgTCplP9Qp3zaa2o1fgCDVMwdLm0ce
         5u4g==
X-Forwarded-Encrypted: i=1; AJvYcCUBH+S8kUA3N6X5jFRSIEK4hzMDaSPfcCQ06kP6zvQySGWjfkNffLe0pNNm8Anm3Na59/g/Pulna0Ia01viSmC4uCFeMZPqYVr379dC
X-Gm-Message-State: AOJu0Ywvak5WJDnmth8T6hsiNW310QEOYu7jGif9zmwCZjHrzk30fJzx
	ihDIGZAb+mizh2zQO0qohR5FyqoCLscrQPddf8Y1GwCcex5N5hFJHgm9643rBIRT55HQzFjyiNc
	=
X-Google-Smtp-Source: AGHT+IEDIq8R6lM2e/FDud+yjpl7UTkZxiILCrmL9bUfo5qMhAkXNgyJ5nzDsOIyurd6KeqjOPwYpw==
X-Received: by 2002:aa7:d153:0:b0:578:6360:aa11 with SMTP id 4fb4d7f45d1cf-57cb4bb0d59mr8960865a12.5.1718608939885;
        Mon, 17 Jun 2024 00:22:19 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e5aesm5982832a12.60.2024.06.17.00.22.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 00:22:18 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so17829566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:22:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3odTrwHJMx2TOoyvWIgZZ8ERH/YXLKZ8B//kasZCAFUujzIwXixI0QZ/eA+IUI/hB+qyU0/b4M8mQs9UWUo2oCmIqljekc0XDFNBp
X-Received: by 2002:a17:906:b28a:b0:a6f:1d4e:734f with SMTP id
 a640c23a62f3a-a6f608bbab5mr562399266b.36.1718608937530; Mon, 17 Jun 2024
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
 <20240614-guenter-mini-v6-1-7b7fdc3b21b3@chromium.org> <20240616235410.GN4782@pendragon.ideasonboard.com>
In-Reply-To: <20240616235410.GN4782@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 17 Jun 2024 09:22:05 +0200
X-Gmail-Original-Message-ID: <CANiDSCueAU6R_NDKQcFMOTqtrYB7QAQL6oUQanR=-dTnhsaTbQ@mail.gmail.com>
Message-ID: <CANiDSCueAU6R_NDKQcFMOTqtrYB7QAQL6oUQanR=-dTnhsaTbQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] media: uvcvideo: Stop stream during unregister
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Tomasz Figa <tfiga@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 17 Jun 2024 at 01:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Fri, Jun 14, 2024 at 12:41:27PM +0000, Ricardo Ribalda wrote:
> > uvc_unregister_video() can be called asynchronously from
> > uvc_disconnect(). If the device is still streaming when that happens, a
> > plethora of race conditions can occur.
> >
> > Make sure that the device has stopped streaming before exiting this
> > function.
> >
> > If the user still holds handles to the driver's file descriptors, any
> > ioctl will return -ENODEV from the v4l2 core.
> >
> > This change makes uvc more consistent with the rest of the v4l2 drivers
> > using the vb2_fop_* and vb2_ioctl_* helpers.
>
> As I've said many times before, this issue needs a fix in the V4L2 core,
> ideally with support in the cdev core. It seems I'll have to do it
> myself ?

 vb2_video_unregister_device() already patched this issue. We are just
porting that solution to UVC, because uvc is not using the vb2
helpers.
I don't see why being more consistent with the rest of the v4l2 driver
makes it a bad thing.

I am reverting the ChromeOS solution for this race condition and
applying this patch instead:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5632459/1
That is going to test this patch in some million devices in some days.

This change is self-contained, fixes a real problem, makes the driver
consistent and will be tested by lots of users. We could land this
patch and help our users until there is a solution in cdev.
I would argue that even with a solution in cdev this is not a bad patch.

> ideally with support in the cdev core. It seems I'll have to do it
> myself ?

I can help reviewing and testing ;)

Regards!


>
> > Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index bbd90123a4e7..55132688e363 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1908,11 +1908,41 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >       struct uvc_streaming *stream;
> >
> >       list_for_each_entry(stream, &dev->streams, list) {
> > +             /* Nothing to do here, continue. */
> >               if (!video_is_registered(&stream->vdev))
> >                       continue;
> >
> > +             /*
> > +              * For stream->vdev we follow the same logic as:
> > +              * vb2_video_unregister_device().
> > +              */
> > +
> > +             /* 1. Take a reference to vdev */
> > +             get_device(&stream->vdev.dev);
> > +
> > +             /* 2. Ensure that no new ioctls can be called. */
> >               video_unregister_device(&stream->vdev);
> > -             video_unregister_device(&stream->meta.vdev);
> > +
> > +             /* 3. Wait for old ioctls to finish. */
> > +             mutex_lock(&stream->mutex);
> > +
> > +             /* 4. Stop streaming. */
> > +             uvc_queue_release(&stream->queue);
> > +
> > +             mutex_unlock(&stream->mutex);
> > +
> > +             put_device(&stream->vdev.dev);
> > +
> > +             /*
> > +              * For stream->meta.vdev we can directly call:
> > +              * vb2_video_unregister_device().
> > +              */
> > +             vb2_video_unregister_device(&stream->meta.vdev);
> > +
> > +             /*
> > +              * Now both vdevs are not streaming and all the ioctls will
> > +              * return -ENODEV.
> > +              */
> >
> >               uvc_debugfs_cleanup_stream(stream);
> >       }
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

