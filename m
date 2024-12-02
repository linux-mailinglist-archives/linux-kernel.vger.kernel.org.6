Return-Path: <linux-kernel+bounces-427812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2E9E0A96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7274B37E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E32040B0;
	Mon,  2 Dec 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q39gADz9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688221FDE1B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151879; cv=none; b=OGf/JQP+AGhgZ9GMjNN3A8t/tgvEACx+CSj6Sd7aCLIxIwiSxXQ4i7+voKlPvknVXsmJJG2hneMrR1pGOBLe0toaw/ZNNMMGsRsQgR4PS6dFDUCdnAZGbVunnDdepKXa0O18HXxTdjurI8Nkc3zwkh6yYlU8t8+hJyNxB9/uKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151879; c=relaxed/simple;
	bh=vJUarVCgzLbRIG6joq/iHyey3+rZ0pgyQXMOAdtKj/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP4a+8n1OalR3XwS2BF/1baVj6h75UgCLwQREUgQzDehUFqvtyBCZdKeQVUsoL4/QMC8DF9OnIUDj9NJdbKhZqsbzna7nbn7NFmhGnF8XQo8rXHtVTc8/WFjbZmZ4fFm/tDSLgr7tm2RoH4/5bNyFn47BZTU9NALylcoeH2eRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q39gADz9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733151876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM16Ab71QF2/aMjr/9GiFpGYvFVS70nYhp6dqdWKglA=;
	b=Q39gADz9ebXHu8T52W8QuWGbsFpZmzuMKiUqKyya8caEuWMlkSabjokOBtrMlkY+ctn05r
	hfo3TNl1g9b13AywLRvvsLbVl0UFbgqon+ufM4KdTJEIG/SAYJLz0JGvZFCBsEt9a1obDd
	mnFmtNg/w/WpKLzRWjZHNgsKs/fSPN4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-j2FN2SwCMeuuD11hafnnbw-1; Mon, 02 Dec 2024 10:04:35 -0500
X-MC-Unique: j2FN2SwCMeuuD11hafnnbw-1
X-Mimecast-MFC-AGG-ID: j2FN2SwCMeuuD11hafnnbw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d0d341cc43so1110718a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151873; x=1733756673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM16Ab71QF2/aMjr/9GiFpGYvFVS70nYhp6dqdWKglA=;
        b=mHNnbiBGrzisTXuxzvdQBO7JFNwyjAr9IL8ILYPaJrvf/yN/9vfCwHu6CICFuI/vi1
         jXmNYgPh/t8UxqW5vjZmqOjQMrLLBc0u36o/JJdDk72S4FZh4Ff+FNJsrD8VybySzCi4
         uzfNT1fp2IJcqTAPztF8qj4cD9jqVehgazHe4DTSrsLealMS6B2KWe7MixlQM8oudVTU
         e/YRGSTtzhrWviKpuuM27QI2NwYKlVMhXyf3jg2xnfSOLEUhh0ilz4drkSmm9v7a/Ld1
         p85bRbrk2yVMr2vH8fwbSIcue10n8VDJfU5yh+VLsV/gV3QH/4nYvZpdj7xwl3qjTd09
         Lqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUYeMZBicpGKNc64mwUUt3FgVsiAb2q5FzwjCf9Zhh+b8pBRW+NcbJ9zhOLr8UK7nGv7h+fm9s6Ilue1WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybKgZN9dF2vno0wWPNSxKkhWX+MG0haoKsTUkD8LYZ+I6oqRh
	mtMS6+WxwW7Qqox0LWlSIf+ZGwtHZQD60rOVLvOmMyZlWif1C1NcInOiGGGACrK4xlKZae09q2A
	pvKC1NnzHClgX4a3vHKIVR4W6eCDM1GUzBV2TQluZ3P6GGJgksOOOc5NVmLVSng==
X-Gm-Gg: ASbGncvSbKD+YNbpW2Vj5O8LB89gV3CLneRLEAC1ZAiaBohWUk0VFsBNXNYBsqrljh4
	gfxhBfngwh+LAyMzQg0xzkWcaZ2eVzk279FEKfbuOtXLXP3F5TIzx9GaWWozrv4J7oqX94G/Y6t
	x4NJg2L0STvCh1pBtxJ/J63nO4+ktKv5ojoe0I6HkdUmgN8Wugqza8haEGysnqv6i1bK0Vcdt2Z
	Yvc0PAnqbXjfrcp8AU+6Bjg8GIKVg3tLX51J+VQM54saqLfJptWdQ==
X-Received: by 2002:a05:6402:1d4a:b0:5d0:bf27:ef8a with SMTP id 4fb4d7f45d1cf-5d0bf27f17fmr15030160a12.26.1733151871236;
        Mon, 02 Dec 2024 07:04:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH89JizN6dfc6LIjrO4IFDhOO72gnXCi8c/ckPglRq/Z/u3VGXGUFjQSMP8IFSUTjS94QFJ2g==
X-Received: by 2002:a05:6402:1d4a:b0:5d0:bf27:ef8a with SMTP id 4fb4d7f45d1cf-5d0bf27f17fmr15029908a12.26.1733151869120;
        Mon, 02 Dec 2024 07:04:29 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0ccbf4e3fsm3042592a12.47.2024.12.02.07.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 07:04:28 -0800 (PST)
Message-ID: <85e10e91-54f6-44b0-aafe-565c83b5cf26@redhat.com>
Date: Mon, 2 Dec 2024 16:04:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Use uvc_query_name in uvc_get_video_ctrl
To: Xiong Nandi <xndchn@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241129151723.48275-1-xndchn@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241129151723.48275-1-xndchn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 29-Nov-24 4:17 PM, Xiong Nandi wrote:
> uvc_query_name was introduced to print query name in uvc_query_ctrl.
> So we can also use it in uvc_get_video_ctrl.
> 
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>

Thank you for your patch.

I have merged this into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

with the line-wrapping fixed to 80 chars.

Regards,

Hans


> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index e00f38dd07d9..93cacd2c8721 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -297,8 +297,8 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
>  		goto out;
>  	} else if (ret != size) {
>  		dev_err(&stream->intf->dev,
> -			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
> -			query, probe ? "probe" : "commit", ret, size);
> +			"Failed to query (%s) UVC %s control : %d (exp. %u).\n",
> +			uvc_query_name(query), probe ? "probe" : "commit", ret, size);
>  		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
>  		goto out;
>  	}


