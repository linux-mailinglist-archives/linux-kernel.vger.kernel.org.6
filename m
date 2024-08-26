Return-Path: <linux-kernel+bounces-301842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78195F660
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC91C2209D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BF194AEA;
	Mon, 26 Aug 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfijHjDr"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832B186619
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689369; cv=none; b=oDoUvTpEeXREpUaqU1VqgLhNoG+GtKfWMyGauyMfme03ckYx/7ZG221fanLlZEu+h5OI8tc4mM9kn0yUhKjnDiYQNzK6989MXUd8SXY7oilo5FiVn5G4e2i1ecTci+eAguA14m1VKPj7hGgZH9BasNdDJ/r6/rzhyAmp3pN+HHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689369; c=relaxed/simple;
	bh=n17DFLWyl3CSI/X+WLKk0icF5uEAcJUa1ajvrl1pPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feQ9MAKW6QWj3DkUw1aqLmpJV/6BOR6IwicMC32f6ZfiD7RvGemSUlQ8gSa/jLe9/yUcjdMxIqtda4+44eXQVY9Zlvl9rvSrDDkYifZ5rCw/EW8UC3oHMqNcjMkUbKRtriZZwXe0bOJWlHt0Y1VC7nZGVdkcNDbcFinjPZsJwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfijHjDr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d2044b522so15603115ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724689367; x=1725294167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ5wZ/vKWIbDs4M6ax+M16y6/0zt2H1gMgY/mimetxo=;
        b=JfijHjDrD0t/bvnMJ1RTxXs0B4QKE+pXJ3i2BRrqHXmiItv2q7wIevAu002fz58tmW
         TKF0V+bDuDSYeyZzoFlZArhi16FqGCnJYuGZmMUCorTbMQY5zmnqREvSoVuxbAzBsePP
         lA3CVrjxwG+XnBUQPAIhtV6RooVbBOJN/dY3KcLnKqUEDZdrxC6I2UYSoszHMUXXofEp
         MlCXZ431hFlep8DGhQlUYyLL2BULqwusOEaXNdgPqeZt5KtbjSMr6P7hbvTe/hiWtF4L
         CQi8UlYhaLQK2LaHKv9JPLPHJ90Rc4Qwea1RIuBgGTSqdO7T8o+cBuVvfYanrp7g8QUN
         EMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689367; x=1725294167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ5wZ/vKWIbDs4M6ax+M16y6/0zt2H1gMgY/mimetxo=;
        b=TaPHaiQpQt4BkUHdHCjOxN2NE16XtST92xSRcJgAqWWRWMZlVrwnaFuZyDVOA/SbRv
         Sfhas6YJRF2SnnUkrgnoAV3xBOAfe4GGFyXyH7XkXSPASUaOf8ft+5S6jltEmxi3uHpm
         vA5ZFgD8tHUr1dMs2w+zyRCkLY/P1to+m1yOPnsx0rfkh7DY51BJeiyPjN0Pe1FhMeTM
         xjvmcb/cCpkPLBL54Zf7xGGqWzJNg9EKQEhPD8QhlxWIXQZagev+pDmnDSnEgHxLOIKu
         hpzwPEBuI8NTJ+g1JGosCTYoAe6eEI+YmGCmZoWAioGCURm+tupDQP59RuY8otvQ1ah6
         JtPg==
X-Forwarded-Encrypted: i=1; AJvYcCXLhV21Az9PwbjXNt5Uwx1+xeSDtE3sG6Cj9jdNKlfQbBopoocn3YrwtR19A9IJQHyXuxZdzmsLmi7tZ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1HjQlLskH3m6rtaMNv1PEcvk7bBCE+otsL2unU7fFXH0fovf
	L5ZGDDF1Vl3C5pSxAGwo0i6KmmQfRNuZOR6VLK+bgLEE60WhpEoZPIOneYDmYvc=
X-Google-Smtp-Source: AGHT+IFI3P8hGX0KfCf1HPUh36zOUQ9yWsLm6yuGu+xiFXneZ7zWnTsUEV3fUbMh6Xcdf6Ks6WUa7A==
X-Received: by 2002:a05:6e02:1905:b0:398:f487:5a04 with SMTP id e9e14a558f8ab-39e3c985372mr129550985ab.11.1724689367061;
        Mon, 26 Aug 2024 09:22:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:841:3fb0:c1d:cf23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad5529csm7634145a12.68.2024.08.26.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:22:46 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:22:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] remoteproc: xlnx: add sram support
