Return-Path: <linux-kernel+bounces-437771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDE9E9877
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EB51882E89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26841ACEDB;
	Mon,  9 Dec 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNX8iorX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AB35971
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753392; cv=none; b=jcdzDo8RxdqXHgKbp87qus64tBInDbUZEdUU9IjQbnUDV21zUY9H/LoWTPumHN5YuUrWU/BBiemiGMVcIxe7y0D+O/OmSrVNXgJS69ViG2+4nhYw8fIysaA/KE8yVtqk2k/phkruVQoBw//y1O0TT+a+woEFIiGiv/QZiW/d3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753392; c=relaxed/simple;
	bh=VFsqTHIjbvNsg1lhxlslmn4uCUDQmZvnFu9rTQQdUT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu1d+7JKZhPS7NmCGv9q4TgEtTWeUOUkYcG+FszU+1uvdThI0bK03VPrF/JkND3wguAE7XtcXa2HE07rLGQXfPCxCDxRX8o+ypGz7xTYNNREVzzu4GOrvgeFg0Fp5c9c56CaM6h/p7IT9AWQgrDzNkOKAX3RPh+ecvKB+yHF420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNX8iorX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733753389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHZzrjR5Ve3b7sXUVbsD2DflrETBRAIsfwkq5v711Dk=;
	b=UNX8iorXkMK8n/Miat0aQk0nGPtKzEvd8CfszAp1GCrh9pxK12P139vnxLEZd0cWrsV6Op
	UrFM+EfWVE5Ap2Q63kD0YgwR4VrwN0hlNmpIym8tADbv+C2zZBnzdlQx1p6wKBcYO7e1Ad
	tezSJ82Pt4QTdRzs5/uY0e23PuTSvHo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-qQoeTk_dPjSKDEUWS6Lb4A-1; Mon, 09 Dec 2024 09:09:44 -0500
X-MC-Unique: qQoeTk_dPjSKDEUWS6Lb4A-1
X-Mimecast-MFC-AGG-ID: qQoeTk_dPjSKDEUWS6Lb4A
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa683e90dd3so77204566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753382; x=1734358182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHZzrjR5Ve3b7sXUVbsD2DflrETBRAIsfwkq5v711Dk=;
        b=n77QbGBx9Zo+2y8WJXW/XzUNva2uKS8vLPIgDRaPyuyoOs9Kb7AX8M3Jb7zmhO1bEH
         KH+wHp1IYj3Vg1DPrgzczUla5Wrox8tVLIJvoW5us3wFDJJ6tTJ+3ljY7pKQBc9JRdVH
         B/h7MiCsB2jdtJ9Nq3oBsxKlKJTyHyLl1/L/aU2L4EP+RTk58pYWsu3LbGRvVVGbhpjM
         cxi/sN5sIVV50dX2GgI29rY/pHu+oGDdmcEyNJbTHiLRA/3ZgAgwIBevTLRsn9mi8hdH
         iTZbPs+uwl+dFt6QxLASTQ/i1Il5elKxuztuIHJBeUhZcyUsbYD53w83dex8R9baPrYd
         KAcA==
X-Forwarded-Encrypted: i=1; AJvYcCXHAIOYVOaM0IjTBK0Sjz0HQy7EqGHkw6WgrIE7doKQhbrkMPpIxNfdC/dpwFVkJCPOxqAXtIlAP1snnMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4e3c7tD2PnNI7+WPQhAUUntpiWLa4K3cCIS7v+VvaiW091ps
	Zh3vUoRYRuiSsVuUIcMBsNt4DxMneMmeeVBCCiJyZmljeZaNKmxsqFmv5VnTq4cJJ6HXEP2RpnG
	0kx8OxGp0fvlk6xerK9QnqjUFeQIez32zls57m1Zb8BEcpyM2VDJbPFcyaNb9rA==
X-Gm-Gg: ASbGnctWq3J+YrcQ78kZ2Xll8EGuSoWL2nxrAbJuIYq/zo4IrQW6dZhGYHm/fn6J6ZA
	Md0KIwurKEiqbCEc/DfYVYu8jR78PEGJSxaJnKQZad4WKqhkkX7t4NHk3d8VQDYayYHWP3zOdVQ
	LeGNvNNmN2fR0OGbneOnWLGH6d0DwvoW9dRCvi4XVV4KAA7y5kGR9W393YQX/B3+Vql4qN8ZnUe
	Rh0qDBkWgXHi3zz6cjF9rHOn7Eq1aZFsqJV6z3voOb8T2F7kwcN7A==
X-Received: by 2002:a17:907:cb1d:b0:aa6:85d0:1486 with SMTP id a640c23a62f3a-aa685d029f6mr368165566b.54.1733753382361;
        Mon, 09 Dec 2024 06:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGbaRuojSlObqb+ZgGmgiC5B1UUWtEQVDAfZ4MvGLv/a0gZ7FV1AlNBxzVkBL59NKv7aDaAQ==
X-Received: by 2002:a17:907:cb1d:b0:aa6:85d0:1486 with SMTP id a640c23a62f3a-aa685d029f6mr368162266b.54.1733753381961;
        Mon, 09 Dec 2024 06:09:41 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6707a5110sm290067466b.36.2024.12.09.06.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:09:41 -0800 (PST)
Message-ID: <5701c6b4-b749-4028-8e42-475790f08190@redhat.com>
Date: Mon, 9 Dec 2024 15:09:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/19] media: uvcvideo: Introduce
 uvc_mapping_v4l2_size
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-16-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-16-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Centralize the calculation for the v4l2_size of a mapping.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 1bc019138995..f262e05ad3a8 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1463,6 +1463,14 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
>  	return 0;
>  }
>  
> +static size_t uvc_mapping_v4l2_size(struct uvc_control_mapping *mapping)
> +{
> +	if (uvc_ctrl_mapping_is_compound(mapping))
> +		return DIV_ROUND_UP(mapping->size, 8);
> +
> +	return sizeof(s32);
> +}
> +
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  				 struct uvc_control *ctrl,
>  				 struct uvc_control_mapping *mapping,
> @@ -1504,7 +1512,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  			v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
>  	}
>  
> -	v4l2_ctrl->elem_size = sizeof(s32);
> +	v4l2_ctrl->elem_size = uvc_mapping_v4l2_size(mapping);
>  	v4l2_ctrl->elems = 1;
>  
>  	if (v4l2_ctrl->type >= V4L2_CTRL_COMPOUND_TYPES) {
> @@ -2093,7 +2101,7 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
>  		return -EINVAL;
>  	}
>  
> -	size = DIV_ROUND_UP(mapping->size, 8);
> +	size = uvc_mapping_v4l2_size(mapping);
>  	if (xctrl->size < size) {
>  		xctrl->size = size;
>  		return -ENOSPC;
> @@ -2271,9 +2279,8 @@ static int uvc_mapping_set_xctrl_compound(struct uvc_control *ctrl,
>  					  struct v4l2_ext_control *xctrl)
>  {
>  	u8 *data __free(kfree) = NULL;
> -	size_t size;
> +	size_t size = uvc_mapping_v4l2_size(mapping);
>  
> -	size = DIV_ROUND_UP(mapping->size, 8);
>  	if (xctrl->size != size)
>  		return -EINVAL;
>  
> 


