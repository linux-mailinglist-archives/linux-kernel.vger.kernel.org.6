Return-Path: <linux-kernel+bounces-421330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE09D89B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487202889BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0091B415C;
	Mon, 25 Nov 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc5SdO4d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD21B3930
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549822; cv=none; b=kvmtt+bP9EouGGTNuJE84icufIIWirP67diPHGZuk0CQIjbjI07hjqw32BcyPg/I7L6Dt28TUy1vrkvgr8u6kmIoIkYlFH3A5KHrPew7XjwzDtRM1VkpeFSM8Dnax++nwuqVsyiGg7vKOhX3Qh0IyjD0zLfGBzLNeVaoOcEbcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549822; c=relaxed/simple;
	bh=kfMHB3RJjnlbzO1OpVGbhIstSz4cmx2aTUu0FTGJNng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjTii6TtrGqvNM9CTuE95kmhifdnuo10ETYV2diMe0r4GNqM+H9TzBQqU5sOLAKpls/BpDACXu6V8Qg5B9C3t5r1UPpFJaZruPntp0kPFMqj0noRnmvMLgGbta/jmoOBh+80F2LllEurix94i0Gk0pMpYSn6+ji4SG5zVDmugiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc5SdO4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732549819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQnkgAjPT8jFYPzn3mXbirErF6dgXKuZNcTSfMJYSzU=;
	b=Kc5SdO4dXIQ/K3zDlAsrvOLWmRQDsSlTEwK/60KAVzMD7hHzF2MjNBUPmjEegmzMBiWPoe
	tZuQ9qFKfwt1NQzTenrw53y8A2lcIJKohvsu7c7QFTdYfJYLneLs+qkHu7IPCro/K32w5k
	PeUT1ukymsAsD0ItkUZzqjT6a7g9XL0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Yu4vy5ndPF-XCC6f8oCltg-1; Mon, 25 Nov 2024 10:50:17 -0500
X-MC-Unique: Yu4vy5ndPF-XCC6f8oCltg-1
X-Mimecast-MFC-AGG-ID: Yu4vy5ndPF-XCC6f8oCltg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa516e52376so189062166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549816; x=1733154616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQnkgAjPT8jFYPzn3mXbirErF6dgXKuZNcTSfMJYSzU=;
        b=DvNlxhzfdwr67ryyhgRxQt6NbBe6OSs4LZVgbhVJnKLcQLszP4IITX+Lk80QxAPQ4X
         2AfNjdWKVvtH+rNcX1yxbPpyI77dNmf1iCTHjqJdfoQj4hZO3wTV0R+GkHRZ8bscld+g
         tthrqwK3e5AwoLnhuCQC5xlqG80WA2w+Wh6PHGy+5zytG7A6Yx8jHQABxFgKjTSrufut
         IN4zZTVv1jxnGZ56XFRDjH6ZgTEYK2UlVYM0u1uEqAZU4lJv8XEHu792Ldxq9OlWSXyf
         +nvJ5YHB/XbblfT4yx4j9gCjLFUhh95bbMtMGrJXgA5mFyNLeuy8b/xUwOW3s7eN5hud
         ZnYg==
X-Forwarded-Encrypted: i=1; AJvYcCWNAYiL9OtyauU4SFKkh5zi56GNwBi+JPbS0TU8/ijh5JPwFkILwgXl8qJw1Sn/dVyyNhCbSd7+teBgnyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWo7dINcHCeSrn2v/CEaUGJrZ20Pr+h3xBVBUDLgfK6M0xxlbu
	08bNEyLZUalY/UK00WmHZzsBdNNCdEbRDpm/0jcY8e0ekzavEUrscmOpXse7c13S6lUPjzE+CLe
	Pm4dti0Tlyjb6N1Wl5etVyWhkrnpV7Ka2N2Vkip/n+xWqIY1SgRWEeJxe3Em9AQ==
X-Gm-Gg: ASbGncuDddaji0J/L1Ju7BYlTIWNaFkknw4C6NC3KWBPqXgHqV1Z6E5s6qQH928QzoN
	hLI1rTfSoXMclOZNC+ZcTG6+3jNzOCldadtWi0RceoSiZfh0PIGE8FDzXQjP/VYQdLQRdwXd0pq
	VFJzGJuqcwoPmiMzwTx0xE5iZgSI4nnnMawoNUjNfkRqSsyh3kQwRijTmfU7y1AwN9uN5ZejXLH
	VMEDBeFFY88R5crVfnaGFvNKk9KI4crIyp1dsVzUDXQE0yYKxv3HXewR5norm+ESYWWdnNxrvZJ
	xYitNnxssAdfxQOo1ffYsag6CCx60gjA+0bls1Z6KnPxWdzgS0aWPr+LbTrg2wgT80WysGGmsCM
	u0pOAKuROLL0fWldaRqyv+nBn
