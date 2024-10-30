Return-Path: <linux-kernel+bounces-388295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178669B5D52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F5B21CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F21DFE16;
	Wed, 30 Oct 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3IIUoYc"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B321348
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275469; cv=none; b=JdueVpnf65ZdIVIvrq4Mg5Tysp3atyLybm1RNzitIj6iOn4MApVOfbjSKQQOKBFoyMgiEAA35tZJI57bqENpmnuBEZyZ2PGGhI2XWA6VvIHYQBCZuyRcEFvXg36/4KJef2P0RSfgJjnCLh52jEQrC664T1z1O+95EfpJOlPft08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275469; c=relaxed/simple;
	bh=B+cw9PA/7VZt/fohppn2aNdkGFc4L/28zmOip6XYSe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9m9twmCHW3aUhsEZtmieFWZVkMAonJAD5evQvc45thvLI0IFuOXJnqND2omqQO+bv4jx10L/unXj+3vCwUXpI39r4UCp/8Dzz8WsLtQFEkLKi14JzNQ6StIYmveRzPO3BlNq6WxCmqzk/REYKJnxZ+F/okf697g5uq8yTVwHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3IIUoYc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso5545807e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730275465; x=1730880265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H93KKVpJbQ9UgwbZgl1kdPifbCt7HKUU//i7YU4EaJY=;
        b=l3IIUoYc7aPorQTgtEhf4hz3dyiHjXE9Y+obwFQGgd3pXDYinfWdFFjnpphWHee05v
         d+4Ke9Ly7VDhqo3LRk0UFpZTnM/1DoHjsCVI0wtmGa24BhXtmtXT9AfOSciavrgL2vWU
         XsNsdALDkx/626X5fFhtI8JpTAnb9EXccUjngMo+KGGu8kkU7gAZz1E3D7wfiRHDZD5O
         paEXXN5Q1e+CE+rRbXYMv3xf+3WimTO+30iGLArrN771aEsM1l6JKz5lOzuFDk5G9nHd
         HTYmOFjXpqrKFh+uju3uYRdxTwIdEC7lBIIuua277DjjYnpjROVYVJN/5ZaFFoX05LCB
         63Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275465; x=1730880265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H93KKVpJbQ9UgwbZgl1kdPifbCt7HKUU//i7YU4EaJY=;
        b=B3Ur+8eAaCdR06isEj+UMlkAa6+E2NaIr/tto1ezMKS8rUcNUjki27sNOJzo47QF8m
         of9kD02e84W4hmH+IzmYLbk8lVjjLh8E+ZP0J/nqQV1NfE+Lm8ny+RbS6OK2kgjxAAOj
         9xKLnxxFXlaF3ydVQ0ZkUmEDBUyURXWLfuiC1LRKgIB56zqZzclG0Ha3eulLvQ1a/dNa
         ghfdY3SEdlkriWlZsUdpV9e2py0cTOaoToYEwwmhlZAfDnqJS8F2Xo36atOHQYcuqv8R
         gIKybovzuQGT4G/MZVn909PXraPGQogPoR+2/QY9MZvKxYREF4MHwJqkKN6/qsKmBCkw
         JOrA==
X-Forwarded-Encrypted: i=1; AJvYcCWd3i60a+bEhJ5iT1gBqzDBA8TSKeEJaXqV59/ByZu1r8xKwV02NMejuhBr+n5VO0tz80cEspCvRMIHp0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTUadF2lCJyWbECHTUEl2acn/P0Myh3ql6F4mX3POQY4mL0ep
	XW+gtb1KE4pRU9M6P3NvOhP1m62QDpKMoRJhCWQg/QQF3N45YyF8qNsT7daehQ4=
X-Google-Smtp-Source: AGHT+IEZj9cR0ATu/JOPSB5irJVr/RnXyRQtlMK8w5XGhoTtI+E9S/Awq23Np24Aq1OO/+nXkl58yg==
X-Received: by 2002:ac2:4c41:0:b0:539:f65b:3f9 with SMTP id 2adb3069b0e04-53b347c0b08mr8580322e87.10.1730275464885;
        Wed, 30 Oct 2024 01:04:24 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm14792889f8f.42.2024.10.30.01.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 01:04:24 -0700 (PDT)
Message-ID: <74458ba4-af0f-4c41-92f5-c6c0cb79e930@linaro.org>
Date: Wed, 30 Oct 2024 08:04:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] scsi: ufs: exynos: Allow UFS Gear 4
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-2-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-2-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> UFS Gear 4 offers faster speeds, and better power usage so lets
> enable it.
> 
> Currently ufshcd_init_host_params() sets UFS_HS_G3 as a default,
> so even if the device supports G4 we end up negotiating down to
> G3.
> 
> For SoCs like gs101 which have a UFS major controller version
> of 3 or above advertise Gear 4. This then allows a Gear 4 link
> on Pixel 6.
> 
> For earlier controller versions keep the current default behaviour
> of reporting G3.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

some nits/personal preferences below, no need to address them

> ---
>  drivers/ufs/host/ufs-exynos.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 9ec318ef52bf..e25de4b86ac0 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -771,6 +771,21 @@ static void exynos_ufs_config_sync_pattern_mask(struct exynos_ufs *ufs,
>  	exynos_ufs_disable_ov_tm(hba);
>  }
>  
> +#define UFS_HW_VER_MAJOR_MASK   GENMASK(15, 8)
> +
> +static u32 exynos_ufs_get_hs_gear(struct ufs_hba *hba)
> +{
> +	u8 major;
> +
> +	major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, hba->ufs_version);
> +
> +	if (major >= 3)
> +		return UFS_HS_G4;
> +
> +	/* Default is HS-G3 */
> +	return UFS_HS_G3;
> +}
> +
>  static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
>  				struct ufs_pa_layer_attr *dev_max_params,
>  				struct ufs_pa_layer_attr *dev_req_params)
> @@ -787,6 +802,8 @@ static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
>  	}
>  
>  	ufshcd_init_host_params(&host_params);

blank line

> +	/* This driver only support symmetric gear setting e.g. hs_tx_gear == hs_rx_gear */
> +	host_params.hs_tx_gear = host_params.hs_rx_gear = exynos_ufs_get_hs_gear(hba);

I find it easier to read if you split inits on their own line:
	host_params.hs_tx_gear = exynos_ufs_get_hs_gear(hba);
	host_params.hs_rx_gear = exynos_ufs_get_hs_gear(hba);

>  
>  	ret = ufshcd_negotiate_pwr_params(&host_params, dev_max_params, dev_req_params);
>  	if (ret) {

