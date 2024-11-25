Return-Path: <linux-kernel+bounces-421129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0599D8718
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C40163811
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630319258B;
	Mon, 25 Nov 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UzfCl3WX"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3A1ADFE2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542656; cv=none; b=L3ZEJ3BwlwD1V+P4bRy8WztptOm+BwgevYoOo+XYDXjZa3ASqa8kgjDwfzoPYGcqxa5XCxD08lHLXQKGVT0+M/+R+2hTijk7n7CEofo618ia+n83Jw2Dd+t9HUlwJfEShdCkvtLHoPfERKrXB66cANK6iqdF673Grsc6353u/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542656; c=relaxed/simple;
	bh=ilHRhOQtmU52tJoi5rkYul1Wi+LJB1Spyhoz3pG+2eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVIe2hul/ZedQCYS19SVDiAphKRSSgJaHi5+9CxJhuK+72I1s1r4gq7Hh9myJ+W1aF4WhTmSay4wm7wQ/FXS8JZJbmuMzA8O/iH/wR4OXDUcWLu/kM4/axkSh3g29sIqYY68/X8uQl2OYuzlRgA/rCTmILJQ2sge4G+SFbJ8UBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UzfCl3WX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea8d322297so3434197a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732542654; x=1733147454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDipKvIOUX7uzCSO1YayfVZOqbIm+XO2gEj1lWmD+x0=;
        b=UzfCl3WX3ZtaBfJ+hDm0B0/ai5qn+FF89wlyfpXW300kqGXGdlsRr8SeAvXiDQp5cO
         nKwJsUpn4tG/hLsppa18XJZL03+xhcU0AFXOPJh8bECwjt/fZ4BUECxyBO1CuUo9oqH3
         4bzWcL2hoWuJTw1slqtq3zDALc+t4JnH9CArA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542654; x=1733147454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDipKvIOUX7uzCSO1YayfVZOqbIm+XO2gEj1lWmD+x0=;
        b=LbuQdUtSpLYVtuJugpuShis0f0nNUghkn1/5EWXFFz6/LAPZ5dTs0D22bq2yJr4cBo
         P1b2UdY8VV/mp6n0DO3J568tuzXN7dX6PvZv+c4U5bhMHlYeo9GMWyTIFaioT2ZP6qs7
         C8n7joKXl+m+1amMAp38++U97qrYJg6kUArHAfHMhqmFktFI1PVqyWTizTUX4X9sJ0v1
         P/CMQTj7B0kobmCvPODS0PGHirRzgskuEL4rthT6KAnDsfFFFtP9XN/TUWgGKX95c4GU
         JaGcd4L6BJQXt1R4Ns05TUlnmc/BYQsEWTARrEhlBdpTvsvQTuw7s1n9O7mto9FkZdwZ
         oa6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1Acb6ADj/vtdnWI1872i5TNRdSbX1mT/AW+qL7FXEQSCg43ZsT4lIOwdqgTzVvD/iTGOmtpklFRLJTrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjB1lsxvueY23CVasaXCoCRUCo61HryiyZvRG3AmK8bGeep1el
	z7N4i2Y1Lk3WSOa1BpdmqynlLWumXIVRpLls2Xsn3HNz0f18i9pdmQil+Mh3hK8wtNyCf6LHG54
	=
X-Gm-Gg: ASbGncvh8z+vzpSFt3m4XhfhQsYwCaIqNwwUpJLcEE+THcSQHIvbY9xcJFQP0W9Pffh
	Oqj06//E7IDvqnKqg8ffc6mLEX2HW2fFt5HXo/KKsmvS37HqMr/uAE35FZue1NWgJDlx+U6vhe0
	4k+i+t7kWpfK8atvTYiSKvN36oYu24rrf3kl9UrB2YWp10k5DRu8U31EQh30WCbQDxrUmPHnDia
	o29a1JonDnKRdJSZ/ofl3M6JTWOSdqTOu8nTfcOuIaX7MbAoBYfkkLnA6fe5x3sHxbrQPG4+FTV
	HUN8E+8GMrcRcIlc
