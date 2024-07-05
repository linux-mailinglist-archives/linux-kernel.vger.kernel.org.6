Return-Path: <linux-kernel+bounces-242357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF592870F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518521C241EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A712148305;
	Fri,  5 Jul 2024 10:49:25 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB301145B21
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176564; cv=none; b=L+6yh2KfH+ztItEyZFYtBWH9AnxAHicr8PNDXiwMJIp8Ems0XeO29HxZbaidHNCLlGL7elFBx9n6K+7EKqwQu6bARM9lQ8w2C8kM1VAboidk0Uc/m2L16+7v6pdV4Y+LONadV6W8HPyFrG/hgw9xVnPviiQkDQb8ObK8amGrAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176564; c=relaxed/simple;
	bh=YGJJAUHiRlWaPWuLUj/FBlNouDzLhJ6UNZ9CbqxIJtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkwCNB70Zc6Bu8NpN+U3bzvheRrXyQcrXenmvYCPGYTSYawu1S2A136dBOqkFRhs/OsKUqBViOv0hK2Mb28fa5p3Q8rqEJFPhmUdCmnVNuOYFEPHcK5/nv+A5Ax0iR+uierpU+8pFySLvMt7PNL6nroXwz9oRiwxiOyzq94Org4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFqxS3GCbz6JB3f;
	Fri,  5 Jul 2024 18:48:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 63556140B38;
	Fri,  5 Jul 2024 18:49:12 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 11:49:11 +0100
Date: Fri, 5 Jul 2024 11:49:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Julia Lawall <julia.lawall@inria.fr>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, "Javier Carrasco"
	<javier.carrasco.cruz@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] soc: ti: pruss: do device_node auto cleanup
Message-ID: <20240705114911.0000761a@Huawei.com>
In-Reply-To: <20240703065710.13786-2-five231003@gmail.com>
References: <20240703065710.13786-1-five231003@gmail.com>
	<20240703065710.13786-2-five231003@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  3 Jul 2024 12:25:26 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> Use scope based cleanup instead of manual of_node_put() calls, hence
> simplifying the handling of error paths at various places.
> 
> While at it, refactor the setup code for device node "memories", from
> pruss_probe() into a new function pruss_of_setup_memories().  It is
> worth noticing that this step is a direct consequence of trying to
> minimize the scope of the "struct device_node" pointer to make auto
> cleanup read more cleanly.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
Hi.

A few minor comments inline.

Jonathan

