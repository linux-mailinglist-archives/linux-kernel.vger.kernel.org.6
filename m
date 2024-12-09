Return-Path: <linux-kernel+bounces-437914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCC9E9A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B90A1607FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECC1C5CA0;
	Mon,  9 Dec 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXuHoRlo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D41B0428
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757898; cv=none; b=KGx7FTuXifHS8r227e5fmGsxtI+pjs8/+WTHjGBz801HH+NDeGSe4s5LufASlSNhfCPfv3VqtsO5ZFCF4HzZuWXIYAgyNDRLZRyg6gfQdxLjv1sD2cU4A/bkGivbeHw+uOEE6+//Y8Bqp1SKIs/QMpw9Pya3u91R7FM9NigqKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757898; c=relaxed/simple;
	bh=Z8ezlDlzfS/VvCx4K0dhY367m+LJZb4FH0Hw1ld9gyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ss2TmFtSZAUKVIJV7vvpw77XXYJNwBS94baXTNZT/o9Ykx68v+lBe2xPEI8hCQLGAeaH3GNkSkezCfHVFWt1cQPfdrXLdAtdP0J8p8GB86hsZnL3PuAZ0N1vla8xNQ0/3qDGbD51w/oUHENAzKH9IqepTvpyVkrfWE8qkK1IiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXuHoRlo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733757895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lml9igTZ0kguO2PlxaKLV0rcbD78PVoSn43lSLvR664=;
	b=EXuHoRloBsRJbLa4d/NZKk2Qa7higQj+KDLjU6YvHBeiUEVf3b1MutE5F0kzWdHJl0JSlr
	mP/oSgW0A/CjQmNV6wn4ws/Trg0FVS+kszMZb5x0Su2WT2CcK9ExaQKzBDWfdAfismTw9C
	9r+OhWkEXTgOkQ/lyew+cYACIzFK76A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-sv4-TOnZNx2BrWP0sBKabQ-1; Mon, 09 Dec 2024 10:24:54 -0500
X-MC-Unique: sv4-TOnZNx2BrWP0sBKabQ-1
X-Mimecast-MFC-AGG-ID: sv4-TOnZNx2BrWP0sBKabQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa636e5221eso251103366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757893; x=1734362693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lml9igTZ0kguO2PlxaKLV0rcbD78PVoSn43lSLvR664=;
        b=SwSFSgvylQf9euRNHvMW8E1SHW82Oz1i1N0HmzaD8ODnrAAXHwpY60lx74ibSC4lGb
         Od3FGVcUT7DSS+Uwm/fh45/3/AxA3ws4LJ6QNob5I1NXyD1ngGHq+Dqesz/hmri+DNbM
         Yv6Gr0C2QdE+DdZAQmTk+IxNB7CxMrBKHUj8mHEsChwFP/UYZ3FGzQwf1wMS26WI+5tj
         +MdCz//Gja1GdoEIsiBUx/sct7GumTPZQG3CqoiQK+d6gDHRE5jcSi4SMSLKhW+7cJ0m
         L0+/gjpZLqJfu/DyWUre4RT5C4jaKt0tVZqI4fcu+ruYtOZRTtsefMKJonae62mBrbj3
         bXYw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Q4/zqySJg11z2e7gSP1ZZRssLnctvFC6jCGTTiPr0N9quPjecLH+9Nof4EyuTXsgZ6I+s8KyHJSCoUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwbbNxJvM7ZDEnGBdeBgNIdsimVNI8BtPK/aawlH2n9f9fxVS
	+8qgM3JFnCpaUPcl1RAqXnGZ17CxASMFp30cOUcUWmLcuGnYyOB1ztbO/mQh0JJletWwY04qgFp
	vrKWV0WQo3VG8DVEDYyhmS4sJ00KlX7HP9CILlo8JBW5ocW9MvP/vqjRYSZ6TWw==
