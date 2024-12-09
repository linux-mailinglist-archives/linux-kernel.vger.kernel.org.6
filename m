Return-Path: <linux-kernel+bounces-437729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE89E97BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D93C283A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94B1B4244;
	Mon,  9 Dec 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtc7NhQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820521B422C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752037; cv=none; b=UZqB6PP/SRgUUhUmguQdpsNR//GWUdIrU9uWi9pE3/4Bk1V9qRAOk5gxZP3jckfGZ/gO3Zhzob1ff/jTNUDch619nJX2vhExseXFHgS8zypXmGe4lVW5STDFRjoiXuiQOCkl5C3M4NZ0VdKD2b1s3wPaOZGSOXOE+4oLugKO2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752037; c=relaxed/simple;
	bh=xIDH5ZGKn/U7XkrehevgURAa7MsvUJvder0R1oTHzLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYXM8D9zO0z+P5UADTvh8FHztL+Ul93kiYDxDssffwYvvlxf++6lSyvZ+qrE2//kOX7zzdnMNA3QfJkTsR7XWvE0K2H4DK7Jlf2Q5Ht9fgpQtQfFgNacdS1cl0jqZiKjWC7tpooFPaqnEVqYw4GZDIYO/r8GvZ8lMeVoHwv9X0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vtc7NhQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733752034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNtXEjpYUE+9og383dkVR79PwqWRsrM27GgBMRdn9fA=;
	b=Vtc7NhQCDrWTAnK4njK1Mlu2FhfOcTQNBhWbw3LWMWRDouCMrvGyEpteT5LJ6rf62lLQq0
	kxQwvpewdeFt53s7UIsXbAXAKirsyRstNyk1rvU9ZFz2va+uk9GkMeY4yp5kOrR8FN1Y+P
	1bLQ4UZHWz0D20sK/BLkBDZQjZd9JFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-i17tDeHgM1-R5YveTDySbQ-1; Mon, 09 Dec 2024 08:47:13 -0500
X-MC-Unique: i17tDeHgM1-R5YveTDySbQ-1
X-Mimecast-MFC-AGG-ID: i17tDeHgM1-R5YveTDySbQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e1339790so2848082f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752032; x=1734356832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNtXEjpYUE+9og383dkVR79PwqWRsrM27GgBMRdn9fA=;
        b=Fb+dX2Z9QW/YesNLlqwRk/NaotOruukYJVzyXN533y9z6j7xTETbUaVvFbNUbH/+nD
         bqQiWT1VihQbGT7u6CmGxaW/I7aa5wcecHPrMRghWhhIWbd7iEJ30Pj7lqBq9LZOT2R3
         3/OtpKdNXaYs0UtBvsZa4OW9Hfo+IXThy1KIJqJaTBCf9Fu4oU0SRTaJCzaN+HIvcDhO
         q4i/jg/KwTQQENEaMf7lFrK3R8bLQpL3IVKYqTVeqiArtTRuklvflWWFWB0w6dCLO9A2
         /wgLavY83BqUn2ztJYKKvhsGhO3JDninmqWhgXpYea4qud4mfZJnV3qxFp1uIsfBPYNm
         vG5A==
X-Forwarded-Encrypted: i=1; AJvYcCV3/8TloLy8U1ncFT1gBy1wBy6feNiNNQDIbVFNFV5cy+Teq7oHIKagvGxDbZGJV4Uxf5BSVob1MCFBqYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnkPKWor++uhbkXznA8q3UMVO5HdPZRIMJ7BjMEaGQ5SGiLPS
	UR2vNcmV+W1xSBeTkBBHBwpsXs+T+GXE/Jh7B4B/+GtXnHb+LkGrwkzMmslyBUwpFkPpMHx0/8l
	/sIn53/7wHa5eWwHV+0D61goBOcScNAe027ZmHm1i6e91q1juL0YpSLosQqo6PQ==
