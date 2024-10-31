Return-Path: <linux-kernel+bounces-390792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D230E9B7E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1B1F2166A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47911BB6BC;
	Thu, 31 Oct 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoeUYX/C"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC93137747
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388707; cv=none; b=jCkDLkU8FCR9FpDg8P9dWJSCX8YufX3Y0OghlYbQEbWIVDYaZ52gD3W6kAfCFJheecr8F0VfbHLBKDdYKlLOfAXj1Th2VA+JmhtiwrNdtX58LushF2gMg9hmRQFlCx4x5+4yYl6Evn/o97GN+aUnxmRijVT7UVmuqGCeRri/Jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388707; c=relaxed/simple;
	bh=CLn75NGygwynyS5wWXARtZWyikh4gsjLmayNvmdQzRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFxOxNRlbyevkDi8/JYIMWbL035od5Ti3V8XBj2OIweCujbdBdItS8UfOc/jDCBKopzKpi+vWauWrqH8nQ9MTRk2ARnoy/eVjHglK8qR6+jCS4RmdSx1GUL8TzjpVHbkLHXLrSKMj/deB6VrKMmCj15Yf7Te3b1BWSRJiDC8M2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoeUYX/C; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso688197f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730388702; x=1730993502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYbrKwbw3BAA3+t49U7pyQ6oV5144cNwkG87g9CyP+o=;
        b=hoeUYX/CsnGkgCMJn19/d99NVFe7MqyO4wpAi55Iby+REaNsDi+jRWh3dOVvRYM4L5
         lA//6bQpY0OYRdEvve0fk0FCcSD6xr2YkLLN664zOAUZGz+YTar3iM0zx3I+99F4fV/r
         BvsYNA7lVyTnHFGJypIuDTgjhAFxo9F21wMM0e8FgZ17VpcqU28mQeFPy+pnqD08Cd/z
         tRrVXhHrlCLzllZAVr+hicmmB/jzLrHTMAjLz96acwUxT3bqzOoC0WbUyhlkPEpz/Y20
         2VlzVdvwHLnWXet8wiM8jPCjmxJbyblgeKZu9JyhMslLxgS237FekXqpGskYuaB20RSP
         W6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388702; x=1730993502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYbrKwbw3BAA3+t49U7pyQ6oV5144cNwkG87g9CyP+o=;
        b=laNn7ZrNeQcbN7pN3qoSb8V2kFZiJKyXfdh3a6N9/YXGIP5N732olODTCxyhNPujzg
         vbo5sYOOxh4JPqWaHy8TUcKVP+5ASa//U2efl7f79wblcfGXFXjoDzMmpUQFMyCoB+05
         7XpsYrri+hZOr3bEm519dkzkbpGd1XGwfmCfxUVIji1SEiTXXFi6nOG9ROT2JZ9Yu/CG
         hI8i6F3++EL/OznFRK2EmbWev883zF7JVbbmgbzG7x1/2PNxnDiHdyq2CXXLJHfKTLdk
         33480XXvmPjhoLaSLCPo28O4MnxTuz/3yXpJQibFQjEHYpSfHSpUbUSwaPzRw6IZKLOZ
         YzWw==
X-Forwarded-Encrypted: i=1; AJvYcCW07frrSY8beKX+i1mKV8urppIg8sra3/6miGQwU2VPh1bBsf8ZRvU3JeEtx69QlH4Xzit6ntwsSmj4tJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHglbVcX/MXe8nshZAR6NW1Rj1l5pGerTfOjqJavpUXi6EIr7
	iOeFn159W26mIhvnh2EdEyK9zfO9xoAtGXbyq1iNgtrmdenn63YtOqtgK6akRL4=
X-Google-Smtp-Source: AGHT+IHq4BAfihy45utt2HuZFBKUWEdxRO+WgQHNsFD7CYtEQlEJVW+AsKh3p9Kl295OkYT0fhfpzg==
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-380610f2ea6mr15001892f8f.6.1730388702331;
        Thu, 31 Oct 2024 08:31:42 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4a46sm2481206f8f.41.2024.10.31.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:31:41 -0700 (PDT)
Message-ID: <9a2c9541-8b88-43af-84a9-7b39d3251ac6@linaro.org>
Date: Thu, 31 Oct 2024 15:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] scsi: ufs: exynos: Add
 EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR check
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: ebiggers@kernel.org, andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241031150033.3440894-1-peter.griffin@linaro.org>
 <20241031150033.3440894-7-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241031150033.3440894-7-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/24 3:00 PM, Peter Griffin wrote:
> The values calculated in exynos_ufs_specify_phy_time_attr() are only
> used in exynos_ufs_config_phy_time_attr() which is only called if the
> EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR flag is not set.
> 
> Add a check for this flag to exynos_ufs_specify_phy_time_attr() and
> return for platforms that don't set it.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> v3: update commit message (Tudor)
> ---
>  drivers/ufs/host/ufs-exynos.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 2c2fed691b95..0ac940690a15 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -541,6 +541,9 @@ static void exynos_ufs_specify_phy_time_attr(struct exynos_ufs *ufs)
>  	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
>  	struct ufs_phy_time_cfg *t_cfg = &ufs->t_cfg;
>  
> +	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)
> +		return;
> +
>  	t_cfg->tx_linereset_p =
>  		exynos_ufs_calc_time_cntr(ufs, attr->tx_dif_p_nsec);
>  	t_cfg->tx_linereset_n =

