Return-Path: <linux-kernel+bounces-437748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC819E9800
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D762826B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CA1ACEA8;
	Mon,  9 Dec 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inVs3SuS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3B1A23B2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752731; cv=none; b=IkdJTWL0TtNEdlWy9SUf/VJgi4aS72A8PJuK36tcuLeCcp4WGFnGF35+8P+I3bVLnb2ihaKIXGd7U8l3c+PLHJYdLYcKDp209gZ6br/GaGJB2hoU75AGGvzCL8rBuy8ISzmBScyvPdkuM0JWlxP+NS287D+8/OGZ5aCHkjKf7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752731; c=relaxed/simple;
	bh=oq7NI5KFgFre6T52oWAt0rnSxrGeYNer420M375pCD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMq7JRcttHZDKl0SUrunvP+nRAvIAj20AjDc4Su1Hnb7hLI/k1BEu/Kz2iuQuEIuZ1HXhifM96ndubn/ekQt5MLMJOyOshC+AtsEpxU8mGjiEkJu/bELm/EuvI4TvlEXzsqz2u4VvjQ07FvYLqICZD564vyNCj0gXCkz/MBhO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inVs3SuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733752728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7QHQ6fdH5kEbsSEM5ocuGy0eYSxlB7jTtXGYrqo+qU=;
	b=inVs3SuSsIpJwb0LEMdiBooIPks67mXThjlAT2sejfB2O//DSUXVRg7nHwutjojKpx+o3I
	zTQXWOSXjXLGGhptOcE88oVFpedyZzt9Tl5ppt47Hks4lCwqJnY9hsrdzCoSsk44aACT+4
	ukypkVNYXxdlAjbQjAwKZAg23UmSosY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-qfBt_CMdPuyEDsBXbe4kSw-1; Mon, 09 Dec 2024 08:58:47 -0500
X-MC-Unique: qfBt_CMdPuyEDsBXbe4kSw-1
X-Mimecast-MFC-AGG-ID: qfBt_CMdPuyEDsBXbe4kSw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa634496f58so218932266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752726; x=1734357526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7QHQ6fdH5kEbsSEM5ocuGy0eYSxlB7jTtXGYrqo+qU=;
        b=AUWeQp4OOf9DfjWcAiR0cGSQqmUR4s8JwVoTyQQBsOM3itWn1AYe/JSkVtiaByaZyb
         5YzhidkwuACQ75RZxJpfHMiKg50/6STXXvzAIYAfSPuhBrx3c9/om5uEt7ksZAE3UAc+
         xkPYQcXifiEaLqg6Uf0IiGro0H2ZdsmpmieUzueEFJh8Kub8+FrrjnlFpTRPvJdqKece
         cWJoM5hyb0/Rni5VQreRlaJKam18Dgb7NxNZ7//OBJmFRCoKOljzhAMaJ/q0A0WFgdZQ
         BG+RRj9l7D8m00W3I5jiI0s1haoUWTvSy7vHnQv3RApg2jdljPlnMIRNoeSbVNsgsJ9J
         gvwg==
X-Forwarded-Encrypted: i=1; AJvYcCUdtjxpc5dvKxFrNkxyYfUIEQV9Hv21Le6OsQA95fOmy4P0UEO44JOGYDMT9WS2+7x/cdtg5Aa/Y1RTXHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJDg6LSFziVswb6CCGRq7R8KG6BHeZh/1q0VIL0/Xn8tJurcj
	ZRJRxoP+jAG2yBkOMMg44tlRvbACX0ziXM0GTDaSA1yzgJoA9j7TEjJCUR4jY3jNlxamUWgJScM
	h9BBxrF31dYDe4a22Bn1GyKtGF0Ji5qjSy8p1YbPQ+fJr6HgOjJhdYMJF9delRQ==
