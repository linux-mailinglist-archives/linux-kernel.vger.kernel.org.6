Return-Path: <linux-kernel+bounces-566568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF0A679D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8818917FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B1211462;
	Tue, 18 Mar 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZeyWipRT"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8E204C39
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315967; cv=none; b=FYde10jXxGHRVnbNA4Bjk+rdxMUXgJzUR/QQV2d2hOZyIp6nRHGZV1mDkUEdGN2NE6tgtoma3//tqEapOZoueKyCsvdKhypqhh7xDLC3k34rbzn4+aOrIaUy4/5FCRfdM8Vxe0A4rk8H5kKpWIeF6NR/DqE73PxJdCkV5wOAUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315967; c=relaxed/simple;
	bh=Y4GaTWIXYkP1Wp5MBq5OZrPIS2IaOnZYMEx/7ruy0Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3HQ2PJzaA776fznZEa3h8s5O1Nj2sgyjRmaPox2b62++yjmeFGbaR++hiv1hRS21f/cyIQMliTlbfggEC8QYjdWtXlD8kZpF54NBlgncBWH3K869+igGrt8FZtiXxtAKTRNEO+oNHZIiydw+pfnurE7XM6WNPXIyD0Pq1s03DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZeyWipRT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff1e375a47so51589997b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742315964; x=1742920764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wKjasBMPgoT2rFalGXd6BBeR4y99deeJSGyhMPOVds=;
        b=ZeyWipRTOMMHiBnMG5fyKu0ZRk0PBQ4+3Lagmd7GXN12bybZAtmGbC37GUJ/7a8fxA
         lwfFnRVeJCCF2ySDCOI47oamb2UoIuOyxyr+507eGNFowKb6B9yETGUksEq7+9Jl4MsD
         rtSSYEneu8bU6rZpt0D9HoDU517hmqMscq/dVz7/w+LyUbrked8rCfnIFZ4Fx5HobJBu
         AZirtrGki2vljwwUtJzAuHBr66VIEFRpg6y+cAEvvwimiu0yMgdSw07G6BO/kQ3S8AsH
         Oxv4ua10PzDqziKNxPvMFgW33wAKawUCGmAmnmzZhLhAz6z0pdk39deSnzC73syfZmv1
         aqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315964; x=1742920764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wKjasBMPgoT2rFalGXd6BBeR4y99deeJSGyhMPOVds=;
        b=TzUnYR34FVK3wsDjzK8+sSBwyqBT9Wz7NgU6iduODLpS3+wxBUnl6gR+yYKnoFyj1F
         nXjYSLJWFaebIzQxcZoELKVZQPO8RyP8vv7CcPWhOanVdeahphJuNV5EDs7IB/8zcRmk
         HdzMi6/R3yBYKGWtJ13H/ycSvxflfr7Xo6tKeb0T976ABGroUSWi/xPkx0Ykpb079tPN
         XsX1tIGALwv43oCV+HvIUHPdr1Zmcop+HTLQe44fBmzgB+Fjm67BdIonNlwbQ1jaLJlU
         DT1S1fGWYkYCkngMHaz3Yu31cdO+Lj9TSrL8RSLzyytZ43IvR3hCWvIEEdwuT661jLBd
         4sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtdxRdDNyVMyJE7cKz0dd1uK6gHt0EvKyRN5NRjtEIND1cHl+GjUjRjmlkfY+DlfK5U0V0G/CYJkw9y/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuv+RkNH/O6JJbMWZU8IeOxhN2GkRHUZuaWei17TXY7OmG9u/
	lHEA012JrGdOMdmhIoSAKOSQKWIZt1adZzgdZnwvkMmn+dmhvBDzvqKgEa91GDHpgswbNN2SMVT
	hQ+JNGjUZKpay185XkSfPxo4fQK3ze7S0DtNXzg==
X-Gm-Gg: ASbGncvOqrVtNgQaqc2y6OoP/XiOA+nBZ7n3/cSlTHyY5Wvb71OnWMK+AuteVDij/os
	EwK64fTj3z1U9bXGuUxxFMeWNTNwMRtkGJQ7qWQtv+a0DqRmmIG4LQjAAHgpUerJ+McI5rT1ZkN
	jCNv5Nvp1ReAikVocQq7vsiUF0ME/R9a/5MKZxBjhm5jxWfxyQ53DryQCL
