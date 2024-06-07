Return-Path: <linux-kernel+bounces-206438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F79009BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D81C2825A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299A199EA0;
	Fri,  7 Jun 2024 15:58:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E419414D;
	Fri,  7 Jun 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775897; cv=none; b=DVQRBI9jc9ZTl3gziuTzhVdgMTfgMb1lyETUvYPs6L5yPfsJ0e9dySDt0f95uu6P/Dcr2a/e31QOqXkpRn2A4t/FOnr5zMf4WwUjf/aO6FYsN9KDVGtuozhrwW8S5YT0A1on6aUjnlfmXEHXEcQgZBue/lVcEyG3Jfhls9ehLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775897; c=relaxed/simple;
	bh=wLmEPnGiH2sWjtpPH5jP3Z6lrRzcGqIBWkF60wZBWhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy5V0rnDwxqhtKTT+zxLCJVkVtvjTvIAkdq0Gk3CE7wxwJXaZxuazDBZi3wg5vs/kfCroPQll6Vz3hUshUBq+gUPTmNrLf4kSZAJx6JgdR1bz67VZ/7gcLsNX/OiDFdMVFVxSo8qXuUW+SbWzuzOrfgvdD5k4EpiaMz6ZQdWfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F4315A1;
	Fri,  7 Jun 2024 08:58:39 -0700 (PDT)
