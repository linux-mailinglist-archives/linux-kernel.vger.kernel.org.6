Return-Path: <linux-kernel+bounces-403156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13419C31BA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2305FB20F65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872914B95A;
	Sun, 10 Nov 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="War74eiG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940B155756
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236406; cv=none; b=r/zn6FGZZ6+43ntTxfb4qhsGBaPFFMri5EPIfwyFiIjPi1a0xEi8ZoLW6kRnAKs3IkOIX/4vZ5qJE/Hya1er1xYoThMaR2uFaEbRKH8df5maDGSLhf2z8bInzgHBUFfPQzQVtulwGE0scBuupcTC03/1BqTRvpC6h6TkHcyFJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236406; c=relaxed/simple;
	bh=hd9MxZmaHUtz1GKr3sObWuJOomwjoTrZHnjIWaw4wx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLnpDsSKdyPYkuBYxynukxFOmgk0ISNzyZHmIahfXKBG9Qwp1ZbikpVrx5ZowOgT/5U292TlhK5UvNFYG/szLKur/5ca5HpTHWAjN5Co6gml7QX2ZHeUHnJ2PK+Gq93aEvgmekicu1+wKRmQ7Kug9vdy0Cq1g6rDwqyv9CKjpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=War74eiG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so3074818b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 03:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731236404; x=1731841204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMpDe5w9iUW90NujS3qbzllTGg6PQPGBsS1EJKhPt2k=;
        b=War74eiGt6Irw3sgnHUsjdSPAc1w67UqKRNtxc/HN98PZV2D+VgRc97KG7yy3ymlUP
         gt4CmhAGDzoZPZuZGZyqWv1e6iP8iQ8Kd6LM1X9tdUUYERB6/fKh2teduSMLwOOeIyrW
         Cluw3Qlh5Zrj61nmDUSi/b1YwxJk/8fw1hJ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731236404; x=1731841204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMpDe5w9iUW90NujS3qbzllTGg6PQPGBsS1EJKhPt2k=;
        b=q1wVYKARzN5eUnSQbILy5rZlIk+bofkG8FzPMve4JaFzueY1ZV9yBu1hXJbKsGLW3W
         LhgMnlcowXjUAs/l5kkdm5ZG0LU66+kcYSgZb161NkvTYTeXjSgMYnX5IdgM58kx0siw
         4IQvPvLT4sE1/G2fe56CIBLDNVORt/h/CUEOWG3YVNQiSrHsKhDfB5u4hsSb4B07l74b
         ewc6x6BCkux05ZPqrtpgMK+O2SJEox+Nq6gmDuQ44ebh2NS/ErwvOiVHAbuA4Z6Kmshm
         lbPuO5oNc+MzUOJPMEbEVanj8Ymwb6JmTNCJQCZ2Fqux2EdZhElcB8cCbnOV4yZ19jXX
         gNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbEps9XKJZdyqIS9J8hd27jyjGePin1ORRE8Am7RR75ZvLpOXRjFpnZlN8mYCC+zPi/Q2XfkGBmbyKKRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG734iFS8X5tfqdHKkt7gFFss/Z97KflG+VS0l7Mjfm7YgWBYt
	5aU+k0aOSjse8tzCHVx/9YQpC4PMbEY2qZwko9HZ2AIEXaH9cJtlrtXfZX/++DcCf2/zn63Z7ms
	=
X-Google-Smtp-Source: AGHT+IEdKy8zmRWjkP07fh9+J8Al6vGIvXseBEBeFye11BLezlAOV/yVxSSUpdJjcq0FNgLLQLzVXA==
X-Received: by 2002:a05:6a00:14d3:b0:71d:ee1b:c854 with SMTP id d2e1a72fcca58-724132a134dmr13035026b3a.9.1731236403908;
        Sun, 10 Nov 2024 03:00:03 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d44sm6901464b3a.114.2024.11.10.03.00.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 03:00:02 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso2642372a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 03:00:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO5Z8kIrum/e6qZQFHTizKmQMfF6hrx6dnAUe0D9mGXPwi9PEDAN37xT4FmpC+vTydK+534HaJCJe/YLY=@vger.kernel.org
