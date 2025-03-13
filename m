Return-Path: <linux-kernel+bounces-559659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A5A5F744
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE57A948A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C879267B1F;
	Thu, 13 Mar 2025 14:08:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258BF267AEA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874935; cv=none; b=WQF0SHvn4Tc1lJUa89J0oB0TU3EvtXMN76gK5lpuQqlsa/sv30OHgE1FVLkM0GkpE+XTiF/ZuNBYOt4mZ3H6F1hqUDGtPf1+8xWncd7C0XsdwNMxvQintRl9tJUt1LCQuyYtSsf989MSFLJBoKjWsDajr2IPskMXKRq7FZeSq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874935; c=relaxed/simple;
	bh=GM5Vbbv0sXx4IvuELCUOE6NuXse5q//sW3nZFqc1lbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOnumr47Zyc/w0t7nhieOZ0s2t56YifkgGCvWVLwLWUKIxKfzd+sFUg73thTQwTaZSjkDQX6qIAGBcDDt/k4Y/8OuULu4l90UBTGOl7hct5SYJgwTKHx42Virjb/JAiNnDbzBQ6RCIV6hzYCcsPAgYTgEhU3ZY/y9xVLuJF53A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B260F150C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:09:01 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 250A73F694
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:08:51 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:08:42 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: Remove unnecessary NULL check before
 clk_prepare_enable()
Message-ID: <Z9Lm6nSPphPfupEB@e110455-lin.cambridge.arm.com>
References: <20250313082907.2481547-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313082907.2481547-1-nichen@iscas.ac.cn>

On Thu, Mar 13, 2025 at 04:29:07PM +0800, Chen Ni wrote:
> clk_prepare_enable() already checked NULL clock parameter.
> Remove unneeded NULL check for clk here.

You're not saving anything here. If mdev->aclk is NULL you still end up
calling clk_prepare() and clk_enable() even if they return zero immediately.
And if you don't like the check for mdev->aclk not being NULL, you should
also move the clk_disable_unprepare() call outside the if() {...} block.

Best regards,
Liviu

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 5ba62e637a61..2b59830f0572 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -282,8 +282,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  
> -	if (mdev->aclk)
> -		clk_prepare_enable(mdev->aclk);
> +	clk_prepare_enable(mdev->aclk);
>  
>  	for (i = 0; i < mdev->n_pipelines; i++) {
>  		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

