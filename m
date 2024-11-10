Return-Path: <linux-kernel+bounces-403297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7049C33C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC9B1F21366
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28C80BF8;
	Sun, 10 Nov 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HcTQ1TS0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F93219ED
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254868; cv=none; b=d4Sb4mZKkCd1nGhDf0jEl5j1pO+dqM4eA89Exvd1Qm+zE//8u7Eu/HhMOPgW3vfd6bkR9b/V8+OFMLrQPuFeeYf++d1c4N9IYXFIusn0zDc0spiGq+nHFhWUwK76WZiX7kQhFGSM08Dss6t5nu4mSG18GDcODsoJylvzKMsHWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254868; c=relaxed/simple;
	bh=v8/Qriah7mMMd1g36X1Of61K4/3lFAL5Q/NV2+4Ihg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okn717KZXCHsEzthg0DwJyhcGOcU57EOFm2TNZofF6dzpuOYm0/gKUn1wlVcrBKLYfaA1RIXeOnZI4LWbjtNk5RZtbisoF4ZQIvyUIIFWKMuE++cDtAXTKxJET48bzB5ndHhN4eVRn48yvnbWiv7oFb6GaZVPVCsinrvxXRGh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HcTQ1TS0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c693b68f5so38061855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731254865; x=1731859665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0skt12aKXCRD6lMwCqaBvTwg2pvnfA4CAmfeu+/462s=;
        b=HcTQ1TS09v1TY40ItXRLWMYcjTSk8nxk9u+86khDz6zCjp2hPgxcewPqSEMivc0wUR
         bF75w99DTO9Mq1RJvISwa3kxGyP09uoWUkH2iGdXDYksm4AwZhg551/n3VXpWVAwoDrT
         T4RdqZZeXfFv+LruMN4mr1ZP+8rzolQrWu0Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254865; x=1731859665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0skt12aKXCRD6lMwCqaBvTwg2pvnfA4CAmfeu+/462s=;
        b=whqcQ6Y75UfOvoSXjW4nsLmP2NCz7FuOvWbJp1N3pNi3aNmKIRFrPKJPFU8NvNnRoH
         pz/fzJRJwGRG2Sc2psJdTC7x1d4us5Bj9q7zAZlZVw2/K+sZEJ1ddfwqtQdhmmPqiwtt
         O4qFO+bJQZaH2mKhwyGUzaLWZUHMoJtP6ZjibdeQj4Ms4pOQUeVqROWBiBFoyZ17jMrF
         L6flJzdUvEOYDb08Wc/AQ8TUkgls1zrMyNsGwnxG2rMa7ekAAC8wH1oMRbC0YZu0ae87
         TKJ0k3JAMMD2feGzTdNaVQa/z9N+52cgiAy/+ylKHKAgZOf3MwZlpFj+FIm4GI/6QHp0
         CTSA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Nw7/uSIuekiULgOT6MBHgI6JbMLYtegQHscYxf05KQACGGWX3zHXBcoRJ2g+ECbsMXtvJRJVU4SSQu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7Co8/q1eDrgBTi+mbiGUcDMu/NQqh2SZjbmz9w1IMIadgz4U
	KjQQ1k511fG7XfeUF/bJCTJmwloM7cbU7QmscxRQHgO8E9ECAz+kssISDMbmGUnbSBG/+eWbZ1I
	=
X-Google-Smtp-Source: AGHT+IFK7QGNh1W4jpYDyE965ohIg16QN1yHxE/8jkrzk3y+cEBhylubrrky3e8U8k3PkGQscWuRkA==
X-Received: by 2002:a17:902:ce03:b0:20c:693b:6578 with SMTP id d9443c01a7336-2118354efe3mr143598385ad.25.1731254865289;
        Sun, 10 Nov 2024 08:07:45 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc838esm61550765ad.32.2024.11.10.08.07.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 08:07:44 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so3003237a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 08:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4mi6I2yLwfWnNRjDtLJ+kDwnyRCAn6mMmTzpKmVlgMGd0guvZ9U8/eYPFzSpbp3cEt3iibhSPXdiy+Pk=@vger.kernel.org
