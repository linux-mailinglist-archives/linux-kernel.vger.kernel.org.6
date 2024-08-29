Return-Path: <linux-kernel+bounces-306152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E49639F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E417284F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7414A0A4;
	Thu, 29 Aug 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjc2OQm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3B1487D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909886; cv=none; b=ZbmFpa+w8Zbvw9wMMx5tSFjvbsK+5u8Qu5+VUQLxkUPeFY6BXwIabog0B+sY9AyVnVDmsFNjsQWMBqMr/zYmPyPEpHdeIfBXfGHSKIPPNDdfe1cuc9aU+7rljWYbWQ7RRhf4UwQ939s59r/bmthdLGkexcpDeIEQZcLusDeV9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909886; c=relaxed/simple;
	bh=rl6MiMt55oOtH8dBw+mq1miCc0dLP9wb3iqcC7gtzlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEa28It6Mvb0jGjPNY+CAlwgVpFEJWOWyuGvaHM9BMuCEOCopyOGe66qK1aH54/WrMdxkUBNt4cCfPtTSfZA3kDzckUYNE7ENgcFnuhy0+IKx6KG/k9OILx+tlZrqT5Oc9Ak77PIIq53DLebqrXPcIdVLeijLDZr66UGws3COoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjc2OQm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso2579155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724909883; x=1725514683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fBUm0h6cRPfEHOMq53XB/Ov/Qr4PFpK1A6+YnznzAw=;
        b=SUjc2OQm601bROFnUN6mL8qqknc1Urbej9V0CAS1eVHYfFsa/e7vF6d3/H7bL9oGFo
         gc9BTN5vrhlNLnWEC5C/2Qf1aWpKHazi7lfMxwHG5mYnB3FcxcIN6jv2Gghy9+1K1wqA
         EBjoGybUTKaxYSabfnFiirioGOf5ToGF1bG3Tx09bi7KpOeeoC/3J7aBX0+N3Zy2yaoz
         1XS4bXAxBCkCqkpj19upcgWQG6g5xgjO3E876D6+kH5ZtWEk1xrSo1r1td4F49z7wvwO
         ZtP1o2Cc0qKnV0xeV6A2QPZcR/Bcr5UYv2ZdyId59+CpnRq3HsTQQFeLWYyhxX03+XIJ
         6Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724909883; x=1725514683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fBUm0h6cRPfEHOMq53XB/Ov/Qr4PFpK1A6+YnznzAw=;
        b=WXv25v7mdjTgqGEFiwbr9/Fwqg55NtwGyksOCVYD82wR6f1/u1Ffu0b3zWK9Ov8K1l
         KDYevdVMpdwzVDnl45QbcfRKyrdVUPDI6ilb2qs4LrMn+i/GTrAj3HzwgJH9LuowVTbt
         UI1kckC4cQ5KIm0oROSgMwMk5Jfjn4jFFrj8h+MI08KqZn8MJ7lfSOR7iDaNXDF69LN7
         Akpq6RWBcludD/taZT5dtHVob0JCSfEhCx71QFRDIDLmcBNFBI8QSAiX6B04eEmPK4gW
         4X3G/ibMIUqiSJr6BUID1ul1mRqmMFVhOqu8bvF7YA0ipw83WqO8n742YDGjhewVxXQG
         7P/A==
X-Forwarded-Encrypted: i=1; AJvYcCX8G3Oss2tTvi6SnGIeu+MY1OgTVbzdGJ41mzBnQvSrNsRqoU2s1V5nxBpZBULmBq32XASefL/4rpfP1Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKW++aTdnI1uj5qdMAdQKusnnPyzcEJTEoV4/sv4qgfPM12+gc
	1hWIGmJT7sfd+oI1GnOHSWXqJ9AshccX5UXXfQVGK6bADX7ZBBmo
X-Google-Smtp-Source: AGHT+IHy1J5FktI6cmRfNoPz6x+FDas92ofFhixmO6MS40it5IQqU/ciqzng+Ya79H+JWorumkQoaw==
X-Received: by 2002:adf:f052:0:b0:371:72b3:643e with SMTP id ffacd0b85a97d-3749b57addcmr1355931f8f.42.1724909882914;
        Wed, 28 Aug 2024 22:38:02 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898908ebfasm29973266b.95.2024.08.28.22.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 22:38:02 -0700 (PDT)
Message-ID: <3d9f32ca-c21f-45cf-bc4e-2cc827385d0e@gmail.com>
Date: Thu, 29 Aug 2024 07:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] staging: rtl8712: Calculate size from pointer
To: Manisha Singh <masingh.linux@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828222153.68062-2-masingh.linux@gmail.com>
 <20240828222153.68062-4-masingh.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828222153.68062-4-masingh.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 00:21, Manisha Singh wrote:
> Calculate the size from the pointer instead of struct to adhere to kernel
> coding style.
> 
> Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
> ---
> Changes since v2:
>          commit message updated.
> 
> Changes since v1:
>          Broke the patch into 2 different fixes.
> 
>   drivers/staging/rtl8712/rtl871x_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> index 378da0aa7f55..20e080e284dd 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ b/drivers/staging/rtl8712/rtl871x_io.c
> @@ -48,7 +48,7 @@ static uint _init_intf_hdl(struct _adapter *padapter,
>   	set_intf_funs = &(r8712_usb_set_intf_funs);
>   	set_intf_ops = &r8712_usb_set_intf_ops;
>   	init_intf_priv = &r8712_usb_init_intf_priv;
> -	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
> +	pintf_priv = kmalloc(sizeof(*pintf_priv), GFP_ATOMIC);
>   	pintf_hdl->pintfpriv = pintf_priv;
>   	if (!pintf_priv)
>   		goto _init_intf_hdl_fail;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120

