Return-Path: <linux-kernel+bounces-409840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12359C9256
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A097D286C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAAC19EED0;
	Thu, 14 Nov 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gyhQPkjb"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3318A931
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612105; cv=none; b=JxNZx82763QJaPy1yxXFw6fOAZyrKmlIzLHVCSNd+aU3A9T4R3HgoeOpSopsEmWjHbz3gVILAqRTKkZVCiae60OwnqKq1sc+qoj5+eGMLKKVK89hy9SWyE6nvmCcWjxnsZk0on7Cxt9+Sgt4APTwWUMeJ7iQnfNunr0shck7hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612105; c=relaxed/simple;
	bh=Kz2CoKac5RIK5zqQkcVxg/OrSDhQq5pmW8hKofWMCyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/BaW5Romcn18yYu0aPa68WBJw0qz3tH7pt4krF74UXjZA+1oUDQHanP7c0UHQi8i4T6lB/LM2fTgtQ3gQIpMb5RGegCdGWlIH0FbBIj65xoNHAlELHWEDKrZ3qs4aHkdTTT43RXFj/4tcRUxDop2PedyLCtyHCN0JMDZ+nofoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gyhQPkjb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e59746062fso885221a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731612103; x=1732216903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=odn4ivrjcs80WB1pz4wOMV3nOHpG1wZPYgFFp65VWS4=;
        b=gyhQPkjbvQwsxpWFjmvI0waCalw8v+F0AIOn8RfycB6Pi7HVsN8xmjAmqAhYdcH47a
         tXnF6b/368uDm0sNqqYOlOViWW8yy7K59w/eAYGl8kw/xLCbBhJTqC1f13JdLbGBJiPz
         O8JECmu7lWryiKEmuPExPXpsqsr3k4Vxfjkmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612103; x=1732216903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odn4ivrjcs80WB1pz4wOMV3nOHpG1wZPYgFFp65VWS4=;
        b=UNjkWMph6hWQ/Swzy5SWy64sPcPsfOK9+3Cb0LL88k2O46rcjftSw3LZHQi3y9/i4H
         oiNz+5lw7y30ImSpgmCvC+mzJG8JZ6nOhyxN46oaUtGtEU5canaVVLev7vMhDUdI3KZi
         t8VViWpKFjOnNWJyOOuvoGMBH7CefC+uzH5pZYhW8551Y7/fC2v8QMOWcye1HO+BFZ+W
         dqH/x99HAuImK02fhf9PX5c2lPGrWQOgVOZHGYNsDCWJVxaocwRLLK31/3onkX1YbxMb
         1uS74HTwnZCTioM0gAQ8UBJnpGTSdyrdeG4R31SIsUNjnqPe7DFMfSsLZY3GbFWCJDgp
         A7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVfj+Tti29+5j5gj/uILoJjtCsCwjq2YSOwstXXhfhAjXjaeNAUmlug3TnPD2Rq5f/U6//OHFcWlSXVfpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot+eP+bB6lD7gcXbOkCoyIRAdZBwz3bQOv39mZxuceWl4Hhww
	arXVMy0+i9qN6EFsacYWiOE5F4PVcTAnmDutsYZQw78A7ka1LAY9fNqhp5HUBYtMJ/+BNmEv6hE
	=
