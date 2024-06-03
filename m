Return-Path: <linux-kernel+bounces-199372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCE8D8632
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A8B1F2143C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE8130ACF;
	Mon,  3 Jun 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiIdf16g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06606882B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429027; cv=none; b=KxDOrzeP2+ZzuguCIzUcz3+k1JjLm+iNV/aS4YM83eMsVoxj19RzioAtzTkugUGlBAU0KZ1CKZrWCqUcBpifiwNH7uv+Q2J/rFwWEi8fEw2MLYiuTSRDKQ3r9yIlXvBtrBEyq/gGVRAEmIjsulb3/RMURg8LBOXHAFppfUhoKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429027; c=relaxed/simple;
	bh=qLGutChqnX9e8a3ha4iN2YiLfsS82Seh0CnbTGwsF+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/fvQMc2PzzS0trTLJVgvS+SS1/x1yb8/AHL+qqgu9jvBJcizeyeyJ929cfUZ9AhCJD+XWrS4y0jaA6NFlV6PjCkGsV2nTCfBJIt1pDyyPlrRfjcHl90ZDNTcL4w5EJHnWJ3uo5SjS5znLz117o3+9CVRw+kBilm8ROtnlSoH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiIdf16g; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717429025; x=1748965025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLGutChqnX9e8a3ha4iN2YiLfsS82Seh0CnbTGwsF+c=;
  b=BiIdf16g8NwaxOzJhS5+stZ186oe6VAZzB6JIHYle3d1mGXKhdUYBQQC
   z2IL9lO1A4ZDWg7SfEKgSng6UE4DVJuLUa8443NmjD++5FIJOPwb8Y4qz
   /QQFWmtxJYMduvAkWgdsdb5IqaHkoMcEqZA1lWvJaZvklN8eWpYRoyFVS
   sqG3EPbBFqIGjx5wqQ25qvSAgcwgnZ1hCz4OFPAIBladB7IpnUylKR1+K
   2Vx+sYKWz8cCHrxvdiuDmq8JIgLGBftOT3D0HdUWMFW/6h9qryxknYcrV
   GDLZVIu0jHk0I31CEPExqdiwRZXb4TOxCMI9mwQx8kTYswpyeeKsqsH8I
   w==;
X-CSE-ConnectionGUID: zr7LkxMkSFSGq+lI/ECbXA==
X-CSE-MsgGUID: hLfOvcALS+WtJ2ARMLNVEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17753465"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17753465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 08:37:05 -0700
X-CSE-ConnectionGUID: 7gY6C+GHQda2OASj6mtLdA==
X-CSE-MsgGUID: wJTKSMQ0Qd68nog43sZDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41996853"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Jun 2024 08:37:02 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE9k4-000LpL-05;
	Mon, 03 Jun 2024 15:37:00 +0000
Date: Mon, 3 Jun 2024 23:36:41 +0800
From: kernel test robot <lkp@intel.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on
 template
Message-ID: <202406032321.OzAKgNBA-lkp@intel.com>
References: <20240603120506.1837322-3-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603120506.1837322-3-xiujianfeng@huawei.com>

Hi Xiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiu-Jianfeng/mm-hugetlb_cgroup-identify-the-legacy-using-cgroup_subsys_on_dfl/20240603-201513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240603120506.1837322-3-xiujianfeng%40huawei.com
patch subject: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on template
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240603/202406032321.OzAKgNBA-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406032321.OzAKgNBA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406032321.OzAKgNBA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/hugetlb_cgroup.c:20:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2245:
   include/linux/vmstat.h:498:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     498 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/hugetlb_cgroup.c:828:13: warning: address of array 'tmpl->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
     828 |                 if (tmpl->name)
         |                 ~~  ~~~~~~^~~~
   2 warnings generated.


vim +828 mm/hugetlb_cgroup.c

   814	
   815	static void __init
   816	hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
   817				     struct cftype *tmpl, int tmpl_size)
   818	{
   819		char buf[32];
   820		int i, idx = hstate_index(h);
   821	
   822		/* format the size */
   823		mem_fmt(buf, sizeof(buf), huge_page_size(h));
   824	
   825		for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
   826			*cft = *tmpl;
   827			/* rebuild the name */
 > 828			if (tmpl->name)
   829				snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
   830			/* rebuild the private */
   831			if (tmpl->private)
   832				cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
   833			/* rebuild the file_offset */
   834			if (tmpl->file_offset) {
   835				unsigned int offset = tmpl->file_offset;
   836	
   837				cft->file_offset = MEMFILE_OFFSET0(offset) +
   838						   MEMFILE_FIELD_SIZE(offset) * idx;
   839			}
   840		}
   841	}
   842	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

