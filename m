Return-Path: <linux-kernel+bounces-259210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A39392A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABBC1C21596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7A16EBE2;
	Mon, 22 Jul 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQ73vEhn"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4016E89B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666365; cv=none; b=lmPfnNG/VwwUnEcvkuyBm3vh0A/LmDQjuk0auHcPiCR2bi9Uv81FsgyhLAvQk1hZOHRyoqKpIztNY+W6CgVDsee/CIqVxKsK49RyjRL9/mOsKF2pJsL1M4o2e0d6ra9VY+f0tmck7KI47IyEMTEnAE4Yhbt8Mianh+SRVv5VDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666365; c=relaxed/simple;
	bh=UCtOMZriDo+Q9tpJkqNXLwJn/SEOzuq5fzYAswLa0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTV3CtCzQJvA1gtpQ0cj3hJ/oBFoMfnISaledLlHenSi2Eg6ZqznCSi/MlKd9Ay9x4HATqepXDXxobmD8X4VlYZONaqPb/TGRuw+mPS7bvD6FAa8XdGeLdmbWdKrPf/KovxsiFr6XZGC8NNG/Xo9Q+6uoDOgCUd6qzyU30IoPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQ73vEhn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d934cb84b6so2703125b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721666362; x=1722271162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0FtCS8ce3oJ6FC+bt5StATqnJIS3hC7uSpnEKxX5dA=;
        b=WQ73vEhn5TwaNfTvIvw24yZwnqmIC+ml5vOcOr/2obsMYVK7ZooXDe8QQI8RqwOPa/
         XS6Dj90Xl39Eyt+qBrO1FEsnCEeFHCjAO4TFnz6T+Fn7tn5bl+TITcSKiv3jmOyicZxh
         wtE7eNT7DiTQYVV7MeJmevAV5C9e66OpFJaGwHRtJKkCYAUsRuPOIcifOoIMslgepS2r
         f2SoPbLP08Sc5WXjdDmBRNY3cZk+9iFjYUJ3JmhH9X28md7CnM3bHFrhDkbRGFpCdXHa
         XUJempL2fxiIBChuokwzzFV238kQuSq6+5Qfewp2gwadRfi66e3R2cPCn1FtnBPEmKRz
         9y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721666362; x=1722271162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0FtCS8ce3oJ6FC+bt5StATqnJIS3hC7uSpnEKxX5dA=;
        b=vBpftV/bVpETlpegxbkMpmh4aqpL0PJh5FVpWNUto2hXf/kItwwKkx7b8cCqM89MbX
         vy87wHGl1qJo01O336BJcQ/NZLRGi9d5wu4Ve5zRvFkFBwYFThAS8ZzyRrSFJMcpyhuo
         yvZmTH/L4hVqS+GqcXFcuICaGjrs11iS8DjlqZkABmElJGSDQyiYgb0DDkW3id2XKJS0
         P0m86H7gWUo8Tonk6pXjg8ZbMmHQm+BKtOcyks9n7VJEgHP/kHxaTNiKv8UwP+ZYq8+y
         zzXhYl5n+nm+NMk7rCYclqu5elL+Nq4SiWeX58PpK+ZIPaspRqXteDgtg79foR8SVaxe
         lnXg==
X-Forwarded-Encrypted: i=1; AJvYcCW57MgtuQhb2L3YLcX+P1/CN5eTe7kqBVVJJ5Lfoazq8pFz/ebvvQ/vguGeMj6MzT7nL2S5GegiGDmZ1QOPk5/cwnDTpYOSfKOPMlcl
X-Gm-Message-State: AOJu0YzIq1AZ3afVwK2qJ5wG9576D/zvNzPL3Nv0l/+HxWoOhhIE/9JY
	seb+yH6bG922cu8CiWtcXKremrVkfe8rwp5Ra/c8Q5zpCwtW/sFNNmSkhsA3CIA=
X-Google-Smtp-Source: AGHT+IGzBMp/tsItWgAPj+VB+pvLu8wcqPOAbVV//tJxVI+9UDqbeEYyMGXRJ4f+JWurWTP5JeE9/g==
X-Received: by 2002:a05:6808:170f:b0:3d9:2154:2ffd with SMTP id 5614622812f47-3dafd0bad7cmr381413b6e.3.1721666361567;
        Mon, 22 Jul 2024 09:39:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:35af:fa4f:e4b1:a51f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d146d7573sm3499152b3a.61.2024.07.22.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:39:21 -0700 (PDT)
Date: Mon, 22 Jul 2024 10:39:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: xlnx: add sram support
Message-ID: <Zp6LNyyuzskj+UBH@p14s>
References: <20240716013953.1715134-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716013953.1715134-1-tanmay.shah@amd.com>

Good morning,