> ---
>  drivers/soc/ti/pruss.c | 168 +++++++++++++++++++----------------------
>  1 file changed, 78 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 24a42e0b645c..9767d129a8ea 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -381,38 +381,82 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>  {
>  	const struct pruss_private_data *data;
> -	struct device_node *clks_np;
>  	struct device *dev = pruss->dev;
>  	int ret = 0;
>  
>  	data = of_device_get_match_data(dev);
>  
> -	clks_np = of_get_child_by_name(cfg_node, "clocks");
> -	if (!clks_np) {
> -		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
> -		return -ENODEV;
> -	}
> +	struct device_node *clks_np __free(device_node) =
> +			of_get_child_by_name(cfg_node, "clocks");
> +	if (!clks_np)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "%pOF is missing its 'clocks' node\n", cfg_node);
>  
>  	if (data && data->has_core_mux_clock) {
>  		ret = pruss_clk_mux_setup(pruss, pruss->core_clk_mux,
>  					  "coreclk-mux", clks_np);
> -		if (ret) {
> -			dev_err(dev, "failed to setup coreclk-mux\n");
> -			goto put_clks_node;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to setup coreclk-mux\n");
>  	}
>  
>  	ret = pruss_clk_mux_setup(pruss, pruss->iep_clk_mux, "iepclk-mux",
>  				  clks_np);
> -	if (ret) {
> -		dev_err(dev, "failed to setup iepclk-mux\n");
> -		goto put_clks_node;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to setup iepclk-mux\n");
>  
> -put_clks_node:
> -	of_node_put(clks_np);
> +	return 0;
> +}
>  
> -	return ret;
> +static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
> +{
> +	struct device_node *np = dev_of_node(dev);
> +	struct device_node *child __free(device_node) =
> +			of_get_child_by_name(np, "memories");
> +	int i;
> +
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "%pOF is missing its 'memories' node\n",
> +				     child);
> +
> +	for (i = 0; i < PRUSS_MEM_MAX; i++) {
> +		const struct pruss_private_data *data =
> +				of_device_get_match_data(dev);
> +		const char *mem_names[PRUSS_MEM_MAX] =
> +				{ "dram0", "dram1", "shrdram2" };

These are not per loop iteration. I'd pull them out of here.
Sure the compiler will probably figure it out, but the code will
more readable if it doesn't look like dev might change from
one iteration to the next.


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
> +		if (index < 0)
> +			return index;
> +
> +		if (of_address_to_resource(child, index, &res))
> +			return -EINVAL;
> +
> +		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
> +							resource_size(&res));
> +		if (!pruss->mem_regions[i].va)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "failed to parse and map memory resource %d %s\n",
> +					     i, mem_names[i]);
> +		pruss->mem_regions[i].pa = res.start;
> +		pruss->mem_regions[i].size = resource_size(&res);
> +
> +		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
> +			mem_names[i], &pruss->mem_regions[i].pa,
> +			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
> +	}
> +	return 0;
>  }
>  
>  static struct regmap_config regmap_conf = {
> @@ -424,26 +468,21 @@ static struct regmap_config regmap_conf = {
>  static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
>  {
>  	struct device_node *np = dev_of_node(dev);
> -	struct device_node *child;
> +	struct device_node *child __free(device_node) =
> +			of_get_child_by_name(np, "cfg");
>  	struct resource res;
>  	int ret;
>  
> -	child = of_get_child_by_name(np, "cfg");
> -	if (!child) {
> -		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
> -		return -ENODEV;
> -	}
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "%pOF is missing its 'cfg' node\n", child);
>  
> -	if (of_address_to_resource(child, 0, &res)) {
> -		ret = -ENOMEM;
> -		goto node_put;
> -	}
> +	if (of_address_to_resource(child, 0, &res))
> +		return -ENOMEM;
>  
>  	pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
> -	if (!pruss->cfg_base) {
> -		ret = -ENOMEM;
> -		goto node_put;
> -	}
> +	if (!pruss->cfg_base)
> +		return -ENOMEM;
>  
>  	regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
>  				     (u64)res.start);
> @@ -452,34 +491,22 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
>  	pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
>  						  &regmap_conf);
>  	kfree(regmap_conf.name);
> -	if (IS_ERR(pruss->cfg_regmap)) {
> -		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
> -			PTR_ERR(pruss->cfg_regmap));
> -		ret = PTR_ERR(pruss->cfg_regmap);
> -		goto node_put;
> -	}
> +	if (IS_ERR(pruss->cfg_regmap))
> +		return dev_err_probe(dev, PTR_ERR(pruss->cfg_regmap),
> +				     "regmap_init_mmio failed for cfg\n");
>  
>  	ret = pruss_clk_init(pruss, child);
>  	if (ret)
> -		dev_err(dev, "pruss_clk_init failed, ret = %d\n", ret);
> +		return dev_err_probe(dev, ret, "pruss_clk_init failed\n");
>  
> -node_put:
> -	of_node_put(child);
>  	return ret;
return 0;

Make it obvious that it can't be anything else and that if we reach
here we have succeeded.

>  }
>  
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
> @@ -494,48 +521,9 @@ static int pruss_probe(struct platform_device *pdev)
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
I'd have preferred a precursor patch that was just code movement then
a main one using the auto cleanup.

>  
>  	platform_set_drvdata(pdev, pruss);
>  


