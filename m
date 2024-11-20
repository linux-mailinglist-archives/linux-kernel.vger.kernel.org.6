Return-Path: <linux-kernel+bounces-415779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9219D3C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA55286AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2441BCA0F;
	Wed, 20 Nov 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWkpfy3u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B031C9EA7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107677; cv=none; b=NAeN1D+SoZykcujgNkEeZyctlwmBeE0wDowpsxd3nyuYgO9O15gJIhyHrWlv5L9485F+IXT3yWGW/2WBCp69wGsgrI8zzNA270p3+Xcot7grVT7b17NroDiJGHhg40fvh29XsDFSyOKjG4ajXbbcXxpwLmKARjUIiqWTpkpnvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107677; c=relaxed/simple;
	bh=JLz107JtLMSLCJ/tPEMnRAU4tFEJHNZpsA6Z06j/FmY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FBUmx9I6PgpriUxK8vYKJzdLDji6eHVgxVoB+BRX6B/+SgCjwWcghZLE5x5HF33lGiX5dFKZzgVA9ObqSdbsXIpeC5OYVp4lvVzPJ8WiJ2g6COB9K4B0B9RZOSSawnkP617sy1+mXvGwbzc/GyvSyliHYJ2GKArCliji0+FGJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWkpfy3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732107674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iacYTsl4czcRLlbMeQb2P90UWoTtgdTtN/zn9kj9vw=;
	b=dWkpfy3us8rWLa8tWzfKW/ISIwewxBCRkp6dAFNCcNR2KDz+un3D6ylWvi4Zd/TVDsC2rd
	IA7QEt6NtV3L9jZVmUFC3mgkXvZPZ9oxxJDeciKc1efuP3K8ojZHN4fraWRGr79llSU6gB
	Eo371lz227RaTUGMfdHcFJGYaD3d6is=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-EMWvLU7KMFG6O6TLOyPljw-1; Wed, 20 Nov 2024 08:01:11 -0500
X-MC-Unique: EMWvLU7KMFG6O6TLOyPljw-1
X-Mimecast-MFC-AGG-ID: EMWvLU7KMFG6O6TLOyPljw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1b8d4563so156039966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107670; x=1732712470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iacYTsl4czcRLlbMeQb2P90UWoTtgdTtN/zn9kj9vw=;
        b=D3Y88hLLLTzmHIEYUXdGoo+52NXC+THSNfItaE1YaHo8MrId/BzZZNB1gcEtW27EnM
         WTrPsRZ5HRDPrLTb+fmaZDAzmnxiqhswREV700kA7itk319kIHfUf5t2FfeK2UpSeBM2
         03LJ5GGZ4d3GvZqPkiPHY3acvaM2cQS9ZQ3RU8eUCDBc5rWBTE4/5sw6wCcFi8XA8DCM
         Nn587x5mAQQcTpfmFpHRAApYIk7ytpHLBcnLls5nSn9BqE+tAPnmtVtkFxCYBRb/Ozbu
         0nMkC0SFlvwgo1P0lZoP+oE94VRnXVqOvYeNfEDLHcmnw93MJkuGQEYrayxbmg5h6E/s
         9f/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZA1ovUUtQFONwITxXIpoBcsIXhOYLZOztGdZojm2DOC2AYzkwUoWOIykyDG+HoX1WCH+CK85YfNszjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1e3dQE4pBW1bhKsmi04QT2VOOVvewPGnFIRkQ/arQ6TVk+hX
	Gbt1eY+4OfqUC9mr3GfPSj4EY3p+M5ZyWlC9H7peGziUeg+X5sSd5tGg/P81CAUaiBXK0yEyOig
	vecuY3WUUAQLtS4w2vOVyThr1IoXpzLqK0sDaD2n4xVNxyNd3YXwVETsAjPAajw==
X-Received: by 2002:a05:6402:13cd:b0:5cf:14fa:d24d with SMTP id 4fb4d7f45d1cf-5cff4ca4e23mr2804933a12.22.1732107669493;
        Wed, 20 Nov 2024 05:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV3w73kYvz9BRxhNPe9y9IT6e6ze0dgixliTSWRBWDQRRoPHAGJShURRiABZCNH+ZbqL56PA==
X-Received: by 2002:a05:6402:13cd:b0:5cf:14fa:d24d with SMTP id 4fb4d7f45d1cf-5cff4ca4e23mr2804779a12.22.1732107668567;
        Wed, 20 Nov 2024 05:01:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff5fc4c81sm705195a12.74.2024.11.20.05.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:01:07 -0800 (PST)
Message-ID: <ac84df80-5f11-4b05-bf13-8e2388ebfb41@redhat.com>
Date: Wed, 20 Nov 2024 14:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Support partial control reads
From: Hans de Goede <hdegoede@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 stable@vger.kernel.org
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-1-04d9d51aee56@chromium.org>
 <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
 <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
 <845fd4ee-dcf7-4657-beb6-6936d5ef04cc@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <845fd4ee-dcf7-4657-beb6-6936d5ef04cc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20-Nov-24 11:50 AM, Hans de Goede wrote:
> Hi Ricardo,
> 
> On 18-Nov-24 5:57 PM, Ricardo Ribalda wrote:
>> On Mon, 18 Nov 2024 at 17:41, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi Ricardo,
>>>
>>> Thank you for your patch.
>>>
>>> On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
>>>> Some cameras, like the ELMO MX-P3, do not return all the bytes
>>>> requested from a control if it can fit in less bytes.
>>>> Eg: Returning 0xab instead of 0x00ab.
>>>> usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
>>>>
>>>> Extend the returned value from the camera and return it.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>> ---
>>>>  drivers/media/usb/uvc/uvc_video.c | 19 +++++++++++++++++--
>>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
>>>> index cd9c29532fb0..f125b3ba50f2 100644
>>>> --- a/drivers/media/usb/uvc/uvc_video.c
>>>> +++ b/drivers/media/usb/uvc/uvc_video.c
>>>> @@ -76,14 +76,29 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>>>>
>>>>       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
>>>>                               UVC_CTRL_CONTROL_TIMEOUT);
>>>> -     if (likely(ret == size))
>>>> +     if (ret > 0) {
>>>> +             if (size == ret)
>>>> +                     return 0;
>>>> +
>>>> +             /*
>>>> +              * In UVC the data is represented in little-endian by default.
>>>> +              * Some devices return shorter control packages that expected
>>>> +              * for GET_DEF/MAX/MIN if the return value can fit in less
>>>> +              * bytes.
>>>
>>> What about GET_CUR/GET_RES ? are those not affected?
>>>
>>> And if it is not affected should we limit this special handling to
>>> GET_DEF/MAX/MIN ?
>>
>> I have only seen it with GET_DEF, but I would not be surprised if it
>> happens for all of them.
>>
>> before:
>> a763b9fb58be ("media: uvcvideo: Do not return positive errors in
>> uvc_query_ctrl()")
>> We were applying the quirk to all the call types, so I'd rather keep
>> the old behaviour.
>>
>> The extra logging will help us find bugs (if any).
>>
>> Let me fix the doc.
>>
>>>
>>>
>>>> +              * Zero all the bytes that the device have not written.
>>>> +              */
>>>> +             memset(data + ret, 0, size - ret);
>>>
>>> So your new work around automatically applies to all UVC devices which
>>> gives us a short return. I think that is both good and bad at the same
>>> time. Good because it avoids the need to add quirks. Bad because what
>>> if we get a short return for another reason.
>>>
>>> You do warn on the short return. So if we get bugs due to hitting the short
>>> return for another reason the warning will be i the logs.
>>>
>>> So all in all think the good outways the bad.
>>>
>>> So yes this seems like a good solution.
>>>
>>>> +             dev_warn(&dev->udev->dev,
>>>> +                      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
>>>> +                      uvc_query_name(query), cs, unit, ret, size);
>>>
>>> I do wonder if we need to use dev_warn_ratelimited()
>>> or dev_warn_once() here though.
>>>
>>> If this only impacts GET_DEF/MAX/MIN we will only hit this
>>> once per ctrl, after which the cache will be populated.
>>>
>>> But if GET_CUR is also affected then userspace can trigger
>>> this warning. So in that case I think we really should use
>>> dev_warn_once() or have a flag per ctrl to track this
>>> and only warn once per ctrl if we want to know which
>>> ctrls exactly are buggy.
>>
>> Let me use dev_warn_once()
> 
> Great, thank you.
> 
> Re-reading this I think what would be best here is to combine
> dev_warn_once() with a dev_dbg logging the same thing.
> 
> This way if we want the more fine grained messages for all
> controls / all of GET_* and not just the first call we can
> still get them by enabling the debug messages with dyndbg.
> 
> This combination is used for similar reasons in other places
> of the kernel.
> 
> Not sure what Laurent thinks of this though, Laurent ?
> 
> I wonder if we need some sort of helper for this:
> 
> dev_warn_once_and_debug(...(

Nevermind I see that you've already send a v3.

Lets stick with just the dev_warn_once() for now
and then we can revisit this if necessary.

Regards,

Hans






>>> What we really do not want is userspace repeatedly calling
>>> VIDIOC_G_CTRL / VIDIOC_G_EXT_CTRLS resulting in a message
>>> in dmesg every call.
>>>
>>>>               return 0;
>>>> +     }
>>>>
>>>>       if (ret != -EPIPE) {
>>>>               dev_err(&dev->udev->dev,
>>>>                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>>>>                       uvc_query_name(query), cs, unit, ret, size);
>>>> -             return ret < 0 ? ret : -EPIPE;
>>>> +             return ret ? ret : -EPIPE;
>>>
>>> It took me a minute to wrap my brain around this and even
>>> though I now understand this change I do not like it.
>>>
>>> There is no need to optimize an error-handling path like this
>>> and IMHO the original code is much easier to read:
>>>
>>>                 return ret < 0 ? ret : -ESOMETHING;
>>>
>>> is a well known pattern to check results from functions which
>>> return a negative errno, or the amount of bytes read, combined
>>> with an earlier success check for ret == amount-expected .
>>>
>>> By changing this to:
>>>
>>>                 return ret ? ret : -EPIPE;
>>>
>>> You are breaking the pattern recognition people familiar with
>>> this kinda code have and IMHO this is not necessary.
>>>
>>> Also not changing this reduces the patch-size / avoids code-churn
>>> which also is a good thing.
>>>
>>> Please drop this part of the patch.
>> ack
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>
>>
> 


