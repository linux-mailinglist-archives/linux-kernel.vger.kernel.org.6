Return-Path: <linux-kernel+bounces-420998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD29D8568
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA69D28568A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43309191F91;
	Mon, 25 Nov 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCH9B3xC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6B1547C3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537548; cv=none; b=IfxKsgY0oBq5JtkP3BMxK4EpuXwrX52CzzEGzPnoP7c2w6yvJsnRTmIRd80vj9+JKpitwWjI0yr8mx+tt/hmqnBPeGGC3CECdHR6UZ2SEsoRbzyerBuHrL1/IXz817p/eHLDX6Qt3wrJaPPOhfZmflEMEkwOZvLPFFO5h+0u1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537548; c=relaxed/simple;
	bh=awkhOdmcrAaka+uC4QAHvteJBoj1suS1N0zdwROecWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrA3GDD9/HP8CEJ9QLzmV+qWc5vfBM6WuV1E5Q1yr55MwaMPQ0cfjC1yMEuSPH4NZBHHvJ8Kq8AIselKem1N/aQTTem0Lz1VbGa+rk4RIWgIBhhTxL3b2RsvPehg8ZuyR3CSf+TpnL4qbueQErDU3C8yiRbitE6sPHaH3hPIZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCH9B3xC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732537545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UipEsdUDZv2puatnG+MmRRhEmVsTQ1X+NpBU/k99t7s=;
	b=QCH9B3xCZar3ObcHDKskhktYfZT2UFsYBBywfc5dRSf2Qhknujcrq4hn3b6FmWIV8m4q81
	tD/xFFEYKwUxSYgHnCZG+2skaZZbL44bzgsNUD4JclTtHushOwYZupDSOmRwNy0nFSehef
	Cfxy7Nt9cmJL/ktuAftqWUiTMRbAtj8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Z6H5OKPINFKTY-N_fniayg-1; Mon, 25 Nov 2024 07:25:44 -0500
X-MC-Unique: Z6H5OKPINFKTY-N_fniayg-1
X-Mimecast-MFC-AGG-ID: Z6H5OKPINFKTY-N_fniayg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa53537b4c6so159379066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537543; x=1733142343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UipEsdUDZv2puatnG+MmRRhEmVsTQ1X+NpBU/k99t7s=;
        b=EPX4P9Gr5hks4gaeowduPc1YWYC8v3cchsHfNbUrF+qL4MMKMnjtNPMX5bJW/xxvgk
         vcDjltLr2tVt7nVRmzn6Q65fEpZ4Co2QyYMOjzpR1FYhTY1o0ss0GrvVjSD2QbXAxgFx
         ZPRVoZzI1wcBwnsNhiuHKAIazN1oGSj4dPzihXQdSlk1K2tsuHJjvakaRRGUQlAnkWQ3
         d0a9g5L1/kMODRgEeEJpp9C2B3lZ4MZrEMh+BoL5+gXDNiZFc7frjPH8t1HT3fTke2pp
         Gqge68d5uZhuVBZ0Ei+rtvSHUAiubt2xoj/M8TucMvhDwe/8ocI87Xyu1z6ykjkRAflG
         YE4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ34AXpijjTQOpO3kXedRWsaahhH9wRuEK3kHVMn3U5Zd2+xSjYgIU9gW0BNAb6L8VJqC8+mk1re8+RFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpWK8RcdDK2HU/Xfsov3ssQFsXU+dPbpSkCbUHykhyjqAjOZ/
	dRbIWX3YhRNUHJclM7HQPZRMT7jxQkqXWUr9I6cjORsLAZ3+l390uTbZByYa9OVTMiANJcW0p/1
	MUwZmJZby2h+cHppvYHotgQRaM4Lhc6Az8jDAqXH5GYD3XwkjRsh3cZK8o0gAqQ==
X-Gm-Gg: ASbGncuMBA/PM4GA+cpHIkWJzkLBNNKCo0ADtMeTmrx7WiqC+m71K5FWk2LBjFCkU3Y
	FrjT8YwAHMsA1E/BL5LTABSeR4JE0lUhqNI4aE7ngO8yXltLgVoKglHNn6XPJeGFO1lIJe7JkwY
	d6IhyVxKB0UyvYtnrSbw9rlsehZMfczYjxjSLRMGyPC5rVgv5158/WJsGESYarbi9cUCtQoppjW
	oZ9xetNzY1cyszUhzQTgfjj5LMWC2dVkWXQ4xW6yTa4cjcZ1G21zF6BA3tS+rIx3VYgmqvkLKFP
	oXQc/3t2iTTaGfuRBvLglq80M9EpnzkxmegxtX3J1/VNA6ZTHuVx5pKQ1Man83WFVdnIIL7i40M
	zvo7ZOdCnBGpPG9cCYFuI9qgP
X-Received: by 2002:a17:906:1da9:b0:aa5:3950:10ea with SMTP id a640c23a62f3a-aa5395015ddmr633029966b.36.1732537543115;
        Mon, 25 Nov 2024 04:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAwoRMpod2zBQ9KdOEIZ6eq4riZ6XcMBUAYu7xUxYliAtWQ92HCvt1sG335Bkq7zAEOxoj0g==
