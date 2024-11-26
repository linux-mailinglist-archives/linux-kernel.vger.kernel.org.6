Return-Path: <linux-kernel+bounces-422475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D29D9A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E88B161F37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADE282F4;
	Tue, 26 Nov 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmfIlC6S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5F1AC44C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633346; cv=none; b=YAo27BRfVCC2IAORMyrTzFfb/Rzt4vzsptP4ZxnTMGByRqn3oWPqM0U7m2oQ0HY6eQ6c409+bHPSws6fwEaxIv2k5QyoeDSg7/qZ4f6eRHltuBGLgUnmy9QYmz8VQ9JQkZVZk5QwwmaVFa5SBRlwYEnfQvMcRg8SByLzCBuYXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633346; c=relaxed/simple;
	bh=ZaLjxDUqtOfh5cEdPJcETrCiLtKfDmIlpm1oI9p++C8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SKmdg6koe+X5S39lyhPhmkrIX3JkIcdiLlXPhbF9KRbq4RYHy5KlXBfzGwG8kEDyJvcJT29I8I7Y2yI8jzi9FfrnwWDxyVRpi4yJdIK6LYhsuWtcE8a8N9yyb5oQrltHsLjnb6yTy/+0oqUXrguRaYCMCwqT/trKhop0fHwbKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmfIlC6S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732633344; x=1764169344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZaLjxDUqtOfh5cEdPJcETrCiLtKfDmIlpm1oI9p++C8=;
  b=CmfIlC6So2ezHPu0GiSh/PnpbnRrqVhKapiN58pD44PZHESwGYvg7Zbe
   JFtEypNJU05Yvtn2taIAa+2AV1YLskTd9qZ8NbCIVwvx4V83oMwGNzrW8
   NN9tmR26nGqsqWuXBd2fLa4+Xl3yp/8J+VwW25Mkok60f6zMv3ai2L0+2
   xyjSTRFdVR/ttTrGT9OxtJCiyD1fFZUpW75YvcZILZDTpTciBpbWvp41Q
   yBbZjkeb5BrWanQoKG+v9HTzGuSDcnGS/4G12cn8v0olha+3KJB2bZCoo
   d5raqiHI2RA/EIeR/BBuvzflERS9Vnk4iAaW4d1Pyt5kOTrIuh1c+IoL3
   w==;
X-CSE-ConnectionGUID: YjNWEsj9QmS+WjuEyd5FwQ==
X-CSE-MsgGUID: xOtxJMgVTS2O7oxuZtkoZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="44182821"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="44182821"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:02:23 -0800
X-CSE-ConnectionGUID: nuR5Vg74QEmyMxacumX9og==
X-CSE-MsgGUID: CCR5whhZRnC61JscerTePw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91752553"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Nov 2024 07:02:22 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFx51-0007Lj-0T;
	Tue, 26 Nov 2024 15:02:19 +0000
Date: Tue, 26 Nov 2024 23:01:41 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: drivers/net/ethernet/intel/i40e/i40e_ddp.c:53:1: warning: the frame
 size of 1040 bytes is larger than 1024 bytes
