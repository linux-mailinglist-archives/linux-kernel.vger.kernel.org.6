Return-Path: <linux-kernel+bounces-415794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2109D3C97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F982281BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC841A9B3B;
	Wed, 20 Nov 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HutQNdb/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BE19E804
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109720; cv=none; b=o+LJkTgOV7/AxK55Ch/XAabuKhrN/aUxfidfpxvzQcWqXu+Ul5QOB9NRqR7Lzo9cxL3mjorpcYqemf1a2pd1f3oGkXQYGlscLGv7PUqFGEtecc4Yv3Hf/YddzmnufbMndRjjGsEXv4Hwczn3wnm3Gp/1UsR6WP5gr43a+oNnchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109720; c=relaxed/simple;
	bh=e8FOrIY3cxf0W7OzTn+6xazKzrkSDvIqGfy8WUggbqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqZNqz1fMsPV7oxuYR9edtUaVnR/iJ8O9GLaZmOqAUIekJE12RqbHPyzSttNVjBQlqSCm5SEI7ZvmvD7Jw6Kh6Ihssho+maxr2KdMVCueimV940tRtoIVIi0OdY7wQ9tB1IRcbfdAkH3q3VlojIXytlL3+PEYnV4K59FS2vqjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HutQNdb/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732109716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2vuM+CMH+yKfOybEW/urA/Wxu3mQQTGIWZA/ooePvs=;
	b=HutQNdb/MklXX+3468hYRdtaZApAzttLb8VdsRP9+2yhqGtPqAUHo/yio0vGXMs7j9QUVg
	ZCZmZYm5N/cTlTEgra4HhIvxUkudzh5x5jLuTSJXunLq3ejjO48NNX1SSy8jupt1kkuxY3
	OuWJhkoTyvqPv/tCoFJ7ZmEsBqnnz9s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-CWG5oZ8QPJSwhUW2cG_nkA-1; Wed, 20 Nov 2024 08:35:15 -0500
X-MC-Unique: CWG5oZ8QPJSwhUW2cG_nkA-1
X-Mimecast-MFC-AGG-ID: CWG5oZ8QPJSwhUW2cG_nkA
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539fb5677c9so1865451e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732109714; x=1732714514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2vuM+CMH+yKfOybEW/urA/Wxu3mQQTGIWZA/ooePvs=;
        b=dtVXQoLae8PG/YUtUYCX2oJ97169qmeVWdZMufA6OmqYyl0blZtXL1BQ6eKZfgtDPh
         qm56bcB2rBJ+gBTrKa0hcIhKq1PRdVtAlMOy+KB508Yz+PFk6Wh3q2CuPgwGMRNib95c
         7bmRiJFqFJAlrOk3qOyMSH0+GFy4I33ibxgYDdoNMPcGxj/FU9oslRn54vIg1EUWloJp
         yNAZuNYyfPv2Q53yA6Lpxs/DGt2QOgQpy76gl+xCZx38Jr73fUIPMb+BylNVEGr45aZy
         7C7WG0NjxgjOIohG4fTziU9EjW3BsV+KF9CqQMPXnDoGk47pBzF0nY+9705bWWO1qvub
         6XAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU33MAeCDqy9hjPNwvX25kdbgQ6mCgUeEXYK+wzV8+CIqYxXb/7ddjv8FK+PNLa0dw6nT5iapuQt3m0Bnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXB5hN2Jpn5dsOCfpuSLMD90g8gCJbzwRMgMeLUBjQEbWZZzuD
	W3/8keGA0ETHycjYdSJOtfMLH6/IqkP78prN4AiFTNyeHe6KZf+6c5XUj+9B+1GQlrRRJ5CdkOi
	4HQ/4xzgWgGArULkHclfwE0jN8y04oFUZs+/l+90VvwDrxIAGUFYKJk1XBUxs/g==
X-Received: by 2002:a05:651c:154e:b0:2fa:dc24:a346 with SMTP id 38308e7fff4ca-2ff8db983dfmr16247761fa.21.1732109714005;
        Wed, 20 Nov 2024 05:35:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM5a1z+R3MCpAN7r90XeLbA5BmVoikjwMqI/J8xiQ/7XIgwC9eSLkmbqa8PDhJOeGQeKJnmQ==
X-Received: by 2002:a05:651c:154e:b0:2fa:dc24:a346 with SMTP id 38308e7fff4ca-2ff8db983dfmr16247621fa.21.1732109713608;
        Wed, 20 Nov 2024 05:35:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44eff15sm810931a12.35.2024.11.20.05.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:35:13 -0800 (PST)
Message-ID: <fe5a0e29-fa36-4daa-be62-9186c47e02ba@redhat.com>
Date: Wed, 20 Nov 2024 14:35:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
 <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 6:16 PM, Ricardo Ribalda wrote:
> Some cameras, like the ELMO MX-P3, do not return all the bytes
> requested from a control if it can fit in less bytes.
> Eg: Returning 0xab instead of 0x00ab.
> usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> 
> Extend the returned value from the camera and return it.
> 
> Cc: stable@vger.kernel.org
> Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index cd9c29532fb0..e165850397a0 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>  
>  	ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
>  				UVC_CTRL_CONTROL_TIMEOUT);
> -	if (likely(ret == size))
> +	if (ret > 0) {
> +		if (size == ret)
> +			return 0;
> +
> +		/*
> +		 * In UVC the data is represented in little-endian by default.
> +		 * Some devices return shorter control packages that expected
> +		 * if the return value can fit in less bytes.
> +		 * Zero all the bytes that the device have not written.
> +		 */
> +		memset(data + ret, 0, size - ret);
> +		dev_warn_once(&dev->udev->dev,
> +			      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> +			      uvc_query_name(query), cs, unit, ret, size);
>  		return 0;
> +	}
>  
>  	if (ret != -EPIPE) {
>  		dev_err(&dev->udev->dev,
> 


