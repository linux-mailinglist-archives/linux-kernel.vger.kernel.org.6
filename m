Return-Path: <linux-kernel+bounces-183099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63918C9492
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 13:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5541F2181F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8445BEC;
	Sun, 19 May 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oim1VTKa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACB2A1D2;
	Sun, 19 May 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716119902; cv=none; b=f/nQRO9bryEpDoeBd/xKf3ZIJqQXSKCpvy/H99aH5BeYKvDngKIKhFuJsglFIdPIbkIh+wE0zm1Yc7KahNFmFEi8mBr2zc2CKstAZxaq/eW3dykc01DoPMCs1xuZXFbVj9bOgrBfLDYrCpiyYrpJ3FEbkC02/I5TBcPomWI2fUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716119902; c=relaxed/simple;
	bh=mTgo2YitYHK1KoUwLjWoZIyp9zqbssF77Gq7r3cJ/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkOoXDXVidqdpqWp7HlbPiKB6t605NRo+3ahAjT6Hgm8fkdchU+IwWuznXablUBoCTWIPUuoLMpIMVzVhrvzHii+RJa3yHw1cCdSn8RIPghw/xgipcRMg0Rj9z0mCA2IM/NbruAjYgMGquArYmG/9akFnGeMx3AaDuZS9PhHr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oim1VTKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338FC32781;
	Sun, 19 May 2024 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716119902;
	bh=mTgo2YitYHK1KoUwLjWoZIyp9zqbssF77Gq7r3cJ/dE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oim1VTKaFqFTTSe/mezVwyXOe+1vWVWw9yaGAMvAXAhoodoosGNznnPBlkDGRxdQO
	 YHTUZYKkNLrY5ofljOrFMwwAqwFvG6fd/9tNn6hp3acrpnFYeq9BNFrd7DQimJcl6z
	 jGbRJg8Xos41epHkYGNCSojPXH7chVXMNh0yscUB3C3QZRTLSgQN7RNQqOn4nvsPRY
	 UtOgGopwySr4bx1eiOGZMnSDCWqzTbJ0l3GctNqWhERQql+s7+mJp5exuBlFO7MT3W
	 z+SoTEoq1UTLgsVfg/IVmCUcyQ+8XeDM846we50jiLrEPNGbbEF6+fH+sUNvp3cmK8
	 wvWPn6JoUTtfw==
Date: Sun, 14 Apr 2024 17:55:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: Use scope based of_node_put() cleanups
Message-ID: <20240414175539.517d677f@jic23-huawei>
In-Reply-To: <20240409-dt-cleanup-free-v2-3-5b419a4af38d@kernel.org>
References: <20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org>
	<20240409-dt-cleanup-free-v2-3-5b419a4af38d@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 13:59:41 -0500
Rob Herring <robh@kernel.org> wrote:

