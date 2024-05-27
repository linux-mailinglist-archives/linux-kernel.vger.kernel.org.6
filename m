Return-Path: <linux-kernel+bounces-190489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D28CFF25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217771F21555
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAD15D5D1;
	Mon, 27 May 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJMkaYJ1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6C131E41;
	Mon, 27 May 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809950; cv=none; b=NFkkWg2F7g6D4I8crHhiFamDQzvK3ESXoi6j4WxKkIYbHkkB04pQCG/M7cZz1+Ss0RPFxnLNsMQb+6J9ClZa+3fO0LnGTaBKhGmCZxOCRKT4d229do4lRSdszhN3pRZKu0LAWg8N5pJ50j4HMbE//fpDuloOSaOoz/4xhar8tYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809950; c=relaxed/simple;
	bh=xW+z/AkpQjZ9ITMKsYLns576tz7bCeAiXff1OYqvzbA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QBbNz3mZh1+zHQ4LmFH2OrOeIeODOxi/HePSL+lTda1B7VR24IFBcb5mT7R/TfLTM0g2Ay2pmdAfnWLnFR8+3nYpm+Jl8gJMSkDpZxy8CfaxK3uY+n4s3aLExuttLt48zyoewQkAKCaYc07ZggaU7Fl8duK93kt3CI0P2Lns0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJMkaYJ1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716809949; x=1748345949;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xW+z/AkpQjZ9ITMKsYLns576tz7bCeAiXff1OYqvzbA=;
  b=fJMkaYJ1v7Crw5xhz/4iH55YhWsVj7xY/PwO9suYwYw8HEgoy8MaTRxt
   WoxDrEage0zaP5Gba85mIC15lxlN5eVmDx4FfoByM97fB31DrxsoAv6DE
   13bXgXNlbS3s4taJZ+Lg+7FuCDw6Qiw/mFtDElM3tWhBlxOOQ5wZ3Ge3p
   9bNcRvrVtkjPb+C4pVx46c0NFtLYoLx6xyVVBLaT/kXYFPN9qqq/grwMr
   zJAzjlecOmmTcynXowbi5jiGpfrE3RR+P5+DSgA0TCOWKqiNzM85wBoSn
   v5a2SE4IeL0ql9CnNMQgWggF5wih29gsbC1hw5xabicjHxceauIASSjAy
   Q==;
X-CSE-ConnectionGUID: c5YLo0D9TjmbVEVs7n0HyQ==
X-CSE-MsgGUID: 1JpiMYB1RWOH8illHAQV5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13310552"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13310552"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 04:39:08 -0700
X-CSE-ConnectionGUID: /wfKKJk9TcSfCTcqvnGZSA==
X-CSE-MsgGUID: c79UWj7mShGAZT/maFCTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34626514"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 04:39:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 14:39:02 +0300 (EEST)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
Message-ID: <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
References: <cover.1716205838.git.shravankr@nvidia.com> <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 May 2024, Shravan Kumar Ramani wrote:

> Add support for programming any counter to monitor the cycle count.
> Since counting of cycles using 32-bit ocunters would result in frequent

counters

> wraparounds, add the ability to combine 2 adjacent 32-bit counters to
> form 1 64-bit counter.
> Both these features are supported by BlueField-3 PMC hardware, hence
> the required bit-fields are exposed by the driver via sysfs to allow
> the user to configure as needed.

I'm trying to understand what happens for the other counter, when the 
use_odd_counter is enabled? This change also doesn't add code that would 
make the other counter -EBUSY, should that be done?

