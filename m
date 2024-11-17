Return-Path: <linux-kernel+bounces-411963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8C9D01C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226C1284744
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB1A92D;
	Sun, 17 Nov 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/0l3Z5i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122C33E7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731805051; cv=none; b=OfumRkgqkDVyASkpzdbWTk0VfjDtCPmU6XmLpJi9jRdpD9P8ZZRcU9CojrMidtEzhsdZUiqgxL9sWSXNuxCK1Z2juYnToOcqzQDwyoOHZEDyicGLzqA7laeb2ieiz94P6Bj1ePreXmFv7Qm40uNRIVjdI34cJotiuLM2AmaMLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731805051; c=relaxed/simple;
	bh=5wrsNBo8Hnbij2o1ETYHg7Xe+kl2cGv/S/QTsTULEcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZcBSjOzQxDdJ+zL6C3kQmTI7CU5mIT+p8M1x8QT6cK8xGIUqH9OAEj7H0wJ/6WfYqrQjIR39EsIp/IXrIFmuUXVf6Z/d2X3S5bMwsGqWHspTITNpV6VTlu+Cu/IjssCKUI9DUDKov75XMcKoOdCzXjyZXNTVAmLV6yqsgDNAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/0l3Z5i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731805049; x=1763341049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5wrsNBo8Hnbij2o1ETYHg7Xe+kl2cGv/S/QTsTULEcw=;
  b=k/0l3Z5i3pZP6FK3VIJgdAY2/ktdmY8WF83CnceT7SqvM+FSJo2bNl9d
   gip3T49A4rs6KW7WjqvyOW1Y65D7/GRzQnNmEKuj7xrrIFNgW4hU8MXkj
   /Rdx2/qVvo0KE4hP3hie9Qr0nYHK8PcIKogm2vik5WiuCDtXDZSnlX+89
   WXgCRUz9iAIHQaifbga80MtvoyGKl/ZENvS9SRANv1OoH0qGORcdonShP
   AfWbtbPQMEDa16Tsk7iCXTX967OGlmnRKMI1Z9nR/Yv75pHL7lQYVkUxK
   9/FeZEsgo0uxq0F4ykR4zRPumE800RwiBJl0GfyFnTauLlwQhMw0+F0z5
   A==;
X-CSE-ConnectionGUID: NHvLfdTvRWK1tAEPllBwUw==
X-CSE-MsgGUID: HhWxvZ/qQOidCn11FxnlhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="35554502"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="35554502"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 16:57:29 -0800
X-CSE-ConnectionGUID: oONgtneyR4SfW7tr4TIMmA==
X-CSE-MsgGUID: ehnUVlDnSlWqcJdGSl/ksA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="119736636"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2024 16:57:26 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTbP-0001CX-2I;
	Sun, 17 Nov 2024 00:57:23 +0000
Date: Sun, 17 Nov 2024 08:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Benoit <paul@os.amperecomputing.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <202411171059.1mPeDZMS-lkp@intel.com>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114030452.10149-1-paul@os.amperecomputing.com>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Benoit/firmware-smccc-Support-optional-Arm-SMC-SOC_ID-name/20241114-113039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241114030452.10149-1-paul%40os.amperecomputing.com
patch subject: [PATCH] firmware: smccc: Support optional Arm SMC SOC_ID name
config: arm-randconfig-003-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171059.1mPeDZMS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171059.1mPeDZMS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171059.1mPeDZMS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/firmware/smccc/smccc.c: In function 'arm_smccc_version_init':
>> drivers/firmware/smccc/smccc.c:26:35: error: storage size of 'regs_1_2' isn't known
      26 |         struct arm_smccc_1_2_regs regs_1_2;
         |                                   ^~~~~~~~
