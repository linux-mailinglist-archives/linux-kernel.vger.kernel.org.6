Return-Path: <linux-kernel+bounces-289675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9495490C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A0F1F20C66
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761D1B86C3;
	Fri, 16 Aug 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GST0JKnU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7F1B3F08
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812300; cv=none; b=TijNTIjFh3BrwSgbKZfpE7PG0Xkvp3yodWgnPZx/DiWx4K0Jnj57FLeuW/RFxBcbNVA8eLLg3y1/E32opCDanvvfjDMWG06ItSwGUcO83OcwKOhp3iAGEMMKSai18fa1QsX/KRcIKnD+4H6FoMSmKWjKl1oFFmmsK1rgmUDi1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812300; c=relaxed/simple;
	bh=fvGhxIuzPUioSNTTe3EoSTFxz8wI2lhy+hs0qJT16y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0+XZ8ovnROnE28VshQCeIP4bkACdcje+BuZxNJowMDRGlbD3rH26EYVatEgghTS3081b8LN8uHy8vvDOHgbT1q6TbXCP5amAQttktJuhte2ryc2+5FWg0X2cJnwEk0RtHOZPP3rWqgRGsfoTKjzkcGjqgAz8mNXb2Eb5itJNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GST0JKnU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723812299; x=1755348299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvGhxIuzPUioSNTTe3EoSTFxz8wI2lhy+hs0qJT16y4=;
  b=GST0JKnUhe1K7ZITGKGWQ712/qfA4sZJdqrNCvXgUe5lb40lawIjsDVx
   XbhZordQKCPOrjCBSpDxFn7II5UYTzCLPp1A5hoscMEQ9Faga7VbJuNxX
   WeEjU3tLn7aeKBCvrg5iZW2r060dncG+wdJUuN0ZswdhnGEfPgj5a1tjy
   qO5QwMRwkJOFEQuEkVSrGfJVezIH8/csiovyZn7pGEtOJsmkFl8Ko6RPp
   2ZkG4sE/q2mTVAATpwWMIIO06lkSVQ8wm2BuOTC4L9jI3wPS8+B97u4Gk
   TlLCcEiJXAs6herqQWfQvjAKlW72CTj9+wK3yJjdRpECBYdQHHraPc51t
   Q==;
X-CSE-ConnectionGUID: +STeHcCSRGeKjlDq77J7Eg==
X-CSE-MsgGUID: hgGRe5hPQheUdTMfUK1DQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="44625450"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="44625450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 05:44:57 -0700
X-CSE-ConnectionGUID: pzvbqMBIQSqcDRf43NMVfw==
X-CSE-MsgGUID: 8HfQNVKBQTilZOBzibhyrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64333875"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Aug 2024 05:44:54 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sewK4-0006QC-15;
	Fri, 16 Aug 2024 12:44:52 +0000
Date: Fri, 16 Aug 2024 20:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: Re: [PATCH v2 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
Message-ID: <202408162056.MQnreTgK-lkp@intel.com>
References: <20240816054805.5201-5-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816054805.5201-5-kanchana.p.sridhar@intel.com>

Hi Kanchana,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc3]
[cannot apply to akpm-mm/mm-everything next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar/mm-zswap-zswap_is_folio_same_filled-takes-an-index-in-the-folio/20240816-134948
base:   linus/master
patch link:    https://lore.kernel.org/r/20240816054805.5201-5-kanchana.p.sridhar%40intel.com
patch subject: [PATCH v2 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
config: i386-buildonly-randconfig-005-20240816 (https://download.01.org/0day-ci/archive/20240816/202408162056.MQnreTgK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408162056.MQnreTgK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408162056.MQnreTgK-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_io.c: In function 'count_mthp_zswpout_vm_event':
>> mm/page_io.c:178:17: error: implicit declaration of function 'count_mthp_stat' [-Werror=implicit-function-declaration]
     178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
         |                 ^~~~~~~~~~~~~~~
>> mm/page_io.c:178:53: error: 'MTHP_STAT_ZSWPOUT' undeclared (first use in this function)
     178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
         |                                                     ^~~~~~~~~~~~~~~~~
   mm/page_io.c:178:53: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/count_mthp_stat +178 mm/page_io.c

   174	
   175	static inline void count_mthp_zswpout_vm_event(struct folio *folio)
   176	{
   177		if (IS_ENABLED(CONFIG_THP_SWAP))
 > 178			count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

