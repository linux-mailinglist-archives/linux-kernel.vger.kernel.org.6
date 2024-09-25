Return-Path: <linux-kernel+bounces-338516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D3985988
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D1D284158
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B31A38D0;
	Wed, 25 Sep 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqTtzFWb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61E1A3046
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264363; cv=none; b=GE8fxpXd/E1CTWocufQLRwvRxq9BF2ZRhGZ4jXUVEr6sCioOoQNJ1Zpv+9Rt8f5AQin5uiGu/CDXShUBvXqYLB7ohfE1abOVitqT8DRg1cPUyDGx5pxRQXXm4rjGOMpGGrTzKj4tForsJvuKJbBh7pZRN5YTyBb4DnXIhDYWoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264363; c=relaxed/simple;
	bh=v3Vu+YeTkpjmMPj1uAIp2/vkwpKekQ3F0fZjvvd7h+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCHF6zHX6unj43PZ4MmPRNJKfQAUPRs9gh49afjjAVYabnNaR06HbFKzRHL/5vIlyO3CaL+OeTUd5gU7uwAHmqwAF5pSN0P2cOCxC1uX1ZRbdSTZGLmcvFCsbnkDTKH+3fr8feXf3q4z3wheYcYKl+SkoVa64szyguxvEkhwuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqTtzFWb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727264362; x=1758800362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3Vu+YeTkpjmMPj1uAIp2/vkwpKekQ3F0fZjvvd7h+Q=;
  b=VqTtzFWb8Y3t0ysxoZ0iQOfHx88u9xcrHOqVbnB87TpFX/K1K94B2Apr
   1b82uRTkgmfjxaATzzruIoeKn7UXqNQSWxmSwsliTTCyMtIpvAk1xssb9
   +0OthkgazmnYBU3/BgLJrMss5PAUtmYtcX5VzTD28pHsEbnUHYIEF0heI
   QE2wFNC2afjhY7ZL1aKGUENv01Y8b9gVGokLw0QkltNv0/0FRSmwIcPAp
   SAyW9mJ2OqEoxZvrWYSn3pLYbzxaWqJI7fnjFQgjN4RFF5Fq1a/s1ITek
   PsHdq4O65yPzBABekk3CP1E9CHMXjFaaemXbYRFZqwAJtjjHByJqUkdaq
   Q==;
X-CSE-ConnectionGUID: tM1kmSdsTgyPJhKbZStxYw==
X-CSE-MsgGUID: 1CDHPonSS8GqZFzwW1BmrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26175490"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26175490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 04:39:21 -0700
X-CSE-ConnectionGUID: IohvOObDQ4KPN8wEon43QA==
X-CSE-MsgGUID: PKefS8E9S/yhLSMgPL+RgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="102564370"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2024 04:39:17 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stQMU-000JW7-1t;
	Wed, 25 Sep 2024 11:39:14 +0000
Date: Wed, 25 Sep 2024 19:39:03 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, tkjos@google.com,
	Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
	Yuming Han <yuming.han@unisoc.com>
Subject: Re: [PATCH 1/2] mm/slub: Add panic function when slub leaks
Message-ID: <202409251901.XFGbDalC-lkp@intel.com>
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
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240925/202409251901.XFGbDalC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251901.XFGbDalC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251901.XFGbDalC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:7354: error: unterminated #ifdef
    7354 | #ifdef CONFIG_SLUB_LEAK_PANIC
         | 


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

