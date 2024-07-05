Return-Path: <linux-kernel+bounces-242603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3F928A58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F018B1F21628
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED9168490;
	Fri,  5 Jul 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiO/YbMh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EB14A0BC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188173; cv=none; b=We7HTQ07aMQhxwyiPbpBBxqGSZo81U0qGUsu9foZ5hFsqflwaPI5X1jxqKc6RaJtaEL25dD1gePNiv9GYo2oX+JY/KMIz6rzi4yFtwWzF3rNmpK+a5iqzzKidUBCAbq+twM+8GUoBMVDbGY5UIcbbUU1n4ynAS/R4gunsVXfWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188173; c=relaxed/simple;
	bh=Ey1kRqQMEA9yWomml3zQYIK4tI58rc7XAbEtt0BRUMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC0ODjGgjxA4Z/XVgz2IzMaUEumX5sdc5/0yA1XmwXf2t4WCkcH3jVEJYBQ191Ly2O7X8w92OkvirjShTRlNZ/MZ6/AjIgHoUW94HaAwfyutkOV1ShmzcXYAe04sQqeXRoE/4hr/U3ZeVZzKwDLYVImzh8u9NXcZY3aK5RMNKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiO/YbMh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720188171; x=1751724171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ey1kRqQMEA9yWomml3zQYIK4tI58rc7XAbEtt0BRUMU=;
  b=ZiO/YbMh7Y714lF1ZnyykNdgtZwISdj278dFKwAa/IYGB1HVpMz7hVuo
   KgvBZuR2OAvLdvMOBi1jzgSVR65QJzksduGiy2FndWNizzTFoWAu2OOla
   XO5mtRrpnoDZPgDZfNwiAymcdoovqAVFCXkfwQOellUpqqlfVgQRjNTMl
   wI7pikUOMRBnLpDLSaHDPcGoR5HCDIreu4i4mSWXkJFzzgwWiB15wls/v
   6UEOCKo3IcIkx16t+6eq0RiEHF9yAulV+5EYeanK5Ndvvw4GF98vtJUFo
   AA9Mn70UXJcyC5aMDJOgjyg90MDgoFNd3EzaQ2E2z55EV6swuTvpLIMg0
   g==;
X-CSE-ConnectionGUID: ibnutjzUT+SjaqHUfPawBQ==
X-CSE-MsgGUID: x3CRdOIMTSODlDVEOyfK9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17614471"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17614471"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 07:02:50 -0700
X-CSE-ConnectionGUID: i4huqPTzQh+odbRjHbOcRQ==
X-CSE-MsgGUID: fIi+5rV6TeOAKVZhGxFuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51309171"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Jul 2024 07:02:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPjWO-000SRc-2e;
	Fri, 05 Jul 2024 14:02:44 +0000
Date: Fri, 5 Jul 2024 22:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v2 01/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <202407052114.eLXLN20k-lkp@intel.com>
References: <20240703040613.681396-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703040613.681396-2-alexs@kernel.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/alexs-kernel-org/mm-zsmalloc-add-zpdesc-memory-descriptor-for-zswap-zpool/20240703-182314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240703040613.681396-2-alexs%40kernel.org
patch subject: [PATCH v2 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
config: i386-buildonly-randconfig-001-20240705 (https://download.01.org/0day-ci/archive/20240705/202407052114.eLXLN20k-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407052114.eLXLN20k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407052114.eLXLN20k-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from mm/zsmalloc.c:40:
>> include/linux/stddef.h:16:33: error: 'struct page' has no member named 'memcg_data'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   mm/zpdesc.h:40:9: note: in expansion of macro 'static_assert'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |         ^~~~~~~~~~~~~
   mm/zpdesc.h:40:23: note: in expansion of macro 'offsetof'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |                       ^~~~~~~~
   mm/zpdesc.h:48:1: note: in expansion of macro 'ZPDESC_MATCH'
      48 | ZPDESC_MATCH(memcg_data, memcg_data);
         | ^~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct zpdesc' has no member named 'memcg_data'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   mm/zpdesc.h:40:9: note: in expansion of macro 'static_assert'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |         ^~~~~~~~~~~~~
   mm/zpdesc.h:40:52: note: in expansion of macro 'offsetof'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |                                                    ^~~~~~~~
   mm/zpdesc.h:48:1: note: in expansion of macro 'ZPDESC_MATCH'
      48 | ZPDESC_MATCH(memcg_data, memcg_data);
         | ^~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: expression in static assertion is not an integer
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   mm/zpdesc.h:40:9: note: in expansion of macro 'static_assert'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |         ^~~~~~~~~~~~~
   mm/zpdesc.h:40:23: note: in expansion of macro 'offsetof'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |                       ^~~~~~~~
   mm/zpdesc.h:48:1: note: in expansion of macro 'ZPDESC_MATCH'
      48 | ZPDESC_MATCH(memcg_data, memcg_data);
         | ^~~~~~~~~~~~


vim +16 include/linux/stddef.h

6e2182874324727 Richard Knutsson 2006-09-30  14  
^1da177e4c3f415 Linus Torvalds   2005-04-16  15  #undef offsetof
14e83077d55ff4b Rasmus Villemoes 2022-03-23 @16  #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
3876488444e7123 Denys Vlasenko   2015-03-09  17  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

