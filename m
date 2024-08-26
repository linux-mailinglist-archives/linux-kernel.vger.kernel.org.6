Return-Path: <linux-kernel+bounces-302068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3095F96E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC71C22133
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473361991CC;
	Mon, 26 Aug 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU2MMGTQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89081990CD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699277; cv=none; b=dxsfajbw4eted4HMjVkNBHk9D8UIW+1CJHxG85bS/Ne1t2l3IebkSV6hXfFULp+v85T4Pg85RJEK1Fgi+YomhthMAQ9sJxDMVf5WCozfLdpU6KhQHiePdsMT5y0AskdksNVLR5/X3MwByqEXbkVaDCkhQp1ZdGLQvqKsPayn+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699277; c=relaxed/simple;
	bh=xEJ2cXYER4N3XCO2mOEMn9fSE+s/0OFNOWSEaGbzkp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jXdO3InqZV7x3VnEjv/DRKFXYF0PM0VGgJavH9oRJ02ngvZ0e0TZWGd1VxNFm7tCw5PMFXC4P8VZ1PlCyarP4YbQ4resZFW3sLKLHy5krsho861qj8nyUUcIlForamCIKUqyp4JNuJAAfbdVic03ec2ghgADyMaUKGgX8bIPxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU2MMGTQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86883231b4so606694966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724699274; x=1725304074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmtnEYFG7LM3Rww8xbnrxCDknQ7Ml6u6NmRWdx1EeJ0=;
        b=UU2MMGTQbAH0Mkg99VvoS2PV1+KB4YeLY/KGjepU06548b8QcpRIQCwY8fLzrFlg9H
         QaA3Y4XFMtJ31cx/nZQrggv5iVqPlnVp1gCNEFszKwadpEmSftd8JxE+kpmqS5EtDx/5
         HURyj2fS5gqhTVBAe8QrIMh4gOK25O45gYeA1QBWGfLWYkEcvGjvfweXrsfTnB8C35bO
         DxcINkJ6nApQbQL0iLMA19qwzjYD3tLKxiv9/IrFXR8fat7ZA5ZJVAkpl5hxVL2AQTIz
         iYTrPCKBhTIhaKmxyDQa3GvHm4P6NjgBNi5sBLrIhw7HqGLwZ5Vk1OWAP91SuVIKf5ZZ
         i/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724699274; x=1725304074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmtnEYFG7LM3Rww8xbnrxCDknQ7Ml6u6NmRWdx1EeJ0=;
        b=gKo1vKgHp8010l25VMBQoYF8i9LrllKbjEWALNN4Void/hp3MUasHqWzMp4+NgSZqZ
         aPO72CsS+R+JLvynLOK1FHKUl81wcZl1X+6MEd2sHFT3BAL4Bvw4uH/L3WorwaqZedpS
         vnkQ8mU3tFwV3YpbjkLXfgJ6p/CFir6QU2KgVFPI/Y+huRGyH/ovB0fiCNPqMWvzPDM+
         XVXhBeAc40OjdXd+2GOjwoBxo1xFQI7LzYmP19ZrZw4FnAEImnFkokCK98Dj/a7qxYzc
         EM44ad6sUyh0ToSR+78UrYb+NZDZ/kfad48IKldkFBWtIu9dfoGv9EhbzxQrOY8Q0tzO
         e7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLolmNwbTmNbBwWjukFwCxx0tWBiRH5Cbp83azSiL3yiAZCuU2Sg2tbnsp1xb8bMCj9eE8gH0AoG36LRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75Cad9nNTVX/6qpBVr56oaKzxkVKQZwUuQ1wgg+QQklNDgrWs
	l+cDfczXBZRL0t8/jYq2Y3m/SRKpM7o8I+TXyxCDyR5KFlAPXybCc3OIXtRy
X-Google-Smtp-Source: AGHT+IHKHKsFx9fhD9tunI7iX3r2A+7rNFND6+T/z9N90Q3ttvn7hbDydR2wPEnuEz4MjM5Whd/6XQ==
X-Received: by 2002:a17:907:3f14:b0:a86:722c:1460 with SMTP id a640c23a62f3a-a86a51b4a11mr885047966b.18.1724699273782;
        Mon, 26 Aug 2024 12:07:53 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8502:42e6:b0b2:a0bb:dc32? (p200300c78f2a850242e6b0b2a0bbdc32.dip0.t-ipconnect.de. [2003:c7:8f2a:8502:42e6:b0b2:a0bb:dc32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ff24sm9046666b.89.2024.08.26.12.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 12:07:53 -0700 (PDT)
Message-ID: <e5c1cc1e-f43c-466b-9bcb-8a1c507cdd3f@gmail.com>
Date: Mon, 26 Aug 2024 21:07:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Fix style issues in rtl871x_io.c
To: Manisha Singh <masingh.linux@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240826185213.9445-2-masingh.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240826185213.9445-2-masingh.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 20:52, Manisha Singh wrote:
> This patch addresses style issues reported by checkpatch.pl in
> drivers/staging/rtl8712/rtl871x_io.c:
> 
> 1. Avoid Multiple Assignments: The original line had multiple
>     assignments in a single statement. This is generally discouraged
>     for clarity and maintainability. The code has been refactored to
>     use separate statements for each assignment.
> 
> 2. Prefer `sizeof(*pintf_hdl->pintfpriv)` Over
>     `sizeof(struct intf_priv)`: Updated the memory allocation call to
>     use `sizeof(*pintf_hdl->pintfpriv)` instead of
>     `sizeof(struct intf_priv)`. This is considered better practice as it
>     automatically adjusts if the type of `pintf_hdl->pintfpriv` changes,
>     reducing the risk of mismatches and improving maintainability.
> 
Hi Manisha,

please do just one change at a time. The 1. and 2. indicates that you 
are doing two different things.

> Changes made:
> - Replaced the original line with two separate lines for allocation and
>    assignment.
> - Updated `kmalloc` to use `sizeof(*pintf_hdl->pintfpriv)` for the
>    allocation size.
> 
> These changes improve code readability and maintain consistency with
> coding standards.

Do not describe so much what you do. What you do can be seen in the 
patch. The most important thing to describe is the __why__. When 
possible just use 2-3 Lines in the description.

> 
> Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> index 6789a4c98564..b81e9b06725c 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ b/drivers/staging/rtl8712/rtl871x_io.c
> @@ -48,8 +48,8 @@ static uint _init_intf_hdl(struct _adapter *padapter,
>   	set_intf_funs = &(r8712_usb_set_intf_funs);
>   	set_intf_ops = &r8712_usb_set_intf_ops;
>   	init_intf_priv = &r8712_usb_init_intf_priv;
> -	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
> -						    GFP_ATOMIC);
> +	pintf_priv = kmalloc(sizeof(*pintf_hdl->pintfpriv), GFP_ATOMIC);
> +	pintf_hdl->pintfpriv = pintf_priv;
>   	if (!pintf_priv)
>   		goto _init_intf_hdl_fail;
>   	pintf_hdl->adapter = (u8 *)padapter;

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp



