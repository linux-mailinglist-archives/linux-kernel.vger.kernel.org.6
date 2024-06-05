Return-Path: <linux-kernel+bounces-202624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE688FCEDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573F21C250A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C219EEA1;
	Wed,  5 Jun 2024 12:39:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA719E7F8;
	Wed,  5 Jun 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591195; cv=none; b=afJpjQMSU+Wo4urlig1soTmlwTtafRuBXwGqIvbut/wI74MqmWVTsa/STfcI1wLBc4esdVO1x3VQ4+RacvAZ5e/k9zpCtBq2WFLz7CcJRm70w3GKNXd9XZS/erH4e3NUH6Bk77uPlH6fgAKras8fCENQmYciVB6cdPmn0JTv3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591195; c=relaxed/simple;
	bh=otSmJ0pkdmSbTtHg9x3aGkUGNLGMhSXxt63d9ZAtoAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTvpCNt/AzPdRnRKx/0eHwrDg33JqiH+msMRcpLuDXQuGAWhFwaydxx1DF35xsoy4+B8GtjnSKI8i2bNepono7SHQ55/v+JDwzS9EhdUd6lOPChgircSoyoRW5GBVen9VBh9rj5ZO0eIOyvPxyLcLXuVJ/93Gr4Mvbjz6Exu2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3BB9339;
	Wed,  5 Jun 2024 05:40:16 -0700 (PDT)
Received: from [10.57.39.129] (unknown [10.57.39.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39FE93F762;
	Wed,  5 Jun 2024 05:39:48 -0700 (PDT)
Message-ID: <b7f7403b-142a-4914-a787-f92292069d6d@arm.com>
Date: Wed, 5 Jun 2024 13:39:51 +0100
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
 <f44611fd-523a-4b4d-accd-20fdfbac178a@arm.com>
 <6dee4870-3ca2-46d7-a30b-014a7d34135a@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <6dee4870-3ca2-46d7-a30b-014a7d34135a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 12:43, AngeloGioacchino Del Regno wrote:
> Il 05/06/24 11:18, Steven Price ha scritto:
>> On 04/06/2024 13:39, AngeloGioacchino Del Regno wrote:
>>> MediaTek MT8188 has a Mali-G57 MC3 (Valhall-JM): add a new
>>> compatible and platform data using the same supplies and the
>>> same power domain lists as MT8183 (one regulator, three power
>>> domains).
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/gpu/drm/panfrost/panfrost_drv.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> index ef9f6c0716d5..4e2d9f671a0d 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> @@ -777,6 +777,14 @@ static const struct panfrost_compatible mediatek_mt8186_data = {
>>>   	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>>>   };
>>>   
>>> +static const struct panfrost_compatible mediatek_mt8188_data = {
>>> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
>>> +	.supply_names = mediatek_mt8183_b_supplies,
>>
>> I think this is a little confusing. Ideally we'd drop the existing
>> mediatek_xxx_supplies which are the same as default_supplies and just
>> use that instead.
>>
>>> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>>> +	.pm_domain_names = mediatek_mt8183_pm_domains,
>>
>> We'd want at least a comment explaining that this isn't a typo (i.e. /*
>> mt8188 uses the same pm domains as mt8183 */). But I'm also wondering if
>> it would be sensible to simply have one domain list, something like:
>>
>> --->8---
>> static const char * const mediatek_pm_domains[] = { "core0", "core1",
>> 						    "core2", "core3",
>> 						    "core4" };
>>
>> static const struct panfrost_compatible mediatek_mt8183_data = {
>> 	...
>> 	.num_pm_domains = 3,
>> 	.pm_domain_names = mediatek_pm_domains,
>> };
>> ...
>> static const struct panfrost_compatible mediatek_mt8186_data = {
>> 	...
>> 	.num_pm_domains = 2,
>> 	.pm_domain_names = mediatek_pm_domains,
>> };
>> ...
>> static const struct panfrost_compatible mediatek_mt8188_data = {
>> 	...
>> 	.num_pm_domains = 3,
>> 	.pm_domain_names = mediatek_pm_domains,
>> };
>> ...
>> static const struct panfrost_compatible mediatek_mt8192_data = {
>> 	...
>> 	.num_pm_domains = 5,
>> 	.pm_domain_names = mediatek_pm_domains,
>> };
>> --->8---
>>
>> OTOH what you've got it no worse than what we already had, so it's up to
>> you whether you want to tidy this up or just add a comment so it doesn't
>> look like there's a typo.
>>
> 
> I didn't disclose my plan, but you've already shown part of it, so seeing that
> you preventively agree with at least part of that is fun :-)
> 
> I surely won't be able to do what I want to do for *this* cycle as I'm mostly
> sure that I won't have time for this in the next 3 weeks - but anyway....
> 
> What I was thinking is that we should either look for a number of power domains
> limited by a max power domains definition (that should already be present somewhere
> in panfrost if I recall correctly) without even caring about the actual power
> domain names, or we should look for a number of PDs having any name matching,
> in a for loop, snprintf(*something, sizeof(something), "core%d", i).
> 
> This means that, with the snprintf idea, we don't even have to set any
> pm_domain_names list anymore, at all, and we can either reuse num_pm_domains
> or just get the number of PDs limited by the binding - but that's a problem for
> the future me/us I guess...
> 
> But since we're there...
> 
> Please, I'd like to hear your opinion about the core%d idea :-)

I was tempted to suggest something like it... ;) But two things made me
wary:

 * It's a bigger change, and I didn't want to suggest such a large
refactor - let's get this patch in first.

 * There is no technical reason why designs will have a power domain per
core. In particular there is the concept of 'stacks' added in later GPUs
(so for these GPUs it should be "stack%d"). We also don't want the
bindings being decided based on the driver, so if there's an integration
which has e.g. "core01", "core23", etc we should support that rather
than encouraging people to invent different names just to make the
bindings easier.

Having said that, we could have special handling for
pm_domain_names==NULL where "core%d" is assumed, leaving the current
approach for any 'weird' GPU integrations that might crop up in the future.

> Anyway, I think that for now I'm choosing the "comment shortcut" for this patch.

Agreed - there's no point holding up adding support for a new GPU for
this clean up.

> P.S.: Thanks for the feedback!

No problem.

Thanks,

Steve

> Cheers,
> Angelo
> 
>> Steve
>>
>>> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>>> +};
>>> +
>>>   static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
>>>   static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
>>>   							   "core3", "core4" };
>>> @@ -808,6 +816,7 @@ static const struct of_device_id dt_match[] = {
>>>   	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>>>   	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
>>>   	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
>>> +	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
>>>   	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
>>>   	{}
>>>   };
>>
> 
> 
> 


