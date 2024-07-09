Return-Path: <linux-kernel+bounces-245820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AA92B9DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2678528564C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFE158DB9;
	Tue,  9 Jul 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHWBSIOU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908615251B;
	Tue,  9 Jul 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529197; cv=none; b=GfuUflPlXjc1yPhab/FUf2qXuxGz4PoCCrziscUPj7nsf7CwR1SMa/MjlHABlxgQLef13FzRsCGYtmlbt3LU/u3XotCPVSvvw1zYJv4+0t5s5BJWsB+wiXLgoAPuu3J+OW0KFtIyTfc8dcY8Cmnna0Z5BNKLSKy+8JiR8x21OD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529197; c=relaxed/simple;
	bh=o6K/SWl3shws6k/7CBGNm6oZlTts/bpSZlEoGF320X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUkmrdw6y/slWZooOIY9+KEuKRrAbmbqJNBFwJLd53w7yeB4p0lpYa9JaeLoMxqeF43UGxuZ2bKIvET5aGv1ENqPpQ1B1dB8FK37cHT8YRAC3sCQWSghXXpMt4KahVdzbNeTqP1dAUgGRekxCMZIj70qoBJ/9hSYStPT7Jwl9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHWBSIOU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720529194; x=1752065194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o6K/SWl3shws6k/7CBGNm6oZlTts/bpSZlEoGF320X8=;
  b=kHWBSIOUf8bPF/tJp90elOTvmMios0Kx9qYjbJkMvBDXEStii7J3/sre
   tewYpfzRvWTBcwUdngC+sTVLI6KD121KCnpzhP16ELOWVzZp870p3+v9g
   qeRfg5iTHrRqPmOxa0C6gwgqUi2aAi3E7Ow2FMPAsUleAIHPfrsZrT3Xy
   xGVSMQNfKBcnCQz+Z/RjwQy49R//X02JHXPrEbWEja2zZxYexcj53QvAZ
   FkC8erCmBF5e2ZHcnY9EdkTvZ4ShhDw+fiSgSHMAVeHuVRzr4Y0xcBrnm
   k2dfv33xHIJ/TFsBE55lSXvL6dRi0Gt0yLFAXW+jHikjdtToh/HBOQhHP
   Q==;
X-CSE-ConnectionGUID: nKMGSGukSxCADD7LVlnZqg==
X-CSE-MsgGUID: nIBX3t6NSNORwEgHfCmM+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35316642"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35316642"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:46:33 -0700
X-CSE-ConnectionGUID: xsBGJRQDQUa7e3ZbU9bt7g==
X-CSE-MsgGUID: O5/fVxTEQP+Qz6DVPPTFsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52165198"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jul 2024 05:46:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRAEk-000WgL-2H;
	Tue, 09 Jul 2024 12:46:26 +0000
