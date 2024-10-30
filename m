Return-Path: <linux-kernel+bounces-388619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E39B6227
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F99B21F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCD1E5733;
	Wed, 30 Oct 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDJHrvzi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1151E376E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288722; cv=none; b=DGDyWNj6J+jZOHSLdxiAi5mkqQMUtbS8ZXspR2D33JNEEWqQe1gnqI+DTxpw4Wv/wbaJjhXnmipMKwsSOOkr6oEzYS0v5P/tksQTRQzWy7JrmA6w1Y1fHZhoNqdvctXEkHKotqIabrABBFBu6oUCMxshWswadgFJeSZKeeXmaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288722; c=relaxed/simple;
	bh=w0GYEg+LFxq3vLAYtJEuPA8L1iKjtUZHq5licyRLyaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MU/NPjN+ET9mcUvPXuktnF+qRZXu2qPHm1T8uKAoi/cfLYhVex8Ktn1D1jMOdTtKWXNx82Fvmh49WSLCp+hmdfxQ3fkF7r+gPAMVWc3W1s+llvd9GOflld493iIP9TafqOzbZWZ2QsThWKnHn8dh0ySJZ1obJiE3LL6jxAt5HBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDJHrvzi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315abed18aso60245275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288717; x=1730893517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRTlMMdulNS4t7Utn/teiYYlIAHmyGJd+rw2+dNOPT8=;
        b=XDJHrvzin5IsYQWW5MfOooR+Y0/qc9/EolG5lON3y+o+STcTgsB6l9W0l/WFNEzkwK
         jP5Gy3VXRPdQnM+0ZU4N2S8ylK6Cpx5oYt9yOwDY97wuG90fPgWkGwF0xyMbfbUdSbJI
         sPDahCj7uv9Xa9LKsMmHnxkTGqhLNwghpGmbpUCGmRfLd2GWl7UsJjuCfSuqoS80SHxn
         a1KheuvIX3Nxu9CEF8/0t9ZTrzaAEBETyk0s08Ekk80E4Xq/7HhlgMGTnhNfGDGfs0dL
         oZ3YrCBoYhNeZLbjy3/1scdclWWAnbpcFNk16Nrs+c2EsKHoCsnT9rYEzP+Z7xYwhJge
         eW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288717; x=1730893517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRTlMMdulNS4t7Utn/teiYYlIAHmyGJd+rw2+dNOPT8=;
        b=uzUayZsghe+dhGVKvZ+HWhpypbKbSnF9cvZBKiTM4YGaHtqxp87Y5Hgf0n87/DwEIb
         9PEy6tf0cj/77vTqANzDUqFDx0vOPtMivhBthSK5UkCN2eRKCHW1cCxrp0NuCllU8PW2
         vPnqjCKFKJIX/pLxzCrZCEpInVGZmHqEfRi81XMmIBwq2VSfFYgqg5Sja6Ac0Cbm/1RC
         JjpqvWZy0b5Z2aEgn4+8UOwbord8TDRfOCGyefCneEY5AyAMc3DIg+Rb9DU4axCXzW7Y
         nBb3mw1xgkmlNqLbLvz2IqZGVVVnInRBXqgzDNZAa7nSagDLGlSOH26VSuYEVpwiFzvJ
         VAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlECCC2GwsM9YhH5T1B9AjdTOkLlObYR4S8BjJRjNg30h2oJMdLVztV1bdCtTX78S49gdeLTeH3za8b/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGON8ILirRyE9u1PDvZQDGj0KfacIdA3iHcwOtht4TBZlh/EH3
	GL4Hk1JYYapkQ6V/r/70F8oIHgquWDlxTbxK9dOVdutlZK1wH9+WEKSpz+3+zJ4=
X-Google-Smtp-Source: AGHT+IFhRIh+9dGeOayOm15oZMXod/rBU6ExE23pj44w94j9FntXD8S6utlDgPeArlr6epPz1dO7fQ==
X-Received: by 2002:a05:600c:35d3:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-4319ac7832dmr132578255e9.7.1730288717449;
        Wed, 30 Oct 2024 04:45:17 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d5edsm19091545e9.26.2024.10.30.04.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:45:17 -0700 (PDT)
Message-ID: <f9cb758d-28a5-44bd-9cb5-d7ac5108db1b@linaro.org>
Date: Wed, 30 Oct 2024 11:45:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] scsi: ufs: exynos: set ACG to be controlled by
 UFS_ACG_DISABLE
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-10-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-10-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> HCI_IOP_ACG_DISABLE is an undocumented register in the TRM but the
> downstream driver sets this register so we follow suit here.
> 
> The register is already 0 presumed to be set by the bootloader as
> the comment downstream implies the reset state is 1. So whilst this
> is a nop currently, it should help with suspend/resume.

It should help in case the bootloader changes I assume. I see
gs101_ufs_drv_init() gets called only at probe time, via
ufshcd_pltfrm_init().

> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/ufs/host/ufs-exynos.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index b0cbb147c7a1..fa4e61f152c4 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -76,6 +76,10 @@
>  #define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN |\
>  				 UNIPRO_PCLK_CTRL_EN |\
>  				 UNIPRO_MCLK_CTRL_EN)
> +
> +#define HCI_IOP_ACG_DISABLE	0x100
> +#define HCI_IOP_ACG_DISABLE_EN	BIT(0)
> +
>  /* Device fatal error */
>  #define DFES_ERR_EN		BIT(31)
>  #define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF |\
> @@ -220,10 +224,15 @@ static int exynos_ufs_shareability(struct exynos_ufs *ufs)
>  static int gs101_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
>  {
>  	struct ufs_hba *hba = ufs->hba;
> +	u32 reg;
>  
>  	/* Enable WriteBooster */
>  	hba->caps |= UFSHCD_CAP_WB_EN;
>  
> +	/* set ACG to be controlled by UFS_ACG_DISABLE */
> +	reg = hci_readl(ufs, HCI_IOP_ACG_DISABLE);
> +	hci_writel(ufs, reg & (~HCI_IOP_ACG_DISABLE_EN), HCI_IOP_ACG_DISABLE);
> +
>  	return exynos_ufs_shareability(ufs);
>  }
>  

