Return-Path: <linux-kernel+bounces-510402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E5A31C44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289DE3A8078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D331D798E;
	Wed, 12 Feb 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPNG3pCB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB261D63C4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328464; cv=none; b=rfAOca8QxW08/0qbDE5fhb0mFclwWdaBL8XMgDYDoLAiltX97Cp1QwX9QxYCFVlVjpCvNM2ooxr1U2J9u5gNhfBhmmsFv5S/EatYGDTmzWf/kGM1YLlMwWRMbbOqCvAXexAnmuC8BfCjJT5pZi9ofK2Plrh/yqPwFgLvUPWR3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328464; c=relaxed/simple;
	bh=xLEQuFwS+B5l13xuPWAlVmmJybLtLGODIvyniOzcDMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sXTTAUWKijq7txwYPQIYFbKsSNaydSyLIkPLPpxuitmcxEHf8A4kPtGD9rPE+w1NWTqSSOpe3IeqLBh2EMIVA9rxz7xfX/vQUdj31X7XGA0qKV3UJWDDjhlUr+1FfNyxHvmWzFR7WMA9IsKD+kZK3mYVdopG4dNomCFrX0ZukME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPNG3pCB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739328463; x=1770864463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xLEQuFwS+B5l13xuPWAlVmmJybLtLGODIvyniOzcDMU=;
  b=dPNG3pCBLmx8eRvMSuYy70XWBLqvAbM3iJ/fLxW4UqlbZLs0d8eqGSTK
   OJBJHxPSVZc07GJEmAv7KQzqeiYta58+O825gGhbXHgt8M2+Vv3Hh3G5d
   eiidbTGFYOwQ1XBclvoek1oBy9F4gMo8GBH7RF4PnTOcNC5uL2I6UjTl2
   yh9N9n7nw2QGzpCYIx1AKBiWSboP6L626D/OXK54XSUJBhZgpHhiwMBGC
   bsf/gmXm03iPtPw3f8QN2PXAEU4YyxyIbLTLxQ1aJN9Ccw3u2VV+PtLB9
   S/IvsmnqQVOlSUYrgqwp8/Ca09sOJJqOB76eALJkfGy/VtThngdaHDFyd
   A==;
X-CSE-ConnectionGUID: FCz6C2ciSJSpd1m/6TFuhQ==
X-CSE-MsgGUID: X7D/MrlmT9e7wxWhP/Mb4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39990897"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39990897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:47:43 -0800
X-CSE-ConnectionGUID: vtuJPVFASNO43qsx3WX5ag==
X-CSE-MsgGUID: REb5PIHbQVio/bRe6nH/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117773185"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 18:47:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti2mo-00151c-1E;
	Wed, 12 Feb 2025 02:47:38 +0000
Date: Wed, 12 Feb 2025 10:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/resource.c:1838:43: warning: implicit conversion from
 'unsigned long long' to 'resource_size_t' (aka 'unsigned int') changes value
 from 68719476735 to 4294967295
Message-ID: <202502121040.ncM3OOjx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
commit: 99185c10d5d9214d0d0c8b7866660203e344ee3b resource, kunit: add test case for region_intersects()
date:   5 months ago
config: arm-randconfig-001-20241228 (https://download.01.org/0day-ci/archive/20250212/202502121040.ncM3OOjx-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121040.ncM3OOjx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121040.ncM3OOjx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/resource.c:1838:43: warning: implicit conversion from 'unsigned long long' to 'resource_size_t' (aka 'unsigned int') changes value from 68719476735 to 4294967295 [-Wconstant-conversion]
                   end = min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   kernel/resource.c:1827:52: note: expanded from macro 'MAX_PHYS_ADDR'
   #define MAX_PHYS_ADDR           ((1ULL << MAX_PHYSMEM_BITS) - 1)
                                                               ^
   include/linux/minmax.h:213:52: note: expanded from macro 'min_t'
   #define min_t(type, x, y) __cmp_once(min, type, x, y)
                             ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:96:33: note: expanded from macro '__cmp_once'
           __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:31: note: expanded from macro '__cmp_once_unique'
           ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
                                  ~~    ^
   kernel/resource.c:1855:45: warning: implicit conversion from 'unsigned long long' to 'resource_size_t' (aka 'unsigned int') changes value from 68719476735 to 4294967295 [-Wconstant-conversion]
                   addr <= min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   kernel/resource.c:1827:52: note: expanded from macro 'MAX_PHYS_ADDR'
   #define MAX_PHYS_ADDR           ((1ULL << MAX_PHYSMEM_BITS) - 1)
                                                               ^
   include/linux/minmax.h:213:52: note: expanded from macro 'min_t'
   #define min_t(type, x, y) __cmp_once(min, type, x, y)
                             ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:96:33: note: expanded from macro '__cmp_once'
           __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:31: note: expanded from macro '__cmp_once_unique'
           ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
                                  ~~    ^
   2 warnings generated.


vim +1838 kernel/resource.c

  1831	
  1832	static resource_size_t gfr_start(struct resource *base, resource_size_t size,
  1833					 resource_size_t align, unsigned long flags)
  1834	{
  1835		if (flags & GFR_DESCENDING) {
  1836			resource_size_t end;
  1837	
> 1838			end = min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
  1839			return end - size + 1;
  1840		}
  1841	
  1842		return ALIGN(max(base->start, align), align);
  1843	}
  1844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

