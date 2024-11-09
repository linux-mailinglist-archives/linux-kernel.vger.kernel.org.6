Return-Path: <linux-kernel+bounces-402924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6A9C2E7E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9121F21AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7419CD07;
	Sat,  9 Nov 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPD8E6C7"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2D193075
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169813; cv=none; b=A03KQyX+k4o3bERqHtiH9SjnM9EmnFXY/Xa+20Sg2Bus48bkD67qAfHMv787BhKI9g14NJKO2yycI2hqSod/mBUVVQk/kBZuPer0AWtWz6LnOc2453E9LEBtjHIuUEVdb6NP0chhDQ1x+eMUyJl0BBMb2UynstAq5P6w8PT3UHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169813; c=relaxed/simple;
	bh=U8UHl4wxz4PNA6EqtybfF3/n2H684L2xaa0g7707FiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL2/93xAE8asjAQ2P1X8Yk5D/AyehnL7L1nXIrSVce4F72GaPGHnsW1HP9KIMRYdBxo8Lrs6inFoWJwHvUVvZ2IPAVs5KtQxn9YVwU7z8e/n5X1FDSvZoAF/XuVajPWoGJAT/P6kJN9VLn4GsEOL2zhPXwpI7lWTqhZbp8in2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LPD8E6C7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2633918a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731169811; x=1731774611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9d693ktclz3c49fcxPFHwUNwkVVUFVCGgr6pF/KAtZw=;
        b=LPD8E6C7F9tRBJfEyE77FKncEDvFfqCVO0aQ+yA9BcXnI/8O6+kl9ho9tqw17ewVDG
         mxuf/gUBXFCnWfo7A4n+nh5CN0rpg8ulrNLUJsazvbRZ+8nmHDpe7o9HOtcucLB38q2c
         EvojRIPoUR3cnC4FRzxOhpeJRuoj2hMQRPDKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169811; x=1731774611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d693ktclz3c49fcxPFHwUNwkVVUFVCGgr6pF/KAtZw=;
        b=lmc8vpyq9/gcfXEwRrtIMXwM/Dr32im8Gj1YtiOLAuYIvbYFeXwxoX36qSNplXG3X2
         AavYcWiB3ZZjhBVG+b3yk1bjXwMHvnpanSckDcjlo+baqq6BLD7j1EGPu5QAWeviTI0W
         b2zezXUgxNxF09ZLZ9Gevat0n1U5v7WqVddOHUoZWH6+746+vzDtJkPpkKDHBhXq7VPa
         aQ4DLx+COT4FqTTQ+aZA0gYEXsdJT7lN7fHNHAhHOamGZQX2URWRPXe3RtPPPcguGDGK
         P7fVE4pIgRbwFR5g3i+o7hK4GQ43kcYHeKhF7uQ5oj3xKblWKkzPfUqMn1T7McnUwMOn
         I7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTaB380j5RxdZRNw36+A+N/t8w5ON3C3vb9xQOlxekMAHSSp5AT/wL4qpklazr0Vsrb14SOVQvgrFr9/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVVZ4XtMrDrMZZNIWtGnLoAMzO54uuL31mhOFhU8sFJsZ4g9M
	XT3bHcO6wIQWE/vh0O+8jDol1jyhqTFLhyvA3YcoO1vmTS2wS7nLUEOq5Ktaz+a+topHtbznqDE
	=
X-Google-Smtp-Source: AGHT+IHnneGz+vJPYN1PnbCislrY9v/O+p3HVMcF8MCCXiA5fPeYNGU84U/YoWhMYkp3X7EbHOK+aw==
X-Received: by 2002:a17:90b:3c42:b0:2e2:b211:a4da with SMTP id 98e67ed59e1d1-2e9b1708091mr9281166a91.14.1731169810762;
        Sat, 09 Nov 2024 08:30:10 -0800 (PST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a349sm48260325ad.219.2024.11.09.08.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:30:09 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca388d242so34289485ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 08:30:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVI6QmEK/KjT8XFnj65rwJl7RJvc4mVQBcEpJesY/vvvDtloACJGyWe8xP97jD69LK0ViWlFs/9Z3cVce4=@vger.kernel.org
X-Received: by 2002:a17:902:d508:b0:20c:8cf9:6133 with SMTP id
 d9443c01a7336-21183d0b82cmr98510815ad.8.1731169808130; Sat, 09 Nov 2024
 08:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org> <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
In-Reply-To: <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 9 Nov 2024 17:29:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Message-ID: <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Sat, 9 Nov 2024 at 16:37, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> FYI / some background: I have been asked to start helping /
> co-maintaining UVC with Laurent. I'll send out a patch adding
> myself as UVC maintainer soon.

Great! I talked with Laurent yesterday, I hope that we can maintain
the driver the three of us in the near future.

>
> On 8-Nov-24 9:25 PM, Ricardo Ribalda wrote:
> > Some notebooks have a button to disable the camera (not to be mistaken
> > with the mechanical cover). This is a standard GPIO linked to the
> > camera via the ACPI table.
> >
> > 4 years ago we added support for this button in UVC via the Privacy control.
> > This has two issues:
> > - If the camera has its own privacy control, it will be masked
> > - We need to power-up the camera to read the privacy control gpio.
> >
> > We tried to fix the power-up issues implementing "granular power
> > saving" but it has been more complicated than anticipated....
>
> I have been discussing UVC power-management with Laurent, also
> related to power-consumption issues caused by libcamera's pipeline
> handler holding open the /dev/video# node as long as the camera
> manager object exists.
>
> For now we have fixed this with some relatively small changes to
> libcamera's uvcvideo pipeline handler, but that is really meant
> as an interim solution and as this privacy control series shows
> the power-management issues are real.

Indeed, we have tried to fixed it before:
https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/

btw this recently landed patch was to work in this direction :)
https://lore.kernel.org/linux-media/20240926-guenter-mini-v7-1-690441953d4a@chromium.org/

