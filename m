Return-Path: <linux-kernel+bounces-541961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0779A4C3E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9852D7A9323
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C49213E6F;
	Mon,  3 Mar 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bmeo2b7t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C6212FA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013511; cv=none; b=MmMv5k4pBQHPLrarrtdf0rUnVSDk21ffkQMh5S+mXyx6qTUpdUeS+MeThP/PPcm5sxu4Pw3eovBHQaNDhJ/1KmzHRfLYpyE0OiznBk5dNJ1+ev9LpDxfgzUgEcxRIhFSH2PhJGjrHmFqpSCl9wkXizwhjYxSwZpJXyYjA9JEeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013511; c=relaxed/simple;
	bh=DkZ0ZU13h9unh67yYI41Mc2eoLM/G+sBDAukmgqAU6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtUuwjXSgMZFpcNPxA3r+qS4eUm4HmjhrkwgBp+RVnp33VaMsMLZccoRblSvXrqxTe7cyfCN87nlie3GjV7+KSBsEcxdSgcZ2WU1vkp6WCXy8767PP3FXoxEgO9gr6XoPCv/sethq6C0tCoHx3nBbldbULF5dctLONmgspJ0Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bmeo2b7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741013508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzyQeS/lmiZRfQTYNaKZi6MlPZQA4aSfZ3WWfK+EdyY=;
	b=Bmeo2b7tm5ce/tWcZ6AzYMDIxtem2lfGwXxoGPEWz5hJRp+HKif6+fAmJM66KRbVlzlHk0
	bvJeQXlYkUv45bR2GKwa5m2ZX61xu+rEoE94gONqvIEYPY2RY3v3540hN7XfFN/Nk4fH5u
	1nKPeT3BuQIaQEVtqRjWA6+rD2fzpZw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-zi57TJiOOqGxAQq6MY5q7A-1; Mon, 03 Mar 2025 09:51:42 -0500
X-MC-Unique: zi57TJiOOqGxAQq6MY5q7A-1
X-Mimecast-MFC-AGG-ID: zi57TJiOOqGxAQq6MY5q7A_1741013501
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e073b9cf96so4238721a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013501; x=1741618301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzyQeS/lmiZRfQTYNaKZi6MlPZQA4aSfZ3WWfK+EdyY=;
        b=iZT4sS304RmqgCv/3SDJDZzcZh3qYDgF0d9+/HGQNdWABkT2VMFYs8ykWBijs6PgCm
         Y7BFlJsJnHhLrCH8V2ll0QLdU1k+1+8xPS3LYENHGMEHT/MZWQ+6o3NOwndZAdgnkWMu
         ihabd3lb6kMk6/PLRy7y2RftgmNjishK0ielKdJ0UKnn5g6Bi/mN8ATUnDHr/xENPmv/
         GPXj+/jb5PWmwjtWY06Lp7wxvARIZRpf8U+kDyeygDKMRYjZxbmOrHQFbkfZGzg/7sb9
         tvyvjtWQO4npLEZDBptQoTX97RQveaFvOCY06Yx8Shej6XGg8JWMldgG4mpgWW3DIzfK
         a6kA==
X-Forwarded-Encrypted: i=1; AJvYcCVJxRgPtqX7hHkrXCuYg/9n+eQnNpoAY4RveqeBGycfVSHdWruk4YmRGieT5svbVeIuHofLQnUlddXe84E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjG0M2OsMVv9Chc23PtToB9GX2G9xMFiFe79zP8Xm0FfWv6J3
	onCUnJiYk59NnxipdPVBxjJF0W2yMUMdZytGJc/LJRsTTsaDL1m/lbD0jmt/iHwqo7lRrg6zUbY
	auXqE/mTG3mqCY3uMV54JIXYYrbGV5gWYaW9KAN5b3S/TM8lXoZZ0UAcdZkL/bg==
X-Gm-Gg: ASbGncvLtS7o0OMWHaAJk6n7RyjZKBl85zVE/xvMx0K75s16QXScwkwnGq733J/zASH
	65uq8fSvJMoKQTd4Zmz8EEu9H/GJjE1Ky3enJEVuGf13R5CWD+KTbZoIAGwR7/YyiiK7J1qCYFz
	LMotwuBFknrbRT/jsJ+piOAyDNVT9azZuystvZ/AlSVAtWpSu4o9rWoKMC2YIvH6rcq9GeRNks3
	hFMICeXhEq7WakOQIYLFZRuzp+UErwP/U0ysxD04JmUEoM/JBXLTfGtxQPKxYzMWOiYr9wD5Zgm
	tW2cpw6IYDmhf108wFk=
X-Received: by 2002:a05:6402:5247:b0:5de:e02a:89c1 with SMTP id 4fb4d7f45d1cf-5e4d6b62a7emr14619241a12.26.1741013501163;
        Mon, 03 Mar 2025 06:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQBXMOgL+HG0jccPl6+aG8dYZda1+GqG2MpgHoytE7nB1BqrhIyLiAJarjgZcWY5donAVpUA==
X-Received: by 2002:a05:6402:5247:b0:5de:e02a:89c1 with SMTP id 4fb4d7f45d1cf-5e4d6b62a7emr14619214a12.26.1741013500778;
        Mon, 03 Mar 2025 06:51:40 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa3bsm6905057a12.16.2025.03.03.06.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:51:40 -0800 (PST)
Message-ID: <a506c61b-41cd-4067-a358-a5c6e94427fb@redhat.com>
Date: Mon, 3 Mar 2025 15:51:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: uvcvideo: Return the number of processed
 controls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
 <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24-Feb-25 11:34, Ricardo Ribalda wrote:
> If we let know our callers that we have not done anything, they will be
> able to optimize their decisions.
> 
> Cc: stable@kernel.org
> Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4e58476d305e..f2484f6d21c1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1846,12 +1846,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
>  	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
>  }
>  
> +/*
> + * Returns the number of uvc controls that have been correctly set, or a
> + * negative number if there has been an error.
> + */
>  static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  				  struct uvc_fh *handle,
>  				  struct uvc_entity *entity,
>  				  int rollback,
>  				  struct uvc_control **err_ctrl)
>  {
> +	unsigned int processed_ctrls = 0;
>  	struct uvc_control *ctrl;
>  	unsigned int i;
>  	int ret;
> @@ -1886,6 +1891,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  		else
>  			ret = 0;
>  
> +		if (!ret)
> +			processed_ctrls++;
> +
>  		if (rollback || ret < 0)
>  			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
>  			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
> @@ -1904,7 +1912,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  			uvc_ctrl_set_handle(handle, ctrl, handle);
>  	}
>  
> -	return 0;
> +	return processed_ctrls;
>  }
>  
>  static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
> @@ -1951,6 +1959,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  
>  	if (!rollback)
>  		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
> +	ret = 0;
>  done:
>  	mutex_unlock(&chain->ctrl_mutex);
>  	return ret;
> 


