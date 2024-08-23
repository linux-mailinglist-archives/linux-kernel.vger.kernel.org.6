Return-Path: <linux-kernel+bounces-298891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5F95CCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F5B221BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCDC185E7B;
	Fri, 23 Aug 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpKjaEbH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A0136E2E;
	Fri, 23 Aug 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417322; cv=none; b=hk+6xEfFtQJB67hnbKH0TXv9oak3JnT0M322y6zoQXp1ZZyeIQGWDPDcjHGn3yZAdaogOqvGG1xoEl4iGl+4HpBTd2qb25PiX77HSshDhaIjOzSYK6TOsT25X2awFhfMhJxBPN4ybekxxQ28BDHanP/ng+UAagXYF7kA5P0vtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417322; c=relaxed/simple;
	bh=FRPHzX2x8IdGmESULRYConm7ga8nwv8NqW76+alQfYE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cVuPFub7QFVilEO50ZwoofcqRexSTkBmBw+Nt14lsiKpjvbJpuRgWy/yo5UMCcNvBYTlfsC1PmkMLrudP1eDwrApPNdB47pLyF8a9Z9uZPKO12zbV9QV3WYGWzeOIbeRn2dZfIC0fymMvj1ER85yeRpxl8Fq77sh3HWaAsF58jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpKjaEbH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724417321; x=1755953321;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FRPHzX2x8IdGmESULRYConm7ga8nwv8NqW76+alQfYE=;
  b=VpKjaEbH+vU3g5mhvS4gZx63N9w8jOy+BXOCNTgKNslh7RZv+y/S/bTe
   ZI3ECmhMqsBZFFqb9c2eWX5+wyArHvj+v9eQflLTqZz/9WtESen3x3cR5
   Cuy/lE4uqkMsHk6bG2EcA06V75d8cJ2PDzoo1BfoPaT14bwGUYm+2NOZV
   6N9xxi2Y+Qh91nFWzZLDvspqm6/uwjWE1YAA3xA16l2AS7PaLN9IVE50B
   CBHYfmrS0I/P4oQNkPZhmkcxEU/+rM7DX+bQD0tTWmmBHck2u5U22j2BH
   g9QG8toDXdMU5F9EL92IH9ojgYu0gwKCxZOg6nYyovJLJuKGpcpMVuXY9
   w==;
X-CSE-ConnectionGUID: Hkcl8N7lTxCY+MlPo7VEOA==
X-CSE-MsgGUID: 2ZWDDDfIRZ+4vpKFJj9IVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26753981"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="26753981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:48:41 -0700
X-CSE-ConnectionGUID: qbNE1WYOTYCwiZeBw+Owog==
X-CSE-MsgGUID: 0CEBFTqGRyqhzFH/j3Q+rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="92513984"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:48:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 15:48:34 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86/intel-uncore-freq: Add support for
 efficiency latency control
In-Reply-To: <20240821131321.824326-3-tero.kristo@linux.intel.com>
Message-ID: <0abf523f-56a8-b0be-cf15-d799a0a4fc90@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com> <20240821131321.824326-3-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 Aug 2024, Tero Kristo wrote:

