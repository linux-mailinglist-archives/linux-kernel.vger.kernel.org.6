Return-Path: <linux-kernel+bounces-541881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED7A4C2DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198C93A7C66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2D213257;
	Mon,  3 Mar 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq/H2Whv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08D21322F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010850; cv=none; b=Fi0PgKe3zmBjQpsZma8XDd/MBhOY0RtLmQMCIZemR1GESiXpWdFt7sN7SVQZhR0XUtFgdwehU1VyeqUDlL5uYk0MT0xl1/W+mCvtXuZIT+/b+OJOPbta1rOwPMYoMdQ6U1ulpQLMnKPIt3md8AeJkfLGPJGwCwIiqnJUXBGic7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010850; c=relaxed/simple;
	bh=8sxbX5O26w5xPQxkxTSVAiTsZlfgUWGK53dYCGtXYu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2LqzwLHqPjFcnj//4MJy8hz0RHoV3VbztlUouOWNWS8aUzLfhR+PNkUOoXx3KDBp0Q3SGEPY9pmOg8yYFD9qYSO05CBdKTGFlp7H0KtjpuPkhveZV/a7zWyQKa+eUrjiveejERGjjSenzodnNYqYFTx3swG2s+W2oI7IL+DVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hq/H2Whv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741010847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/jz82WLxz2AXnyirtjFiRLnkqi5Gdqp332HU/uapU0=;
	b=hq/H2WhvxDO9aejvt3V1914vBiUD7ec9sUR0OJtww8DwJtUKbdMbPiHK+KIxG5XO3y4Gtw
	bAZFxbQeQHGvko4cBs4SJhyUdVfYJcbFVZyRXf9JP2ef2JBZ0ZT7FByoELeOiwHHnqTkeV
	RkV1YsYaduHz6AHWDXyrJkb7jhuf93g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-2nLfUmA9OQeeUS8OSpprcQ-1; Mon, 03 Mar 2025 09:07:25 -0500
X-MC-Unique: 2nLfUmA9OQeeUS8OSpprcQ-1
X-Mimecast-MFC-AGG-ID: 2nLfUmA9OQeeUS8OSpprcQ_1741010845
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac1e109f006so81479566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010844; x=1741615644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/jz82WLxz2AXnyirtjFiRLnkqi5Gdqp332HU/uapU0=;
        b=nygLAK21FTGrQueje0QunqPEdNh2y9EQF6a7K5V45tGwhShAzcWDNOoAqETUvVfHRP
         YYhVDqkAAjx0avuDgRHczGU8Rv4lGcnKIL/mROOR8ZiXhNNbMCe0aqcn5xzhjq1czt8n
         im5sUU3zkIt9cGSNeErkGxM4Y0yUzxh7ulhtatwEra4tS0KXnG8pRjAlvANkOkU3NnXO
         L90QT1YPHb2PeH2d+LJhxcQjR89Gw8am6qsoWKiKI7ig/qD/4qW/U5dOm/CUyLSvzuX4
         4H4yIkkJzqeVzpD/7yyuthArmNeeq8+4oalNTRoW8sNRI7T/0MxKb9h9Jq/R6O75Teeg
         BD8g==
X-Forwarded-Encrypted: i=1; AJvYcCWSzZ+/aC4nbEiisKuzs2HjJijN/AJhD2DWO++FFdmrSjlmd0B1ClAvYEzC6jSuQlluo4bhqtc36ynyedc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZuepASpfTiB0Ul1RFQD9e9Lbk0HKMjBw1/vqsqL1pcDJxb5c
	DSxs45ol9ZbZS3vHH9zpaaXlm8RMXuf8THUDiH2Y0xCOtgB6PwtYu1dNqtXKvt0j+FwOYtB/xvB
	h7HBnFPZfTNio2vtNe1jkx86u2JAOYqCfFv9/3UpIaPYc89mRmdSYWmUmSJp6aQ==
X-Gm-Gg: ASbGncv+my6/ej7b+eWwbXM2LRWC9tJ31kEGOC+m6kRx1d/9P7A/tmmuGloXVJ+4C4I
	V8eSBsQ4n2kxLokDKW8icbCr+47y/N72+mVoIjO8r2E2eA5KpWGWLB38NBtwX3IDWwz934Weq0Z
	f3yztdX5PEHrOzVBdzzSkC5+apz0lnDi7ZLkpS7oxqRLP8up49VSdKR1/ZY0N9i0f6Xg0LQ01PB
	zX3IeeMfsHRiUpqgxh2vOSlI0Wfw+o4MQ0XKXTc4IWbYB39fXmkKhbiX/xwg/QHYr1je+mdD2+O
	O8iGU79V7pryV4tw6hg=
X-Received: by 2002:a17:907:3f9a:b0:ab7:8079:78ae with SMTP id a640c23a62f3a-abf265e9bcfmr1589132466b.44.1741010844560;
        Mon, 03 Mar 2025 06:07:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBD8Aj0BpxaGnvRgtUOdfzwUMqZL2wprJlFC35LC4uCN781yYjf3zsY7UYORaHX540v0YrEw==
X-Received: by 2002:a17:907:3f9a:b0:ab7:8079:78ae with SMTP id a640c23a62f3a-abf265e9bcfmr1589125666b.44.1741010844028;
        Mon, 03 Mar 2025 06:07:24 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6348394dsm357844666b.63.2025.03.03.06.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:07:23 -0800 (PST)
Message-ID: <3b64dbbb-d5b4-4813-9dce-aa6e361133cf@redhat.com>
Date: Mon, 3 Mar 2025 15:07:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] media: uvcvideo: Keep streaming state in the file
 handle
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
 <20250226-uvc-granpower-ng-v4-1-3ec9be906048@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250226-uvc-granpower-ng-v4-1-3ec9be906048@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Feb-25 15:23, Ricardo Ribalda wrote:
> Add a variable in the file handle state to figure out if a camera is in
> the streaming state or not. This variable will be used in the future for
> power management policies.
> 
> Now that we are at it, make use of guards to simplify the code.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 18 +++++++++++++-----
>  drivers/media/usb/uvc/uvcvideo.h |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 93c6cdb23881..f9cd6db759c5 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -835,11 +835,18 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>  	if (!uvc_has_privileges(handle))
>  		return -EBUSY;
>  
> -	mutex_lock(&stream->mutex);
> +	guard(mutex)(&stream->mutex);
> +
> +	if (handle->is_streaming)
> +		return 0;
> +
>  	ret = uvc_queue_streamon(&stream->queue, type);
> -	mutex_unlock(&stream->mutex);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	handle->is_streaming = true;
> +
> +	return 0;
>  }
>  
>  static int uvc_ioctl_streamoff(struct file *file, void *fh,
> @@ -851,9 +858,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>  	if (!uvc_has_privileges(handle))
>  		return -EBUSY;
>  
> -	mutex_lock(&stream->mutex);
> +	guard(mutex)(&stream->mutex);
> +
>  	uvc_queue_streamoff(&stream->queue, type);
> -	mutex_unlock(&stream->mutex);
> +	handle->is_streaming = false;
>  
>  	return 0;
>  }
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 5e388f05f3fc..bc87e1f2c669 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -618,6 +618,7 @@ struct uvc_fh {
>  	struct uvc_streaming *stream;
>  	enum uvc_handle_state state;
>  	unsigned int pending_async_ctrls;
> +	bool is_streaming;
>  };
>  
>  struct uvc_driver {
> 