The more people interested in this problem the better.

>
> Combined with Mauro's remarks about how this is an userspace ABI break (1)
> I think we should maybe first take another look at the powermanagement
> issues in general rather then moving forward with this series.
>
> My apologies for this, I realize how annoying it can be when you are
> working on a patch series to fix a specific issue and a reviewer
> moves the goal-posts like this. But I do really think that just fixing
> the generic power-management issues would be better and I also think
> that this should be feasible / not too hard.
>
> Here is what I have in mind for this:
>
> 1. Assume that the results of trying a specific fmt do not change over time.
>
> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
>    enum-frame-sizes -> enum-frame-rates tripplet results
>    (constrain what userspace requests to these)
>
> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
>    3 levels nested loop for this) on probe() and cache the results
>
> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
>    the requested fmt to one from our cached fmts
>
> 5. On stream-on do the actual power-on + set-fmt + verify that we get
>    what we expect based on the cache, and otherwise return -EIO.

Can we start powering up the device during try/set fmt and then
implement the format caching as an improvement?
Laurent mentioned that some cameras missbehave if a lot of controls
are set during probing. I hope that this approach does not trigger
those, and if it does it would be easier to revert if we do the work
in two steps.

>
> I think that should sort the issue, assuming that 1. above holds true.
>
> One downside is that this stops UVC button presses from working when
> not streaming. But userspace will typically only open the /dev/video#
> node if it plans to stream anyways so there should not be much of
> a difference wrt button press behavior.

I do not personally use the button, but it is currently implemented as
a standard HID device. Making it only work during streamon() might be
a bit weird.
I am afraid that if there is a button we should keep the current behaviour.

>
> This should also make camera enumeration faster for apps, since
> most apps / frameworks do the whole 3 levels nested loop for this
> on startup, for which atm we go out to the hw, which now instead
> will come from the fmts cache and thus will be much much faster,
> so this should lead to a noticeable speedup for apps accessing UVC
> cameras which would be another nice win.
>
> Downside is that the initial probe will take longer see we do
> all the tryfmt-s there now. But I think that taking a bit longer
> to probe while the machine is booting should not be an issue.

How do you pretend to handle the controls? Do you plan to power-up the
device during s_ctrl() or set them only during streamon()?
If we power-up the device during s_ctrl we need to take care of the
asynchronous controls (typically pan/tilt/zoom), The device must be
powered until the control finishes, and the device might never reply
control_done if the firmware is not properly implemented.
If we set the controls only during streamon, we will break some
usecases. There are some video conferencing equipment that do homing
during streamoff. That will be a serious API breakage.

This patchset is not only to fix the powersaving issues, but also to
fix the issue when a camera has  a gpio privacy switch and an internal
Privacy control.  4 years ago I did not see any camera with Privacy
control (in 100s of models), now they are common.
Can we have both changes, gpio subdevice and granular power saving?

