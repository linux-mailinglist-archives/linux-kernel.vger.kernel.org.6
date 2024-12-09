Return-Path: <linux-kernel+bounces-438427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402739EA139
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59BD280DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10388199FC1;
	Mon,  9 Dec 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nuvt+W+X"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0319A288
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779584; cv=none; b=cmuyH3/5BcMnMRr5z+v2SP4yhgwoK95MNQxQaVSt18GjAa7Pl9E6B7jburB9nlnXVm2SyBW50H4cCaD3eZ60h/YREuTtFfGAdoXdYG5h9myUih1SMCAGz8tNtC/XxNTWNRxHzpS5dia1nS6LyTRp9CRn7OGF6DjajDjTuN6tGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779584; c=relaxed/simple;
	bh=LGMZUnYe8iHvq/5eUJ1IfXuB2btk9eOij72HmxMY7Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXDPl9A7lu0cqycqRmCcJl0eDIjYmA0AQJpsEWWLwN3dQx53jTQE7R+Lq6MvTDR37NNFaWhdCMOAoAsAZo4kASYbtKrjmk7kRrPGxc6fVchtm7Xm3F8qn2JxtnLJNt2LRj10PmIkWmaQxQAsacXtX+Wf89oeR3akLpBfbbCIAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nuvt+W+X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2162c0f6a39so19852295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733779582; x=1734384382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6idwqeXE/MDvDjAbT1MWejPhgLZPC4983El4drMBYE=;
        b=Nuvt+W+XC4Ze4J9ZzuMdtBgqrnXJBMwZJiWj5MwFQ5Xdr0akUwv0v6xn1D9HO3NZlO
         /r51cZtxfUPkVF+oUPgKxp++8cJ2uccdKDAoj0QvXOhqyj0VV6u15X8k1Nd1TKFITAwk
         bral9BfyMj1uzN37I0hyi+JwfX6IqlyWgZHLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733779582; x=1734384382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6idwqeXE/MDvDjAbT1MWejPhgLZPC4983El4drMBYE=;
        b=pdZatxyigjt9BH5W9ZJ/xgu2NNejHnxikUkD41ExuThPTkkUIBU6MSThO7lKqnsenW
         4bh+6COfCFhhef5Xdel9VvnHs9RHIelAmoV/wNbCyxeuLSLQermF1rMlyXoOL6gMswVo
         wiDZEjILTbQyTt1aIYTMlO4BFawoaarViH5cxyZG/0u7xD8OGdO2h2KJsCEPgpSwbTuE
         oWU8SFz7UZ6SSOmo78nHlrNg2U8wf2VfwAJxx69EVY/9D2URhpjtDqK29LWD/wIFYDe4
         v9K9qvdukRIhwNEdeE2HTSATJ87+/PrkDudgsZTqVZrgqlLwP7UXh5Bag69DwijF94H3
         i18w==
X-Forwarded-Encrypted: i=1; AJvYcCURskxkNNRhTSfsbJ83f/dM9WiurfhA41nGPsJdWqF9LLPDNA1mDtEgnHuc6ETFmUrAQ38qZBceGg/37Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgpn677utuUuLilpSNSY04AL8vfvRdXzbLBFTRTDRKKXRnjzkO
	mopCzC4xwq28MYlBK4ezhcaLncTqt+/6hpYZ7lqIW+36QWCvZgpRBqAB9KZ2Y2WUEVpRiZV4c3w
	=
X-Gm-Gg: ASbGncvH/hDOTqppCjIzlx/5m0pvpmLkC7ojrh2UjMibc//h4WxHFuGoB8khHucWJ0M
	Z+XJWjtB1QJ8IMgSPIuUAAnCQvR5zUZ1h9nVKkWs/pDhq+AOcQKQJgi47lqmpL+DcMeLTPhxbTj
	lR+KKgMy4ljrSR2KiEBUlmt6+kZZTG2+YM7GDdL6oRKvkpj6GRJjhToviaZ0SGhqRDCcthxo8Jo
	/ZhOC1Z8nrCgN3QOaF04BbHEB1muDxRH7ulrbZWnSYvuJU0xgTskYU5Aks71xd1AvlOkvyTx4FM
	FHdcXWzY6ajHUjc4pyz8
X-Google-Smtp-Source: AGHT+IHB/uoogOvVAja2MtaTBxT+NHf/Xu2llFof2Gs4nop2itgv1XTmk3rvc7t1ALd6jvXM5cebdA==
X-Received: by 2002:a17:902:cecf:b0:216:6be9:fd48 with SMTP id d9443c01a7336-216709d65fdmr13261305ad.3.1733779581781;
        Mon, 09 Dec 2024 13:26:21 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162bd745b4sm44512285ad.73.2024.12.09.13.26.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 13:26:21 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21631789fcdso13231985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW79XkeudwLZpOVL4/vFuXKmcgFDqkCX1hb22nPvGp6IsQV89OL0L9bOrSjzZLzcf76kZJ2fgMz9ANzHro=@vger.kernel.org
X-Received: by 2002:a17:90b:3805:b0:2ea:61c4:a443 with SMTP id
 98e67ed59e1d1-2efd58699b7mr1287425a91.4.1733779580155; Mon, 09 Dec 2024
 13:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
 <20241209-queryctrl-v1-1-deff7acfcdcb@chromium.org> <4bd4796f-858a-48f7-9b32-ef6991ebe194@xs4all.nl>
 <CANiDSCt_rpf=RjTYR+Fmy4fsWb0z6J5NU7iKrERDmvUrcxZwig@mail.gmail.com>
In-Reply-To: <CANiDSCt_rpf=RjTYR+Fmy4fsWb0z6J5NU7iKrERDmvUrcxZwig@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 22:26:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCsmTfyVPN7ExDEGQ54gNcEQb7jC1JJ5zgrwE38tu+uYbw@mail.gmail.com>
X-Gm-Features: AZHOrDm4lv503GGwvfdGmeP052uXzeNZJu1iaDoQ9PyURITZVBtA271vDk9LqF8
Message-ID: <CANiDSCsmTfyVPN7ExDEGQ54gNcEQb7jC1JJ5zgrwE38tu+uYbw@mail.gmail.com>
Subject: Re: [PATCH 01/10] media: ioctl: Simulate v4l2_queryctrl with v4l2_query_ext_ctrl
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Mike Isely <isely@pobox.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 21:02, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Hans
>
> On Mon, 9 Dec 2024 at 20:34, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 09/12/2024 20:25, Ricardo Ribalda wrote:
> > > v4l2_queryctrl is a subset of v4l2_query_ext_ctrl. If the driver does
> > > not implement v4l2_queryctrl we can implement it with
> > > v4l2_query_ext_ctrl.
> > >
> > > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-dev.c   |  3 ++-
> > >  drivers/media/v4l2-core/v4l2-ioctl.c | 22 +++++++++++++++++++++-
> > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> > > index 5bcaeeba4d09..252308a67fa8 100644
> > > --- a/drivers/media/v4l2-core/v4l2-dev.c
> > > +++ b/drivers/media/v4l2-core/v4l2-dev.c
> > > @@ -572,7 +572,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
> > >          and that can't be tested here. If the bit for these control ioctls
> > >          is set, then the ioctl is valid. But if it is 0, then it can still
> > >          be valid if the filehandle passed the control handler. */
> > > -     if (vdev->ctrl_handler || ops->vidioc_queryctrl)
> > > +     if (vdev->ctrl_handler || ops->vidioc_queryctrl ||
> > > +         ops->vidioc_query_ext_ctrl)
> > >               __set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
> > >       if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
> > >               __set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > index 0304daa8471d..a5562f2f1fc9 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -2284,9 +2284,11 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
> > >                               struct file *file, void *fh, void *arg)
> > >  {
> > >       struct video_device *vfd = video_devdata(file);
> > > +     struct v4l2_query_ext_ctrl qec;
> > >       struct v4l2_queryctrl *p = arg;
> > >       struct v4l2_fh *vfh =
> > >               test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
> > > +     int ret;
> > >
> > >       if (vfh && vfh->ctrl_handler)
> > >               return v4l2_queryctrl(vfh->ctrl_handler, p);
> > > @@ -2294,7 +2296,25 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
> > >               return v4l2_queryctrl(vfd->ctrl_handler, p);
> > >       if (ops->vidioc_queryctrl)
> > >               return ops->vidioc_queryctrl(file, fh, p);
> > > -     return -ENOTTY;
> > > +     if (!ops->vidioc_query_ext_ctrl)
> > > +             return -ENOTTY;
> > > +
> > > +     /* Simulate query_ext_ctr using query_ctrl. */
> > > +     qec.id = p->id;
> > > +     ret = ops->vidioc_query_ext_ctrl(file, fh, &qec);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     p->id = qec.id;
> > > +     p->type = qec.type;
> > > +     strscpy(p->name, qec.name, sizeof(p->name));
> > > +     p->minimum = qec.minimum;
> > > +     p->maximum = qec.maximum;
> > > +     p->step = qec.step;
> > > +     p->default_value = qec.default_value;
> > > +     p->flags = qec.flags;
> >
> > That's not quite correct. See v4l2_queryctrl() in v4l2-ctrls-api.c
> > on how to do this: for types that VIDIOC_QUERYCTRL doesn't support,
> > some of these fields must be set to 0.
> >
> > In fact, once vidioc_queryctrl has been removed, then you can also
> > remove v4l2_queryctrl() and just rely on this code. Unless I missed
> > something.
>
> Thanks for the mega-fast review :)
>
> I do not think that we can easily remove v4l2_queryctrl(). It is still
> called by v4l2-subdev.c
>
> We could do something to remove the code duplication... but it will
> probably make the code more difficult to follow.
>
> I will send a new version with the fix that you proposed, as well as:
>
> -- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -2290,10 +2290,6 @@ static int v4l_queryctrl(const struct
> v4l2_ioctl_ops *ops,
>                 test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
>         int ret;
>
> -       if (vfh && vfh->ctrl_handler)
> -               return v4l2_queryctrl(vfh->ctrl_handler, p);
> -       if (vfd->ctrl_handler)
> -               return v4l2_queryctrl(vfd->ctrl_handler, p);
>         if (!ops->vidioc_query_ext_ctrl)
>                 return -ENOTTY;

Actually we cannot remove these four lines. I have a set ready with a helper....
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commits/queryctrl
Not sure if it is better with or without the helper.

Will send it tomorrow if I do not have more feedback.

Best rergards!


>
> >
> > Regards,
> >
> >         Hans
> >
> > > +
> > > +     return 0;
> > >  }
> > >
> > >  static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,
> > >
> >
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

