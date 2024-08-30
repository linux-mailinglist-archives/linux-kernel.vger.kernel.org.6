Return-Path: <linux-kernel+bounces-307951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0096556F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9074E286D75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383913632B;
	Fri, 30 Aug 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnAfWtjg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046E4D8B1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724986610; cv=none; b=nf6sLFI0F4Ks2TsMKqw98YD1Nt/ox03zaC6nbBXHVoT8ZN7oMcULJyDTg3c15BqgwXh5EB75nw+0c8reu8ZRXLwe3zvrSvF6X2xh3m6BL5vpf/4wVgaptcbWfn6fPzEOKT2Kk3wSvZEEfNWPiU31wonixtcg7tfBrSzqxIcTjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724986610; c=relaxed/simple;
	bh=aQar/z5yi0IpojdwMgkqYFs3xDJDSY9fiPUMmksM4S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWTLe/vJAsw8oDGC0p84+xHiI6otIjU3fhLSKeTM1l2cEA8tBjdQ9YHRW7APR0zpGH4LSFYRLS3Umr1JlyGVtq+D77UEstqlAFdarzVRd5DBAt5k9eVxUzWA7QSTR6gy+qlfibfHgObYpJRjf6HdlbWOcoMaOsGgZfsNP+c5jBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnAfWtjg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724986610; x=1756522610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQar/z5yi0IpojdwMgkqYFs3xDJDSY9fiPUMmksM4S8=;
  b=mnAfWtjgs4BbQgdM2Hfn7xO0tkI/ErqcidJiqWVWHzAPNhWHNd/2oB+n
   xQreHx7njmlkrDo1Q0BH2vYrGq/uB7jl6Mx6prUpQd18TZL8Tz5DBVULA
   nVQUklgdTzAeFOFq2Qz7oGd09DycceNu4TWBLOv/sVPktXSC1yRmdIJsm
   dnWZfbDx6tgJ4+sPfO+qH2sHGs1yBR2a1wJM6GT9XYIGZiWv34nPR44d0
   GGnpdUOBj+4Uc8cRGX7ntCo0kcmBhioMDuueobJNE3PvyESHsOrP7e9lB
   xYnBaU4hVLHND3ZZ/y51K1crWItNOL1k6UV9PdII3MsZOUgnhf9/W0zFu
   A==;
X-CSE-ConnectionGUID: qShrqyXoQRSHfdh7lwFl7w==
X-CSE-MsgGUID: fPoK7FWkQq6noYZA5lXsdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27410988"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="27410988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:56:49 -0700
X-CSE-ConnectionGUID: Os+YLIpdR12mibT760u3Lw==
X-CSE-MsgGUID: xeBI/GFKQrWE7cs7NAiYMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="63957854"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Aug 2024 19:56:46 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjroa-0000vz-1n;
	Fri, 30 Aug 2024 02:56:44 +0000
Date: Fri, 30 Aug 2024 10:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Theodore Dubois <tblodt@icloud.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Theodore Dubois <tblodt@icloud.com>,
	Ryan Houdek <sonicadvance1@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	David Hildenbrand <david@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
Message-ID: <202408301005.IiGdSjk2-lkp@intel.com>
References: <20240827215930.24703-1-tblodt@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827215930.24703-1-tblodt@icloud.com>

Hi Theodore,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.11-rc5 next-20240829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Theodore-Dubois/prctl-allow-prctl_set_mm_exe_file-without-unmapping-old-exe/20240828-060019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20240827215930.24703-1-tblodt%40icloud.com
patch subject: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old exe
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240830/202408301005.IiGdSjk2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408301005.IiGdSjk2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408301005.IiGdSjk2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/fork.c: In function 'replace_mm_exe_file':
>> kernel/fork.c:1439:9: error: 'old_exe_file' undeclared (first use in this function); did you mean 'new_exe_file'?
    1439 |         old_exe_file = rcu_dereference_raw(mm->exe_file);
         |         ^~~~~~~~~~~~
         |         new_exe_file
   kernel/fork.c:1439:9: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/fork.c:1433:13: warning: unused variable 'ret' [-Wunused-variable]
    1433 |         int ret = 0;
         |             ^~~


vim +1439 kernel/fork.c

3864601387cf41 Jiri Slaby              2011-05-26  1421  
35d7bdc86031a2 David Hildenbrand       2021-04-23  1422  /**
35d7bdc86031a2 David Hildenbrand       2021-04-23  1423   * replace_mm_exe_file - replace a reference to the mm's executable file
ff0712ea71f173 Matthew Wilcox (Oracle  2023-08-24  1424)  * @mm: The mm to change.
ff0712ea71f173 Matthew Wilcox (Oracle  2023-08-24  1425)  * @new_exe_file: The new file to use.
35d7bdc86031a2 David Hildenbrand       2021-04-23  1426   *
a7031f14525751 Mateusz Guzik           2023-08-14  1427   * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
35d7bdc86031a2 David Hildenbrand       2021-04-23  1428   *
35d7bdc86031a2 David Hildenbrand       2021-04-23  1429   * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
35d7bdc86031a2 David Hildenbrand       2021-04-23  1430   */
35d7bdc86031a2 David Hildenbrand       2021-04-23  1431  int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
35d7bdc86031a2 David Hildenbrand       2021-04-23  1432  {
35d7bdc86031a2 David Hildenbrand       2021-04-23 @1433  	int ret = 0;
35d7bdc86031a2 David Hildenbrand       2021-04-23  1434  
35d7bdc86031a2 David Hildenbrand       2021-04-23  1435  	get_file(new_exe_file);
fe69d560b5bd9e David Hildenbrand       2021-04-23  1436  
a7031f14525751 Mateusz Guzik           2023-08-14  1437  	/* set the new file */
a7031f14525751 Mateusz Guzik           2023-08-14  1438  	mmap_write_lock(mm);
a7031f14525751 Mateusz Guzik           2023-08-14 @1439  	old_exe_file = rcu_dereference_raw(mm->exe_file);
a7031f14525751 Mateusz Guzik           2023-08-14  1440  	rcu_assign_pointer(mm->exe_file, new_exe_file);
a7031f14525751 Mateusz Guzik           2023-08-14  1441  	mmap_write_unlock(mm);
a7031f14525751 Mateusz Guzik           2023-08-14  1442  
2a010c41285345 Christian Brauner       2024-05-31  1443  	if (old_exe_file)
35d7bdc86031a2 David Hildenbrand       2021-04-23  1444  		fput(old_exe_file);
35d7bdc86031a2 David Hildenbrand       2021-04-23  1445  	return 0;
35d7bdc86031a2 David Hildenbrand       2021-04-23  1446  }
3864601387cf41 Jiri Slaby              2011-05-26  1447  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

