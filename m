Return-Path: <linux-kernel+bounces-438347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26D9E9FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC3F163C60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304319AD8B;
	Mon,  9 Dec 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPKbWJ13"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89231199EB0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774548; cv=none; b=UwQ11/U/DifgymfOgfZhvYHFwzUglApwGTVmqnfHvv8HYNKyBxup98tko3dHvtvCsoGZ9T/avoYGlW7HhqMZ7fp8m9WCf0swsdS6vO28bdqCWC0P1wU6Hi87HozEe9vSeOinrakb2YUJqxpGRPvn3rUA0Nl9iqFRWY1bJhuGs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774548; c=relaxed/simple;
	bh=0Ayw37wUejtQ5m+rsSeIg82/mR7t7LSqI1T/BKoym3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZDI8VPiqSDxUwjnVH7N7p6Y5+pPvlTWvrsLaIjy3/5h78Y9VYHk4Zhqsfkw+hUjLYFG2psrF958NdEoA00o1/Qjp82BqWkAHMS2hL2KdMT0XmEbMX6rszFTLfj9hT2n0dvM+7QTpvkPJgmDY07T+tTyy+RZyU1X772XKJTj888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SPKbWJ13; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so2435081a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733774545; x=1734379345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33O92irM5rjPnkOEmFcL92w9iQOp7kWbD3T8HmnoBQA=;
        b=SPKbWJ13k39Wf92jyRB9iSPFPOm3geiZcsEwfFAIi3TTW/rbKzIYXUT3eQPaBf0lFp
         3j9oo4aaE/n/0AxL0TSf14zA942wbpDKZXziprgjI+5sFaQ2QTWJ07NWMyrdcEUmSSDa
         sk1KJAhvHgMDnrhOv0ehTpPcMt2BbbsbERZKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774545; x=1734379345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33O92irM5rjPnkOEmFcL92w9iQOp7kWbD3T8HmnoBQA=;
        b=LAAetNFnwWOf0XXpdyNxTNo+CeqsebmJXuvr6eHm2x4375GjNxGq8nuM9zREDJPqQW
         NVPRWF7QtLYJbK9wVt8OU3s6zUkLo8BUkmp+dOYBhQ4EeTjBA+DiIyAhR2m8PcgbIOCp
         1NLvSVmT/82rDdwFgon1+VAKjX3B5/koGWwMFoy5IK1PSbKfFe5f2IesZgQGEY9FzQ3R
         ZZU5WLrRQofBwGAPZao17kLhQnFjesS7WXwgQbp33imD5Kdp2pelmAHzHEie83Jf7VTU
         cEqf1VXphiyOq3CG+XUrEHn9t1FpijGtmFnslgfWYOWe2BEdXm/0S568MnLWzi80c0iZ
         xn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV20MtYPn82dKnIw50ldhercxE3DTIL3Z8IlIcZ1h0AQy7+MpJAvXpQYJoSFUwN9WNxV16ueRMPO9mcmNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSTNnU4pVtuB6PtSvrbfps6PbFI7vVG/K8BV3qh6DH+p8kd4B
	imefMKpW/PO5OgGuWaKNfK8h+fqJpUARPURxUdlLrFuoNgJB3ne/ABpHI8i0E9MZumlRmIR6MFE
	=
X-Gm-Gg: ASbGncuRw5PEOLdBW7bJNpaZGwZBezlxREIwXCJ1kleuhnJFF7xDMyx2Zu89btvx6YM
	W+faasSOgs8Xz6XQFx7YIzsT+Kb8Cmvtbi9lkV/qdrhyHhHuHLzxBPLettPr22cA5FhMpMXLpJ9
	bZ0a/7FlA8JbMYkgAasdY7AKYLuKE/y9j31NBrqcmfGiY74yH5xarRIY0viNFXEgFzGjHjQgN8x
	66PhRAiaiCUQOk8nYA5oF3Hn05ShNFQAVAF2TTtWgk3HVM/Yf7AQpbUUBk52Qh+2Tis0tGfAzyv
	qDxHfSU6YfQhwvvz
X-Google-Smtp-Source: AGHT+IFLGkcK+jvo7AdXcDhNUTg2qvhs5v91KByVWpZoaMGM6jtsu6yAwADe1u5IzcsSkIXlJwCd0w==
X-Received: by 2002:a17:90b:4c48:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2efd5a9749bmr933170a91.5.1733774545634;
        Mon, 09 Dec 2024 12:02:25 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef67d6ea84sm7459336a91.47.2024.12.09.12.02.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 12:02:24 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso4662019a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:02:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuF8vi4G4oMW/gmwLHen+hdjm+TxColA+SJt6QehTQZLLDKqsngUngtP4Gj09YCr80ZB7j1b2+GnyOIZE=@vger.kernel.org
