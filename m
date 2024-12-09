Return-Path: <linux-kernel+bounces-437919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC139E9A81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38931886D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFD1C5CA0;
	Mon,  9 Dec 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxVZKpE8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AA1C5CB2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758120; cv=none; b=StwWJJ55jQ6++5ybUMeWk67rle18ebQqo8sBv9RNbpTgSwvyUOiLb2s+BON4UMWGIps2HWX0w/iNAh4mAocFKEI8iyAhEu2xnxebWi4cwmq8NH3cVWv5oY3jz8HuIpKRKX5RBeqe2yFwGRzxzqWBi86LMGM2lHBMq9LHnFXDX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758120; c=relaxed/simple;
	bh=qvf6Z+Ka6yQvgPXOvWAMB+sYfbrIepMBTcEYp5GgVMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnHq8Sh7lwKZbZCFFuwHWRvesPLMZkXP24UJy8gITilLUtHYqWoFvfFhBHZmb3wox3yMDtULWqEeGe6FM58apnyyfE9E+t+Nf14ouOiU5oGU0hYqYFy+nH1qiY598xPPtrXhrU/hoGRTJe6LdElep6X3j55IdQM4k+IpKwEmG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxVZKpE8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733758118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8CNxdaZDke1IVjl09wgAQK9CPtsp+j111TxSqB/HAA=;
	b=SxVZKpE8Zpk5Qzg7E6KoO8ZE8pmnSEsYKA8Xkh06S0FDAhUfjrgTSzjXCgawgwzOgehkTt
	2/D6ygeu8fh47rog8peASs0hc81khxtgSGi8tayvKEYNYAFybrpn4kwxFvz2vpAtaiIoWT
	qGWGy8zz+9840MoX+vAid6SsQf7DpZY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-_l7N43l9M96XZrZ4zPWrMg-1; Mon, 09 Dec 2024 10:28:33 -0500
X-MC-Unique: _l7N43l9M96XZrZ4zPWrMg-1
X-Mimecast-MFC-AGG-ID: _l7N43l9M96XZrZ4zPWrMg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3eceb9fe8so1127569a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758109; x=1734362909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8CNxdaZDke1IVjl09wgAQK9CPtsp+j111TxSqB/HAA=;
        b=jLe9Bbkl+nY2OkPF50nceaImOYeRYddshnOsdxn3qZXHwj+nj+JMCXOXHhCdse6TuK
         BG2WJS62G24TJitCGs0orCph+ep650+Gloh86scdoAZddYdMHRq89nPwXgR9U2UscPEb
         DnM1FyUXzmh21JXQbk6TcvKZQrd9NA6JtiWDhD3IovknYZDCjJsAlf1WyHJGr7lVq94R
         PMN8ojiXr15HtFT1N48/KiUivcRFXZ/WVUMH2hkee2I4ZAFTRHttHIueHdgDWcZwC6vZ
         n9Hs/asGfoBu9v3JobMDHK+iOe7uAp4MAmZdgPE0ezIbzXuIv6u3+Qk47TT8GhoSs335
         +6cg==
X-Forwarded-Encrypted: i=1; AJvYcCXb6G2kA412gixe8vwrd11oDjeHoJ7j8MPxTqsjNOGEirTP/TX17aQBHP1HhU1FvZ0i4nwL5MK2gZxhgBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGUxdob2rKG04zK+EUwRi93Y1bfkq8WVbsxgS3o7IBY9ukVxV
	aZAaCgm/JRwgHRURKuAyWyOv6BpbQbmUJWtXrHjB9X4szuOYS5+IviwY8HwlLlXR4uMGzEQGajR
	fNouf1ut0iBFJ9Aa9SxSxXCJtixuwp2z0KyjDbYuHD/H9p86DWOzbxdo2xAsZjg==