For 64-bit counter, I suppose the userspace is expected to read the full 
counter from two sysfs files and combine the value (your documentation 
doesn't explain this)? That seems non-optimal, why cannot kernel just 
return the full combined 64-value directly in kernel?

Similarly, are these cycle counters occupying the same space as non-cycle 
counters (so both can/cannot be used that the same time)? I'm asking this 
because you're adding a parallel interface to read the value and if it's 
either-or, I don't understand why the value needs to be read from 
different file depending on the counter counting in cycles or not.

-- 
 i.

> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 134 ++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 4ed9c7fd2b62..635ecc3b3845 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -88,6 +88,8 @@
>  #define MLXBF_PMC_CRSPACE_PERFMON_CTL(n) (n * MLXBF_PMC_CRSPACE_PERFMON_REG0_SZ)
>  #define MLXBF_PMC_CRSPACE_PERFMON_EN BIT(30)
>  #define MLXBF_PMC_CRSPACE_PERFMON_CLR BIT(28)
> +#define MLXBF_PMC_CRSPACE_PERFMON_UOC GENMASK(15, 0)
> +#define MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0x4)
>  #define MLXBF_PMC_CRSPACE_PERFMON_VAL0(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0xc)
>  
>  /**
> @@ -114,6 +116,8 @@ struct mlxbf_pmc_attribute {
>   * @attr_event: Attributes for "event" sysfs files
>   * @attr_event_list: Attributes for "event_list" sysfs files
>   * @attr_enable: Attributes for "enable" sysfs files
> + * @attr_use_odd_counter: Attributes for "use_odd_counter" sysfs files
> + * @attr_count_clock: Attributes for "count_clock" sysfs files
>   * @block_attr: All attributes needed for the block
>   * @block_attr_grp: Attribute group for the block
>   */
> @@ -126,6 +130,8 @@ struct mlxbf_pmc_block_info {
>  	struct mlxbf_pmc_attribute *attr_event;
>  	struct mlxbf_pmc_attribute attr_event_list;
>  	struct mlxbf_pmc_attribute attr_enable;
> +	struct mlxbf_pmc_attribute attr_use_odd_counter;
> +	struct mlxbf_pmc_attribute attr_count_clock;
>  	struct attribute *block_attr[MLXBF_PMC_MAX_ATTRS];
>  	struct attribute_group block_attr_grp;
>  };
> @@ -1763,6 +1769,103 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
>  	return count;
>  }
>  
> +/* Show function for "use_odd_counter" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_use_odd_counter_show(struct device *dev,
> +					      struct device_attribute *attr, char *buf)
> +{
> +	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	unsigned int blk_num;
> +	u32 value, reg;
> +
> +	blk_num = attr_use_odd_counter->nr;
> +
> +	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +			MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +			&reg))
> +		return -EINVAL;
> +
> +	value = FIELD_GET(MLXBF_PMC_CRSPACE_PERFMON_UOC, reg);
> +
> +	return sysfs_emit(buf, "%u\n", value);
> +}
> +
> +/* Store function for "use_odd_counter" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_use_odd_counter_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	unsigned int blk_num;
> +	u32 uoc, reg;
> +	int err;
> +
> +	blk_num = attr_use_odd_counter->nr;
> +
> +	err = kstrtouint(buf, 0, &uoc);
> +	if (err < 0)
> +		return err;
> +
> +	err = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +		&reg);
> +	if (err)
> +		return -EINVAL;
> +
> +	reg &= ~MLXBF_PMC_CRSPACE_PERFMON_UOC;
> +	reg |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFMON_UOC, uoc);
> +
> +	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +		MLXBF_PMC_WRITE_REG_32, reg);
> +
> +	return count;
> +}
> +
> +/* Show function for "count_clock" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_count_clock_show(struct device *dev,
> +					  struct device_attribute *attr, char *buf)
> +{
> +	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	unsigned int blk_num;
> +	u32 reg;
> +
> +	blk_num = attr_count_clock->nr;
> +
> +	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +			MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
> +			&reg))
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%u\n", reg);
> +}
> +
> +/* Store function for "count_clock" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_count_clock_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	unsigned int blk_num;
> +	u32 reg;
> +	int err;
> +
> +	blk_num = attr_count_clock->nr;
> +
> +	err = kstrtouint(buf, 0, &reg);
> +	if (err < 0)
> +		return err;
> +
> +	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
> +		MLXBF_PMC_WRITE_REG_32, reg);
> +
> +	return count;
> +}
> +
>  /* Populate attributes for blocks with counters to monitor performance */
>  static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_num)
>  {
> @@ -1799,6 +1902,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
>  		attr = NULL;
>  	}
>  
> +	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
> +		/*
> +		 * Couple adjacent odd and even 32-bit counters to form 64-bit counters
> +		 * using "use_odd_counter" sysfs which has one bit per even counter.
> +		 */
> +		attr = &pmc->block[blk_num].attr_use_odd_counter;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_use_odd_counter_show;
> +		attr->dev_attr.store = mlxbf_pmc_use_odd_counter_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "use_odd_counter");
> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +
> +		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
> +		attr = &pmc->block[blk_num].attr_count_clock;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
> +		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "count_clock");
> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +	}


