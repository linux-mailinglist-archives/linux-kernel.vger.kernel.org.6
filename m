Return-Path: <linux-kernel+bounces-437597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972D9E959E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39711670AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6DA22E3F1;
	Mon,  9 Dec 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewp17Gb7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2223872A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749091; cv=none; b=dU3RsP2cpk94O3xXhTJXPVnUF++1Zq8cODdntZUs693MV7uDw+cGMQKiZuoKEYjgn9YtSBKoDGLVXJRZM1cspbxuNmV+jxJv+xxPHAb6WBBSqecd9rZcALpHqEpWhf+LliFJN6uFUsVJKtrgac1R1CAC95dEgJjUn6LlEtVh954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749091; c=relaxed/simple;
	bh=+2GZ8Q59WH5eXt/MMZrNO01/XAhHKyIDnw7hJgMiy0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQkV3I3611kiFFWRec24ltUYbuATught8bnKv3KXbEhhYUAZVHvtMEMBlYg7NH2NPCUWwzazW3AG5jyT11GTC+2n67zqZQwGoXDnMQ5+J9PVgu3EfeVKzhQZ0jkQAusSa6TD5Wn7Ic8e9MwA4OAUHqTCtkNMHE8J/ztnU2NMPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ewp17Gb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbyC+igT/KTufsKy7S5I6bAyzZ+D5/fjrUElh2MRCIk=;
	b=Ewp17Gb7klHa+NjJiXhF2JgDp5Q9DnZZzC+DPkAoyYkPiLTUiZHfYj4UCi1gMkyxALmcIE
	Fu4FRWS38BIFRe8Z4M296GR+F3KK9vzW+sYRgxRB1wsfSzPPBE0QV1odT6iAK3gT3hIgK3
	6t5VV89Dq1+Zg21RrvEiOL8HY4jb0Nw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-2kMCphvGNUC7IUruTNXDRw-1; Mon, 09 Dec 2024 07:58:06 -0500
X-MC-Unique: 2kMCphvGNUC7IUruTNXDRw-1
X-Mimecast-MFC-AGG-ID: 2kMCphvGNUC7IUruTNXDRw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa64275c4f6so188259566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749085; x=1734353885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbyC+igT/KTufsKy7S5I6bAyzZ+D5/fjrUElh2MRCIk=;
        b=GxqaJM+9I7pw8BwM0/KtOaJVFKC9GRrehxrp9t9nzVYp6eznTaMyjh5IYBRvC90sv1
         DB/gyVa5LSp9GVVbkIovvpNIoLX8nVyMLtKCerODD6n+YuvVcBSino/8LfldmVyhFLA8
         OdfKzxLonZFyUv4USE9ozQHs/I5eGp+a7fyAxKkdyWgcB/FpZI2GPIVcqg2rWTKE+lAf
         qzfmR3f8yzp78/MNGcSoygqV3eqK/BrwpTuoXA1UVin/BpOBEtJ3TvC7PmkcC0l2yeOy
         ddWzebaMyywxRAaT9nCtSLgYsQj+VEM9xxu4eskebxiUo1sXiPYiH+QVRehoMkEJbbZn
         82Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUEjM/lKMc4G5tM75jCxWMNjfckAEqJkOUoWlt71exxSv9OE+HzeZKxYWofhYkN/cIm184NxAT5ZVcmdAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNkZBOSSSsOvqDRzu11WA1Sk40emZeIcbOKuSVemdTjp0vsM+
	mRZ3xR1wJ82hFtxNzSheOKBmAdYHl9nzmM8GXzn3LP+14Iee4Qnkaz/Uo4eCNQwYZJBDgZoGbtl
	6x2bPVfvYzSXsIZWYsr3DB6xENkhaBGgE/Ywu8tu7DDEpl3H4+E3rAt2exv0PFg==
X-Gm-Gg: ASbGncuPh/3tAXZm218SgdZFd1QLQUa6kqqOR6vgmkRyOnoK45JQVp2xQrSLcHp08Ep
	l4zYdxKmwJFVRoXnqvV7QE+sTc73KVr3Mhay3ORHj8bGRFWqKWgHDxDrnYVbPhTnz+yp+t6Nqwo
	x8tIh/xQyfArECzPomdZMwi8uoCkiw8yRTTKr7ViERpSmby+yW2k+UvCYyPNzJD3UGOaW3ELPmj
	4vmxBZ4S8AcmRazFyEuKMC8LWgs29AC1YwYv8OGroGN1+PBxV5hoQ==
X-Received: by 2002:a17:906:cc9:b0:aa6:6fa5:65b0 with SMTP id a640c23a62f3a-aa66fa5664emr485312366b.44.1733749085309;
        Mon, 09 Dec 2024 04:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvZTaOuUF113q1UE8eYW06UMVUuHznqmeMMI1F122LR/7rNdZV80yo5QnqQxKOBx0lBZD32w==
X-Received: by 2002:a17:906:cc9:b0:aa6:6fa5:65b0 with SMTP id a640c23a62f3a-aa66fa5664emr485281066b.44.1733749079681;
        Mon, 09 Dec 2024 04:57:59 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e96c19sm674717066b.42.2024.12.09.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:57:59 -0800 (PST)
