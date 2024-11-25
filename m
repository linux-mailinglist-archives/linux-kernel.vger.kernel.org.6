Return-Path: <linux-kernel+bounces-421345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656B9D89E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F0A16ABEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852B1B414F;
	Mon, 25 Nov 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl4nAkXd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0DEAF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550491; cv=none; b=kUzlJ14tBgIZrrTB6KOZiBPcR1Cxc2qdn/rTY3zprDzl0kKM1Ou+Nz6sDfulyHkw2cU7s4Cx4TcldfdZ60Kg0dlsG/qpvREhB5mOz6JRQ1AgAycFHrMeCfS1+8xjR3ZDN8kQTh+WUJYg+TS2z6WI8xmnR7RZed2Afm/YtKv9h1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550491; c=relaxed/simple;
	bh=Pluboec6B86D6ws6bYAgKSR1YGIcc9GTafVmWwbJSj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcnbf7X0Gi0SRxxVdKeSeHx9WOKtVkYmxBtksjputlsT38WORc0/t2pcIt3DFJOsz0b1W/Q838WINszusDCT+HC7gY7IuW52QGxpi42Ed8ole1uOZWIqCizM9MmPg5b2xL2e5MyrYwWIoQDHHNMz3bWn+0uRzQXLtm/TlzH4fw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fl4nAkXd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732550487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGIGpXHEYfpIIvt0UvOdEb2pgVXsrLcxjgtqNDiti3Q=;
	b=fl4nAkXd1TLv9SslclP3vgtEiLb/lkYW+YkIv2RqrAxK4sibJ/vnAGzqmqBmaBlHLccIsl
	7UlX3Rh0+fbWHJqdPsYJdF1RYauT6TRqI5kJTkx0DbQ/VydRORVW40AOmeUnRJryZs2nmC
	drcWZuFwVyJBP1LRqP/JRXxOIysjUio=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-EJreUkRGO0CE59yrBK5dDg-1; Mon, 25 Nov 2024 11:01:25 -0500
X-MC-Unique: EJreUkRGO0CE59yrBK5dDg-1
X-Mimecast-MFC-AGG-ID: EJreUkRGO0CE59yrBK5dDg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d035c8f3afso1777414a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550483; x=1733155283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGIGpXHEYfpIIvt0UvOdEb2pgVXsrLcxjgtqNDiti3Q=;
        b=CWaod4EOQjZDjDN0Ca2nn+/qcF96kYSiftJ17xASZDI+o18JawB7Quu73fh6e6Nrg8
         Y0pzW9VJPiKEPryibtTHxgr83BEFu658dNd5oMY7qINKFeWctSKaLxUKZ/9ed1wSnovm
         DZPTFPZatiKxcKjfwZldiOe+30ThDuBS+7QieC5DhddE+74UiT3iZFbR3q4Y6EDyHrZX
         jQ9zov9xlk7eyx8axCgWRjQ0VspOL1hSggvVrNKcfv+S/YW/e9+Tt8ng0hKzHdftdGSx
         YmXwni7eRe1CU128AlmfsXR5sWuaV1aUYXc+lRqBJByHd40q5i55HzNwh23IKBrn/hY4
         Zt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZBl6BYqJx5EUiFNzkz9wePB8t2i+rDqA7GpWMw0wu0wjXoWL//k4XU0MzWp7Ve2vBwWtZoeeIVeSj5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOoEE9kA3ryzVv0DE+iWBBksciIVthMAxOU483GH6r633yM7zL
	g6H4C5WQmxhXPqbDX7KV3EQoN6bD25Pp9G5ZMhfx1eELr3Ogg4O/F6Y47d1pfnbkzcHdQEYvm7o
	tIIemvMVpKMH1+WrMytJe/M+c02voKPVNrtVu89A6rdkFQ62KNWhcWypVyqFqCg==
X-Gm-Gg: ASbGncv2HjN7gPPsx6z7qj2gCDe/uzoitvX2f6At6pm3uCwOx25+jo0GoZ9C0KN84S0
	1nPduPH3lpAg77OhV3PMYT9mHXwoElEXXiJkqwXCt59cBjJKjVlx/wusv6PW5fInHylsbhQp26k
	MEosWRZCA3rGrjSH/pC39H3Bl1buKFOJSmvI92NBvj3bQhq+IbHLYwCJLJKHWydTrO1iV0Q+Mf4
	07SHyczUtM0vI7ssM1Ty1XkvAUcFpRLXqIlDD+oKXFt7Jl5As5pKI/4IlcSO+Fuv22QA60aRLPj
	q/6GXCdusx0ugG2EAA/gnZjQXRgNNwlBXIASYiAsqNLSPqtM0Hh8edYygsoaJ4sMyhV1x00yjnh
	OSygwH0HT/OZaw+k5tmx4lnBw
X-Received: by 2002:a05:6402:3896:b0:5cf:e9d6:cc8a with SMTP id 4fb4d7f45d1cf-5d0206257c4mr11826319a12.20.1732550481873;
        Mon, 25 Nov 2024 08:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQbWf0jO1klkeWEEobeV5FhDZOLY+CFfN2xGEVK/87HU7FApwBNZxs1UJfr7YKCXLn8oTsrw==
X-Received: by 2002:a05:6402:3896:b0:5cf:e9d6:cc8a with SMTP id 4fb4d7f45d1cf-5d0206257c4mr11825847a12.20.1732550477578;
        Mon, 25 Nov 2024 08:01:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc745sm4278689a12.64.2024.11.25.08.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:01:16 -0800 (PST)
Message-ID: <f7d29368-c05f-4fbc-ba8d-2bbc95b21c37@redhat.com>
Date: Mon, 25 Nov 2024 17:01:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/19] media: uvcvideo: uvc_ioctl_(g|s)_ext_ctrls:
 handle NoP case
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-8-64cfeb56b6f8@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-8-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> If nothing needs to be done. Exit early.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 02fd5cbc3474..65dbb53b1e75 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1081,6 +1081,9 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  	u32 which;
>  	int ret;
>  
> +	if (!ctrls->count)
> +		return 0;
> +
>  	switch (ctrls->which) {
>  	case V4L2_CTRL_WHICH_DEF_VAL:
>  	case V4L2_CTRL_WHICH_CUR_VAL:
> @@ -1121,6 +1124,9 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  	unsigned int i;
>  	int ret;
>  
> +	if (!ctrls->count)
> +		return 0;
> +
>  	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
>  	if (ret < 0)
>  		return ret;
> 