X-Gm-Gg: ASbGnctaIwkMlJBoA4SRn67QE9ATcXmW3s149f7YbKY4VXiFY2ICzcwQ6S+Uuvuqiqf
	bMBXH4c80r/Vs728KfXyPfjEsE1z7KU7lAWFuXkQFDIifpFqi9CQGU+BMmzTgEEHv0FkDcosi1q
	n2rhWS/bqO0+DMdDVFCxTRKIuMO2VrSUJ4P5nOt4wM4q1sstPa9qxeZEwdfYAyl/0mF8qjOE1UX
	ke/UFY/bC9hzuGsFlnE7l1DKHDdRc4nfkPqNYU4n0z0kxKFrxE3xpz3hQ==
X-Received: by 2002:a05:6402:2552:b0:5d3:ba42:e9e9 with SMTP id 4fb4d7f45d1cf-5d3be6d69c2mr10705533a12.9.1733758108788;
        Mon, 09 Dec 2024 07:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpNDyINNKptq9S98OEpzOs4X92aZ/u6zj2HCho4ET4SXIDz5mwVd5XzLnEYATHoc0J67tznA==
X-Received: by 2002:a05:6402:2552:b0:5d3:ba42:e9e9 with SMTP id 4fb4d7f45d1cf-5d3be6d69c2mr10705500a12.9.1733758108387;
        Mon, 09 Dec 2024 07:28:28 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3c2b0137asm4953862a12.4.2024.12.09.07.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:28:27 -0800 (PST)
Message-ID: <1d7c4bdb-f34d-4df6-abab-25c0a7af9cac@redhat.com>
Date: Mon, 9 Dec 2024 16:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yunke Cao <yunkec@google.com>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org>
 <2e90c10a-71fe-4e80-9ac3-80393bc8b266@redhat.com>
 <CANiDSCvO4DvAHfYpkSi_ZMuV6huk0fTA94-jPafeGrUw+6WoZQ@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCvO4DvAHfYpkSi_ZMuV6huk0fTA94-jPafeGrUw+6WoZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 9-Dec-24 4:23 PM, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Mon, 9 Dec 2024 at 15:22, Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>>> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
>>> index f86185456dc5..cbe15bca9569 100644
>>> --- a/include/uapi/linux/uvcvideo.h
>>> +++ b/include/uapi/linux/uvcvideo.h
>>> @@ -16,6 +16,7 @@
>>>  #define UVC_CTRL_DATA_TYPE_BOOLEAN   3
>>>  #define UVC_CTRL_DATA_TYPE_ENUM              4
>>>  #define UVC_CTRL_DATA_TYPE_BITMASK   5
>>> +#define UVC_CTRL_DATA_TYPE_RECT              6
>>>
>>>  /* Control flags */
>>>  #define UVC_CTRL_FLAG_SET_CUR                (1 << 0)
>>> @@ -38,6 +39,18 @@
>>>
>>>  #define UVC_MENU_NAME_LEN 32
>>>
>>> +/* V4L2 driver-specific controls */
>>> +#define V4L2_CID_UVC_REGION_OF_INTEREST_RECT (V4L2_CID_USER_UVC_BASE + 1)
>>> +#define V4L2_CID_UVC_REGION_OF_INTEREST_AUTO (V4L2_CID_USER_UVC_BASE + 2)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE            (1 << 0)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS                        (1 << 1)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE               (1 << 2)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS                       (1 << 3)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT         (1 << 4)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK    (1 << 5)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION (1 << 6)
>>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY              (1 << 7)
>>> +
>>
>> Hmm, shoudn't these be standardized. At least the ROI rect control seems like
>> something which could be standardized ?
> 
> I believe that back in 2022 we deciced to go with custom controls:
> https://lore.kernel.org/linux-media/a0fe2b49-12b7-8eaf-c3ef-7af1a247e595@xs4all.nl/

Ok that is good enough for me. I just wanted to make sure this was already looked
at as a possible generic ctrl.

Regards,

Hans



