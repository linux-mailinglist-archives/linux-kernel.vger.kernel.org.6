Return-Path: <linux-kernel+bounces-421005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D79D8580
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7365B169B14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162811A0AF0;
	Mon, 25 Nov 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cN6IQY4b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73651552E3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538353; cv=none; b=YwKBsM7N8OobH5lRojvhzegCXFY8go9ahsRXtAA50xgQpef37iXunguG816G6419S/Sf3E3DYMgsr/pLYWZ84ZEuWl4cqynRi8VcpKXNW/TNujB6kHmXPOq9pj6IbE/puvCBLyEJ3JTL9BFItehngRdVOagpK6auQ2IhPJPF/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538353; c=relaxed/simple;
	bh=k4iMJ84f3HreES954i68XDfttraLGB3fFuvF5aaBW5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It+anXNEPeMvA0BLL7vB2Cj0Thh33DIo20I5SbCTtwILOyttMb0v9ndx1LFdgUGNQ+dUso9ghHxrIKdauMKtoitc8yvZNvEhlYbkSIxJc12h+IuOCFnQ3r6/UwF2scMQCbttBms31JahzSN1o3A9X85LzEsNyUIord1DhFVcaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cN6IQY4b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732538350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yef20OpwpU9zOgOimbXnx430m9fj8MKsFysmHZ/NyCY=;
	b=cN6IQY4b1QiZGuOS8++91pF0rH+GNmZWpyLCGt1jlQDainXNS95WAW38Am77dSMm2FfE7+
	hZbK8GsJj/t5lnph+hqT2JFdPdDrbLda989wRoFSDgEcSVGjSAP4FcDPZl1AZEBdqUCnqB
	DZvhaMg3WE5+zLkCMPaqdqV0lXMZqm8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-08jNsFYhNUGBgAnjQNVtqw-1; Mon, 25 Nov 2024 07:39:09 -0500
X-MC-Unique: 08jNsFYhNUGBgAnjQNVtqw-1
X-Mimecast-MFC-AGG-ID: 08jNsFYhNUGBgAnjQNVtqw
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53de5d603dcso177925e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538348; x=1733143148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yef20OpwpU9zOgOimbXnx430m9fj8MKsFysmHZ/NyCY=;
        b=Y79VJMiryT1Wyp/hUEN9dFMiv5hKMkXuPmqAe/YSgY1zpqKMFATiYCrtRGsnPvQ33x
         0PW6RMRa1sYcAGcW2nL5QUJTwwkXo2Mt4uV3/agDb4P26yB+QTRVH0Y73QLi4yI/po8p
         UzFsMb4k8I2IULby+XvAgm6IzWfKeku1WHbxA8Vzm0y3SiiMH8xsFWlahrX2RSJJXJHt
         ZLZo4KwHAuIf5kA4X8WXYco7QfBzG5QVzKHb3l3qtzXXPNLPIQO6/EukBqGThvQ1KqNA
         hbZV0eLOiSBM3dPTax9cMIWiDSAMjRSWRoNiG0RfE2tdPVNXrUoo1oRv4cqYG1cEC2eY
         /pJw==
X-Forwarded-Encrypted: i=1; AJvYcCXvvTF8ZXaBSZE5yS6ducic2pYQtm55EbiHzcuKyr+j7vOMFI+hvFMIucY+ZIOZ84zME+pIpT/r+8i76h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzffA0g7lwmdtP6utrl8R4Zl3JW9jNhNnr6s2+EtSpXHZy6Ae
	0pWH6SWIkioS3Z4tvHZ1eZWie+rmLcktNeZMPvLq7woHwgGoJSXLkACAKlO5KefDhwy+wfmTZI2
	7x797MsxNS15Tj30vIp4/dd6trUFxq/GT9PiYWC5BLIsQF3/BS0bq1ZwoU0dZ1w==
