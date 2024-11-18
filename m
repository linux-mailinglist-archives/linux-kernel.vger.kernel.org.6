Return-Path: <linux-kernel+bounces-413249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F69D15AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D34B1F232C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635E1C830E;
	Mon, 18 Nov 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj+zFfPh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4AF1C6F73
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948325; cv=none; b=ps5QMfhVY4G+XPDZGXQLsjvI3TCRdslNn4AZ9P6p3lwgic+nO9dxh1cF00uhb2MBRF19LAaigCjUdH93D5nDrkVPlOFF8TQOxtgCFLUATx2cljBzRvAU5sTASeKjsna/6c2ORvoX3iGbCYa6M0bdIZMjNLvLOUgiADJrZ8/wqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948325; c=relaxed/simple;
	bh=M8qRZwuPSHZzmXncbrgn/s/Tt5ePgg+efoKISTCGEos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOxkNEefLpJYghy98LhA1u4AiWzN8Q+Fvh2zJ2T9LoogJBskHXPIgtnlYyAEin5k4jqhS0w0aUtOx8i+AegIE60W81WxwPz6RApsjksljxq16xljP3RxBodBWIj/0i2j2082MmaK/siJ/XhIlp7JJQa3WHwuxXvUdFU41KadNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dj+zFfPh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731948322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D++6g6lRdyP0JIFnmfdsxSr8uKDFgQCiSM+h9Fjlq0k=;
	b=dj+zFfPhywfgLHLo078UOS53SQrpkFb/rPIOzkqeViB0eTP4P05+izHmDWfVTTjJUYJ/rS
	H7hAEhs0r5fbLPFbn7c6FHd0EKgizu+AjhX9zsarEE80aPIhrtFzguYEIWvJeg2y4hZ6PI
	p/ri3fAlCLZIBBl8r60MYw/LKkJzT7M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-8kGbJgn1P9C-KGClgtP5MQ-1; Mon, 18 Nov 2024 11:45:21 -0500
X-MC-Unique: 8kGbJgn1P9C-KGClgtP5MQ-1
X-Mimecast-MFC-AGG-ID: 8kGbJgn1P9C-KGClgtP5MQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0c259715so85860566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948320; x=1732553120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D++6g6lRdyP0JIFnmfdsxSr8uKDFgQCiSM+h9Fjlq0k=;
        b=OqBQYTl2xW304mu8CwTqmT39DO3kHwAUjp03iugCCXpvznEmQrUksn3oTqpLu0ZhuP
         Jtfp8SCEsJGTSDuSr09S0EFicM6ZUHVcCYuanMwNeHkHPS4/YBxLXjaGzWiVt2tO6gZm
         yRQnMnb3kbx71cKlq+Zx8fcE1GJYLZhEo5C3TywvT6EkmQyohTMhnsAQV/f244S4QWx1
         PEzYGxBJHA7QWT+dP0jLGeeTJFX9dED70qmfy51bdunFIwdL5HFxyj7lhz2Wz4gCZQPN
         0H3jBBzQX6sDiF4kCrAnnqEjsk0GGeKR0M9pOm24AEGlT4iNEZYJTCE2kPtNG8ThWwDb
         aKRg==
X-Forwarded-Encrypted: i=1; AJvYcCX6dmzWK2PSOPprrpHz6UhR//TsjbIuqfUAIyl5BsLU581p/U0ug4+VGQdkx++lF22GunahQLlkXCs3/cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAa62vyIIa+S2+lJnIP3yqcA/qWAo4eqTWa/wN21oEBUKn/5L4
	wkieW5B/eKEGqqFJQK4AegobUPcpb2BK+WjFVEUuubdQ+rIxwTvM5vaZXnN+6gjCM8+cGEhoQEB
	MTt3VPbpaN2zg0UFMOoml8wfR19VDZQgLWsmSwMyF4qW3dGLffgFXYbpNMKEf3w==
X-Received: by 2002:a17:907:3e1f:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-aa4834543e4mr1083129266b.30.1731948320215;
        Mon, 18 Nov 2024 08:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXl8O9GsIyhuXzg5nGHjHl/pfG7DfEkgnUofIDwvqnvdm/ClXmO+TdQXQb1pKYHJ1yTUY9NA==
X-Received: by 2002:a17:907:3e1f:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-aa4834543e4mr1083127166b.30.1731948319861;
        Mon, 18 Nov 2024 08:45:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4a18e7e4dsm292474366b.201.2024.11.18.08.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:45:19 -0800 (PST)
Message-ID: <4ce7cac7-6e4a-45b8-8d0e-a8f16a77839f@redhat.com>
Date: Mon, 18 Nov 2024 17:45:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] media: uvcvideo: Add more logging to
 uvc_query_ctrl()
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-2-04d9d51aee56@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241008-uvc-readless-v2-2-04d9d51aee56@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

Thank you for your patch.

On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
> If we fail to query the ctrl error code there is no information on dmesg
> or in uvc_dbg. This makes difficult to debug the issue.
> 
> Print a proper error message when we cannot retrieve the error code from
> the device.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index f125b3ba50f2..6efbfa609059 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -111,8 +111,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>  	error = *(u8 *)data;
>  	*(u8 *)data = tmp;
>  
> -	if (ret != 1)
> -		return ret < 0 ? ret : -EPIPE;
> +	if (ret != 1) {
> +		dev_err(&dev->udev->dev,
> +			"Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
> +			uvc_query_name(query), cs, unit, ret);
> +		return ret ? ret : -EPIPE;

Adding error logging is always good, but again please drop the change
to the return condition and stick with the:

	return ret < 0 ? ret : -EPIPE;

pattern used everywhere.

Also in this case the return condition change really should have
been in a separate patch since unlike before the success condition
did not change, so it really is unrelated to adding the error
logging.

Regards,

Hans