X-Gm-Gg: ASbGncsqDwtG7sWyN2UgWRi0s8ul9xhfdnY7GcQm0E72NAd4SgEJ4cd5q8TQHuKcDkI
	mIGztV5BcHL2YAxY14gCg/cEc2JDN0s2So+HhJTwtsZ+eourf3hYcYadzVRHSAFGjg+o8/u2utj
	chluX5i1mjZxsfLC3a23pyo4tcnMh5G8g7Ju4CwHTiwsbsyBhYOyhQtXQfjddBI3X9vA9D1TV0o
	vw+6KeegZQqmGDV40wC4eZHaDQY1yzxtI26JKes1jqSpCQXA3DU/g==
X-Received: by 2002:a5d:59ae:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-386453da219mr513230f8f.22.1733752031846;
        Mon, 09 Dec 2024 05:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2i3cIfb4RiG066keLy/InBf/TPA8L9FhuFcXSsYGXcSfzZNjOq1Xuh7FPM3liPhgDH6s/Gw==
X-Received: by 2002:a5d:59ae:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-386453da219mr513203f8f.22.1733752031509;
        Mon, 09 Dec 2024 05:47:11 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653d1df95sm376771166b.98.2024.12.09.05.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 05:47:11 -0800 (PST)
Message-ID: <6941cc32-14a5-40c3-9e79-5a899c6a72c1@redhat.com>
Date: Mon, 9 Dec 2024 14:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/19] media: uvcvideo: support
 V4L2_CTRL_WHICH_MIN/MAX_VAL
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-13-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-13-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> From: Yunke Cao <yunkec@google.com>
> 
> Add support for V4L2_CTRL_WHICH_MIN/MAX_VAL in uvc driver.
> It is needed for the V4L2_CID_UVC_REGION_OF_INTEREST_RECT control.
> 
> Signed-off-by: Yunke Cao <yunkec@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 96 ++++++++++++++++++++++++++++++++--------
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 +
>  2 files changed, 79 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b591d7fddc37..0dae5e8c3ca0 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1270,6 +1270,37 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
>  	return 0;
>  }
>  
> +static bool uvc_ctrl_is_readable(u32 which, struct uvc_control *ctrl,
> +				 struct uvc_control_mapping *mapping)
> +{
> +	if (which == V4L2_CTRL_WHICH_CUR_VAL)
> +		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR);
> +
> +	if (which == V4L2_CTRL_WHICH_DEF_VAL)
> +		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF);
> +
> +	/* Types with implicit boundaries. */
> +	switch (mapping->v4l2_type) {
> +	case V4L2_CTRL_TYPE_MENU:
> +	case V4L2_CTRL_TYPE_BOOLEAN:
> +	case V4L2_CTRL_TYPE_BUTTON:
> +		return true;
> +	case V4L2_CTRL_TYPE_BITMASK:
> +		return (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) ||
> +			(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX);
> +	default:
> +		break;
> +	}
> +
> +	if (which == V4L2_CTRL_WHICH_MIN_VAL)
> +		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN);
> +
> +	if (which == V4L2_CTRL_WHICH_MAX_VAL)
> +		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX);
> +
> +	return false;
> +}
> +
>  /*
>   * Check if control @v4l2_id can be accessed by the given control @ioctl
>   * (VIDIOC_G_EXT_CTRLS, VIDIOC_TRY_EXT_CTRLS or VIDIOC_S_EXT_CTRLS).
> @@ -1288,7 +1319,6 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  	struct uvc_control *master_ctrl = NULL;
>  	struct uvc_control_mapping *mapping;
>  	struct uvc_control *ctrl;
> -	bool read = ioctl == VIDIOC_G_EXT_CTRLS;
>  	s32 val;
>  	int ret;
>  	int i;
> @@ -1300,10 +1330,10 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  	if (!ctrl)
>  		return -EINVAL;
>  
> -	if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) && read)
> -		return -EACCES;
> +	if (ioctl == VIDIOC_G_EXT_CTRLS)
> +		return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
>  
> -	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
> +	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
>  		return -EACCES;
>  
>  	if (ioctl != VIDIOC_S_EXT_CTRLS || !mapping->master_id)
> @@ -1451,6 +1481,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>  	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
>  		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) &&
> +	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN))
> +		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX;
>  
>  	if (mapping->master_id)
>  		__uvc_find_control(ctrl->entity, mapping->master_id,
> @@ -2037,16 +2070,18 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
>  
>  	switch (which) {
>  	case V4L2_CTRL_WHICH_CUR_VAL:
> -		ret = __uvc_ctrl_load_cur(chain, ctrl);
> -		if (ret < 0)
> -			return ret;
>  		id = UVC_CTRL_DATA_CURRENT;
>  		query = UVC_GET_CUR;
>  		break;
> +	case V4L2_CTRL_WHICH_MIN_VAL:
> +		id = UVC_CTRL_DATA_MIN;
> +		query = UVC_GET_MIN;
> +		break;
> +	case V4L2_CTRL_WHICH_MAX_VAL:
> +		id = UVC_CTRL_DATA_MAX;
> +		query = UVC_GET_MAX;
> +		break;
>  	case V4L2_CTRL_WHICH_DEF_VAL:
> -		ret = uvc_ctrl_populate_cache(chain, ctrl);
> -		if (ret < 0)
> -			return ret;
>  		id = UVC_CTRL_DATA_DEF;
>  		query = UVC_GET_DEF;
>  		break;
> @@ -2064,6 +2099,14 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
>  	if (!data)
>  		return -ENOMEM;
>  
> +	if (which == V4L2_CTRL_WHICH_CUR_VAL)
> +		ret = __uvc_ctrl_load_cur(chain, ctrl);
> +	else
> +		ret = uvc_ctrl_populate_cache(chain, ctrl);
> +
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = mapping->get(mapping, query, uvc_ctrl_data(ctrl, id), size, data);
>  	if (ret < 0)
>  		return ret;
> @@ -2076,22 +2119,37 @@ static int uvc_mapping_get_xctrl_std(struct uvc_video_chain *chain,
>  				     struct uvc_control_mapping *mapping,
>  				     u32 which, struct v4l2_ext_control *xctrl)
>  {
> +	struct v4l2_queryctrl qc;
> +	int ret;
> +
>  	switch (which) {
>  	case V4L2_CTRL_WHICH_CUR_VAL:
>  		return __uvc_ctrl_get(chain, ctrl, mapping, &xctrl->value);
>  	case V4L2_CTRL_WHICH_DEF_VAL:
> -		if (!ctrl->cached) {
> -			int ret = uvc_ctrl_populate_cache(chain, ctrl);
> +	case V4L2_CTRL_WHICH_MIN_VAL:
> +	case V4L2_CTRL_WHICH_MAX_VAL:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -			if (ret < 0)
> -				return ret;
> -		}
> -		xctrl->value = uvc_mapping_get_s32(mapping, UVC_GET_DEF,
> -						   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> -		return 0;
> +	ret = __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qc);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (which) {
> +	case V4L2_CTRL_WHICH_DEF_VAL:
> +		xctrl->value = qc.default_value;
> +		break;
> +	case V4L2_CTRL_WHICH_MIN_VAL:
> +		xctrl->value = qc.minimum;
> +		break;
> +	case V4L2_CTRL_WHICH_MAX_VAL:
> +		xctrl->value = qc.maximum;
> +		break;
>  	}
>  
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  static int uvc_mapping_get_xctrl(struct uvc_video_chain *chain,
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 65dbb53b1e75..7e284770149d 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1087,6 +1087,8 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  	switch (ctrls->which) {
>  	case V4L2_CTRL_WHICH_DEF_VAL:
>  	case V4L2_CTRL_WHICH_CUR_VAL:
> +	case V4L2_CTRL_WHICH_MAX_VAL:
> +	case V4L2_CTRL_WHICH_MIN_VAL:
>  		which = ctrls->which;
>  		break;
>  	default:
> 