Date: Tue, 9 Jul 2024 20:45:26 +0800
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
Message-ID: <202407092025.wqTyq8Er-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on next-20240709]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240707-082513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240707002055.1835121-6-cristian.marussi%40arm.com
patch subject: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone driver
config: arm-randconfig-003-20240709 (https://download.01.org/0day-ci/archive/20240709/202407092025.wqTyq8Er-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240709/202407092025.wqTyq8Er-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407092025.wqTyq8Er-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/arm_scmi/scmi_transport_smc.c:157:58: warning: variable 'size' is uninitialized when used here [-Wuninitialized]
     157 |                 void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
         |                                                                        ^~~~
   drivers/firmware/arm_scmi/scmi_transport_smc.c:136:22: note: initialize the variable 'size' to silence this warning
     136 |         resource_size_t size;
         |                             ^
         |                              = 0
>> drivers/firmware/arm_scmi/scmi_transport_smc.c:235:3: error: write to reserved register 'R7'
     235 |                 arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
         |                 ^
   include/linux/arm-smccc.h:570:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     570 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^
   include/linux/arm-smccc.h:513:48: note: expanded from macro 'arm_smccc_1_1_smc'
     513 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                                 ^
   include/linux/arm-smccc.h:400:24: note: expanded from macro 'SMCCC_SMC_INST'
     400 | #define SMCCC_SMC_INST  __SMC(0)
         |                         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm/include/asm/opcodes.h:215:2: note: expanded from macro '__inst_arm_thumb32'
     215 |         __inst_thumb32(thumb_opcode)
         |         ^
   arch/arm/include/asm/opcodes.h:205:27: note: expanded from macro '__inst_thumb32'
     205 | #define __inst_thumb32(x) ___inst_thumb32(                              \
         |                           ^
   arch/arm/include/asm/opcodes.h:230:2: note: expanded from macro '___inst_thumb32'
     230 |         ".short " __stringify(first) ", " __stringify(second) "\n\t"
         |         ^
>> drivers/firmware/arm_scmi/scmi_transport_smc.c:235:3: error: write to reserved register 'R7'
   include/linux/arm-smccc.h:567:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     567 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^
   include/linux/arm-smccc.h:529:48: note: expanded from macro 'arm_smccc_1_1_hvc'
     529 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                                 ^
   include/linux/arm-smccc.h:401:24: note: expanded from macro 'SMCCC_HVC_INST'
     401 | #define SMCCC_HVC_INST  __HVC(0)
         |                         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm/include/asm/opcodes.h:215:2: note: expanded from macro '__inst_arm_thumb32'
     215 |         __inst_thumb32(thumb_opcode)
         |         ^
   arch/arm/include/asm/opcodes.h:205:27: note: expanded from macro '__inst_thumb32'
     205 | #define __inst_thumb32(x) ___inst_thumb32(                              \
         |                           ^
   arch/arm/include/asm/opcodes.h:230:2: note: expanded from macro '___inst_thumb32'
     230 |         ".short " __stringify(first) ", " __stringify(second) "\n\t"
         |         ^
>> drivers/firmware/arm_scmi/scmi_transport_smc.c:235:3: error: write to reserved register 'R7'
   include/linux/arm-smccc.h:573:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     573 |                         __fail_smccc_1_1(__VA_ARGS__);                  \
         |                         ^
   include/linux/arm-smccc.h:540:8: note: expanded from macro '__fail_smccc_1_1'
     540 |                 asm ("" :                                               \
         |                      ^
   drivers/firmware/arm_scmi/scmi_transport_smc.c:238:3: error: write to reserved register 'R7'
     238 |                 arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
         |                 ^
   include/linux/arm-smccc.h:570:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     570 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^
   include/linux/arm-smccc.h:513:48: note: expanded from macro 'arm_smccc_1_1_smc'
     513 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                                 ^
   include/linux/arm-smccc.h:400:24: note: expanded from macro 'SMCCC_SMC_INST'
     400 | #define SMCCC_SMC_INST  __SMC(0)
         |                         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm/include/asm/opcodes.h:215:2: note: expanded from macro '__inst_arm_thumb32'
     215 |         __inst_thumb32(thumb_opcode)
         |         ^
   arch/arm/include/asm/opcodes.h:205:27: note: expanded from macro '__inst_thumb32'
     205 | #define __inst_thumb32(x) ___inst_thumb32(                              \
         |                           ^
   arch/arm/include/asm/opcodes.h:230:2: note: expanded from macro '___inst_thumb32'
     230 |         ".short " __stringify(first) ", " __stringify(second) "\n\t"
         |         ^
   drivers/firmware/arm_scmi/scmi_transport_smc.c:238:3: error: write to reserved register 'R7'
   include/linux/arm-smccc.h:567:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     567 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^
   include/linux/arm-smccc.h:529:48: note: expanded from macro 'arm_smccc_1_1_hvc'
     529 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                                 ^
   include/linux/arm-smccc.h:401:24: note: expanded from macro 'SMCCC_HVC_INST'
     401 | #define SMCCC_HVC_INST  __HVC(0)
         |                         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm/include/asm/opcodes.h:215:2: note: expanded from macro '__inst_arm_thumb32'
     215 |         __inst_thumb32(thumb_opcode)
         |         ^
   arch/arm/include/asm/opcodes.h:205:27: note: expanded from macro '__inst_thumb32'
     205 | #define __inst_thumb32(x) ___inst_thumb32(                              \
         |                           ^
   arch/arm/include/asm/opcodes.h:230:2: note: expanded from macro '___inst_thumb32'
     230 |         ".short " __stringify(first) ", " __stringify(second) "\n\t"
         |         ^
   drivers/firmware/arm_scmi/scmi_transport_smc.c:238:3: error: write to reserved register 'R7'
   include/linux/arm-smccc.h:573:4: note: expanded from macro 'arm_smccc_1_1_invoke'
     573 |                         __fail_smccc_1_1(__VA_ARGS__);                  \
         |                         ^
   include/linux/arm-smccc.h:540:8: note: expanded from macro '__fail_smccc_1_1'
     540 |                 asm ("" :                                               \
         |                      ^
   1 warning and 6 errors generated.


vim +/R7 +235 drivers/firmware/arm_scmi/scmi_transport_smc.c

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
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  198  static int smc_chan_free(int id, void *p, void *data)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  199  {
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  200  	struct scmi_chan_info *cinfo = p;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  201  	struct scmi_smc *scmi_info = cinfo->transport_info;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  202  
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  203  	/*
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  204  	 * Different protocols might share the same chan info, so a previous
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  205  	 * smc_chan_free call might have already freed the structure.
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  206  	 */
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  207  	if (!scmi_info)
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  208  		return 0;
f1d71576d2c9ec drivers/firmware/arm_scmi/smc.c                Andre Przywara   2024-01-26  209  
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  210  	/* Ignore any possible further reception on the IRQ path */
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  211  	if (scmi_info->irq > 0)
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  212  		free_irq(scmi_info->irq, scmi_info);
d1ff11d7ad8704 drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2023-07-19  213  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  214  	cinfo->transport_info = NULL;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  215  	scmi_info->cinfo = NULL;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  216  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  217  	return 0;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  218  }
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  219  
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  220  static int smc_send_message(struct scmi_chan_info *cinfo,
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  221  			    struct scmi_xfer *xfer)
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  222  {
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  223  	struct scmi_smc *scmi_info = cinfo->transport_info;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  224  	struct arm_smccc_res res;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  225  
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  226  	/*
0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  227  	 * Channel will be released only once response has been
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  228  	 * surely fully retrieved, so after .mark_txdone()
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  229  	 */
0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  230  	smc_channel_lock_acquire(scmi_info, xfer);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  231  
728a057b6ab114 drivers/firmware/arm_scmi/scmi_transport_smc.c Cristian Marussi 2024-07-07  232  	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  233  
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  234  	if (scmi_info->cap_id != ULONG_MAX)
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09 @235  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  236  				     0, 0, 0, 0, 0, &res);
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  237  	else
1f17395124a53a drivers/firmware/arm_scmi/smc.c                Sudeep Holla     2023-10-09  238  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  239  				     scmi_info->param_offset, 0, 0, 0, 0, 0,
da405477e76707 drivers/firmware/arm_scmi/smc.c                Nikunj Kela      2023-10-09  240  				     &res);
dd820ee21d5e07 drivers/firmware/arm_scmi/smc.c                Jim Quinlan      2020-12-22  241  
f7199cf489027a drivers/firmware/arm_scmi/smc.c                Sudeep Holla     2020-04-17  242  	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  243  	if (res.a0) {
0bfdca8a8661aa drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  244  		smc_channel_lock_release(scmi_info);
f7199cf489027a drivers/firmware/arm_scmi/smc.c                Sudeep Holla     2020-04-17  245  		return -EOPNOTSUPP;
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  246  	}
f716cbd33f038a drivers/firmware/arm_scmi/smc.c                Cristian Marussi 2021-12-20  247  
f7199cf489027a drivers/firmware/arm_scmi/smc.c                Sudeep Holla     2020-04-17  248  	return 0;
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  249  }
1dc6558062dadf drivers/firmware/arm_scmi/smc.c                Peng Fan         2020-03-08  250  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