On Mon, Jul 15, 2024 at 06:39:54PM -0700, Tanmay Shah wrote:
> AMD-Xilinx zynqmp platform contains on-chip sram memory (OCM).
> R5 cores can access OCM and access is faster than DDR memory but slower
> than TCM memories available. Sram region can have optional multiple
> power-domains. Platform management firmware is responsible
> to operate these power-domains.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v2:
>   - Expand commit message with power-domains related information.
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 131 ++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 596f3ffb8935..52ddd42b09e0 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -56,6 +56,17 @@ struct mem_bank_data {
>  	char *bank_name;
>  };
>  
> +/**
> + * struct zynqmp_sram_bank - sram bank description
> + *
> + * @sram_res: sram address region information
> + * @da: device address of sram
> + */
> +struct zynqmp_sram_bank {
> +	struct resource sram_res;
> +	u32 da;
> +};
> +
>  /**
>   * struct mbox_info
>   *
> @@ -120,6 +131,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   * struct zynqmp_r5_core
>   *
>   * @rsc_tbl_va: resource table virtual address
> + * @sram: Array of sram memories assigned to this core
> + * @num_sram: number of sram for this core
>   * @dev: device of RPU instance
>   * @np: device node of RPU instance
>   * @tcm_bank_count: number TCM banks accessible to this RPU
> @@ -131,6 +144,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   */
>  struct zynqmp_r5_core {
>  	void __iomem *rsc_tbl_va;
> +	struct zynqmp_sram_bank **sram;

I suggest making @sram an array rather than an array of pointers - it would
simplify function zynqmp_r5_get_sram_banks(). 

> +	int num_sram;
>  	struct device *dev;
>  	struct device_node *np;
>  	int tcm_bank_count;
> @@ -494,6 +509,40 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int add_sram_carveouts(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct rproc_mem_entry *rproc_mem;
> +	struct zynqmp_sram_bank *sram;
> +	dma_addr_t dma_addr;
> +	size_t len;
> +	int da, i;
> +
> +	for (i = 0; i < r5_core->num_sram; i++) {
> +		sram = r5_core->sram[i];
> +
> +		dma_addr = (dma_addr_t)sram->sram_res.start;
> +		len = resource_size(&sram->sram_res);
> +		da = sram->da;
> +
> +		/* Register associated reserved memory regions */
> +		rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
> +						 (dma_addr_t)dma_addr,
> +						 len, da,
> +						 zynqmp_r5_mem_region_map,
> +						 zynqmp_r5_mem_region_unmap,
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
> +}
> +
>  /*
>   * tcm_mem_unmap()
>   * @rproc: single R5 core's corresponding rproc instance
> @@ -669,6 +718,12 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
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
> @@ -881,6 +936,78 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	return ERR_PTR(ret);
>  }
>  
> +static int zynqmp_r5_get_sram_banks(struct zynqmp_r5_core *r5_core)
> +{
> +	struct zynqmp_sram_bank **sram, *sram_data;
> +	struct device_node *np = r5_core->np;
> +	struct device *dev = r5_core->dev;
> +	struct device_node *sram_np;
> +	int num_sram, i, ret;
> +	u64 abs_addr, size;
> +
> +	/* "sram" is optional proprty. Do not fail, if unavailable. */

s/proprty/property

> +	if (!of_find_property(r5_core->np, "sram", NULL))
> +		return 0;
> +
> +	num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
> +	if (num_sram <= 0) {

Any reason this is "<" rather than "<=" ?

> +		dev_err(dev, "Invalid sram property, ret = %d\n",
> +			num_sram);
> +		return -EINVAL;
> +	}
> +
> +	sram = devm_kcalloc(dev, num_sram,
> +			    sizeof(struct zynqmp_sram_bank *), GFP_KERNEL);
> +	if (!sram)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_sram; i++) {
> +		sram_data = devm_kzalloc(dev, sizeof(struct zynqmp_sram_bank),
> +					 GFP_KERNEL);
> +		if (!sram_data)
> +			return -ENOMEM;
> +
> +		sram_np = of_parse_phandle(np, "sram", i);
> +		if (!sram_np) {
> +			dev_err(dev, "failed to get sram %d phandle\n", i);
> +			return -EINVAL;
> +		}
> +
> +		if (!of_device_is_available(sram_np)) {
> +			of_node_put(sram_np);
> +			dev_err(dev, "sram device not available\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = of_address_to_resource(sram_np, 0, &sram_data->sram_res);
> +		of_node_put(sram_np);

Why calling this here when sram_np is used below?

> +		if (ret) {
> +			dev_err(dev, "addr to res failed\n");
> +			return ret;
> +		}
> +
> +		/* Get SRAM device address */
> +		ret = of_property_read_reg(sram_np, i, &abs_addr, &size);
> +		if (ret) {
> +			dev_err(dev, "failed to get reg property\n");
> +			return ret;
> +		}
> +
> +		sram_data->da = (u32)abs_addr;
> +
> +		sram[i] = sram_data;
> +
> +		dev_dbg(dev, "sram %d: name=%s, addr=0x%llx, da=0x%x, size=0x%llx\n",
> +			i, sram[i]->sram_res.name, sram[i]->sram_res.start,
> +			sram[i]->da, resource_size(&sram[i]->sram_res));
> +	}
> +
> +	r5_core->sram = sram;
> +	r5_core->num_sram = num_sram;
> +
> +	return 0;
> +}
> +
>  static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
>  {
>  	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> @@ -1095,6 +1222,10 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  				return ret;
>  			}
>  		}
> +
> +		ret = zynqmp_r5_get_sram_banks(r5_core);
> +		if (ret)
> +			return ret;
>  	}

Thanks,
Mathieu

>  
>  	return 0;
> 
> base-commit: d87dbfd31796f810ed777aee4919f211b4a6c7fb
> -- 
> 2.25.1
> 

