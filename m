Return-Path: <linux-kernel+bounces-187310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1358CCFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E26B1F237C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605C13D8AF;
	Thu, 23 May 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEsy0Dfj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD713CABA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458945; cv=none; b=dy/UZrXzBlpPFzKu9AhSF7OHrCC8VnMsSDi/eLx3bZEJnOMLM+y8nfCcYhtfpLwkOImC3xEf2GFMqGjF68GJV9EvTe22pKCFqXrdPuvlpzIAQaeLv5K4hUaLlO1hH7pb1aYoaCMIncI8KfciUl1o3vBBW57y4Owd5YC7snYLC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458945; c=relaxed/simple;
	bh=cRvgnopSvHuyo7S5+mFu2V6jpNbioLHzrbU88U4unFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tPcfd4SLvgYAFkylMXmbg8D3nWBQ+Sgvvee3e6pRQcJayNZn0DD03MdPuyZi90Xw1hZFe5hYAf2Q7g4CTUxEIeJWRjYS5bGfftGpMjh2B0zl+sTSWiViErhedww7DxpwVGFk/EZNaQIIxJ6r3sqgGOsREWxrlgWT+cG6VtGHDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEsy0Dfj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716458943; x=1747994943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cRvgnopSvHuyo7S5+mFu2V6jpNbioLHzrbU88U4unFs=;
  b=mEsy0DfjQq4qxrtzf6yku1G7ZXVFhZknXdWU8UV4vx4UAs8pKtzEzhSK
   hnF6YiC4FJp+lVeE/iF5GdJx6B2fBsN26t6K9AXEADwdLwxVS4puyjkf3
   KnNJkm5gOp1Kjj7OwbXd9alyfjJBXLc8Pg0bYEF6mmb2W0es/446wsV2j
   kJn/26yEzjGsRgn1MbLx1VGzgamuXItPQ8PQehcmrYlItuKRUG8S+H8I3
   r3czuIPY5SyNgB1BqG7NZXJQ9/CuKjqJubhfh9QQA/LvmL7YFXu1+v7fM
   4i/xBGTIrpYnx81IqN2a3UfqlOiceT4EN6naJGT2LdDb/GO9jghH5IZSI
   Q==;
X-CSE-ConnectionGUID: 9etgbAfQSPicMoRgVJbkyg==
X-CSE-MsgGUID: LvFA7i0iRM2Ji8C38c5MTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23898282"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23898282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:09:02 -0700
X-CSE-ConnectionGUID: IZoTNUtTT4SFHHy+k+cOIA==
X-CSE-MsgGUID: ZVz69UgRQIqFH6xkJgYH4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38011553"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 May 2024 03:09:01 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA5Na-0002hh-2j;
	Thu, 23 May 2024 10:08:58 +0000
Date: Thu, 23 May 2024 18:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Barry Song <v-songbaohua@oppo.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/huge_mm.h:285:undefined reference to `mthp_stats'
Message-ID: <202405231728.tCAogiSI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c760b3725e52403dc1b28644fb09c47a83cacea6
commit: ec33687c674934dfefd782a8ffd58370b080b503 mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters
date:   2 weeks ago
config: s390-randconfig-r005-20230226 (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405231728.tCAogiSI-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/memory.o: in function `count_mthp_stat':
>> include/linux/huge_mm.h:285:(.text+0x191c): undefined reference to `mthp_stats'
   s390-linux-ld: mm/huge_memory.o:(.rodata+0x10): undefined reference to `mthp_stats'


vim +285 include/linux/huge_mm.h

   279	
   280	static inline void count_mthp_stat(int order, enum mthp_stat_item item)
   281	{
   282		if (order <= 0 || order > PMD_ORDER)
   283			return;
   284	
 > 285		this_cpu_inc(mthp_stats.stats[order][item]);
   286	}
   287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

