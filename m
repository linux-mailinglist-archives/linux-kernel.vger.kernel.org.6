Return-Path: <linux-kernel+bounces-333948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4C97D049
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61FF282DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D025745;
	Fri, 20 Sep 2024 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcWbGhrP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE101863E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726803380; cv=none; b=GCX5x0bFzmHj86rMl20wQD7mBANfPD9FeyNH+JlgKpcnR6opNlXdEml3VHAUcj+eKxQ7EZLJrkdI6qJcG0Rl3P9ehWhfVaRoJ6sr0YK1USzocIt1AjCKP873cKzK7ZbC//BnHO+3hb/OB0ptdxv3wxJ23dwcl6SNm29ZQJr7MEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726803380; c=relaxed/simple;
	bh=sQOi+DJccYWuLL/d6MtyHFVyVTZ3RrxdRwdb6ZsSJCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShL6teSphelecAiMfqSCEuYzHaq9fBfPyKAKc6bGHDgNYSyRZW/4wxU9d2/nRnQMt5asEKIDkEPQmTi3e1+hp8iLEjQ8Ftf3cxELGz8a7P4YZx1rKfRdxDXU/XRWgcEVPfyD7TJM0cPNM94QI0NevZC2RSXTYQg4wpWKPNcsJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcWbGhrP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726803379; x=1758339379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQOi+DJccYWuLL/d6MtyHFVyVTZ3RrxdRwdb6ZsSJCE=;
  b=XcWbGhrP5eTHaCGtBmE5b71zx9Og6BEVcHOeyulvg37rPntiJbPdqXds
   B13tXtWRNQ0qmiFhe0aWPI9oK/Bcm+3VbcAgBwdTIfVvAaWi8v4adFVS5
   C9xOJzwGJrxDtqCw10goWoP320scpCtqCoZ/vjNe9uoF2kgRjA46S2R/Q
   Yhehl/rVVp1ZDlcvWMjz5uk7RF7sExgr4bTJ23u6nVrB6eAL4uy5X2/eA
   5cx4oOaPvkKe8wmywA6NHMFCDQgYb3XZE/cRnETJVM8Ea4IXEp4l5BaVN
   7JZnXQunbNGaM7IsP3hLmCOl2ayO/TH1rUJytH/vhXN3L5Ezz86icmoIB
   w==;
X-CSE-ConnectionGUID: dudAhnu8RnGoJScdtzTxgg==
X-CSE-MsgGUID: oTTBrfLDRjGsAzviE0nwzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25670169"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25670169"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 20:36:18 -0700
X-CSE-ConnectionGUID: vaQYfDo+SZ2GJtYwD36SRQ==
X-CSE-MsgGUID: zEFAcQb2RaeZ/zqTsoUVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70284826"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Sep 2024 20:36:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srURJ-000DvT-0J;
	Fri, 20 Sep 2024 03:36:13 +0000
Date: Fri, 20 Sep 2024 11:35:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	lcherian@marvell.com, gcherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v7] perf/marvell: Marvell PEM performance monitor support
Message-ID: <202409201101.hqshrCE7-lkp@intel.com>
References: <20240919125117.3484572-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919125117.3484572-1-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/smp/core]
[also build test WARNING on soc/for-next linus/master v6.11 next-20240919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Marvell-PEM-performance-monitor-support/20240919-205406
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/20240919125117.3484572-1-gthiagarajan%40marvell.com
patch subject: [PATCH v7] perf/marvell: Marvell PEM performance monitor support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240920/202409201101.hqshrCE7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201101.hqshrCE7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201101.hqshrCE7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/perf/marvell_pem_pmu.c: In function 'pem_perf_read_counter':
   drivers/perf/marvell_pem_pmu.c:232:16: error: implicit declaration of function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Wimplicit-function-declaration]
     232 |         return readq_relaxed(pmu->base + eventid_to_offset(eventid));
         |                ^~~~~~~~~~~~~
         |                readl_relaxed
   drivers/perf/marvell_pem_pmu.c: In function 'pem_perf_probe':
>> drivers/perf/marvell_pem_pmu.c:353:78: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     353 |         name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
         |                                                                           ~~~^
         |                                                                              |
         |                                                                              long long unsigned int
         |                                                                           %x
     354 |                               res->start);
         |                               ~~~~~~~~~~                                      
         |                                  |
         |                                  resource_size_t {aka unsigned int}


vim +353 drivers/perf/marvell_pem_pmu.c

   315	
   316	static int pem_perf_probe(struct platform_device *pdev)
   317	{
   318		struct pem_pmu *pem_pmu;
   319		struct resource *res;
   320		void __iomem *base;
   321		char *name;
   322		int ret;
   323	
   324		pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
   325		if (!pem_pmu)
   326			return -ENOMEM;
   327	
   328		pem_pmu->dev = &pdev->dev;
   329		platform_set_drvdata(pdev, pem_pmu);
   330	
   331		base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   332		if (IS_ERR(base))
   333			return PTR_ERR(base);
   334	
   335		pem_pmu->base = base;
   336	
   337		pem_pmu->pmu = (struct pmu) {
   338			.module	      = THIS_MODULE,
   339			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
   340			.task_ctx_nr = perf_invalid_context,
   341			.attr_groups = pem_perf_attr_groups,
   342			.event_init  = pem_perf_event_init,
   343			.add	     = pem_perf_event_add,
   344			.del	     = pem_perf_event_del,
   345			.start	     = pem_perf_event_start,
   346			.stop	     = pem_perf_event_stop,
   347			.read	     = pem_perf_event_update,
   348		};
   349	
   350		/* Choose this cpu to collect perf data */
   351		pem_pmu->cpu = raw_smp_processor_id();
   352	
 > 353		name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
   354				      res->start);
   355		if (!name)
   356			return -ENOMEM;
   357	
   358		cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
   359						 &pem_pmu->node);
   360	
   361		ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
   362		if (ret)
   363			goto error;
   364	
   365		return 0;
   366	error:
   367		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
   368						    &pem_pmu->node);
   369		return ret;
   370	}
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

