Return-Path: <linux-kernel+bounces-210886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B29049A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C051F2311A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA003AC0C;
	Wed, 12 Jun 2024 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gngi8TSq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3E39850
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162747; cv=none; b=VTHzY8hAwMcTVy+EfReGZZX11ICBE83mCd00W89ouVicvImi3srr8bDn6bwadSSr4PcLI/QHGxLzJ/7dQFO2V15Fkgi/2Afy/NWw9bwuJBiGnU/RMFZsMuvZXhb8702h+k3iwSfM8oGVGwcNFyDCYKDPlSBIcCnnYBjA7cmsfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162747; c=relaxed/simple;
	bh=f0KrILH3kr7anOUOsJZV2d4WNHNntE524DO1e7OauZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4s1RMhTXNEqnyQ/nThZbUaXAYZv+ZDWi3i9mVj8c5ipItXWpcoj+woOLujf0MAE4lALzHQ8hNww2Nu2cq7Ig19eKyB4y1Y7vlSBEA+yIVGC8qj4AEZxh5gQTmSTq5LgqtF7anK0JoOkpgQm+sXiP3BddQqyp5EQeWM3XGrP9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gngi8TSq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f04afcce1so217666866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718162743; x=1718767543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zncNPlK1KhFnoHey29Jtt2xNQ8IDNyEFlcKcVKZ1KJU=;
        b=Gngi8TSqM6aGg5iNumFe+kztKOkUw417aa9HYQFuU8spWl17nlIpyeovqbqxDfJHCA
         wSrCzgK7G41CAg3ThG/rRy+eoYsK+m+Ia9paBa/3SRlZD5OnLuo6/J2o131MwaZAadL3
         BABPFQ8hJtvF0nDKN4i0W+pUlO0GPUqJAH14A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162743; x=1718767543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zncNPlK1KhFnoHey29Jtt2xNQ8IDNyEFlcKcVKZ1KJU=;
        b=rKHmsBX4ZojMARcY4mshUrVAQs99WEXUYPpqmZQZcDxpTcTyaDG0n0CtzfeJnCNIdp
         h8/JUjjObg23AjtoVRc3wra3ExaJwyYPqXm4M0LYqwVua71LKaKRv+14uYXxG/AgCIgF
         DBxQH0yKMtOYaOU45qMFLzLJPU1NEsi6Vxr0GD3lRBHkMSH37d7rzG2fN+GRWaIEdKnP
         uv/PhK2ct+i7557qgA3EW1M0t6uKoA5O52ZJlXbz48kdLKMKd/BoLtIUg9zOw9Rb+CX6
         gEP5MWXvTNDTLK2Ktq+rK8mBVfWD6OukMlorbaPd3iebke3i6FPpYOvEVVDBNoEWGrJF
         WSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVDxbSxnXTgmHgFtZFuQTNz62I2tX30z49k1GmzseN2xV82eE6bPG1L5uKRwHJJqN81KMmkkHqDncsV9Q/w+13qRtU6SySiBkzMcTiR
X-Gm-Message-State: AOJu0YzQ1LBiwA+H+8Z5nMVop6I4deFbwZx/vfTh0eAgRDjXVzcIGkv5
	5rYBRklyDmbsT6lSflV/gb1+EWSBNjGtmz/0Io0EjDrQFWtjDn0O470YFHfc6tdRLqNrDhM2vc/
	4zw==
X-Google-Smtp-Source: AGHT+IGYLH8zz2HkIF2MADD01xlAY9mk+nm++MwSIY6QdnntaWYJ8DJXxs6QSRzxVYOdlPRRD5NhcQ==
X-Received: by 2002:a17:907:7e96:b0:a63:49d3:e1c5 with SMTP id a640c23a62f3a-a6f480191bfmr56813966b.64.1718162743050;
        Tue, 11 Jun 2024 20:25:43 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f11e6811bsm447833366b.194.2024.06.11.20.25.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 20:25:41 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f04afcce1so217663266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:25:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIhk1SVoOx+zGQD2QJmtRHDWbCx8shUQ0peXJgUxSe7Cq6/rNv8IxheoKiapRC4JBM8214BfdKc6D4/2rG9qh7cinK4RU1LBncboEi
X-Received: by 2002:a17:906:35cd:b0:a6e:fbe1:d5e1 with SMTP id
 a640c23a62f3a-a6f47f589abmr40566366b.22.1718162741146; Tue, 11 Jun 2024
 20:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
 <20240327-guenter-mini-v4-1-49955c198eae@chromium.org> <7d06c6e4-c555-4117-a22b-5c614d7f6f8a@xs4all.nl>
 <CAAFQd5A3nzpv531fu6h7thCkxettTSbc3vofPyt7ie8qf6SJcQ@mail.gmail.com> <1976a7c6-6b66-4c4c-9c9c-f41dd8b2bdf3@xs4all.nl>
In-Reply-To: <1976a7c6-6b66-4c4c-9c9c-f41dd8b2bdf3@xs4all.nl>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 12 Jun 2024 12:25:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CDX9mWejD8RTwFfYA7dLmkfpe8Cbddba+KhrsWJR0uzA@mail.gmail.com>
Message-ID: <CAAFQd5CDX9mWejD8RTwFfYA7dLmkfpe8Cbddba+KhrsWJR0uzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] media: uvcvideo: stop stream during unregister
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Max Staudt <mstaudt@chromium.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Paul <seanpaul@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:58=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4all.=
nl> wrote:
>
> On 06/06/2024 12:04, Tomasz Figa wrote:
> > Hi Hans,
> >
> > On Tue, May 28, 2024 at 4:55=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs=
4all.nl> wrote:
> >>
> >> On 27/03/2024 09:24, Ricardo Ribalda wrote:
> >>> uvc_unregister_video() can be called asynchronously from
> >>> uvc_disconnect(). If the device is still streaming when that happens,=
 a
