Return-Path: <linux-kernel+bounces-413191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F29D14EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9AEB28D68
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC351B0F2C;
	Mon, 18 Nov 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2NSd7GG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1019F411
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945567; cv=none; b=mcFTa9D02O1mf9DE35THEjIr3Yig9lv4YXQMQra0sqcgpU4jqx64V5jBSPWEkMkWpldf55Gy8L6QVQjG+HktY/NHnMBCXB2G6qa5QFRkwxbzlld64ZbapeicwqfD+u/BAkjpgWXJJwb6vVM1kjhl715w3G2B0+yVvc8b79L/gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945567; c=relaxed/simple;
	bh=6kQID9o1vESz9vvdHUzfktt+J8QrvHzIgdusVRvav48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tewyENU4+PzJW0PxcNT83HFEA6XCQMH1yp31VO704qqjkutNabkVqfbzs9Q2p+IbADk3Zf+hftoiARY2duMtDe69wL2Uj6u67X9VpSi9QlxN1tf8c8DDiBeW6IgT74a0oVtHTTCYRSatjoYgODvcd/cri0TCaeaRhv+b5DA/mMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2NSd7GG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731945564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsNkPYWyEStnM2GK6FQ11EPE1SL0LCNKdfqZC2SuQjs=;
	b=U2NSd7GGk0WW8JDnhF2WqBfqZ3yvrJntH2EeEzbRwyOSpzNqPKydGB2NMu2Fd63Ze2EJXw
	XfB3ZYqITJVG56eaxR47yLj8gCDUDbaoNRkaJzQVuBlEvZ+fX5UKyeggJ6Djp/DkqUTCu/
	IIj/feYLkSNBqw9WWf6QFtfXmhVCSSA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-cStVlizlO0yI7zXQhv9n-g-1; Mon, 18 Nov 2024 10:59:22 -0500
X-MC-Unique: cStVlizlO0yI7zXQhv9n-g-1
X-Mimecast-MFC-AGG-ID: cStVlizlO0yI7zXQhv9n-g
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cbad9b3ca2so3183957a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945561; x=1732550361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsNkPYWyEStnM2GK6FQ11EPE1SL0LCNKdfqZC2SuQjs=;
        b=TwLqYT2DiUaNJaUoY/JkHR6aDN0Ids5meZeiAqn+8elU5GKLdxGMQl77Hsztb2sWGl
         rgdmEjDIMGByUkzo0byK4XekQkZsxdgnz9faUnfALuV1FjQEKvmEP8YeUqd1VTs4x77z
         qWGkqYuKHy/EKH8jqF4gKP46qbDRsiGdxkK0jDKR3pMHBluEymDiMFy3pRPZTZkZ/TRr
         d6KZO2A9usCnXv9mY9DfIFI7lFEmMkothQL0F961Aug3SZ6hH42I1M6DzAVYiwrBGfuV
         12FuebQyJWCbaH/eHQGO/SbWj1Aq+QaWtzW/UtPVs3w40pZBtov7cndqtJ6FOpbu/Zaz
         Dp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaufmPtIPsKqTXWkndcouC6dpD2n0Pz2IpzXvyKvpxiy7MzwjcSzmlx8ecX/7HKrrAOIKI95FVhbeONIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCb8+Dby34rrnoQltSAh1Nqx2KYl/egoDJQXOkw8eY2i9424u
	93Q75ArJKoSSfW08brMuQyCpZss/Vjrm2aF4ZejfQFt5wIs2Vn/CnQrKwrybH/LfIC5tbnyFLDW
	1gimRhcOoQZRSUJ6VF6iIRDcCcUw6BHohb0OuP3ac5BVZQ8pOk+dwJmmLlmfcmw==
X-Received: by 2002:a05:6402:2693:b0:5cf:68f4:e2db with SMTP id 4fb4d7f45d1cf-5cf8fc17c47mr9328012a12.9.1731945560812;
        Mon, 18 Nov 2024 07:59:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5IrmJz54uPT2cGG8O85VTjdZfry6BrJMzPosb9zG+DiITHBZefCJ/I5YSUhFD8N92tRibdA==
X-Received: by 2002:a05:6402:2693:b0:5cf:68f4:e2db with SMTP id 4fb4d7f45d1cf-5cf8fc17c47mr9328001a12.9.1731945560450;
        Mon, 18 Nov 2024 07:59:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfc2677c5csm1422970a12.72.2024.11.18.07.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 07:59:20 -0800 (PST)
Message-ID: <8151585c-cb4c-424d-a81c-939ee30d8e9d@redhat.com>
Date: Mon, 18 Nov 2024 16:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Ricardo Ribalda <ribalda@chromium.org>, Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yunke Cao <yunkec@google.com>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org>
 <ac8ea4ed606cbc7dfb15057babc29e49a152ef01.camel@irl.hu>
 <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 14-Nov-24 9:03 PM, Ricardo Ribalda wrote:
> Hi Gergo
> 
> Sorry, I forgot to reply to your comment in v14.
> 
> On Thu, 14 Nov 2024 at 20:53, Gergo Koteles <soyer@irl.hu> wrote:
>>
>> Hi Ricardo,
>>
>> On Thu, 2024-11-14 at 19:10 +0000, Ricardo Ribalda wrote:
>>>
>>> +     },
>>> +     {
>>> +             .id             = V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
>>> +             .entity         = UVC_GUID_UVC_CAMERA,
>>> +             .selector       = UVC_CT_REGION_OF_INTEREST_CONTROL,
>>> +             .size           = 16,
>>> +             .offset         = 64,
>>> +             .v4l2_type      = V4L2_CTRL_TYPE_BITMASK,
>>> +             .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
>>> +             .name           = "Region Of Interest Auto Controls",
>>> +     },
>>>  };
>>>
>>
>> Wouldn't be better to use 8 V4L2_CTRL_TYPE_BOOLEAN controls for this?
> 
> If I create 8 Booleans, they will always be shown in the device. And
> the user will not have a way to know which values are available and
> which are not.
> 
> We will also fail the v4l2-compliance test, because there will be up
> to 7 boolean controls that will not be able to be set to 1, eventhough
> they are writable.

So why can't these other controls be set to 1? Because only one
of the options in the bitmask can be selected at a time ?

If only 1 bit in the UVC_CTRL_DATA_TYPE_BITMASK for this can be one
at the time, then this should be mapped to a V4L2_CTRL_TYPE_MENU
just like how that is done for V4L2_CID_EXPOSURE_AUTO already.

Actually looking at existing comments about UVC_CTRL_DATA_TYPE_BITMASK
in the driver there is this comment on top of uvc_mapping_get_menu_value()

 * For controls of type UVC_CTRL_DATA_TYPE_BITMASK, the UVC control value is
 * expressed as a bitmask and is thus guaranteed to have a single bit set.

Assuming this "guaranteed to have a single bit set" comment is valid for
the V4L2_CID_UVC_REGION_OF_INTEREST_AUTO part of UVC_CT_REGION_OF_INTEREST_CONTROL
too then I think we should simply map this to a menu similar to how
this is done for V4L2_CID_EXPOSURE_AUTO.

Note V4L2_CID_EXPOSURE_AUTO is the only existing user of UVC_CTRL_DATA_TYPE_BITMASK
at the moment.

Mapping this to a menu should nicely address Gergo's concerns here.

Regards,

Hans


