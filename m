Return-Path: <linux-kernel+bounces-219916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFF90DA14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEAA1C21EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED613A41A;
	Tue, 18 Jun 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toHvl+EU"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFF912FB3B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729715; cv=none; b=hXxfoJG7OVq15ryXQRh42dmqIScxE3LkYAHlHUXckA6BEpsB8anNR0lEnqQJ9MUuJChzUP1G2UZ6AVDDyXAPUIE70nIFW5/jUUP38nOM4Hy24nERE8b3B4DzEHKmsUtogZJfeWHmjFLU1iGvbQcKM+LyX6AFJpMdMZEbPK0beQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729715; c=relaxed/simple;
	bh=faOcSfotd0L8bZWVe64AEImrOeZFrTyWUKNv+cBYOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq886ChQg9Nugui75csxStDcCbF75uu3ZteRI30esJ1I/1TPFEEttrFX9yYUnOk76ASsV8UXOsiDTTgRCnl1LOUQDQiCBiLHnTZickm/cPcsouKrt13s4OqakGFwA5nZAMPnfi5o36VEDr9uHVZxwpOWd97km8N6TLQuqEmEaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=toHvl+EU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706264e1692so419155b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718729713; x=1719334513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axs/NTc7WQWO5o4c5RYZObX/9i/8ia+OOTb1bfZvEpE=;
        b=toHvl+EUdl9/BkGavbSbjo+oh8Yu9f3+dx5iFgv/83LrtenGURc9xmGyNcgi360/87
         0KJqtJ+vYFndYXHIEN1roVsr48Zo8Jbz0unGvQ2sQcBD3LjnsAF8CbbElMQNuSY+n95c
         gJtKdp115SxDtQsaIiD43xbSOaqTvvJlWIEXISPiNXRbO8VjXrRUCy3c5vEsdc/cQ6Bc
         NYtIjzrLqDxWzM3q/1T2u/yZjwMmxcabNJ23QpqLFY0DhZOM5xnLMajjR55oD/6xKXwW
         xRWmpqxVrdsUg7OmFmwfwmjBO0ew01Ov74HPfY6J/+8Jbd02ofkoGLoI4aNfbaCQ/8BT
         Aw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729713; x=1719334513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axs/NTc7WQWO5o4c5RYZObX/9i/8ia+OOTb1bfZvEpE=;
        b=WouLFpNcBAOG8YYDUZjLaNs4cnuc+x0bF/OsS8Af2TnD9I7DyaYqTwS/fqfTZXyaN6
         ECVKxRvacrFhW+flw1VaLWHMLil7WV21qtXGZht8HFgumtKEZgA2QMjUfZKACVf4D98l
         V/OKqfgDmfHO3iovjtRUOC0Hqw+LHNbGXsqAmZxLwe+L3ptJWPmb2Ir48jBsqt8a0mpm
         HTXTVJZzaf1oIjAq3ATUgTIMgNnMACGw95Bkc7QmXDNRZR38kTfnXC9HBdl13hZhcadS
         WnDvxX7x2jCl1VAiKoUYoh5yWgUEpnjHnJF1oa7tzUu7KWhefF8veyk03c5EDNvkXw2J
         R8dg==
X-Forwarded-Encrypted: i=1; AJvYcCWVI4uLJm1PG299WlhgBfykAR5bdwLVVudhXtjZI71lwf8CveDyLi7B7l/yy/kgL5h8u4TUVMHLMzDkU4XC4wK7a5qQbLGP/Z2ga86+
X-Gm-Message-State: AOJu0YwUCCqLD0/uAXZoXme9zeOP5uZ3mt+YSZ4wc58hv5U4O4z8TjzG
	YiU08DZPv1y45l7W/323IMPsAK0Bm2tH95zzkwasbbcTg4PMnLWt/aGra9bAaUvIy7N/6HfzsRo
	t
X-Google-Smtp-Source: AGHT+IHkt54aUKgYQVsXgPSJ2xjmskmFfz73ulmW3ko62AGOOxeuHMi67+OLGmoeUPfelrI0W7psEQ==
X-Received: by 2002:a05:6a20:6382:b0:1b7:f59d:fd1e with SMTP id adf61e73a8af0-1bcbb5f06a3mr93516637.50.1718729712899;
        Tue, 18 Jun 2024 09:55:12 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:119:277c:7645:6d69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc97fd59sm9178370b3a.84.2024.06.18.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:55:11 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:55:09 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: "andersson@kernel.org" <andersson@kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] remoteproc: xlnx: add attach detach support