Message-ID: <202411262240.7uamxDkb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
commit: cdc594e00370e153c323cf8aa9c43b66679e09a0 i40e: Implement DDP support in i40e driver
date:   6 years ago
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20241126/202411262240.7uamxDkb-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411262240.7uamxDkb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411262240.7uamxDkb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/net/tcp.h:23,
                    from drivers/net/ethernet/intel/i40e/i40e.h:7,
                    from drivers/net/ethernet/intel/i40e/i40e_ddp.c:4:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   arch/xtensa/include/asm/page.h:190:33: note: in expansion of macro 'pfn_valid'
     190 | #define virt_addr_valid(kaddr)  pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
         |                                 ^~~~~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/xtensa/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/skbuff.h:19,
                    from include/linux/tcp.h:21,
                    from include/net/tcp.h:24:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/asm-generic/bug.h:148:34: note: in definition of macro 'WARN_ON_ONCE'
     148 |         int __ret_warn_once = !!(condition);                    \
         |                                  ^~~~~~~~~
   include/linux/dma-mapping.h:359:26: note: in expansion of macro 'pfn_valid'
     359 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                          ^~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_ddp.c: In function 'i40e_ddp_does_profile_exist':
   drivers/net/ethernet/intel/i40e/i40e_ddp.c:49:70: warning: array subscript i is outside array bounds of 'struct i40e_profile_info[0]' [-Warray-bounds=]
      49 |                 if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
         |                                                  ~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/intel/i40e/i40e.h:338:34: note: while referencing 'p_info'
     338 |         struct i40e_profile_info p_info[0];
         |                                  ^~~~~~
   In function 'i40e_ddp_profiles_eq',
       inlined from 'i40e_ddp_does_profile_exist' at drivers/net/ethernet/intel/i40e/i40e_ddp.c:49:7:
   drivers/net/ethernet/intel/i40e/i40e_ddp.c:20:38: warning: array subscript i is outside array bounds of 'struct i40e_profile_info[0]' [-Warray-bounds=]
      20 |                 !memcmp(&a->version, &b->version, sizeof(a->version)) &&
         |                                      ^~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e.h: In function 'i40e_ddp_does_profile_exist':
   drivers/net/ethernet/intel/i40e/i40e.h:338:34: note: while referencing 'p_info'
     338 |         struct i40e_profile_info p_info[0];
         |                                  ^~~~~~
   In function 'i40e_ddp_profiles_eq',
       inlined from 'i40e_ddp_does_profile_exist' at drivers/net/ethernet/intel/i40e/i40e_ddp.c:49:7:
   drivers/net/ethernet/intel/i40e/i40e_ddp.c:21:35: warning: array subscript i is outside array bounds of 'struct i40e_profile_info[0]' [-Warray-bounds=]
      21 |                 !memcmp(&a->name, &b->name, I40E_DDP_NAME_SIZE);
         |                                   ^~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e.h: In function 'i40e_ddp_does_profile_exist':
   drivers/net/ethernet/intel/i40e/i40e.h:338:34: note: while referencing 'p_info'
     338 |         struct i40e_profile_info p_info[0];
         |                                  ^~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_ddp.c:53:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      53 | }
         | ^
   drivers/net/ethernet/intel/i40e/i40e_ddp.c: In function 'i40e_ddp_does_profile_overlap':
   drivers/net/ethernet/intel/i40e/i40e_ddp.c:104:21: warning: array subscript i is outside array bounds of 'struct i40e_profile_info[0]' [-Warray-bounds=]
     104 |                 if (i40e_ddp_profiles_overlap(pinfo,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     105 |                                               &profile_list->p_info[i]))
         |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e.h:338:34: note: while referencing 'p_info'
     338 |         struct i40e_profile_info p_info[0];
         |                                  ^~~~~~
   drivers/net/ethernet/intel/i40e/i40e_ddp.c:109:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     109 | }
         | ^


vim +53 drivers/net/ethernet/intel/i40e/i40e_ddp.c

    23	
    24	/**
    25	 * i40e_ddp_does_profile_exist - checks if DDP profile loaded already
    26	 * @hw: HW data structure
    27	 * @pinfo: DDP profile information structure
    28	 *
    29	 * checks if DDP profile loaded already.
    30	 * Returns >0 if the profile exists.
    31	 * Returns  0 if the profile is absent.
    32	 * Returns <0 if error.
    33	 **/
    34	static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
    35					       struct i40e_profile_info *pinfo)
    36	{
    37		struct i40e_ddp_profile_list *profile_list;
    38		u8 buff[I40E_PROFILE_LIST_SIZE];
    39		i40e_status status;
    40		int i;
    41	
    42		status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
    43					      NULL);
    44		if (status)
    45			return -1;
    46	
    47		profile_list = (struct i40e_ddp_profile_list *)buff;
    48		for (i = 0; i < profile_list->p_count; i++) {
    49			if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
    50				return 1;
    51		}
    52		return 0;
  > 53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