X-Received: by 2002:a17:90b:2251:b0:2e2:b64e:f501 with SMTP id
 98e67ed59e1d1-2e9b1740f12mr13805943a91.30.1731254863163; Sun, 10 Nov 2024
 08:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com> <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110151426.GD6002@pendragon.ideasonboard.com>
In-Reply-To: <20241110151426.GD6002@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 10 Nov 2024 17:07:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
Message-ID: <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 16:14, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Sat, Nov 09, 2024 at 05:29:54PM +0100, Ricardo Ribalda wrote:
> > On Sat, 9 Nov 2024 at 16:37, Hans de Goede <hdegoede@redhat.com> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > FYI / some background: I have been asked to start helping /
> > > co-maintaining UVC with Laurent. I'll send out a patch adding
> > > myself as UVC maintainer soon.
> >
> > Great! I talked with Laurent yesterday, I hope that we can maintain
> > the driver the three of us in the near future.
> >
> > > On 8-Nov-24 9:25 PM, Ricardo Ribalda wrote:
> > > > Some notebooks have a button to disable the camera (not to be mistaken
> > > > with the mechanical cover). This is a standard GPIO linked to the
> > > > camera via the ACPI table.
> > > >
> > > > 4 years ago we added support for this button in UVC via the Privacy control.
> > > > This has two issues:
> > > > - If the camera has its own privacy control, it will be masked
> > > > - We need to power-up the camera to read the privacy control gpio.
> > > >
> > > > We tried to fix the power-up issues implementing "granular power
> > > > saving" but it has been more complicated than anticipated....
> > >
> > > I have been discussing UVC power-management with Laurent, also
> > > related to power-consumption issues caused by libcamera's pipeline
> > > handler holding open the /dev/video# node as long as the camera
> > > manager object exists.
> > >
> > > For now we have fixed this with some relatively small changes to
> > > libcamera's uvcvideo pipeline handler, but that is really meant
> > > as an interim solution and as this privacy control series shows
> > > the power-management issues are real.
> >
> > Indeed, we have tried to fixed it before:
> > https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
> >
> > btw this recently landed patch was to work in this direction :)
> > https://lore.kernel.org/linux-media/20240926-guenter-mini-v7-1-690441953d4a@chromium.org/
> >
> > The more people interested in this problem the better.
> >
> > > Combined with Mauro's remarks about how this is an userspace ABI break (1)
> > > I think we should maybe first take another look at the powermanagement
> > > issues in general rather then moving forward with this series.
> > >
> > > My apologies for this, I realize how annoying it can be when you are
> > > working on a patch series to fix a specific issue and a reviewer
> > > moves the goal-posts like this. But I do really think that just fixing
> > > the generic power-management issues would be better and I also think
> > > that this should be feasible / not too hard.
> > >
> > > Here is what I have in mind for this:
> > >
> > > 1. Assume that the results of trying a specific fmt do not change over time.
> > >
> > > 2. Only allow userspace to request fmts which match one of the enum-fmts ->
> > >    enum-frame-sizes -> enum-frame-rates tripplet results
> > >    (constrain what userspace requests to these)
> > >
> > > 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
> > >    3 levels nested loop for this) on probe() and cache the results
> > >
> > > 4. Make try_fmt / set_fmt not poweron the device but instead constrain
> > >    the requested fmt to one from our cached fmts
> > >
> > > 5. On stream-on do the actual power-on + set-fmt + verify that we get
> > >    what we expect based on the cache, and otherwise return -EIO.
> >
> > Can we start powering up the device during try/set fmt and then
> > implement the format caching as an improvement?
>
> This sounds worth trying. We'll need to test it on a wide range of
> devices though, both internal and external.

For what is worth, we have been running something similar to
https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
in ChromeOS and it has worked fine....

But I am pretty sure that it has issues with async controls :S

