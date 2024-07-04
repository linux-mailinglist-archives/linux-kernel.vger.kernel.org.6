Return-Path: <linux-kernel+bounces-241371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A609927A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F9E1C22D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEF1B140F;
	Thu,  4 Jul 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gD2UV7BI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD31EB36
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108236; cv=none; b=qKokNzlq64+jVvUkWmpiEaWhRjMdpMOR7kL2w/wANilVTq5WRUsrXvmY2PJBO3ugEQ8Wl92gQRnuCqfJdSXnHdFpgA0A3hp/kF2jnceYYFc3CQyuwzNUrLcd7E3hHaycW6jrVxiBvlSNwebx5aRKZtopBaQKmYQctoJ9IIJfQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108236; c=relaxed/simple;
	bh=HSv2fhqTMdwTAuROorLz640frxDkzsqGhsAxXQZz/6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDBpxpStm48sANnBYBMOGzPn9918b2F8eufJdK8pkDyMEiIxCxn1KQtI27BwgMt8WsyTlpL7Cu9DtMmGi8PRtLD6sYl+IcwSQGllMj7ZXdldjIIO2F6VO72HM87wtFIZMeUHKUlrGDb0MxGsP9wLcaukUbk8L58raa0R6+tmhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gD2UV7BI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af8128081so591647b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720108233; x=1720713033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JH6dLrtghj4tnp10SzmiRwNtcGS9NasLXFmO4SXDQTg=;
        b=gD2UV7BI1+49z3CYye59atEFzACMDWih/ZJPFKfsJF5luMPCcUiGD50tXeoI/Nixta
         M3kbl3mipUaHu8U2AiC3ZzlBdIDr32W04jqQR1bjeZy4RtXDMuXTHnBxGnYM51AdZEfS
         TQkAehRNz+4l7cbbKWFrUzahmfTP1gR2nxJ90/YyCycIBTNlkbmC371SuUiKN7a6kfnW
         Z9M70dhBvu72ZtJt1VZrjAvbU/7kVm1asfXDwFD3oYl+v/0MCz07ZcpaIIsuwH1JItF5
         sTw29RVmtlKL2UK83NUu0PYTclOZvBIKzU7kds3omNKGHvGZmHLSCPmhZ5NjLnnn4u+h
         B2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720108233; x=1720713033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH6dLrtghj4tnp10SzmiRwNtcGS9NasLXFmO4SXDQTg=;
        b=jLNA8Tt+O2a1KSJdTbsVPyA8rKeQXDdmtLeFiAfreeVS8sCMHaQeyU1D0cPzN/cs9g
         dU+kDUgjihxh/3hZ6boA1HnaCFzccK7Iy/eqpcSGfHBqOHRp7YehwUvRYrTGD/ffbMrH
         RxcnV3SJxLjYTHVCDH3YZO7X4mkJmDlWVF7UAapvp9xUjzeuKmnqB35xS+Qa6TQRernh
         tK8DnTNgqOv8M5DYVCCbNsPwAIFNiWK7yiiP4DgiJyqpCzl/iwJ06broeZRpL6UvELTP
         X7VB+MLNtqwUs5x92j/j3SSYi6b9eD7qudK3EUJBoCs7gI/lTv4UJtgktiyC951KoVlP
         drwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXx4Jw562jkZ8+PYn9+4XMxp0Y60e7kvjEs85vOapoa+iP5Ngnvkd2pjaEZnPqeLEn9odQ44Ccj9Ko+LRQWYeNUfvIsfDnig/3C1xB
X-Gm-Message-State: AOJu0Yw28oh5iL9KNOzyAFcbifvbcMP/TAkH9egLTDDOZaHauXbI1IfO
	eXYHzifxqW0pcquBOLICbTLrxDfDWuw+MshUGf6+UgnT/tU8u7m8Mrp7vaWvqKTtrKkIgG8Ibpc
	1
X-Google-Smtp-Source: AGHT+IGCvlIuFKXkmQL/xXMjFExNNm8y8t/Uha2dJXjlYTvhYGD8/hdWmWK5i/OnIxOKB0JHtJKR0A==
X-Received: by 2002:a05:6a00:2192:b0:70a:ffa5:41ec with SMTP id d2e1a72fcca58-70b00b6b061mr2122346b3a.25.1720108233063;
        Thu, 04 Jul 2024 08:50:33 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fb65:8622:7ca1:51c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802464b18sm12393039b3a.45.2024.07.04.08.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:50:32 -0700 (PDT)
Date: Thu, 4 Jul 2024 09:50:30 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] remoteproc: xlnx: add attach detach support
Message-ID: <ZobExtgp86V54BD+@p14s>
References: <20240627172936.227439-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627172936.227439-1-tanmay.shah@amd.com>

