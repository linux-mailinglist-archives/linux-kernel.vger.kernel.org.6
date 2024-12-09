Return-Path: <linux-kernel+bounces-437548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186209E94CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FC0280C93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EEF227581;
	Mon,  9 Dec 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjUF05FN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEB2163B5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748581; cv=none; b=J3dKMnwgu76BSmGcidzrAR+VxEmCTtHbMZKQmAgRLybj4oaKuxSH9/rvNyZgPECUMvxDorSnkQlRZU7J/PLSqsoS0x9BgqusE14uOIUa0znYfvyC/rROyaOQ5PAU8pdO5rYrA0ggwCBZ5ZhMtQ+LGpWJKEo10jp/42El+3FB/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748581; c=relaxed/simple;
	bh=/MxgLdkD0qg3Ljt/CuyTna9gd3FB2VixMTv8EfaNBbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUCEl3H3XUVj9Q0WrQ0l1qaysVuk2GBBhOMMCP2dlCZHn7rAZAM8z0D2JyW+T/wtAe2c4MyY1PcGMrRdZp5gNtyHUiLZMLqXbO7VvJrKojIwFwMVE5QQlm+bEDN6wDSYbhb7yR2XRRp4OCoOulhRRrzIUj+uBcOkGH2BrzcSFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjUF05FN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733748578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZZGCuMgAMmR3fg219v2vXNHMIdyHit6IOGYXSUhW4A=;
	b=IjUF05FNt82ncZIi2hJh5kbScUMPVHHotOA/40RTHbhBfRzx29tbcvX6DAok9R+v2wrj10
	IKSgFuk9Kcx+4BehZEvqxQo+VUDUrRP3lmw1Dzk6ORzk06RxIbxeGjh35FuC1McD6S/Mz8
	3wMpa5BUfQKBFmDkDog0RGkMrIWCbg4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Vkpyd7-xNoq9FCvGgNTAHw-1; Mon, 09 Dec 2024 07:49:35 -0500
X-MC-Unique: Vkpyd7-xNoq9FCvGgNTAHw-1
X-Mimecast-MFC-AGG-ID: Vkpyd7-xNoq9FCvGgNTAHw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa680c6aa0eso117584566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748574; x=1734353374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZZGCuMgAMmR3fg219v2vXNHMIdyHit6IOGYXSUhW4A=;
        b=t3Tl2u75U/XwxLG4sBpioGc3s9uhL47XK55+ACOMlJRn2rzCWq+1jnZiFhu8+WsF6T
         RwXaQcjqm53qrQQY0hTpzASTtB40q4w3LuiT+8M4qfZ9bMLcjKHm+RuWiOCZQSoLz8oU
         2Hj8jRCsU8WXW11Qoqpj3fzmefxG25hlW7kNEth3n60malGPU050NYO8rm2WMwoDzrYI
         CmFzd9bmdcIKlZ2XTDSBTz9cmDk90y4YQ5Yy4JWPnWn8XxPLpE3yWS8zGq1w5WZFLfza
         nOFo/I8q3P+/UHBKVlz8MEw4ts01ZPJ0il+AwH0yLvSDydWWcAg2aHaChRLW6iCuZ8eH
         OybA==
X-Forwarded-Encrypted: i=1; AJvYcCVodTJmcokTi6gV/d8Y4kRV6lHFaw5uCflkh27/rl9/B0FfJrRPAz98+Kofr+JNP8GEbNHSMrGYw1HmaLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHbGTLXc7R1NTj4nQOtdeLFFJtWJvNALCFLuZVmES5G1JXyZJ
	SE+rRrqQrJqO2Istrsp6U8YhOJyg3UPiyu6pXB7rcbaQGRWqGJ4JTSixqrlBIC1V5CSlFvQ851a
	+QSdGlMaj/hMAPaO50DQ3iF3S5iwNmyH/YhvnXsj95W0zQ+WPs04Tg21w4zYgJQ==
X-Gm-Gg: ASbGncvV4tGn3URv5/xiAJ0oOCN5UVouSXyuN8niZ08Rlol1F//rfBRvwUH+gna8ARl
	63QyXAn8gZcpRIVAXjtCnoGNmsHNqHPiglJ5zO9XNgFFa8mf2ZW+JOn0DYFdGmbC7iJFH+ZCxuD
	XuZM4UJ4HiFLm+vA4z7VqjxpZ5eIHNCj75Hz2VG0Md8aUJ5p5Jl2xL+bQn88b6Cw1JyiSFOda2d
	qHQEgvcKwDSbCFL9dtzv1PP8iTJU0Ms44/WjGHSXHLqsJ39xeMAGg==
