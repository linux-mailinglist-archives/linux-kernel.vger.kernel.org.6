Return-Path: <linux-kernel+bounces-204078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC98FE3BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4631C20809
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A8187357;
	Thu,  6 Jun 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RufTruQO"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E31187344
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668283; cv=none; b=NGgoTCcENOdFicprviJ8psr6Q9sSCJpmq1Odz956iUspgooWsd/aR6P/QwvOUFKGt3HgJHflSOV8+xbAKPR/waIjQT00h10MZ+VbEkcOc9Ne/MlxQ7YOhNr4iaRAkbwp6WCQL2pGrOwuKyHkhQeHjeNkNroySJFj+CcQkcZlAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668283; c=relaxed/simple;
	bh=cljjUSYvAY7IKDvMcJNeH/P9k/GXEpyfzDxe6JnqD3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpsPFyaEPeru+fmEqZAqZ3I56lBuXjr7FQq5LLZHxxLavrB9DGj+pdizLANXBq/OS7jSQzqD22Yw6iUN/xK7iADYVhnbIPLPCOEoQgf5qHEuvHGYMIURQ6LOPy+2reBQnvZBpoLjuTkqmg2pW8d1ssRiTYuMNLvPz+YBa/CUB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RufTruQO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f9502c5145so176751a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717668281; x=1718273081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FFEfZfMhtCTVz6fJLdJgkQIxu+ZKHBd6J2Z4h3gV+c=;
        b=RufTruQOzUFI8wjrJYSROJUzaK6PKOJlH1he1gZMPlM02mys+eIpcFGoly3xRUlPuQ
         gOY7u+Q7yEgU3UugA9euKaJki5NytjspgXTRMzW/wwDV6/bC4YD4RqS6rbbUKocO9hG4
         NgnWx46efHuxJUmMfFMAXd75NKLzuRW5WTT+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668281; x=1718273081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FFEfZfMhtCTVz6fJLdJgkQIxu+ZKHBd6J2Z4h3gV+c=;
        b=FVkrMbzf/AYzgGiCcvxywPpV98jdtda7xVQK1Ggi8XysVuif4LheAMUJY7ooUywKJC
         VvhicWsgn/6O59n2sLBckKJWwLZ7bxdinmtpciI54Y7HamkWq+Lt+0JWdtvZH+6ePggI
         p+s82s4giJsaBAdHNGtdKvY4NuBTGbZzphLpz6Wpez9xf81gPlxrHKy2uC6EQPd545v7
         uvfR+zZov01Ntmw2DP7bl6ZT0fDxMxyKOv/O5MUr4pSMA++BimPEnGb0rwRGZ+u6HSwC
         HlgoRwZOH4+CYezbSY4fX2PHnflpO0WiUDUj8F1nZKeFhmVy6jLkM4JEaJbIdac7zpN6
         0vzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9sOV/nSSQiP+rjPynnsUofdxLwKDSOn/02mWroCz7cGpIOoT8r1mXPLB108e2eM3vQNSeYVpBE1hc0N5hMAbcyAVSMud8BeNu0/6
X-Gm-Message-State: AOJu0YxqcpB4eBcKXv2+9ECuGvqSxUCx8lt60M2smqrBwmw5m1xf8Bjh
	6l0iTZjaEAodSdsWSMezWQT2GPfdaJzAxi+19HAucQk7aTZSAPHYCl4bGZFqKIrh6rx4Xt9ifQV
	WsA==
X-Google-Smtp-Source: AGHT+IFPVV3WtbGlE+FDaMVj0AgTTDiViyW9dZiSxcvyw1mG/v3fLutaQBY0ijvMI0F1iEBHtG0uzw==
X-Received: by 2002:a9d:73ce:0:b0:6f9:4fd1:a070 with SMTP id 46e09a7af769-6f94fd1a402mr928067a34.36.1717668280843;
        Thu, 06 Jun 2024 03:04:40 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b2426sm45378485a.73.2024.06.06.03.04.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:04:40 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ae1b32752fso3970856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:04:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0SKpTTC4/aNjHtKFXRBAJhQ1NMMeQVFAZ07FF7lHCnNZUldd1hH1Pdr298WjF2RUfWGqr8XV/LxHSGuN+zQw4dMCcHYaoPtd0Opsm