X-Google-Smtp-Source: AGHT+IHb3wETXbMXTUIMCGbfzJ3TlKhyaGXfNz+dbdchpMLk1F3mvjnTc+whTc7mHCzUfnKZ7bJUGg==
X-Received: by 2002:a17:90b:2788:b0:2e2:cc55:75b6 with SMTP id 98e67ed59e1d1-2ea1559b3acmr36559a91.31.1731612103279;
        Thu, 14 Nov 2024 11:21:43 -0800 (PST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea15611343sm2414a91.14.2024.11.14.11.21.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 11:21:40 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-723f37dd76cso940509b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:21:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfwrn7Rt573/9nz7oTMFsnAehAWtSRRlw7oCyBwkODxwQmj8spkWx/ahYWXix1tqKONjrtNCvwmz+t4Xs=@vger.kernel.org
X-Received: by 2002:a05:6a00:22c8:b0:71e:4930:162c with SMTP id
 d2e1a72fcca58-72476b872c4mr39834b3a.6.1731612099659; Thu, 14 Nov 2024
 11:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org> <bd68178f-1de9-491f-8209-f67065d29283@redhat.com>
In-Reply-To: <bd68178f-1de9-491f-8209-f67065d29283@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 20:21:26 +0100
X-Gmail-Original-Message-ID: <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
Message-ID: <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a evdev
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Hans

Thanks for the great summary.

On Wed, 13 Nov 2024 at 18:57, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> On 12-Nov-24 6:30 PM, Ricardo Ribalda wrote:
> > Some notebooks have a button to disable the camera (not to be mistaken
> > with the mechanical cover). This is a standard GPIO linked to the
> > camera via the ACPI table.
> >
> > 4 years ago we added support for this button in UVC via the Privacy control.
> > This has three issues:
> > - If the camera has its own privacy control, it will be masked.
> > - We need to power-up the camera to read the privacy control gpio.
> > - Other drivers have not followed this approach and have used evdev.
> >
> > We tried to fix the power-up issues implementing "granular power
> > saving" but it has been more complicated than anticipated...
> >
> > This patchset implements the Privacy GPIO as a evdev.
> >
> > The first patch of this set is already in Laurent's tree... but I
> > include it to get some CI coverage.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Changes in v3:
> > - CodeStyle (Thanks Sakari)
> > - Re-implement as input device
>
> Thank you for your enthusiasm for my suggestion to implement this
> as an input device.

I wanted to give it a try... and it turned out to be quite simple to
implement. I thought it could be a good idea to share it, so we can
have something tangible to talk about ;).

>
> As I mentioned in my reply in the v2 thread, the goal of my
> enumeration of various way camera privacy-controls are exposed to
> userspace today is to try and get everyone to agree on a single
> userspace API for this.
>
> Except for this v3 patch-set, which I take as an implied vote
> from you (Ricardo) for the evdev SW_CAMERA_LENS_COVER approach,
> we have not heard anything on this subject from Sakari or Laurent
> yet. So for now I would like to first focus on / circle back to
> the userspace API discussion and then once we have a plan for
> the userspace API we can implement that for uvcvideo.
>
> First lets look at the API question top down, iow what use-cases
> do we expect there to be for information about the camera-privacy
> switch state:
>
> a) Having an app which is using (trying to use) the camera show
> a notification to the user that the camera is turned-off by
> a privacy switch .
>
> Ricardo, AFAICT this is the main use-case for chrome-os, do I have
> this right ?

b) is as important as a) for us.  If you do not give instant feedback
to the user when they change the status of the camera they might not
be able to find the button later on :)


>
> b) Showing on on-screen-display (OSD) with a camera /
> crossed-out-camera icon when the switch is toggled, similar to how
> muting speakers/mic show an OSD . Laptop vendor Windows add-on
> software does this and I know that some users have been asking
> for this.
>
> Then lets look at the question bottom-up which hardware interfaces
> do we have exposing this information:
>
> 1. Internal UVC camera with an input privacy GPIO resource in
> the ACPI fwnode for the UVC camera, with the GPIO reporting
> the privacy-switch state. Found on some chrome-books
>
> 2. Laptop firmware (EC/ACPI/WMI) which reports privacy-switch
> state, without a clear 1:1 relation between the reported state and
> which camera it applies to. In this case sometimes the whole UVC
> camera module (if it is UVC) is simply dropped of the bus when
> the camera is disabled through the privacy switch, removing
> the entire /dev/video# node for the camera. Found on many windows
> laptops.
>
> 3. UVC cameras which report privacy-switch status through
> a UVC_CT_PRIVACY_CONTROL. Found on ... ?
Some logitech cameras and also internal ones.