> >>> plethora of race conditions can happen.
> >>>
> >>> Make sure that the device has stopped streaming before exiting this
> >>> function.
> >>>
> >>> If the user still holds handles to the driver's file descriptors, any
> >>> ioctl will return -ENODEV from the v4l2 core.
> >>>
> >>> This change make uvc more consistent with the rest of the v4l2 driver=
s
> >>> using the vb2_fop_* and vb2_ioctl_* helpers.
> >>>
> >>> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>> ---
> >>>  drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/u=
vc/uvc_driver.c
> >>> index bbd90123a4e76..17fc945c8deb6 100644
> >>> --- a/drivers/media/usb/uvc/uvc_driver.c
> >>> +++ b/drivers/media/usb/uvc/uvc_driver.c
> >>> @@ -1911,8 +1911,19 @@ static void uvc_unregister_video(struct uvc_de=
vice *dev)
> >>>               if (!video_is_registered(&stream->vdev))
> >>>                       continue;
> >>>
> >>> +             /*
> >>> +              * Serialize other access to the stream.
> >>> +              */
> >>> +             mutex_lock(&stream->mutex);
> >>> +             uvc_queue_streamoff(&stream->queue, stream->type);
> >>>               video_unregister_device(&stream->vdev);
> >>>               video_unregister_device(&stream->meta.vdev);
> >>> +             mutex_unlock(&stream->mutex);
> >>
> >> This sequence isn't fool proof. You have to follow the same sequence a=
s
> >> vb2_video_unregister_device(): take a reference to the video device,
> >> then unregister, then take the stream mutex and call vb2_queue_release
> >> for each queue. Finally unlock the mutex and call put_device.
> >
> > vb2_queue_release() will run when the userspace releases the file
> > handle that owns the vb2 queue [1], so we shouldn't really need to
> > call it here.
> >
> > [1] https://elixir.bootlin.com/linux/v6.9.3/source/drivers/media/usb/uv=
c/uvc_v4l2.c#L655
> >
> >>
> >> Doing the video_unregister_device first ensures no new ioctls can be
> >> called on that device node. Taking the mutex ensures that any still
> >> running ioctls will finish (since it will sleep until they release the
> >> mutex), and then you can release the queue.
> >
> > Actually isn't the only missing thing in the code basically ensuring
> > that any ioctl currently being executed finishes? Why is the streamoff
> > or queue release needed?
>
> See below...
>
> >
> > Best regards,
> > Tomasz
> >
> >>
> >> This does require that you call get_device before calling video_unregi=
ster_device,
> >> otherwise everything might be released at that point.
> >>
> >> Instead of vb2_queue_release() you might have to call uvc_queue_stream=
off,
> >> but note that there are two queues here: video and meta. The code abov=
e
> >> just calls streamoff for the video device.
> >>
> >> For the meta device I think you can just use vb2_video_unregister_devi=
ce()
> >> directly, since that sets vdev->queue and vdev->queue.lock to the corr=
ect
> >> values. That would just leave the video device where you need to do th=
is
> >> manually.
>
> Ideally uvc should just use centralized locking (i.e. set vdev->queue.loc=
k)
> for the video node, just like it does for the meta device.
>
> If that was the case, then it can just call vb2_video_unregister_device()=
.
> The vb2_video_unregister_device helper was added to ensure that no ioctls
> are running, and then streaming is stopped and the queue is released.

Yes, it would be as simple as that if it used standard locking, but
since it does its own stuff, I'm not very confident that the same
logic as in vb2_video_unregister_device() would work fine for it as
well.

>
> While it is true that the queue is released automatically when the last u=
ser
> closes the filehandle, it can get complicated if the application has a fi=
le
> handle open when the device is unregistered (usually due to it being unpl=
ugged).
> Without that call to vb2_video_unregister_device() the queue is still act=
ive,
> and especially if you also have subdevices that are still in streaming mo=
de,
> it is hard to make sure nothing is still using the hardware.
>
> vb2_video_unregister_device() provides a clean way of ensuring that when =
the
> device is unregistered all streaming is stopped and the vb2 queue is rele=
ased.
>
> After that the only file operation that can be used without returning an =
error
> is close().
>
> Since uvc uses its own locking for the video device, it has to do this ma=
nually.
> It is probably enough to ensure no ioctls are running since uvc doesn't h=
ave
> subdevices, but I think it makes sense to stop streaming and release the =
queue
> when unregistering the device, it is weird to postpone that until the las=
t fh
> is closed.

My comment comes from a concern that releasing objects and changing
internal state in the release callback may break some assumptions in
the operations that will follow once the lock is released, e.g.
close(), leading to some kind of double frees or dereferencing freed
objects. Therefore just preventing new opens and setting the
video_device as unregistered could be potentially a safer option until
the driver is converted to standard locking. (Is there even a plan to
do that?)

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
>
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>> +
> >>> +             /*
> >>> +              * Now the vdev is not streaming and all the ioctls wil=
l
> >>> +              * return -ENODEV
> >>> +              */
> >>>
> >>>               uvc_debugfs_cleanup_stream(stream);
> >>>       }
> >>>
> >>
>
>

