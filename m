Return-Path: <linux-kernel+bounces-403293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E794D9C33B4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50444B20C83
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9605C603;
	Sun, 10 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FhhOC06P"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A91BC2A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254529; cv=none; b=ZU2SWJHdd86OPrfy3q/ADvuWg2UmsFHf2LwxCm/Is2LGt27oOysSbGzKWyK8KD2eSM4YVerujHtEdiO8V3v5g4pv5VwOHx50Cb28IYfgx4nxnmOkJSFBwwndkq6YE3EvR4sDHijihnR/EoNOsP4iLSKYCcCkMKZLLtt60h+MVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254529; c=relaxed/simple;
	bh=ZRa6FijkI+LZa7ep5qzKJ7Z0Ba2vVxpt/Tny7o4692k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfdEhJ66soD/xoDHpKvCiKlFvr6S/weFwbclP/pH9FU824cHFAnS6PeqOaO2Lpw+MXTtiALPiHVEmxxwd8GzfB9O2lkIcmljeP6MwTNCmzvFN8gFpZiceUz7/BDf99ej0k3Xty/TC0LRbQl/hS34CjV12gQXb0mlWEbSW41yUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FhhOC06P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb7139d9dso34741295ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731254527; x=1731859327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVY7VeNitIMXPIsd+9NIiRq6YocYM2GcYTriZCbfqJs=;
        b=FhhOC06P/mpZvKNQECWWkeZIWFzi2L/AjvY/g7Nz5oN6WDlDOiRaDacoJLW7aWx9f9
         a479LFHKFN+7/gpV8QeKZoOqbnBHCqEo2X17OnfPodbpWpPN1B0Ns7n6SYbr4JBHrE4e
         AlWxAKFLH9tV5uHfSbK0WtVaLsbQ553kLGNfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254527; x=1731859327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVY7VeNitIMXPIsd+9NIiRq6YocYM2GcYTriZCbfqJs=;
        b=mvVSJi0aOWjm0xBjcrgDv3JTAZROAhg6YocHj9EUo7q/SCK2+VCE1s4WoAUxyrsYcz
         754213f97TQjYoWQKblvrShA89e2dVV8ljNpgzXYvHt8zs+quIrirJF6PEn86mc6B2cb
         MkBpQZnYaqBJuE9KlVEiQYOnBFKcTvBwj+3Lj1z1U1UsQHcgNvj+IFDalsDG1xiIqzsL
         MBPaQMIVWmZ4fAY9g0FO29wx/Bs5tDTBNDly61YPtpG3oLT47Fb5BZ2IAbwwE3ByR9BX
         y5XNSW6rw6F39cAJ8IpAai8gVeG++cDOLyd4Z2Emq6X95tDwr8CgsB0ynUZGrzuJw2pZ
         AjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Jpgf5iZYiEV7AURdUY6g2wxoK4JPlFAK1R1MfzdYHRj4VhyapQSj/ZAgme+VWJnhoGaq9439edgmF9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkne5YhjBb9qKmzrMXViwtPSy0MAaAEVBGLNiNX/T7GjVz27I2
	BG/DHPozh1BfXw3iST8jFkmvQUQ8cMhBpebZ6ua9URxBPXQu+gY1T/jsJ/2GRoyolQWzKA0m8Uc
	=
X-Google-Smtp-Source: AGHT+IHpuLfRrIfjNVxaP8vNAH5S1YKom/4n+gf8I2J1syvmtAdYcl+acUFhRHThrkvKO2qG3phxuQ==
X-Received: by 2002:a17:902:db11:b0:20c:d5c5:4039 with SMTP id d9443c01a7336-21183ccf12cmr141023015ad.10.1731254526961;
        Sun, 10 Nov 2024 08:02:06 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a731sm60585595ad.236.2024.11.10.08.02.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 08:02:04 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e91403950dso2830905a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 08:02:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOpMiFZfeHHIjW331DVJBOfAl02qN411HvMiQ2pVXm1HY51U0TjYGg2sCgkN+BlcwrMFWN3r6J08TxcCU=@vger.kernel.org
X-Received: by 2002:a17:90b:2747:b0:2e2:cf5c:8ee3 with SMTP id
 98e67ed59e1d1-2e9b17138bcmr15352771a91.10.1731254523404; Sun, 10 Nov 2024
 08:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com> <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110110257.5160a7d1@foz.lan> <CANiDSCvYo8=x_QAeg0_S=_H=R1EgM9xLUy4DXURcuEadYcQjQQ@mail.gmail.com>
 <20241110134608.6e82f851@foz.lan>