On Thu, Jun 27, 2024 at 10:29:38AM -0700, Tanmay Shah wrote:
> It is possible that remote processor is already running before
> linux boot or remoteproc platform driver probe. Implement required
> remoteproc framework ops to provide resource table address and
> connect or disconnect with remote processor in such case.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v6:
>   - Move rproc state check to add_tcm_carveout
>   - free node reference using of_node_put
>   - fix iounmap use
> 
> Changes in v5:
>   - Fix comment on assigning DETACHED state to remoteproc instance
>     during driver probe.
>   - Fix patch subject and remove "drivers"
> 
> Changes in v4:
>   - Move change log out of commit text
> 
> Changes in v3:
>   - Drop SRAM patch from the series
>   - Change type from "struct resource_table *" to void __iomem *
>   - Change comment format from /** to /*
>   - Remove unmap of resource table va address during detach, allowing
>     attach-detach-reattach use case.
>   - Unmap rsc_data_va after retrieving resource table data structure.
>   - Unmap resource table va during driver remove op
> 
> Changes in v2:
>   - Fix typecast warnings reported using sparse tool.
>   - Fix following sparse warnings:
>
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 151 ++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 84243d1dff9f..596f3ffb8935 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -25,6 +25,10 @@
>  /* RX mailbox client buffer max length */
>  #define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
>  				 sizeof(struct zynqmp_ipi_message))
> +
> +#define RSC_TBL_XLNX_MAGIC	((uint32_t)'x' << 24 | (uint32_t)'a' << 16 | \
> +				 (uint32_t)'m' << 8 | (uint32_t)'p')
> +
>  /*
>   * settings for RPU cluster mode which
>   * reflects possible values of xlnx,cluster-mode dt-property
> @@ -73,6 +77,26 @@ struct mbox_info {
>  	struct mbox_chan *rx_chan;
>  };
>  
> +/**
> + * struct rsc_tbl_data
> + *
> + * Platform specific data structure used to sync resource table address.
> + * It's important to maintain order and size of each field on remote side.
> + *
> + * @version: version of data structure
> + * @magic_num: 32-bit magic number.
> + * @comp_magic_num: complement of above magic number
> + * @rsc_tbl_size: resource table size
> + * @rsc_tbl: resource table address
> + */
> +struct rsc_tbl_data {
> +	const int version;
> +	const u32 magic_num;
> +	const u32 comp_magic_num;
> +	const u32 rsc_tbl_size;
> +	const uintptr_t rsc_tbl;
> +} __packed;
> +
>  /*
>   * Hardcoded TCM bank values. This will stay in driver to maintain backward
>   * compatibility with device-tree that does not have TCM information.
> @@ -95,20 +119,24 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>  /**
>   * struct zynqmp_r5_core
>   *
> + * @rsc_tbl_va: resource table virtual address
>   * @dev: device of RPU instance
>   * @np: device node of RPU instance
>   * @tcm_bank_count: number TCM banks accessible to this RPU
>   * @tcm_banks: array of each TCM bank data
>   * @rproc: rproc handle
> + * @rsc_tbl_size: resource table size retrieved from remote
>   * @pm_domain_id: RPU CPU power domain id
>   * @ipi: pointer to mailbox information
>   */
>  struct zynqmp_r5_core {
> +	void __iomem *rsc_tbl_va;
>  	struct device *dev;
>  	struct device_node *np;
>  	int tcm_bank_count;
>  	struct mem_bank_data **tcm_banks;
>  	struct rproc *rproc;
> +	u32 rsc_tbl_size;
>  	u32 pm_domain_id;
>  	struct mbox_info *ipi;
>  };
> @@ -557,6 +585,14 @@ static int add_tcm_banks(struct rproc *rproc)
>  		dev_dbg(dev, "TCM carveout %s addr=%llx, da=0x%x, size=0x%lx",
>  			bank_name, bank_addr, da, bank_size);
>  
> +		/*
> +		 * In DETACHED state firmware is already running so no need to
> +		 * request add TCM registers. However, request TCM PD node to let
> +		 * platform management firmware know that TCM is in use.
> +		 */
> +		if (rproc->state == RPROC_DETACHED)
> +			continue;
> +
>  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
>  						 bank_size, da,
>  						 tcm_mem_map, tcm_mem_unmap,
> @@ -662,6 +698,107 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static struct resource_table *zynqmp_r5_get_loaded_rsc_table(struct rproc *rproc,
> +							     size_t *size)
> +{
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = rproc->priv;
> +
> +	*size = r5_core->rsc_tbl_size;
> +
> +	return (struct resource_table *)r5_core->rsc_tbl_va;
> +}
> +
> +static int zynqmp_r5_get_rsc_table_va(struct zynqmp_r5_core *r5_core)
> +{
> +	struct resource_table *rsc_tbl_addr;
> +	struct device *dev = r5_core->dev;
> +	struct rsc_tbl_data *rsc_data_va;
> +	struct resource res_mem;
> +	struct device_node *np;
> +	int ret;
> +
> +	/*
> +	 * It is expected from remote processor firmware to provide resource
> +	 * table address via struct rsc_tbl_data data structure.
> +	 * Start address of first entry under "memory-region" property list
> +	 * contains that data structure which holds resource table address, size
> +	 * and some magic number to validate correct resource table entry.
> +	 */
> +	np = of_parse_phandle(r5_core->np, "memory-region", 0);
> +	if (!np) {
> +		dev_err(dev, "failed to get memory region dev node\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_address_to_resource(np, 0, &res_mem);
> +	of_node_put(np);
> +	if (ret) {
> +		dev_err(dev, "failed to get memory-region resource addr\n");
> +		return -EINVAL;
> +	}
> +
> +	rsc_data_va = (struct rsc_tbl_data *)ioremap_wc(res_mem.start,
> +							sizeof(struct rsc_tbl_data));
> +	if (!rsc_data_va) {
> +		dev_err(dev, "failed to map resource table data address\n");
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * If RSC_TBL_XLNX_MAGIC number and its complement isn't found then
> +	 * do not consider resource table address valid and don't attach
> +	 */
> +	if (rsc_data_va->magic_num != RSC_TBL_XLNX_MAGIC ||
> +	    rsc_data_va->comp_magic_num != ~RSC_TBL_XLNX_MAGIC) {
> +		dev_dbg(dev, "invalid magic number, won't attach\n");
> +		return -EINVAL;
> +	}
> +
> +	r5_core->rsc_tbl_va = ioremap_wc(rsc_data_va->rsc_tbl,
> +					 rsc_data_va->rsc_tbl_size);
> +	if (!r5_core->rsc_tbl_va) {
> +		dev_err(dev, "failed to get resource table va\n");
> +		return -EINVAL;
> +	}
> +
> +	rsc_tbl_addr = (struct resource_table *)r5_core->rsc_tbl_va;
> +
> +	/*
> +	 * As of now resource table version 1 is expected. Don't fail to attach
> +	 * but warn users about it.
> +	 */
> +	if (rsc_tbl_addr->ver != 1)
> +		dev_warn(dev, "unexpected resource table version %d\n",
> +			 rsc_tbl_addr->ver);
> +
> +	r5_core->rsc_tbl_size = rsc_data_va->rsc_tbl_size;
> +
> +	iounmap((void __iomem *)rsc_data_va);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_attach(struct rproc *rproc)
> +{
> +	dev_dbg(&rproc->dev, "rproc %d attached\n", rproc->index);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_detach(struct rproc *rproc)
> +{
> +	/*
> +	 * Generate last notification to remote after clearing virtio flag.
> +	 * Remote can avoid polling on virtio reset flag if kick is generated
> +	 * during detach by host and check virtio reset flag on kick interrupt.
> +	 */
> +	zynqmp_r5_rproc_kick(rproc, 0);
> +
> +	return 0;
> +}
> +
>  static const struct rproc_ops zynqmp_r5_rproc_ops = {
>  	.prepare	= zynqmp_r5_rproc_prepare,
>  	.unprepare	= zynqmp_r5_rproc_unprepare,
> @@ -673,6 +810,9 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  	.kick		= zynqmp_r5_rproc_kick,
> +	.get_loaded_rsc_table = zynqmp_r5_get_loaded_rsc_table,
> +	.attach		= zynqmp_r5_attach,
> +	.detach		= zynqmp_r5_detach,
>  };
>  
>  /**
> @@ -723,6 +863,16 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  		goto free_rproc;
>  	}
>  
> +	/*
> +	 * If firmware is already available in the memory then move rproc state
> +	 * to DETACHED. Firmware can be preloaded via debugger or by any other
> +	 * agent (processors) in the system.
> +	 * If firmware isn't available in the memory and resource table isn't
> +	 * found, then rproc state remains OFFLINE.
> +	 */
> +	if (!zynqmp_r5_get_rsc_table_va(r5_core))
> +		r5_rproc->state = RPROC_DETACHED;
> +
>  	r5_core->rproc = r5_rproc;
>  	return r5_core;
>  
> @@ -1134,6 +1284,7 @@ static void zynqmp_r5_cluster_exit(void *data)
>  	for (i = 0; i < cluster->core_count; i++) {
>  		r5_core = cluster->r5_cores[i];
>  		zynqmp_r5_free_mbox(r5_core->ipi);
> +		iounmap(r5_core->rsc_tbl_va);
>  		of_reserved_mem_device_release(r5_core->dev);
>  		put_device(r5_core->dev);
>  		rproc_del(r5_core->rproc);
> 
> base-commit: 8fa5d65ee3f228ad8fb4a2a20cbd8cf7a1fcfcab
> -- 
> 2.25.1
> 

