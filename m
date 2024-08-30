Return-Path: <linux-kernel+bounces-308486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2B965D98
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835BD1C2302B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5251917BB01;
	Fri, 30 Aug 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lca60JrQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857713A261;
	Fri, 30 Aug 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011637; cv=none; b=Et4ha1F335UPzNVq3gbVDA9MbEoYxtbnfH1zg8b3lcF3MUmI4KZq5TrPMrMa22PW2hKkDa/1EoHJOecoWrhMSbC0bDsKhwrLvE5lP4f5468l+U61eW9XXlai4IwVXoCpsv/M5J8F4n4knlZxoD31ybP9EUcRHf4J2sODV+9hQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011637; c=relaxed/simple;
	bh=+zIwCCKQPYwYRIIkUV99DUi+yAmBgMOFRt+dGkzfPFY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wwu+9riPegGbuDQhj0CceULap3mwjx3soL2hQPMZipy2BJQgMLIKrtu/1tuOYOX/7xOhX5ZJsrk2YUjpawTWIQhflWNFt/lxdcRA1EiaWro4ojEq1TKfeCXUqmplyu1EJHaK9/VgHfEkkE7OU9FUE2VKoIi7EQtXMsJlth8fejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lca60JrQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725011635; x=1756547635;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+zIwCCKQPYwYRIIkUV99DUi+yAmBgMOFRt+dGkzfPFY=;
  b=lca60JrQyMkK0hR7Yl9iKNJpNXa6C6h41fZTiUT4qTVM1zK1hCznJ0DV
   hq635rTaldVHv7Uc1BwHtbWdxYHzpY4occT+znYuVblgkTO295uDfBTbS
   WiXxttYidNV5fLD+W36tBwdMe+ynDOqzBrS7Y7ovWRf0YYWZMxS2Y7Kvh
   PKLAWT0lLpeo1dxjrueCXUnFrqAUDDpEcHDnHyX1EbV9WzN0P2naanwUQ
   0i15RY/4Nf8g+loJFNVBUnLdgN/35SU0xKcC5b+FxszGCcirH5WA02WX9
   KdDQFJc0nwMnX31UprGG8AIAt5y+MvoUN5XT3DZ8mXIzNwZ3kgpbXNCf+
   A==;
X-CSE-ConnectionGUID: zeC6kaZKTqeAkFgIjIDhLw==
X-CSE-MsgGUID: 92MAVJKxRBSU9cbHQ/CB/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35052462"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="35052462"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:53:54 -0700
X-CSE-ConnectionGUID: eQTUA7McSOGgtZGPzhY7qQ==
X-CSE-MsgGUID: IRI29FxnSiCTXNxHbbj94g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64197176"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:53:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 12:53:48 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86:intel/pmc: Ignore all LTRs during suspend
In-Reply-To: <20240808205551.403770-1-xi.pardee@linux.intel.com>
Message-ID: <0332a6a1-840b-576c-fe81-f1a690d0dd9a@linux.intel.com>
References: <20240808205551.403770-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Aug 2024, Xi Pardee wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> Add support to ignore all LTRs before suspend and restore the previous
> LTR values after suspend. This feature could be turned off with module
> parameter ltr_ignore_all_suspend.

This does not answer why? question.

> Suggested-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>

Please add a space between the name and email.

This patch seems to have fallen through cracks and did not appear in the 
patchwork at all.

> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  2 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 01ae71c6df59..f364a011721d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
>  
> +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +		struct pmc *pmc;
> +		u32 ltr_ign;
> +
> +		pmc = pmcdev->pmcs[i];
> +		if (!pmc)
> +			continue;
> +
> +		guard(mutex)(&pmcdev->lock);
> +		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
> +
> +		/* ltr_ignore_max is the max index value for ltr ignore register */

ltr -> LTR

> +		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
> +	}
> +
> +	/*
> +	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
> +	 * deeper S0IX substate.

S0ix

--
 i.

> +	 */
> +	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
> +}
> +
> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +		struct pmc *pmc;
> +
> +		pmc = pmcdev->pmcs[i];
> +		if (!pmc)
> +			continue;
> +
> +		guard(mutex)(&pmcdev->lock);
> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
> +	}
> +}
> +
>  static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>  				       const int lpm_adj_x2)
>  {
> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>  module_param(warn_on_s0ix_failures, bool, 0644);
>  MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>  
> +static bool ltr_ignore_all_suspend = true;
> +module_param(ltr_ignore_all_suspend, bool, 0644);
> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
> +
>  static __maybe_unused int pmc_core_suspend(struct device *dev)
>  {
>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>  	if (pmcdev->suspend)
>  		pmcdev->suspend(pmcdev);
>  
> +	if (ltr_ignore_all_suspend)
> +		pmc_core_ltr_ignore_all(pmcdev);
> +
>  	/* Check if the syspend will actually use S0ix */
>  	if (pm_suspend_via_firmware())
>  		return 0;
> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>  {
>  	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>  
> +	if (ltr_ignore_all_suspend)
> +		pmc_core_ltr_restore_all(pmcdev);
> +
>  	if (pmcdev->resume)
>  		return pmcdev->resume(pmcdev);
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ea04de7eb9e8..e862ea88b816 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -372,6 +372,7 @@ struct pmc_info {
>   * @map:		pointer to pmc_reg_map struct that contains platform
>   *			specific attributes
>   * @lpm_req_regs:	List of substate requirements
> + * @ltr_ign:		Holds LTR ignore data while suspended
>   *
>   * pmc contains info about one power management controller device.
>   */
> @@ -380,6 +381,7 @@ struct pmc {
>  	void __iomem *regbase;
>  	const struct pmc_reg_map *map;
>  	u32 *lpm_req_regs;
> +	u32 ltr_ign;
>  };
>  
>  /**
> 

