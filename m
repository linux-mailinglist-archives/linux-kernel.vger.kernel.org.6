Return-Path: <linux-kernel+bounces-421105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1979D86A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A84F28C05B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC21AC44D;
	Mon, 25 Nov 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OG27IG0R"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD8191F9E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541957; cv=none; b=j5GS1Dnjo9SW5UKgowIwQFs8JocnAwAW8BHHAmwo7Z6ISzgB5/XWolAts00L7YtiOR57QU56IXMeJjkzT8MhhQY7ZVMLm2RE93V5sJGT+8/jbAq5R8vcCyGZX/W2T0UXfZxnVsA0/QB0bvAtND7T/w0p/5BN328vLXsHMsq8suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541957; c=relaxed/simple;
	bh=iI4u+0P8PAxqK8FqrvMjyBoAkXpCJW142vZ6Pb++qCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or0jXP2KvMkAivHbbSzRxi0toTx5bSR3EgBeoOwPUa5z0r1IfE7bu8S9WlK4FaxAnFA+XNsmOZEkZ/YOICrVOowBbRGoi8DfRXuiUrtPEB+ZA2pyTtCCn4sY9QLcqo/45JFtVoyq8qTls5wvDXJl5nflCq+ASnFoKG+e/yCICTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OG27IG0R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21288d3b387so32858655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732541955; x=1733146755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHU43PrEmce5yy0ZUe/r7zMFo0keCbmE2OgOKALEIE8=;
        b=OG27IG0RGUDOLLX5N69PpfuJKO7gty1rlfHKtV+Luk9gg11fBk4YkndC5Zyj8Zmq8R
         TLVgUUgrBG3eKkCOv3y+pUe5C4y9d5omlziZ84s/I71WsGF7hvSS0PUYbEL709AxjoLe
         +OU3Fub1o3OCiTKmX/h/2/gCWqdFoK46UgpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732541955; x=1733146755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHU43PrEmce5yy0ZUe/r7zMFo0keCbmE2OgOKALEIE8=;
        b=kzWysjMyh1YSvlHfVC660TBhv7hgEmRS1wy9bLWpE0t0cvUvNXtm0By8lbZbURN+sY
         Ruxee9BeN74UI5imVYZi8b7IWwnUNSc7w/F0KF9qpmb/w0hMW2unL3d9VCWvtLvTHgUV
         FkxJ5rhNOAThmUKGg8wEm1p1ShBLf5AAAbZ99TdGXBr6wTeZjhfV862wfWVHjEx/k2uU
         O3YA+TNpp9tuTHzs1SHiUyqr4ZWPVdizWNFJ6euKmD1/XuadHChTK5a1J7Qvzfsfn8l+
         DjfI6THaTHJ18F+2nfdumIpwkuHvQYcd7lA7NYkkEJCkK4c4TmmltglG2mD41lmos439
         kdHg==
X-Forwarded-Encrypted: i=1; AJvYcCX573NNx+wzjdWgqS70m5g9QLFm9Nu1ypJdPtFvbEKgev7Dh5vMboWUtHFIKANBejoIwiXuWSSqAlmQ7TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2cGRwEGb+46ZJKOc8RRTCvsruxvAZni9vS2cuL7U/BSZJSb3
	YIGerg9zdy+b7WvrbsnfDwE5vpQJ8rpgV3kaU30SBNQBmsf3g4mReHCt7Np0okXuLlw2WLOZWB8
	=
X-Gm-Gg: ASbGncsqQXnS0cQZkfdZJts8IwopomgGxWW17OgkzZjp672nUZsc6y+TclZf5YR+WEO
	928lJJ2PnUUH+Gvqx+hkZkLbQVvXYjflVtMmyAwldQBDUtXTpvwuqeQkf2SppseUCQ9JvN/foB+
	E6ILMAUbRsjTxGMSKqxcv/3gW9fIzSoO/6UKrDvn9B6Exqo+NrqFMZAJVCXNPz2k3oOwMBX5dxa
	Lf/ffbTjL5m/LsghMFeHilF65mVqhr+lGv/d5CcOPfapgI5b7o2n4muQz+Kt73nLG5LeNgTtJo+
	1Bs+f+/xGDTp