X-Received: by 2002:a17:906:1da9:b0:aa5:3950:10ea with SMTP id a640c23a62f3a-aa5395015ddmr633027966b.36.1732537542778;
        Mon, 25 Nov 2024 04:25:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f5fdesm455741666b.72.2024.11.25.04.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:25:42 -0800 (PST)
Message-ID: <55c76c99-dc86-41b2-84c6-d2e844530f67@redhat.com>
Date: Mon, 25 Nov 2024 13:25:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
 <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 9-Nov-24 5:29 PM, Ricardo Ribalda wrote:

<snip>

>> I have been discussing UVC power-management with Laurent, also
>> related to power-consumption issues caused by libcamera's pipeline
>> handler holding open the /dev/video# node as long as the camera
>> manager object exists.

<snip>

>> Here is what I have in mind for this:
>>
>> 1. Assume that the results of trying a specific fmt do not change over time.
>>
>> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
>>    enum-frame-sizes -> enum-frame-rates tripplet results
>>    (constrain what userspace requests to these)
>>
>> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
>>    3 levels nested loop for this) on probe() and cache the results
>>
>> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
>>    the requested fmt to one from our cached fmts
>>
>> 5. On stream-on do the actual power-on + set-fmt + verify that we get
>>    what we expect based on the cache, and otherwise return -EIO.
> 
> Can we start powering up the device during try/set fmt and then
> implement the format caching as an improvement?

Yes, actually looking at how complex this is when e.g. also taking
controls into account I think that taking small steps is a good idea.

I have lately mostly been working on sensor drivers where delaying
applying format settings + all controls to stream-on is normal.

So that is the mental model I'm applying to uvc here, but that might
not be entirely applicable.

> Laurent mentioned that some cameras missbehave if a lot of controls
> are set during probing. I hope that this approach does not trigger
> those, and if it does it would be easier to revert if we do the work
> in two steps.

Ack, taking small steps sounds like a good plan.

<snip>

>> This should also make camera enumeration faster for apps, since
>> most apps / frameworks do the whole 3 levels nested loop for this
>> on startup, for which atm we go out to the hw, which now instead
>> will come from the fmts cache and thus will be much much faster,
>> so this should lead to a noticeable speedup for apps accessing UVC
>> cameras which would be another nice win.
>>
>> Downside is that the initial probe will take longer see we do
>> all the tryfmt-s there now. But I think that taking a bit longer
>> to probe while the machine is booting should not be an issue.
> 
> How do you pretend to handle the controls? Do you plan to power-up the
> device during s_ctrl() or set them only during streamon()?
> If we power-up the device during s_ctrl we need to take care of the
> asynchronous controls (typically pan/tilt/zoom), The device must be
> powered until the control finishes, and the device might never reply
> control_done if the firmware is not properly implemented.
> If we set the controls only during streamon, we will break some
> usecases. There are some video conferencing equipment that do homing
> during streamoff. That will be a serious API breakage.

How to handle controls is a good idea.

Based on my sensor experience my initial idea was to just cache them
all. Basically make set_ctrl succeed but do not actually do anyhing
when the camera is not already powered on and then on stream-on call
__v4l2_ctrl_handler_setup() to get all current values applied.

But as you indicate that will likely not work well with async controls,
although we already have this issue when using v4l2-ctl from the cmdline
on such a control and that seems to work fine. Just because we allow
the USB connection to sleep, does not mean that the camera cannot finish
doing applying the async control.

But I can see how some cameras might not like this and having 2 different
paths for different controls also is undesirable.

Combine that with what Laurent said about devices not liking it when
you set too much controls in a short time and I do think we need to
immediately apply ctrls.

I see 2 ways of doing that:

1. Use pm_runtime_set_autosuspend_delay() with a delay of say 1 second
and then on set_ctrl do a pm_runtime_get_sync() +
pm_runtime_put_autosuspend() giving the camera 1 second to finish
applying the async ctrl (which might not be enough for e.g homing) +
also avoid doing suspend + resume all the time if multiple ctrls are send

2. Instead of immediately powering on the camera on /dev/video# open
track per fh if the camera has been powered on and then on the first
set-ctrl, or the first other IOCTL like try/set-fmt which requires
the camera to be powered on power it up and then keep it on until
the fh is closed, since apps hitting these paths are likely to do
more stuff which requires the camera to be powered on.

This should avoid apps (like udev rules) just doing a simple get-cap
query of powering on the camera, while at the same time preserving
the current behavior for apps which want to actually do something
with the camera, so the chance of regressions should be small.

I guess the time between power-up and sending the first request to
the camera will change slightly. But most apps which actually want
to do stuff with the camera will likely already do so immediately
after opening /dev/video# so the timing change should be negligible.

I guess 2. is pretty similar to your proposal to delay power-on
to the first set/try-fmt, which I assume also already does
something similar wrt controls ?

I think that 2. can work nicely and that would be nice to have,
even though it does not fix the privacy-control + power-mgmt issue.

Regards,

Hans