>> drivers/firmware/smccc/smccc.c:50:25: error: implicit declaration of function 'arm_smccc_1_2_smc'; did you mean 'arm_smccc_1_1_smc'? [-Wimplicit-function-declaration]
      50 |                         arm_smccc_1_2_smc(
         |                         ^~~~~~~~~~~~~~~~~
         |                         arm_smccc_1_1_smc
>> drivers/firmware/smccc/smccc.c:26:35: warning: unused variable 'regs_1_2' [-Wunused-variable]
      26 |         struct arm_smccc_1_2_regs regs_1_2;
         |                                   ^~~~~~~~


vim +26 drivers/firmware/smccc/smccc.c

    22	
    23	void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
    24	{
    25		struct arm_smccc_res res;
  > 26		struct arm_smccc_1_2_regs regs_1_2;
    27	
    28		smccc_version = version;
    29		smccc_conduit = conduit;
    30	
    31		smccc_trng_available = smccc_probe_trng();
    32	
    33		if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
    34		    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
    35			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
    36					     ARM_SMCCC_ARCH_SOC_ID, &res);
    37			if ((s32)res.a0 >= 0) {
    38				arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
    39				smccc_soc_id_version = (s32)res.a0;
    40				arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
    41				smccc_soc_id_revision = (s32)res.a0;
    42	
    43				/* Issue Number 1.6 of the Arm SMC Calling Convention
    44				 * specification introduces an optional "name" string
    45				 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
    46				 * available.
    47				 */
    48				regs_1_2.a0 = ARM_SMCCC_ARCH_SOC_ID;
    49				regs_1_2.a1 = 2;	/* SOC_ID name */
  > 50				arm_smccc_1_2_smc(
    51					(const struct arm_smccc_1_2_regs *)&regs_1_2,
    52					(struct arm_smccc_1_2_regs *)&regs_1_2);
    53	
    54				if ((u32)regs_1_2.a0 == 0) {
    55					unsigned long *destination =
    56						(unsigned long *)smccc_soc_id_name;
    57	
    58					/*
    59					 * Copy regs_1_2.a1..regs_1_2.a17 to the
    60					 * smccc_soc_id_name string with consideration
    61					 * to the endianness of the values in a1..a17.
    62					 * As per Issue 1.6 of the Arm SMC Calling
    63					 * Convention, the string will be NUL terminated
    64					 * and padded, from the end of the string to
    65					 * the end of the 136 byte buffer, with NULs.
    66					 */
    67					*destination++ =
    68					    cpu_to_le64p((const __u64 *)&regs_1_2.a1);
    69					*destination++ =
    70					    cpu_to_le64p((const __u64 *)&regs_1_2.a2);
    71					*destination++ =
    72					    cpu_to_le64p((const __u64 *)&regs_1_2.a3);
    73					*destination++ =
    74					    cpu_to_le64p((const __u64 *)&regs_1_2.a4);
    75					*destination++ =
    76					    cpu_to_le64p((const __u64 *)&regs_1_2.a5);
    77					*destination++ =
    78					    cpu_to_le64p((const __u64 *)&regs_1_2.a6);
    79					*destination++ =
    80					    cpu_to_le64p((const __u64 *)&regs_1_2.a7);
    81					*destination++ =
    82					    cpu_to_le64p((const __u64 *)&regs_1_2.a8);
    83					*destination++ =
    84					    cpu_to_le64p((const __u64 *)&regs_1_2.a9);
    85					*destination++ =
    86					    cpu_to_le64p((const __u64 *)&regs_1_2.a10);
    87					*destination++ =
    88					    cpu_to_le64p((const __u64 *)&regs_1_2.a11);
    89					*destination++ =
    90					    cpu_to_le64p((const __u64 *)&regs_1_2.a12);
    91					*destination++ =
    92					    cpu_to_le64p((const __u64 *)&regs_1_2.a13);
    93					*destination++ =
    94					    cpu_to_le64p((const __u64 *)&regs_1_2.a14);
    95					*destination++ =
    96					    cpu_to_le64p((const __u64 *)&regs_1_2.a15);
    97					*destination++ =
    98					    cpu_to_le64p((const __u64 *)&regs_1_2.a16);
    99					*destination++ =
   100					    cpu_to_le64p((const __u64 *)&regs_1_2.a17);
   101				}
   102			}
   103		}
   104	}
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

