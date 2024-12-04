Return-Path: <linux-kernel+bounces-431078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD29E3949
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D9DB30428
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D011F1AF0BE;
	Wed,  4 Dec 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEvGvegX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD221AF0D5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311387; cv=none; b=qU+4i2uNF6eSgFnJtiZNo1vYmFQSB01d47anM1TX+LvCINZGRruOF5kiDS6WZFTa1Q8PxWnYnom5O8/H2dhGL9oLo/MBf7aSOMvZvogUo7jwmusuZLboypqR5Jr9GLUTcXVONAIBEbx4ET29TUlxNMvhVRbAPibh9LUSwo5M3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311387; c=relaxed/simple;
	bh=Lm5PIHzRjou6UpwctHmF45CdibJIcEp58ZTJhFUoYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9hqQj2V7lwRI+vxqNWZnc1MBq0+GEaegVa7hYRc91yTclbvca1JHWZgxTQkuO8CnBdRDMYeXiT+F5oBhz4KawY7zpbuNf8Ha3D+tJFWQuOvde1UhFbTzCQwZh2FdobtrI/rjMjBHpkx9I0DQv4Jf04c+T5otsMQ8FHMCOsYXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEvGvegX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733311385; x=1764847385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lm5PIHzRjou6UpwctHmF45CdibJIcEp58ZTJhFUoYJ8=;
  b=QEvGvegXVnooDzYtxWREHaFOPQh4aIWMTwaJam/5SAgiGGSSWUugU29t
   DYLSP/O2bqMc7ywpSGDM/vN8gZpQcfoB7gz/5qWjcnv+i/+zjoUTKrhev
   omt5KVq4Sd5duDwWeGIh3HwIfKPoKnBl/j1Tc02My0mWexmf00nI5rsKc
   0vv1MFQfPGcaNr0a6xO49D+F9j2j24ORkkq6Qk0NlF4RiTLlgetwZtOdC
   PcPu0YJYLRRBvBND6LlMqpeWyNauZ/LzTvkxrURZy97AeQBd4+4JWwEdb
   g1h2eblKKkVcW5RU1HaTl6cPoXE6chqRwIi3AEjr43b2sIolY5fIKS19/
   Q==;
X-CSE-ConnectionGUID: LsiCxHTXRdGUOd3IGd0VBg==
X-CSE-MsgGUID: nFRz0EAwR3S/v9jartJgtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="51104508"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="51104508"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:23:05 -0800
X-CSE-ConnectionGUID: hNc4TBZaQeKSTPMtboscnw==
X-CSE-MsgGUID: UJSjbqqeSUeL+IVFxnc6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98726046"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Dec 2024 03:23:03 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInTA-0002wT-1c;
	Wed, 04 Dec 2024 11:23:00 +0000
Date: Wed, 4 Dec 2024 19:22:40 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Benoit <paul@os.amperecomputing.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <202412041926.d2p2hcQe-lkp@intel.com>
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
config: arm-sp7021_defconfig (https://download.01.org/0day-ci/archive/20241204/202412041926.d2p2hcQe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041926.d2p2hcQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041926.d2p2hcQe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/smccc/soc_id.c: In function 'str_fragment_from_reg':
>> drivers/firmware/smccc/soc_id.c:109:23: warning: right shift count >= width of type [-Wshift-count-overflow]
     109 |         dst[4] = (reg >> 32) & 0xff;
         |                       ^~
   drivers/firmware/smccc/soc_id.c:110:23: warning: right shift count >= width of type [-Wshift-count-overflow]
     110 |         dst[5] = (reg >> 40) & 0xff;
         |                       ^~
   drivers/firmware/smccc/soc_id.c:111:23: warning: right shift count >= width of type [-Wshift-count-overflow]
     111 |         dst[6] = (reg >> 48) & 0xff;
         |                       ^~
   drivers/firmware/smccc/soc_id.c:112:23: warning: right shift count >= width of type [-Wshift-count-overflow]
     112 |         dst[7] = (reg >> 56) & 0xff;
         |                       ^~
   drivers/firmware/smccc/soc_id.c: At top level:
>> drivers/firmware/smccc/soc_id.c:37:29: warning: 'smccc_soc_id_name' defined but not used [-Wunused-variable]
      37 | static char __ro_after_init smccc_soc_id_name[136] = "";
         |                             ^~~~~~~~~~~~~~~~~


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
   110		dst[5] = (reg >> 40) & 0xff;
   111		dst[6] = (reg >> 48) & 0xff;
   112		dst[7] = (reg >> 56) & 0xff;
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

