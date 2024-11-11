Return-Path: <linux-kernel+bounces-404223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBC9C410C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D21282A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987741A08C6;
	Mon, 11 Nov 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLqlDOFv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696C1A070E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335721; cv=none; b=Ox1zFOfzUt0LnzPAXrhooqGbNigkWJJvcmw1nI/VrfHb299vze6dLZ1YOhTiVPzjSPvyi+j5bEVk15YbSGaFfo1AxC8B87wAIScCCphNmlwfHSpnWa+sENTPAS3ILNDxjhHvaHK13RsqzFTQj9NAmPIE4gxHGgPKCfbqIYohgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335721; c=relaxed/simple;
	bh=WrVn9TW9kOmHFecckhkfiRpiEUOowAKBgBRdpRWlWMc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K419/8l86LWArXMehU2+QZXhb8qDbx834dV3nTWE6+D3/ShRcCacnuQN8g8sYi6QfVMXjObdf72tg1p2Vnx04FGz0lOa0hZEcnveiWIf4SaigWcCAtRnzhQe2tF/yTTRoZ+iuWzErg42hd+Fi7K+9CrDQFuEOtDiJczHSTBvgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLqlDOFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731335719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEraueI3D8vxdIlzbXk9k2nsBw5FTtLrfKoo0JbFBYI=;
	b=BLqlDOFvdvTjmFdMF0TuGBfx/O3r70IIzMM723gi2taUkEVOrJIoGDy4N7S7pzj8HbIc/U
	KohKnAkvxOvzqS529lv2MIl1MbTsQEmsVYlnY+0kE4nX3ktPfBkSlPbFpZcO3v7xDSOf9g
	PIOA47DPMY2gYYRtrZeQCFx3CCFtXsc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-IiSTyxW0OrOWIdKvfIi1Xg-1; Mon, 11 Nov 2024 09:35:17 -0500
X-MC-Unique: IiSTyxW0OrOWIdKvfIi1Xg-1
X-Mimecast-MFC-AGG-ID: IiSTyxW0OrOWIdKvfIi1Xg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c9465e3547so3756090a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335716; x=1731940516;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEraueI3D8vxdIlzbXk9k2nsBw5FTtLrfKoo0JbFBYI=;
        b=c9iUK5PGksQu+2FySnEfM+oxvTqt3ncsGHquFZwzmNHuTJ3b/uuh7YQEPfMaQ46aL7
         fDxY7ZABboCqGmfbCeQ8N9s9O7zJlrpjMNaT0VmNtKkcGMNM8THllb+2m0lVrNjzKfrg
         g8eUwabC5HeZkTZsAgdKRb97iq5VmpAQm4nnJR7FlJrS59+Fv0vPsyQ5ReM3cLxkD8Hm
         QlsPRkqainVP/b5r0ZNWCvqyHqUllc8ZNxFcoP1p/EUBSfeqAB608h2kwAHXaRxRfPvC
         2JPUe1qyTLYVdTQBlXIeUZwV1Eeqz1uG+B/pb68I4Wj3EONKIOLKzpOkTj0hyfkZJelv
         P5iQ==
X-Gm-Message-State: AOJu0YwrUP+GT82VUzMq5NgWwohwIDjKa3Hhp8Bto0jmEyQXuABQoIwt
	3azONgObJkLpPIaYqYm/lZQYp10/qtIN6TmiLKHYhLxImxudohlyoh24L4uH2zCMplLiedYYNpV
	fx4oJWuiOVe2bW2Oky5CqOPiRLRYgj1f7KhK3J2eey1VqgV/OL3pO+CdeptXJ4Q==
X-Received: by 2002:a05:6402:5213:b0:5ce:fc3c:3c3 with SMTP id 4fb4d7f45d1cf-5cf0a45c690mr11604545a12.28.1731335716359;
        Mon, 11 Nov 2024 06:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBn6M5jLeFz+WTQmnTdycpz6COiPHVTcBo8Ft2iihWhhhy48Jo7SlGezyBev8fDhok8/wvvA==
X-Received: by 2002:a05:6402:5213:b0:5ce:fc3c:3c3 with SMTP id 4fb4d7f45d1cf-5cf0a45c690mr11604517a12.28.1731335715875;
        Mon, 11 Nov 2024 06:35:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d724sm5013433a12.18.2024.11.11.06.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:35:15 -0800 (PST)
Message-ID: <91903a1b-f3b0-4c86-9337-bca4ae962535@redhat.com>
Date: Mon, 11 Nov 2024 15:35:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] media: uvcvideo: Implement the Privacy GPIO as a
 subdevice
From: Hans de Goede <hdegoede@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <a644fed4-aff5-4514-8e35-d6cab642d3dd@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <a644fed4-aff5-4514-8e35-d6cab642d3dd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

p.s.

