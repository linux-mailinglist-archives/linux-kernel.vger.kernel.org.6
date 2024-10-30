Return-Path: <linux-kernel+bounces-388682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A756A9B6309
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D827D1C20FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A71E8852;
	Wed, 30 Oct 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVO/w2uR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C31D1E7A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291130; cv=none; b=V6XgLDaBEE/iId/gLEeAnH/nB9u8gw1SzL7bN34eDChLnZzUtlYRkikM3S26P30QvbvLskmzi1ATdc6ViTvmjt8p4sXonU+zgcCdyCQgXzsLkuLIeczBvQEMgzpExvX9Lv4kN/GoYrShwXo/IjIKNaEMP4rIVKhYK3PgD9mUIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291130; c=relaxed/simple;
	bh=npPpKCfr8a/nX6dSWj7YKXfzbNKDFxy1Zti2s+52ors=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ7qx+yMY/QWpza8o98Eh504XeZ5CKxrMhb6kSpz8XLe97YN9jGeiBxNK4Mz0ut5TtPdSvzh4peh/6RwYI8DjhpyYwMCcjNEj2MkH5vss96qHR/HR6MTIr4p/sejk+8s2SE8fV4Tn3jFPlCTz6rXawvxwmKd4CpMGli1K1dOqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVO/w2uR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43169902057so61112305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730291127; x=1730895927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzgcGS1Hf9hdPADay9tMP9fc5ub7cUqD288aa3YpE9s=;
        b=vVO/w2uRVW8ebWK9xhcPJodZ34mYkotL7O9mM5egXirCYNThka4mVjC3eSNIphSAzr
         RNNmAU+xx0XHP3JuTCcru0E5B4dg6oUF5eeGvB+qJvRc7LeqpfAuLGI6yEgpTWWU5PTm
         JxQXv81QbKhH8h2EKvx6LJgSBTHT/vwN2+7w015cFSrW2p1NbjVHYK+eWCG4CXmj0UL2
         3ATAfnVl/gtzstbJ+SSzqv8iXSTJVbPhy7Hm2MmJ6+1b6Gf/7BS4ZC/6IrwwAwmw1L55
         3N9o5KG/FRdvGSTbPkYyN3hCabjn/B3hbytrPdDqBZdtHpeefGK4ugIK5tDRVvoe08Rm
         3M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730291127; x=1730895927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzgcGS1Hf9hdPADay9tMP9fc5ub7cUqD288aa3YpE9s=;
        b=ZLR9lVhFof7aLO7HU01ngy6aAD6bVUc5eustBtQFte5HvKEUKGfmEHf4CQ2BVAt6mf
         1Mg4c1JmjzfVEr+WISp7s4/O/JXlHVwl2k/Gj3I1GEdL5hN1a+RgioBWjclRjnErsmsh
         VP2PFxOavK1MPd8lYQevfzllUcniLUfeHao7IaHPDkrDTG/BfoiW49k5DJn/RkftiqVy
         C6oZzPC803paFdpaboyH3T375ihsl+LrA/GzxbWMDLAaB6P2K+/1x6FZbzYkUYLysrun
         5PnnORfeWIWIEwxuiLSK6kaoiz0YDYIv91qaQEUO/ODIGCKUQzuwFgE7e0uwiW2tVOS3
         MqxA==
X-Forwarded-Encrypted: i=1; AJvYcCW4OJawHGbXeG3Ds84aeX6CpRYBk15AZpn7ix9hUb+gaA7LPnKPH+t7Ggve+yzx6rvljon0LJbdKkgIWO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIC9qgp5qC7KfJm5DdIzvQ6grE7IvymEtx7Flo+KgToiJgyEP5
	erDlG0VFz+cqLx2Jtatj68S9wTkcWD4zRB3OU//Y8cyO0LMrSS72gh76rVajUIA=
X-Google-Smtp-Source: AGHT+IHoX4497mSUz/yxsu5fS7Yi5t7HC7XwVTZtKpVH7CT0vNJsNQn5cDMNxHVUOof05fQedX8kMw==
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id 5b1f17b1804b1-431bb9d1122mr31382025e9.26.1730291127043;
        Wed, 30 Oct 2024 05:25:27 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd918333sm20337295e9.10.2024.10.30.05.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 05:25:26 -0700 (PDT)
Message-ID: <6d3beeab-c26d-4240-b968-cb13d06d7eae@linaro.org>
Date: Wed, 30 Oct 2024 12:25:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] scsi: ufs: exynos: gs101: enable clock gating
 with hibern8
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-12-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-12-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> Enable clock gating and hibern8 capabilities for gs101. This
> leads to a significantly cooler phone when running the upstream
> kernel.
> 
> The exynos_ufs_post_hibern8() hook is also updated to remove the
> UIC_CMD_DME_HIBER_EXIT code path as this causes a hang on gs101.
> 
> The code path is removed rather than re-factored as no other SoC
> in ufs-exynos driver sets UFSHCD_CAP_HIBERN8_WITH_CLK_GATING
> capability. Additionally until the previous commit the hibern8
> callbacks were broken anyway as they expected a bool.

I think too it's fine to remove uneeded code as it was broken anyway.

> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/ufs/host/ufs-exynos.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 3bbb71f7bae7..7c8195f27bb6 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
cut

> @@ -1566,26 +1569,7 @@ static void exynos_ufs_post_hibern8(struct ufs_hba *hba, enum uic_cmd_dme cmd)
>  {

cut

> +	if (cmd == UIC_CMD_DME_HIBER_ENTER) {

I verified that the order of operations at hibern8_enter/exit() is sane:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

---
hibern8_notify() gets called in ufshcd_uic_hibern8_enter/exit()

exynos_ufs_post_hibern8 disables the clocks for:
  ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_ENTER, POST_CHANGE)

exynos_ufs_pre_hibern8() enables the clocks for:
  ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT, PRE_CHANGE);

