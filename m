Return-Path: <linux-kernel+bounces-541916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8DA4C35A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70C51644CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B72135AD;
	Mon,  3 Mar 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJPYXNOq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EF212B0A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012000; cv=none; b=BAcRUYXPdXAex+YHADMHwy9R01ZtDzQDIIRsaVm19QQB8H1SrXIovEmXQADKfUoQyulpuvV7J5OyNd+YoKck/Zf6/57Accfi4p3O/iaSptONZzQ86qGWCfGVTAyon4lnlhOdZYlBERVT20ACOasSYS0w8JsS6F1e4zkapDt25W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012000; c=relaxed/simple;
	bh=slLX+r5Vf8CWQsPvwwtkbWKltyR+MVUjLc6odV2SI/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnltNrwuoYe2o9QD2L/4zhWyR2+bCrJxsQk3lBH55xnMRb3K/rhuE1m8zKxuiLvJZxQYQ1bMGNxKFj63mVrd5W+7QX2vcRgmz+xgIsfploynr+Sbyv8XjW//voH7q5+tZm7O5q+9otmd3qEHVlQeDQy1/fwvwz0I/XY/5LwE6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJPYXNOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741011998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0V1g1d1kOcTOs2TZBAtXmVXD8dosU2PjAXG9JAsWxs=;
	b=GJPYXNOqCFMYgoTST/GfL9Mp8kruqauTa3TNS/Xfjdx28SmYD018+1H+4B6VcaDKqE4qTh
	opXR+PoMJn5mSc/XbLHdVoQBcLuYqgo3CUQnm0g5ppzSJ83pGp9IhU8n4Zf7iHmFf5v0AY
	YDnIqsyrk3O2lHepXUo6VUms9zyCmzQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-3abgMhx3OdCHyMuwG03Hyg-1; Mon, 03 Mar 2025 09:26:36 -0500
X-MC-Unique: 3abgMhx3OdCHyMuwG03Hyg-1
X-Mimecast-MFC-AGG-ID: 3abgMhx3OdCHyMuwG03Hyg_1741011995
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abec83a498cso440345266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011995; x=1741616795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0V1g1d1kOcTOs2TZBAtXmVXD8dosU2PjAXG9JAsWxs=;
        b=LxWnnFOLkGUPwSYyvifdS8MJgjH0xaPC7pSkO0XAbvhREWTG+zen9HmtuW0pARdcfw
         oUV2qE5bPISmN0edRdtbmh30kWn3kdpNDN1H7L/O5a4QBSRMlPDOgtPRAEjA/PIpbqIN
         QoFTCKZ5skURWWR96IxCdjxVUozS/S0Ae43iLqomrycg8n/O+jbAR2yl2cMsNQnDQ7ON
         Fim+l12OUrkhr/8EsUsYwqUj5vlp9uCDLQ5fKg3VsTriOW1iMhBv2ERT0XU65khPaV7k
         EaZl1BBD7nZ6NeNFgbkGqF7pV4n6XaJ8luu3UAdzUZmyGxxaVaMRDGrKpwDA45Zn2SOG
         6U1A==
X-Forwarded-Encrypted: i=1; AJvYcCWgCmDaq0pYEnYGsVzvyx6aslB6Z5xcdSqwWjzgQXcTow3anBww5U9S+onI2BbID57/8jvp7wi2gok6sBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAw2FJTfJnwsf5NZjwgygkjU1Oj+77OeCCoBCUIp8dyDQClg9
	b+Fs2fB9yox2YUP+82/hxojNbNGy1WsxYjkUgaVrrHpceJAJwXKdaxtSNTJzmvfUHIu3YloYwRq
	PL0AF+ddGaZeTaJCjN/okjkNLbqq7v0hqCjgZVc4VxJf/SY9CEW835Xb2aRx2nQ==
X-Gm-Gg: ASbGncuy66BUF0wj0fzZXulo1O6GNaFp6MovWmz1Czjc2K2jOOkyHfyJqs+PfzJl8ag
	6QOsB2YG0T9ZXGhAFWBddHa+om62i3aVfBOucK1nHxZ/1MjnSmn3FksbUgUHlTGXWiZTDa8WjAc
	HX48HUs0fqnpnJMH3izV+tfUpPaDC/Q1nThZ+GBAC8SYLx9h2r5CS64DzhJu0w7CPULFWA/0jmi
	uG/4ew91eM68ZOAA7U2I5MofLCELrMfKOdXWc043JHzROH2UV7pjQwC6e10q/mV7K84uaZj+VIL
	+SvBWft4iIZns6O5/Zk=
