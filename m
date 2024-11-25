Return-Path: <linux-kernel+bounces-421116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD499D86BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01862164C27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F711AC456;
	Mon, 25 Nov 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y59Y8pyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599A1AB50C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542251; cv=none; b=shQD45FHMgI4Cica0cz8WzSW/MXJCO0butxR7NocoxZJQdjaF2fwysBjHfCU2NYaTRpYy0UNTQSwjXThjj1DbgXcvyD8jiltf8xiq4u8qA3BX91w0fRFJWQ26b4SOhDEYWO2Njl3oZxYvLmIaZCR/uahmnkPvDrO7tRp1gAO2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542251; c=relaxed/simple;
	bh=NdpHPl91yCIP6m0C14SiDShavK1QjUgunTuuG3bOhFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcBjg2erWsXYr11c3v3u2E7TSFLbgC3t9NxNm1HYJX+yjey4Yk96EkZqvtYNLCGsEQlbLdBClxFlKiAscz6yNoA9OWKRvNcuXXjwoCGOPwrusbNErhndjKGhggKNcIenB31xYcm/uyQsPxScRaA4s/uh+EaQg15D6EpIQZEMHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y59Y8pyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732542248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhhNcg4tt2EmSYnWuYxYmElmP5/JIvyr3LxTavuF7BY=;
	b=Y59Y8pyjva25Kga6pBTuEuB4JQQc3p/y9EAGyGx6hetOhNd1wtm8ZPROfoLsuWDP/CVfoe
	sgpnEJVQty4lCbfTkoXY8IvCPYilF8o3WJ2EnDUfa+x+4RyY7gZcGo1x5JtRz9vdFBb+Ty
	2gOAjyIQ0AIXdtMLAiQCBy37oDCu7pI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-8Uc9-YlqMReFzmjhTELH7g-1; Mon, 25 Nov 2024 08:44:06 -0500
X-MC-Unique: 8Uc9-YlqMReFzmjhTELH7g-1
X-Mimecast-MFC-AGG-ID: 8Uc9-YlqMReFzmjhTELH7g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa52d371666so195646766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542245; x=1733147045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhhNcg4tt2EmSYnWuYxYmElmP5/JIvyr3LxTavuF7BY=;
        b=dXEBAfETdU62QMOAEI298MXq7v7EA7OMgYH4swkhmZEK35W41tABUFH1oZS9PsL+Oc
         P/ekBLI4ypnshNLsPRs7ILDaatMDYvnrgFkqId4CQk+HhEt1dAH2fNFKPfHY8rrDtAMe
         QXTPoDwKNN2eC57Oc8MsAeKnPaV0Yug3CxhXmIupsfjSLBG1dhO0uC44OgrHchh4SbGK
         JuBgUOz2Y7Kp/vdnqAfrpqGLKkgHslua3/UlzpDdYaR6dYljCuaQLNbMhzOGZsY8vPnQ
         VipcnIzFIMqo4npbWmXzEQThE70iY+iRvNZTv/4MFDRFBijAXnc6utT0lvEOPI1gwvFI
         9pwg==
X-Forwarded-Encrypted: i=1; AJvYcCUvAeVtBUdXMnRiqAU7FkoH4+IbzBEyZduBa8Dj7lO7FO0h0jMfhDqOEzhRktH0KXUmd/T+kzvvbwbr7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGodvSNmmt+d3tyldmONmJNS90eTvVM6p+BnWlfoLWja/LUUMp
	Sq0oR285knif3RqrLbmWfBlCn8h6yYF1/DpiojqKMShQ7xsrR5V8ie0MQ05S+sYq+X2zttO56zO
	zdB1vgjG02e53HyTomNvRPkiilwQs7f7QM/2ygfrRVL9KrOHbyuUCnmnx37m2aA==
X-Gm-Gg: ASbGncvYTRQ2H64LZcI0regL0woX7i6xrNC109PEg9sj7rfRpnSH5wP8qZe4k9AiD3y
	g87b9fqhgH/cr2LBhxdZ4Q5rtQKrsQfeFzey1jm8NBZW58PTE0WjHaNQ3F3kLB+c/QlcFUrROme
	IKyOwKQnuTxnGPnT/9ugGz5cepiVXcMSdhiX2fh8kGdbOJrrFhkyMyJBeSn9+k7DeI6rGelyjBk
	xfz+qdWjCJMsJk68vu78Tpqpw5+UyrDY0BvL5Z11JjYPSx0jippiGJ2Ctcy3gUMPOiln1IYgBkV
	JnOpuWR5ecGny0NpGY2pmDOQBtFA2UDE1zTXJ55NbvDKie4xKUnTHlEjdAHYyVXwxIwf2XBRPll
	30iKhZbpyZJU+SX5lWz4A01Gv
