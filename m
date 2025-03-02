Return-Path: <linux-kernel+bounces-540688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B6A4B3BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA73D1891E02
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9B1EB187;
	Sun,  2 Mar 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9gDWLy0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F18322E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936029; cv=none; b=B/n6B7wfDz3yADf7lWvZaaa0RYPgylqjzwtBovsKp+h0nJ8e+Hql1QXTekIckpluQrwsLuqv5ovSRsJb0nc0cfAnNB60bJ1PhRFYHQ+aBcFbFn4nEwzR0+mYf0b1RiongdsE4AEY2acWCsF/Z1X8AnCYG3PrZ13hz/iK8rw8sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936029; c=relaxed/simple;
	bh=ZngZ0Ou/fnr6OvPe5mlLf/lYsuR34A6vTyTwNTnP1UA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZVNXoJi6nuVf1e2gZBRwEPTPKHgGX4kodpz+7y1CuE9kEvYYeWaD30yIrKhcSsT6BzFXi1qFO3ZnCXtj+471Bx90bKgVy62whXlivNRX0V6b9QJruNvdyraSsTfR6KR2lmfeN5/jTWjh48WjRJ+t8zjEqmJGhVljNEyoTa9pVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9gDWLy0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740936026; x=1772472026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZngZ0Ou/fnr6OvPe5mlLf/lYsuR34A6vTyTwNTnP1UA=;
  b=W9gDWLy0oqGWC9ZKm4VnHX2BbnDQHJM/ODbgKchlYroo6gFf+sKy+8Aw
   gM9cMys4nOdtKjuyHmXa8AGWMUgZYkmN2VUYucWe2hAbl6GQ4jIVjC9a3
   SbmvtFSji61GPPLtaYwJ+Ep+Mk2riiK3OErXFZ1GfVgwElQTyj6bvnQZL
   Lv5saaJWaGWunSCTkqiUBKyGpPz7WUG3eOOOh2YiQZNtR8HtYcYk1cWLq
   k7zly0GDY9OvTIJOyVI8GZxPqI23anWte87Z64rmxcWwQDfxuK/Z3KKgg
   u+DWvVMxtuqo1Vf35hJ7a6EKmYSyS+kpZrJYAwdgjWcGdoGUoZl7lIHf4
   g==;
X-CSE-ConnectionGUID: 4upSKGdOTFCa0QksVIrg+g==
X-CSE-MsgGUID: roaYmJpRS2egdmg9BZUXoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="44626299"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="44626299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 09:20:26 -0800
X-CSE-ConnectionGUID: jDtsdxTrSBO/VVteZE106w==
X-CSE-MsgGUID: MpZiLuGJRaW9S7DlSCqQ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121930311"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Mar 2025 09:20:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tomzH-000HTu-0F;
	Sun, 02 Mar 2025 17:20:23 +0000
Date: Mon, 3 Mar 2025 01:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for
 'arch_report_meminfo'
Message-ID: <202503030123.GrzZ1SpJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1973160c90d7886c523e52e1f56164e6a74f0474
commit: ef104443bffa004f631729dfc924f0b84abbd602 procfs: consolidate arch_report_meminfo declaration
date:   1 year, 10 months ago
config: parisc-randconfig-r016-20230411 (https://download.01.org/0day-ci/archive/20250303/202503030123.GrzZ1SpJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030123.GrzZ1SpJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030123.GrzZ1SpJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      65 | void arch_report_meminfo(struct seq_file *m)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/arch_report_meminfo +65 arch/parisc/kernel/pdt.c

c9c2877d08d9aa Helge Deller 2017-05-11  63  
c9c2877d08d9aa Helge Deller 2017-05-11  64  /* report PDT entries via /proc/meminfo */
c9c2877d08d9aa Helge Deller 2017-05-11 @65  void arch_report_meminfo(struct seq_file *m)
c9c2877d08d9aa Helge Deller 2017-05-11  66  {
c9c2877d08d9aa Helge Deller 2017-05-11  67  	if (pdt_type == PDT_NONE)
c9c2877d08d9aa Helge Deller 2017-05-11  68  		return;
c9c2877d08d9aa Helge Deller 2017-05-11  69  
c9c2877d08d9aa Helge Deller 2017-05-11  70  	seq_printf(m, "PDT_max_entries: %7lu\n",
c9c2877d08d9aa Helge Deller 2017-05-11  71  			pdt_status.pdt_size);
c9c2877d08d9aa Helge Deller 2017-05-11  72  	seq_printf(m, "PDT_cur_entries: %7lu\n",
c9c2877d08d9aa Helge Deller 2017-05-11  73  			pdt_status.pdt_entries);
c9c2877d08d9aa Helge Deller 2017-05-11  74  }
c9c2877d08d9aa Helge Deller 2017-05-11  75  

:::::: The code at line 65 was first introduced by commit
:::::: c9c2877d08d9aa0ca0a5c227ac795fbb76269300 parisc: Add Page Deallocation Table (PDT) support

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