X-Google-Smtp-Source: AGHT+IEc+uK7aFRxHdPYL1HTdcpQ/+Q0kEzX7CtiLmOuPq/EdjDdEQvmNW3JAQOQq/pOEyTw3o7VKw==
X-Received: by 2002:a17:90b:1c10:b0:2ea:9f38:993c with SMTP id 98e67ed59e1d1-2eb0e5277f6mr16171386a91.18.1732542653951;
        Mon, 25 Nov 2024 05:50:53 -0800 (PST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cffcc20sm6670177a91.17.2024.11.25.05.50.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:50:53 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so3109751a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwVioZpxijZLxLymE0oxN5NlM3owHHW3gVbNtFZIXt9aCzWJCpdkmuoyo3t7yM5XsJB1jpyiSzFCrgXME=@vger.kernel.org
X-Received: by 2002:a05:6a21:4890:b0:1e0:c243:cffc with SMTP id
 adf61e73a8af0-1e0c243d07amr6508648637.36.1732542652324; Mon, 25 Nov 2024
 05:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com> <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110151426.GD6002@pendragon.ideasonboard.com> <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
 <123bfac4-389a-400a-8104-afc27124b75d@redhat.com> <20241125125834.GC32280@pendragon.ideasonboard.com>
 <33e7dbc8-0d29-4905-a28c-e562151a837a@redhat.com>
In-Reply-To: <33e7dbc8-0d29-4905-a28c-e562151a837a@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 14:50:40 +0100
X-Gmail-Original-Message-ID: <CANiDSCv0U=i2ZSd0abfP1JYrY-HVKa5t_7qAea+9KCog5P2PVg@mail.gmail.com>
Message-ID: <CANiDSCv0U=i2ZSd0abfP1JYrY-HVKa5t_7qAea+9KCog5P2PVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 14:44, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 25-Nov-24 1:58 PM, Laurent Pinchart wrote:
> > On Mon, Nov 25, 2024 at 01:39:05PM +0100, Hans de Goede wrote:
> >> Hi Ricardo,
> >>
> >> On 10-Nov-24 5:07 PM, Ricardo Ribalda wrote:
> >>> On Sun, 10 Nov 2024 at 16:14, Laurent Pinchart
> >>> <laurent.pinchart@ideasonboard.com> wrote:
> >>
> >> <snip>
> >>
> >>>>>> Here is what I have in mind for this:
> >>>>>>
> >>>>>> 1. Assume that the results of trying a specific fmt do not change over time.
> >>>>>>
> >>>>>> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
> >>>>>>    enum-frame-sizes -> enum-frame-rates tripplet results
> >>>>>>    (constrain what userspace requests to these)
> >>>>>>
> >>>>>> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
> >>>>>>    3 levels nested loop for this) on probe() and cache the results
> >>>>>>
> >>>>>> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
> >>>>>>    the requested fmt to one from our cached fmts
> >>>>>>
> >>>>>> 5. On stream-on do the actual power-on + set-fmt + verify that we get
> >>>>>>    what we expect based on the cache, and otherwise return -EIO.
> >>>>>
> >>>>> Can we start powering up the device during try/set fmt and then
> >>>>> implement the format caching as an improvement?
> >>>>
> >>>> This sounds worth trying. We'll need to test it on a wide range of
> >>>> devices though, both internal and external.
> >>>
> >>> For what is worth, we have been running something similar to
> >>> https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
> >>> in ChromeOS and it has worked fine....
> >>>
> >>> But I am pretty sure that it has issues with async controls :S
> >>
> >> Interesting that is actually a lot more aggressive (as in doing a
> >> usb_autopm_put_interface() often) then what I expected when you said:
> >>
> >> "Can we start powering up the device during try/set fmt"
> >>
> >> As I mentioned in my other emails what I think would worth nicely
> >> is delay the initial usb_autopm_get_interface() till we need it
> >> and then just leave the camera on till /dev/video# gets closed.
> >>
> >> That idea is based on dividing apps in 2 groups:
> >>
> >> 1. Apps just temporarily opening /dev/video# nodes for discovery,
> >> where we ideally would not power-up the camera.
> >>
> >> 2. Apps (could even be the same app) opening /dev/video# for
> >> a longer time because it actually want to use the camera
> >> at the moment of opening and which close the /dev/video# node
> >> when done with the camera.
> >>
> >> Your code seems to also covers a 3th group of apps:
> >>
> >> 3. Apps opening /dev/video# for a long time, while not using
> >> it all the time.
> >>
> >> Although it would be nice to also cover those, IMHO those are
> >> not well behaved apps and I'm not sure if we need to cover those.
> >
> > Is that right ? Isn't it better for an application to keep the device
> > open to avoid open delays or even open failures when it wants to use the
> > device ?
>
> Keeping devices open has advantages and disadvantages. E.g. keeping
> /dev/input/event# nodes open will also typically lead to e.g.
> touchscreens staying powered on.
>
> Generally speaking it is not unheard of to expect userspace to
> behave in a certain way for things like this for power-consumption
> reasons.
>
> I guess the question is how far do we want to go inside the uvc
> driver to avoid userspace needing to close the /dev/video# nodes
> when unused.
>
> Ricardo's patch from here:
>
> https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
>
> goes all the way and if I understand Ricardo correctly this is
> already in use in ChromeOS ?

It is in use on just some devices. I try to not diverge from upstream if I can.

>
> So we could also go with this. Maybe put it behind a Kconfig option
> for a while ?

I can try to work on a new version of the patch, including support for
async controls the way I described in my previous email.
Let me know what you think.

>
> AFAICT the only thing which needs to be figured out there is async
> controls.
>
> I think we can simply set a long autosuspend delay on devices with
> async controls to deal with that ?
>
> I have a Logitech QuickCam Orbit (non AF) UVC camera which has
> pan + tilt controls and AFAICT these work fine with v4l2-ctl
> which immediately closes the /dev/video# node after the set-ctrl
> command. But I'm not sure if I have tested this without the camera
> streaming at the time. Anyways that is at least one camera I can test.
>
> Regards,
>
> Hans
>
>


-- 
Ricardo Ribalda

