Return-Path: <linux-kernel+bounces-199730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBC8DAFF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB9FB24714
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D313BC1E;
	Mon,  3 Jun 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJsSakcp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395E13B59C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449981; cv=none; b=hYNkrELN9i3piN5jJy3gCNYs8s2vW+KjSfuYiyX95jmiuIdbqM5e1Z0caxZMx+1SBii3sqHwTkeI84JDZfjTjMjHBMUgVs3OoPnWsJYVXzckZq3Nyp28t4msM9IjYVkwz2eD/DQIGIi+Q4z18pQzoowGLAR+p6P7KUw00Vrw/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449981; c=relaxed/simple;
	bh=hxFNXFxhoTGnscbJZwVO74ezWVZmXgfbta89CyZQJEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVBXHn+gC9NFYcumFg+W8R+gvtsjMJ4T/eDZu91/HJawsVnbQb6sYChQkWdW+kXQqGUrOx3tETfU4N29HO0S3npK5q8jf3CCnp2aDgE9bpb/wJoC7uz/n8TFsLUDibxnuqi57zxFkvwifiuLylIdROUljSvgJ7WBfrMoKT7J6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJsSakcp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717449978; x=1748985978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxFNXFxhoTGnscbJZwVO74ezWVZmXgfbta89CyZQJEU=;
  b=cJsSakcp3a2C16+G2BrwUBxemK1YWrj/hlZc3UxKMTite/D7RAhTnJRr
   w5jlOQvJVEUXvCb3xymeEq9T/LVdOH4PtmgMt5LlZIJNMovCClWlly0jw
   A7P+A8xo5EyMQZUndFnM0hnQ9q5fxw4kt5ERoW+lMTYe8J/dn2hyzb6u9
   rL8iD3NVQ9K9Vn3l19yGeSrMuL5RAriBrgvwE12fH//q7/1sK2otsOVk1
   MbkTfLxvbio6aX2Y22jpGORQBvC5EE1c8M46900BjADSWy02uxfgKK8Lu
   01NcRCFf1AdxWr9mZ5IHfEseNNB/6EjNL3oC4LvKKwKJg1QT3bhByJexh
   w==;
X-CSE-ConnectionGUID: RuiZIWEvRpuuxlrIj6SlHQ==
X-CSE-MsgGUID: ene+xzg+SF2MwbxDEHtYSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17802158"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17802158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:26:18 -0700
X-CSE-ConnectionGUID: dGhhB+7wQ9SMOSJDMY8Nqw==
X-CSE-MsgGUID: W49K0OOsQmG0sir3DGIPfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37601355"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 14:26:16 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEFBt-000MCx-26;
	Mon, 03 Jun 2024 21:26:08 +0000
Date: Tue, 4 Jun 2024 05:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on
 template
Message-ID: <202406040437.z2Iel9db-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240604/202406040437.z2Iel9db-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040437.z2Iel9db-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040437.z2Iel9db-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_cfttypes_init':
>> mm/hugetlb_cgroup.c:828:21: warning: the comparison will always evaluate as 'true' for the address of 'name' will never be NULL [-Waddress]
     828 |                 if (tmpl->name)
         |                     ^~~~
   In file included from include/linux/cgroup.h:27,
                    from mm/hugetlb_cgroup.c:20:
   include/linux/cgroup-defs.h:605:14: note: 'name' declared here
     605 |         char name[MAX_CFTYPE_NAME];
         |              ^~~~


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