X-Received: by 2002:a17:90b:50e:b0:2ef:6cbd:3c0b with SMTP id
 98e67ed59e1d1-2efd5869946mr938178a91.3.1733774543037; Mon, 09 Dec 2024
 12:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
 <20241209-queryctrl-v1-1-deff7acfcdcb@chromium.org> <4bd4796f-858a-48f7-9b32-ef6991ebe194@xs4all.nl>
In-Reply-To: <4bd4796f-858a-48f7-9b32-ef6991ebe194@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 21:02:11 +0100
X-Gmail-Original-Message-ID: <CANiDSCt_rpf=RjTYR+Fmy4fsWb0z6J5NU7iKrERDmvUrcxZwig@mail.gmail.com>
X-Gm-Features: AZHOrDlRlIITa-MC0kxLj6pBufnFBS38Pperkg5q-RePWpzWtd1V-2fTVWLSvh4
Message-ID: <CANiDSCt_rpf=RjTYR+Fmy4fsWb0z6J5NU7iKrERDmvUrcxZwig@mail.gmail.com>
Subject: Re: [PATCH 01/10] media: ioctl: Simulate v4l2_queryctrl with v4l2_query_ext_ctrl
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Mike Isely <isely@pobox.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Mon, 9 Dec 2024 at 20:34, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/12/2024 20:25, Ricardo Ribalda wrote:
> > v4l2_queryctrl is a subset of v4l2_query_ext_ctrl. If the driver does
> > not implement v4l2_queryctrl we can implement it with
> > v4l2_query_ext_ctrl.
> >
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/v4l2-core/v4l2-dev.c   |  3 ++-
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 22 +++++++++++++++++++++-
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> > index 5bcaeeba4d09..252308a67fa8 100644
> > --- a/drivers/media/v4l2-core/v4l2-dev.c
> > +++ b/drivers/media/v4l2-core/v4l2-dev.c
> > @@ -572,7 +572,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
> >          and that can't be tested here. If the bit for these control ioctls
> >          is set, then the ioctl is valid. But if it is 0, then it can still
> >          be valid if the filehandle passed the control handler. */
> > -     if (vdev->ctrl_handler || ops->vidioc_queryctrl)
> > +     if (vdev->ctrl_handler || ops->vidioc_queryctrl ||
> > +         ops->vidioc_query_ext_ctrl)
> >               __set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
> >       if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
> >               __set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index 0304daa8471d..a5562f2f1fc9 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -2284,9 +2284,11 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
> >                               struct file *file, void *fh, void *arg)
> >  {
> >       struct video_device *vfd = video_devdata(file);
> > +     struct v4l2_query_ext_ctrl qec;
> >       struct v4l2_queryctrl *p = arg;
> >       struct v4l2_fh *vfh =
> >               test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
> > +     int ret;
> >
> >       if (vfh && vfh->ctrl_handler)
> >               return v4l2_queryctrl(vfh->ctrl_handler, p);
> > @@ -2294,7 +2296,25 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
> >               return v4l2_queryctrl(vfd->ctrl_handler, p);
> >       if (ops->vidioc_queryctrl)
> >               return ops->vidioc_queryctrl(file, fh, p);
> > -     return -ENOTTY;
> > +     if (!ops->vidioc_query_ext_ctrl)
> > +             return -ENOTTY;
> > +
> > +     /* Simulate query_ext_ctr using query_ctrl. */
> > +     qec.id = p->id;
> > +     ret = ops->vidioc_query_ext_ctrl(file, fh, &qec);
> > +     if (ret)
> > +             return ret;
> > +
> > +     p->id = qec.id;
> > +     p->type = qec.type;
> > +     strscpy(p->name, qec.name, sizeof(p->name));
> > +     p->minimum = qec.minimum;
> > +     p->maximum = qec.maximum;
> > +     p->step = qec.step;
> > +     p->default_value = qec.default_value;
> > +     p->flags = qec.flags;
>
> That's not quite correct. See v4l2_queryctrl() in v4l2-ctrls-api.c
> on how to do this: for types that VIDIOC_QUERYCTRL doesn't support,
> some of these fields must be set to 0.
>
> In fact, once vidioc_queryctrl has been removed, then you can also
> remove v4l2_queryctrl() and just rely on this code. Unless I missed
> something.

Thanks for the mega-fast review :)

I do not think that we can easily remove v4l2_queryctrl(). It is still
called by v4l2-subdev.c

We could do something to remove the code duplication... but it will
probably make the code more difficult to follow.

I will send a new version with the fix that you proposed, as well as:

-- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2290,10 +2290,6 @@ static int v4l_queryctrl(const struct
v4l2_ioctl_ops *ops,
                test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
        int ret;

-       if (vfh && vfh->ctrl_handler)
-               return v4l2_queryctrl(vfh->ctrl_handler, p);
-       if (vfd->ctrl_handler)
-               return v4l2_queryctrl(vfd->ctrl_handler, p);
        if (!ops->vidioc_query_ext_ctrl)
                return -ENOTTY;

>
> Regards,
>
>         Hans
>
> > +
> > +     return 0;
> >  }
> >
> >  static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,
> >
>


-- 
Ricardo Ribalda

