Return-Path: <linux-kernel+bounces-542107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74703A4C5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E1188D60F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB5214A7F;
	Mon,  3 Mar 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcQJWyge"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB238214A8D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017075; cv=none; b=a8ExnWpojbM+xlp8LAEClaMId4xGUNhpxNeVNQAQKw3EGZt0y5vZbZJDHxbZH/bgA0fzWBF0Y6yxI446eRSHzvCt1T+dkdPGgnlz9k0v2YpvkLKlj+gdIdF38k9sQ7x8Nyad6o5b4zj5b0H3fSSxM6snC8kOFY4wq6qa/sogqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017075; c=relaxed/simple;
	bh=ZWEhpOBidKeV739TbxKmSwQPBROxU2amALqS0k+Joz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD2j4UL8QGH/CS9biVxq8Av6GwosNKEZdUQGE6VyVAyfGHTw4ZMwizs22TmZgRL5flVW2pUWCPvCpQvY3e3xN7B2IJlzRIIzq639MqqQDmEuQoAnFm2vrBR7agWpxGt4Go3fOF2hK6gYyAUBZmBtNhSJwgY+ovdxsdVv+sE+rOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcQJWyge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K16nr7ubLrzOQPyiKBk0XrIZtdEZRIqjn6VX8zdTz0M=;
	b=gcQJWyge0n8Z4Se2Gt6lANDEcDbDaZpEnv9tgTntCcZWP4g+vLkQflX6nVunpO78z46N3B
	aZomaLJLrt+hK+8WozVZib8quzIYEiUJNkTUiPKDnyyMl6PXwFcdiTppj379auHmzhT18D
	F9IbMbSeSPKQsHzJ+T2GvX9/I003xjY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-d29aukDQM6yA3H24eY2puw-1; Mon, 03 Mar 2025 10:51:10 -0500
X-MC-Unique: d29aukDQM6yA3H24eY2puw-1
X-Mimecast-MFC-AGG-ID: d29aukDQM6yA3H24eY2puw_1741017069
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf597afe1fso242370366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017069; x=1741621869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K16nr7ubLrzOQPyiKBk0XrIZtdEZRIqjn6VX8zdTz0M=;
        b=DQOQRKJY/qq0EOo/928768tmWK0a5jfQ2M+L8y0+aSbm5CSGX+konjPxzE+UCM/j1B
         7bnKZqwow0Qny4WsVSCEZJK7GUtw4k38doJDE0ljDHzZkEWnv6yV+9Tm6UDYOMeYz+Nl
         RrfHRtCh0YwsgU5bakXFWdr+T4ndv2dFxRsKtcexG30W4byzOUfaxBTBu2TJzgO+YsHY
         LepcLPrlWxohQqxATXcqEslsaMpil5b948bY/C+x9uwZGHIFupFE3wm6k1m0yo02xZ2V
         i33JUkjBfOrPBloAjzy/yBc2+zwvc2xpywCVNa6w6GKkyIq12OkiJZAwPoDlusfEuUyE
         my/A==
X-Forwarded-Encrypted: i=1; AJvYcCXbrj6x7K8MeZ3sNGZY0fwjDuPbN6/DQjNR91RRZANrKAdIfCnw54lajMfgrAj2DcL7pa6tgK+4tXMa9/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0OO09pGcC0rcl/YadMfVPra9RszOqP8Cbmt0Aq0lmKTNpwZYR
	YGEtq7sYN7hJIb6Ja1lcaNgdakun/8J+7/lqyILbViCKbIiIRRSYB8po8R+6+/WTOnk9OLiAz73
	ckiOvKUi+q4hjdLtVJpt4yk1x5LaICYOaGkNv0ZI5/CsbUnYzIw+NC6tUZl88Hw==
X-Gm-Gg: ASbGncsqeGKLJ7psMLcrYxKkI54uiLLTyErQj0p6//eSE8isgHTtjo11wkcIV2sdYZQ
	3GVbaQERBv1zrvBGBfULg44v9hbjn+PZEaClhtUS9Hz6iqa/xuw++TUGfM2cmSsLF3RW3w+srmh
	tP8ALdKT3BffXGH18p2o3ymNiwdTW2ciQmJbP90vpq7KNFl0ek6+WP3Hz5ZM6VPvQgga4SpKl/N
	uJdz0ZYgosD5zz5URI0Rr01X/HDy6ACHj7keGvalUrskGplIbywTYN+eb/ixddMd7P+EyUyW0S0
	M20TehjADn5Mb/td/7M=
