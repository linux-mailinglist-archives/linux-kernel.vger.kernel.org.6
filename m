Return-Path: <linux-kernel+bounces-338922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD65985E55
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C7E289470
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9718CC1C;
	Wed, 25 Sep 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpPmrpTC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41A165F1A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266283; cv=none; b=kinh7Qx77TXsE393kPHez2+IjgT/3jZP0lCY7illrWwvqSLaGdOlBGXx/CwbF57YNtMWYORsQKWZ5l4UqdPz0BIfrvZRG3AWN+3kiBaxmzDQVli7P6EQyNFKKvjk23zTYwuNAAURw4zICIsqjDUV3UHh15g108g+inmBWAWpBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266283; c=relaxed/simple;
	bh=FAHKjBRAC5Qo7JGJBZ0ZwrHXhZXpLlt629eFHIHC2mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpLZOtgUtxDkFxx0odPjAIHz6/zxQ1J/Vn72aQxV3R8owQ4MdXJ3fIkXG/AE/n2hqAeEyrDG79qy9Jc5D5GavmcdCNC1pkv+c4TN1KcpoCd2Q1/OZcZ4/M8ePI3GDEOF9mUdbR8jQzp3PGuVudRPLsrAyGSaSWlKLtuxLxET6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpPmrpTC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727266282; x=1758802282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FAHKjBRAC5Qo7JGJBZ0ZwrHXhZXpLlt629eFHIHC2mQ=;
  b=kpPmrpTCMv0LcRqDfFPHyEnAAa9r2MjMxc+ixQQW033pZYZsK9hNkm4Q
   KoaSgosC92Vv6qbGIKvP3Z6k5l8W6uzB5MNA0Sng9jspGcU/2tnJo5OV6
   XCOFoW/MrPNxTDrZAWkVvgYQ8tzgGfEK925B25is5xg6uNtc9guqj/yXh
   elbL65hyOjnylgndrrdmdoUNv09p7Ivae+wyTbEDeEFvR4OccjERvUJG5
   tGLXnKS5W/gGAEd7pvShp5FE/zD5SWVUn4dONCfnDdMjF/M3KdNQM/sp0
   mzlGJ0bVkywrhHlOHZ2pbzf5h3lGaLBjAd9PhqpnTY4HhaDxGen023lF2
   Q==;
X-CSE-ConnectionGUID: 72Ch90irRXK7zoiVX/WrSQ==
X-CSE-MsgGUID: ciJ5jI4RSLyMDCRKwMeQLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37685680"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37685680"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 05:11:22 -0700
X-CSE-ConnectionGUID: 4r2PhwDLS8+19mq24EPbKQ==
X-CSE-MsgGUID: kHeJJX76TBGVdZwSVBpbjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71349556"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2024 05:11:18 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stQrT-000JXF-17;
	Wed, 25 Sep 2024 12:11:15 +0000
Date: Wed, 25 Sep 2024 20:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
	Christoph Lameter <cl@linux-foundation.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <greg@kroah.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, tkjos@google.com,
	Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
	Yuming Han <yuming.han@unisoc.com>
Subject: Re: [PATCH 1/2] mm/slub: Add panic function when slub leaks
Message-ID: <202409251929.fHee67vM-lkp@intel.com>
References: <20240925032256.1782-2-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925032256.1782-2-fangzheng.zhang@unisoc.com>

Hi Fangzheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.11 next-20240925]
[cannot apply to vbabka-slab/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fangzheng-Zhang/mm-slub-Add-panic-function-when-slub-leaks/20240925-112601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240925032256.1782-2-fangzheng.zhang%40unisoc.com
patch subject: [PATCH 1/2] mm/slub: Add panic function when slub leaks
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240925/202409251929.fHee67vM-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251929.fHee67vM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251929.fHee67vM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:7354:2: error: unterminated conditional directive
    7354 | #ifdef CONFIG_SLUB_LEAK_PANIC
         |  ^
   1 error generated.


vim +7354 mm/slub.c

  7350	
  7351	/*
  7352	 * The /sys/module/slub ABI
  7353	 */
> 7354	#ifdef CONFIG_SLUB_LEAK_PANIC
  7355	/*
  7356	 * What:          /sys/module/slub/parameters/leak_panic
  7357	 *                /sys/module/slub/parameters/leak_panic_threshold
  7358	 * Date:          Sep 2024
  7359	 * KernelVersion: v6.6+
  7360	 * Description:   Used for slub memory leak check. When the user
  7361	 *                successfully allocates the slub page, it also performs
  7362	 *                statistics on the total slub usage in the system.
  7363	 *                When the usage exceeds the set value
  7364	 *                (threshold * memtotal / 100), it is considered that
  7365	 *                there is a risk of slub leakage in the system at this time.
  7366	 *                A panic operation will be triggered.
  7367	 * Users:         userspace
  7368	 */
  7369	MODULE_PARM_DESC(leak_panic, "Disable/Enable slub_leak_panic");
  7370	module_param_named(leak_panic, slub_leak_panic_enabled, bool, 0644);
  7371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

