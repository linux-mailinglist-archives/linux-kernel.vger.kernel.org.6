Return-Path: <linux-kernel+bounces-541922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECEA4C36E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4E918923B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD07CA5A;
	Mon,  3 Mar 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFtEnUxM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384912139CF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012475; cv=none; b=D5POAQRKmWFIZKPXBFNf1ycUOqqvU9kocRwISAhDJ8ndvgqQHpiaxtcMmD/tOjo72/6RFC2wuvNAoTsfD3XU7aMfY+EPQ5EHNUsxEUD7gOQASsbLHwOh1yJjudeFIjmu+zv0N9bilIjmLLtTU6NU6Wyz33DHnA5aaO6Jh/eM1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012475; c=relaxed/simple;
	bh=5qvGUIZ/I5J/i3g9av11OIbWKvv8KsxZRfgvPegFhq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jkc1vAWhNqJdq/Q0sHVJiwTq5TpHgwMAQiHP1wPg0Bzm5a+i5GDOeAYZIqP6MKPMwaUdQGh5wJBZ9OGUBx7QxmAZsO+cCepeYfAEjBfv4xEEHmmD2GqMQgoiZAdNe/klb061uzRKa0PFYP6aYh1MTn180OzxSdOi7lGYOvqUH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFtEnUxM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741012472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I34YFTmas2vrNzlk9v8DChrYz3A19H2Ms0F9Tcfezvw=;
	b=UFtEnUxMI5w6yU0PSy6hdCBdqi1ABSoYffGS/SRdtkDSfd9/0k2/yNiR9S6Z1i+EL38zff
	1AewcmeIfPAJhYqADX8j8rhJcXYTDw9bpizDnKwGoZY9f0PD3HYcwPIhRUxWVgbwa9Vk42
	P8adj23gQl2G7PAYAXQkRVQxSZj//oI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-7SsszYBaNyuf8eEOdxNvDA-1; Mon, 03 Mar 2025 09:34:25 -0500
X-MC-Unique: 7SsszYBaNyuf8eEOdxNvDA-1
X-Mimecast-MFC-AGG-ID: 7SsszYBaNyuf8eEOdxNvDA_1741012465
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf553044abso204187366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012464; x=1741617264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I34YFTmas2vrNzlk9v8DChrYz3A19H2Ms0F9Tcfezvw=;
        b=q0OLyf8rOxDOgAzlYO1+dPyOS0mJxs39HUa29qvX/JTMpTekFw2sL/ACDE0glaQ8hM
         wekA7RQ9CL16wnccSC1K/VHy7uubS4i9xUSeQy/0EI/PJiNCVBbYmzidLtg2Pt9uvJle
         zDyBl0mlbJ3yJdgWSHpOXVFmdWKXbYmcVqXq+5Vw8fRGg5cU6u8CnSANDPRk0Wzzu/yX
         fmpiRIbhMtsK3HRfm6Rb+fMBS6cF3IvhUmr2oQnvsIVIn6OHmciiOPIx0R+IB0QZpc4F
         nHUMApaibjssF+j63NTAFlTu8labr3gjKYCUkz3g2hKxRb2uKcgP1HkY+/txueKnBYLc
         sxSw==
X-Forwarded-Encrypted: i=1; AJvYcCUGnXngr38w9EMdR1NInWQPU6unelft6m2LeCb4swP6Pzxarrywy8f7yjk7GXk4F2YuXL57w2mygYnTCa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bvmtCxFX4hnvOrBBFf57CMwkvZWe/xSQ1iwTjeWVN5k7dNlK
	MGp5CrHbVbSck8m05+hpVYghojxe7oq6z+Hjo2BRc6+CVANsJJg8BSY4WQizw1NL7ZKeCP+zn7n
	lWrHr8kzgvo8MhLOAMoEZwEuXC1MF3gKkNIeYGjkeimltCscvLdkvHAuGxfMvcA==
X-Gm-Gg: ASbGncvqp+p3T6YWyk7/81GnE61PaA8Q05Tas+H3pMCt78aeH6TvFWrdZqZkokcdXdy
	t7Y+Gh9kMp7ZPoNZ6Oq+Qia/+JVIyI9uBJ5WJU2Fq+dVBFCKzobWocw6D2S0YJ8GPh4uzcsKgcb
	xqPoHzuVv64e3QwgI0Xy1DW2tfdlleDZPckTLfLn2h9JPr4X22YS0d7SFhjdFJD4Kp4jkGxyiSa
	5gfD+I+dQ5gEhW1mV5K3UrJlwP7lfOXwkCEegszZPOBpSni9qCvkirgCyX3zpJbIXG0dx7vRWkA
	l3jMb2foI+/CDjs4Zdg=
X-Received: by 2002:a17:907:3545:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-abf44b12416mr1013702566b.11.1741012464585;
        Mon, 03 Mar 2025 06:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGihIPNx7b5A2OG9AxeVc7V+cJcoZ0+m+poQG0Vt/bJ2O+YoX+CsSfZPuX7kYqgg+p9uOVxcQ==
X-Received: by 2002:a17:907:3545:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-abf44b12416mr1013700066b.11.1741012464138;
        Mon, 03 Mar 2025 06:34:24 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf4e50c80esm483595066b.61.2025.03.03.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:34:23 -0800 (PST)