X-Gm-Gg: ASbGncuvyEFVeXX6+CowXF5du7UwvfKUg4xWg++sFvDtGpgmkEAW4mfkyBLgIOHVbNQ
	MJOLnX6fjRJOFzc1KbFAE51pskoPQ1pwJceQzKLEQM9S6hHFy+x+TeKFb+Dxhrk2J+T7Ti5zxV0
	aKQ3FFTNUAvj3MUuG0WDoFWxt+nAbBKWzv6wogxE4E33kjIbiFxD1HBvyQ+yw2opSyeOkIRxaak
	w35YMI55czC1aWQNkfV2Fi2H+Pqj2mREIns1ZehbIP7UWwb4aXWBQ==
X-Received: by 2002:a17:906:3cb2:b0:aa6:423c:850e with SMTP id a640c23a62f3a-aa6423c88c4mr1082617566b.27.1733752726164;
        Mon, 09 Dec 2024 05:58:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/q5DH2fhz/HoaynAnr4jhQZEHAgbly+SJp3H7cKxrjHRo+wJydaxXWPAsZ1RiqkoVr0ryCw==
X-Received: by 2002:a17:906:3cb2:b0:aa6:423c:850e with SMTP id a640c23a62f3a-aa6423c88c4mr1082613766b.27.1733752725771;
        Mon, 09 Dec 2024 05:58:45 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa667843413sm351403266b.24.2024.12.09.05.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 05:58:45 -0800 (PST)
Message-ID: <e0098601-4242-4044-bb99-c5e86cb0c858@redhat.com>
Date: Mon, 9 Dec 2024 14:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/19] media: uvcvideo: add support for compound
 controls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-11-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-11-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> From: Yunke Cao <yunkec@google.com>
> 
> This patch adds support for compound controls. This is required to
> support controls that cannot be represented with a s64 data, such as the
> Region of Interest.
> 
> Signed-off-by: Yunke Cao <yunkec@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 224 ++++++++++++++++++++++++++++++++-------
>  drivers/media/usb/uvc/uvcvideo.h |   5 +
>  2 files changed, 192 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 893d12cd3f90..e51cd0a2228a 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c

<snip>

> @@ -1971,19 +2009,59 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  	return ret;
>  }
>  
> -int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
> -		 struct v4l2_ext_control *xctrl)
> +static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
> +					  struct uvc_control *ctrl,
> +					  struct uvc_control_mapping *mapping,
> +					  u32 which,
> +					  struct v4l2_ext_control *xctrl)
>  {
> -	struct uvc_control *ctrl;
> -	struct uvc_control_mapping *mapping;
> -
> -	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
> -		return -EACCES;
> +	u8 *data __free(kfree) = NULL;
> +	size_t size;
> +	u8 query;
> +	int ret;
> +	int id;
>  
> -	ctrl = uvc_find_control(chain, xctrl->id, &mapping);
> -	if (ctrl == NULL)
> +	switch (which) {
> +	case V4L2_CTRL_WHICH_CUR_VAL:
> +		ret = __uvc_ctrl_load_cur(chain, ctrl);
> +		if (ret < 0)
> +			return ret;
> +		id = UVC_CTRL_DATA_CURRENT;
> +		query = UVC_GET_CUR;
> +		break;
> +	case V4L2_CTRL_WHICH_DEF_VAL:
> +		ret = uvc_ctrl_populate_cache(chain, ctrl);
> +		if (ret < 0)
> +			return ret;
> +		id = UVC_CTRL_DATA_DEF;
> +		query = UVC_GET_DEF;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
> +
> +	size = DIV_ROUND_UP(mapping->size, 8);
> +	if (xctrl->size < size) {
> +		xctrl->size = size;
> +		return -ENOSPC;
> +	}
> +
> +	data = kmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = mapping->get(mapping, query, uvc_ctrl_data(ctrl, id), size, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return copy_to_user(xctrl->ptr, data, size) ? -EFAULT : 0;
> +}

While reviewing "[PATCH v15 14/19] media: uvcvideo: Use the camera to clamp compound controls"
I realized that this copy_to_user() is somewhat unexpected. Normally we let the v4l2 core
ioctl wrapper take care of this.

Since there is no room in struct v4l2_ext_control to store the data I guess this is ok,
but IMHO this does at least need a comment explaining how this is a special case.

Regards,

Hans





