Return-Path: <linux-kernel+bounces-437774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DE9E987E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95151882651
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDB1B0400;
	Mon,  9 Dec 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhGQutoE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E415575F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753523; cv=none; b=FadLIskpz2NhOSHqZs3m0s6zGS6yAUkvVrlXUUL6lxBhur71n7d2Q4Q/FrmdPiZlt+baxIGmeqv8OBgEi9DIxVjGJXcgxNlP+v+t1SLn626ryGGydYk41sH/BUfFmKcHCKZArPHh2e3d51OuL1bnv8Jj3uHCNbDK60MjNZnBMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753523; c=relaxed/simple;
	bh=HUA4b4M8JnCMR3m0/iw02mhSWeK2KScSMgJfj1k3/No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXu3ezzM17eG9aX/3h0oivBWxqDX36eBfkNM7SZ8Ck1mxUj2833oMzC9cQZNBoLlQXZ0dFPFhI6Q7Y4BxbNgjohR/svKxVZ0FnigxWrELPdQTvOTaI5AFgIZeDofhG9rY8Sv8ztKYFnLYHYpYlpmIJcxnU3mMraCF6OUsm9rN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhGQutoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733753520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+4+nlTVwxPvy1lSFfkyjyoPQLwpzbUibFlcQJuLdCc=;
	b=fhGQutoEoibtuM83CujJx9ABgyxpBWlWJ2EstVWjU3rXhJnj7DsTFTBjYmNxfO2REsW3SR
	YcCLVK3nnBE75pKTkuYBGqqHaF2EKUY5ym8QENY+rGifggJ3g18rGjaEC6NofztVRmmLD/
	tnVfQNGeLLrPBxoAbEg5SnfUiHMY7u4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-J_WRwPYVP2SR8b4MIcNTVg-1; Mon, 09 Dec 2024 09:11:59 -0500
X-MC-Unique: J_WRwPYVP2SR8b4MIcNTVg-1
X-Mimecast-MFC-AGG-ID: J_WRwPYVP2SR8b4MIcNTVg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso111682266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753518; x=1734358318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+4+nlTVwxPvy1lSFfkyjyoPQLwpzbUibFlcQJuLdCc=;
        b=ffIjm9b43J0WGsuHVQf76LtoBfOYdTCOw5FTmy6EHZctDz7ZCPacPf4dn2zrjBFqW4
         cezx8pzEiHm/TYEhWIVgEuIX7VNpr6scMgpttRQdh7SxkvYx7AmOg5TYF34++aX6GAbB
         fExB0vjtdmYTrzAgqs3sW4VI71EaHISDWEv1xSr5FnYp9B4a1Rk8V79Epdn9Q5gfYNs/
         szUzzRDBGZPGHW32GzrNu+wJmAlwzzukt8emISAtZfg/SQxGRJBBwu4xtc9Hb23+9bfT
         gjnuR/TWMp5brX5/Zw4r+uCeipZOwruxI0Xo7g45LyM//3jCZ6z5F9cCt79nxhaSpQXy
         iSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJxTxwSqFpK7wqqhg5R3AwHOihf2roolAmRo+2lX0jF0jc/f+IvHlDrswpPhIhSzIoVzVq6Zm8mTwr03k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hV5gbrtphFcKYjVdqEafhqK3zWCOXSQgJ+yF6WgUS4Hsznrp
	iPZnozY8HK8VMQmerFFTTVSyf0te2QoFeL5Jx6v05dRZI0mV4H4+5He6Xs1XE8bLwD5upImYg0L
	nHX/LkJKx0mGslOTdid8H7rtstEAqL/4Kt1g1TzIm1EbYQus3Y3LpcUyU4i6CWw==
X-Gm-Gg: ASbGncuRs/l3Qi4FQXqx6vkMQssbuE41bGAQvVYGUcjZfNFU4/TL0jjkGlt0XNfhRZw
	lzomJq12Mq4Feasom90XsT7ef0wG5PirEPUkMxxBdv+vMv0ILP544CqxmzuJfm9HyeDAHw400we
	3ojDZswI0NE/U3CN4XIDHMXlzUKE4n5iCoraBuAAik+ks3AluPFaRAURiZbOtNNeM+aIna0E0wN
	TVq4X86KUGKdbYZmvZ7E242Bcs49jrMDR2F4VyE8SqIaumPVUYJg69jqw==
X-Received: by 2002:a05:6402:4315:b0:5d1:1064:326a with SMTP id 4fb4d7f45d1cf-5d41853edd6mr1844018a12.15.1733753517897;
        Mon, 09 Dec 2024 06:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpxg+1Gf1R8AT9wVN7m/GsAbasHVdsDYLb1ALuKdf0POhrVzOzG6/X89WZcBRq4P9o59TDOQ==
X-Received: by 2002:a05:6402:4315:b0:5d1:1064:326a with SMTP id 4fb4d7f45d1cf-5d41853edd6mr1843947a12.15.1733753517478;
        Mon, 09 Dec 2024 06:11:57 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm3154356a12.56.2024.12.09.06.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:11:57 -0800 (PST)
Message-ID: <8258ce59-cd06-46ba-b275-97eb9ae4d64c@redhat.com>
Date: Mon, 9 Dec 2024 15:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 17/19] media: uvcvideo: Add sanity check to
 uvc_ioctl_xu_ctrl_map
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Do not process unknown data types.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 5000c74271e0..4c88dab15554 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -106,6 +106,12 @@ static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
>  	struct uvc_control_mapping *map;
>  	int ret;
>  
> +	if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
> +		uvc_dbg(chain->dev, CONTROL,
> +			"Unsupported UVC data type %u\n", xmap->data_type);
> +		return -ENOTTY;

This seems like a textbook case for -EINVAL ?

Otherwise patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> +	}
> +
>  	map = kzalloc(sizeof(*map), GFP_KERNEL);
>  	if (map == NULL)
>  		return -ENOMEM;
> 


