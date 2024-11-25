Return-Path: <linux-kernel+bounces-421343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCBC9D89DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9E285BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E121B4143;
	Mon, 25 Nov 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLV9HPeq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94A2500D2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550476; cv=none; b=B/U9JPPancwwGZrrrD2JeeanB5CO7AVQ64Tk+jzpJbnleCqTeQvQYY534+OHPYMNbjMpqglySqOwFZzXQqkk3Geiu4tkbdcMfq0KPlwDN+wMg/XlmvPZmLACb+oXItKjDZTGiCgv/P3FBO1Uqy+2jqkkDPdVw2SUVs3Lf1zlkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550476; c=relaxed/simple;
	bh=XvBt2ajSVUNNM/8Hhh2IsmcsERKJdXAv8ewqGXiLk3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNKgBtD2/UFQm6CI/tc/7hwyIZWoQ2t8OhX2Bs/IOc3tlsa/cN1p/Ljvm38D9+Y0w+WXvSpK5yEEHfhpJ0umL8Vfz0wN/WW46BO8PxUtswZzOr8chBV9MR8pUd74VQnwlhlbljasbv1yqDJ9jXDS4nPf4NHK4XnlcU5VOrfxdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLV9HPeq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732550473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwD97Iaa1eMsbr0BhCGDfOD7jLttQto+VSmJj0E+TCU=;
	b=jLV9HPeqbH3YxVprRL1dVHESqDjRVkxfQ8sxUYCzW41h1HbaRwvKKja+6J2tTmAiCC3loG
	D4zhDNitx2x1bOG0up2KjexUa61aiOh38fELqt1WDyQQy1BSl/zBz0nYJcB2l7O3lnVU2e
	KE3N7Fm8dVf1HI2sk4qu1oZcXHogFeM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-0aEdcYeoNCO-qWZcR30fng-1; Mon, 25 Nov 2024 11:01:08 -0500
X-MC-Unique: 0aEdcYeoNCO-qWZcR30fng-1
X-Mimecast-MFC-AGG-ID: 0aEdcYeoNCO-qWZcR30fng
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa5160f99b6so194584166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550467; x=1733155267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwD97Iaa1eMsbr0BhCGDfOD7jLttQto+VSmJj0E+TCU=;
        b=SsIAdYNO696/LYmGt0RXgFQArtvQNA9mXpPEnUPcEItSocD5ZEsHmoXmrjsdJZ/f2h
         bGjfY/cSlwdgP6Keqe2yW/QDVGvrEejmeZd+suuwl65iQYHk91malq7UFkBIxVQH6M+F
         YGYILNZ2ZZ79JcsJ0lXOKOhLrdGq70PHNX1HDiPf9N2xVbqh9/tLQHg+s/dn6cObVZMD
         UlDFOBSHxS/ZfSMRtosUcqmI+0lN5uZVkJ60NlOOAGY0iXk1guP6T7ksLlPeg4SSXnq4
         GO+d5GvsMPA/aGAvo1gIWAQkHvClpBPsVnOBmxokIREsOkLq+Oh1qVtBLlBFqwzNS0x3
         DBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZcQ0DUXcDQmeg/cUCwNe8gndml1DyLpFyCRCxpC4mikGFSYSmCADH7rvj5LcrBysAOjuikbIGK+y0J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/139W9g5Q6N0LQFihduqHdRX/Idk/H+3jYO3XQDUOaw78895k
	iPzB4DXtCmSCUvX6zRgLU+qcZF5pSywmuHHNkY8Mze4cjnRQdyN7g51s2l9kVIf5BQZpA+O36XD
	FwfsUc/HC+bGqE0O6AlCO5EYaWyrCI+Qim04RBI1T7XiXg0SBEYAm0nHK61ocGA==
X-Gm-Gg: ASbGncvyw7gwCTz6vartceEdkRs1slJIlzUrHMAstSBt+xpMl7Qy+deWsk6hpCuXTpE
	MDFw5wUIgmku0vYWO483U5usNkdVz8pL0MgpBeK/1FTdTtFAASrTH0CyvFwqfETIN8TOsfoeYDm
	2rW2FNPZRfJpge7GbJg1syypqHDZMXyElu4u+HHPvI/UqGWTP0Ambh8t1VGPVonVMosBTgvQqvP
	49jH91LVbYpfuuD0HVKWSsnhOaUbQqlr+GsHetqEwVGUA2tDzFPlxXdxiwxvMLw09LIzHWsZkMG
	13qj0SXAzPbFG1atGf6YHc2EdWhjj+Ou57RQca+0ocWt0J8hKXUMAmB0ePPLGPy1V+TgNSOi5BT
	qkROHJR48DjcB2BzVualyIW/t
