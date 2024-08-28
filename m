Return-Path: <linux-kernel+bounces-305741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA19633B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96621C240CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA81AD417;
	Wed, 28 Aug 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hegh5vew"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141A1AD3F5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879740; cv=none; b=dNrP44Pqz+Xob1hoC6zZv+5oDLnp16aWx5o9inDJ8Q+BJdAiP+tzKu5h/XJS9pHCGpQAtgTnwR5ICTonouAyB8KSUYjEeFT8aWBxoEG5HK5wqrbOqFLJ2C8tlSSQqfSqZ31N/EiWGg37fq3pFQY4Ph+9n+OnBDSHEPuXHD1VUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879740; c=relaxed/simple;
	bh=kuGZ62y/XO4qJyz0UjKv1D4OELR9tiomQ7nZXgNFacg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A9jKvnFiQOIdrt4E2mwXTMcOMMkC4E2VoNrR1BxYU4fpe42M2PUYVaTqaa+woN1qdxnqH7jjd3GdUcq2GQrnb4zDUfs7hHPFXDes56MCLWvAVgXk44BBQqfmWMoVvl9WskbXYIdWdFyZ6DlIvO3EG/jvHqJpReILbvw/e6O1nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hegh5vew; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533488ffaddso8755326e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724879736; x=1725484536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MALVjPP/ugUbqVBVpipIvnCXRUymBUlW/hUrmGAJS4k=;
        b=hegh5vewa6/QUMmlUDCXemPGU0BH5FB9G9dphZB1rpOd75qnSanE7xEs8Fi07hrVXM
         hM6S5oUGWB58qupimW5wdKHtYwPPQ3lVYoMYD5SF/lzuDpJTNkdly5+8EEmd/WsaJQej
         T8jJKBm/JIPWr6vLvd9887nfLyX5UP6P8Jxv/YH4euhYULMvoFM1kKFAwvq4P+FG4w48
         3i2qyd9OkOTMkzm59qmkN+6UKZR046FtPmwnYsBigUIe7MNwr1apc6KrlDdRsw/TrmsS
         wUNiEDBTPZlvHiyoVBYQ8Eck/iBX4tZAP+4epF1/oH1/ly24Q3K3awwtV96xx92zeo8o
         jrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879736; x=1725484536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MALVjPP/ugUbqVBVpipIvnCXRUymBUlW/hUrmGAJS4k=;
        b=lyi0FWZpROmrIUQUyRKL3sXsgfiEANvBmAC68S+UvHKIhUpFcAJzjIZyGo2U3FAj6Y
         R5oUdfQwC/N13b56SyYJtJJcxeCrbUafBxUxenFva3TMliBis5bquNJvMd0kqoFwFNVo
         0fS/pyJf1SCnWeqyJnIM/kpjHeMvQpAq2f3IdHPuZRUOvb+zPpwvrWK/iXeY6gBHCRWs
         zOtr4aDHTnaJVZDWNZjod4vtSLo8W2hss0vjM0cFgx11zikNPGu+GLCrEos9siimj0O8
         ZrCtr3BY6jFC+jWFroga8D0mDzDum91E0ac17G3wTvZV+QdfyQG5sgutTqLSxrxNnBhn
         FfDg==
X-Forwarded-Encrypted: i=1; AJvYcCXajJmMqgFTOIFDwUUA7XITL6l5oJo4NgXKuzUC3DdNeN+QLe8iL0uz635sv+1guBOUKLinTGqy7Ic48qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg90abbR/XumeeHl/Z1kWzN7t8p05fYCmHzarMSDF6/lAbbukf
	wY8QhkoRncaNLOtEUdc89XlxRuCwuw3ESjwvGVqfccvT3G8JajJu
X-Google-Smtp-Source: AGHT+IHgi5Ryv8QHYtcvnpQhVFcLZaacH4p1EV3D1dfwmb2DiXZle4AD8ZfNOR440JzQ5Er/Hrvcww==
X-Received: by 2002:a05:6512:3c92:b0:533:3268:b959 with SMTP id 2adb3069b0e04-5353e5be1cfmr292882e87.53.1724879735962;
        Wed, 28 Aug 2024 14:15:35 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3? (p200300c78f2a85534dd47649c4c2f4e3.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a88c6d2c844sm72477066b.178.2024.08.28.14.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 14:15:35 -0700 (PDT)
Message-ID: <bbd42daa-319e-4390-99ac-7bf874fd0007@gmail.com>
Date: Wed, 28 Aug 2024 23:15:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] staging: rtl8712: Calculate size from pointer
To: Manisha Singh <masingh.linux@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <20240828204552.26790-4-masingh.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828204552.26790-4-masingh.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 22:45, Manisha Singh wrote:
> Calculate the size from the pointer instead of struct
> 
Hi Manisha,

the first line of the description is good. Please just add the why (to 
adhere to kernel coding style?) and the "." to make it a full sentence.

Omit the next two lines.
> CHECK: Prefer kmalloc(sizeof(*pintf_hdl->pintfpriv)...) over
> kmalloc(sizeof(struct intf_priv)...)
> 

Thanks for your support.

Bye Philipp

> Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl871x_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> index 6311ac15c581..8ad4647dad2f 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ b/drivers/staging/rtl8712/rtl871x_io.c
> @@ -48,7 +48,7 @@ static uint _init_intf_hdl(struct _adapter *padapter,
>   	set_intf_funs = &(r8712_usb_set_intf_funs);
>   	set_intf_ops = &r8712_usb_set_intf_ops;
>   	init_intf_priv = &r8712_usb_init_intf_priv;
> -	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
> +	pintf_priv = kmalloc(sizeof(*pintf_priv), GFP_ATOMIC);
>   	if (!pintf_priv)
>   		goto _init_intf_hdl_fail;
>   	pintf_hdl->pintfpriv = pintf_priv;