Message-ID: <b20805a6-8ea7-472a-9fa6-a4f7cce6e868@redhat.com>
Date: Mon, 9 Dec 2024 13:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/19] media: uvcvideo: Factor out clamping from
 uvc_ctrl_set
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-10-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-10-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Move the logic to a separated function. Do not expect any change.
> This is a preparation for supporting compound controls.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 82 +++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 6d5167eb368d..893d12cd3f90 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2002,28 +2002,17 @@ int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
>  	return -EINVAL;
>  }
>  
> -int uvc_ctrl_set(struct uvc_fh *handle,
> -	struct v4l2_ext_control *xctrl)
> +static int uvc_ctrl_clamp(struct uvc_video_chain *chain,
> +			  struct uvc_control *ctrl,
> +			  struct uvc_control_mapping *mapping,
> +			  s32 *value_in_out)
>  {
> -	struct uvc_video_chain *chain = handle->chain;
> -	struct uvc_control *ctrl;
> -	struct uvc_control_mapping *mapping;
> -	s32 value;
> +	s32 value = *value_in_out;
>  	u32 step;
>  	s32 min;
>  	s32 max;
>  	int ret;
>  
> -	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
> -		return -EACCES;
> -
> -	ctrl = uvc_find_control(chain, xctrl->id, &mapping);
> -	if (ctrl == NULL)
> -		return -EINVAL;
> -	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> -		return -EACCES;
> -
> -	/* Clamp out of range values. */
>  	switch (mapping->v4l2_type) {
>  	case V4L2_CTRL_TYPE_INTEGER:
>  		if (!ctrl->cached) {
> @@ -2041,14 +2030,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		if (step == 0)
>  			step = 1;
>  
> -		xctrl->value = min + DIV_ROUND_CLOSEST((u32)(xctrl->value - min),
> -							step) * step;
> +		value = min + DIV_ROUND_CLOSEST((u32)(value - min), step) * step;
>  		if (mapping->data_type == UVC_CTRL_DATA_TYPE_SIGNED)
> -			xctrl->value = clamp(xctrl->value, min, max);
> +			value = clamp(value, min, max);
>  		else
> -			xctrl->value = clamp_t(u32, xctrl->value, min, max);
> -		value = xctrl->value;
> -		break;
> +			value = clamp_t(u32, value, min, max);
> +		*value_in_out = value;
> +		return 0;
>  
>  	case V4L2_CTRL_TYPE_BITMASK:
>  		if (!ctrl->cached) {
> @@ -2057,21 +2045,20 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  				return ret;
>  		}
>  
> -		xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
> -		value = xctrl->value;
> -		break;
> +		value &= uvc_get_ctrl_bitmap(ctrl, mapping);
> +		*value_in_out = value;
> +		return 0;
>  
>  	case V4L2_CTRL_TYPE_BOOLEAN:
> -		xctrl->value = clamp(xctrl->value, 0, 1);
> -		value = xctrl->value;
> -		break;
> +		*value_in_out = clamp(value, 0, 1);
> +		return 0;
>  
>  	case V4L2_CTRL_TYPE_MENU:
> -		if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
> -		    xctrl->value > (fls(mapping->menu_mask) - 1))
> +		if (value < (ffs(mapping->menu_mask) - 1) ||
> +		    value > (fls(mapping->menu_mask) - 1))
>  			return -ERANGE;
>  
> -		if (!test_bit(xctrl->value, &mapping->menu_mask))
> +		if (!test_bit(value, &mapping->menu_mask))
>  			return -EINVAL;
>  
>  		/*
> @@ -2079,8 +2066,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		 * UVC controls that support it.
>  		 */
>  		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
> -			int val = uvc_mapping_get_menu_value(mapping,
> -							     xctrl->value);
> +			int val = uvc_mapping_get_menu_value(mapping, value);
>  			if (!ctrl->cached) {
>  				ret = uvc_ctrl_populate_cache(chain, ctrl);
>  				if (ret < 0)
> @@ -2090,14 +2076,34 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & val))
>  				return -EINVAL;
>  		}
> -		value = xctrl->value;
> -		break;
> +		return 0;
>  
>  	default:
> -		value = xctrl->value;
> -		break;
> +		return 0;
>  	}
>  
> +	return 0;
> +}
> +
> +int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl)
> +{
> +	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_control_mapping *mapping;
> +	struct uvc_control *ctrl;
> +	int ret;
> +
> +	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
> +		return -EACCES;
> +
> +	ctrl = uvc_find_control(chain, xctrl->id, &mapping);
> +	if (!ctrl)
> +		return -EINVAL;
> +	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> +		return -EACCES;
> +
> +	ret = uvc_ctrl_clamp(chain, ctrl, mapping, &xctrl->value);
> +	if (ret)
> +		return ret;
>  	/*
>  	 * If the mapping doesn't span the whole UVC control, the current value
>  	 * needs to be loaded from the device to perform the read-modify-write
> @@ -2116,7 +2122,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		       ctrl->info.size);
>  	}
>  
> -	uvc_mapping_set_s32(mapping, value,
> +	uvc_mapping_set_s32(mapping, xctrl->value,
>  			    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> 


