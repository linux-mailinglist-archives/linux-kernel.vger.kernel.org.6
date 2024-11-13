Return-Path: <linux-kernel+bounces-407874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80D9C764D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0382851D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C2201039;
	Wed, 13 Nov 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUCFYZ5D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB72200CBE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511197; cv=none; b=FEJGl5uiYN/7c66yAvXm+vPdmxX4mJbPPiuzFeKK+FW8/SO1frOnFbVGOk/hSzj0WwACBzQmVEsRfIspn/xES5NVpi+Q/yxbMkM0qv9uy2pdRQuqby83JkMZAxolMm0u7HuwAdu55nQOziTDtvtf0Fog4IHUXL2umw7L7Im240k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511197; c=relaxed/simple;
	bh=nOwVnwYrpicjCfmdQGy2Cdsyn9B6v7ynS9HUG9qeUQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAWGXEEAP8Y36SJV8SdSgixCzJRz76aKCqzBu3W8d0DfV/COyL43ZgRuLgtC5Y5jzVyQaHe77a3gLXw+A2tj5BHExfZhj2trAmd0cODd1d6Ev+psrx8Qi+cc8A1Lg0+YlLS/x0UzLnARjFrwhfafZVvpMg4+lo1Mt1P72ZeVPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUCFYZ5D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731511194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCLG25hVok1lovn87TXiObw7KoI+wXBF1rK5GdDYyhY=;
	b=OUCFYZ5DlA0DngKach1WUhUT9rcNnO/qLmXosoa6AKRKR/AIqJ5RisVc1eD9rbwqePsbfC
	VomNYBye0qpq4LjzDzFO2eG5mR8Nczwo8ENy0ofHbCEogpyt43Uadtk/k6lmmnM+W8/Nn+
	kXaf1aOgtBweh468dgD8eHUZaHhdKgo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-8JiMvj51O5-fsZVSo1aTKQ-1; Wed, 13 Nov 2024 10:19:52 -0500
X-MC-Unique: 8JiMvj51O5-fsZVSo1aTKQ-1
X-Mimecast-MFC-AGG-ID: 8JiMvj51O5-fsZVSo1aTKQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a23eada74so567851466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511191; x=1732115991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCLG25hVok1lovn87TXiObw7KoI+wXBF1rK5GdDYyhY=;
        b=D0fG+OJ6yo0s6VU4BKkhRK/1b/bvG4P+7tDukCKiYKZt33HwQHl+PQbmgXw01v3PCC
         uRyJ7MmvgOqRQ7phi6fe77ELuhfd+cmnkNkUHHtcj+6mfUowmK5xX9/W8ecruGvIN+vZ
         HxWDuIAWhe1A+7D2Hh3b39GQyTt8XoRAZyvOTy6BeCZf6p1TmJ6yTYxSdDkGCa+CpoxE
         PvfyG7sSrcOkDImUAcMhsBg1FJucYjzVwPxwbkbFx0etJXDAFpl9GnoFU19pPDSR1SWJ
         pyxdzuFw1f1t6KW1SN2mxKLWyTrCE5+UPMLg9vMql8EB2UqnGyZimtgOJp1c2dnjXe/K
         szVg==
X-Forwarded-Encrypted: i=1; AJvYcCVHkYe+jAsEddvL2HpDi1aJIwZhm/ZuXRbdgNmoEcjWggXPgBUeEf/1Oo9cQfxqw2kI76r0QvptdNtVSD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vOZgN6/MOGcgmcSg/ChsZvHqrgwAWXNInx5DDUa4Zv8C2i4N
	HaxHw43XvPGgEChSDZJCdLOZNvrh12hmeb384uqxmMMnjOJx6W1uYON/rZPXW5DGDqBGc7NqsOV
	EHDwiRq7p/wj3vat8MNQTTedZOoLoEx3tjR2uPf2EZGaFe89LQhASJSnlypTwQA==
X-Received: by 2002:a17:907:3f05:b0:a9a:3ca0:d55a with SMTP id a640c23a62f3a-aa1f813b95emr302625566b.57.1731511190894;
        Wed, 13 Nov 2024 07:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCA8xGVsXqnwS+V6c7SWD1KQMyojgkD0HJzAgpjbB89nJ3EyiQD4J33kp9UV7YKU5DWZlJRg==
X-Received: by 2002:a17:907:3f05:b0:a9a:3ca0:d55a with SMTP id a640c23a62f3a-aa1f813b95emr302623466b.57.1731511190506;
        Wed, 13 Nov 2024 07:19:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deebabsm869231066b.153.2024.11.13.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:19:49 -0800 (PST)
Message-ID: <8c9cedd4-953b-4b5e-8c08-7aab3259d4f4@redhat.com>
Date: Wed, 13 Nov 2024 16:19:48 +0100
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
 Hans Verkuil <hverkuil@xs4all.nl>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
 <a644fed4-aff5-4514-8e35-d6cab642d3dd@redhat.com>
 <CANiDSCtecYwfzSGDOHAtkdSrDb5WjtxAQMikH=tLPqngGXbBkw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCtecYwfzSGDOHAtkdSrDb5WjtxAQMikH=tLPqngGXbBkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 12-Nov-24 6:31 PM, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Mon, 11 Nov 2024 at 13:59, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ricardo, Et al.,