X-Google-Smtp-Source: AGHT+IEAIuZBtCdDszWtXzHCJJeW4LXwXcjtps3dupT+KLXpxevhe4+sxD9wCYgo8/fgc4cU/MpsDqaQ6wQ3z5JY1Gg=
X-Received: by 2002:a05:690c:4902:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6ff45fa0641mr217311797b3.16.1742315964086; Tue, 18 Mar 2025
 09:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ov9282-flash-strobe-v2-0-14d7a281342d@linux.dev>
 <20250314-ov9282-flash-strobe-v2-1-14d7a281342d@linux.dev>
 <Z9P01zU_Kg0U62wa@kekkonen.localdomain> <bx4p2hycva2rqywgglqluus6o7jbmfa2jjbc4k5d6aw6wsfkxd@zrtckmwtphuq>
 <Z9QwT7n7D09BEfqa@kekkonen.localdomain> <3dkwhfqxjhu3w4hpcl4gfsi22kwauo6s5urxrorezaw323yygq@nujmlkie5rpd>
 <Z9l04b5ZGy877j32@kekkonen.localdomain> <myyn53owptzx3dm3qmudtm4pmnon7axmjks2u5adno6ywktd3t@qriiifsitqoh>
 <Z9l9-tEwHRtXnz1a@kekkonen.localdomain> <s76b7q2cvcuk32n3jpsijyrhxhtstk6fewb5drkxdeopvt5grj@p4mcqltiza36>
 <Z9mNKG07sJcbnk3Z@kekkonen.localdomain>
In-Reply-To: <Z9mNKG07sJcbnk3Z@kekkonen.localdomain>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 18 Mar 2025 16:39:05 +0000
X-Gm-Features: AQ5f1JpzPvC5kCimBdTH6JyyA_xL5QWl48RuiHB061pvN72a0BBg78Q-tkCMXUk
Message-ID: <CAPY8ntDzA+j97XB4VUfBtSH0RgpVKSdKxS1o5LnmoNDE1h=eyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] media: v4l: ctrls: add a control for flash/strobe duration
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Richard Leitner <richard.leitner@linux.dev>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