X-Received: by 2002:a17:906:3d21:b0:aa6:32f9:d1a7 with SMTP id a640c23a62f3a-aa63a20839amr1056555366b.38.1733748574158;
        Mon, 09 Dec 2024 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzTOakG66cbeggGu91NN0gFJvxgpqXsiQxcwB5vGxcUhkPxpW6uz4k9HHBj0SG3IVg5HkWNg==
X-Received: by 2002:a17:906:3d21:b0:aa6:32f9:d1a7 with SMTP id a640c23a62f3a-aa63a20839amr1056552266b.38.1733748573640;
        Mon, 09 Dec 2024 04:49:33 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa677c4970bsm249618366b.112.2024.12.09.04.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:49:33 -0800 (PST)
Message-ID: <2c095d07-739f-4e9d-ac71-ba484bfe2a4d@redhat.com>
Date: Mon, 9 Dec 2024 13:49:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/19] media: uvcvideo: Support any size for mapping
 get/set
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-9-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-9-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Right now, we only support mappings for v4l2 controls with a max size of
> s32. This patch modifies the prototype of get/set so it can support any
> size.
> 
> This is done to prepare for compound controls.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 183 +++++++++++++++++++++++++++------------
>  drivers/media/usb/uvc/uvcvideo.h |   8 +-
>  2 files changed, 130 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index d6afa131a5e1..6d5167eb368d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -367,6 +367,22 @@ static const u32 uvc_control_classes[] = {
>  
>  static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
>  
> +static s32 uvc_mapping_get_s32(struct uvc_control_mapping *mapping,
> +			       u8 query, const void *data_in)
> +{
> +	s32 data_out;
> +
> +	mapping->get(mapping, query, data_in, sizeof(data_out), &data_out);

If mapping->get() fails, e.g. hits the -EINVAL path in uvc_ctrl_get_zoom()
then this will return the uninitialized data_out.

I realize that this is supposed to never happen and adding error-handling
here would not be helpful since there is no way to return an error-code
without changing the function prototype.

But I think you should at least initialize data_out to 0 to avoid leaking
stack-memory contents to userspace if we somehow do manage to hit this.


> +
> +	return data_out;
> +}
> +
> +static void uvc_mapping_set_s32(struct uvc_control_mapping *mapping,
> +				s32 data_in, void *data_out)
> +{
> +	mapping->set(mapping, sizeof(data_in), &data_in, data_out);
> +}
> +
>  /*
>   * This function translates the V4L2 menu index @idx, as exposed to userspace as
>   * the V4L2 control value, to the corresponding UVC control value used by the
> @@ -405,58 +421,93 @@ uvc_mapping_get_menu_name(const struct uvc_control_mapping *mapping, u32 idx)
>  	return v4l2_ctrl_get_menu(mapping->id)[idx];
>  }
>  
> -static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
> -	u8 query, const u8 *data)
> +static int uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping, u8 query,
> +			     const void *uvc_in, size_t v4l2_size,
> +			     void *v4l2_out)
>  {
> -	s8 zoom = (s8)data[0];
> +	u8 value = ((u8 *)uvc_in)[2];
> +	s8 sign = ((s8 *)uvc_in)[0];
> +	s32 *out = v4l2_out;
> +
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
>  
>  	switch (query) {
>  	case UVC_GET_CUR:
> -		return (zoom == 0) ? 0 : (zoom > 0 ? data[2] : -data[2]);
> +		*out = (sign == 0) ? 0 : (sign > 0 ? value : -value);
> +		return 0;
>  
>  	case UVC_GET_MIN:
>  	case UVC_GET_MAX:
>  	case UVC_GET_RES:
>  	case UVC_GET_DEF:
>  	default:
> -		return data[2];
> +		*out = value;
> +		return 0;
>  	}
>  }
>  
> -static void uvc_ctrl_set_zoom(struct uvc_control_mapping *mapping,
> -	s32 value, u8 *data)
> +static int uvc_ctrl_set_zoom(struct uvc_control_mapping *mapping,
> +			     size_t v4l2_size, const void *v4l2_in,
> +			     void *uvc_out)
>  {
> -	data[0] = value == 0 ? 0 : (value > 0) ? 1 : 0xff;
> -	data[2] = min((int)abs(value), 0xff);
> +	u8 *out = uvc_out;
> +	s32 value;
> +
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
> +
> +	value = *(u32 *)v4l2_in;
> +	out[0] = value == 0 ? 0 : (value > 0) ? 1 : 0xff;
> +	out[2] = min_t(int, abs(value), 0xff);
> +
> +	return 0;
>  }
>  
> -static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
> -	u8 query, const u8 *data)
> +static int uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
> +				  u8 query, const void *uvc_in,
> +				  size_t v4l2_size, void *v4l2_out)
>  {
>  	unsigned int first = mapping->offset / 8;
> -	s8 rel = (s8)data[first];
> +	u8 value = ((u8 *)uvc_in)[first + 1];
> +	s8 sign = ((s8 *)uvc_in)[first];
> +	s32 *out = v4l2_out;
> +
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
>  
>  	switch (query) {
>  	case UVC_GET_CUR:
> -		return (rel == 0) ? 0 : (rel > 0 ? data[first+1]
> -						 : -data[first+1]);
> +		*out = (sign == 0) ? 0 : (sign > 0 ? value : -value);
> +		return 0;
>  	case UVC_GET_MIN:
> -		return -data[first+1];
> +		*out = -value;
> +		return 0;
>  	case UVC_GET_MAX:
>  	case UVC_GET_RES:
>  	case UVC_GET_DEF:
>  	default:
> -		return data[first+1];
> +		*out = value;
> +		return 0;
>  	}
>  }
>  
> -static void uvc_ctrl_set_rel_speed(struct uvc_control_mapping *mapping,
> -	s32 value, u8 *data)
> +static int uvc_ctrl_set_rel_speed(struct uvc_control_mapping *mapping,
> +				  size_t v4l2_size, const void *v4l2_in,
> +				  void *uvc_out)
>  {
>  	unsigned int first = mapping->offset / 8;
> +	u8 *out = uvc_out;
> +	s32 value;
> +
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
>  
> -	data[first] = value == 0 ? 0 : (value > 0) ? 1 : 0xff;
> -	data[first+1] = min_t(int, abs(value), 0xff);
> +	value = *(u32 *)v4l2_in;
> +	out[first] = value == 0 ? 0 : (value > 0) ? 1 : 0xff;
> +	out[first + 1] = min_t(int, abs(value), 0xff);
> +
> +	return 0;
>  }
>  
>  static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> @@ -887,14 +938,20 @@ static s32 uvc_menu_to_v4l2_menu(struct uvc_control_mapping *mapping, s32 val)
>   * a signed 32bit integer. Sign extension will be performed if the mapping
>   * references a signed data type.
>   */
> -static s32 uvc_get_le_value(struct uvc_control_mapping *mapping,
> -	u8 query, const u8 *data)
> +static int uvc_get_le_value(struct uvc_control_mapping *mapping,
> +			    u8 query, const void *uvc_in, size_t v4l2_size,
> +			    void *v4l2_out)
>  {
> -	int bits = mapping->size;
>  	int offset = mapping->offset;
> +	int bits = mapping->size;
> +	const u8 *data = uvc_in;
> +	s32 *out = v4l2_out;
>  	s32 value = 0;
>  	u8 mask;
>  
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
> +
>  	data += offset / 8;
>  	offset &= 7;
>  	mask = ((1LL << bits) - 1) << offset;
> @@ -916,29 +973,40 @@ static s32 uvc_get_le_value(struct uvc_control_mapping *mapping,
>  		value |= -(value & (1 << (mapping->size - 1)));
>  
>  	/* If it is a menu, convert from uvc to v4l2. */
> -	if (mapping->v4l2_type != V4L2_CTRL_TYPE_MENU)
> -		return value;
> +	if (mapping->v4l2_type != V4L2_CTRL_TYPE_MENU) {
> +		*out = value;
> +		return 0;
> +	}
>  
>  	switch (query) {
>  	case UVC_GET_CUR:
>  	case UVC_GET_DEF:
> -		return uvc_menu_to_v4l2_menu(mapping, value);
> +		*out = uvc_menu_to_v4l2_menu(mapping, value);
> +		return 0;
>  	}
>  
> -	return value;
> +	*out = value;
> +	return 0;
>  }
>  
>  /*
>   * Set the bit string specified by mapping->offset and mapping->size
>   * in the little-endian data stored at 'data' to the value 'value'.
>   */
> -static void uvc_set_le_value(struct uvc_control_mapping *mapping,
> -	s32 value, u8 *data)
> +static int uvc_set_le_value(struct uvc_control_mapping *mapping,
> +			    size_t v4l2_size, const void *v4l2_in,
> +			    void *uvc_out)
>  {
> -	int bits = mapping->size;
>  	int offset = mapping->offset;
> +	int bits = mapping->size;
> +	u8 *data = uvc_out;
> +	s32 value;
>  	u8 mask;
>  
> +	if (WARN_ON(v4l2_size != sizeof(s32)))
> +		return -EINVAL;
> +
> +	value = *(s32 *)v4l2_in;
>  	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU)
>  		value = uvc_mapping_get_menu_value(mapping, value);
>  	/*
> @@ -960,6 +1028,8 @@ static void uvc_set_le_value(struct uvc_control_mapping *mapping,
>  		bits -= 8 - offset;
>  		offset = 0;
>  	}
> +
> +	return 0;
>  }
>  
>  /* ------------------------------------------------------------------------
> @@ -1141,8 +1211,8 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
>  	if (ret < 0)
>  		return ret;
>  
> -	*value = mapping->get(mapping, UVC_GET_CUR,
> -			      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> +	*value = uvc_mapping_get_s32(mapping, UVC_GET_CUR,
> +				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
>  	return 0;
>  }
> @@ -1275,12 +1345,12 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
>  	 * as supported.
>  	 */
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> -		return mapping->get(mapping, UVC_GET_RES,
> -				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> +		return uvc_mapping_get_s32(mapping, UVC_GET_RES,
> +					   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> -		return mapping->get(mapping, UVC_GET_MAX,
> -				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +		return uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> +					   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>  
>  	return ~0;
>  }
> @@ -1324,10 +1394,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  			return ret;
>  	}
>  
> -	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
> -		v4l2_ctrl->default_value = mapping->get(mapping, UVC_GET_DEF,
> -				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> -	}
> +	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
> +		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
> +				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
>  
>  	switch (mapping->v4l2_type) {
>  	case V4L2_CTRL_TYPE_MENU:

The dropping of the { } here seems to be an unrelated code style change, please
drop this.


> @@ -1359,16 +1428,16 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  	}
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> -		v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +		v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> +				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> -		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +		v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> +				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> -		v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
> -				  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> +		v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> +				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>  
>  	return 0;
>  }
> @@ -1581,7 +1650,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>  	ctrl->handle = NULL;
>  
>  	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> -		s32 value = mapping->get(mapping, UVC_GET_CUR, data);
> +		s32 value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
>  
>  		/*
>  		 * handle may be NULL here if the device sends auto-update
> @@ -1925,8 +1994,8 @@ int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
>  			if (ret < 0)
>  				return ret;
>  		}
> -		xctrl->value = mapping->get(mapping, UVC_GET_DEF,
> -					    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> +		xctrl->value = uvc_mapping_get_s32(mapping, UVC_GET_DEF,
> +						   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
>  		return 0;
>  	}
>  
> @@ -1963,12 +2032,12 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  				return ret;
>  		}
>  
> -		min = mapping->get(mapping, UVC_GET_MIN,
> -				   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> -		max = mapping->get(mapping, UVC_GET_MAX,
> -				   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> -		step = mapping->get(mapping, UVC_GET_RES,
> -				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> +		min = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> +					  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +		max = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> +					  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +		step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> +					   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>  		if (step == 0)
>  			step = 1;
>  
> @@ -2047,8 +2116,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		       ctrl->info.size);
>  	}
>  
> -	mapping->set(mapping, value,
> -		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> +	uvc_mapping_set_s32(mapping, value,
> +			    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
>  		ctrl->handle = handle;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6ebaabd11443..3d32a56c5ff8 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -131,10 +131,10 @@ struct uvc_control_mapping {
>  	const struct uvc_control_mapping *(*filter_mapping)
>  				(struct uvc_video_chain *chain,
>  				struct uvc_control *ctrl);
> -	s32 (*get)(struct uvc_control_mapping *mapping, u8 query,
> -		   const u8 *data);
> -	void (*set)(struct uvc_control_mapping *mapping, s32 value,
> -		    u8 *data);
> +	int (*get)(struct uvc_control_mapping *mapping, u8 query,
> +		   const void *uvc_in, size_t v4l2_size, void *v4l2_out);
> +	int (*set)(struct uvc_control_mapping *mapping, size_t v4l2_size,
> +		   const void *v4l2_in, void *uvc_out);
>  };
>  
>  struct uvc_control {
> 

Exceot for my 2 small remarks this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




