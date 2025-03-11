Return-Path: <linux-kernel+bounces-556766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C689A5CE39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D317CFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CF2641C4;
	Tue, 11 Mar 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsLluakn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13658263F4B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719096; cv=none; b=KJ03EVQ281DwQTr9ZMgC9Om7bTVI/2rJHWlrQ7Rz4wBkSasBxrIZEmvfGboV/TCWoZK76uL27JWL899U+pcParMC3VneOpyapn9h0vaNYhjcvCGiBbPWXqwC/lLi/J4Nd+kKkRWoqy5P2vVl58ThmiWUzXvwTwNHizCJF6j1RaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719096; c=relaxed/simple;
	bh=NI4qwEEZcWJHjaM6xFotypi1tSQ1Ni3vCG+I6ADYZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USQ0KqjCyBO/gwDPkEwar61hmRa6YsXSfpIylRn2rFqOSgtt6u1wM8yfxhxukYPEpn8b0GrRbPnuwhyJ3W8NNmMZb1sWU7vxBG4d7OOHFSCVthl/CblX79dpDuaM1/yfQot9fsYhEEYWkrvYfMv9I15ldggSpRnS1Y99Z6xY6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsLluakn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741719095; x=1773255095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NI4qwEEZcWJHjaM6xFotypi1tSQ1Ni3vCG+I6ADYZe8=;
  b=FsLluaknPq28TpdZfB4SkVFyBzWhm4zTCpiJr2b3MGJhR2qsdqKlTsNa
   LbUes2SH7zYzsvZrPWyvOSRqbG2+40BeXAwii2KkS2cOPUBDsCu8khyIv
   T5PXr6U0BY6k+iF3bKXsstCeXHtiHaDRQh8PRasi6DX6Ow6GtkA8nwuRQ
   Ql5qhX1nne8DUOp0vm6aa8sS7q1wh9l14Qg9M2t6e1SQmSolbn9K5SCbg
   vKMkmj8lQnEj8MHisa07SK2vKC4oOZCzRjPGm2m1Bsm7/I/4AUy9ToevX
   8VqU+pjlkx+qa485U7kpOV0s0mBmkedmTt0uQ5F4MLMJbjqMQclkkUxpY
   A==;
X-CSE-ConnectionGUID: 2BcMASxuQfawjOCHS5hJeg==
X-CSE-MsgGUID: JALi5iRBTYCaOhlUC/QUMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42494798"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42494798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 11:51:34 -0700
X-CSE-ConnectionGUID: YPgFu7zGRt2nsZj4c92USQ==
X-CSE-MsgGUID: LCCyJQqySkS27xBCZaV82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157604880"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2025 11:51:33 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts4hK-0007k7-0n;
	Tue, 11 Mar 2025 18:51:27 +0000
Date: Wed, 12 Mar 2025 02:51:07 +0800
From: kernel test robot <lkp@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
Message-ID: <202503120232.2RVdFOyX-lkp@intel.com>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311013352.2727490-1-yajun.deng@linux.dev>

Hi Yajun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/genirq-Keep-affinity_hint-unchanged-if-it-has-a-value/20250311-093633
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250311013352.2727490-1-yajun.deng%40linux.dev
patch subject: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250312/202503120232.2RVdFOyX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120232.2RVdFOyX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120232.2RVdFOyX-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/irq/irqdesc.c: In function 'alloc_masks':
>> kernel/irq/irqdesc.c:61:38: error: passing argument 1 of 'zalloc_cpumask_var_node' from incompatible pointer type [-Werror=incompatible-pointer-types]
      61 |         if (!zalloc_cpumask_var_node(&desc->affinity_hint,
         |                                      ^~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      struct cpumask **
   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/irq.h:14,
                    from kernel/irq/irqdesc.c:10:
   include/linux/cpumask.h:996:68: note: expected 'struct cpumask (*)[1]' but argument is of type 'struct cpumask **'
     996 | static __always_inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
         |                                                     ~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/zalloc_cpumask_var_node +61 kernel/irq/irqdesc.c

    53	
    54	#ifdef CONFIG_SMP
    55	static int alloc_masks(struct irq_desc *desc, int node)
    56	{
    57		if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
    58					     GFP_KERNEL, node))
    59			return -ENOMEM;
    60	
  > 61		if (!zalloc_cpumask_var_node(&desc->affinity_hint,
    62					     GFP_KERNEL, node)) {
    63			free_cpumask_var(desc->irq_common_data.affinity);
    64			return -ENOMEM;
    65		}
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

