Return-Path: <linux-kernel+bounces-431165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB09E39D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8551B28602D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B791B87EB;
	Wed,  4 Dec 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBRDL8BD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D81B6CFF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315226; cv=none; b=goZneRUF9d07jLeXkfvWFnT2t8PJ6IlHrh8hswDxiyzJzgDFSXZGLF12QEnyctGTTSQShLoeFIFvQJ/aUXRQfm0cnB2aS7zFv9FOq5DlFBgIT0/AZxF1xRbK6pB/7p5qDJsGMdPW1laaU9txxsy2WBEPWYaBlEzLDQ05g7GA9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315226; c=relaxed/simple;
	bh=9U+1S5c6QBIEs2jEVkouqNjE862gZHRZMYIqjSXUYvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYYnqXDI4Y66Nb1G71gb3imgLeV+Q99YiFDbYBPrV4l2K1/0lpv3wfhCsVmS6Jn1ajcsSKCzJmeriY4J+vPBmXjlY9OdsTUu+G4q9Ni9R3ra1NEoZaNssB/HNI4TkUuKF4t1l9uXERVMVzLk20G0OeofKmvE3l6BMRSxMR+8NvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBRDL8BD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315225; x=1764851225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9U+1S5c6QBIEs2jEVkouqNjE862gZHRZMYIqjSXUYvA=;
  b=gBRDL8BDmDFiH+VRu5myTEmopyd6gf6ehlKoe0mX+uK8RROFlyLjKXMH
   K56xt3ocNlT/KY3h4gVnDwLn5iILNnMeFO/v5hPbdq33O2JQ9sWBQix2k
   4nAMO498H9fdshCAVAgWbhfufYzH36mM6SpwTx6FueQoBkYJ2gYiHna/2
   hnHJYbUXuJg5ovQyV9eLAXlG8TnXxYEDqSbwoNKYysHxy5yUZvhIMDor2
   Q88gkwEiU2CiPsxwTCTiUA828o781SH/PKZagAKGv71RVtEfei97gcnph
   UHW985u9ReK/ErZr0SMzsEDEdMk1uN/rn6pP5EWwRyGq8CniormoxAj9r
   g==;
X-CSE-ConnectionGUID: MIK3e7IWTpS4ssvIQQdrWw==
X-CSE-MsgGUID: NxAb3eSzQSCIkQUwi/5TsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44954199"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44954199"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:27:03 -0800
X-CSE-ConnectionGUID: BQCuPqjHREGCWw4bnGZW4g==
X-CSE-MsgGUID: mll3T9a/QYe7tkeqDGCKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93614814"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 04:27:00 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIoT3-00030p-35;
	Wed, 04 Dec 2024 12:26:57 +0000
Date: Wed, 4 Dec 2024 20:26:35 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Benoit <paul@os.amperecomputing.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <202412042020.U9EEV8mE-lkp@intel.com>
References: <20241203212854.5565-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203212854.5565-1-paul@os.amperecomputing.com>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Benoit/firmware-smccc-Support-optional-Arm-SMC-SOC_ID-name/20241204-124243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241203212854.5565-1-paul%40os.amperecomputing.com
patch subject: [PATCH v2] firmware: smccc: Support optional Arm SMC SOC_ID name
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20241204/202412042020.U9EEV8mE-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412042020.U9EEV8mE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042020.U9EEV8mE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/smccc/soc_id.c:109:16: warning: shift count >= width of type [-Wshift-count-overflow]
     109 |         dst[4] = (reg >> 32) & 0xff;
         |                       ^  ~~
   drivers/firmware/smccc/soc_id.c:110:16: warning: shift count >= width of type [-Wshift-count-overflow]
     110 |         dst[5] = (reg >> 40) & 0xff;
         |                       ^  ~~
   drivers/firmware/smccc/soc_id.c:111:16: warning: shift count >= width of type [-Wshift-count-overflow]
     111 |         dst[6] = (reg >> 48) & 0xff;
         |                       ^  ~~
   drivers/firmware/smccc/soc_id.c:112:16: warning: shift count >= width of type [-Wshift-count-overflow]
     112 |         dst[7] = (reg >> 56) & 0xff;
         |                       ^  ~~
