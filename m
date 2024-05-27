Return-Path: <linux-kernel+bounces-190187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70D8CFAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A6C281EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B63A1BA;
	Mon, 27 May 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlK4XRE6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3F3B1AB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797104; cv=none; b=AhNrWnQNdDIUgb5Rry5N8jqhLBZQqifzU6rqc1FUDc58FtRq+MRn/Pjdo2sCaVe1yvJKyHNWfB99bo2hhqctklNKugWEsn7lsrgRelb3h6gm6cVFFruraHJlyXPOvJgCKvvvDcwXz9SEt4zb5B9MpDmvpracV5ReJgMlXAG/aZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797104; c=relaxed/simple;
	bh=+VKxq+YHCBlsMb47ofjRCtChcs3IJSVYNcd8K6UMZmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db5OGTiXvNdbqlUSWTWr/HMzICO6WtsfoPMVL/ZzVCqzGmUzbghqmrSocT9T1xReWvY4p7tXYZEcrk+qX/npDXhuU+N6vR+02oiu50X13La8rqCJPCGk1vuaB13JtI8Jpo67qXRBdeADBY+myLnjNCU6TLcamxGZArddnyIE5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlK4XRE6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354f89a59c6so582788f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716797101; x=1717401901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oiab9V+mCHP9zn1CnbxeVYdytMkVdLAk3pdibYKTdSw=;
        b=FlK4XRE6HU/i2Ol7U5a2aCs2TUCa3yWaBAlJT47tCj0qQyPxEspGp/WsBk2z8NV+E3
         1shKWpJpkvTJkTPJXB0wO1sg5YRdU7KOAMY3h51ecdqAhG98duEOyl7fditfeQ/KOMVy
         L0h46BdZSicTOZ+Cp72I6weR8A7gEizgBfy/Z4ruCaUNReqEyLu4sOJ+EIsf9yjgT5ZB
         GwRu0wC6MLY6W0BMVH418vpMRb2SqubAyi8iSWBZKuOWuRZK/6POmlOjvOgLAMc5V0Ka
         23ymUkxtgsCE6FlJAFtvaiH8jSUsBQbgKMl3Iqs3uhLiUdl8XuHSqrjSCjd0KeLXPLhg
         eojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797101; x=1717401901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oiab9V+mCHP9zn1CnbxeVYdytMkVdLAk3pdibYKTdSw=;
        b=Zo888Now5REn6UdjgnOK43AelOIBulZKKORRAn3zxxHhAT4CyDSLdXdPDAAid5L7Pk
         t9Ba5firCIaytV0lH0nNs0cI6GAJoMKFYHpRspNAFR+7lf2Y/PwAoYwUXP8rk2HQitnl
         7BOKmQ/GjjMtcQq0XFrB+qU4rDDur4hByLoCJDsAQmvAfXM7qG4vILZv3AP3AgTZc7CJ
         dDg0M6ItEZUm1VQ3iJ1u0eMGnoEJspMW+zOOxtNprfVMv3XKvzOBJZzUCUlbN6uZDh/E
         peZrhjTGuMN37qzB+cAZLj7iHEh/0BUVuZffTibIqBh6aAjB3rFZg9aEL80Se0Gf4i2U
         b9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUp5dXB1L1AmKk6sjn69Xzi72B2GnJfq2pa94ZTQ3PYsnqRaUKrqt85y9slQRqfVWUUC4gOBJn1bAe3BRslUKPwzQrcnYue3Dpy7RPX
X-Gm-Message-State: AOJu0Yw0ABv45bmKJjiBA6Ddim9z1YfpjYzlfbtkwDoBYZs8EdQryTuL
	yTetHFMPkSL/zR2+T87rituBmxRVInuG7TZrfZv/zDZr0EtQDKhl
X-Google-Smtp-Source: AGHT+IErKsdEXc1o9U/Jvz1gNnKUFNtYvEe2qYeHliDR538FuYFNRUep95WXDxdFAQwJtDPwQbu4SA==
X-Received: by 2002:adf:ffce:0:b0:354:cbc3:bd9d with SMTP id ffacd0b85a97d-35522125e22mr5259764f8f.0.1716797101348;
        Mon, 27 May 2024 01:05:01 -0700 (PDT)
Received: from [192.168.44.127] ([185.238.219.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35671d03330sm6794562f8f.64.2024.05.27.01.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:05:01 -0700 (PDT)
Message-ID: <9b623cb2-6c42-4e24-8be1-ba32b2682275@gmail.com>
Date: Mon, 27 May 2024 10:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Fix spelling mistake in rtl871x_io.h
To: Roshan Khatri <topofeverest8848@gmail.com>, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 ayushtiw0110@gmail.com, namcaov@gmail.com, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240525160230.66365-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240525160230.66365-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.05.24 18:02, Roshan Khatri wrote:
> This patch corrects misspelled word to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl871x_io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
> index c5b12f74ebf8..f09d50a29b82 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.h
> +++ b/drivers/staging/rtl8712/rtl871x_io.h
> @@ -62,7 +62,7 @@
>   #define IO_WR_BURST(x)		(IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | \
>   				((x) & _IOSZ_MASK_))
>   #define IO_RD_BURST(x)		(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
> -/*below is for the intf_option bit defition...*/
> +/*below is for the intf_option bit definition...*/
>   #define _INTF_ASYNC_	BIT(0)	/*support async io*/
>   struct intf_priv;
>   struct	intf_hdl;

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

