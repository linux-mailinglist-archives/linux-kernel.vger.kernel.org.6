Return-Path: <linux-kernel+bounces-211433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F096905192
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4574B23CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1216F0E9;
	Wed, 12 Jun 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjRpCloa"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEB16D4D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192865; cv=none; b=tf2CAg39oxCkqI4MzuPxp0dQ3Fo5rkr13/rjJu0MnySG3JGHxAT2U/HXLl4g/rxOfvgWRSPxova/XrNPZKs0AnC/wRACCI894CC1zWdUZQXs/h51Xkhpi/wX0i7tGbLuGrJ7EUICXxga0LBmozWKHJrkd3Y4//S4p9J1NLCJB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192865; c=relaxed/simple;
	bh=VlzlBB0dCBI5lfoT0WJdI4XQI6RQ9zVg/+xsBEl6ioc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvY/DiyNjuk9kTplUrqURrjHPx87QFmgB6kepNeaWrhTRY4p4bmxKZR5hcLNOlQPlfbKxLn+xTQm8v5MppU6iunOAvE0pIB9Wm1JQHZfbR4pHlbiHcHYOprzkHaOtcir4/A/2fUUMxALD2id+CrazIDs1FnxAtVlZh+bCEG7Tqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjRpCloa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc1261f45so5310026e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718192862; x=1718797662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5DGSn0udcZbzTbE+TmEg1Luv49Nhw05suq5j2ttZc=;
        b=QjRpCloa+HmVNhezL1QLdaPm6UeiRBMVYBEyWjSAdw1iUlr+3vzeBS/0yYJVoX/bSc
         MocX5q989YvOVxTmfR7MGoZvRqBIDScXic7vzZTNryGaJIGPcPFi7G4uzqv+Jd5GX0pb
         izbjplqbEE1g1b5s+sA3drkqj87dehOMw2vdg/iVRuYvRCdxcIaoFVndIM/Zf3VfrTjW
         SsWm3yQYTjYXtIaZsusaHrel5pKZ7VWXfKcKIl9w6IvPgb9HAREP9Z3UzEqapIvR0eK0
         ORTLIw/y+2dZXnSIs7zm2O5ZWoFuh5xKVjQuDAqxMaomgebO9hKzEZLG6rXX4vC5tX7c
         nLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192862; x=1718797662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5DGSn0udcZbzTbE+TmEg1Luv49Nhw05suq5j2ttZc=;
        b=tBoUQEblLTFOPM4xdsIDGyaU3MVc9mNDAjahk1I+HhU4BjhDb1ruZUv4UHCRiG49Sw
         SSvhkl611TtBUrdmmqieDi41hG2SpTsIQTvUtdJ6LLL+PwYNL2BVMa1M1cR8Gs/aD2yQ
         tcFVoqJ+FQQfUT085S50fnMOESVmGevFg7em+OQaoHujdzVTdMmV6Vqf1ea+u4+bl1vG
         q+z5J3ll18HIeN2MqtbOPvJ/8Tmozq3/jwz+lIZhWWZF3bx/NeD8Q4w0ZSmpF09rqiaK
         oXYBNAFKjFv7DgLPru3kjKCJleMZItc1uLnwbHoLTYl9FYEcjwvh1xN/uIGRTAhbno86
         bS7A==
X-Forwarded-Encrypted: i=1; AJvYcCWvAIO4nfcG9cVXZyjPdr7GTKO7azxFGL8JqPtX520a+1f+LLzmY5NTu1kqU+MoOmakUbtf8Is0c5jkJKnr78p9ZfDK/p/3u2CCqy3S
X-Gm-Message-State: AOJu0YxrIGfIkjPsxVmjoUyYZIPgkT789/YVzn84fQNPXQo/t46Abi+4
	aq73Bzv7M+cd6khzMJMS+6jEmTgUQ5L4VcTwNGfmxd684Eik939w
X-Google-Smtp-Source: AGHT+IGhDuz2KvlTUdp0O3DO4ksfuwA794uBMR5acjGhmhWsSeadnd+8T0is6M6KXFOiMQjXVDi0ng==
X-Received: by 2002:a05:6512:1114:b0:52c:7f93:c2b9 with SMTP id 2adb3069b0e04-52c9a405535mr1097705e87.63.1718192862079;
        Wed, 12 Jun 2024 04:47:42 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c9582d285sm495994e87.228.2024.06.12.04.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:47:41 -0700 (PDT)
Message-ID: <9e9f27dc-80fb-4f0d-a29d-b418a7e96042@gmail.com>
Date: Wed, 12 Jun 2024 14:47:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: bd71815: fix ramp values
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
References: <ZmmJXtuVJU6RgQAH@latitude5580>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZmmJXtuVJU6RgQAH@latitude5580>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

Thanks for finding and fixing this!

On 6/12/24 14:42, Kalle Niemi wrote:
> Ramp values are inverted. This caused wrong values written to register
> when ramp values were defined in device tree.
> 
> Invert values in table to fix this.
> 
> Signed-off-by: Kalle Niemi <kaleposti@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
> ---
>   drivers/regulator/bd71815-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
> index 26192d55a685..79fbb45297f6 100644
> --- a/drivers/regulator/bd71815-regulator.c
> +++ b/drivers/regulator/bd71815-regulator.c
> @@ -256,7 +256,7 @@ static int buck12_set_hw_dvs_levels(struct device_node *np,
>    * 10: 2.50mV/usec	10mV 4uS
>    * 11: 1.25mV/usec	10mV 8uS
>    */
> -static const unsigned int bd7181x_ramp_table[] = { 1250, 2500, 5000, 10000 };
> +static const unsigned int bd7181x_ramp_table[] = { 10000, 5000, 2500, 1250 };
>   
>   static int bd7181x_led_set_current_limit(struct regulator_dev *rdev,
>   					int min_uA, int max_uA)
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


