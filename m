Return-Path: <linux-kernel+bounces-347660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572098D94A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC23C1F21652
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F381D2200;
	Wed,  2 Oct 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKk17jGk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756221D1F74
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877899; cv=none; b=kuCYRWZjTG0o8RFhyrrXDAxw/+aM46DvicaSZWfTl1+aZAgUa4G2v9Nqo8SijUbUCsTSB++TSH+IfhLO/ycfjqRbL8DQWTKYH3ZvmzUYZ1y48/atGEdwzpsIWS0E+Kln05Sm8/qzqZD02mnWHmX7p5z3fSQtUM2DfBi+uZorDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877899; c=relaxed/simple;
	bh=V3mZRy5RQR1Eu05wsO9e6qyZguDVh74fMnPcxO7KWxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k4k9isd3NNYpXuWCG0mhbH6zcEOXBMg4GM9/MZAFV5xvG083uGj3UUoi2a/Nkn5o3+LqYqA2qZZ5aPisFNINDJ+Ta8LdpcaCsibkUKiCGk26Exz9i264LyaWzPYciroKoC5hnnZbRFm9b8YIhSszlVWI3JAiunVZDD0T5nTWms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKk17jGk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727877898; x=1759413898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V3mZRy5RQR1Eu05wsO9e6qyZguDVh74fMnPcxO7KWxM=;
  b=MKk17jGkND+B0EQlQ5TELzTL32ynozlrffEOG/ZphUesBBE8tqx+6pfe
   STMcmOVBQN+f7LnGa9Vp2KsjKAxGIkoBC4aF5uzFoV7ena6akgozPVebf
   kPvhBOHBJ45rDzN21jnysi4k5UCyW3Q3nZGo3I8ksNc2NtYPPZE/Ve1F5
   VX9xvVphvfiD01laZ5uUX8BXAkkcKR3UizLATJNA/JWYAgXAtwV2kyg3g
   vIQVA2bE2nVJ3LpcC2VRbQJKmIan39ah3HWCX7G6Nw0YczuSKLPU9Dq85
   EHRcUpJgT1SoZKWqubKzSfgq5D4QcvfJ+nQmCMsjRIzatrQ5OuAk4gQbM
   g==;
X-CSE-ConnectionGUID: JgNcUO45S2yERtQn5O05dg==
X-CSE-MsgGUID: IS9QeTW3T7qyvNFhPPJV3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26840320"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26840320"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:02:44 -0700
X-CSE-ConnectionGUID: ngE4dKQ8QhuXepPyCKUuzw==
X-CSE-MsgGUID: XGe+RQGIT6mNO0MyqxWKJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="73880526"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Oct 2024 07:02:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svzw8-000Sxk-15;
	Wed, 02 Oct 2024 14:02:40 +0000
Date: Wed, 2 Oct 2024 22:02:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/failslab.c:19:5: error: redefinition of 'should_failslab'
Message-ID: <202410022126.z1ggl2C9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: 6ce2082fd3a25d5a8c756120959237cace0379f1 fault-inject: improve build for CONFIG_FAULT_INJECTION=n
date:   4 weeks ago
config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410022126.z1ggl2C9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410022126.z1ggl2C9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410022126.z1ggl2C9-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/failslab.c:14:17: error: 'FAULT_ATTR_INITIALIZER' undeclared here (not in a function)
      14 |         .attr = FAULT_ATTR_INITIALIZER,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
>> mm/failslab.c:19:5: error: redefinition of 'should_failslab'
      19 | int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
         |     ^~~~~~~~~~~~~~~
   In file included from mm/failslab.c:2:
   include/linux/fault-inject.h:128:19: note: previous definition of 'should_failslab' with type 'int(struct kmem_cache *, gfp_t)' {aka 'int(struct kmem_cache *, unsigned int)'}
     128 | static inline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
         |                   ^~~~~~~~~~~~~~~
   mm/failslab.c: In function 'should_failslab':
   mm/failslab.c:44:26: error: 'FAULT_NOWARN' undeclared (first use in this function)
      44 |                 flags |= FAULT_NOWARN;
         |                          ^~~~~~~~~~~~
   mm/failslab.c:44:26: note: each undeclared identifier is reported only once for each function it appears in


vim +/should_failslab +19 mm/failslab.c

