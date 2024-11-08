Return-Path: <linux-kernel+bounces-401849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328EF9C201E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E307328444F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864E1F6664;
	Fri,  8 Nov 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elVSOBfn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394261F5831
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078732; cv=none; b=Tn1tV3bIGqy54sFItCWNx8zfQI2B3eDN/bU1mriM0pUWnwSybaLX+qqIxg899cmZcYBksoxVRVxKzwCtTRq3Ko5Ne/GgBpGWgZ6pmAL+k+CNCOQaeiZ68hOA1iJlktMLGKI0pUW/wyhn/0Qmm1q52BHrmSiJTVLw9l+oDIXq/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078732; c=relaxed/simple;
	bh=TuEytQDdNj6xfl9UatFE2MgXYhmuhMDA4DXyqTyrfd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR47tePh6avXW0A/mLOdhWCTUilp8f3FV8yz6PbGRp9TVXhfUlQy7fbHiQhiakL3NBhDq5+zThIsO3DIU4cndQgFJKFb8GJjA3WQiiH425VSsr9cBQIYU0ItPyPH98zaIGbqsDvvSOPPvEr6sI+rfkJmN/qHMXzO973KkG7CKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elVSOBfn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731078731; x=1762614731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TuEytQDdNj6xfl9UatFE2MgXYhmuhMDA4DXyqTyrfd4=;
  b=elVSOBfn3/iOWOf2oFRZuBaN/CvTgrPljCIGn7zmn8nZskvC11/MrOPL
   je4AC39kXAbS/8riZmm7omZBH85db2CHDQ/WUh8ahqP8WCzAgYLi9YZcM
   ksy0lS9sQTS0i7GUuean0E4E1+ANGqZ5dSU4DRaAzaTQHoPHAHKXnfT0M
   EE9L1I2/F6LbeVRAyuiKVh8BZg2fS+wYWssud0qnU4u+qXw1G8Zx8DBGq
   CAP3qzQo//N+cZjeQI4xHRvHT4HuEZfhLYxjXb5dwp5Qvp8RrjyTbbCIB
   WWiw1XQgym2s/LtJtV9LqQ/v6xCN0p+v9iYrSKqDtzOfpldGfaedEDzi6
   A==;
X-CSE-ConnectionGUID: mOmrwoQ5QbiHYt5cZdorEg==
X-CSE-MsgGUID: KXkIjxxEQwWfEkBdEjZlEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34654597"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34654597"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:12:11 -0800
X-CSE-ConnectionGUID: /pVdO/c7QOiocUGakrz0HQ==
X-CSE-MsgGUID: 7ViBaoPjTfCsCv77eB6l/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90452895"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Nov 2024 07:12:08 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9Qeb-000rXE-1Y;
	Fri, 08 Nov 2024 15:12:05 +0000
Date: Fri, 8 Nov 2024 23:11:16 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, david@redhat.com,
	wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	ioworker0@gmail.com, da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: shmem: change shmem_huge_global_enabled() to
 return huge order bitmap
Message-ID: <202411082236.7mwWSsNe-lkp@intel.com>
References: <a0d41cdc3491878260277e8c18a3e71deb2bc1fb.1731038280.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d41cdc3491878260277e8c18a3e71deb2bc1fb.1731038280.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20241108]
[cannot apply to linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-factor-out-the-order-calculation-into-a-new-helper/20241108-121545
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a0d41cdc3491878260277e8c18a3e71deb2bc1fb.1731038280.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH 2/4] mm: shmem: change shmem_huge_global_enabled() to return huge order bitmap
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20241108/202411082236.7mwWSsNe-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411082236.7mwWSsNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411082236.7mwWSsNe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:777:21: warning: 'shmem_huge_global_enabled' defined but not used [-Wunused-function]
     777 | static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/shmem_huge_global_enabled +777 mm/shmem.c

   776	
 > 777	static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
   778						      loff_t write_end, bool shmem_huge_force,
   779						      unsigned long vm_flags)
   780	{
   781		return 0;
   782	}
   783	#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
   784	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