X-Received: by 2002:a17:906:4c1:b0:aa5:c1b:2203 with SMTP id a640c23a62f3a-aa50c1b22a1mr897055166b.42.1732549815816;
        Mon, 25 Nov 2024 07:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG+xVc+WRWlgy8t3DQvbGAQE/X9x6Ysv9LBZndFPpM5k6tbAVH6eP65j8ocm1tz0b2PWKizg==
X-Received: by 2002:a17:906:4c1:b0:aa5:c1b:2203 with SMTP id a640c23a62f3a-aa50c1b22a1mr897053066b.42.1732549815427;
        Mon, 25 Nov 2024 07:50:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa516396f6asm449690966b.158.2024.11.25.07.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:50:14 -0800 (PST)
Message-ID: <9be8f912-13b3-4b7d-9705-8ffa3a27d205@redhat.com>
Date: Mon, 25 Nov 2024 16:50:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/19] media: uvcvideo: Handle uvc menu translation
 inside uvc_get_le_value
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-5-64cfeb56b6f8@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-5-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> map->get() gets a value from an uvc_control in "UVC format" and converts
> it to a value that can be consumed by v4l2.
> 
> Instead of using a special get function for V4L2_CTRL_TYPE_MENU, we
> were converting from uvc_get_le_value in two different places.
> 
> Move the conversion to uvc_get_le_value().
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 77 +++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index bab9fdac98e6..77f7058ec966 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -862,6 +862,25 @@ static inline void uvc_clear_bit(u8 *data, int bit)
>  	data[bit >> 3] &= ~(1 << (bit & 7));
>  }
>  
> +static s32 uvc_menu_to_v4l2_menu(struct uvc_control_mapping *mapping, s32 val)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
> +		u32 menu_value;
> +
> +		if (!test_bit(i, &mapping->menu_mask))
> +			continue;
> +
> +		menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +		if (menu_value == val)
> +			return i;
> +	}
> +
> +	return val;
> +}
> +
>  /*
>   * Extract the bit string specified by mapping->offset and mapping->size
>   * from the little-endian data stored at 'data' and return the result as
> @@ -896,6 +915,16 @@ static s32 uvc_get_le_value(struct uvc_control_mapping *mapping,
>  	if (mapping->data_type == UVC_CTRL_DATA_TYPE_SIGNED)
>  		value |= -(value & (1 << (mapping->size - 1)));
>  
> +	/* If it is a menu, convert from uvc to v4l2. */
> +	if (mapping->v4l2_type != V4L2_CTRL_TYPE_MENU)
> +		return value;
> +
> +	switch (query) {
> +	case UVC_GET_CUR:
> +	case UVC_GET_DEF:
> +		return uvc_menu_to_v4l2_menu(mapping, value);
> +	}
> +
>  	return value;
>  }
>  
> @@ -1060,32 +1089,6 @@ static int uvc_ctrl_populate_cache(struct uvc_video_chain *chain,
>  	return 0;
>  }
>  
> -static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
> -				const u8 *data)
> -{
> -	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
> -
> -	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
> -		unsigned int i;
> -
> -		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
> -			u32 menu_value;
> -
> -			if (!test_bit(i, &mapping->menu_mask))
> -				continue;
> -
> -			menu_value = uvc_mapping_get_menu_value(mapping, i);
> -
> -			if (menu_value == value) {
> -				value = i;
> -				break;
> -			}
> -		}
> -	}
> -
> -	return value;
> -}
> -
>  static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
>  			       struct uvc_control *ctrl)
>  {
> @@ -1136,8 +1139,8 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
>  	if (ret < 0)
>  		return ret;
>  
> -	*value = __uvc_ctrl_get_value(mapping,
> -				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> +	*value = mapping->get(mapping, UVC_GET_CUR,
> +			      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
>  	return 0;
>  }
> @@ -1287,7 +1290,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  {
>  	struct uvc_control_mapping *master_map = NULL;
>  	struct uvc_control *master_ctrl = NULL;
> -	unsigned int i;
>  
>  	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
>  	v4l2_ctrl->id = mapping->id;
> @@ -1330,21 +1332,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
>  		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
>  		v4l2_ctrl->step = 1;
> -
> -		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
> -			u32 menu_value;
> -
> -			if (!test_bit(i, &mapping->menu_mask))
> -				continue;
> -
> -			menu_value = uvc_mapping_get_menu_value(mapping, i);
> -
> -			if (menu_value == v4l2_ctrl->default_value) {
> -				v4l2_ctrl->default_value = i;
> -				break;
> -			}
> -		}
> -
>  		return 0;
>  
>  	case V4L2_CTRL_TYPE_BOOLEAN:
> @@ -1592,7 +1579,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>  	ctrl->handle = NULL;
>  
>  	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> -		s32 value = __uvc_ctrl_get_value(mapping, data);
> +		s32 value = mapping->get(mapping, UVC_GET_CUR, data);
>  
>  		/*
>  		 * handle may be NULL here if the device sends auto-update
> 