>>
>> On 8-Nov-24 9:25 PM, Ricardo Ribalda wrote:
>>> Some notebooks have a button to disable the camera (not to be mistaken
>>> with the mechanical cover). This is a standard GPIO linked to the
>>> camera via the ACPI table.
>>>
>>> 4 years ago we added support for this button in UVC via the Privacy control.
>>> This has two issues:
>>> - If the camera has its own privacy control, it will be masked
>>> - We need to power-up the camera to read the privacy control gpio.
>>
>> Thinking more about this I think we need to start with looking at the userspace
>> API for privacy controls, define how we want that to look and then go from
>> there.
>>
>> The reason I'm writing this is because due to my work in drivers/platform/x86
>> (pdx86) on EC / ACPI / WMI drivers for non chromebooks I am aware of at least
>> 4 different methods camera on/off (aka privacy) toggles are being reported
>> to userspace at the moment. Adding a v4l2-ctrl on a subdev instead of directly
>> on /dev/video# would be adding a 5th method which seems highly undesirable.
>>
>> Instead I would like to first focus on fixing these userspace API
>> inconsistencies agreeing on a single API we want to use everywhere
>> going forward. We don't need to fix all drivers at once, but IMHO we
>> should agree on what the API should look like and document that and
>> any future drivers implementing camera privacy control related code
>> then must use the new API.
>>
>> Lets start with the 3 APIs I'm currently aware of:
>>
>> 1. uvcvideo driver exporting V4L2_CID_PRIVACY on /dev/video#
>> uvcvideo seems to be the only user of this CID (i)
>>
>> 2. pdx86 drivers exporting an input evdev with EV_SW,
>> SW_CAMERA_LENS_COVER. This is somewhat of a special case
>> for some Dell laptops with an electro-mechanical shutter
>> operated by the EC. But this is not also used by
>> hp-wmi.c where it does not necessarily indicate the
>> status of a mechanical cover, but also possibly simply
>> disconnecting the camera from the USB bus.
>>
>> 3. pdx86 drivers exporting an input evdev with EV_KEY,
>> KEY_CAMERA_ACCESS_ENABLE, KEY_CAMERA_ACCESS_DISABLE
>> These KEY codes are based on offical the HUTRR72 HID/HUT
>> extension and as such may also be send by USB/I2C/BT HID
>> devices.
>>
>> The only user outside of hid-input.c is the recently added
>> drivers/platform/x86/lenovo-wmi-camera.c driver and I'm
>> wondering if that should not use SW_CAMERA_LENS_COVER
>> instead. I'll ask the driver author about how this
>>
>> 4. pdx86 drivers exporting an input evdev with EV_KEY,
>> KEY_CAMERA. Note this 4th method lacks information on if
>> the camera was enabled or disabled. In many cases this
>> is send to indicate that the EC has either dropped
>> a UVC camera of the bus, or added it to the bus.
>> Ideally we would have some helper checking for internal
>> UVC camera presence and turn this into 2 or 3.
>>
>> TL;DR: it a mess.
>>
>> Circling back to this patch-set, note how 3 of the 4
>> currently in use variants today use in input evdev.
>>
>> I think that using an input evdev (shared with the
>> snapshot button if present) will give us a nice out for
>> the power-management issue with the V4L2_CID_PRIVACY,
>> while at the same time giving a nice opportunity to
>> standardize on a single userspace API.
>>
>> My proposal would be to standardize on SW_CAMERA_LENS_COVER
>> I realize that the GPIO does not always indicate a lens
>> cover, but the resulting black frames are the same result
>> as if there were a lens cover and looking at:
>>
>> https://support.hp.com/ie-en/document/ish_3960099-3335046-16
>>
>> and then the second picture when expanding "Locate and use
>> the webcam privacy switch" that does look like it may be
>> an actual cover which reports back its state through a GPIO.
>>
>> The reason why I'm not in favor of using
>> KEY_CAMERA_ACCESS_ENABLE + KEY_CAMERA_ACCESS_DISABLE is that
>> looking at the HUTRR72 it talks about:
>> "Enables programmatic access to camera device"
>> which suggests that it is a request to the OS / desktop-
>> environment to block camera access at the software level,
>> rather then reporting back that a hw-level block is in place.
>>
>> And since these may be used by any HID device we are not of
>> control in how these will be used.
>>
>> Ricardo, what do you think of instead of using a v4l-subdev,
>> using an input evdev (shared with the existing one) reporting
>> SW_CAMERA_LENS_COVER ?  The v4l-subdev approach will need
>> userspace changes anyways and if we are going to make userspace
>> changes we might as well use the best API available.
> 
> I just sent a patchset using SW_CAMERA_LENS_COVER

I'm glad that you like my proposal and thank you for immediately
implementing it and sending out a v3.

I was expecting us to first have a bit more discussion about
what the userspace API should look like and what we should do
wrt keeping / deprecating V4L2_CID_PRIVACY.

But I'm glad that you like the evdev SW_CAMERA_LENS_COVER idea,
at least I assume you like it since you went for it for v3 :)

I'll reply to your v3 cover-letter to discuss what we should do
wrt keeping / deprecating V4L2_CID_PRIVACY.

IMHO it would be good to hold of on sending out a v4 until we
have hashed out how we want this all to look userspace API wise,
otherwise you'll just spend a lot of time doing revisions
pursuing a moving target.

> I guess the internal uvc privacy (UVC_CT_PRIVACY_CONTROL) shall NOT be
> converted to evdev:
> - If we do so, we cannot differentiate external gpio and internal, for
> devices that have both
> - There is no warranty that we will get a uvc_event when the control
> changes, so we would have to constantly poll the device

These are good questions, lets also discuss this in a thread
with the v3 cover-letter as start to keep all discussion in one place.

Regards,

Hans