Message-ID: <9ffc2b57-579e-46f8-83cd-a7d5cca15a42@redhat.com>
Date: Mon, 3 Mar 2025 15:34:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] media: uvcvideo: Increase/decrease the PM counter
 per IOCTL
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
 <20250226-uvc-granpower-ng-v4-3-3ec9be906048@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250226-uvc-granpower-ng-v4-3-3ec9be906048@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Feb-25 15:23, Ricardo Ribalda wrote:
> Now we call uvc_pm_get/put from the device open/close. This low
> level of granularity might leave the camera powered on in situations
> where it is not needed.
> 
> Increase the granularity by increasing and decreasing the Power
> Management counter per ioctl. There are two special cases where the
> power management outlives the ioctl: async controls and streamon. Handle
> those cases as well.
> 
> In a future patch, we will remove the uvc_pm_get/put from open/close.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c | 23 +++++++++++++++++++++--
>  drivers/media/usb/uvc/uvcvideo.h |  1 +
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4e58476d305e..47188c7f96c7 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1594,12 +1594,15 @@ static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
>  
>  		if (ctrl->handle) {
>  			WARN_ON(!ctrl->handle->pending_async_ctrls);
> -			if (ctrl->handle->pending_async_ctrls)
> +			if (ctrl->handle->pending_async_ctrls) {
>  				ctrl->handle->pending_async_ctrls--;
> +				uvc_pm_put(handle->chain->dev);
> +			}
>  		}
>  
>  		ctrl->handle = new_handle;
>  		handle->pending_async_ctrls++;
> +		uvc_pm_get(handle->chain->dev);
>  		return;
>  	}
>  
> @@ -1611,6 +1614,7 @@ static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
>  	if (WARN_ON(!handle->pending_async_ctrls))
>  		return;
>  	handle->pending_async_ctrls--;
> +	uvc_pm_put(handle->chain->dev);
>  }
>  
>  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> @@ -2815,6 +2819,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
>  void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
>  {
>  	struct uvc_entity *entity;
> +	int i;
>  
>  	guard(mutex)(&handle->chain->ctrl_mutex);
>  
> @@ -2829,7 +2834,11 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
>  		}
>  	}
>  
> -	WARN_ON(handle->pending_async_ctrls);
> +	if (!WARN_ON(handle->pending_async_ctrls))
> +		return;
> +
> +	for (i = 0; i < handle->pending_async_ctrls; i++)
> +		uvc_pm_put(handle->stream->dev);
>  }
>  
>  /*
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index de1e105f7263..1c9ac72be58a 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -691,6 +691,9 @@ static int uvc_v4l2_release(struct file *file)
>  	if (uvc_has_privileges(handle))
>  		uvc_queue_release(&stream->queue);
>  
> +	if (handle->is_streaming)
> +		uvc_pm_put(stream->dev);
> +
>  	/* Release the file handle. */
>  	uvc_dismiss_privileges(handle);
>  	v4l2_fh_del(&handle->vfh);
> @@ -857,6 +860,7 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>  		return ret;
>  
>  	handle->is_streaming = true;
> +	uvc_pm_get(stream->dev);
>  
>  	return 0;
>  }
> @@ -873,7 +877,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>  	guard(mutex)(&stream->mutex);
>  
>  	uvc_queue_streamoff(&stream->queue, type);
> -	handle->is_streaming = false;
> +	if (handle->is_streaming) {
> +		handle->is_streaming = false;
> +		uvc_pm_put(stream->dev);
> +	}
>  
>  	return 0;
>  }
> @@ -1410,6 +1417,8 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  	void __user *up = compat_ptr(arg);
>  	long ret;
>  
> +	guard(uvc_pm)(handle->stream->dev);
> +
>  	switch (cmd) {
>  	case UVCIOC_CTRL_MAP32:
>  		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
> @@ -1444,6 +1453,16 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  }
>  #endif
>  
> +static long uvc_v4l2_video_ioctl2(struct file *file,
> +				  unsigned int cmd, unsigned long arg)
> +{
> +	struct uvc_fh *handle = file->private_data;
> +
> +	guard(uvc_pm)(handle->stream->dev);
> +
> +	return video_ioctl2(file, cmd, arg);
> +}
> +
>  static ssize_t uvc_v4l2_read(struct file *file, char __user *data,
>  		    size_t count, loff_t *ppos)
>  {
> @@ -1529,7 +1548,7 @@ const struct v4l2_file_operations uvc_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= uvc_v4l2_open,
>  	.release	= uvc_v4l2_release,
> -	.unlocked_ioctl	= video_ioctl2,
> +	.unlocked_ioctl	= uvc_v4l2_video_ioctl2,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl32	= uvc_v4l2_compat_ioctl32,
>  #endif
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index fbe3649c7cd6..eb8e374fa4c5 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -766,6 +766,7 @@ void uvc_status_put(struct uvc_device *dev);
>  /* PM */
>  int uvc_pm_get(struct uvc_device *dev);
>  void uvc_pm_put(struct uvc_device *dev);
> +DEFINE_GUARD(uvc_pm, struct uvc_device *, uvc_pm_get(_T), uvc_pm_put(_T))
>  
>  /* Controls */
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
> 


