Return-Path: <linux-kernel+bounces-546908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5BA50050
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520837A49D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA024887A;
	Wed,  5 Mar 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdPJQw3p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FB43166
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180878; cv=none; b=LjrtjwI+hXtnvj49Vyo0wlGdIUzvb9gzkgZJg3w+Jcxx9zrj7R42e/8tDe6eZfYEEcZvqv8dxhh2iDCGyV6FR92VKNq7bNA7ZlFfiEz1TkWlZDYqFyT6n6lZ8JyfLtqNz49Ry8ocNRMGvqs3/MGmhoKQkBUlWcmS+YwWNeXMnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180878; c=relaxed/simple;
	bh=ufiuiueTS8H+yFuJXWNVF9N2q1bYbA3mx7SeKXThoEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+FpYYcRA35bNNlxAOkbbHUucMJePokpm+nb/HZxiy9//iIdpnx92rSxjczERWnTiK8zzaEV03YwWCMWzNOsJXI0L/2heEBLtATAh9CdlwzQBugxIc1kUD+w2KupU3c3/yOQbt5FclLF4qJM8d+QJv/sbyAJSC4TYyS8MLTvQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdPJQw3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741180874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F26zELxB+XCWgdBuoCOeDJROHFnk5TBOYnV+hLKHl14=;
	b=MdPJQw3pyieyXrnVw4rqwe/Rbpo69wCQgJbEjvmWdcRPk4TI2lxZUdSNNW/DiG8j5p4FLl
	qGhYriq1N55cksd4Um4kHjobbimXzkjvaUrvJESwf2WMipVgs5GPgkkvMme3QYmSAIELeL
	q0On0vXGkrgLKxrptgWlXaWn/EPlMwg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-q1KUKzW_OMS_oDgwZ_3NLw-1; Wed, 05 Mar 2025 08:21:08 -0500
X-MC-Unique: q1KUKzW_OMS_oDgwZ_3NLw-1
X-Mimecast-MFC-AGG-ID: q1KUKzW_OMS_oDgwZ_3NLw_1741180867
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abf497da6c4so508735666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180867; x=1741785667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F26zELxB+XCWgdBuoCOeDJROHFnk5TBOYnV+hLKHl14=;
        b=Ty/t74BqnGuVxVZnRl9Byg/V708o5u8XCLIs8BX1MBVV5VcjShztIpSCVaFtl8j2N1
         d0npYvBY/MSeetTctP+mDolohh2zw7rthHTc5wigjfjTAH5Z0YnqrGb08WlqvRVhH3fI
         diytr4zwRwgEYWN5AwXCCHTAcUeMztMUUk+II8c7mMMG4VmRUnr9VmZqjog4s39sHeuF
         W5SIJZQE01YRlmOKHrDYl7mTUNIt6nMNICoPZZREMU2iXOy9CVeU8WQD2gtO3jZuWeRv
         j8YWaKM6fCI6K3Qt8UL6ldeUhx+2cl/F4EkUUr1cLh3IeYcg/XHpmGw02rkAo0LNRkj7
         j8ow==
X-Forwarded-Encrypted: i=1; AJvYcCVlxoYSEIqwGxza7hZwEhvtISnmTLDoOh5hZJckurKfdO0XNsW8x4SWOjCQSJYqt8F3bouifgpJsUquW7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJrbuEnTTxHh3XMj4ZU5om33pwy6BmwcHMqZ0sy+AN432hW/e
	yX9Ey6/5Uzb1zsORqz7RjPwyYoIUCIvZ6xGqc+pJNk/aVzVgPLQ1RZTMKCjNPBJOACyufb9tR04
	ASWyu7K/WWY7SxQB9fH/fvBRy4llcAfZ2seEtNEijS7NJ7rY7PjaZpMgWS4FwIQ==
X-Gm-Gg: ASbGnctuRTDbQsQgzr81A1o0mVh+up8GIMqJ907KOwg+ucAxbb8txaL4bnnZ+WXjXqv
	Vpp9Jhkax8jY1G6O0z5T2HunfXlILQPbh+NV0E1eMFOisRGv8Z6wWiCZK2dsSYHL8QB0eTyCvL0
	XrQ5A/O3fn1NdnNo29GK2/4vxkV17UAjrp21FTX17XtoT3uu3HIkzqb0KiwyzZ4vOUQcdubpvmP
	VzcAfRJY5PbaHt2MlGllpyiSlym6okQqea1wwBhUKofe7rwrGwgLfnVqNLr4aYMxntNaCfq/yyZ
	fLnHXHmgrmip8d+u5zZ5N6LoTAaNF5j3NmY2LxG59/LS0BUgYn0NH59J1T2+raj5UNQxCaY6DZ+
	eLRJVvNm1dcVo7ci/5QkaIyR2SGqTCEU7uHK5z3295E5w7As7tarjzeaV7m4M62aL2Q==
X-Received: by 2002:a17:907:3d86:b0:ac2:8a4:b9db with SMTP id a640c23a62f3a-ac20d8bcab2mr271098066b.16.1741180867086;
        Wed, 05 Mar 2025 05:21:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrZRbLXyymfVe1LrGtYFfNZ9iSG17eRcczqBpXH6Na4jSmSA1qEoWcNrFO6iKdI6ABorfJIw==
X-Received: by 2002:a17:907:3d86:b0:ac2:8a4:b9db with SMTP id a640c23a62f3a-ac20d8bcab2mr271094966b.16.1741180866686;
        Wed, 05 Mar 2025 05:21:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf75c6d4f3sm551922966b.184.2025.03.05.05.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:21:06 -0800 (PST)