>
> Note this will only work while the camera is streaming and
> even then may require polling of the ctrl because not all
> cameras reliably send UVC status messages when it changes.
> This renders this hardware interface as not usable
>
>
> Currently there are 2 ways this info is being communicated
> to userspace, hw-interfaces 1. + 3. are exposed as a v4l2
> privacy-ctrl where as hw-if 2. uses and input evdev device.
>
> The advantage of the v4l2 privacy-ctrl is that it makes it
> very clear which camera is controlled by the camera
> privacy-switch.
>
> The disadvantage is that it will not work for hw-if 2,
> because the ACPI / WMI drivers have no v4l2 device to report
> the control on. We could try to add some magic glue code,
> but even then with e.g. IPU6 cameras it would still be
> unclear which v4l2(sub)device we should put the control on
> and if a UVC camera is just dropped from the bus there is
> no /dev/video# device at all.
>
> Using an input device does not has this disadvantage and
> it has the advantage of not requiring to power-up the camera
> as currently happens with a v4l2 ctrl on a UVC camera.
>
> But using an input device makes it harder to determine
> which camera the privacy-switch applies to. We can specify
> that SW_CAMERA_LENS_COVER only applies to device internal
> cameras, but then it is up to userspace to determine which
> cameras that are.

I am working on wiring up this to userspace right now.. I will report
back if it cannot do it.

>
> Another problem with using an input device is that it will
> not work for "UVC cameras which report privacy-switch status
> through a UVC_CT_PRIVACY_CONTROL." since those need the camera
> on and even then need to be polled to get a reliable reading.
>
> Taking this all into account my proposal would be to go
> with an input device and document that SW_CAMERA_LENS_COVER
> only applies to device internal cameras.
>
> This should work well for both use-cases a) and b) described
> above and also be easy to support for both hw interfaces
> 1. and 2.
>
> My proposal for hw-if 3. (UVC_CT_PRIVACY_CONTROL) would be
> to keep reporting this as V4L2_CID_PRIVACY. This means it
> will not work out of the box for userspace which expects
> the input device method, but giving the limitations of
> this hw interface I think that requiring userspace to have
> to explicitly support this use-case (and e.g. poll the
> control) is a good thing rather then a bad thing.
>
> Still before moving forward with switching the hw-if 1.
> case to an input device as this patch-series does I would
> like to hear input from others.
>
> Sakari, Laurent, any comments ?
>
> Regards,
>
> Hans
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> > - Make the code depend on UVC_INPUT_EVDEV
> > - Link to v2: https://lore.kernel.org/r/20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org
> >
> > Changes in v2:
> > - Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
> > - Create uvc_gpio_cleanup and uvc_gpio_deinit
> > - Refactor quirk: do not disable irq
> > - Change define number for MEDIA_ENT_F_GPIO
> > - Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org
> >
> > ---
> > Ricardo Ribalda (8):
> >       media: uvcvideo: Fix crash during unbind if gpio unit is in use
> >       media: uvcvideo: Factor out gpio functions to its own file
> >       media: uvcvideo: Re-implement privacy GPIO as an input device
> >       Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
> >       media: uvcvideo: Create ancillary link for GPIO subdevice
> >       media: v4l2-core: Add new MEDIA_ENT_F_GPIO
> >       media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO entity
> >       media: uvcvideo: Introduce UVC_QUIRK_PRIVACY_DURING_STREAM
> >
> >  .../userspace-api/media/mediactl/media-types.rst   |   4 +
> >  drivers/media/usb/uvc/Kconfig                      |   2 +-
> >  drivers/media/usb/uvc/Makefile                     |   3 +
> >  drivers/media/usb/uvc/uvc_ctrl.c                   |  40 +-----
> >  drivers/media/usb/uvc/uvc_driver.c                 | 112 +---------------
> >  drivers/media/usb/uvc/uvc_entity.c                 |  21 ++-
> >  drivers/media/usb/uvc/uvc_gpio.c                   | 144 +++++++++++++++++++++
> >  drivers/media/usb/uvc/uvc_status.c                 |  13 +-
> >  drivers/media/usb/uvc/uvc_video.c                  |   4 +
> >  drivers/media/usb/uvc/uvcvideo.h                   |  31 +++--
> >  drivers/media/v4l2-core/v4l2-async.c               |   3 +-
> >  include/uapi/linux/media.h                         |   1 +
> >  12 files changed, 223 insertions(+), 155 deletions(-)
> > ---
> > base-commit: 1b3bb4d69f20be5931abc18a6dbc24ff687fa780
> > change-id: 20241030-uvc-subdev-89f4467a00b5
> >
> > Best regards,
>


-- 
Ricardo Ribalda

