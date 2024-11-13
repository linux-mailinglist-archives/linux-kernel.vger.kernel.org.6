Return-Path: <linux-kernel+bounces-408050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD99C7998
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B66E283C58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B202003CF;
	Wed, 13 Nov 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWacmP6q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06D16190C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517627; cv=none; b=C9ZgOJbJ4m8VA+QkaIGCot2A9mApTtjfg1yyhER4h3BCjyhJbNZhbODej6DVDni7QeIJuwFPb9YWuLFaX+fixiSo234JWrgjcV0l82t1p2CrpyOpBhGnSVFovcPCgvJmEcAN3VPKKl3zhn+lJ0jWdXZWBgaInlJ045y6ag1t5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517627; c=relaxed/simple;
	bh=KUtgGXM7Nx7TD+ujpP03MUbGBKhv1vaZgHBC+W193BY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lutB5XukX1S6DBNQdeLaKPhmVwT2S8KZBjlbDQ9vAAuCG+vU+MQb/i5KoMPvFtQPiIigGtqPwv6ZW0IhczN2e+q+RV+hie0K5KmdwIYuFMq+FwsUKhZnBQAXt/FRXsbzeyo8Ou2VzdSsQ+aNoasEWShfN+8SaYbxJd3I3IupF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWacmP6q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731517626; x=1763053626;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KUtgGXM7Nx7TD+ujpP03MUbGBKhv1vaZgHBC+W193BY=;
  b=XWacmP6qEGypFnimaBWMGTr+2oMJIfgiKvJnoyGsYJKqKIfdGit8qe9+
   u6xtpqRPOovcS+cJx+0ICNBbETjiTMDKUcnrWSnYYI1cC+BSX5WiJ/Q/z
   abtj8CM3HZ7F51qaMPA91YrtjeD89sO42gjHvq6DfcgHlTc7v0zhEZOOw
   TQYvd2PgbcpvxQchLrtVy04XFCfW0AdGlWTAXhahPsJBMkv5dzS4jfkF3
   76EHulYi1LxXkktwSqYe34lo0T/vrRoDL2Z19jzjR+2j9z7+0LTbMFY7T
   HJF9V94m1EKPWjlcMAgK9OXAfnukvb6z6PL0mBQO6XppHCw6NBL4JYK3x
   A==;
X-CSE-ConnectionGUID: AcMjAticRpeekzuaxVDHig==
X-CSE-MsgGUID: UpOSTiQ4TSmlUACuCTZ8/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31386969"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31386969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 09:07:03 -0800
X-CSE-ConnectionGUID: 4A0kKNEGR3+3x7j9kn2oxw==
X-CSE-MsgGUID: ARzdSNAGSqmY0e4nv+xMrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="88094058"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Nov 2024 09:07:02 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBGpX-0000Zl-0C;
	Wed, 13 Nov 2024 17:06:59 +0000
Date: Thu, 14 Nov 2024 01:06:42 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Xi <xiqi2@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/proc/vmcore.c:424:19: warning: 'mmap_vmcore_fault' defined but
 not used