> Add efficiency latency control support to the TPMI uncore driver. This
> defines two new threshold values for controlling uncore frequency, low
> threshold and high threshold. When CPU utilization is below low threshold,
> the user configurable floor latency control frequency can be used by the
> system. When CPU utilization is above high threshold, the uncore frequency
> is increased in 100MHz steps until power limit is reached.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  .../uncore-frequency-common.h                 |   4 +
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 153 +++++++++++++++++-
>  2 files changed, 155 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
> index 4c245b945e4e..b5c7311bfa05 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
> @@ -70,6 +70,10 @@ enum uncore_index {
>  	UNCORE_INDEX_MIN_FREQ,
>  	UNCORE_INDEX_MAX_FREQ,
>  	UNCORE_INDEX_CURRENT_FREQ,
> +	UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD,
> +	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD,
> +	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,
> +	UNCORE_INDEX_EFF_LAT_CTRL_FREQ,
>  };
>  
>  int uncore_freq_common_init(int (*read)(struct uncore_data *data, unsigned int *value,
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index 9fa3037c03d1..3a83b6ce54a5 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -30,6 +30,7 @@
>  
>  #define	UNCORE_MAJOR_VERSION		0
>  #define	UNCORE_MINOR_VERSION		2
> +#define UNCORE_ELC_SUPPORTED_VERSION	2
>  #define UNCORE_HEADER_INDEX		0
>  #define UNCORE_FABRIC_CLUSTER_OFFSET	8
>  
> @@ -46,6 +47,7 @@ struct tpmi_uncore_struct;
>  /* Information for each cluster */
>  struct tpmi_uncore_cluster_info {
>  	bool root_domain;
> +	bool elc_supported;
>  	u8 __iomem *cluster_base;
>  	struct uncore_data uncore_data;
>  	struct tpmi_uncore_struct *uncore_root;
> @@ -75,6 +77,10 @@ struct tpmi_uncore_struct {
>  /* Bit definitions for CONTROL register */
>  #define UNCORE_MAX_RATIO_MASK				GENMASK_ULL(14, 8)
>  #define UNCORE_MIN_RATIO_MASK				GENMASK_ULL(21, 15)
> +#define UNCORE_EFF_LAT_CTRL_RATIO_MASK			GENMASK_ULL(28, 22)
> +#define UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK		GENMASK_ULL(38, 32)
> +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE	BIT(39)
> +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK		GENMASK_ULL(46, 40)
>  
>  /* Helper function to read MMIO offset for max/min control frequency */
>  static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
> @@ -89,6 +95,48 @@ static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
>  		*value = FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
>  }
>  
> +/* Helper function to read efficiency latency control values over MMIO */
> +static int read_eff_lat_ctrl(struct uncore_data *data, unsigned int *val, enum uncore_index index)
> +{
> +	struct tpmi_uncore_cluster_info *cluster_info;
> +	u64 ctrl;
> +
> +	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
> +	if (cluster_info->root_domain)
> +		return -ENODATA;
> +
> +	if (!cluster_info->elc_supported)
> +		return -EOPNOTSUPP;
> +
> +	ctrl = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +	switch (index) {
> +	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, ctrl);
> +		*val *= 100;
> +		*val = DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK));
> +		break;
> +
> +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, ctrl);
> +		*val *= 100;
> +		*val = DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK));
> +		break;
> +
> +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, ctrl);
> +		break;
> +	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_RATIO_MASK, ctrl) * UNCORE_FREQ_KHZ_MULTIPLIER;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  #define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
>  
>  /* Helper for sysfs read for max/min frequencies. Called under mutex locks */
> @@ -137,6 +185,77 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
>  	return 0;
>  }
>  
> +/* Helper function for writing efficiency latency control values over MMIO */
> +static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val, enum uncore_index index)
> +{
> +	struct tpmi_uncore_cluster_info *cluster_info;
> +	u64 control;
> +
> +	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
> +
> +	if (cluster_info->root_domain)
> +		return -ENODATA;
> +
> +	if (!cluster_info->elc_supported)
> +		return -EOPNOTSUPP;
> +
> +	switch (index) {
> +	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +		if (val > 100)
> +			return -EINVAL;
> +		break;
> +
> +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +		if (val > 100)
> +			return -EINVAL;
> +		break;
> +
> +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +		if (val > 1)
> +			return -EINVAL;
> +		break;
> +
> +	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +		val /= UNCORE_FREQ_KHZ_MULTIPLIER;
> +		if (val > FIELD_MAX(UNCORE_EFF_LAT_CTRL_RATIO_MASK))
> +			return -EINVAL;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +	if (index == UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD) {
> +		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK);
> +		val /= 100;
> +		control &= ~UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK;
> +		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, val);
> +	}
> +
> +	if (index == UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD) {
> +		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK);
> +		val /= 100;
> +		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK;
> +		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, val);
> +	}
> +
> +	if (index == UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> +		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE;
> +		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, val);
> +	}
> +
> +	if (index == UNCORE_INDEX_EFF_LAT_CTRL_FREQ) {
> +		control &= ~UNCORE_EFF_LAT_CTRL_RATIO_MASK;
> +		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_RATIO_MASK, val);
> +	}

Why are these not using switch/case?

-- 
 i.

> +
> +	writeq(control, cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +	return 0;
> +}

