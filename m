Return-Path: <linux-kernel+bounces-542106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194CA4C5BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8083AA71E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FE214A76;
	Mon,  3 Mar 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6tE/BIx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D11F4166
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017071; cv=none; b=o+140XfRGrwqyYuwGfviHNf2ZPe7qtcons3fYshZ6uooVJA1ViwJLQ19tWO8HT2jUxswnbK7jfLaNthF3+AKDamvPWDXki+yCuENxs7LF+c6baoSTEzXFet0i3EpMW8K9CYr78oPnbdmgWCjvNYBI1sNjLkBKJLg+kw/jZmx9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017071; c=relaxed/simple;
	bh=Q5kJVVC8kNtwYQqA9BcK86Gbrof3EdqlcoliQevVwto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EstdwqAVs27MPw5C6ivkxkireUIg9en3njQgm7rxGUtD9YxwuOtqGs1GMU9oTDKZIK2RWjSMYZ2fpkBrQN5Bct9busAiz6iFLAjaBL6fHyW8MTZjeCKiFqPJ+zOEFEPFeKlq6ZVJURAkZnIqBbOozsbRKwEnu9yuL3083igv19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6tE/BIx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dNvNAyHU5G5gygWRGJlXArKYYYBxB4wqYDMvVSBxrQ=;
	b=f6tE/BIx6YvdY8NS34AIstp28Z5gdBE8kUSFnp1ILnXgo+t6r+AFTb1eeGzRoDH//n0fTN
	GrK7AlBzvZo1wEDeu+PTgZbc6cdfv4PDt+WFOQVwlHo3tcQERSsZdDfKdJTpLrYBF1Mu4r
	oFs/WYuXUa5Q5973iokIs9YtVZQ4eL4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-CjCOb_IMMDu84UEqdqTAPg-1; Mon, 03 Mar 2025 10:50:57 -0500
X-MC-Unique: CjCOb_IMMDu84UEqdqTAPg-1
X-Mimecast-MFC-AGG-ID: CjCOb_IMMDu84UEqdqTAPg_1741017056
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so4830971a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017056; x=1741621856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dNvNAyHU5G5gygWRGJlXArKYYYBxB4wqYDMvVSBxrQ=;
        b=TR0kNbwTijVZ0d/8w2f2hTO10hxlQuvwamozZSJWN+D6pCImwpKuUYeGOeQPPZhE30
         hfLZC2h6ptv59UCPhg6GeyiVGzYB7kAv5xBKiYlwRfO+jVbojK5F87gfnDTnr9dQG7UD
         fISfiHzMYqYXvKvzFONNPEVwJuZYty2Lk7rtp1Qli1aoyhD/4pk1SP/M384MFx6Wc32w
         DSyaIasBpiUVM30XicaKUC3krAIPqKYlXIAdEQiDGKm2kGVsoJnyyJ2kUh3iJmz9BhXE
         ZbVGlw8QDHVyK7G42GsJad65pI8woNUpapXmJcpwphGbIGOCF/nviu1pGIT77uSLXEol
         f24Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwgyTNIvXiuyruFQPdK2DrmE4JT1OYQzSR5V3isMzg8A+o02ymlq89LZvOBEqqEN5tZaiIkON25vwWyZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+AYXFwyMmROvJO9xmwuDhQSeocZKfobjonP8EnUz1rShGecH
	v47dpxUIWUJseX5Y7gjL262AlOnGG5RnznIB1o6mE2oeatzSn4QnpSYgHSnCPBkKEMmlSwekcg9
	IpcqBlX8PDjjlp2o55m33Jv2Jw3L+NVUZ5hNJJb8LJiThvIqNM0uABPuNwxX6NA==
X-Gm-Gg: ASbGnctLBRE2XNLQd/6A9+CFSIiSDyOBiK4IEC5PP4lJaCgmxTWEgef60qEI9+fQ+jP
	tyO+6txGnoauhqah5iZHJFcsroryppnFHZT5n2Mu1LlpCqUmg8vbq8CBAPyApu6Epqm6S8L2BmK
	C6+/e4N7HlyJx73k+cFtpJHDk+YOBVs5tRNqcM36Yns+XSogLChQRo1c+/Vf4+ZUSSbrdEjW9QS
	T+mYQ68QOjy5Oc5nwNO/UKcgLuB03elNlE8kJk3qXNqSTEsSbiFmmjwQoPTHwMYw8HqdkEgLmz4
	EfiwCRFpGI6xujYg6Cs=
X-Received: by 2002:a05:6402:40d1:b0:5e0:87eb:956b with SMTP id 4fb4d7f45d1cf-5e4d6b68f0dmr12880984a12.22.1741017056302;
        Mon, 03 Mar 2025 07:50:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpG/UQJz56LDbfAhf/kiJEcE14KnocWAUI5oNLuJ5COA4PPwaqHlXug2SOBV0xP2U4dgeukw==
X-Received: by 2002:a05:6402:40d1:b0:5e0:87eb:956b with SMTP id 4fb4d7f45d1cf-5e4d6b68f0dmr12880963a12.22.1741017055914;
        Mon, 03 Mar 2025 07:50:55 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e533a89a21sm3099850a12.60.2025.03.03.07.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:50:55 -0800 (PST)
Message-ID: <2cd42ab9-8079-4bd6-b650-42c2e894592a@redhat.com>
Date: Mon, 3 Mar 2025 16:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: uvcvideo: Send control events for partial
 succeeds
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
 <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24-Feb-25 11:34, Ricardo Ribalda wrote:
> Today, when we are applying a change to entities A, B. If A succeeds and B
> fails the events for A are not sent.
> 
> This change changes the code so the events for A are send right after
> they happen.
> 
> Cc: stable@kernel.org
> Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index f2484f6d21c1..7d074686eef4 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1705,7 +1705,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
>  }
>  
>  static void uvc_ctrl_send_events(struct uvc_fh *handle,
> -	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
> +				 struct uvc_entity *entity,
> +				 const struct v4l2_ext_control *xctrls,
> +				 unsigned int xctrls_count)
>  {
>  	struct uvc_control_mapping *mapping;
>  	struct uvc_control *ctrl;
> @@ -1716,6 +1718,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
>  		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
>  
>  		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
> +		if (ctrl->entity != entity)
> +			continue;
> +
>  		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
>  			/* Notification will be sent from an Interrupt event. */
>  			continue;
> @@ -1954,11 +1959,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  					uvc_ctrl_find_ctrl_idx(entity, ctrls,
>  							       err_ctrl);
>  			goto done;
> +		} else if (ret > 0 && !rollback) {
> +			uvc_ctrl_send_events(handle, entity,
> +					     ctrls->controls, ctrls->count);
>  		}
>  	}
>  
> -	if (!rollback)
> -		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
>  	ret = 0;
>  done:
>  	mutex_unlock(&chain->ctrl_mutex);
> 


