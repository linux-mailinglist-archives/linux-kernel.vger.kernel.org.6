Return-Path: <linux-kernel+bounces-367110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9F99FEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EA61F26117
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950E14D2B1;
	Wed, 16 Oct 2024 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcz53zZk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798013C807;
	Wed, 16 Oct 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044825; cv=none; b=EvpRzYiN4Q1pcwI0P660GjuEuRnYC/6zkVGYfwcFmwowrjyLSgiRp5Y3kTnaP35AFoiYBvBKFzUji3w83b2lhxWPtHSNgJa3P6LxkkO9Sh2iIOjWvJazuG9V+FWOv7dt3s9S0y2mFWQx1GYPUT1JI6iGX0x37bkCqYSsui5nP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044825; c=relaxed/simple;
	bh=pLHR8sgV1YYQCR3HgSpvj06ZJH7LDxDS5GNtuTzF37I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUM1NSlH1sSbPw0h8s0KtATOXNTcWiPhBqq+xXdtssD/QVA0z+/3tfCGX5M4xElDj4jd3SkMpBNU0CSsnCRcN08+MYuIsnkNRS4tQyJnAw+LiYH4GUAIcck5TMEt+QBZPzC/k4aHnjhogvi5Kzl6Fno/pdYh7GmB3T4lKl6AHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcz53zZk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729044824; x=1760580824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pLHR8sgV1YYQCR3HgSpvj06ZJH7LDxDS5GNtuTzF37I=;
  b=mcz53zZki+5X9TMsUxfQxBDE3QkKftISG0uiBzdhz/pM9bdo/NZ4ZF/H
   k/L1K8JhETSICTU44EYfe+pbuVsfjk58DnXRhn45STz3vjn5OFhoRnu8+
   ANI6OkyUCy+tFI8S7euyesTeOEHO7d+5XmsTdUfQFPbjCH8KQjyPVHvzq
   RDESaP08yAcFEWll4VmwgHwMXuVubIqIxV4asJj+6CO5CuV+aK9az+Dbe
   iDoIikoGr9BOYXgygAz35W6/vhERjqyAIR4BC2SclKCHHAkYl/bx1VUbT
   8noCjpPY+hVRS2eVgws/DYzCChjW0uBXgUrxWwtEKrq+4d7gHuNW9AODB
   A==;
X-CSE-ConnectionGUID: f+LlYrrdQQa5DwGDHWohvQ==
X-CSE-MsgGUID: ZPW1/Mw6R82xiSHGs/DPTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45950691"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45950691"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:13:44 -0700
X-CSE-ConnectionGUID: dKtKS4fOSgCcrnwxRcQPLg==
X-CSE-MsgGUID: SBDcVXBHRh6IYvtfdIXW2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77702802"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Oct 2024 19:11:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0tV9-000KAF-2e;
	Wed, 16 Oct 2024 02:11:03 +0000
Date: Wed, 16 Oct 2024 10:10:28 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Li <yang.li85200@gmail.com>, guoren@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yang Li <yang.li85200@gmail.com>
Subject: Re: [PATCH] csky: fix csky_cmpxchg_fixup not working
Message-ID: <202410160952.7oClZ4pG-lkp@intel.com>
References: <20241008054615.43062-1-yang.li85200@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008054615.43062-1-yang.li85200@gmail.com>

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li/csky-fix-csky_cmpxchg_fixup-not-working/20241008-134806
base:   linus/master
patch link:    https://lore.kernel.org/r/20241008054615.43062-1-yang.li85200%40gmail.com
patch subject: [PATCH] csky: fix csky_cmpxchg_fixup not working
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20241016/202410160952.7oClZ4pG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410160952.7oClZ4pG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160952.7oClZ4pG-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/csky/mm/fault.c: In function 'csky_cmpxchg_fixup':
>> arch/csky/mm/fault.c:48:39: warning: comparison between pointer and integer
      48 |         if (instruction_pointer(regs) == &csky_cmpxchg_stw)
         |                                       ^~
>> arch/csky/mm/fault.c:49:47: error: passing argument 2 of 'instruction_pointer_set' makes integer from pointer without a cast [-Wint-conversion]
      49 |                 instruction_pointer_set(regs, &csky_cmpxchg_ldw);
         |                                               ^~~~~~~~~~~~~~~~~
         |                                               |
         |                                               long unsigned int *
   In file included from arch/csky/include/asm/processor.h:8,
                    from arch/csky/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:6,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21,
                    from arch/csky/mm/fault.c:5:
   arch/csky/include/asm/ptrace.h:29:58: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
      29 |                                            unsigned long val)
         |                                            ~~~~~~~~~~~~~~^~~


vim +/instruction_pointer_set +49 arch/csky/mm/fault.c

    34	
    35	#ifdef CONFIG_CPU_HAS_LDSTEX
    36	static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
    37	{
    38		return;
    39	}
    40	#else
    41	extern unsigned long csky_cmpxchg_ldw;
    42	extern unsigned long csky_cmpxchg_stw;
    43	static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
    44	{
    45		if (trap_no(regs) != VEC_TLBMODIFIED)
    46			return;
    47	
  > 48		if (instruction_pointer(regs) == &csky_cmpxchg_stw)
  > 49			instruction_pointer_set(regs, &csky_cmpxchg_ldw);
    50		return;
    51	}
    52	#endif
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

