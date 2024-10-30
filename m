Return-Path: <linux-kernel+bounces-388303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D79B5D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593C91C20F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED571E0DD6;
	Wed, 30 Oct 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSUEP7bJ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C991E0B76
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275955; cv=none; b=PnQBRDXb3bOCjFIzm8gZY7Oltf5LvrAO48PGTeoLVo3KD/7MlOPdw+vku2C25qkvlrunfzy0iQelXcM/kkS/gZALI1YXQJk4ZwkCdjlJ01Y27y6RjhB5hNxFzpHXEQ2bV1IhprJFbiUBa9lR4ZwnfLYcwb0AK95cFJOpm2897oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275955; c=relaxed/simple;
	bh=fGOeiitn4cJGXZHbq7R0xn62ncJf2WQGEoz0ME+iMbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUnxkeNVtrR6zwh3L+TE+W867Y4u7sEKLgWmWx6PAceeTJsAt7RhAyLteStEYxhGvIsrADjrOW8/0bs+6gKXJyMnj6rXR4ljSgB76y/qq3bPW2q5vUl8ZHQ+lkCc7QEZhc8W4wHrdu6bLTuFiPxOnwQVryfetd/V0MjxWddBQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSUEP7bJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a68480164so883653566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730275951; x=1730880751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz9wlAuOkzG9Bsbmp9By5wnGJg5X6riHYobC5TJfVgs=;
        b=eSUEP7bJKkqkcrz1eyGjsm4bPqIfub9MUwuVTzwuywZAHqT3yd6uBXQWic5/Syr59o
         RIbefviOCg2Ekx6ld0rdxkrSJC4Vwcx4evoC+GnMV49L2NbCDgWoXnAoraDAd6CNVuWL
         w75oNiviMvxdsGIIhADhP3SFek0xJpF4DY2msZTuCIEyYKEOi2Wk5P9FafODgXLE+WmD
         4wDmq9V8jKcv/sVQFeZEhv2SqsmGlDhfFsShhsUZMOGvE9XZxBUwtIa6iYmpjRuK1Jmz
         DHft8w26QONvYRQGxtdJN9hmoMskSaHtB/+Ulfm66x2v5KXls/aW6UbhIZFMeEFWXEes
         m/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275951; x=1730880751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz9wlAuOkzG9Bsbmp9By5wnGJg5X6riHYobC5TJfVgs=;
        b=b6Eun013pBJWLaJk3grTavGlWXxq6Kuvs1WuW85N0nQxNg3gKTBLomKZhgcOBTn1oT
         BZkaXEYYdHPqvtT6ofdGB4/StbXccPY7ZeNvXVM7h9PEAkgKPzmXbS48HupW3pqn4PHF
         tKSuHa+xHmUeH0wylu5qA8QrD7YBnFLkeAzVlBLGaNLgpX9H2ENJyD1x4pD3EbPtjgsd
         Rq4+hoteZTG/VAxYCCvDnJ32EbFbEcxMiGq/BrDn9m8t2YtGHO8+ByUHxnd5pVXWCTKr
         DqKV9E/hBli0iWnWtBu0HZjYZrUR3jrtH4+fu+II8MPFMJjV4NUlgatgBTdh6r3v4n81
         klTg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzd+z4oR6PEvhU6ueozBjivwL+4uMY6degwkoBqMteZ02pBEFGOBAR7RAVaJ2omoW/UkjSjTREUIhLB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2s+IoXdGc/9ObmFYi5YIuI/cLgITuH+jLz91K8v0wQasPbYD
	uCPJxMxhHT2QIvVnShQjw9z5CMkkdeLn2gIfp1ZdCWPSstv5DOODqfrB/w//8q3w5fsNU2i4wq5
	2
X-Google-Smtp-Source: AGHT+IEHTQ5wOu9NxUvBgVG3q+Vz5Q9uWU1Gz79aPOENRB/2Xj3YqbpYXp26n28FGcPh+P9z83I7JA==
X-Received: by 2002:a17:906:f591:b0:a9a:13dd:2734 with SMTP id a640c23a62f3a-a9de5f2641fmr1504885266b.36.1730275949334;
        Wed, 30 Oct 2024 01:12:29 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8549sm13364615e9.10.2024.10.30.01.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 01:12:28 -0700 (PDT)
Message-ID: <b9d7f990-112a-4cde-8f04-6f8c6cb96f9e@linaro.org>
Date: Wed, 30 Oct 2024 08:12:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] scsi: ufs: exynos: add check inside
 exynos_ufs_config_smu()
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-3-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-3-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> Move the EXYNOS_UFS_OPT_UFSPR_SECURE check inside exynos_ufs_config_smu().
> 
> This way all call sites will benefit from the check. This fixes a bug
> currently in the exynos_ufs_resume() path on gs101 which will cause
> a serror.

because resume() calls exynos_ufs_config_smu() and we ended up accessing
register fields that we shouldn't have.
> 
> Fixes: d11e0a318df8 ("scsi: ufs: exynos: Add support for Tensor gs101 SoC")
Cc: stable@vger.kernel.org

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/ufs/host/ufs-exynos.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index e25de4b86ac0..939d08bce545 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -724,6 +724,9 @@ static void exynos_ufs_config_smu(struct exynos_ufs *ufs)
>  {
>  	u32 reg, val;
>  
> +	if (ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE)
> +		return;
> +
>  	exynos_ufs_disable_auto_ctrl_hcc_save(ufs, &val);
>  
>  	/* make encryption disabled by default */
> @@ -1457,8 +1460,8 @@ static int exynos_ufs_init(struct ufs_hba *hba)
>  	if (ret)
>  		goto out;
>  	exynos_ufs_specify_phy_time_attr(ufs);
> -	if (!(ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE))
> -		exynos_ufs_config_smu(ufs);
> +
> +	exynos_ufs_config_smu(ufs);
>  
>  	hba->host->dma_alignment = DATA_UNIT_SIZE - 1;
>  	return 0;

