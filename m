Return-Path: <linux-kernel+bounces-251134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7C930111
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A26281DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3938DE0;
	Fri, 12 Jul 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8zKat8A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1D18C08;
	Fri, 12 Jul 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813493; cv=none; b=JPkA7J0OahdNP8Bq1AccuDC1nGgFCMlaMbWBcyPP79xvPGvTPTF2pMpbSMHFQprD76qnfdE4NXX6Pp/NTS3k63efO+7Gw+vlPEjrQoL6E2ii1PnbjWU7Cayo64IyGWHsEPD12K7IjU4ZtCy/DrEC//DTCnk1WtJLJhKPTEvnNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813493; c=relaxed/simple;
	bh=Xs0O2s+oSugsI3ZvzFon2V/CPImOC2vIfiyCeloaF50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYvFh+9yaX+8gIYW2rYVTBoxG51tp3qNndCEFxo/iA/4USGQzQlQE+Fj+45n08P/aujDoSMo6pXauW0B/Bs0iT+V+yLxB6/DRZ/uoJF3ZsjqHw1hALWfjAajYHQ/5ZA/LsyC7mqAt+8mIWCSjLOVjV2sYWZIZXWCUAXPMLp5Fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8zKat8A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720813490; x=1752349490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xs0O2s+oSugsI3ZvzFon2V/CPImOC2vIfiyCeloaF50=;
  b=a8zKat8AnWbWtEITTe3xmFZVTgMbc7+n67jtUFi7OiOs7Jodyg+3AjVb
   sjrASiY1ZES2Q62GXhLHeXuyAt7acJBSk97ADafgtYanf5yGO66OUs2D3
   hZbq4DqR800QQPuacJuCT07aZBE715olyqDKsXUcE2uJQIS38zFBNdQOq
   +YXHce3BjjlC4IIdXYtxEN3mseIPN7zepGWjBV7pZ6uOe7ycUM7ovIkc0
   krSwi6QPzgCDwy0wYGnOvCmMZtPi4PZGH0uA8TlGs/HZohFGiOKJa9m+s
   Ka/mjJImIzfaeTTW4I8g1FYD9RpnSfSRzr4LnNbVwsbbPBgrau/zz6OGa
   A==;
X-CSE-ConnectionGUID: cvOUlNZxRoWWjYilZ4mQWg==
X-CSE-MsgGUID: SKyLEqzZQJ2dxumhEO95eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18410756"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="18410756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:44:50 -0700
X-CSE-ConnectionGUID: KbSQTBy9RoSsODOpBO4kLw==
X-CSE-MsgGUID: IYmtyCCoQICB0UX5f2j4pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="80104949"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jul 2024 12:44:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSMCA-000bCo-1u;
	Fri, 12 Jul 2024 19:44:42 +0000
Date: Sat, 13 Jul 2024 03:44:38 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
Message-ID: <202407130355.IWguWKJm-lkp@intel.com>
References: <20240710173153.4060457-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710173153.4060457-2-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on next-20240712]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240711-062033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240710173153.4060457-2-cristian.marussi%40arm.com
patch subject: [PATCH v2 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
config: arm64-randconfig-r132-20240712 (https://download.01.org/0day-ci/archive/20240713/202407130355.IWguWKJm-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20240713/202407130355.IWguWKJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407130355.IWguWKJm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/shmem.c:153:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/firmware/arm_scmi/shmem.c:153:31: sparse:     expected void [noderef] __iomem *
   drivers/firmware/arm_scmi/shmem.c:153:31: sparse:     got void *
   drivers/firmware/arm_scmi/shmem.c:156:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/firmware/arm_scmi/shmem.c:156:31: sparse:     expected void [noderef] __iomem *
   drivers/firmware/arm_scmi/shmem.c:156:31: sparse:     got void *
   drivers/firmware/arm_scmi/shmem.c:165:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/firmware/arm_scmi/shmem.c:165:31: sparse:     expected void [noderef] __iomem *
   drivers/firmware/arm_scmi/shmem.c:165:31: sparse:     got void *
   drivers/firmware/arm_scmi/shmem.c:172:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/firmware/arm_scmi/shmem.c:172:31: sparse:     expected void [noderef] __iomem *
   drivers/firmware/arm_scmi/shmem.c:172:31: sparse:     got void *

vim +153 drivers/firmware/arm_scmi/shmem.c

   138	
   139	void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo,
   140					struct device *dev, bool tx,
   141					struct resource *res)
   142	{
   143		struct device_node *shmem __free(device_node);
   144		const char *desc = tx ? "Tx" : "Rx";
   145		int ret, idx = tx ? 0 : 1;
   146		struct device *cdev = cinfo->dev;
   147		struct resource lres = {};
   148		resource_size_t size;
   149		void __iomem *addr;
   150	
   151		shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
   152		if (!shmem)
 > 153			return ERR_PTR(-ENODEV);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

