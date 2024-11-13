Return-Path: <linux-kernel+bounces-408381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB59C7E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FD8283F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143618C33A;
	Wed, 13 Nov 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8LXdSub"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254718BC29
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535727; cv=none; b=roPz8GKo7fmBpWZmopQl9rA2xjSO7sDFh9F93VkuXiMAf/6oIj1fqo4/MaSTVQ9odlcZulu3WZRjxKexre2gYpzqRYCU0X002jZmkNm+5HiCnueiXwqCp00J6h8vjOs0gfkLHYsUQFq2+1NRZs4VTKi4NSp1kgFJcy6mQYdPjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535727; c=relaxed/simple;
	bh=z9stuSLhlEy++TW9cEOH6TRGd9dAPMRqgcaZYellQBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy+DqNJlx+vFB/Q4Xw2i86Jqx304pkQv8DnXJNebiwFlaK2gDMzwnJYNUPySXPNgPmd7lp2MSdjgoA1KlQJYxdXhS9pyNM6NJfiu3FVDfpHhJpyR7fIyfOn+91JW304FNFDmWSddglARaw9DnrVtOM2ids4SYwFbrNsByshkbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8LXdSub; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731535726; x=1763071726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9stuSLhlEy++TW9cEOH6TRGd9dAPMRqgcaZYellQBU=;
  b=F8LXdSubse39+7Q7a6AH0pLrx5sL7gfwKKLuYuW1titbjGhb3ya7h8pq
   Tds6XKWIgKlsmPXpfBNhO3w4OUJUyJJIIthnwtfFCDIMyRA7RQIBqAQg2
   sV7QJg48ggU3mUy6Og4NjZrJlPknwyLa284IBTNGDX3+my39Eb1sZ06gQ
   JrcbuoW3JNPzq7NskOhtLa2j7h2/6szM/1aYIK7H1mYtJonKpI7nJg2xN
   cif4R1EM0ok1WutSnEpzD1KwQzLHv+B4nz5alxL1LV+xeskVe2PO3/NcR
   SRH55eOm3A+caeTamDvOKAXIrVL+xkCdRc0TmJHlZ9KHbJwJMinFUFOv5
   Q==;
X-CSE-ConnectionGUID: 3D4kD8HBRpGjAvGyTdc/fw==
X-CSE-MsgGUID: yiPCpPvWQnOz03hFQoYGbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42077997"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42077997"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:08:45 -0800
X-CSE-ConnectionGUID: xvrdLtP/T/uwTps2LQWlBA==
X-CSE-MsgGUID: En440rtUR9yjqqh0rkp2mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88397161"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2024 14:08:42 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBLXT-0000lf-1M;
	Wed, 13 Nov 2024 22:08:39 +0000
Date: Thu, 14 Nov 2024 06:08:09 +0800
From: kernel test robot <lkp@intel.com>
To: yongli-oc <yongli-oc@zhaoxin.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, yongli@zhaoxin.com,
	cobechen@zhaoxin.com, louisqi@zhaoxin.com, jiangbowang@zhaoxin.com
Subject: Re: [PATCH] Support lockref reference count if enable LOCK_STAT
Message-ID: <202411140548.NBssFC0E-lkp@intel.com>
References: <20241113085703.148839-1-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113085703.148839-1-yongli-oc@zhaoxin.com>

Hi yongli-oc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on akpm-mm/mm-nonmm-unstable linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yongli-oc/Support-lockref-reference-count-if-enable-LOCK_STAT/20241113-171348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241113085703.148839-1-yongli-oc%40zhaoxin.com
patch subject: [PATCH] Support lockref reference count if enable LOCK_STAT
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241114/202411140548.NBssFC0E-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140548.NBssFC0E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140548.NBssFC0E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/purgatory/purgatory.c:10:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:11:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:369:13: warning: taking address of packed member 'lock' of class or structure 'lockref::(anonymous union)::struct (anonymous at include/linux/lockref.h:39:3)' may result in an unaligned pointer value [-Waddress-of-packed-member]
     369 |         spin_lock(&dentry->d_lock);
         |                    ^~~~~~~~~~~~~~
   include/linux/dcache.h:371:15: warning: taking address of packed member 'lock' of class or structure 'lockref::(anonymous union)::struct (anonymous at include/linux/lockref.h:39:3)' may result in an unaligned pointer value [-Waddress-of-packed-member]
     371 |         spin_unlock(&dentry->d_lock);
         |                      ^~~~~~~~~~~~~~
   2 warnings generated.


vim +369 include/linux/dcache.h

d83c49f3e36cec Al Viro 2010-04-30  366  
d83c49f3e36cec Al Viro 2010-04-30  367  static inline void dont_mount(struct dentry *dentry)
d83c49f3e36cec Al Viro 2010-04-30  368  {
d83c49f3e36cec Al Viro 2010-04-30 @369  	spin_lock(&dentry->d_lock);
d83c49f3e36cec Al Viro 2010-04-30  370  	dentry->d_flags |= DCACHE_CANT_MOUNT;
d83c49f3e36cec Al Viro 2010-04-30  371  	spin_unlock(&dentry->d_lock);
d83c49f3e36cec Al Viro 2010-04-30  372  }
d83c49f3e36cec Al Viro 2010-04-30  373  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