773ff60e841461c Akinobu Mita           2008-12-23   8  
773ff60e841461c Akinobu Mita           2008-12-23   9  static struct {
773ff60e841461c Akinobu Mita           2008-12-23  10  	struct fault_attr attr;
71baba4b92dc1fa Mel Gorman             2015-11-06  11  	bool ignore_gfp_reclaim;
621a5f7ad9cd1ce Viresh Kumar           2015-09-26  12  	bool cache_filter;
773ff60e841461c Akinobu Mita           2008-12-23  13  } failslab = {
773ff60e841461c Akinobu Mita           2008-12-23 @14  	.attr = FAULT_ATTR_INITIALIZER,
71baba4b92dc1fa Mel Gorman             2015-11-06  15  	.ignore_gfp_reclaim = true,
621a5f7ad9cd1ce Viresh Kumar           2015-09-26  16  	.cache_filter = false,
773ff60e841461c Akinobu Mita           2008-12-23  17  };
773ff60e841461c Akinobu Mita           2008-12-23  18  
a7526fe8b94eced Vlastimil Babka        2024-07-11 @19  int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
773ff60e841461c Akinobu Mita           2008-12-23  20  {
ea4452de2ae9873 Qi Zheng               2022-11-18  21  	int flags = 0;
ea4452de2ae9873 Qi Zheng               2022-11-18  22  
fab9963a69dbd71 Jesper Dangaard Brouer 2016-03-15  23  	/* No fault-injection for bootstrap cache */
fab9963a69dbd71 Jesper Dangaard Brouer 2016-03-15  24  	if (unlikely(s == kmem_cache))
a7526fe8b94eced Vlastimil Babka        2024-07-11  25  		return 0;
fab9963a69dbd71 Jesper Dangaard Brouer 2016-03-15  26  
773ff60e841461c Akinobu Mita           2008-12-23  27  	if (gfpflags & __GFP_NOFAIL)
a7526fe8b94eced Vlastimil Babka        2024-07-11  28  		return 0;
773ff60e841461c Akinobu Mita           2008-12-23  29  
a9659476d4b391a Nicolas Boichat        2019-07-11  30  	if (failslab.ignore_gfp_reclaim &&
a9659476d4b391a Nicolas Boichat        2019-07-11  31  			(gfpflags & __GFP_DIRECT_RECLAIM))
a7526fe8b94eced Vlastimil Babka        2024-07-11  32  		return 0;
773ff60e841461c Akinobu Mita           2008-12-23  33  
fab9963a69dbd71 Jesper Dangaard Brouer 2016-03-15  34  	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
a7526fe8b94eced Vlastimil Babka        2024-07-11  35  		return 0;
4c13dd3b48fcb6f Dmitry Monakhov        2010-02-26  36  
ea4452de2ae9873 Qi Zheng               2022-11-18  37  	/*
ea4452de2ae9873 Qi Zheng               2022-11-18  38  	 * In some cases, it expects to specify __GFP_NOWARN
ea4452de2ae9873 Qi Zheng               2022-11-18  39  	 * to avoid printing any information(not just a warning),
ea4452de2ae9873 Qi Zheng               2022-11-18  40  	 * thus avoiding deadlocks. See commit 6b9dbedbe349 for
ea4452de2ae9873 Qi Zheng               2022-11-18  41  	 * details.
ea4452de2ae9873 Qi Zheng               2022-11-18  42  	 */
3f913fc5f974561 Qi Zheng               2022-05-19  43  	if (gfpflags & __GFP_NOWARN)
ea4452de2ae9873 Qi Zheng               2022-11-18  44  		flags |= FAULT_NOWARN;
3f913fc5f974561 Qi Zheng               2022-05-19  45  
a7526fe8b94eced Vlastimil Babka        2024-07-11  46  	return should_fail_ex(&failslab.attr, s->object_size, flags) ? -ENOMEM : 0;
773ff60e841461c Akinobu Mita           2008-12-23  47  }
a7526fe8b94eced Vlastimil Babka        2024-07-11  48  ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
773ff60e841461c Akinobu Mita           2008-12-23  49  

:::::: The code at line 19 was first introduced by commit
:::::: a7526fe8b94eced7d82aa00b2bcca44e39ae0769 mm, slab: put should_failslab() back behind CONFIG_SHOULD_FAILSLAB

:::::: TO: Vlastimil Babka <vbabka@suse.cz>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