Message-ID: <202411140156.2o0nS4fl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1b785f4c7870c42330b35522c2514e39a1e28e7
commit: b8ee299855f08539e04d6c1a6acb3dc9e5423c00 fs/proc: fix compile warning about variable 'vmcore_mmap_ops'
date:   6 days ago
config: riscv-randconfig-r071-20241113 (https://download.01.org/0day-ci/archive/20241114/202411140156.2o0nS4fl-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140156.2o0nS4fl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140156.2o0nS4fl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/proc/vmcore.c:424:19: warning: 'mmap_vmcore_fault' defined but not used [-Wunused-function]
     424 | static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
         |                   ^~~~~~~~~~~~~~~~~


vim +/mmap_vmcore_fault +424 fs/proc/vmcore.c

9cb218131de1c59 Michael Holzheu         2013-09-11  416  
9cb218131de1c59 Michael Holzheu         2013-09-11  417  /*
9cb218131de1c59 Michael Holzheu         2013-09-11  418   * The vmcore fault handler uses the page cache and fills data using the
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  419)  * standard __read_vmcore() function.
9cb218131de1c59 Michael Holzheu         2013-09-11  420   *
9cb218131de1c59 Michael Holzheu         2013-09-11  421   * On s390 the fault handler is used for memory regions that can't be mapped
9cb218131de1c59 Michael Holzheu         2013-09-11  422   * directly with remap_pfn_range().
9cb218131de1c59 Michael Holzheu         2013-09-11  423   */
36f062042b0fd9f Souptick Joarder        2018-08-21 @424  static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
9cb218131de1c59 Michael Holzheu         2013-09-11  425  {
9cb218131de1c59 Michael Holzheu         2013-09-11  426  #ifdef CONFIG_S390
11bac80004499ea Dave Jiang              2017-02-24  427  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
9cb218131de1c59 Michael Holzheu         2013-09-11  428  	pgoff_t index = vmf->pgoff;
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  429) 	struct iov_iter iter;
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  430) 	struct kvec kvec;
9cb218131de1c59 Michael Holzheu         2013-09-11  431  	struct page *page;
9cb218131de1c59 Michael Holzheu         2013-09-11  432  	loff_t offset;
9cb218131de1c59 Michael Holzheu         2013-09-11  433  	int rc;
9cb218131de1c59 Michael Holzheu         2013-09-11  434  
9cb218131de1c59 Michael Holzheu         2013-09-11  435  	page = find_or_create_page(mapping, index, GFP_KERNEL);
9cb218131de1c59 Michael Holzheu         2013-09-11  436  	if (!page)
9cb218131de1c59 Michael Holzheu         2013-09-11  437  		return VM_FAULT_OOM;
9cb218131de1c59 Michael Holzheu         2013-09-11  438  	if (!PageUptodate(page)) {
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  439  		offset = (loff_t) index << PAGE_SHIFT;
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  440) 		kvec.iov_base = page_address(page);
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  441) 		kvec.iov_len = PAGE_SIZE;
de4eda9de2d957e Al Viro                 2022-09-15  442  		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  443) 
4a22fd20379ca89 Matthew Wilcox (Oracle  2022-04-29  444) 		rc = __read_vmcore(&iter, &offset);
9cb218131de1c59 Michael Holzheu         2013-09-11  445  		if (rc < 0) {
9cb218131de1c59 Michael Holzheu         2013-09-11  446  			unlock_page(page);
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  447  			put_page(page);
b5c212374c85353 Souptick Joarder        2018-10-30  448  			return vmf_error(rc);
9cb218131de1c59 Michael Holzheu         2013-09-11  449  		}
9cb218131de1c59 Michael Holzheu         2013-09-11  450  		SetPageUptodate(page);
9cb218131de1c59 Michael Holzheu         2013-09-11  451  	}
9cb218131de1c59 Michael Holzheu         2013-09-11  452  	unlock_page(page);
9cb218131de1c59 Michael Holzheu         2013-09-11  453  	vmf->page = page;
9cb218131de1c59 Michael Holzheu         2013-09-11  454  	return 0;
9cb218131de1c59 Michael Holzheu         2013-09-11  455  #else
9cb218131de1c59 Michael Holzheu         2013-09-11  456  	return VM_FAULT_SIGBUS;
9cb218131de1c59 Michael Holzheu         2013-09-11  457  #endif
9cb218131de1c59 Michael Holzheu         2013-09-11  458  }
9cb218131de1c59 Michael Holzheu         2013-09-11  459  

:::::: The code at line 424 was first introduced by commit
:::::: 36f062042b0fd9f8e41b97a472f52139886ca26f fs/proc/vmcore.c: use new typedef vm_fault_t

:::::: TO: Souptick Joarder <jrdr.linux@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