>
> > Laurent mentioned that some cameras missbehave if a lot of controls
> > are set during probing. I hope that this approach does not trigger
> > those, and if it does it would be easier to revert if we do the work
> > in two steps.
> >
> > > I think that should sort the issue, assuming that 1. above holds true.
> > >
> > > One downside is that this stops UVC button presses from working when
> > > not streaming. But userspace will typically only open the /dev/video#
> > > node if it plans to stream anyways so there should not be much of
> > > a difference wrt button press behavior.
> >
> > I do not personally use the button, but it is currently implemented as
> > a standard HID device. Making it only work during streamon() might be
> > a bit weird.
> > I am afraid that if there is a button we should keep the current behaviour.
> >
> > >
> > > This should also make camera enumeration faster for apps, since
> > > most apps / frameworks do the whole 3 levels nested loop for this
> > > on startup, for which atm we go out to the hw, which now instead
> > > will come from the fmts cache and thus will be much much faster,
> > > so this should lead to a noticeable speedup for apps accessing UVC
> > > cameras which would be another nice win.
> > >
> > > Downside is that the initial probe will take longer see we do
> > > all the tryfmt-s there now. But I think that taking a bit longer
> > > to probe while the machine is booting should not be an issue.
> >
> > How do you pretend to handle the controls? Do you plan to power-up the
> > device during s_ctrl() or set them only during streamon()?
> > If we power-up the device during s_ctrl we need to take care of the
> > asynchronous controls (typically pan/tilt/zoom), The device must be
> > powered until the control finishes, and the device might never reply
> > control_done if the firmware is not properly implemented.
> > If we set the controls only during streamon, we will break some
> > usecases. There are some video conferencing equipment that do homing
> > during streamoff. That will be a serious API breakage.
> >
> > This patchset is not only to fix the powersaving issues, but also to
> > fix the issue when a camera has  a gpio privacy switch and an internal
> > Privacy control.  4 years ago I did not see any camera with Privacy
> > control (in 100s of models), now they are common.
> > Can we have both changes, gpio subdevice and granular power saving?
> >
> > > Regards,
> > >
> > > Hans
> > >
> > > 1) Which is technically correct, but FWIW I agree with you that I think
> > > most userspace consumers will not care
> > >
> > > > Last year, we proposed a patchset to implement the privacy gpio as a
> > > > subdevice https://lore.kernel.org/linux-media/20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org/
> > > >
> > > > I think it is a pretty clean solution and makes sense to use a
> > > > subdevice for something that is a sub device of the camera :).
> > > >
> > > > This is an attempt to continue with that approach.
> > > >
> > > > Tested on gimble:
> > > > gimble-rev3 ~ # v4l2-ctl --all -d /dev/v4l-subdev0
> > > > Driver Info:
> > > >         Driver version   : 6.6.56
> > > >         Capabilities     : 0x00000000
> > > > Media Driver Info:
> > > >         Driver name      : uvcvideo
> > > >         Model            : HP 5M Camera: HP 5M Camera
> > > >         Serial           : 0001
> > > >         Bus info         : usb-0000:00:14.0-6
> > > >         Media version    : 6.6.56
> > > >         Hardware revision: 0x00009601 (38401)
> > > >         Driver version   : 6.6.56
> > > > Interface Info:
> > > >         ID               : 0x0300001d
> > > >         Type             : V4L Sub-Device
> > > > Entity Info:
> > > >         ID               : 0x00000013 (19)
> > > >         Name             : GPIO
> > > >         Function         : Unknown sub-device (00020006)
> > > >
> > > > Camera Controls
> > > >
> > > >                         privacy 0x009a0910 (bool)   : default=0 value=0 flags=read-only, volatile
> > > >
> > > > gimble-rev3 ~ # media-ctl  -p
> > > > Media controller API version 6.6.56
> > > >
> > > > Media device information
> > > > ------------------------
> > > > driver          uvcvideo
> > > > model           HP 5M Camera: HP 5M Camera
> > > > serial          0001
> > > > bus info        usb-0000:00:14.0-6
> > > > hw revision     0x9601
> > > > driver version  6.6.56
> > > >
> > > > Device topology
> > > > - entity 1: HP 5M Camera: HP 5M Camera (1 pad, 1 link)
> > > >             type Node subtype V4L flags 1
> > > >             device node name /dev/video0
> > > >         pad0: Sink
> > > >                 <- "Extension 8":1 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 4: HP 5M Camera: HP 5M Camera (0 pad, 0 link)
> > > >             type Node subtype V4L flags 0
> > > >             device node name /dev/video1
> > > >
> > > > - entity 8: Extension 8 (2 pads, 2 links, 0 routes)
> > > >             type V4L2 subdev subtype Unknown flags 0
> > > >         pad0: Sink
> > > >                 <- "Extension 4":1 [ENABLED,IMMUTABLE]
> > > >         pad1: Source
> > > >                 -> "HP 5M Camera: HP 5M Camera":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 11: Extension 4 (2 pads, 2 links, 0 routes)
> > > >              type V4L2 subdev subtype Unknown flags 0
> > > >         pad0: Sink
> > > >                 <- "Processing 2":1 [ENABLED,IMMUTABLE]
> > > >         pad1: Source
> > > >                 -> "Extension 8":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 14: Processing 2 (2 pads, 2 links, 0 routes)
> > > >              type V4L2 subdev subtype Unknown flags 0
> > > >         pad0: Sink
> > > >                 <- "Camera 1":0 [ENABLED,IMMUTABLE]
> > > >         pad1: Source
> > > >                 -> "Extension 4":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 17: Camera 1 (1 pad, 1 link, 0 routes)
> > > >              type V4L2 subdev subtype Sensor flags 0
> > > >         pad0: Source
> > > >                 -> "Processing 2":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 19: GPIO (0 pad, 0 link, 0 routes)
> > > >              type V4L2 subdev subtype Decoder flags 0
> > > >              device node name /dev/v4l-subdev0
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > Changes in v2:
> > > > - Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
> > > > - Create uvc_gpio_cleanup and uvc_gpio_deinit
> > > > - Refactor quirk: do not disable irq
> > > > - Change define number for MEDIA_ENT_F_GPIO
> > > > - Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org
> > > >
> > > > ---
> > > > Ricardo Ribalda (5):
> > > >       media: uvcvideo: Factor out gpio functions to its own file
> > > >       Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
> > > >       media: uvcvideo: Create ancillary link for GPIO subdevice
> > > >       media: v4l2-core: Add new MEDIA_ENT_F_GPIO
> > > >       media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO entity
> > > >
> > > > Yunke Cao (1):
> > > >       media: uvcvideo: Re-implement privacy GPIO as a separate subdevice
> > > >
> > > >  .../userspace-api/media/mediactl/media-types.rst   |   4 +
> > > >  drivers/media/usb/uvc/Makefile                     |   3 +-
> > > >  drivers/media/usb/uvc/uvc_ctrl.c                   |  40 +----
> > > >  drivers/media/usb/uvc/uvc_driver.c                 | 123 +-------------
> > > >  drivers/media/usb/uvc/uvc_entity.c                 |  20 ++-
> > > >  drivers/media/usb/uvc/uvc_gpio.c                   | 187 +++++++++++++++++++++
> > > >  drivers/media/usb/uvc/uvc_video.c                  |   4 +
> > > >  drivers/media/usb/uvc/uvcvideo.h                   |  34 ++--
> > > >  drivers/media/v4l2-core/v4l2-async.c               |   3 +-
> > > >  include/uapi/linux/media.h                         |   1 +
> > > >  10 files changed, 252 insertions(+), 167 deletions(-)
> > > > ---
> > > > base-commit: 4353256f5487e0c5c47e8ff764bf4f9e679fb525
> > > > change-id: 20241030-uvc-subdev-89f4467a00b5
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

