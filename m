Return-Path: <linux-kernel+bounces-315544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB796C402
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5206028703F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06B1DFE14;
	Wed,  4 Sep 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsn8D+mN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC51DB55E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466877; cv=none; b=pP4da92qjyN4m7E4zmjnsP1CAOCABZy0IinAd06CHgCbS//OV65BaZbnXLRiwg/872HdQT971VpGw7VZxRWZIq/aRRfluaEuMr5R4fFsdNGvlFUXvQuxd5UHCjwiDYoUIo0DRVF57nr+EXiW3QYPnOZOmWrfGSi0vePHKpeU3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466877; c=relaxed/simple;
	bh=CoyqvOgwtCZPWZSoclyZkEX5+I1LpHTxJf8NXDiWuu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCmHMTM67FiglJaUX17dPVXeTGYXyBGY28ToGsyK6P9ZzCm70ub6aJy+HSz0Lqc9Bf2/KoAX/Nf0UBvcmtKSyCDnz/Jv29s8WDJa67o8mlaAKWGMfnCWYBYVhmN3kIYLIxNETWSxPDOETJySRwDB1sm+N8lU1azvHpbazph8dLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsn8D+mN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068acc8b98so8606055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725466875; x=1726071675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weNh0QX5nezonyihacHlDzSp/qiDEiH8F2h5VX1i+hE=;
        b=gsn8D+mN6P0uimQloGwKPYfIUBsAu0Zn0F+R1SsrOGp07Y0GLixzXT3jStumFukwVw
         xNDYPRBMX7zW5AJKdfkpWt1lF4gzfbWdsPSfLwFFyJsIaLom9owtG9HiaaMvHKepTiaZ
         MjANhrOqV8K8ynj6wLKXZUfHjl8tnTg3jKXss+oTH5dGWAQ3AUDU9UcCnWznp1rIpv4J
         CRF6WdQZnvYuNrByW0yGoe7azs9BdmI3ADL5n6WQsQlkburPRhups+8dRkKWxttxI7SH
         5icBYesDQtbTeW+GuXtw5oLbE5mzPIIOaveB/qEWiLwAKK1J1rvIHsUz930iq+yuU/7+
         4K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466875; x=1726071675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weNh0QX5nezonyihacHlDzSp/qiDEiH8F2h5VX1i+hE=;
        b=IcF2RRHLEwpVGmAO8cuGQp5GmPlpSVXg1sFRlk3yBeqiy8KZLt/8CXNFVdJHC+CRtb
         Yz2DwO58Rpb/0j/gn9cw+dtabLH70rsDvNtsJzohTIjiv/qhwg/hWPt+PejXRshau6US
         zUcTORjGlCJUnj9bAZg+VtTvcQCEymZCeIE0E1RRnHtj7mCI7ImiNU50GvyJ+zeIvMVe
         Kru8E84JtOKx3gT7ShUkwVriwNs+Vtd/y/9NriTNX2QZ5viM4SBjJECVgBz70lFLxnKP
         XjVJr07nuDweIfDlJZm0Ee72ansjal7SRCVBJkLlXnkv6HOV9yfZeI0q80hzSU4cRSdJ
         dW+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3DDVGKxtvIHcAD+Mmg1ka3wCXzmRt6faHU+atewlrLUNaSeuDEjxDZhfCj8PUZNu3RhhFin837gTRzhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNU43gY574+2Unz3HSDn4tJz6S5q+LoYe6szmeDxJ2IhqzyFN5
	3tNc3cYEQxyyDQjfkNIQ96VuRPPF7xTIU4d6BaupAbNIJL1whAczcTcWcMk5p7w=
X-Google-Smtp-Source: AGHT+IH70Qucqc4w3IuTRnC0ArVA/LCFl7Nyz3bO3XGxKL2AKr1w6zXgO+S845CmkbKE1RgpX1KEyQ==
X-Received: by 2002:a17:903:40c5:b0:206:b1fa:ccc3 with SMTP id d9443c01a7336-206b1fae4a4mr30019055ad.20.1725466874577;
        Wed, 04 Sep 2024 09:21:14 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8490:5dd6:5f49:1365])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea6661dsm15330635ad.253.2024.09.04.09.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:21:14 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:21:11 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] remoteproc: xlnx: add sram support
Message-ID: <ZtiI98P/ipMkwMh1@p14s>
References: <20240830173735.279432-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830173735.279432-1-tanmay.shah@amd.com>

Good morning,

On Fri, Aug 30, 2024 at 10:37:36AM -0700, Tanmay Shah wrote:
> AMD-Xilinx zynqmp platform contains on-chip sram memory (OCM).
> R5 cores can access OCM and access is faster than DDR memory but slower
> than TCM memories available. Sram region can have optional multiple
> power-domains. Platform management firmware is responsible
> to operate these power-domains.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v5:
>   - remoteproc: xlnx: remove genpool use for OCM sram
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
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 135 ++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 2cea97c746fd..af4e0e53dc9d 100644
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
> +	struct zynqmp_sram_bank *sram;
> +	int num_sram;
>  	struct device *dev;
>  	struct device_node *np;
>  	int tcm_bank_count;
> @@ -494,6 +509,45 @@ static int add_mem_regions_carveout(struct rproc *rproc)
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
> +		sram = &r5_core->sram[i];
> +
> +		dma_addr = (dma_addr_t)sram->sram_res.start;
> +
> +		len = resource_size(&sram->sram_res);
> +		da = sram->da;
> +
> +		rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
> +						 (dma_addr_t)dma_addr,

@dma_addr is already declared as a dma_addr_t, which is what
rproc_mem_entry_init() is expecting.  As such I do not see a reason for the
extra casting - do you?

If you agree with my assessment I am proposing to remove it before applying the
patch rather than having to send another revision.

Let me know what you think.

Thanks,
Mathieu

> +						 len, da,
> +						 zynqmp_r5_mem_region_map,
> +						 zynqmp_r5_mem_region_unmap,
> +						 sram->sram_res.name);
> +		if (!rproc_mem) {
> +			dev_err(&rproc->dev, "failed to add sram %s da=0x%x, size=0x%lx",
> +				sram->sram_res.name, da, len);
> +			return -ENOMEM;
> +		}
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
> @@ -669,6 +723,12 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
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
> @@ -881,6 +941,77 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
> +			return -EINVAL;
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
> @@ -1095,6 +1226,10 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
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
> base-commit: 057e5c17e29fe67fae4c2786d558c31fd3b106ba
> -- 
> 2.25.1
> 

