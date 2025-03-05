Return-Path: <linux-kernel+bounces-546857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ADCA4FFBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869F33B1347
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A911248877;
	Wed,  5 Mar 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWkZAZ8Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEB248860
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179847; cv=none; b=m4hSmvjjmCXmOHri7oJyY3QcH2o9jmC8Ty2tPREtnUJFww5571vEUFdirVMy97iQRTYvBM1U2zbfiZ86lqpJYunDgmtC6oKtNplrALohYJEmtp0fh79dcf2ggzPHanegi/TG060qPihp14xl+z/MGncuNlnFyGNiZ7vxhiq80Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179847; c=relaxed/simple;
	bh=d2G3CW84w/M9hF4/KFmE43z5KE1aWPCuGSkwntVryh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciOQNJqjYDuJuaNCWPiINNfnKh9B9RJjpJ/cqCerUi3Mja7Vp3pIxLBhRnd+8VJUSAjcXur/5pUiH+/4sSvjo7A4fWplqZ8TWIT/Z4cgMKXx8amfBkrnQPh5m8rHSr4ljlmiNg2Nn1q89Qzse0AEWPFrZd8m/rkkcSkG4WXcErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWkZAZ8Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741179844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vebGEkglLbQGNvLgWBY01sr8S/XdHoDaZpIyllA6Xw=;
	b=DWkZAZ8Q7UKbjE5MjeYsum3n8BasUNE8l3xptIbAzx0R2rNOkzoVhA7InP+qZLNVae/RJI
	i4UlKaykfv3h0XKXZT4eunUyiKfVHr3wg4VSp4aJzcy0+DiS91rPggm01YXzTdqJchu4Yp
	GrR/ZoFbcpCqDGEgT+cgn9gwI/eBkMU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-nMrrJipLOP2lh3M7pgBGpA-1; Wed, 05 Mar 2025 08:04:03 -0500
X-MC-Unique: nMrrJipLOP2lh3M7pgBGpA-1
X-Mimecast-MFC-AGG-ID: nMrrJipLOP2lh3M7pgBGpA_1741179842
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abf5fc8f157so155273766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741179841; x=1741784641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vebGEkglLbQGNvLgWBY01sr8S/XdHoDaZpIyllA6Xw=;
        b=Huck6dQTI560ncircF2s8bpjm8xs8YY6cUnkdM+NTy0wrTIb6GQZBynGArroHwrGIY
         wJv+DbwPcuOLR1VpmyY7sd+yMTxDR+SrGegPwaAxIFpTvjdzrnkkxkNw2lBQvUd6t+mo
         /6WB/3sAmJd/ipIPgo/GtmCwgd2IZTcBAuAqARv2dWFnVAk9Exv8GOzfLEGpPyHGxgWS
         gmTlUv+LmApfCBUN5pDhMbjjCVwwhVkJ7bKV9ClTREHkoRFEzuGdeA42aC+V2VqoY9+l
         UkeM5mL/LSgEpWNY4fPbFe25K848tU2ltUJgJ+D6U4kN6B5X10aW/CXfdyE4jleJm/1m
         +ArA==
X-Forwarded-Encrypted: i=1; AJvYcCV4kDbEBg8x7a0MpauoUMc6sP4GObJEGsQ/Ws/l3LmCNOm9AG4JlIRPEjeIvuIDd+7TxqvLk/M/qD6MJSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGV6r4Rdbl/JZAzBgTg3XCdHbGn2saFNCunRNbX1lLB5+VN5P
	gJALlWhRdhbpCsd0qI97Z0kP/+lukx7At1i8PafMq5EgwSaQpHbyKRP2GBAxsCHZZ4a9QzT1MRK
	B2YNKloJqr03f0BIGvfDhAhGXrB3OPwVbZhjl1os/MHnqTyqzsjw12WVL7GEGPMWezh/GkA==
X-Gm-Gg: ASbGncvtaZvEIufrrILc90EarqT4CBttSFQ9EFm2nbFREMalGDg8CHhZvUovP8Uo8ve
	sfmW8CkJwhuUcIPu6Fc5690lhKdOYFl+CPFm8gNlO5ZHC8YsbK13+ivORKQPMbbRJgCYeWbuqAP
	UD0oVGNiLV1pA2Xvywt6iYyw7XFE9OW+2MMcdpUUNcum4Y6zd/XMOk6hznfXyUmCe0PdFiyIn4J
	D5Ae82G+hhYUCHKh0XeKXFCrQ6V7hCJQAEhuhaq9E3+LYRYgu6H2OmgeYO3sVhKdZys95KU22oT
	DXv/TBdmCNctVI3u8OTosH/VH6noq2m67AxNBPxxUe+1pdFne7RyP7go4lWhg/Pobl3pVWbzS8C
	eVZKg/MdJFOB5XkrSbWmeVmNj5hzhMkBGQ2Gi7QOxMHHl8NPNshrD/d6cttYifqoE0g==