In-Reply-To: <20241110134608.6e82f851@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 10 Nov 2024 17:01:50 +0100
X-Gmail-Original-Message-ID: <CANiDSCu9fiAXEer-TROhks+Hn2=bZp2jb_Zm+nvkzW=6yMtcUg@mail.gmail.com>
Message-ID: <CANiDSCu9fiAXEer-TROhks+Hn2=bZp2jb_Zm+nvkzW=6yMtcUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 13:46, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Sun, 10 Nov 2024 11:32:16 +0100
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > Hi Mauro
> >
> > On Sun, 10 Nov 2024 at 11:03, Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Em Sat, 9 Nov 2024 17:29:54 +0100
> > > Ricardo Ribalda <ribalda@chromium.org> escreveu:
> > >
> > > > >
> > > > > I think that should sort the issue, assuming that 1. above holds true.
> > > > >
> > > > > One downside is that this stops UVC button presses from working when
> > > > > not streaming. But userspace will typically only open the /dev/video#
> > > > > node if it plans to stream anyways so there should not be much of
> > > > > a difference wrt button press behavior.
> > > >
> > > > I do not personally use the button, but it is currently implemented as
> > > > a standard HID device.
> > >
> > > IMO, controlling the privacy via evdev is the best approach then. There's
> > > no need for a RW control neither at subdev or at device level. It could
> > > make sense a Read only to allow apps to read, but still it shall be up to
> > > the Kernel to protect the stream if the button is pressed.
> > >
> > > > Making it only work during streamon() might be
> > > > a bit weird.
> > > > I am afraid that if there is a button we should keep the current behaviour.
> > >
> > > Privacy matters only when streaming. IMO the Kernel check for it needs to
> > > be done at DQBUF time and at read() calls, as one can enable/disable the
> > > camera while doing videoconf calls. I do that a lot with app "soft" buttons,
> > > and on devices that physically support cutting the video.
> > >
> > > I don't trust myself privacy soft buttons, specially when handled in userspace,
> > > so what I have are webcam covers (and a small stick glued at a laptop camera
> > > that has a too small sensor for a webcam cover). I only remove the cover/stick
> > > when I want to participate on videoconf with video enabled with the builtin
> > > camera.
> > >
> > > Regards
> >
> > I think we are mixing up concepts here.
> >
> > On one side we have the uvc button. You can see one here
> > https://www.sellpy.dk/item/2Yk1ZULbki?utm_source=google&utm_medium=cpc&utm_campaign=17610409619&gad_source=1&gclid=Cj0KCQiA0MG5BhD1ARIsAEcZtwR9-09ZtTIVNbVknrZCtCd7ezVM8YFw1yQXfs81FWhofg9eW-iBrsIaAopVEALw_wcB
> > That button is not represented as a hid device. We do not know how the
> > user will use this button. They could even use it to start an app when
> > pressed.
>
> Old cameras have a <snapshot> button. Maybe that's the case of the device
> you're pointing, as it looks some non-uvc Logitech cameras I have myself.
>
> > On the other side we have  the privacy gpio. The chassis has a switch
> > that is connected to the camera and to the SOC. You can see one here:
> > https://support.hp.com/ie-en/document/ish_3960099-3335046-16 .We link
> > the camera with a gpio via the acpi table. When the user flips the
> > button, the camera produces black frames and the SOC gets an IRQ.
>
> OK, so the hardware warrants black frames. Sounds a more secure
> implementation.
>
> > The IRQ is used to display a message like "Camera off" and the value of
> > the GPIO can be checked when an app is running to tell the user:
> > "Camera not available, flip the privacy button if you want to use it."
>
> So, it is not really a privacy gpio/control. It is instead a privacy
> notification control.
>
> I would better name it to clearly indicate what it is about.
>
> > Userspace cannot change the value of the gpio. It is read-only,
> > userspace cannot override the privacy switch. The privacy gpio is
> > represented with a control in /dev/videoX This patchset wants to move
> > it to /dev/v4l2-subdevX
>
> Well, if it is really a gpio pin, kernel (and eventually userspace) can force
> it to pullup (or pulldown) state, forcing one of the states. If, instead is
> an output-only pin, kernel/userspace can't control it at all.
>
> > To make things more complicated. Recently some cameras are starting to
> > have their own privacy control without the need of an external gpio.
> > This is also represented as a control in /dev/videoX.
>
> IMO, both privacy notification events shall be reported the same way,
> no matter if they use GPIO, an input pin or something else.

How do we handle devices that have internal privacy and GPIO if we do
not use a subdevice?

>
> > Now that we have these 3 concepts in place:
> >
> > Today a uvc camera is powered up when /dev/videoX is open(), not when
> > it is streaming.
>
> Ideally, the part of the hardware responsible for streaming shall be
> powered on only while streaming. I agree with Hans de Goede: better
> have this fixed before the privacy notification patches.
>
> > This means that if we want to get an event for the
> > privacy gpio we have to powerup the camera, which results in power
> > consumption. This can be fixed by moving the control to a subdevice
> > (technically the gpio is not part of the camera, so it makes sense).
>
> Ok, but as you said, not all cameras implement it as a separate gpio.

For the device that are not a separate gpio you need to powerup the
device to read it.


>
> > If we only powerup the camera during streamon we will break the uvc
> > button, and the async controls.
>
> Why? IMO, it shall use regmap in a way that the register settings
> will be sent to the device only when the camera control hardware is
> powered up. On a complex device, there are likely at least two power
> up hardware: the camera control logic and the streaming logic.
>
> Not sure if both are visible via UVC spec, though.

There are controls that need to be accessed without streaming, like
the ones that do homing (calibrate the motors), report occupancy of a
room.

If we modify the driver behaviour to  read/write controls only during
this streaming we will stop supporting current use cases and
definately break applications.

>
> Thanks,
> Mauro



-- 
Ricardo Ribalda

