Return-Path: <linux-kernel+bounces-243832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777E929B30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1D92814F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29FB66F;
	Mon,  8 Jul 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwUocrG1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401B12B6C;
	Mon,  8 Jul 2024 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411204; cv=none; b=tn2X3hdZovd6882O3cRs/9Our3XfZJ6vzI1PPKGADF6w+Qqqg/tJ0PetG6q+LxBJ5MGP+Q3cYghLfeataF53QfYF7z9AOQtX79I7vZQq/X7lMUgE2gfULASSsZxABvPDabwiGhQl4YOBlJ8Eq4noKpkeEFBbmFZheZ9OewO8x5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411204; c=relaxed/simple;
	bh=6MJg+qo/rOeiqM9LUVX2vbFaeRb3zr3mwD8IH4hQasA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvODp+/aH57FckXn0oeIym1/rg6BQ8fJCKjhvHNxgwT/qQTgix+0d49IUz2SU7iAty1cpFog5oJB2I43e+ECoWIikvvWGrr3KYRAT5GKyPagIqviigv1RoWrKWMX22XJ3Y6pBVPrU5G71IhINvjPXOzElZVfLR6wIuev5YRfzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwUocrG1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720411202; x=1751947202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6MJg+qo/rOeiqM9LUVX2vbFaeRb3zr3mwD8IH4hQasA=;
  b=UwUocrG1Ip3daFSDhohQGW71qgvGpz2EvXjxp7ooBpz/i52A6DKD8jwv
   kzZ26RDKUCYGzb3ZUvGqncFwmHBY42RD2TgHR5RJcGIRYDQSOREVEt16s
   FJu25ILDyMlyfgBAtAFjJ0gIU4YjXNi1+9907V2iTfKI3Xu4wXB7OBNQk
   ujlPM4yeQAIs/OcFRQWioqy4Voz0CK8RGH1fBPYXgAdeaSFy5tX4we6+7
   LISwkd9SJB8en5M7RRtdP/8SuEtQ0AkEWd8V1FMn7cYKfFLwWZJEXpFIo
   6lVqHEs5HwXztXuwHP5pPwdq3Ak6wxvy6Nh8FhLQ0RsCFJ4nh95lFsPyp
   w==;
X-CSE-ConnectionGUID: OAaifKifQNeWnWTDtWEw+A==
X-CSE-MsgGUID: 1Bd/WjQeTvGfZSbezFuclA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17727366"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17727366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 21:00:02 -0700
X-CSE-ConnectionGUID: +ihNx+V0RgOSu+1zPUy47g==
X-CSE-MsgGUID: WtQIuS/XSjaNauYFXBotCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51990014"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Jul 2024 20:59:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQfXf-000VVC-01;
	Mon, 08 Jul 2024 03:59:55 +0000
Date: Mon, 8 Jul 2024 11:59:26 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 2/8] firmware: arm_scmi: Introduce packet handling helpers
Message-ID: <202407081158.9B8bXpH0-lkp@intel.com>
References: <20240707002055.1835121-3-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707002055.1835121-3-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on next-20240703]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240707-082513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240707002055.1835121-3-cristian.marussi%40arm.com
patch subject: [PATCH 2/8] firmware: arm_scmi: Introduce packet handling helpers
config: arm-randconfig-r111-20240708 (https://download.01.org/0day-ci/archive/20240708/202407081158.9B8bXpH0-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce: (https://download.01.org/0day-ci/archive/20240708/202407081158.9B8bXpH0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407081158.9B8bXpH0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/firmware/arm_scmi/shmem.c:171:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] addr @@
   drivers/firmware/arm_scmi/shmem.c:171:16: sparse:     expected void *
   drivers/firmware/arm_scmi/shmem.c:171:16: sparse:     got void [noderef] __iomem *[assigned] addr
>> drivers/firmware/arm_scmi/shmem.c:183:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *( *setup_iomap )( ... ) @@     got void *( [noderef] __iomem * )( ... ) @@
   drivers/firmware/arm_scmi/shmem.c:183:24: sparse:     expected void [noderef] __iomem *( *setup_iomap )( ... )
   drivers/firmware/arm_scmi/shmem.c:183:24: sparse:     got void *( [noderef] __iomem * )( ... )
   drivers/firmware/arm_scmi/shmem.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +183 drivers/firmware/arm_scmi/shmem.c

   173	
   174	const struct scmi_shared_mem_operations scmi_shmem_ops = {
   175		.tx_prepare = shmem_tx_prepare,
   176		.read_header = shmem_read_header,
   177		.fetch_response = shmem_fetch_response,
   178		.fetch_notification = shmem_fetch_notification,
   179		.clear_channel = shmem_clear_channel,
   180		.poll_done = shmem_poll_done,
   181		.channel_free = shmem_channel_free,
   182		.channel_intr_enabled = shmem_channel_intr_enabled,
 > 183		.setup_iomap = shmem_setup_iomap,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