Message-ID: <ZnG77WlE4o/rxebU@p14s>
References: <20240610154227.3104790-1-tanmay.shah@amd.com>
 <ZnBY0UtG9fyfxdTh@p14s>
 <f51ec569-195a-4434-8f3e-36401aabef89@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51ec569-195a-4434-8f3e-36401aabef89@amd.com>

On Tue, Jun 18, 2024 at 11:45:28AM -0500, Tanmay Shah wrote:
> 
> 
> On 6/17/24 10:40 AM, Mathieu Poirier wrote:
> > Good day,
> > 
> > On Mon, Jun 10, 2024 at 08:42:27AM -0700, Tanmay Shah wrote:
> >> It is possible that remote processor is already running before
> >> linux boot or remoteproc platform driver probe. Implement required
> >> remoteproc framework ops to provide resource table address and
> >> connect or disconnect with remote processor in such case.
> >> 
> >> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >> ---
> >> 
> >> Changes in v5:
> >>   - Fix comment on assigning DETACHED state to remoteproc instance
> >>     during driver probe.
> >>   - Fix patch subject and remove "drivers"
> >> 
> >> Changes in v4:
> >>   - Move change log out of commit text
> >> 
> >> Changes in v3:
> >>   - Drop SRAM patch from the series
> >>   - Change type from "struct resource_table *" to void __iomem *
> >>   - Change comment format from /** to /*
> >>   - Remove unmap of resource table va address during detach, allowing
> >>     attach-detach-reattach use case.
> >>   - Unmap rsc_data_va after retrieving resource table data structure.
> >>   - Unmap resource table va during driver remove op
> >> 
> >> Changes in v2:
> >>   - Fix typecast warnings reported using sparse tool.
> >>   - Fix following sparse warnings:
> >> 
> >>  drivers/remoteproc/xlnx_r5_remoteproc.c | 173 +++++++++++++++++++++++-
> >>  1 file changed, 169 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> index 84243d1dff9f..6ddce5650f95 100644
> >> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> @@ -25,6 +25,10 @@
> >>  /* RX mailbox client buffer max length */
> >>  #define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> >>  				 sizeof(struct zynqmp_ipi_message))
> >> +
> >> +#define RSC_TBL_XLNX_MAGIC	((uint32_t)'x' << 24 | (uint32_t)'a' << 16 | \
> >> +				 (uint32_t)'m' << 8 | (uint32_t)'p')
> >> +
> >>  /*
> >>   * settings for RPU cluster mode which
> >>   * reflects possible values of xlnx,cluster-mode dt-property
> >> @@ -73,6 +77,26 @@ struct mbox_info {
> >>  	struct mbox_chan *rx_chan;
> >>  };
> >>  
> >> +/**
> >> + * struct rsc_tbl_data
> >> + *
> >> + * Platform specific data structure used to sync resource table address.
> >> + * It's important to maintain order and size of each field on remote side.
> >> + *
> >> + * @version: version of data structure
> >> + * @magic_num: 32-bit magic number.
> >> + * @comp_magic_num: complement of above magic number
> >> + * @rsc_tbl_size: resource table size
> >> + * @rsc_tbl: resource table address
> >> + */
> >> +struct rsc_tbl_data {
> >> +	const int version;
> >> +	const u32 magic_num;
> >> +	const u32 comp_magic_num;
> >> +	const u32 rsc_tbl_size;
> >> +	const uintptr_t rsc_tbl;
> >> +} __packed;
> >> +
> >>  /*
> >>   * Hardcoded TCM bank values. This will stay in driver to maintain backward
> >>   * compatibility with device-tree that does not have TCM information.
> >> @@ -95,20 +119,24 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >>  /**
> >>   * struct zynqmp_r5_core
> >>   *
> >> + * @rsc_tbl_va: resource table virtual address
> >>   * @dev: device of RPU instance
> >>   * @np: device node of RPU instance
> >>   * @tcm_bank_count: number TCM banks accessible to this RPU
> >>   * @tcm_banks: array of each TCM bank data
> >>   * @rproc: rproc handle
> >> + * @rsc_tbl_size: resource table size retrieved from remote
> >>   * @pm_domain_id: RPU CPU power domain id
> >>   * @ipi: pointer to mailbox information
> >>   */
> >>  struct zynqmp_r5_core {
> >> +	void __iomem *rsc_tbl_va;
> >>  	struct device *dev;
> >>  	struct device_node *np;
> >>  	int tcm_bank_count;
> >>  	struct mem_bank_data **tcm_banks;
> >>  	struct rproc *rproc;
> >> +	u32 rsc_tbl_size;
> >>  	u32 pm_domain_id;
> >>  	struct mbox_info *ipi;
> >>  };
> >> @@ -621,10 +649,19 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> >>  {
> >>  	int ret;
> >>  
> >> -	ret = add_tcm_banks(rproc);
> >> -	if (ret) {
> >> -		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> >> -		return ret;
> >> +	/*
> >> +	 * For attach/detach use case, Firmware is already loaded so
> >> +	 * TCM isn't really needed at all. Also, for security TCM can be
> >> +	 * locked in such case and linux may not have access at all.
> >> +	 * So avoid adding TCM banks. TCM power-domains requested during attach
> >> +	 * callback.
> >> +	 */
> >> +	if (rproc->state != RPROC_DETACHED) {
> >> +		ret = add_tcm_banks(rproc);
> >> +		if (ret) {
> >> +			dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> >> +			return ret;
> >> +		}
> > 
> > In the normal case function add_tcm_banks() will call zynqmp_pm_request_node()
> > but in the attach case, that gets done in zynqmp_r5_attach().  Either way,
> > zynqmp_pm_release_node() is called in zynqmp_r5_rproc_unprepare().  This is
> > highly confusing.
> > 
> > I suggest adding a check to see if the remote processor is being attached to in
> > add_tcm_banks() and skip the rest of the TCM initialization if it is the case.
> > 
> 
> If we move this check to add_tcm_banks, then I think I should perform request_node
> from within add_tcm_banks only and remove registering attach() op as well. I can call
> request_node from within add_tcm_banks() and then avoid rest of initialization.
> 
> I am not sure if without attach() registartion, I can still register detach() and
> it's valid. I will test this.
>

Just add an attach() that returns 0.

> 
> >>  	}
> >>  
> >>  	ret = add_mem_regions_carveout(rproc);
> >> @@ -662,6 +699,120 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> >>  	return 0;
> >>  }
> >>  
> >> +static struct resource_table *zynqmp_r5_get_loaded_rsc_table(struct rproc *rproc,
> >> +							     size_t *size)
> >> +{
> >> +	struct zynqmp_r5_core *r5_core;
> >> +
> >> +	r5_core = rproc->priv;
> >> +
> >> +	*size = r5_core->rsc_tbl_size;
> >> +
> >> +	return (struct resource_table *)r5_core->rsc_tbl_va;
> >> +}
> >> +
> >> +static int zynqmp_r5_get_rsc_table_va(struct zynqmp_r5_core *r5_core)
> >> +{
> >> +	struct resource_table *rsc_tbl_addr;
> >> +	struct device *dev = r5_core->dev;
> >> +	struct rsc_tbl_data *rsc_data_va;
> >> +	struct resource res_mem;
> >> +	struct device_node *np;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * It is expected from remote processor firmware to provide resource
> >> +	 * table address via struct rsc_tbl_data data structure.
> >> +	 * Start address of first entry under "memory-region" property list
> >> +	 * contains that data structure which holds resource table address, size
> >> +	 * and some magic number to validate correct resource table entry.
> >> +	 */
> >> +	np = of_parse_phandle(r5_core->np, "memory-region", 0);
> >> +	if (!np) {
> >> +		dev_err(dev, "failed to get memory region dev node\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	ret = of_address_to_resource(np, 0, &res_mem);
> > 
> > Shouldn't an of_put_node() be added right here?
> 
> Usually function documentation explicitly ask if it is needed. I will check
> and add if required. I will also check any other references in kernel.
> 

You need to release @np acquired by of_parse_phandle() above.

> > 
> >> +	if (ret) {
> >> +		dev_err(dev, "failed to get memory-region resource addr\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	rsc_data_va = (struct rsc_tbl_data *)ioremap_wc(res_mem.start,
> >> +							sizeof(struct rsc_tbl_data));
> >> +	if (!rsc_data_va) {
> >> +		dev_err(dev, "failed to map resource table data address\n");
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	/*
> >> +	 * If RSC_TBL_XLNX_MAGIC number and its complement isn't found then
> >> +	 * do not consider resource table address valid and don't attach
> >> +	 */
> >> +	if (rsc_data_va->magic_num != RSC_TBL_XLNX_MAGIC ||
> >> +	    rsc_data_va->comp_magic_num != ~RSC_TBL_XLNX_MAGIC) {
> >> +		dev_dbg(dev, "invalid magic number, won't attach\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	r5_core->rsc_tbl_va = ioremap_wc(rsc_data_va->rsc_tbl,
> >> +					 rsc_data_va->rsc_tbl_size);
> >> +	if (!r5_core->rsc_tbl_va) {
> >> +		dev_err(dev, "failed to get resource table va\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	rsc_tbl_addr = (struct resource_table *)r5_core->rsc_tbl_va;
> >> +
> >> +	/*
> >> +	 * As of now resource table version 1 is expected. Don't fail to attach
> >> +	 * but warn users about it.
> >> +	 */
> >> +	if (rsc_tbl_addr->ver != 1)
> >> +		dev_warn(dev, "unexpected resource table version %d\n",
> >> +			 rsc_tbl_addr->ver);
> >> +
> >> +	iounmap((void __iomem *)rsc_data_va);
> >> +	r5_core->rsc_tbl_size = rsc_data_va->rsc_tbl_size;
> >> +
> > 
> > Can you spot the problem here?
> 
> Ah! It's like use-after-free problem. Address should have been unmapped
> at then end of the function. Surprisingly My test passed on platform, so I
> didn't pay attention. This will be fixed in next revision.

I'm also surprised - this should have blown up.

> 
> Thanks,
> Tanmay
> 
> > 
> > Thanks,
> > Mathieu
> > 
> >> +	return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_attach(struct rproc *rproc)
> >> +{
> >> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> >> +	int i, pm_domain_id, ret;
> >> +
> >> +	/*
> >> +	 * Firmware is loaded in TCM. Request TCM power domains to notify
> >> +	 * platform management controller that TCM is in use. This will be
> >> +	 * released during unprepare callback.
> >> +	 */
> >> +	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> >> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >> +		ret = zynqmp_pm_request_node(pm_domain_id,
> >> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> >> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> >> +		if (ret < 0)
> >> +			pr_warn("TCM %d can't be requested\n", i);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_detach(struct rproc *rproc)
> >> +{
> >> +	/*
> >> +	 * Generate last notification to remote after clearing virtio flag.
> >> +	 * Remote can avoid polling on virtio reset flag if kick is generated
> >> +	 * during detach by host and check virtio reset flag on kick interrupt.
> >> +	 */
> >> +	zynqmp_r5_rproc_kick(rproc, 0);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static const struct rproc_ops zynqmp_r5_rproc_ops = {
> >>  	.prepare	= zynqmp_r5_rproc_prepare,
> >>  	.unprepare	= zynqmp_r5_rproc_unprepare,
> >> @@ -673,6 +824,9 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
> >>  	.sanity_check	= rproc_elf_sanity_check,
> >>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> >>  	.kick		= zynqmp_r5_rproc_kick,
> >> +	.get_loaded_rsc_table = zynqmp_r5_get_loaded_rsc_table,
> >> +	.attach		= zynqmp_r5_attach,
> >> +	.detach		= zynqmp_r5_detach,
> >>  };
> >>  
> >>  /**
> >> @@ -723,6 +877,16 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >>  		goto free_rproc;
> >>  	}
> >>  
> >> +	/*
> >> +	 * If firmware is already available in the memory then move rproc state
> >> +	 * to DETACHED. Firmware can be preloaded via debugger or by any other
> >> +	 * agent (processors) in the system.
> >> +	 * If firmware isn't available in the memory and resource table isn't
> >> +	 * found, then rproc state remains OFFLINE.
> >> +	 */
> >> +	if (!zynqmp_r5_get_rsc_table_va(r5_core))
> >> +		r5_rproc->state = RPROC_DETACHED;
> >> +
> >>  	r5_core->rproc = r5_rproc;
> >>  	return r5_core;
> >>  
> >> @@ -1134,6 +1298,7 @@ static void zynqmp_r5_cluster_exit(void *data)
> >>  	for (i = 0; i < cluster->core_count; i++) {
> >>  		r5_core = cluster->r5_cores[i];
> >>  		zynqmp_r5_free_mbox(r5_core->ipi);
> >> +		iounmap(r5_core->rsc_tbl_va);
> >>  		of_reserved_mem_device_release(r5_core->dev);
> >>  		put_device(r5_core->dev);
> >>  		rproc_del(r5_core->rproc);
> >> 
> >> base-commit: d7faf9a16886a748c9dd4063ea897f1e68b412f2
> >> -- 
> >> 2.37.6
> >> 
> 