X-Received: by 2002:a17:907:9815:b0:abf:641a:5727 with SMTP id a640c23a62f3a-abf641a5b44mr659813966b.7.1741017069188;
        Mon, 03 Mar 2025 07:51:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+kTY6PYLlUbG/PtqauQPE6Rqw494YQYlUnD9gWRXe8F8l3Ob/E42U5ZFDWENdOI6Jz12+lg==
X-Received: by 2002:a17:907:9815:b0:abf:641a:5727 with SMTP id a640c23a62f3a-abf641a5b44mr659811866b.7.1741017068795;
        Mon, 03 Mar 2025 07:51:08 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf56691042sm451143466b.99.2025.03.03.07.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:51:08 -0800 (PST)
Message-ID: <07687805-5a56-40b6-b263-d9e319df0c19@redhat.com>
Date: Mon, 3 Mar 2025 16:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: uvcvideo: Rollback non processed entities
 on error
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
 <20250224-uvc-data-backup-v2-3-de993ed9823b@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250224-uvc-data-backup-v2-3-de993ed9823b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24-Feb-25 11:34, Ricardo Ribalda wrote:
> If we wail to commit an entity, we need to restore the
> UVC_CTRL_DATA_BACKUP for the other uncommitted entities. Otherwise the
> control cache and the device would be out of sync.
> 
> Cc: stable@kernel.org
> Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Closes: https://lore.kernel.org/linux-media/fe845e04-9fde-46ee-9763-a6f00867929a@redhat.com/
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 7d074686eef4..89b946151b16 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1864,7 +1864,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  	unsigned int processed_ctrls = 0;
>  	struct uvc_control *ctrl;
>  	unsigned int i;
> -	int ret;
> +	int ret = 0;
>  
>  	if (entity == NULL)
>  		return 0;
> @@ -1893,8 +1893,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  				dev->intfnum, ctrl->info.selector,
>  				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
>  				ctrl->info.size);
> -		else
> -			ret = 0;
>  
>  		if (!ret)
>  			processed_ctrls++;
> @@ -1906,10 +1904,14 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  
>  		ctrl->dirty = 0;
>  
> -		if (ret < 0) {
> +		if (ret < 0 && !rollback) {
>  			if (err_ctrl)
>  				*err_ctrl = ctrl;
> -			return ret;
> +			/*
> +			 * If we fail to set a control, we need to rollback
> +			 * the next ones.
> +			 */
> +			rollback = 1;
>  		}
>  
>  		if (!rollback && handle &&
> @@ -1917,6 +1919,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  			uvc_ctrl_set_handle(handle, ctrl, handle);
>  	}
>  
> +	if (ret)
> +		return ret;
> +
>  	return processed_ctrls;
>  }
>  
> @@ -1947,7 +1952,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  	struct uvc_video_chain *chain = handle->chain;
>  	struct uvc_control *err_ctrl;
>  	struct uvc_entity *entity;
> -	int ret = 0;
> +	int ret_out = 0;
> +	int ret;
>  
>  	/* Find the control. */
>  	list_for_each_entry(entity, &chain->entities, chain) {
> @@ -1958,17 +1964,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  				ctrls->error_idx =
>  					uvc_ctrl_find_ctrl_idx(entity, ctrls,
>  							       err_ctrl);
> -			goto done;
> +			/*
> +			 * When we fail to commit an entity, we need to
> +			 * restore the UVC_CTRL_DATA_BACKUP for all the
> +			 * controls in the other entities, otherwise our cache
> +			 * and the hardware will be out of sync.
> +			 */
> +			rollback = 1;
> +
> +			ret_out = ret;
>  		} else if (ret > 0 && !rollback) {
>  			uvc_ctrl_send_events(handle, entity,
>  					     ctrls->controls, ctrls->count);
>  		}
>  	}
>  
> -	ret = 0;
> -done:
>  	mutex_unlock(&chain->ctrl_mutex);
> -	return ret;
> +	return ret_out;
>  }
>  
>  int uvc_ctrl_get(struct uvc_video_chain *chain,
> 


