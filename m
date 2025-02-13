Return-Path: <linux-kernel+bounces-513534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007FAA34B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EF61888CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67971FF7D8;
	Thu, 13 Feb 2025 17:03:37 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94D28A2B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466217; cv=none; b=ohAq/+tFDLhKPeNqiNBkhbp4iaYOmj1nZEvsi6XqXhJlZ83Kmr2vXjE5wnqL31q6yUdwKx2DanLA360g8/bLXmH4jjOOCk0PNjaRsde2o878JhwWCoxg+XWSKYBYVpkT5ThR18lr0NqqvNCu9R3lLCLAQOzbY8Z0RoJwyB81CYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466217; c=relaxed/simple;
	bh=5ZegvEKMTj3ZzsQpAOukJqsaJqss5n7vrVwbzqjdPls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IdWeen/vSKBQASUbgE84K2qPEngHuxrvf/brYkzkHgMS+l5imCaUoZy019vKMb4jWToXZmeVwilz83Xy5X/0acXUytSPC4yJQYBhsLzNTt6kWAnR1iYTHQHU50AyLv0u9YyrAEkBncObO2ybJ9kbuUeh7HH4oZ+y/1JxUGEUID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 13 Feb
 2025 20:03:32 +0300
Received: from [192.168.211.132] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 13 Feb
 2025 20:03:32 +0300
Message-ID: <6a817784-f3d4-43c2-bd94-ac40c73e8583@fintech.ru>
Date: Thu, 13 Feb 2025 20:03:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon/ci_dpm: Remove needless NULL checks of dpm
 tables
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20250114135856.16192-1-n.zhandarovich@fintech.ru>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Language: en-US
In-Reply-To: <20250114135856.16192-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Gentle ping :)

On 1/14/25 16:58, Nikita Zhandarovich wrote:
> This patch removes useless NULL pointer checks in functions like
> ci_set_private_data_variables_based_on_pptable() and
> ci_setup_default_dpm_tables().
> 
> The pointers in question are initialized as addresses to existing
> structures such as rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk by
> utilizing & operator and therefore are not in danger of being NULL.
> 
> Fix this by removing extra checks thus cleaning the code a tiny bit.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index abe9d65cc460..7c3a960f486a 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -3405,12 +3405,8 @@ static int ci_setup_default_dpm_tables(struct radeon_device *rdev)
>  		&rdev->pm.dpm.dyn_state.cac_leakage_table;
>  	u32 i;
>  
> -	if (allowed_sclk_vddc_table == NULL)
> -		return -EINVAL;
>  	if (allowed_sclk_vddc_table->count < 1)
>  		return -EINVAL;
> -	if (allowed_mclk_table == NULL)
> -		return -EINVAL;
>  	if (allowed_mclk_table->count < 1)
>  		return -EINVAL;
>  
> @@ -3468,24 +3464,20 @@ static int ci_setup_default_dpm_tables(struct radeon_device *rdev)
>  	pi->dpm_table.vddc_table.count = allowed_sclk_vddc_table->count;
>  
>  	allowed_mclk_table = &rdev->pm.dpm.dyn_state.vddci_dependency_on_mclk;
> -	if (allowed_mclk_table) {
> -		for (i = 0; i < allowed_mclk_table->count; i++) {
> -			pi->dpm_table.vddci_table.dpm_levels[i].value =
> -				allowed_mclk_table->entries[i].v;
> -			pi->dpm_table.vddci_table.dpm_levels[i].enabled = true;
> -		}
> -		pi->dpm_table.vddci_table.count = allowed_mclk_table->count;
> +	for (i = 0; i < allowed_mclk_table->count; i++) {
> +		pi->dpm_table.vddci_table.dpm_levels[i].value =
> +			allowed_mclk_table->entries[i].v;
> +		pi->dpm_table.vddci_table.dpm_levels[i].enabled = true;
>  	}
> +	pi->dpm_table.vddci_table.count = allowed_mclk_table->count;
>  
>  	allowed_mclk_table = &rdev->pm.dpm.dyn_state.mvdd_dependency_on_mclk;
> -	if (allowed_mclk_table) {
> -		for (i = 0; i < allowed_mclk_table->count; i++) {
> -			pi->dpm_table.mvdd_table.dpm_levels[i].value =
> -				allowed_mclk_table->entries[i].v;
> -			pi->dpm_table.mvdd_table.dpm_levels[i].enabled = true;
> -		}
> -		pi->dpm_table.mvdd_table.count = allowed_mclk_table->count;
> +	for (i = 0; i < allowed_mclk_table->count; i++) {
> +		pi->dpm_table.mvdd_table.dpm_levels[i].value =
> +			allowed_mclk_table->entries[i].v;
> +		pi->dpm_table.mvdd_table.dpm_levels[i].enabled = true;
>  	}
> +	pi->dpm_table.mvdd_table.count = allowed_mclk_table->count;
>  
>  	ci_setup_default_pcie_tables(rdev);
>  
> @@ -4880,16 +4872,10 @@ static int ci_set_private_data_variables_based_on_pptable(struct radeon_device *
>  	struct radeon_clock_voltage_dependency_table *allowed_mclk_vddci_table =
>  		&rdev->pm.dpm.dyn_state.vddci_dependency_on_mclk;
>  
> -	if (allowed_sclk_vddc_table == NULL)
> -		return -EINVAL;
>  	if (allowed_sclk_vddc_table->count < 1)
>  		return -EINVAL;
> -	if (allowed_mclk_vddc_table == NULL)
> -		return -EINVAL;
>  	if (allowed_mclk_vddc_table->count < 1)
>  		return -EINVAL;
> -	if (allowed_mclk_vddci_table == NULL)
> -		return -EINVAL;
>  	if (allowed_mclk_vddci_table->count < 1)
>  		return -EINVAL;
>  