> Use the relatively new scope based of_node_put() cleanup to simplify
> function exit handling. Doing so reduces the chances of forgetting an
> of_node_put() and simplifies error paths by avoiding the need for goto
> statements.
> 
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Also use cleanup for 'dev' in __of_translate_address()
>  - Further simplify of_dma_is_coherent() and of_mmio_is_nonposted()
> ---
>  drivers/of/address.c  | 113 +++++++++++++++++---------------------------------
>  drivers/of/property.c |  22 ++++------
>  2 files changed, 46 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index ae46a3605904..c350185ceaeb 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -486,34 +486,30 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>   * device that had registered logical PIO mapping, and the return code is
>   * relative to that node.
>   */
> -static u64 __of_translate_address(struct device_node *dev,
> +static u64 __of_translate_address(struct device_node *node,
>  				  struct device_node *(*get_parent)(const struct device_node *),
>  				  const __be32 *in_addr, const char *rprop,
>  				  struct device_node **host)
>  {
> -	struct device_node *parent = NULL;
> +	struct device_node *dev __free(device_node) = of_node_get(node);
> +	struct device_node *parent __free(device_node) = get_parent(dev);
>  	struct of_bus *bus, *pbus;
>  	__be32 addr[OF_MAX_ADDR_CELLS];
>  	int na, ns, pna, pns;
> -	u64 result = OF_BAD_ADDR;
>  
>  	pr_debug("** translation for device %pOF **\n", dev);
>  
> -	/* Increase refcount at current level */
> -	of_node_get(dev);
> -
>  	*host = NULL;
> -	/* Get parent & match bus type */
> -	parent = get_parent(dev);
> +
>  	if (parent == NULL)
> -		goto bail;
> +		return OF_BAD_ADDR;
>  	bus = of_match_bus(parent);
>  
>  	/* Count address cells & copy address locally */
>  	bus->count_cells(dev, &na, &ns);
>  	if (!OF_CHECK_COUNTS(na, ns)) {
>  		pr_debug("Bad cell count for %pOF\n", dev);
> -		goto bail;
> +		return OF_BAD_ADDR;
>  	}
>  	memcpy(addr, in_addr, na * 4);
>  
> @@ -533,8 +529,7 @@ static u64 __of_translate_address(struct device_node *dev,
>  		/* If root, we have finished */
>  		if (parent == NULL) {
>  			pr_debug("reached root node\n");
> -			result = of_read_number(addr, na);
> -			break;
> +			return of_read_number(addr, na);
>  		}
>  
>  		/*
> @@ -543,11 +538,11 @@ static u64 __of_translate_address(struct device_node *dev,
>  		 */
>  		iorange = find_io_range_by_fwnode(&dev->fwnode);
>  		if (iorange && (iorange->flags != LOGIC_PIO_CPU_MMIO)) {
> -			result = of_read_number(addr + 1, na - 1);
> +			u64 result = of_read_number(addr + 1, na - 1);
>  			pr_debug("indirectIO matched(%pOF) 0x%llx\n",
>  				 dev, result);
> -			*host = of_node_get(dev);
> -			break;
> +			*host = no_free_ptr(dev);
> +			return result;
>  		}
>  
>  		/* Get new parent bus and counts */
> @@ -555,7 +550,7 @@ static u64 __of_translate_address(struct device_node *dev,
>  		pbus->count_cells(dev, &pna, &pns);
>  		if (!OF_CHECK_COUNTS(pna, pns)) {
>  			pr_err("Bad cell count for %pOF\n", dev);
> -			break;
> +			return OF_BAD_ADDR;
>  		}
>  
>  		pr_debug("parent bus is %s (na=%d, ns=%d) on %pOF\n",
> @@ -563,7 +558,7 @@ static u64 __of_translate_address(struct device_node *dev,
>  
>  		/* Apply bus translation */
>  		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
> -			break;
> +			return OF_BAD_ADDR;
>  
>  		/* Complete the move up one level */
>  		na = pna;
> @@ -572,11 +567,8 @@ static u64 __of_translate_address(struct device_node *dev,
>  
>  		of_dump_addr("one level translation:", addr, na);
>  	}
> - bail:
> -	of_node_put(parent);
> -	of_node_put(dev);
>  
> -	return result;
> +	return OF_BAD_ADDR;
>  }
>  
>  u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
> @@ -654,19 +646,16 @@ EXPORT_SYMBOL(of_translate_dma_address);
>  const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
>  				      phys_addr_t *start, size_t *length)
>  {
> -	struct device_node *parent;
> +	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
>  	u64 address, size;
>  	int na, ns;
>  
> -	parent = __of_get_dma_parent(dev);
>  	if (!parent)
>  		return NULL;
>  
>  	na = of_bus_n_addr_cells(parent);
>  	ns = of_bus_n_size_cells(parent);
>  
> -	of_node_put(parent);
> -
>  	address = of_translate_dma_address(dev, prop);
>  	if (address == OF_BAD_ADDR)
>  		return NULL;
> @@ -688,21 +677,19 @@ const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
>  {
>  	const __be32 *prop;
>  	unsigned int psize;
> -	struct device_node *parent;
> +	struct device_node *parent __free(device_node) = of_get_parent(dev);
>  	struct of_bus *bus;
>  	int onesize, i, na, ns;
>  
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
>  	if (parent == NULL)
>  		return NULL;
> +
> +	/* match the parent's bus type */
>  	bus = of_match_bus(parent);
> -	if (strcmp(bus->name, "pci") && (bar_no >= 0)) {
> -		of_node_put(parent);
> +	if (strcmp(bus->name, "pci") && (bar_no >= 0))
>  		return NULL;
> -	}
> +
>  	bus->count_cells(dev, &na, &ns);
> -	of_node_put(parent);
>  	if (!OF_CHECK_ADDR_COUNT(na))
>  		return NULL;
>  
> @@ -888,14 +875,13 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
>   */
>  int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  {
> -	struct device_node *node = of_node_get(np);
> +	struct device_node *node __free(device_node) = of_node_get(np);
>  	const __be32 *ranges = NULL;
>  	bool found_dma_ranges = false;
>  	struct of_range_parser parser;
>  	struct of_range range;
>  	struct bus_dma_region *r;
>  	int len, num_ranges = 0;
> -	int ret = 0;
>  
>  	while (node) {
>  		ranges = of_get_property(node, "dma-ranges", &len);
> @@ -905,10 +891,9 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  			break;
>  
>  		/* Once we find 'dma-ranges', then a missing one is an error */
> -		if (found_dma_ranges && !ranges) {
> -			ret = -ENODEV;
> -			goto out;
> -		}
> +		if (found_dma_ranges && !ranges)
> +			return -ENODEV;
> +
>  		found_dma_ranges = true;
>  
>  		node = of_get_next_dma_parent(node);
> @@ -916,10 +901,8 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  
>  	if (!node || !ranges) {
>  		pr_debug("no dma-ranges found for node(%pOF)\n", np);
> -		ret = -ENODEV;
> -		goto out;
> +		return -ENODEV;
>  	}
> -
>  	of_dma_range_parser_init(&parser, node);
>  	for_each_of_range(&parser, &range) {
>  		if (range.cpu_addr == OF_BAD_ADDR) {
> @@ -930,16 +913,12 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  		num_ranges++;
>  	}
>  
> -	if (!num_ranges) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!num_ranges)
> +		return -EINVAL;
>  
>  	r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> -	if (!r) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!r)
> +		return -ENOMEM;
>  
>  	/*
>  	 * Record all info in the generic DMA ranges array for struct device,
> @@ -957,9 +936,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  		r->size = range.size;
>  		r++;
>  	}
> -out:
> -	of_node_put(node);
> -	return ret;
> +	return 0;
>  }
>  #endif /* CONFIG_HAS_DMA */
>  
> @@ -1016,24 +993,18 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
> -	struct device_node *node;
> -	bool is_coherent = dma_default_coherent;
> -
> -	node = of_node_get(np);
> +	struct device_node *node __free(device_node) = of_node_get(np);
>  
>  	while (node) {
> -		if (of_property_read_bool(node, "dma-coherent")) {
> -			is_coherent = true;
> -			break;
> -		}
> -		if (of_property_read_bool(node, "dma-noncoherent")) {
> -			is_coherent = false;
> -			break;
> -		}
> +		if (of_property_read_bool(node, "dma-coherent"))
> +			return true;
> +
> +		if (of_property_read_bool(node, "dma-noncoherent"))
> +			return false;
> +
>  		node = of_get_next_dma_parent(node);
>  	}
> -	of_node_put(node);
> -	return is_coherent;
> +	return dma_default_coherent;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>  
> @@ -1049,20 +1020,14 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>   */
>  static bool of_mmio_is_nonposted(struct device_node *np)
>  {
> -	struct device_node *parent;
> -	bool nonposted;
> -
>  	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
>  		return false;
>  
> -	parent = of_get_parent(np);
> +	struct device_node *parent __free(device_node) = of_get_parent(np);
>  	if (!parent)
>  		return false;
>  
> -	nonposted = of_property_read_bool(parent, "nonposted-mmio");
> -
> -	of_node_put(parent);
> -	return nonposted;
> +	return of_property_read_bool(parent, "nonposted-mmio");
>  }
>  
>  static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..b73daf81c99d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -40,15 +40,12 @@
>   */
>  bool of_graph_is_present(const struct device_node *node)
>  {
> -	struct device_node *ports, *port;
> +	struct device_node *ports __free(device_node) = of_get_child_by_name(node, "ports");
>  
> -	ports = of_get_child_by_name(node, "ports");
>  	if (ports)
>  		node = ports;
>  
> -	port = of_get_child_by_name(node, "port");
> -	of_node_put(ports);
> -	of_node_put(port);
> +	struct device_node *port __free(device_node) = of_get_child_by_name(node, "port");
>  
>  	return !!port;
>  }
> @@ -610,9 +607,9 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
>   */
>  struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
>  {
> -	struct device_node *node, *port;
> +	struct device_node *port;
> +	struct device_node *node __free(device_node) = of_get_child_by_name(parent, "ports");
>  
> -	node = of_get_child_by_name(parent, "ports");
>  	if (node)
>  		parent = node;
>  
> @@ -626,8 +623,6 @@ struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
>  			break;
Trivial but you could use
			return port;
	}

	return NULL;

which I think would make the flow a tiny bit more obvious to anyone who doesn't
know that for_each_child_of_node() leaves it set to NULL on exit.

Maybe use the scoped form a a return_ptr() to make it obvious you are intentionally
holding on to the port node on exit?


>  	}
>  
> -	of_node_put(node);
> -
>  	return port;
>  }
>  EXPORT_SYMBOL(of_graph_get_port_by_id);
> @@ -655,14 +650,13 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>  	 * parent port node.
>  	 */
>  	if (!prev) {
> -		struct device_node *node;
> +		struct device_node *node __free(device_node) =
> +			of_get_child_by_name(parent, "ports");
>  
> -		node = of_get_child_by_name(parent, "ports");
>  		if (node)
>  			parent = node;
>  
>  		port = of_get_child_by_name(parent, "port");
> -		of_node_put(node);
Completely trivial but I'd drop the blank line to bring the error check
up into same block of code as the line that gets what it is checking.

>  
>  		if (!port) {
>  			pr_debug("graph: no port node found in %pOF\n", parent);


> 


