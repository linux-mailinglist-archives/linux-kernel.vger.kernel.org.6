Return-Path: <linux-kernel+bounces-181179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED958C788C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C81F21F35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403114B953;
	Thu, 16 May 2024 14:41:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311921DFEF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870505; cv=none; b=pMrkV8AjWBnjZPcvR3rIMm4IdcjBGyeZMe3Kh6qWnrD0OhpSNjYOwjX+lmu9ftEWCs4fpN4W39d/2imgUsu9h5Gh40qkGhZYyrZc6BDoWHeveRU7siSrCvG9/vRuDfAWj54zxvQaVgfyl+lMWSShMnfpzi1IfqKaUycM1az50hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870505; c=relaxed/simple;
	bh=tzZy4j++9qYRIlW3w4OXp4rGx/E08LjPSggDlXvRSos=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2ThOjM6+5gcIx06OuGmi8UX3zFsRijKoF8rD26e+CTbSPZ0zARrQKyz1m3HyQf6/FD0lg/tHrbAXJFfmAMAJ7/iV21GvwAAsx4dn5e43IvVQvzlRYF2pBERpO/jcP09jRw448uUBbTTgKJZ1lcnazltItpJ8b9ipNVlpQuIsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgCPZ6fsGz6JB95;
	Thu, 16 May 2024 22:38:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E7673140B35;
	Thu, 16 May 2024 22:41:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 May
 2024 15:41:32 +0100
Date: Thu, 16 May 2024 15:41:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Julia
 Lawall <julia.lawall@inria.fr>, Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] soc: ti: pruss: do device_node auto cleanup
Message-ID: <20240516154131.00007a8f@Huawei.com>
In-Reply-To: <20240510071432.62913-2-five231003@gmail.com>
References: <20240510071432.62913-1-five231003@gmail.com>
	<20240510071432.62913-2-five231003@gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 10 May 2024 12:43:22 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> Use scope based cleanup instead of manual of_node_put() calls, hence
> simplifying the handling of error paths at various places.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  drivers/soc/ti/pruss.c | 48 ++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 24a42e0b645c..8f238d59eca9 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -381,13 +381,13 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
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
> +	struct device_node *clks_np __free(device_node) =
> +			of_get_child_by_name(cfg_node, "clocks");
>  	if (!clks_np) {
>  		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
>  		return -ENODEV;
> @@ -398,7 +398,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>  					  "coreclk-mux", clks_np);
>  		if (ret) {
>  			dev_err(dev, "failed to setup coreclk-mux\n");
> -			goto put_clks_node;
> +			return ret;

This driver would also benefit from use of dev_err_probe() for all cases
like this that are called only from the probe() callback.
			return dev_err_probe(dev, ret, "failed to setup coreclk-mux\n2);

Handles any deferred cases nicely, but in general simplifies code by
making these printer error message and return cases a single line.


>  		}
>  	}
>  
> @@ -406,13 +406,10 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>  				  clks_np);
>  	if (ret) {
>  		dev_err(dev, "failed to setup iepclk-mux\n");
> -		goto put_clks_node;
> +		return ret;
>  	}
>  
> -put_clks_node:
> -	of_node_put(clks_np);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static struct regmap_config regmap_conf = {
> @@ -424,26 +421,22 @@ static struct regmap_config regmap_conf = {
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
>  	if (!child) {
>  		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
>  		return -ENODEV;
>  	}
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
> @@ -455,16 +448,13 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
>  	if (IS_ERR(pruss->cfg_regmap)) {
>  		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
>  			PTR_ERR(pruss->cfg_regmap));
> -		ret = PTR_ERR(pruss->cfg_regmap);
> -		goto node_put;
> +		return PTR_ERR(pruss->cfg_regmap);
>  	}
>  
>  	ret = pruss_clk_init(pruss, child);
>  	if (ret)
>  		dev_err(dev, "pruss_clk_init failed, ret = %d\n", ret);
>  
> -node_put:
> -	of_node_put(child);
>  	return ret;
>  }
>  
> @@ -472,7 +462,6 @@ static int pruss_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev_of_node(dev);
> -	struct device_node *child;
>  	struct pruss *pruss;
>  	struct resource res;
>  	int ret, i, index;
> @@ -494,7 +483,8 @@ static int pruss_probe(struct platform_device *pdev)
>  	pruss->dev = dev;
>  	mutex_init(&pruss->lock);
>  
> -	child = of_get_child_by_name(np, "memories");
> +	struct device_node *child __free(device_node) =
> +			of_get_child_by_name(np, "memories");

In this case, the scope of the device_node being held is increased quite
a bit.  Whilst that shouldn't be a problem, it is a bit ugly.

Perhaps factor this code out into another function similar to the ones above?

Jonathan


>  	if (!child) {
>  		dev_err(dev, "%pOF is missing its 'memories' node\n", child);
>  		return -ENODEV;
> @@ -510,22 +500,17 @@ static int pruss_probe(struct platform_device *pdev)
>  
>  		index = of_property_match_string(child, "reg-names",
>  						 mem_names[i]);
> -		if (index < 0) {
> -			of_node_put(child);
> +		if (index < 0)
>  			return index;
> -		}
>  
> -		if (of_address_to_resource(child, index, &res)) {
> -			of_node_put(child);
> +		if (of_address_to_resource(child, index, &res))
>  			return -EINVAL;
> -		}
>  
>  		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
>  							resource_size(&res));
>  		if (!pruss->mem_regions[i].va) {
>  			dev_err(dev, "failed to parse and map memory resource %d %s\n",
>  				i, mem_names[i]);
> -			of_node_put(child);
>  			return -ENOMEM;
>  		}
>  		pruss->mem_regions[i].pa = res.start;
> @@ -535,7 +520,6 @@ static int pruss_probe(struct platform_device *pdev)
>  			mem_names[i], &pruss->mem_regions[i].pa,
>  			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
>  	}
> -	of_node_put(child);
>  
>  	platform_set_drvdata(pdev, pruss);
>  