X-Received: by 2002:a05:6402:2106:b0:5cf:e3cf:3dc2 with SMTP id 4fb4d7f45d1cf-5d0205fb2b7mr12050065a12.11.1732550467209;
        Mon, 25 Nov 2024 08:01:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMK6On0QAetV6/IDul0ywf9knronYPt2+r+MmKSjA9ORvG9/5yP4ydGgXpAqsPiWI4VhFfGw==
X-Received: by 2002:a05:6402:2106:b0:5cf:e3cf:3dc2 with SMTP id 4fb4d7f45d1cf-5d0205fb2b7mr12049986a12.11.1732550466351;
        Mon, 25 Nov 2024 08:01:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc658sm4219752a12.71.2024.11.25.08.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:01:05 -0800 (PST)
Message-ID: <5faa9bcc-c244-44e4-ba39-679e57b513f3@redhat.com>
Date: Mon, 25 Nov 2024 17:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/19] media: uvcvideo: refactor uvc_ioctl_g_ext_ctrls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-7-64cfeb56b6f8@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-7-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> We want to support fetching the min and max values with g_ext_ctrls,
> this patch is a preparation for that.
> 
> Instead of abusing uvc_query_v4l2_ctrl(), add an extra parameter to
> uvc_ctrl_get, so it can support fetching the default value.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 21 ++++++++++++++++++---
>  drivers/media/usb/uvc/uvc_v4l2.c | 28 +++++++++++-----------------
>  drivers/media/usb/uvc/uvcvideo.h |  3 ++-
>  3 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index c975e0ab479b..d6afa131a5e1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1902,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  	return ret;
>  }
>  
> -int uvc_ctrl_get(struct uvc_video_chain *chain,
> -	struct v4l2_ext_control *xctrl)
> +int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
> +		 struct v4l2_ext_control *xctrl)
>  {
>  	struct uvc_control *ctrl;
>  	struct uvc_control_mapping *mapping;
> @@ -1915,7 +1915,22 @@ int uvc_ctrl_get(struct uvc_video_chain *chain,
>  	if (ctrl == NULL)
>  		return -EINVAL;
>  
> -	return __uvc_ctrl_get(chain, ctrl, mapping, &xctrl->value);
> +	switch (which) {
> +	case V4L2_CTRL_WHICH_CUR_VAL:
> +		return __uvc_ctrl_get(chain, ctrl, mapping, &xctrl->value);
> +	case V4L2_CTRL_WHICH_DEF_VAL:
> +		if (!ctrl->cached) {
> +			int ret = uvc_ctrl_populate_cache(chain, ctrl);
> +
> +			if (ret < 0)
> +				return ret;
> +		}
> +		xctrl->value = mapping->get(mapping, UVC_GET_DEF,
> +					    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  int uvc_ctrl_set(struct uvc_fh *handle,
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 97c5407f6603..02fd5cbc3474 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1078,34 +1078,28 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  	struct uvc_video_chain *chain = handle->chain;
>  	struct v4l2_ext_control *ctrl = ctrls->controls;
>  	unsigned int i;
> +	u32 which;
>  	int ret;
>  
> +	switch (ctrls->which) {
> +	case V4L2_CTRL_WHICH_DEF_VAL:
> +	case V4L2_CTRL_WHICH_CUR_VAL:
> +		which = ctrls->which;
> +		break;
> +	default:
> +		which = V4L2_CTRL_WHICH_CUR_VAL;
> +	}
> +
>  	ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL) {
> -		for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> -			struct v4l2_queryctrl qc = { .id = ctrl->id };
> -
> -			ret = uvc_query_v4l2_ctrl(chain, &qc);
> -			if (ret < 0) {
> -				ctrls->error_idx = i;
> -				return ret;
> -			}
> -
> -			ctrl->value = qc.default_value;
> -		}
> -
> -		return 0;
> -	}
> -
>  	ret = uvc_ctrl_begin(chain);
>  	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> -		ret = uvc_ctrl_get(chain, ctrl);
> +		ret = uvc_ctrl_get(chain, which, ctrl);
>  		if (ret < 0) {
>  			uvc_ctrl_rollback(handle);
>  			ctrls->error_idx = i;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 07f9921d83f2..6ebaabd11443 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -788,7 +788,8 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
>  	return __uvc_ctrl_commit(handle, 1, NULL);
>  }
>  
> -int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
> +int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
> +		 struct v4l2_ext_control *xctrl);
>  int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
>  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  			   const struct v4l2_ext_controls *ctrls,
> 