X-Received: by 2002:a05:6214:4992:b0:6ad:8fd4:efce with SMTP id
 6a1803df08f44-6b02bf761c8mr66383096d6.28.1717668276675; Thu, 06 Jun 2024
 03:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
 <20240327-guenter-mini-v4-1-49955c198eae@chromium.org> <7d06c6e4-c555-4117-a22b-5c614d7f6f8a@xs4all.nl>
In-Reply-To: <7d06c6e4-c555-4117-a22b-5c614d7f6f8a@xs4all.nl>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 6 Jun 2024 19:04:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A3nzpv531fu6h7thCkxettTSbc3vofPyt7ie8qf6SJcQ@mail.gmail.com>
Message-ID: <CAAFQd5A3nzpv531fu6h7thCkxettTSbc3vofPyt7ie8qf6SJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] media: uvcvideo: stop stream during unregister
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Max Staudt <mstaudt@chromium.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Paul <seanpaul@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, May 28, 2024 at 4:55=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 27/03/2024 09:24, Ricardo Ribalda wrote:
> > uvc_unregister_video() can be called asynchronously from
> > uvc_disconnect(). If the device is still streaming when that happens, a
> > plethora of race conditions can happen.
> >
> > Make sure that the device has stopped streaming before exiting this
> > function.
> >
> > If the user still holds handles to the driver's file descriptors, any
> > ioctl will return -ENODEV from the v4l2 core.
> >
> > This change make uvc more consistent with the rest of the v4l2 drivers
> > using the vb2_fop_* and vb2_ioctl_* helpers.
> >
> > Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc=
/uvc_driver.c
> > index bbd90123a4e76..17fc945c8deb6 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1911,8 +1911,19 @@ static void uvc_unregister_video(struct uvc_devi=
ce *dev)
> >               if (!video_is_registered(&stream->vdev))
> >                       continue;
> >
> > +             /*
> > +              * Serialize other access to the stream.
> > +              */
> > +             mutex_lock(&stream->mutex);
> > +             uvc_queue_streamoff(&stream->queue, stream->type);
> >               video_unregister_device(&stream->vdev);
> >               video_unregister_device(&stream->meta.vdev);
> > +             mutex_unlock(&stream->mutex);
>
> This sequence isn't fool proof. You have to follow the same sequence as
> vb2_video_unregister_device(): take a reference to the video device,
> then unregister, then take the stream mutex and call vb2_queue_release
> for each queue. Finally unlock the mutex and call put_device.

vb2_queue_release() will run when the userspace releases the file
handle that owns the vb2 queue [1], so we shouldn't really need to
call it here.

[1] https://elixir.bootlin.com/linux/v6.9.3/source/drivers/media/usb/uvc/uv=
c_v4l2.c#L655

>
> Doing the video_unregister_device first ensures no new ioctls can be
> called on that device node. Taking the mutex ensures that any still
> running ioctls will finish (since it will sleep until they release the
> mutex), and then you can release the queue.

Actually isn't the only missing thing in the code basically ensuring
that any ioctl currently being executed finishes? Why is the streamoff
or queue release needed?

Best regards,
Tomasz

>
> This does require that you call get_device before calling video_unregiste=
r_device,
> otherwise everything might be released at that point.
>
> Instead of vb2_queue_release() you might have to call uvc_queue_streamoff=
,
> but note that there are two queues here: video and meta. The code above
> just calls streamoff for the video device.
>
> For the meta device I think you can just use vb2_video_unregister_device(=
)
> directly, since that sets vdev->queue and vdev->queue.lock to the correct
> values. That would just leave the video device where you need to do this
> manually.
>
> Regards,
>
>         Hans
>
> > +
> > +             /*
> > +              * Now the vdev is not streaming and all the ioctls will
> > +              * return -ENODEV
> > +              */
> >
> >               uvc_debugfs_cleanup_stream(stream);
> >       }
> >
>