X-Received: by 2002:a17:906:5a8a:b0:abf:67de:2f21 with SMTP id a640c23a62f3a-abf67de35damr558387066b.22.1741011995194;
        Mon, 03 Mar 2025 06:26:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzOGDBt2RYzDbXQ3y5yBOHdK8rIBHsZoNXo1J+c/fxCXYuQaNx/yDF9GPSHNZgV5UDXckEDw==
X-Received: by 2002:a17:906:5a8a:b0:abf:67de:2f21 with SMTP id a640c23a62f3a-abf67de35damr558385166b.22.1741011994787;
        Mon, 03 Mar 2025 06:26:34 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf65bc01d5sm341299966b.29.2025.03.03.06.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:26:34 -0800 (PST)
Message-ID: <bead8b8d-b0ef-40ce-8e8b-928be5d35d8f@redhat.com>
Date: Mon, 3 Mar 2025 15:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] media: uvcvideo: Create uvc_pm_(get|put) functions
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
 <20250226-uvc-granpower-ng-v4-2-3ec9be906048@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250226-uvc-granpower-ng-v4-2-3ec9be906048@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Feb-25 15:23, Ricardo Ribalda wrote:
> Most of the times that we have to call uvc_status_(get|put) we need to
> call the usb_autopm_ functions.
> 
> Create a new pair of functions that automate this for us. This
> simplifies the current code and future PM changes in the driver.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 36 ++++++++++++++++++++++++------------
>  drivers/media/usb/uvc/uvcvideo.h |  4 ++++
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f9cd6db759c5..de1e105f7263 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -26,6 +26,27 @@
>  
>  #include "uvcvideo.h"
>  
> +int uvc_pm_get(struct uvc_device *dev)
> +{
> +	int ret;
> +
> +	ret = usb_autopm_get_interface(dev->intf);
> +	if (ret)
> +		return ret;
> +
> +	ret = uvc_status_get(dev);
> +	if (ret)
> +		usb_autopm_put_interface(dev->intf);
> +
> +	return ret;
> +}
> +
> +void uvc_pm_put(struct uvc_device *dev)
> +{
> +	uvc_status_put(dev);
> +	usb_autopm_put_interface(dev->intf);
> +}
> +
>  static int uvc_acquire_privileges(struct uvc_fh *handle);
>  
>  static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
> @@ -636,20 +657,13 @@ static int uvc_v4l2_open(struct file *file)
>  	stream = video_drvdata(file);
>  	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>  
> -	ret = usb_autopm_get_interface(stream->dev->intf);
> -	if (ret < 0)
> -		return ret;
> -
>  	/* Create the device handle. */
>  	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -	if (handle == NULL) {
> -		usb_autopm_put_interface(stream->dev->intf);
> +	if (!handle)
>  		return -ENOMEM;
> -	}
>  
> -	ret = uvc_status_get(stream->dev);
> +	ret = uvc_pm_get(stream->dev);
>  	if (ret) {
> -		usb_autopm_put_interface(stream->dev->intf);
>  		kfree(handle);
>  		return ret;
>  	}
> @@ -684,9 +698,7 @@ static int uvc_v4l2_release(struct file *file)
>  	kfree(handle);
>  	file->private_data = NULL;
>  
> -	uvc_status_put(stream->dev);
> -
> -	usb_autopm_put_interface(stream->dev->intf);
> +	uvc_pm_put(stream->dev);
>  	return 0;
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index bc87e1f2c669..fbe3649c7cd6 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -763,6 +763,10 @@ void uvc_status_suspend(struct uvc_device *dev);
>  int uvc_status_get(struct uvc_device *dev);
>  void uvc_status_put(struct uvc_device *dev);
>  
> +/* PM */
> +int uvc_pm_get(struct uvc_device *dev);
> +void uvc_pm_put(struct uvc_device *dev);
> +
>  /* Controls */
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>  
> 