>> drivers/firmware/smccc/soc_id.c:37:29: warning: unused variable 'smccc_soc_id_name' [-Wunused-variable]
      37 | static char __ro_after_init smccc_soc_id_name[136] = "";
         |                             ^~~~~~~~~~~~~~~~~
   drivers/firmware/smccc/soc_id.c:103:20: warning: unused function 'str_fragment_from_reg' [-Wunused-function]
     103 | static inline void str_fragment_from_reg(char *dst, unsigned long reg)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   6 warnings generated.


vim +109 drivers/firmware/smccc/soc_id.c

    36	
  > 37	static char __ro_after_init smccc_soc_id_name[136] = "";
    38	
    39	static int __init smccc_soc_init(void)
    40	{
    41		int soc_id_rev, soc_id_version;
    42		static char soc_id_str[20], soc_id_rev_str[12];
    43		static char soc_id_jep106_id_str[12];
    44	
    45		if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
    46			return 0;
    47	
    48		soc_id_version = arm_smccc_get_soc_id_version();
    49		if (soc_id_version == SMCCC_RET_NOT_SUPPORTED) {
    50			pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
    51			return 0;
    52		}
    53	
    54		if (soc_id_version < 0) {
    55			pr_err("Invalid SoC Version: %x\n", soc_id_version);
    56			return -EINVAL;
    57		}
    58	
    59		soc_id_rev = arm_smccc_get_soc_id_revision();
    60		if (soc_id_rev < 0) {
    61			pr_err("Invalid SoC Revision: %x\n", soc_id_rev);
    62			return -EINVAL;
    63		}
    64	
    65		soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
    66		if (!soc_dev_attr)
    67			return -ENOMEM;
    68	
    69		sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
    70		sprintf(soc_id_jep106_id_str, "jep106:%02x%02x",
    71			JEP106_BANK_CONT_CODE(soc_id_version),
    72			JEP106_ID_CODE(soc_id_version));
    73		sprintf(soc_id_str, "%s:%04x", soc_id_jep106_id_str,
    74			IMP_DEF_SOC_ID(soc_id_version));
    75	
    76		soc_dev_attr->soc_id = soc_id_str;
    77		soc_dev_attr->revision = soc_id_rev_str;
    78		soc_dev_attr->family = soc_id_jep106_id_str;
    79		soc_dev_attr->machine = smccc_soc_name_init();
    80	
    81		soc_dev = soc_device_register(soc_dev_attr);
    82		if (IS_ERR(soc_dev)) {
    83			kfree(soc_dev_attr);
    84			return PTR_ERR(soc_dev);
    85		}
    86	
    87		pr_info("ID = %s Revision = %s\n", soc_dev_attr->soc_id,
    88			soc_dev_attr->revision);
    89	
    90		return 0;
    91	}
    92	module_init(smccc_soc_init);
    93	
    94	static void __exit smccc_soc_exit(void)
    95	{
    96		if (soc_dev)
    97			soc_device_unregister(soc_dev);
    98		kfree(soc_dev_attr);
    99	}
   100	module_exit(smccc_soc_exit);
   101	
   102	
   103	static inline void str_fragment_from_reg(char *dst, unsigned long reg)
   104	{
   105		dst[0] = (reg >> 0)  & 0xff;
   106		dst[1] = (reg >> 8)  & 0xff;
   107		dst[2] = (reg >> 16) & 0xff;
   108		dst[3] = (reg >> 24) & 0xff;
 > 109		dst[4] = (reg >> 32) & 0xff;
 > 110		dst[5] = (reg >> 40) & 0xff;
   111		dst[6] = (reg >> 48) & 0xff;
   112		dst[7] = (reg >> 56) & 0xff;
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