Received: from [10.57.70.171] (unknown [10.57.70.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6B43F64C;
	Fri,  7 Jun 2024 08:58:12 -0700 (PDT)
Message-ID: <c803199b-7e0a-4086-96de-00cf95bae2fd@arm.com>
Date: Fri, 7 Jun 2024 16:58:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] coresight: tmc-etr: Add support to use reserved
 trace memory
Content-Language: en-GB
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-3-lcherian@marvell.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240605081725.622953-3-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linu

On 05/06/2024 09:17, Linu Cherian wrote:
> Add support to use reserved memory for coresight ETR trace buffer.
> 
> Introduce a new ETR buffer mode called ETR_MODE_RESRV, which
> becomes available when ETR device tree node is supplied with a valid
> reserved memory region.
> 
> ETR_MODE_RESRV can be selected only by explicit user request.
> 
> $ echo resrv >/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
> 
> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Reviewed-by: James Clark <james.clark@arm.com>

Some minor comments below.


> ---
> Changelog from v8:
> Added Reviewed-by tag.
> 
>   .../hwtracing/coresight/coresight-tmc-core.c  | 47 +++++++++++
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 79 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc.h   | 27 +++++++
>   3 files changed, 153 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 741ce1748e75..6beb69d74d0a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -23,6 +23,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/coresight.h>
>   #include <linux/amba/bus.h>
>   #include <linux/platform_device.h>
> @@ -400,6 +401,50 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
>   
>   static const struct amba_id tmc_ids[];
>   
> +static struct device_node *tmc_get_region_byname(struct device_node *node,
> +						 char *name)
> +{
> +	int index;
> +
> +	index = of_property_match_string(node, "memory-region-names", name);
> +	if (index < 0)
> +		return ERR_PTR(-ENODEV);
> +
> +	return of_parse_phandle(node, "memory-region", index);
> +}
> +
> +static void tmc_get_reserved_region(struct device *parent)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
> +	struct device_node *node;
> +	struct resource res;
> +	int rc;
> +
> +	node = tmc_get_region_byname(parent->of_node, "tracedata");
> +	if (IS_ERR_OR_NULL(node)) {
> +		dev_dbg(parent, "No reserved trace buffer specified\n");
> +		return;
> +	}
> +
> +	rc = of_address_to_resource(node, 0, &res);

This sequence is repeated again in the metadat area, where :

1. We get region by name.
2. Read the resource details.

Could we not make "the helper" do both and move the "of_node_put()" 
inside the helper ?

static int of_tmc_get_reserved_resource_by_name(struct device *dev,
					        const char *name,
					        struct resource *res)
{

 > +	int index, rc = -ENODEV;
 > +	struct device_node *node;

	if (!is_of_node(dev_fwnode(dev->fwnode)))
		return -ENODEV;
 > +
 > +	index = of_property_match_string(dev->of_node, 
"memory-region-names", name);
 > +	if (index < 0)
 > +		return rc;
 > +
 > +	node = of_parse_phandle(node, "memory-region", index);
	if (!node)
		return rc;

	if (!of_address_to_resource(node, 0, res) &&
	    res->start != 0 && resource_size(res) != 0)
		rc = 0;
	of_node_put(node);
	
	return rc;
}


> +	of_node_put(node);
> +	if (rc || res.start == 0 || resource_size(&res) == 0) {
> +		dev_err(parent, "Reserved trace buffer memory is invalid\n");
> +		return;
> +	}

and the caller does :

	if (of_tmc_get_reserved_area_by_name(parent, "tracedata", &res))
		return;

> +
> +	drvdata->crash_tbuf.vaddr = memremap(res.start,
> +						resource_size(&res),
> +						MEMREMAP_WC);
> +	if (IS_ERR_OR_NULL(drvdata->crash_tbuf.vaddr)) {
> +		dev_err(parent, "Reserved trace buffer mapping failed\n");
> +		return;
> +	}
> +
> +	drvdata->crash_tbuf.paddr = res.start;
> +	drvdata->crash_tbuf.size  = resource_size(&res);
> +}
> +
>   /* Detect and initialise the capabilities of a TMC ETR */
>   static int tmc_etr_setup_caps(struct device *parent, u32 devid,
>   			      struct csdev_access *access)
> @@ -510,6 +555,8 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>   		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
>   	}
>   
> +	tmc_get_reserved_region(dev);
> +
>   	desc.dev = dev;
>   
>   	switch (drvdata->config_type) {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e75428fa1592..041c428dd7cd 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -30,6 +30,7 @@ struct etr_buf_hw {
>   	bool	has_iommu;
>   	bool	has_etr_sg;
>   	bool	has_catu;
> +	bool	has_resrv;
>   };
>   
>   /*
> @@ -694,6 +695,75 @@ static const struct etr_buf_operations etr_flat_buf_ops = {
>   	.get_data = tmc_etr_get_data_flat_buf,
>   };
>   
> +/*
> + * tmc_etr_alloc_resrv_buf: Allocate a contiguous DMA buffer from reserved region.
> + */
> +static int tmc_etr_alloc_resrv_buf(struct tmc_drvdata *drvdata,
> +				  struct etr_buf *etr_buf, int node,
> +				  void **pages)
> +{
> +	struct etr_flat_buf *resrv_buf;
> +	struct device *real_dev = drvdata->csdev->dev.parent;
> +
> +	/* We cannot reuse existing pages for resrv buf */
> +	if (pages)
> +		return -EINVAL;
> +
> +	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
> +	if (!resrv_buf)
> +		return -ENOMEM;
> +
> +	resrv_buf->daddr = dma_map_resource(real_dev, drvdata->crash_tbuf.paddr,
> +					   drvdata->crash_tbuf.size,
> +					   DMA_FROM_DEVICE, 0);
> +	if (dma_mapping_error(real_dev, resrv_buf->daddr)) {
> +		dev_err(real_dev, "failed to map source buffer address\n");
> +		kfree(resrv_buf);
> +		return -ENOMEM;
> +	}
> +
> +	resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
> +	resrv_buf->size = etr_buf->size = drvdata->crash_tbuf.size;
> +	resrv_buf->dev = &drvdata->csdev->dev;
> +	etr_buf->hwaddr = resrv_buf->daddr;
> +	etr_buf->mode = ETR_MODE_RESRV;
> +	etr_buf->private = resrv_buf;
> +	return 0;
> +}
> +
> +static void tmc_etr_free_resrv_buf(struct etr_buf *etr_buf)
> +{
> +	struct etr_flat_buf *resrv_buf = etr_buf->private;
> +
> +	if (resrv_buf && resrv_buf->daddr) {


> +		struct device *real_dev = resrv_buf->dev->parent;
> +
> +		dma_unmap_resource(real_dev, resrv_buf->daddr,
> +				resrv_buf->size, DMA_FROM_DEVICE, 0);
> +	}
> +	kfree(resrv_buf);
> +}
> +
> +static void tmc_etr_sync_resrv_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> +{
> +	/*
> +	 * Adjust the buffer to point to the beginning of the trace data
> +	 * and update the available trace data.
> +	 */
> +	etr_buf->offset = rrp - etr_buf->hwaddr;
> +	if (etr_buf->full)
> +		etr_buf->len = etr_buf->size;
> +	else
> +		etr_buf->len = rwp - rrp;
> +}
> +
> +static const struct etr_buf_operations etr_resrv_buf_ops = {
> +	.alloc = tmc_etr_alloc_resrv_buf,
> +	.free = tmc_etr_free_resrv_buf,
> +	.sync = tmc_etr_sync_resrv_buf,
> +	.get_data = tmc_etr_get_data_flat_buf,
> +};
> +
>   /*
>    * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
>    * appropriately.
> @@ -800,6 +870,7 @@ static const struct etr_buf_operations *etr_buf_ops[] = {
>   	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
>   	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
>   	[ETR_MODE_CATU] = NULL,
> +	[ETR_MODE_RESRV] = &etr_resrv_buf_ops
>   };
>   
>   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
> @@ -825,6 +896,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
>   	case ETR_MODE_FLAT:
>   	case ETR_MODE_ETR_SG:
>   	case ETR_MODE_CATU:
> +	case ETR_MODE_RESRV:
>   		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
>   			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
>   						      node, pages);
> @@ -843,6 +915,7 @@ static void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
>   	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
>   	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>   	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
> +	buf_hw->has_resrv = is_tmc_reserved_region_valid(dev->parent);

Minor nit: In line with the other helpers, please could we rename this to :

tmc_has_reserved_buffer(drvdata) ?

We already have access to drvdata and we can pass that directly instead 
of passing the dev->parent and then fetch drvdata again.

>   }
>   
>   static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
> @@ -1830,6 +1903,7 @@ static const char *const buf_modes_str[] = {
>   	[ETR_MODE_FLAT]		= "flat",
>   	[ETR_MODE_ETR_SG]	= "tmc-sg",
>   	[ETR_MODE_CATU]		= "catu",
> +	[ETR_MODE_RESRV]	= "resrv",
>   	[ETR_MODE_AUTO]		= "auto",
>   };
>   
> @@ -1848,6 +1922,9 @@ static ssize_t buf_modes_available_show(struct device *dev,
>   	if (buf_hw.has_catu)
>   		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
>   
> +	if (buf_hw.has_resrv)
> +		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_RESRV]);
> +
>   	size += sysfs_emit_at(buf, size, "\n");
>   	return size;
>   }
> @@ -1875,6 +1952,8 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
>   		drvdata->etr_mode = ETR_MODE_ETR_SG;
>   	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
>   		drvdata->etr_mode = ETR_MODE_CATU;
> +	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
> +		drvdata->etr_mode = ETR_MODE_RESRV;
>   	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
>   		drvdata->etr_mode = ETR_MODE_AUTO;
>   	else
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c77763b49de0..c23dc9917ab9 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -135,6 +135,7 @@ enum etr_mode {
>   	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
>   	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
>   	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
> +	ETR_MODE_RESRV,		/* Use reserved region contiguous buffer */
>   	ETR_MODE_AUTO,		/* Use the default mechanism */
>   };
>   
> @@ -164,6 +165,17 @@ struct etr_buf {
>   	void				*private;
>   };
>   
> +/**
> + * @paddr	: Start address of reserved memory region.
> + * @vaddr	: Corresponding CPU virtual address.
> + * @size	: Size of reserved memory region.
> + */
> +struct tmc_resrv_buf {
> +	phys_addr_t     paddr;
> +	void		*vaddr;
> +	size_t		size;
> +};
> +
>   /**
>    * struct tmc_drvdata - specifics associated to an TMC component
>    * @pclk:	APB clock if present, otherwise NULL
> @@ -188,6 +200,10 @@ struct etr_buf {
>    * @idr_mutex:	Access serialisation for idr.
>    * @sysfs_buf:	SYSFS buffer for ETR.
>    * @perf_buf:	PERF buffer for ETR.
> + * @crash_tbuf:	Used by ETR as hardware trace buffer and for trace data
> + *		retention (after crash) only when ETR_MODE_RESRV buffer
> + *		mode is enabled. Used by ETF for trace data retention
> + *		(after crash) by default.

Minor nit: This need not be called crash_tbuf, could instead be
resrv_buf as we use it everywhere.

Suzuki


>    */
>   struct tmc_drvdata {
>   	struct clk		*pclk;
> @@ -213,6 +229,7 @@ struct tmc_drvdata {
>   	struct mutex		idr_mutex;
>   	struct etr_buf		*sysfs_buf;
>   	struct etr_buf		*perf_buf;
> +	struct tmc_resrv_buf	crash_tbuf;
>   };
>   
>   struct etr_buf_operations {
> @@ -330,6 +347,16 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>   	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>   }
>   
> +static inline bool is_tmc_reserved_region_valid(struct device *dev)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	if (drvdata->crash_tbuf.paddr &&
> +		drvdata->crash_tbuf.size)
> +		return true;
> +	return false;
> +}
> +
>   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
>   
>   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);