X-Gm-Gg: ASbGncvT4PxHDasornv92lRVr/nLqz78GERwjFG6BZGKHy6X3ZpJr1/IWcUkri+V4y2
	O2bJfGcmZs0L+iTuUGHglWRy9hICDFw3TT/rdDMcnU3tI1CAH5ByfuJIaWCwYpmM4UjEwscDcCp
	Kkefllq5TkcRD8oPKnJ4330xzspOyIGXLcJk2VYkqXjxuRHbOFmwxcwyhVdNXPwlf0jQGUPOtWY
	l7zI2nH3m+y23k2OKdpQjD7czFtBdfyLxZbGloddASlSS42NgfTDn7YXqO0ngkwT0McGTl+ufac
	jNxuL8h2Rsr3sP0395gIHwnkmRTkV4pPgk/XP9YVit3IbNaGHEVCpn7mLfP6yPIzWNR4Tr2Km0r
	ZeSPQCWC2VZHZIb5SxwEa7gxd
X-Received: by 2002:a05:6512:130b:b0:53b:4a6c:1849 with SMTP id 2adb3069b0e04-53dd39a4d14mr7171034e87.35.1732538347722;
        Mon, 25 Nov 2024 04:39:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF750kOuffMEJVJ/0tYr09qlriuyREKbt1Z4XlV2p/iS4b/RkjjaPU0DnFiogipgHhxnpuvMw==
X-Received: by 2002:a05:6512:130b:b0:53b:4a6c:1849 with SMTP id 2adb3069b0e04-53dd39a4d14mr7171018e87.35.1732538347280;
        Mon, 25 Nov 2024 04:39:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa545385bbcsm211715166b.185.2024.11.25.04.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:39:06 -0800 (PST)
Message-ID: <123bfac4-389a-400a-8104-afc27124b75d@redhat.com>
Date: Mon, 25 Nov 2024 13:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <5b5f3bb7-7933-4861-be81-30345e333395@redhat.com>
 <CANiDSCta62P5+1aR9Ks8c6sd3_grCV3C+Le=UjKGkiohyf0R2g@mail.gmail.com>
 <20241110151426.GD6002@pendragon.ideasonboard.com>
 <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCsTNuQRXwMqA_YmX4MJ-A8eTi_rEpkd+Qv=Qwbbrj18Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 10-Nov-24 5:07 PM, Ricardo Ribalda wrote:
> On Sun, 10 Nov 2024 at 16:14, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

<snip>

>>>> Here is what I have in mind for this:
>>>>
>>>> 1. Assume that the results of trying a specific fmt do not change over time.
>>>>
>>>> 2. Only allow userspace to request fmts which match one of the enum-fmts ->
>>>>    enum-frame-sizes -> enum-frame-rates tripplet results
>>>>    (constrain what userspace requests to these)
>>>>
>>>> 3. Run the equivalent of tryfmt on all possible combinations (so the usaul
>>>>    3 levels nested loop for this) on probe() and cache the results
>>>>
>>>> 4. Make try_fmt / set_fmt not poweron the device but instead constrain
>>>>    the requested fmt to one from our cached fmts
>>>>
>>>> 5. On stream-on do the actual power-on + set-fmt + verify that we get
>>>>    what we expect based on the cache, and otherwise return -EIO.
>>>
>>> Can we start powering up the device during try/set fmt and then
>>> implement the format caching as an improvement?
>>
>> This sounds worth trying. We'll need to test it on a wide range of
>> devices though, both internal and external.
> 
> For what is worth, we have been running something similar to
> https://lore.kernel.org/linux-media/20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org/
> in ChromeOS and it has worked fine....
> 
> But I am pretty sure that it has issues with async controls :S

Interesting that is actually a lot more aggressive (as in doing a
usb_autopm_put_interface() often) then what I expected when you said:

"Can we start powering up the device during try/set fmt"

As I mentioned in my other emails what I think would worth nicely
is delay the initial usb_autopm_get_interface() till we need it
and then just leave the camera on till /dev/video# gets closed.

That idea is based on dividing apps in 2 groups:

1. Apps just temporarily opening /dev/video# nodes for discovery,
where we ideally would not power-up the camera.

2. Apps (could even be the same app) opening /dev/video# for
a longer time because it actually want to use the camera
at the moment of opening and which close the /dev/video# node
when done with the camera.

Your code seems to also covers a 3th group of apps:

3. Apps opening /dev/video# for a long time, while not using
it all the time.

Although it would be nice to also cover those, IMHO those are
not well behaved apps and I'm not sure if we need to cover those.

Although looking back at the libcamera uvc pipeline handler issue
I fixed recently, that was actually a case of 3.

Regards,

Hans