On 11-Nov-24 1:59 PM, Hans de Goede wrote:
> Hi Ricardo, Et al.,
> 
> On 8-Nov-24 9:25 PM, Ricardo Ribalda wrote:
>> Some notebooks have a button to disable the camera (not to be mistaken
>> with the mechanical cover). This is a standard GPIO linked to the
>> camera via the ACPI table.
>>
>> 4 years ago we added support for this button in UVC via the Privacy control.
>> This has two issues:
>> - If the camera has its own privacy control, it will be masked
>> - We need to power-up the camera to read the privacy control gpio.
> 
> Thinking more about this I think we need to start with looking at the userspace
> API for privacy controls, define how we want that to look and then go from
> there.
> 
> The reason I'm writing this is because due to my work in drivers/platform/x86
> (pdx86) on EC / ACPI / WMI drivers for non chromebooks I am aware of at least
> 4 different methods camera on/off (aka privacy) toggles are being reported
> to userspace at the moment. Adding a v4l2-ctrl on a subdev instead of directly
> on /dev/video# would be adding a 5th method which seems highly undesirable.
> 
> Instead I would like to first focus on fixing these userspace API
> inconsistencies agreeing on a single API we want to use everywhere
> going forward. We don't need to fix all drivers at once, but IMHO we
> should agree on what the API should look like and document that and
> any future drivers implementing camera privacy control related code
> then must use the new API.
> 
> Lets start with the 3 APIs I'm currently aware of:
> 
> 1. uvcvideo driver exporting V4L2_CID_PRIVACY on /dev/video#
> uvcvideo seems to be the only user of this CID (i)
> 
> 2. pdx86 drivers exporting an input evdev with EV_SW,
> SW_CAMERA_LENS_COVER. This is somewhat of a special case
> for some Dell laptops with an electro-mechanical shutter
> operated by the EC. But this is not also used by
> hp-wmi.c where it does not necessarily indicate the

s/not/now/

> status of a mechanical cover, but also possibly simply
> disconnecting the camera from the USB bus.
> 
> 3. pdx86 drivers exporting an input evdev with EV_KEY,
> KEY_CAMERA_ACCESS_ENABLE, KEY_CAMERA_ACCESS_DISABLE
> These KEY codes are based on offical the HUTRR72 HID/HUT
> extension and as such may also be send by USB/I2C/BT HID
> devices.
> 
> The only user outside of hid-input.c is the recently added
> drivers/platform/x86/lenovo-wmi-camera.c driver and I'm
> wondering if that should not use SW_CAMERA_LENS_COVER
> instead. I'll ask the driver author about how this 

I have send an email out about possibly switching this to
SW_CAMERA_LENS_COVER :

https://lore.kernel.org/platform-driver-x86/5666914c-e8c2-481d-8fdf-aff82865c228@redhat.com/

Regards,

Hans



> 4. pdx86 drivers exporting an input evdev with EV_KEY,
> KEY_CAMERA. Note this 4th method lacks information on if
> the camera was enabled or disabled. In many cases this
> is send to indicate that the EC has either dropped
> a UVC camera of the bus, or added it to the bus.
> Ideally we would have some helper checking for internal
> UVC camera presence and turn this into 2 or 3.
> 
> TL;DR: it a mess.
> 
> Circling back to this patch-set, note how 3 of the 4
> currently in use variants today use in input evdev.
> 
> I think that using an input evdev (shared with the
> snapshot button if present) will give us a nice out for
> the power-management issue with the V4L2_CID_PRIVACY,
> while at the same time giving a nice opportunity to
> standardize on a single userspace API.
> 
> My proposal would be to standardize on SW_CAMERA_LENS_COVER
> I realize that the GPIO does not always indicate a lens
> cover, but the resulting black frames are the same result
> as if there were a lens cover and looking at:
> 
> https://support.hp.com/ie-en/document/ish_3960099-3335046-16
> 
> and then the second picture when expanding "Locate and use
> the webcam privacy switch" that does look like it may be
> an actual cover which reports back its state through a GPIO.
> 
> The reason why I'm not in favor of using
> KEY_CAMERA_ACCESS_ENABLE + KEY_CAMERA_ACCESS_DISABLE is that
> looking at the HUTRR72 it talks about:
> "Enables programmatic access to camera device"
> which suggests that it is a request to the OS / desktop-
> environment to block camera access at the software level,
> rather then reporting back that a hw-level block is in place.
> 
> And since these may be used by any HID device we are not of
> control in how these will be used.
> 
> Ricardo, what do you think of instead of using a v4l-subdev,
> using an input evdev (shared with the existing one) reporting
> SW_CAMERA_LENS_COVER ?  The v4l-subdev approach will need
> userspace changes anyways and if we are going to make userspace
> changes we might as well use the best API available.
> 
> One downside of going the evdev route is that it is a bit
> harder for userspace to map the evdev to a camera:
> 
> 1. For the various WMI interfaces this already is impossible,
> and just to show a notification it is not necessary (using
> an external cam will make things weird though).
> 
> 2. For UVC cameras mapping the evdev to the /dev/video#
> node can still be done by looking if they share a parent
> USB interface. This is e.g. already done in apps like
> xawtv looking at the PCI parent to pair up /dev/video#
> for video capture with the ALSA interface exposed for
> sound by bttv cards.
> 
> 3. We can maybe do something at the media-controller
> level to help userspace linking a camera to its evdev node.
> This would also be helpful for the existing WMI interfaces.
> 
> Regards,
> 
> Hans
> 
> 
> 
> i) With the exception of drivers/media/pci/intel/ivsc/mei_csi.c
> which has a V4L2_CID_PRIVACY control which always reads 0, so
> I guess we can / should probably drop that.
> 
> 
> 
> p.s.
> 
> I do plan to also get back to you on the actually powermanagement
> discussion. But only so many hours in a day, so it will probably
> be a couple of days.
> 
> 


