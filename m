Return-Path: <linux-kernel+bounces-290880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F072F955A73
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E11C20E29
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF617D2;
	Sun, 18 Aug 2024 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkiPKCnI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE2F56
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723939442; cv=none; b=urOi+weeF6DAUOWAfo8QWDaVRz3stMlHuYz5UKo7v16LnvSeWjoLBpbBjKxHb0X6nOVU5nz0ooAI6eqP4Hk0IYwqQjleOTaq+jzhZ3XbwhZBUvF7l1GCzZlWsNcth0f2qbXw8nKg0WkCp6vLJ9/CFH6HgsREU6QeYNO9/xnH5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723939442; c=relaxed/simple;
	bh=dIBabbHnvUrU2LDn0J+PSLmzE5bL2UFcy1hlsHznb3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j37Unci/y+hhGOnMufk2cpxpWZlvjItMsuMFQ4PJXf5o84TnCdlwE/TD0v3cM2ykQdZtO5ErXxLSiUMkba+pdlOFivzcd4nXpcdN+s3PNxIB2QVLvcBStJZWyLZ+FijoRDG0t8wv+aiDoXBc+OieNks/N+FsQmZKFQojmAYdI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkiPKCnI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723939439; x=1755475439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dIBabbHnvUrU2LDn0J+PSLmzE5bL2UFcy1hlsHznb3A=;
  b=GkiPKCnID1Uq0LliGxh2GV3vAmTWb6wTZQ0ul3lfozHZ4xkgJRiEPV57
   9etKtXsp+hIcvz8COwGan4kqzqRc1dd4MBAOvBCqdSy1NsQ5mZU+C3Dmw
   +El9JvvEy/MMLbIO7OreVoQqefCEFgqJ7ZzQI2ZHYOamhCDDExE8i3Xsz
   vuGyvAmK8LmitmVgiPOV/L0WtRACCzroLVEK50uJjGP/fsLyj3+Pyvlbh
   9lRIHUjPfZzetU+naSnBEsHFC/1mjuw0FVe1h1TlLu6SZBkirLlCFLmGd
   R6KS9nr7KHQew2uWPw2ZrTwJ1w4nWPyRbWzLxn1fI7XOW5YfNgXxfj6Uv
   w==;
X-CSE-ConnectionGUID: ghN4JiEVT0aMupR/pQ6qRw==
X-CSE-MsgGUID: 3sd/lFD0RdWX7pvA/WMc4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="39661496"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="39661496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 17:03:59 -0700
X-CSE-ConnectionGUID: xEOYpzM8T+a6vAV7gO/U3A==
X-CSE-MsgGUID: HB2/fAYRTTuLgoqcBpvJNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="59856746"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Aug 2024 17:03:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfTOj-0007tH-1U;
	Sun, 18 Aug 2024 00:03:53 +0000
Date: Sun, 18 Aug 2024 08:03:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: Re: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
Message-ID: <202408180729.M6uZh634-lkp@intel.com>
References: <20240817050921.18462-5-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817050921.18462-5-kanchana.p.sridhar@intel.com>

Hi Kanchana,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7c626ce4bae1ac14f60076d00eafe71af30450ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar/mm-zswap-zswap_is_folio_same_filled-takes-an-index-in-the-folio/20240817-131053
base:   7c626ce4bae1ac14f60076d00eafe71af30450ba
patch link:    https://lore.kernel.org/r/20240817050921.18462-5-kanchana.p.sridhar%40intel.com
patch subject: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240818/202408180729.M6uZh634-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408180729.M6uZh634-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408180729.M6uZh634-lkp@intel.com/

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