Message-ID: <Zsyr0+za1Wy1BjI2@p14s>
References: <20240819170937.3666806-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819170937.3666806-1-tanmay.shah@amd.com>

Good morning,

First and foremost the overall structure of your code has improved immensely and
I commend you for that.

On Mon, Aug 19, 2024 at 10:09:38AM -0700, Tanmay Shah wrote:
> AMD-Xilinx zynqmp platform contains on-chip sram memory (OCM).
> R5 cores can access OCM and access is faster than DDR memory but slower
> than TCM memories available. Sram region can have optional multiple
> power-domains. Platform management firmware is responsible
> to operate these power-domains.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v4:
>   - Free previously allocalted genpool if adding carveouts fail for any
>     sram.
>   - add comment about sram size used in creating carveouts.
> 
> Changes in v3:
>   - make @sram an array rather than an array of pointers
>   - fix of_node_put usage to maintain proper refcount of node
>   - s/proprty/property
>   - Use gen pool framework for mapping sram address space.
> 
> Changes in v2:
>   - Expand commit message with power-domains related information.
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 165 ++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 2cea97c746fd..6d2ac7b85c8a 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/power/xlnx-zynqmp-power.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/genalloc.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/mailbox/zynqmp-ipi-message.h>
> @@ -56,6 +57,21 @@ struct mem_bank_data {
>  	char *bank_name;
>  };
>  
> +/**
> + * struct zynqmp_sram_bank - sram bank description
> + *
> + * @sram_pool: gen pool for his sram
> + * @sram_res: sram address region information
> + * @va: virtual address of allocated genpool
> + * @da: device address of sram
> + */
> +struct zynqmp_sram_bank {
> +	struct gen_pool *sram_pool;
> +	struct resource sram_res;
> +	void __iomem *va;
> +	u32 da;
> +};
> +
>  /**
>   * struct mbox_info
>   *
> @@ -120,6 +136,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   * struct zynqmp_r5_core
>   *
>   * @rsc_tbl_va: resource table virtual address
> + * @sram: Array of sram memories assigned to this core
> + * @num_sram: number of sram for this core
>   * @dev: device of RPU instance
>   * @np: device node of RPU instance
>   * @tcm_bank_count: number TCM banks accessible to this RPU
> @@ -131,6 +149,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   */
>  struct zynqmp_r5_core {
>  	void __iomem *rsc_tbl_va;
> +	struct zynqmp_sram_bank *sram;
> +	int num_sram;
>  	struct device *dev;
>  	struct device_node *np;
>  	int tcm_bank_count;
> @@ -494,6 +514,56 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int add_sram_carveouts(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct rproc_mem_entry *rproc_mem;
> +	struct zynqmp_sram_bank *sram;
> +	size_t len, pool_size;
> +	dma_addr_t dma_addr;
> +	int da, i;
> +
> +	for (i = 0; i < r5_core->num_sram; i++) {
> +		sram = &r5_core->sram[i];
> +
> +		dma_addr = (dma_addr_t)sram->sram_res.start;
> +
> +		/* Use actual resource size, as genpool size can be rounded up */
> +		len = resource_size(&sram->sram_res);
> +		da = sram->da;
> +
> +		pool_size = gen_pool_size(sram[i].sram_pool);
> +		sram->va = (void __iomem *)gen_pool_alloc(sram->sram_pool, pool_size);

The genpool subsystem API is used to allocate the genpool but other than
being free'd int zynqmp_r5_rproc_unprepare(), nothing is done with the genpool.
Do you have plans to change that in an upcoming patchset?  If not please remove.

Thanks,
Mathieu

> +		if (!sram->va) {
> +			dev_err(r5_core->dev, "failed to alloc sram idx %d pool\n", i);
> +			goto fail_add_sram_carveouts;
> +		}
> +
> +		rproc_mem = rproc_mem_entry_init(&rproc->dev, sram->va,
> +						 (dma_addr_t)dma_addr,
> +						 len, da,
> +						 NULL, NULL,
> +						 sram->sram_res.name);
> +
> +		rproc_add_carveout(rproc, rproc_mem);
> +		rproc_coredump_add_segment(rproc, da, len);
> +
> +		dev_dbg(&rproc->dev, "sram carveout %s addr=%llx, da=0x%x, size=0x%lx",
> +			sram->sram_res.name, dma_addr, da, len);
> +	}
> +
> +	return 0;
> +
> +fail_add_sram_carveouts:
> +	while (--i > 0) {
> +		pool_size = gen_pool_size(sram[i].sram_pool);
> +		gen_pool_free(sram[i].sram_pool,
> +			      (unsigned long)r5_core->sram[i].va, pool_size);
> +	}
> +
> +	return -ENOMEM;
> +}
> +
>  /*
>   * tcm_mem_unmap()
>   * @rproc: single R5 core's corresponding rproc instance
> @@ -669,6 +739,12 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>  		return ret;
>  	}
>  
> +	ret = add_sram_carveouts(rproc);
> +	if (ret) {
> +		dev_err(&rproc->dev, "failed to get sram carveout %d\n", ret);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -695,6 +771,12 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  				 "can't turn off TCM bank 0x%x", pm_domain_id);
>  	}
>  
> +	for (i = 0; i < r5_core->num_sram; i++) {
> +		gen_pool_free(r5_core->sram[i].sram_pool,
> +			      (unsigned long)r5_core->sram[i].va,
> +			      gen_pool_size(r5_core->sram[i].sram_pool));
> +	}
> +
>  	return 0;
>  }
>  
> @@ -881,6 +963,85 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	return ERR_PTR(ret);
>  }
>  
> +static int zynqmp_r5_get_sram_banks(struct zynqmp_r5_core *r5_core)
> +{
> +	struct device_node *np = r5_core->np;
> +	struct device *dev = r5_core->dev;
> +	struct zynqmp_sram_bank *sram;
> +	struct device_node *sram_np;
> +	int num_sram, i, ret;
> +	u64 abs_addr, size;
> +
> +	/* "sram" is optional property. Do not fail, if unavailable. */
> +	if (!of_property_present(r5_core->np, "sram"))
> +		return 0;
> +
> +	num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
> +	if (num_sram <= 0) {
> +		dev_err(dev, "Invalid sram property, ret = %d\n",
> +			num_sram);
> +		return -EINVAL;
> +	}
> +
> +	sram = devm_kcalloc(dev, num_sram,
> +			    sizeof(struct zynqmp_sram_bank), GFP_KERNEL);
> +	if (!sram)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_sram; i++) {
> +		sram_np = of_parse_phandle(np, "sram", i);
> +		if (!sram_np) {
> +			dev_err(dev, "failed to get sram %d phandle\n", i);
> +			ret = -EINVAL;
> +			goto fail_sram_get;
> +		}
> +
> +		if (!of_device_is_available(sram_np)) {
> +			dev_err(dev, "sram device not available\n");
> +			ret = -EINVAL;
> +			goto fail_sram_get;
> +		}
> +
> +		ret = of_address_to_resource(sram_np, 0, &sram[i].sram_res);
> +		if (ret) {
> +			dev_err(dev, "addr to res failed\n");
> +			goto fail_sram_get;
> +		}
> +
> +		sram[i].sram_pool = of_gen_pool_get(np, "sram", i);
> +		if (!sram[i].sram_pool) {
> +			dev_err(dev, "failed to get sram idx %d gen pool\n", i);
> +			ret = -ENOMEM;
> +			goto fail_sram_get;
> +		}
> +
> +		/* Get SRAM device address */
> +		ret = of_property_read_reg(sram_np, i, &abs_addr, &size);
> +		if (ret) {
> +			dev_err(dev, "failed to get reg property\n");
> +			goto fail_sram_get;
> +		}
> +
> +		sram[i].da = (u32)abs_addr;
> +
> +		of_node_put(sram_np);
> +
> +		dev_dbg(dev, "sram %d: name=%s, addr=0x%llx, da=0x%x, size=0x%llx\n",
> +			i, sram[i].sram_res.name, sram[i].sram_res.start,
> +			sram[i].da, resource_size(&sram[i].sram_res));
> +	}
> +
> +	r5_core->sram = sram;
> +	r5_core->num_sram = num_sram;
> +
> +	return 0;
> +
> +fail_sram_get:
> +	of_node_put(sram_np);
> +
> +	return ret;
> +}
> +
>  static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
>  {
>  	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> @@ -1095,6 +1256,10 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  				return ret;
>  			}
>  		}
> +
> +		ret = zynqmp_r5_get_sram_banks(r5_core);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> 
> base-commit: 1a491aaf1d1ce3a1cf5190394c36f21d805c7e96
> -- 
> 2.25.1
> 

