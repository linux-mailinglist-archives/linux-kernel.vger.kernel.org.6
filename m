Return-Path: <linux-kernel+bounces-202075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC08FC784
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B63B23466
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F418FC7E;
	Wed,  5 Jun 2024 09:18:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FFB49657;
	Wed,  5 Jun 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579102; cv=none; b=BekFCuSqpN0jjyOR9qINaIzaASaDvNQnzlfKh7TPltPr6o44kPuYM1Znt6rMTMsvK0b8mXzQxLnTxu7YWismr3vpIqOKmmLZVzqJiJhkOZccfdOI/c12+ufLlY2Dy628iTEI8V392akToR7cFOPChBxx0exakRKK8te5Y4xFpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579102; c=relaxed/simple;
	bh=6S3YpsbbS53ZfCt49YVCxFQF4BBA0IGGQrjEj4VK/zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcz11qbQDcQvuzpfaULPNs7VwTI+rZoDGVFyMVIO5In7pix8njnwjC2Dr05losK8syUwrmjou+5a0mhssiNWBgmQwRbqGZngq7ww//N8QmcLJVGlgwSkkqnQzoCYm7St+bQEkkwwFdjPpxLYkXM2JfxydF2Zh4WHOocMFIOlEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF2FDDA7;
	Wed,  5 Jun 2024 02:18:44 -0700 (PDT)
Received: from [10.57.39.129] (unknown [10.57.39.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 147E13F792;
	Wed,  5 Jun 2024 02:18:16 -0700 (PDT)
Message-ID: <f44611fd-523a-4b4d-accd-20fdfbac178a@arm.com>
Date: Wed, 5 Jun 2024 10:18:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panfrost: Add support for Mali on the MT8188
 SoC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 boris.brezillon@collabora.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
 <20240604123922.331469-3-angelogioacchino.delregno@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240604123922.331469-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 13:39, AngeloGioacchino Del Regno wrote:
> MediaTek MT8188 has a Mali-G57 MC3 (Valhall-JM): add a new
> compatible and platform data using the same supplies and the
> same power domain lists as MT8183 (one regulator, three power
> domains).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index ef9f6c0716d5..4e2d9f671a0d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -777,6 +777,14 @@ static const struct panfrost_compatible mediatek_mt8186_data = {
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  };
>  
> +static const struct panfrost_compatible mediatek_mt8188_data = {
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
> +	.supply_names = mediatek_mt8183_b_supplies,

I think this is a little confusing. Ideally we'd drop the existing
mediatek_xxx_supplies which are the same as default_supplies and just
use that instead.

> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
> +	.pm_domain_names = mediatek_mt8183_pm_domains,

We'd want at least a comment explaining that this isn't a typo (i.e. /*
mt8188 uses the same pm domains as mt8183 */). But I'm also wondering if
it would be sensible to simply have one domain list, something like:

--->8---
static const char * const mediatek_pm_domains[] = { "core0", "core1",
						    "core2", "core3",
						    "core4" };

static const struct panfrost_compatible mediatek_mt8183_data = {
	...
	.num_pm_domains = 3,
	.pm_domain_names = mediatek_pm_domains,
};
...
static const struct panfrost_compatible mediatek_mt8186_data = {
	...
	.num_pm_domains = 2,
	.pm_domain_names = mediatek_pm_domains,
};
...
static const struct panfrost_compatible mediatek_mt8188_data = {
	...
	.num_pm_domains = 3,
	.pm_domain_names = mediatek_pm_domains,
};
...
static const struct panfrost_compatible mediatek_mt8192_data = {
	...
	.num_pm_domains = 5,
	.pm_domain_names = mediatek_pm_domains,
};
--->8---

OTOH what you've got it no worse than what we already had, so it's up to
you whether you want to tidy this up or just add a comment so it doesn't
look like there's a typo.

Steve

> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +};
> +
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
>  static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
>  							   "core3", "core4" };
> @@ -808,6 +816,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>  	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
>  	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
> +	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
>  	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
>  	{}
>  };


