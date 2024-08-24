Return-Path: <linux-kernel+bounces-300164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F195DFB2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995E41C20CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B57DA68;
	Sat, 24 Aug 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oaPBxPAH"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D23CF5E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525413; cv=none; b=ZNo7vKk6P73U3YFpavUry2NjNUKV8usHG128fHnQi8qouvC1Dqk8jJdpggdM4j11AYHxX6mFl6tgKjL4qRMSrjZ0H+6jUqIUFfnmRPUuxGIpLeeiW5ZgIAnS0A2W6qdZQjO/hx4CyWTqE4SRauWOgjJdHx/N43+fPLCP++2BLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525413; c=relaxed/simple;
	bh=1eYdz/zau3RYXJaXno1Awf7NlV98Zrj5ocM0zAexwEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csDVMtc4+DroWAUEUqd7sA75L8VoVGEi080KPHpzQ2CgNRkS/7NaU5HgwTjlzPysepI3wszXfo00MSS9eHlkqKp2PssEEVqEKMGO5KikKnZsQR+O43ZEsgeDXQn277p7fZNOdtHDS0Hpck7RhqMatMPkuSi/tBnmbZ2QRjMpWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oaPBxPAH; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OInoe7017964;
	Sat, 24 Aug 2024 13:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724525390;
	bh=cTXwDdH5fYMans6AL7WAaQCqOrfwUgTk5ue5mciCuB8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oaPBxPAHBTQs5YHBvtyPZkI51brtncAdx1gbOdoUJPeX9gF5Aux1/tgXuqeV3+pVB
	 UiNQvy+tQ9YdYVOwr9sqyxQveuSsRe3kaftjv1H9KYwBkPNck6sFkrMjqbg1nxoy8X
	 0EljoV8twax77k79IG+RozjzY1dCexuJHuleul74=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OInoC2023438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:49:50 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:49:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:49:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OInosZ088292;
	Sat, 24 Aug 2024 13:49:50 -0500
Date: Sat, 24 Aug 2024 13:49:50 -0500
From: Nishanth Menon <nm@ti.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Julia Lawall
	<julia.lawall@inria.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] soc: ti: pruss: factor out memories setup
Message-ID: <20240824184950.gzsgdawt2ujjt6ky@subgroup>
References: <20240707055341.3656-1-five231003@gmail.com>
 <20240707055341.3656-2-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240707055341.3656-2-five231003@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:44-20240707, Kousik Sanagavarapu wrote:
> Factor out memories setup code from probe() into a new function
> pruss_of_setup_memories().  This sets the stage for introducing auto
> cleanup of the device node (done in the subsequent patch), since the
> clean up depends on the scope of the pointer and factoring out
> code into a seperate function obviously limits the scope of the various
typo s/seperate/separate - use --codespell with checkpatch to catch :)

A follow on patch has the same problem as well.

> variables used in that function.
> 
> Apart from the above, this change also has the advantage of making the
> code look more neat.
> 
> While at it, use dev_err_probe() instead of plain dev_err() as this new
> function is called by the probe().
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  drivers/soc/ti/pruss.c | 111 ++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 24a42e0b645c..a3c55a291b0b 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -415,6 +415,63 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>  	return ret;
>  }
>  
> +static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
> +{
> +	struct device_node *np = dev_of_node(dev);
> +	struct device_node *child;
> +	const struct pruss_private_data *data = of_device_get_match_data(dev);
> +	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
> +	int i;
> +
> +	child = of_get_child_by_name(np, "memories");
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "%pOF is missing its 'memories' node\n",
> +				     child);
> +
> +	for (i = 0; i < PRUSS_MEM_MAX; i++) {
> +		struct resource res;
> +		int index;
> +
> +		/*
> +		 * On AM437x one of two PRUSS units don't contain Shared RAM,
> +		 * skip it
> +		 */
> +		if (data && data->has_no_sharedram && i == PRUSS_MEM_SHRD_RAM2)
> +			continue;
> +
> +		index = of_property_match_string(child, "reg-names",
> +						 mem_names[i]);
> +		if (index < 0) {
> +			of_node_put(child);
> +			return index;
> +		}
> +
> +		if (of_address_to_resource(child, index, &res)) {
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +
> +		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
> +							resource_size(&res));
> +		if (!pruss->mem_regions[i].va) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "failed to parse and map memory resource %d %s\n",
> +					     i, mem_names[i]);
> +		}
> +		pruss->mem_regions[i].pa = res.start;
> +		pruss->mem_regions[i].size = resource_size(&res);
> +
> +		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
> +			mem_names[i], &pruss->mem_regions[i].pa,
> +			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
> +	}
> +	of_node_put(child);
> +
> +	return 0;
> +}
> +
>  static struct regmap_config regmap_conf = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
> @@ -471,15 +528,8 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
>  static int pruss_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev_of_node(dev);
> -	struct device_node *child;
>  	struct pruss *pruss;
> -	struct resource res;
> -	int ret, i, index;
> -	const struct pruss_private_data *data;
> -	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
> -
> -	data = of_device_get_match_data(&pdev->dev);
> +	int ret;
>  
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -494,48 +544,9 @@ static int pruss_probe(struct platform_device *pdev)
>  	pruss->dev = dev;
>  	mutex_init(&pruss->lock);
>  
> -	child = of_get_child_by_name(np, "memories");
> -	if (!child) {
> -		dev_err(dev, "%pOF is missing its 'memories' node\n", child);
> -		return -ENODEV;
> -	}
> -
> -	for (i = 0; i < PRUSS_MEM_MAX; i++) {
> -		/*
> -		 * On AM437x one of two PRUSS units don't contain Shared RAM,
> -		 * skip it
> -		 */
> -		if (data && data->has_no_sharedram && i == PRUSS_MEM_SHRD_RAM2)
> -			continue;
> -
> -		index = of_property_match_string(child, "reg-names",
> -						 mem_names[i]);
> -		if (index < 0) {
> -			of_node_put(child);
> -			return index;
> -		}
> -
> -		if (of_address_to_resource(child, index, &res)) {
> -			of_node_put(child);
> -			return -EINVAL;
> -		}
> -
> -		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
> -							resource_size(&res));
> -		if (!pruss->mem_regions[i].va) {
> -			dev_err(dev, "failed to parse and map memory resource %d %s\n",
> -				i, mem_names[i]);
> -			of_node_put(child);
> -			return -ENOMEM;
> -		}
> -		pruss->mem_regions[i].pa = res.start;
> -		pruss->mem_regions[i].size = resource_size(&res);
> -
> -		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
> -			mem_names[i], &pruss->mem_regions[i].pa,
> -			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
> -	}
> -	of_node_put(child);
> +	ret = pruss_of_setup_memories(dev, pruss);
> +	if (ret < 0)
> +		goto rpm_put;

Why? We have not called pm_runtime_enable at this point.

>  
>  	platform_set_drvdata(pdev, pruss);
>  
> -- 
> 2.45.2.561.g66ac6e4bcd
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