X-Google-Smtp-Source: AGHT+IGAwAbL/H+P5brFxRbIL1viZGHXlK+T5E3GHJxO8G2TAFqT6eX58d6qxw3iPj9sz8I06EoaKA==
X-Received: by 2002:a17:902:e741:b0:212:c7:3d57 with SMTP id d9443c01a7336-2129f983c1fmr190006645ad.46.1732541954992;
        Mon, 25 Nov 2024 05:39:14 -0800 (PST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22a4asm64643305ad.261.2024.11.25.05.39.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:39:14 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so3546709a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:39:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+YPHSmESfvKA8ef+WCJGHZZJNoOWHdc6e9YssDHK5ow9do12Nnr3EXwWAkWcVt8iXypSGGVJ4CP0t9aE=@vger.kernel.org
X-Received: by 2002:a17:90b:17c8:b0:2ea:8e42:c46 with SMTP id
 98e67ed59e1d1-2eb0d50eb9dmr17426810a91.0.1732541953267; Mon, 25 Nov 2024
 05:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com> <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <55c76c99-dc86-41b2-84c6-d2e844530f67@redhat.com>
In-Reply-To: <55c76c99-dc86-41b2-84c6-d2e844530f67@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 14:39:01 +0100
X-Gmail-Original-Message-ID: <CANiDSCtvLB=tWb7ZCFCw9gn26R2xHnOf=yTLj+M_4AuQKYvgOQ@mail.gmail.com>
Message-ID: <CANiDSCtvLB=tWb7ZCFCw9gn26R2xHnOf=yTLj+M_4AuQKYvgOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a subdevice
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:25, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> On 9-Nov-24 5:29 PM, Ricardo Ribalda wrote:
>
> <snip>
>
> >> I have been discussing UVC power-management with Laurent, also
> >> related to power-consumption issues caused by libcamera's pipeline
> >> handler holding open the /dev/video# node as long as the camera
> >> manager object exists.
>
> <snip>
>
> >> Here is what I have in mind for this:
> >>
> >> 1. Assume that the results of trying a specific fmt do not change over time.
> >>
> >> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
> >>    enum-frame-sizes -> enum-frame-rates tripplet results
> >>    (constrain what userspace requests to these)
> >>
> >> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
> >>    3 levels nested loop for this) on probe() and cache the results
> >>
> >> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
> >>    the requested fmt to one from our cached fmts
> >>
> >> 5. On stream-on do the actual power-on + set-fmt + verify that we get
> >>    what we expect based on the cache, and otherwise return -EIO.
> >
> > Can we start powering up the device during try/set fmt and then
> > implement the format caching as an improvement?
>
> Yes, actually looking at how complex this is when e.g. also taking
> controls into account I think that taking small steps is a good idea.
>
> I have lately mostly been working on sensor drivers where delaying
> applying format settings + all controls to stream-on is normal.
>
> So that is the mental model I'm applying to uvc here, but that might
> not be entirely applicable.
>
> > Laurent mentioned that some cameras missbehave if a lot of controls
> > are set during probing. I hope that this approach does not trigger
> > those, and if it does it would be easier to revert if we do the work
> > in two steps.
>
> Ack, taking small steps sounds like a good plan.
>
> <snip>
>
> >> This should also make camera enumeration faster for apps, since
> >> most apps / frameworks do the whole 3 levels nested loop for this
> >> on startup, for which atm we go out to the hw, which now instead
> >> will come from the fmts cache and thus will be much much faster,
> >> so this should lead to a noticeable speedup for apps accessing UVC
> >> cameras which would be another nice win.
> >>
> >> Downside is that the initial probe will take longer see we do
> >> all the tryfmt-s there now. But I think that taking a bit longer
> >> to probe while the machine is booting should not be an issue.
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
>
> How to handle controls is a good idea.
>
> Based on my sensor experience my initial idea was to just cache them
> all. Basically make set_ctrl succeed but do not actually do anyhing
> when the camera is not already powered on and then on stream-on call
> __v4l2_ctrl_handler_setup() to get all current values applied.
>
> But as you indicate that will likely not work well with async controls,
> although we already have this issue when using v4l2-ctl from the cmdline
> on such a control and that seems to work fine.

-----
> Just because we allow
> the USB connection to sleep, does not mean that the camera cannot finish
> doing applying the async control.
>
Not sure what you mean with this sentence. Could you explain it
differently? Sorry

> But I can see how some cameras might not like this and having 2 different
> paths for different controls also is undesirable.
>
> Combine that with what Laurent said about devices not liking it when
> you set too much controls in a short time and I do think we need to
> immediately apply ctrls.
>
> I see 2 ways of doing that:
>
> 1. Use pm_runtime_set_autosuspend_delay() with a delay of say 1 second
> and then on set_ctrl do a pm_runtime_get_sync() +
> pm_runtime_put_autosuspend() giving the camera 1 second to finish
> applying the async ctrl (which might not be enough for e.g homing) +
> also avoid doing suspend + resume all the time if multiple ctrls are send

What about 1.5:

during s_ctrl():
usb_autopm_get_interface()
if the control is UVC_CTRL_FLAG_ASYNCHRONOUS.
       usb_autopm_get_interface()
set the actual control in the hardware
usb_autopm_put_interface()

during uvc_ctrl_status_event():
   usb_autopm_put_interface()

during close():
   send all the missing usb_autopm_put_interface()


This way:
- we do not have an artificial delay that might not work for all the use cases
- cameras with noncompliant async controls will have the same PM
behaviour as now  (will be powered on until close() )

We do the same with the rest of the actions that require hardware access, like:
https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/

This way:
- Apps that do not need to access the hardware, do not wake it up, and
we do not break usecases.

Next steps will be:
 - cache the formats
 - move the actual set_ctrl to streamon... but if we can do that I
would argue than we can move completely to the control framework.



>
> 2. Instead of immediately powering on the camera on /dev/video# open
> track per fh if the camera has been powered on and then on the first
> set-ctrl, or the first other IOCTL like try/set-fmt which requires
> the camera to be powered on power it up and then keep it on until
> the fh is closed, since apps hitting these paths are likely to do
> more stuff which requires the camera to be powered on.
>
> This should avoid apps (like udev rules) just doing a simple get-cap
> query of powering on the camera, while at the same time preserving
> the current behavior for apps which want to actually do something
> with the camera, so the chance of regressions should be small.
>
> I guess the time between power-up and sending the first request to
> the camera will change slightly. But most apps which actually want
> to do stuff with the camera will likely already do so immediately
> after opening /dev/video# so the timing change should be negligible.
>
> I guess 2. is pretty similar to your proposal to delay power-on
> to the first set/try-fmt, which I assume also already does
> something similar wrt controls ?
>
> I think that 2. can work nicely and that would be nice to have,
> even though it does not fix the privacy-control + power-mgmt issue.
>
> Regards,
>
> Hans
>
>
>


-- 
Ricardo Ribalda

