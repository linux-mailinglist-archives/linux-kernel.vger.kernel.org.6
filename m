Return-Path: <linux-kernel+bounces-243645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAC19298BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DD81C2151B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20213BB32;
	Sun,  7 Jul 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEe/JAKt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578328EA;
	Sun,  7 Jul 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368227; cv=none; b=UHlVV8JOfZCAtjt4CA33FAQfMcykcdKN61KXlchG5O9dhIEo0D5r9C7XR+Cb8UdqPPUHNm40TK3j7txyCR4DLQ2I1HYzRUi8O0vmDuL/BUm4PE+rfvpPvsv9eeZ1MRBX2s8Ms0w/QtaahqP5ZFcCIAjpSL7KJdf931Jbid+Uk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368227; c=relaxed/simple;
	bh=+C98fktP2PvVUClWe+Ihb8xDaQzuDfLxCpAMjLAICOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4a4wIxts4ZeMtBROa7SqkGqZtIlGBvWjA91I+zRcniUIPP0CwJ78If5uyOudxp7v1nEib7qibsng6fbeo6af/AprGEL5Lo2AoVQjSSZaZKEEsF6NeuUgeky7Axsk+AWQnLfD0KSfWLYGJsWpv1LM3H5enaBM9tQNCzzjbg9zOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEe/JAKt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720368225; x=1751904225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+C98fktP2PvVUClWe+Ihb8xDaQzuDfLxCpAMjLAICOE=;
  b=SEe/JAKtyVjlEGal+UM3k20W8sL+7+busMziGhc8tlKei+aGvlj1z7hv
   t0ZCjiyUEhLBhL0l1Wytj9MiohyiFFco1TyXcVPxHyVHQ6BtPRwPTqLmw
   Ot43cZc4gngFQVvLYAr9p96aWudu5D7jqRMfrUSAyPnvCRFclMXnnX921
   ibplSwbyXrkzqDMxZ15YLOjzQQjZuyGZ6cB72td7PS7//sA0bPu0WxsSI
   IjjVjl/3d9GOoYYsvTSKD7nr/wXlD3Vp6+gwfXAwBVjpEBEGTYdZ2Fl6h
   eRdE/Lr49rw7piMQ/Ttr0GG4oRf3duXrkhGgfAOgQH6GcwpB5AtOBitjY
   A==;
X-CSE-ConnectionGUID: nC/w1FWSSbWvusA+IpQ24A==
X-CSE-MsgGUID: b9JoLN7nR2Kxmbj3SLqxuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17390532"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="17390532"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 09:03:45 -0700
X-CSE-ConnectionGUID: yQJthOFoQWGPoURzIEQO+Q==
X-CSE-MsgGUID: mFpJMzK7Sf2t0YVMMwJOLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47175035"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Jul 2024 09:03:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQUMU-000V4Q-0o;
	Sun, 07 Jul 2024 16:03:38 +0000
Date: Mon, 8 Jul 2024 00:03:11 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
Message-ID: <202407072316.PqU8yj52-lkp@intel.com>
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
[also build test WARNING on next-20240703]
[cannot apply to linus/master v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240707-082513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240707002055.1835121-6-cristian.marussi%40arm.com
patch subject: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone driver
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240707/202407072316.PqU8yj52-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240707/202407072316.PqU8yj52-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407072316.PqU8yj52-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/scmi_transport_smc.c:157:58: warning: variable 'size' is uninitialized when used here [-Wuninitialized]
                   void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
                                                                          ^~~~
   drivers/firmware/arm_scmi/scmi_transport_smc.c:136:22: note: initialize the variable 'size' to silence this warning
           resource_size_t size;
                               ^
                                = 0
   1 warning generated.


vim +/size +157 drivers/firmware/arm_scmi/scmi_transport_smc.c

0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  129  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  130  static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  131  			  bool tx)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  132  {
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  133  	struct device *cdev = cinfo->dev;
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  134  	unsigned long cap_id = ULONG_MAX;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  135  	struct scmi_smc *scmi_info;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  136  	resource_size_t size;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  137  	struct resource res;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  138  	u32 func_id;
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  139  	int ret;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  140  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  141  	if (!tx)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  142  		return -ENODEV;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  143  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  144  	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  145  	if (!scmi_info)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  146  		return -ENOMEM;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  147  
728a057b6ab114 drivers/firmware/arm_scmi/scmi_transport_smc.c Cristian Marussi 2024-07-07  148  	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx);
6c5d3315c40fa0 drivers/firmware/arm_scmi/smc.c                Peng Fan         2024-07-07  149  	if (IS_ERR(scmi_info->shmem))
6c5d3315c40fa0 drivers/firmware/arm_scmi/smc.c                Peng Fan         2024-07-07  150  		return PTR_ERR(scmi_info->shmem);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  151  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  152  	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  153  	if (ret < 0)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  154  		return ret;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  155  
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  156  	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09 @157  		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  158  		/* The capability-id is kept in last 8 bytes of shmem.
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  159  		 *     +-------+ <-- 0
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  160  		 *     | shmem |
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  161  		 *     +-------+ <-- size - 8
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  162  		 *     | capId |
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  163  		 *     +-------+ <-- size
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  164  		 */
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  165  		memcpy_fromio(&cap_id, ptr, sizeof(cap_id));
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  166  	}
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  167  
5f2ea10a808aef drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-05-06  168  	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
5f2ea10a808aef drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-05-06  169  		scmi_info->param_page = SHMEM_PAGE(res.start);
5f2ea10a808aef drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-05-06  170  		scmi_info->param_offset = SHMEM_OFFSET(res.start);
5f2ea10a808aef drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-05-06  171  	}
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  172  	/*
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  173  	 * If there is an interrupt named "a2p", then the service and
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  174  	 * completion of a message is signaled by an interrupt rather than by
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  175  	 * the return of the SMC call.
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  176  	 */
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  177  	scmi_info->irq = of_irq_get_byname(cdev->of_node, "a2p");
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  178  	if (scmi_info->irq > 0) {
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  179  		ret = request_irq(scmi_info->irq, smc_msg_done_isr,
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  180  				  IRQF_NO_SUSPEND, dev_name(dev), scmi_info);
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  181  		if (ret) {
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  182  			dev_err(dev, "failed to setup SCMI smc irq\n");
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  183  			return ret;
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  184  		}
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  185  	} else {
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  186  		cinfo->no_completion_irq = true;
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  187  	}
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  188  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  189  	scmi_info->func_id = func_id;
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  190  	scmi_info->cap_id = cap_id;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  191  	scmi_info->cinfo = cinfo;
0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  192  	smc_channel_lock_init(scmi_info);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  193  	cinfo->transport_info = scmi_info;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  194  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  195  	return 0;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  196  }
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  197  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

