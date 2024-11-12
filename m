Return-Path: <linux-kernel+bounces-405775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC39C56DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EF4284230
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECE2309A3;
	Tue, 12 Nov 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx6HBuuw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44066230999
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411830; cv=none; b=Gym+YPTebsEIQwHPxFmoN5QjW8u6U3/wCy4RMx9DXK7dXgOhIEZ3q/CBWhqjb/xZL1mcsnsZRC5n3eSPrd5i1Dx0PFlK6DSuMeWnYCyFxeDKPmOFkIETquyPxCSU8pnGnicQJm5O0AB6XwGUCodsV/W/zPwH9g2gw+KyUv5xKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411830; c=relaxed/simple;
	bh=PO4EqrQG8RsV0jjl15L5FZ6DGDHaLJ4T2Tt9UahcMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRNzqEZT8CXUiK2rUP3W4fVAzFe2uw1oH4J4xDDUIEPhYWp7vfyjHHRN1XvP5JUhuMDMm3HClfQFfuSHNbr4og1fIo1dH2Co57uAFFGC+ropju8yuXbn1gEfO6WOfRWi5gUbWkDf7fYSXPismMCzCCvWlI+jE8nhraEMCB++mv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx6HBuuw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731411829; x=1762947829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PO4EqrQG8RsV0jjl15L5FZ6DGDHaLJ4T2Tt9UahcMr0=;
  b=Cx6HBuuwMUsw8Kz+tPnCB7/mG6jevxWYcrv3paxRQJ/BMtSKJOq5IQlN
   fsZ6FyrgDZ0wL29d59a1ZeZ6LXQSYqZmCm2ds4YKvI71ifDYzHCXymzsF
   HgEMEfeKXAIXX5m0+ziSp6Y7W0OcV7x8s8UjwdMb7YNJ8qQjiB5F0YzvN
   KoN021rpMYOLgVb2dD40e6FC06IMY7aC1mottSoxcUeFC9t6DYAJxgCTk
   VylMxVuCM6pNGfmfmF7Ygq6LwoFypQCisxkcNWIWwzMTQLgTaFGHryPQS
   hqDO2/Hii91JitwSVIgM2EjPKSkjhw3ojgOF9GukokMCwbCMh3x9ypiuU
   Q==;
X-CSE-ConnectionGUID: 2KVENqOjSyytxx3/TGmnaQ==
X-CSE-MsgGUID: j9pbgaNfR2iks2nL3vdfhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34943595"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34943595"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 03:43:48 -0800
X-CSE-ConnectionGUID: JRXgTNxdSRqQi1bW9R5BFg==
X-CSE-MsgGUID: 93AprrR1TuSu8jYshNm7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="110705762"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2024 03:43:45 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tApJ8-0001Ev-1f;
	Tue, 12 Nov 2024 11:43:42 +0000
Date: Tue, 12 Nov 2024 19:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, chao@kernel.org,
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
Message-ID: <202411121928.BzWJRXSl-lkp@intel.com>
References: <20241112031513.528474-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112031513.528474-1-guochunhai@vivo.com>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-clean-up-the-cache-if-cached-decompression-is-disabled/20241112-105927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112031513.528474-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: clean up the cache if cached decompression is disabled
config: x86_64-randconfig-004-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121928.BzWJRXSl-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121928.BzWJRXSl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121928.BzWJRXSl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/erofs/super.c:10:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/erofs/super.c:749:20: error: no member named 'umount_mutex' in 'struct erofs_sb_info'
     749 |                 mutex_lock(&sbi->umount_mutex);
         |                             ~~~  ^
   include/linux/mutex.h:166:44: note: expanded from macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
>> fs/erofs/super.c:750:3: error: call to undeclared function 'z_erofs_shrink_scan'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     750 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^
   fs/erofs/super.c:751:22: error: no member named 'umount_mutex' in 'struct erofs_sb_info'
     751 |                 mutex_unlock(&sbi->umount_mutex);
         |                               ~~~  ^
   1 warning and 3 errors generated.


vim +749 fs/erofs/super.c

   731	
   732	static int erofs_fc_reconfigure(struct fs_context *fc)
   733	{
   734		struct super_block *sb = fc->root->d_sb;
   735		struct erofs_sb_info *sbi = EROFS_SB(sb);
   736		struct erofs_sb_info *new_sbi = fc->s_fs_info;
   737	
   738		DBG_BUGON(!sb_rdonly(sb));
   739	
   740		if (new_sbi->fsid || new_sbi->domain_id)
   741			erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
   742	
   743		if (test_opt(&new_sbi->opt, POSIX_ACL))
   744			fc->sb_flags |= SB_POSIXACL;
   745		else
   746			fc->sb_flags &= ~SB_POSIXACL;
   747	
   748		if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
 > 749			mutex_lock(&sbi->umount_mutex);
 > 750			z_erofs_shrink_scan(sbi, ~0UL);
   751			mutex_unlock(&sbi->umount_mutex);
   752		}
   753		sbi->opt = new_sbi->opt;
   754	
   755		fc->sb_flags |= SB_RDONLY;
   756		return 0;
   757	}
   758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

