Return-Path: <linux-kernel+bounces-246956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA492C951
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0883628470F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0534AEE5;
	Wed, 10 Jul 2024 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM1TguvA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A03BBED;
	Wed, 10 Jul 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582690; cv=none; b=YduVqFYj9QHI1fADkbICZxIG/+2WfyMBWZYycn3UpCSuTjso1eDQWVTMpQnYklZsfPoTlikwti6O/kobs0V+zF7KRBjc6UkwpFpI8GbGq4LX7QxOmXQCtHqbpMp0TluKIIjQiGErXVSTo1Uh9udH7rkN9IEUMMlid9USvmrkZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582690; c=relaxed/simple;
	bh=M2ROzHQROcrCllh9+iB4Unb61gbzwCLA055NO3yeYwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaioRKF+3O70pqs99k3vuaviRx9A2Sx+Dm/L6rMkSQNSPkw0vmcgGXMNlB0fefhMhqcPW2zNXKjFqdVTfBmgMTz5r6DvTLI5VqyqNSNLWjvWImIDlDr1t1wCoSx8l4pmY2rWoWjaC3eZUEIPJlpi7lzzihOw71PoBcFiV33xvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM1TguvA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720582687; x=1752118687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M2ROzHQROcrCllh9+iB4Unb61gbzwCLA055NO3yeYwQ=;
  b=XM1TguvAzS1tIUaGWk5NSjeIO86gbgvyzG3vhu6qfi4Zob7HeDUL1FUh
   fSiG61XpAedElKqVGPUl3gdkTbj7akxcsfmFzs8qNOskqtplPbyR86C4o
   fpy/yYK0rh3yzOJHK1eDS32TczxEerZqnjmCBvH1oPvbCb9THBY6ZmPdz
   7q6ou8AwhQfS4RvPkPv3hNpLuu9/oBpWJELU1A+fC7kp5Y08+3EiAbfzW
   EXGLP7sL0h12hEBCTssJ6+4Z/dK0LWZM/PHcCnnAp8coVVfffw5SGAdIq
   +DIWFH9pGYXp3lvLmgMAlHmq2dv2Fdkk4p5q1VYMt57XfjOWQVOOtOHey
   g==;
X-CSE-ConnectionGUID: /a50K+zSSVmHHvrioV/5oQ==
X-CSE-MsgGUID: X7ChcVUERp2naW5TD7CX7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18017373"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="18017373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 20:38:07 -0700
X-CSE-ConnectionGUID: J5tEipYOQ46fM4Cj3kAsVA==
X-CSE-MsgGUID: VoKJNgA6SHaJKU/R7rmmiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="71297673"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jul 2024 20:38:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRO9Y-000XPu-2D;
	Wed, 10 Jul 2024 03:38:00 +0000
Date: Wed, 10 Jul 2024 11:37:52 +0800
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
Message-ID: <202407101157.p2OvSFcO-lkp@intel.com>
References: <20240707002055.1835121-6-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707002055.1835121-6-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on next-20240709]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240707-082513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240707002055.1835121-6-cristian.marussi%40arm.com
patch subject: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone driver
config: arm64-randconfig-r131-20240709 (https://download.01.org/0day-ci/archive/20240710/202407101157.p2OvSFcO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240710/202407101157.p2OvSFcO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407101157.p2OvSFcO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/scmi_transport_smc.c:276:24: sparse: sparse: symbol 'scmi_smc_desc' was not declared. Should it be static?

vim +/scmi_smc_desc +276 drivers/firmware/arm_scmi/scmi_transport_smc.c

1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  275  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08 @276  const struct scmi_desc scmi_smc_desc = {
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  277  	.ops = &scmi_smc_ops,
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  278  	.max_rx_timeout_ms = 30,
7adb2c8aaaa6a3 drivers/firmware/arm_scmi/smc.c                Etienne Carriere 2020-10-08  279  	.max_msg = 20,
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  280  	.max_msg_size = 128,
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  281  	/*
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  282  	 * Setting .sync_cmds_atomic_replies to true for SMC assumes that,
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  283  	 * once the SMC instruction has completed successfully, the issued
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  284  	 * SCMI command would have been already fully processed by the SCMI
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  285  	 * platform firmware and so any possible response value expected
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  286  	 * for the issued command will be immmediately ready to be fetched
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  287  	 * from the shared memory area.
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  288  	 */
117542b81fe7b1 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  289  	.sync_cmds_completed_on_ret = true,
0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  290  	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  291  };
728a057b6ab114 drivers/firmware/arm_scmi/scmi_transport_smc.c Cristian Marussi 2024-07-07  292  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