X-Gm-Gg: ASbGnct0yRZRftyY+fvV7va49weSYu5zwcKRC+pm4vuZshAdq2Khnw69e+hnCF8MwPP
	e3o+3gLDLuQBlT3eGcUixek4hQ5cN4yhvC48kUrGEFSjl38IMQlc374mzdYO2CiE9wkSYYKd8Uo
	1HE61sQpNTl/L0CGKUr1b3vtTl29VkaZEQavuzLUGYhHUu/MSEw8uQHz39Dy48FvEF9xbp6ybxG
	2KNzzPQXs+gckC6vUu+sMacyKvmlRRf3Q25wCcoTm66pFdaKX4yUQ==
X-Received: by 2002:a17:906:23e9:b0:aa6:78f3:47e5 with SMTP id a640c23a62f3a-aa69cd37769mr91809466b.6.1733757891790;
        Mon, 09 Dec 2024 07:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo0EaUyaeSmt3JlA1qxT41AeaeYLgK7CTAdrxY9r0tJoKdnmwa1wLN6L54AfGtecQ8wYrqsA==
X-Received: by 2002:a17:906:23e9:b0:aa6:78f3:47e5 with SMTP id a640c23a62f3a-aa69cd37769mr91806566b.6.1733757891339;
        Mon, 09 Dec 2024 07:24:51 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6696acc74sm349791866b.134.2024.12.09.07.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:24:50 -0800 (PST)
Message-ID: <dfbbb4a1-2575-42a4-a1f9-c279fc17d9c4@redhat.com>
Date: Mon, 9 Dec 2024 16:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] media: uvcvideo: Flush the control cache when we
 get an event
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
 <20241203-uvc-fix-async-v6-5-26c867231118@chromium.org>
 <02a89566-a6f7-4feb-84c3-079795c98a46@redhat.com>
 <CANiDSCuPM1qeerMUBFx+RfqBD35CcfhQeO5hYVHh-ZeQ-4t9Sw@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCuPM1qeerMUBFx+RfqBD35CcfhQeO5hYVHh-ZeQ-4t9Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 12:31 PM, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Mon, 9 Dec 2024 at 12:03, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ricardo,
>>
>> On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
>>> Asynchronous controls trigger an event when they have completed their
>>> operation.
>>>
>>> This can make that the control cached value does not match the value in
>>> the device.
>>>
>>> Let's flush the cache to be on the safe side.
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>
>> Thank you for your patch.
>>
>> It seems that you have missed Laurent's reply asking to improve the commit message:
>>
>> "Conceptually this change looks fine, but the commit message needs to
>> explain why this is safe to do without protecting ctrl->loaded with a
>> lock."
>>
>> https://lore.kernel.org/linux-media/20241203203748.GD5196@pendragon.ideasonboard.com/
>>
>> Or maybe the posting of this v6 and that reply have crossed each other.
> 
> In this v6 I moved loaded=0 from uvc_ctrl_status_event_async() to
> uvc_ctrl_status_event()

Ah I missed that you moved it, my bad.

> Now setting loaded=0 is just after mutex_lock(&chain->ctrl_mutex);
> 
> Do we need a new version?

Since the setting is now clearly done under the lock the new version seems
good to me as is.

So I have now merged this into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

Regards,

Hans

> 
>>
>> Either way please post a new version addressing this comment.
>>
>> Thanks & Regards,
>>
>> Hans
>>
>>
>>
>>> ---
>>>  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
>>> index 3dc9b7a49f64..db29e0e8bfd4 100644
>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
>>> @@ -1622,6 +1622,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>>>
>>>       mutex_lock(&chain->ctrl_mutex);
>>>
>>> +     /* Flush the control cache, the data might have changed. */
>>> +     ctrl->loaded = 0;
>>> +
>>>       handle = ctrl->handle;
>>>       if (handle)
>>>               uvc_ctrl_set_handle(handle, ctrl, NULL);
>>>
>>
> 
> 


