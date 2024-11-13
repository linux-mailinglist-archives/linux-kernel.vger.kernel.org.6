Return-Path: <linux-kernel+bounces-408380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE789C7E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114971F22AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285A18C02F;
	Wed, 13 Nov 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvRsqJ+Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222218BBAC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535726; cv=none; b=gob2CSdYDZieiBN4J9lQkFjv7hIJW4/Wo1nnWkfFsJj+qbyYvSFc/66+zT30ub2sfnCLRav152XCRaje3NMVbkQf5H56vZBhHmAP5o/l3RaOQC/pmr09hXhagrpyb+nfF6LMza6ASKkdLSgrkn3dcNd+IWWw2kgWryt+wGW9v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535726; c=relaxed/simple;
	bh=BLNlgUz50KcBCrTtdGjaR8KLlpRbyES7DUW6E7hxqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUDdQOvvoENS7ABxcsCVoxuXABbEpU1DyFY9Ea7stNDCjx509vUKplZsfI608dRsl3hnuPx2eZ1TrHvg1TOPJIZ74JCAMACBeotrRqtVjG5cgZ/272k3lZLa80uh2Shp8bjWla7i5pCxERIPWRzBzidVcczBbJaJAN1kFL/dUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvRsqJ+Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731535725; x=1763071725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLNlgUz50KcBCrTtdGjaR8KLlpRbyES7DUW6E7hxqs8=;
  b=RvRsqJ+Q5vuNTh03X4uUVgHwq4hG9+UjC3tT8N7NatcxEkF5nOzREhbG
   YfvCs+fXq7K2sNpmUT7VynVNprMuWb2GLApO1H5DoxsswwlcxHiFx/xyF
   gnW3ooiF8m7n/XFIb/cKiiNsPTl9uBJef7TJFFKopLmDVXFJN7MPkdCwY
   A0MGg9Xs1AOAtZkErhZ3BOn37JG0PHbkkoDlTpYHu7D2h5cznlKOhAJR4
   dEiIP8L8pcf2nJ40QKYhwjGhOOA6T91p5T3NEPku4jdYr1it4pGgji4Zj
   XpMqvAy8/xNHRHmOnzStcuPQX4S8d3O1ePZ2p0KYOQ6x+04PkMF0ROdqr
   Q==;
X-CSE-ConnectionGUID: hXe+pj3BSjypjCyxBkLYmg==
X-CSE-MsgGUID: 5XF8d7oWQvyNZj4OeHNCRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42077989"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42077989"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:08:44 -0800
X-CSE-ConnectionGUID: zMSnqkrYSuKIDpIn6+oTyQ==
X-CSE-MsgGUID: kFoKgqCzRJuJazuED1sLZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88397153"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2024 14:08:42 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBLXT-0000ld-1J;
	Wed, 13 Nov 2024 22:08:39 +0000
Date: Thu, 14 Nov 2024 06:08:09 +0800
From: kernel test robot <lkp@intel.com>
To: yongli-oc <yongli-oc@zhaoxin.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, yongli@zhaoxin.com, cobechen@zhaoxin.com,
	louisqi@zhaoxin.com, jiangbowang@zhaoxin.com
Subject: Re: [PATCH] Support lockref reference count if enable LOCK_STAT
Message-ID: <202411140553.K9M15p3F-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241114/202411140553.K9M15p3F-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140553.K9M15p3F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140553.K9M15p3F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/fs.h:8,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1120,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from include/linux/elfcore.h:11,
                    from include/linux/vmcore_info.h:6,
                    from include/linux/kexec.h:18,
                    from arch/s390/purgatory/purgatory.c:10:
   include/linux/dcache.h: In function 'dont_mount':
>> include/linux/dcache.h:369:19: warning: taking address of packed member of 'struct <anonymous>' may result in an unaligned pointer value [-Waddress-of-packed-member]
     369 |         spin_lock(&dentry->d_lock);
         |                   ^
   include/linux/dcache.h:371:21: warning: taking address of packed member of 'struct <anonymous>' may result in an unaligned pointer value [-Waddress-of-packed-member]
     371 |         spin_unlock(&dentry->d_lock);
         |                     ^


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