X-Received: by 2002:a17:907:7639:b0:a9a:3cec:b322 with SMTP id a640c23a62f3a-aa509d3fd2amr1095067566b.45.1732542244913;
        Mon, 25 Nov 2024 05:44:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI1u01TNhqvUqYHqTS4lo03ToXCKST9SdpaSegeiA7kHV4Twp87DS4sYBUS8u3Ao7Hu2Ds1g==
X-Received: by 2002:a17:907:7639:b0:a9a:3cec:b322 with SMTP id a640c23a62f3a-aa509d3fd2amr1095065666b.45.1732542244558;
        Mon, 25 Nov 2024 05:44:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f88bsm465710466b.2.2024.11.25.05.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:44:04 -0800 (PST)
Message-ID: <33e7dbc8-0d29-4905-a28c-e562151a837a@redhat.com>
Date: Mon, 25 Nov 2024 14:44:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
 <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110151426.GD6002@pendragon.ideasonboard.com>
 <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
 <123bfac4-389a-400a-8104-afc27124b75d@redhat.com>
 <20241125125834.GC32280@pendragon.ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241125125834.GC32280@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Nov-24 1:58 PM, Laurent Pinchart wrote:
> On Mon, Nov 25, 2024 at 01:39:05PM +0100, Hans de Goede wrote:
>> Hi Ricardo,
>>
>> On 10-Nov-24 5:07 PM, Ricardo Ribalda wrote:
>>> On Sun, 10 Nov 2024 at 16:14, Laurent Pinchart
>>> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> <snip>
>>
>>>>>> Here is what I have in mind for this:
>>>>>>
>>>>>> 1. Assume that the results of trying a specific fmt do not change over time.
>>>>>>
>>>>>> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
>>>>>>    enum-frame-sizes -> enum-frame-rates tripplet results
>>>>>>    (constrain what userspace requests to these)
>>>>>>
>>>>>> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
>>>>>>    3 levels nested loop for this) on probe() and cache the results
>>>>>>
>>>>>> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
>>>>>>    the requested fmt to one from our cached fmts
>>>>>>
>>>>>> 5. On stream-on do the actual power-on + set-fmt + verify that we get
>>>>>>    what we expect based on the cache, and otherwise return -EIO.
>>>>>
>>>>> Can we start powering up the device during try/set fmt and then
>>>>> implement the format caching as an improvement?
>>>>
>>>> This sounds worth trying. We'll need to test it on a wide range of
>>>> devices though, both internal and external.
>>>
>>> For what is worth, we have been running something similar to
>>> https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
>>> in ChromeOS and it has worked fine....
>>>
>>> But I am pretty sure that it has issues with async controls :S
>>
>> Interesting that is actually a lot more aggressive (as in doing a
>> usb_autopm_put_interface() often) then what I expected when you said:
>>
>> "Can we start powering up the device during try/set fmt"
>>
>> As I mentioned in my other emails what I think would worth nicely
>> is delay the initial usb_autopm_get_interface() till we need it
>> and then just leave the camera on till /dev/video# gets closed.
>>
>> That idea is based on dividing apps in 2 groups:
>>
>> 1. Apps just temporarily opening /dev/video# nodes for discovery,
>> where we ideally would not power-up the camera.
>>
>> 2. Apps (could even be the same app) opening /dev/video# for
>> a longer time because it actually want to use the camera
>> at the moment of opening and which close the /dev/video# node
>> when done with the camera.
>>
>> Your code seems to also covers a 3th group of apps:
>>
>> 3. Apps opening /dev/video# for a long time, while not using
>> it all the time.
>>
>> Although it would be nice to also cover those, IMHO those are
>> not well behaved apps and I'm not sure if we need to cover those.
> 
> Is that right ? Isn't it better for an application to keep the device
> open to avoid open delays or even open failures when it wants to use the
> device ?

Keeping devices open has advantages and disadvantages. E.g. keeping
/dev/input/event# nodes open will also typically lead to e.g.
touchscreens staying powered on.

Generally speaking it is not unheard of to expect userspace to
behave in a certain way for things like this for power-consumption
reasons.

I guess the question is how far do we want to go inside the uvc
driver to avoid userspace needing to close the /dev/video# nodes
when unused.

Ricardo's patch from here:

https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/

goes all the way and if I understand Ricardo correctly this is
already in use in ChromeOS ?

So we could also go with this. Maybe put it behind a Kconfig option
for a while ?

AFAICT the only thing which needs to be figured out there is async
controls.

I think we can simply set a long autosuspend delay on devices with
async controls to deal with that ?

I have a Logitech QuickCam Orbit (non AF) UVC camera which has
pan + tilt controls and AFAICT these work fine with v4l2-ctl
which immediately closes the /dev/video# node after the set-ctrl
command. But I'm not sure if I have tested this without the camera
streaming at the time. Anyways that is at least one camera I can test.

Regards,

Hans