>
> Regards,
>
> Hans
>
>
> 1) Which is technically correct, but FWIW I agree with you that I think
> most userspace consumers will not care
>
>
>
>
> > Last year, we proposed a patchset to implement the privacy gpio as a
> > subdevice https://lore.kernel.org/linux-media/20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org/
> >
> > I think it is a pretty clean solution and makes sense to use a
> > subdevice for something that is a sub device of the camera :).
> >
> > This is an attempt to continue with that approach.
> >
> > Tested on gimble:
> > gimble-rev3 ~ # v4l2-ctl --all -d /dev/v4l-subdev0
> > Driver Info:
> >         Driver version   : 6.6.56
> >         Capabilities     : 0x00000000
> > Media Driver Info:
> >         Driver name      : uvcvideo
> >         Model            : HP 5M Camera: HP 5M Camera
> >         Serial           : 0001
> >         Bus info         : usb-0000:00:14.0-6
> >         Media version    : 6.6.56
> >         Hardware revision: 0x00009601 (38401)
> >         Driver version   : 6.6.56
> > Interface Info:
> >         ID               : 0x0300001d
> >         Type             : V4L Sub-Device
> > Entity Info:
> >         ID               : 0x00000013 (19)
> >         Name             : GPIO
> >         Function         : Unknown sub-device (00020006)
> >
> > Camera Controls
> >
> >                         privacy 0x009a0910 (bool)   : default=0 value=0 flags=read-only, volatile
> >
> > gimble-rev3 ~ # media-ctl  -p
> > Media controller API version 6.6.56
> >
> > Media device information
> > ------------------------
> > driver          uvcvideo
> > model           HP 5M Camera: HP 5M Camera
> > serial          0001
> > bus info        usb-0000:00:14.0-6
> > hw revision     0x9601
> > driver version  6.6.56
> >
> > Device topology
> > - entity 1: HP 5M Camera: HP 5M Camera (1 pad, 1 link)
> >             type Node subtype V4L flags 1
> >             device node name /dev/video0
> >         pad0: Sink
> >                 <- "Extension 8":1 [ENABLED,IMMUTABLE]
> >
> > - entity 4: HP 5M Camera: HP 5M Camera (0 pad, 0 link)
> >             type Node subtype V4L flags 0
> >             device node name /dev/video1
> >
> > - entity 8: Extension 8 (2 pads, 2 links, 0 routes)
> >             type V4L2 subdev subtype Unknown flags 0
> >         pad0: Sink
> >                 <- "Extension 4":1 [ENABLED,IMMUTABLE]
> >         pad1: Source
> >                 -> "HP 5M Camera: HP 5M Camera":0 [ENABLED,IMMUTABLE]
> >
> > - entity 11: Extension 4 (2 pads, 2 links, 0 routes)
> >              type V4L2 subdev subtype Unknown flags 0
> >         pad0: Sink
> >                 <- "Processing 2":1 [ENABLED,IMMUTABLE]
> >         pad1: Source
> >                 -> "Extension 8":0 [ENABLED,IMMUTABLE]
> >
> > - entity 14: Processing 2 (2 pads, 2 links, 0 routes)
> >              type V4L2 subdev subtype Unknown flags 0
> >         pad0: Sink
> >                 <- "Camera 1":0 [ENABLED,IMMUTABLE]
> >         pad1: Source
> >                 -> "Extension 4":0 [ENABLED,IMMUTABLE]
> >
> > - entity 17: Camera 1 (1 pad, 1 link, 0 routes)
> >              type V4L2 subdev subtype Sensor flags 0
> >         pad0: Source
> >                 -> "Processing 2":0 [ENABLED,IMMUTABLE]
> >
> > - entity 19: GPIO (0 pad, 0 link, 0 routes)
> >              type V4L2 subdev subtype Decoder flags 0
> >              device node name /dev/v4l-subdev0
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Changes in v2:
> > - Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
> > - Create uvc_gpio_cleanup and uvc_gpio_deinit
> > - Refactor quirk: do not disable irq
> > - Change define number for MEDIA_ENT_F_GPIO
> > - Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org
> >
> > ---
> > Ricardo Ribalda (5):
> >       media: uvcvideo: Factor out gpio functions to its own file
> >       Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
> >       media: uvcvideo: Create ancillary link for GPIO subdevice
> >       media: v4l2-core: Add new MEDIA_ENT_F_GPIO
> >       media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO entity
> >
> > Yunke Cao (1):
> >       media: uvcvideo: Re-implement privacy GPIO as a separate subdevice
> >
> >  .../userspace-api/media/mediactl/media-types.rst   |   4 +
> >  drivers/media/usb/uvc/Makefile                     |   3 +-
> >  drivers/media/usb/uvc/uvc_ctrl.c                   |  40 +----
> >  drivers/media/usb/uvc/uvc_driver.c                 | 123 +-------------
> >  drivers/media/usb/uvc/uvc_entity.c                 |  20 ++-
> >  drivers/media/usb/uvc/uvc_gpio.c                   | 187 +++++++++++++++++++++
> >  drivers/media/usb/uvc/uvc_video.c                  |   4 +
> >  drivers/media/usb/uvc/uvcvideo.h                   |  34 ++--
> >  drivers/media/v4l2-core/v4l2-async.c               |   3 +-
> >  include/uapi/linux/media.h                         |   1 +
> >  10 files changed, 252 insertions(+), 167 deletions(-)
> > ---
> > base-commit: 4353256f5487e0c5c47e8ff764bf4f9e679fb525
> > change-id: 20241030-uvc-subdev-89f4467a00b5
> >
> > Best regards,
>


-- 
Ricardo Ribalda