Message-ID: <67c1a857-7656-421f-994c-751709b6ae01@redhat.com>
Date: Wed, 5 Mar 2025 14:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Enable full UVC metadata for all devices
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org>
 <c6ab8640-d96c-4a71-929a-a4ad6bb2647d@redhat.com>
 <20250303151346.GC32048@pendragon.ideasonboard.com>
 <1436dc95-68a6-456d-ab5d-117c7791ec48@redhat.com>
 <20250303161059.GA23684@pendragon.ideasonboard.com>
 <CANiDSCux1whD3yF+mPayajU6imE4t8yjtzeAjrpLPhqyLRc4OA@mail.gmail.com>
 <2897ce12-bb32-4445-b7ed-0a835e089f03@redhat.com>
 <20250305131145.GC31618@pendragon.ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250305131145.GC31618@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Mar-25 2:11 PM, Laurent Pinchart wrote:
> On Wed, Mar 05, 2025 at 02:03:58PM +0100, Hans de Goede wrote:
>> On 3-Mar-25 5:22 PM, Ricardo Ribalda wrote:
>>> On Mon, 3 Mar 2025 at 17:11, Laurent Pinchart wrote:
>>>> On Mon, Mar 03, 2025 at 04:43:50PM +0100, Hans de Goede wrote:
>>>>> On 3-Mar-25 16:13, Laurent Pinchart wrote:
>>>>>> On Mon, Mar 03, 2025 at 03:47:51PM +0100, Hans de Goede wrote:
>>>>>>> On 26-Feb-25 14:00, Ricardo Ribalda wrote:
>>>>>>>> The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
>>>>>>>> V4L2_META_FMT_D4XX. The only difference between the two of them is that
>>>>>>>> V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
>>>>>>>> V4L2_META_FMT_D4XX copies the whole metadata section.
>>>>>>>>
>>>>>>>> Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
>>>>>>>> devices, but it is useful for any device where vendors include other
>>>>>>>> metadata, such as the one described by Microsoft:
>>>>>>>> - https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
>>>>>>>>
>>>>>>>> This patch removes the UVC_INFO_META macro and enables
>>>>>>>> V4L2_META_FMT_D4XX for every device. It also updates the documentation
>>>>>>>> to reflect the change.
>>>>>>>>
>>>>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>>>>>
>>>>>>> Thanks, patch looks good to me:
>>>>>>>
>>>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>
>>>>>> I don't quite agree, sorry.
>>>>>>
>>>>>> The reason why the current mechanism has been implemented this way is to
>>>>>> ensure we have documentation for the metadata format of devices that
>>>>>> expose metadata to userspace.
>>>>>>
>>>>>> If you want to expose the MS metadata, you can create a new metadata
>>>>>> format for that, and enable it on devices that implement it.
>>>>>
>>>>> Looking at the long list of quirks this removes just for the D4xx
>>>>> cameras I do not believe that having quirked based relaying of
>>>>> which metadata fmt is used to userspace is something which scales
>>>>> on the long term. Given the large amount of different UVC cameras
>>>>> I really think we should move the USB VID:PID -> metadata format
>>>>> mapping out of the kernel.
>>>>
>>>> If we can find a solution to ensure the metadata format gets documented,
>>>> sure.
>>>
>>> MS default metadata is already documented:
>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
>>>
>>> I would not worry too much about vendors abusing the metadata for
>>> custom magic if that is your concern.
>>> This would not work with Windows default driver, and that is what most
>>> camera modules are tested against.
>>>
>>>> When it comes to the MS metadata format, if I recall correctly, Ricardo
>>>> said there's an XU with a known GUID to detect the metadata format. We
>>>> therefore wouldn't need quirks.
>>>
>>> There is MXSU control 	
>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
>>> But not all the vendors use it.
>>
>> Right so I actually already checked:
>>
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
>>
>> yesterday before my udev hwdb suggestion I was wondering if there was a way
>> to just get if MSmetadata was used from the camera itself. What I found was this:
>>
>> "UVC metadata is opt-in. Every IHV/OEM that needs metadata support must be enabled through a custom INF file."
>>
>> which lead me to the udev + hwdb suggestion.
>>
>> It is good to know that some cameras have a a way to fet this from a known XU GUID,
>> but the official way seems to be to have per camera info in .inf files. So for Linux
>> that would translate to having a list of vid:pid combinations somewhere.
>>
>> The question then becomes where do we put the vid:pid list and IMHO hwdb is much
>> better (easier to maintain / update) then hardcoding this in the kernel.
> 
> Additional questions: where do we store documentation for the metadata
> format, 

hwdb config files typically have a comment block with which key:value pairs
that hwdb file will set. We can add known/supported formats + links to
the documentation per format there.

> how do we convey what format is supported to applications

This would be a udev property on the /dev/video# node.

> , and
> how do we enable metadata capture when a device is listed in the DB ?

The idea would be to at the kernel side just add a single new CUSTOM metadata
fmt and when that is set copy the entire length of the received metadata
to userspace like we are already doing for the D4xx format.

Yes this will also possibly send extra metadata in other formats to
userspace, without us having documented the format but I don't really think
this is a showstopper here. It is not like this metadata is going to hide
some highly secret processing info which we need to know on the Linux side,
since all the processing is already done on the camera and we get a ready
to use image out of the camera.

Regards,

Hans



