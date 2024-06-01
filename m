Return-Path: <linux-kernel+bounces-197840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A068D6FD4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DA81F216E5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE014F9F0;
	Sat,  1 Jun 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaMf7PO4"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE614F11D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246370; cv=none; b=QOcJZSEC9Q1HmsC8vI4DLeJZBx+vAPfSzNayVMMHWiz6tDXCXLrcrXwperUJZ+RfmbGCyaRH23NCt2HmDOQGbZIy2KPvDaBA28obhIa8iWALsJpNPCqbHgf0EX0MlMiSpLbTh5YCQGD9FNbAlmR/sdK1NNomyxfU9D30kruCOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246370; c=relaxed/simple;
	bh=HlQjZvK++Uq10ytKof9oWRg2BtTuHyHSFvSH6jqFv4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hun8vA1qKAqD2lJYYR3rD+kd3pG7y6t2In9bMDDgV+uSLoDJLOHUrkhq7WzwOzqasqx3FtRxGZ/Zo74iBBady0CPh5uGF6Y7mGtRw3TR78uf8aV3RY4b8QaC7wSogR9Xud/uOxlK2iQciNk2TIKek03SkoTL629R/Vqq2JBo77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaMf7PO4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ea85383b37so2657181fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717246367; x=1717851167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykRfs6ZMhFhtxzL78/zKz45DGl0mEcTPzTBsoi8m+SU=;
        b=kaMf7PO4z6lpxBIArdHA8DqMWjIF6xBJkwx290pB1wWnIXPRMbRbrbR8ofGa7K3Sqm
         nH419bmaMpljXNpHhhhTKnybaLa5KW5sukr92QZcPPzSMfA67AUGRonb+83LgCK94zZU
         qvsppI7K3w/rEj7/5sZnL3iUAdY4ZTCZ2hjjtDocF+CwvUq5q99NqR1B7anWubT5/TO0
         oyVNqSQYKO8YilXT54AUOnbF8xQ/iLXysE2wZZBynGvPAqsDh4XKv7YIesuLBLcMN5xs
         d9eiqrv3nQASCWxBldyf1QhXf+TySV4eQFcT5W4Y1rC+8Veqnylu5oVQPED829krZbEK
         Q5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717246367; x=1717851167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykRfs6ZMhFhtxzL78/zKz45DGl0mEcTPzTBsoi8m+SU=;
        b=B2gliHUehcKpeB4Rayqptu5FgVlRfMpNX4HonV1fM4ortYCJC043MKBQYw8qSzlV3U
         M3Oy2bUJkpsKJb1LK5HtjRo8DXoTGpgB5QCRxXOov6AyphOUUwp1rjomgFlGg/wcKTX0
         /MXVVSsd97Jn49Q92FMLXJXrT8pKaL2MjM4Jph5s2yaZk03HoEaFee6LownMO2WaSulq
         QCBuTJnXk3SHTPUh7baPCNIQTmndlM2bVxF/QTUT7cVkBY1KX/30w8fi8sB46MhQNTfQ
         mU/t8q7bi+Tr9dAFrd/gl2Bz+ea2Gkq7MIUGHaI/i3LngTqlGmKuiRWA+xeqcciIVCJ0
         pu5w==
X-Forwarded-Encrypted: i=1; AJvYcCVfEb0VXMAMlsKfe+pj/9DlaDVVggU6BO/zGwQ7lWFVZtxHjGUraaAv0ilFst1QuI5aaqRPJ78LOwiTvGhQ4+Gl/Qc2SXXwxxI/8zJ1
X-Gm-Message-State: AOJu0YwDM3AJz5nVx+EsAKJRM5w4xg/iz9IE3PfgaIE/T7Fow5bIHWs5
	bl6moMaONXOC/bjhxtVHG4BcXAtLU397PSxHp0n4l6HtZWfYjDLrbwiYQg==
X-Google-Smtp-Source: AGHT+IHd/pAWvjJsEfp1KcD+ulnGVj3E//0f3eame8CxZxw9yhFosP3aHErCVLoLj7T18c7zZOcbow==
X-Received: by 2002:a05:6512:3b25:b0:52b:8909:58b1 with SMTP id 2adb3069b0e04-52b89702d1emr4122902e87.3.1717246366233;
        Sat, 01 Jun 2024 05:52:46 -0700 (PDT)
Received: from [192.168.0.102] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea67b23bsm196793466b.121.2024.06.01.05.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 05:52:45 -0700 (PDT)
Message-ID: <971c164f-5ebf-44cb-8cff-3a09c63bb77e@gmail.com>
Date: Sat, 1 Jun 2024 14:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: r8712u: remove unused struct
 'zero_bulkout_context'
To: linux@treblig.org, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240529000814.233690-1-linux@treblig.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240529000814.233690-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 02:08, linux@treblig.org wrote:

please remove the following line:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
To me it is not important which commit introduced the struct. This is 
not a bug. So I would omit this lines and use instead just:
Remove struct zero_bulkout_context as it is unused.
> 'zero_bulkout_context' is unused since the original
> commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
> mainline kernel").
> 
please remove the following line:
> Remove it. >
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/staging/rtl8712/usb_ops_linux.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> index b2181e1e2d38..0a3451cdc8a1 100644
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> @@ -26,13 +26,6 @@
>   #define	RTL871X_VENQT_READ	0xc0
>   #define	RTL871X_VENQT_WRITE	0x40
>   
> -struct zero_bulkout_context {
> -	void *pbuf;
> -	void *purb;
> -	void *pirp;
> -	void *padapter;
> -};
> -
>   uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
>   {
>   	pintfpriv->piorw_urb = usb_alloc_urb(0, GFP_ATOMIC);


Hi David,

I would prefer the following changes:
Subject: please change from r8712u which is the compiled driver name to 
folder name of the driver: rtl8712

Please also consider the above hints.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Please contact me for any questions.

Thanks for your support.

Bye Philipp