X-Received: by 2002:a17:90b:53c6:b0:2e2:cf5c:8edf with SMTP id
 98e67ed59e1d1-2e9b170eaf9mr12405962a91.9.1731236401269; Sun, 10 Nov 2024
 03:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com> <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110110257.5160a7d1@foz.lan> <CANiDSCvYo8=x_QAeg0_S=_H=R1EgM9xLUy4DXURcuEadYcQjQQ@mail.gmail.com>
In-Reply-To: <CANiDSCvYo8=x_QAeg0_S=_H=R1EgM9xLUy4DXURcuEadYcQjQQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 10 Nov 2024 11:59:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCsE5A+gH5gVuZBPJZ=Jnxer2-44AWUG+OaV73mr=0SoFA@mail.gmail.com>
Message-ID: <CANiDSCsE5A+gH5gVuZBPJZ=Jnxer2-44AWUG+OaV73mr=0SoFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 11:32, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Mauro
>
> On Sun, 10 Nov 2024 at 11:03, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Sat, 9 Nov 2024 17:29:54 +0100
> > Ricardo Ribalda <ribalda@chromium.org> escreveu:
> >
> > > >
> > > > I think that should sort the issue, assuming that 1. above holds true.
> > > >
> > > > One downside is that this stops UVC button presses from working when
> > > > not streaming. But userspace will typically only open the /dev/video#
> > > > node if it plans to stream anyways so there should not be much of
> > > > a difference wrt button press behavior.
> > >
> > > I do not personally use the button, but it is currently implemented as
> > > a standard HID device.
> >
> > IMO, controlling the privacy via evdev is the best approach then. There's
> > no need for a RW control neither at subdev or at device level. It could
> > make sense a Read only to allow apps to read, but still it shall be up to
> > the Kernel to protect the stream if the button is pressed.
> >
> > > Making it only work during streamon() might be
> > > a bit weird.
> > > I am afraid that if there is a button we should keep the current behaviour.
> >
> > Privacy matters only when streaming. IMO the Kernel check for it needs to
> > be done at DQBUF time and at read() calls, as one can enable/disable the
> > camera while doing videoconf calls. I do that a lot with app "soft" buttons,
> > and on devices that physically support cutting the video.
> >
> > I don't trust myself privacy soft buttons, specially when handled in userspace,
> > so what I have are webcam covers (and a small stick glued at a laptop camera
> > that has a too small sensor for a webcam cover). I only remove the cover/stick
> > when I want to participate on videoconf with video enabled with the builtin
> > camera.
> >
> > Regards
>
> I think we are mixing up concepts here.
>
> On one side we have the uvc button. You can see one here
> https://www.sellpy.dk/item/2Yk1ZULbki?utm_source=google&utm_medium=cpc&utm_campaign=17610409619&gad_source=1&gclid=Cj0KCQiA0MG5BhD1ARIsAEcZtwR9-09ZtTIVNbVknrZCtCd7ezVM8YFw1yQXfs81FWhofg9eW-iBrsIaAopVEALw_wcB
> That button is not represented as a hid device. We do not know how the
That button is NOW represented as a hid device. sorry :)
> user will use this button. They could even use it to start an app when
> pressed.
>
> On the other side we have  the privacy gpio. The chassis has a switch
> that is connected to the camera and to the SOC. You can see one here:
> https://support.hp.com/ie-en/document/ish_3960099-3335046-16 .We link
> the camera with a gpio via the acpi table. When the user flips the
> button, the camera produces black frames and the SOC gets an IRQ. The
> IRQ is used to display a message like "Camera off" and the value of
> the GPIO can be checked when an app is running to tell the user:
> "Camera not available, flip the privacy button if you want to use it."
> Userspace cannot change the value of the gpio. It is read-only,
> userspace cannot override the privacy switch. The privacy gpio is
> represented with a control in /dev/videoX This patchset wants to move
> it to /dev/v4l2-subdevX
>
> To make things more complicated. Recently some cameras are starting to
> have their own privacy control without the need of an external gpio.
> This is also represented as a control in /dev/videoX.
>
>
> Now that we have these 3 concepts in place:
>
> Today a uvc camera is powered up when /dev/videoX is open(), not when
> it is streaming. This means that if we want to get an event for the
> privacy gpio we have to powerup the camera, which results in power
> consumption. This can be fixed by moving the control to a subdevice
> (technically the gpio is not part of the camera, so it makes sense).
>
> If we only powerup the camera during streamon we will break the uvc
> button, and the async controls.
>
>
>
> >
> > Thanks,
> > Mauro
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