X-Received: by 2002:a17:906:f587:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac20da4dd5cmr312299266b.10.1741179840715;
        Wed, 05 Mar 2025 05:04:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFShHr2LzuqsAOqeJKefXa4r4HekaqcNv8nbDoeC6x2QQgLvVFTiX5O/hrBMPa48LhX9b89vg==
X-Received: by 2002:a17:906:f587:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac20da4dd5cmr312284866b.10.1741179839394;
        Wed, 05 Mar 2025 05:03:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7b3882dfsm498864766b.143.2025.03.05.05.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:03:58 -0800 (PST)
Message-ID: <2897ce12-bb32-4445-b7ed-0a835e089f03@redhat.com>
Date: Wed, 5 Mar 2025 14:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Enable full UVC metadata for all devices
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org>
 <c6ab8640-d96c-4a71-929a-a4ad6bb2647d@redhat.com>
 <20250303151346.GC32048@pendragon.ideasonboard.com>
 <1436dc95-68a6-456d-ab5d-117c7791ec48@redhat.com>
 <20250303161059.GA23684@pendragon.ideasonboard.com>
 <CANiDSCux1whD3yF+mPayajU6imE4t8yjtzeAjrpLPhqyLRc4OA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCux1whD3yF+mPayajU6imE4t8yjtzeAjrpLPhqyLRc4OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Mar-25 5:22 PM, Ricardo Ribalda wrote:
> On Mon, 3 Mar 2025 at 17:11, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> On Mon, Mar 03, 2025 at 04:43:50PM +0100, Hans de Goede wrote:
>>> On 3-Mar-25 16:13, Laurent Pinchart wrote:
>>>> On Mon, Mar 03, 2025 at 03:47:51PM +0100, Hans de Goede wrote:
>>>>> On 26-Feb-25 14:00, Ricardo Ribalda wrote:
>>>>>> The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
>>>>>> V4L2_META_FMT_D4XX. The only difference between the two of them is that
>>>>>> V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
>>>>>> V4L2_META_FMT_D4XX copies the whole metadata section.
>>>>>>
>>>>>> Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
>>>>>> devices, but it is useful for any device where vendors include other
>>>>>> metadata, such as the one described by Microsoft:
>>>>>> - https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
>>>>>>
>>>>>> This patch removes the UVC_INFO_META macro and enables
>>>>>> V4L2_META_FMT_D4XX for every device. It also updates the documentation
>>>>>> to reflect the change.
>>>>>>
>>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>>>
>>>>> Thanks, patch looks good to me:
>>>>>
>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> I don't quite agree, sorry.
>>>>
>>>> The reason why the current mechanism has been implemented this way is to
>>>> ensure we have documentation for the metadata format of devices that
>>>> expose metadata to userspace.
>>>>
>>>> If you want to expose the MS metadata, you can create a new metadata
>>>> format for that, and enable it on devices that implement it.
>>>
>>> Looking at the long list of quirks this removes just for the D4xx
>>> cameras I do not believe that having quirked based relaying of
>>> which metadata fmt is used to userspace is something which scales
>>> on the long term. Given the large amount of different UVC cameras
>>> I really think we should move the USB VID:PID -> metadata format
>>> mapping out of the kernel.
>>
>> If we can find a solution to ensure the metadata format gets documented,
>> sure.
> 
> MS default metadata is already documented:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
> 
> I would not worry too much about vendors abusing the metadata for
> custom magic if that is your concern.
> This would not work with Windows default driver, and that is what most
> camera modules are tested against.
> 
> 
>>
>> When it comes to the MS metadata format, if I recall correctly, Ricardo
>> said there's an XU with a known GUID to detect the metadata format. We
>> therefore wouldn't need quirks.
> 
> There is MXSU control 	
> https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
> But not all the vendors use it.

Right so I actually already checked:

https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5

yesterday before my udev hwdb suggestion I was wondering if there was a way
to just get if MSmetadata was used from the camera itself. What I found was this:

"UVC metadata is opt-in. Every IHV/OEM that needs metadata support must be enabled through a custom INF file."

which lead me to the udev + hwdb suggestion.

It is good to know that some cameras have a a way to fet this from a known XU GUID,
but the official way seems to be to have per camera info in .inf files. So for Linux
that would translate to having a list of vid:pid combinations somewhere.

The question then becomes where do we put the vid:pid list and IMHO hwdb is much
better (easier to maintain / update) then hardcoding this in the kernel.

Regards,

Hans