On Tue, 18 Mar 2025 at 15:11, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Richard,
>
> On Tue, Mar 18, 2025 at 03:46:18PM +0100, Richard Leitner wrote:
> > On Tue, Mar 18, 2025 at 02:06:50PM +0000, Sakari Ailus wrote:
> > > Hi Richard,
> > >
> > > On Tue, Mar 18, 2025 at 02:42:53PM +0100, Richard Leitner wrote:
> > > > On Tue, Mar 18, 2025 at 01:28:01PM +0000, Sakari Ailus wrote:
> > > > > Hi Richard,
> > > > >
> > > > > On Fri, Mar 14, 2025 at 05:08:16PM +0100, Richard Leitner wrote:
> > > > > > Hi Sakari,
> > > > > >
> > > > > > On Fri, Mar 14, 2025 at 01:34:07PM +0000, Sakari Ailus wrote:
> > > > > > > Hi Richard,
> > > > > > >
> > > > > > > On Fri, Mar 14, 2025 at 11:25:09AM +0100, Richard Leitner wrote:
> > > > > > > > On Fri, Mar 14, 2025 at 09:20:23AM +0000, Sakari Ailus wrote:
> > > > > > [...]
> > > > > > > > > On Fri, Mar 14, 2025 at 09:49:55AM +0100, Richard Leitner wrote:
> > > > > > > > > > Add a control V4L2_CID_FLASH_DURATION to set the duration of a
> > > > > > > > > > flash/strobe pulse. This is different to the V4L2_CID_FLASH_TIMEOUT
> > > > > > > > > > control, as the timeout defines a limit after which the flash is
> > > > > > > > > > "forcefully" turned off again.
> > > > > > > > > >
> > > > > > > > > > On the other hand the new V4L2_CID_FLASH_DURATION is the desired length
> > > > > > > > > > of the flash/strobe pulse
> > > > > > > > >
> > > > > > > > > What's the actual difference between the two? To me they appear the same,
> > > > > > > > > just expressed in a different way.
> > > > > > > >
> > > > > > > > According to FLASH_TIMEOUT documentation:
> > > > > > > >
> > > > > > > >   Hardware timeout for flash. The flash strobe is stopped after this
> > > > > > > >   period of time has passed from the start of the strobe. [1]
> > > > > > > >
> > > > > > > > This is a little bit unspecific, but as also discussed with Dave [2]
> > > > > > > > according to the documentation of V4L2_FLASH_FAULT_TIMEOUT it seems to
> > > > > > > > be targeted at providing a "real timeout" control, not settings the
> > > > > > > > desired duration:
> > > > > > > >
> > > > > > > >   The flash strobe was still on when the timeout set by the user
> > > > > > > >   --- V4L2_CID_FLASH_TIMEOUT control --- has expired. Not all flash
> > > > > > > >   controllers may set this in all such conditions. [1]
> > > > > > > >
> > > > > > > > If I understood that wrong, I'm also happy to use FLASH_TIMEOUT for this
> > > > > > > > use-case. But tbh I think FLASH_DURATION would be more specific.
> > > > > > > >
> > > > > > > > As this still seems unclear: Should the documentation be
> > > > > > > > changed/rewritten if we stick with the FLASH_DURATION approach?
> > > > > > > >
> > > > > > > > [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-flash.html
> > > > > > > > [2] https://lore.kernel.org/lkml/CAPY8ntB8i4OyUWAL8k899yUd5QsRifJXiOfWXKceGQ7TNZ4OUw@mail.gmail.com/
> > > > > > >
> > > > > > > Right, I think I can see what you're after.
> > > > > > >
> > > > > > > How does the sensor determine when to start the strobe, i.e. on which frame
> > > > > > > and which part of the exposure of that frame?
> > > > > >
> > > > > > In general I think it's not part of V4L2_CID_FLASH_DURATION to take any
> > > > > > assumptions on that, as that's sensor/flash specific IMHO.
> > > > > >
> > > > > > In case of the ov9282 sensor driver (which is also part of this series)
> > > > > > the strobe is started synchronously with the exposure on each frame
> > > > > > start.
> > > > > > Being even more specific on the ov9292, the sensor also offers the
> > > > > > possibility to shift that strobe start in in either direction using a
> > > > > > register. Implementing this "flash shift" (as it's called in the sensors
> > > > > > datasheet) is currently under test on my side. I will likely send a
> > > > > > series for that in the coming weeks.
> > > > >
> > > > > Ok, so you get a single frame exposed with a flash when you start
> > > > > streaming, is that correct?
> > > >
> > > > Correct. The flash is switched on for the configured duration at every
> > > > frame exposure (the sensor has a global shutter) as long as the camera is
> > > > streaming.
> > > >
> > > > Maybe to following visualization of configured flash and exposure times help:
> > > >
> > > >              _________        _________        _________
> > > > exposure: __|         |______|         |______|         |__
> > > >
> > > >              __               __               __
> > > > flash:    __|  |_____________|  |_____________|  |_________
> > > >             ^^^^
> > > >       strobe_duration
> > >
> > > That diagram would work for global shutter but not for the much, much more
> > > common rolling shutter operation. Does the driver use the sensor in rolling
> > > shutter mode? This isn't very common with LED flashes.
> >
> > The ov9282 driver uses the sensor in global shutter mode.
> >
> > I totally agree with your statement. This pattern is only useful for
> > global shutter operation.
>
> I think (nearly?) all supported sensors use a rolling shutter.

You've got at least two other global shutter sensors supported in
mainline - Omnivision ov7251 and Sony imx296.
Patches have been posted for OnSemi ar0144 (Laurent) and ar0234
(Dongcheng), which are also both global shutter sensors.

So yes they are in the minority, but not that uncommon.

  Dave



> Could you include a comment on this to the driver?
>
> I wonder what Laurent thinks.
>
> --
> Kind regards,
>
> Sakari Ailus

