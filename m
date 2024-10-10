Return-Path: <linux-kernel+bounces-358737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E589982FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FAE281AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8C1BDA8C;
	Thu, 10 Oct 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ku7zG7Ch"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CD1BC9FE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554289; cv=none; b=jrTCFYryXPGP2Ypta7ixVgUdRl6gFhmRt3LT1XEFPsU4dmDVBWbZ4KcLq6AuAypOOZ0QBBkoDCM0j66JqAe7LEGqHqh1v0OMvIo1dmIzW58SLohU+kQQenDlvWikGr4xJWm6w2zk8uFi0VqocwVoekw8cLljl6vXFX0UHh+q+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554289; c=relaxed/simple;
	bh=NfhfZqu2Su0RgqD8cq5nEWdseA734/1rsCzpimrRzr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw3ybIahDgSD5iGIJLYKkLcToE5mwA9q6kZ6aOrC2XVP0zn+Lt7wbl34iKoz6UJaBwcrKEBcie9geZVK2raz+xnaSXkgZdcRf1lBcbgdT/7jNcYn4PLNwY7UK+ynbP7zt0IUKvSPdnArM9ece6h56B+zCbqQaGKZf4HXJHETFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ku7zG7Ch; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728554288; x=1760090288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NfhfZqu2Su0RgqD8cq5nEWdseA734/1rsCzpimrRzr8=;
  b=Ku7zG7ChR2UEV/7zGR/M/hNJwKCGkFImMDcgpmMkSAnxXP4pqkjE+ARQ
   +3Sd/BnpxbPadgzlDmX+T2i+nyBRmDAVIpR8QTqi8GS1RiCGrEmdPjy16
   ZUPYjLyJ+sqfVFIsv4zZrAGH7MmsBmIWvqhUGhFulev9Bc/MoZalmubiM
   fCbJxo27vNgXNrbfXi/6GYMT1qqTgQbSRZ8nwiYOLY/gYhX3ORp/pN7Ax
   LjY317YxzhZ8uNwHbHpih+OS8N8SatGhONOnvZQfh3sQi0yUtXAhluHNH
   y8Dr6bzCfKrBJqP7W7kN+XO8H04oljxxcwkpO6cEnuWe0mRCLVXRUDDgo
   w==;
X-CSE-ConnectionGUID: pyUTzTEPSKCK1r7gbpjAiw==
X-CSE-MsgGUID: mW8cPwyaTpOJe+UueueP4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31797866"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31797866"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:58:07 -0700
X-CSE-ConnectionGUID: N7yLUXyFTj2JAcgUg+ExFA==
X-CSE-MsgGUID: N+4A3YoOQVOSa5ysiTYLQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76742946"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 02:58:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sypvm-000Abe-1i;
	Thu, 10 Oct 2024 09:58:02 +0000
Date: Thu, 10 Oct 2024 17:57:50 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs3: Fix WARNING in ntfs_extend_initialized_size
Message-ID: <202410101748.6VtnyCOG-lkp@intel.com>
References: <tencent_EE134FDF8DFFA5E18D84121FDDE5DDB41907@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EE134FDF8DFFA5E18D84121FDDE5DDB41907@qq.com>

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.12-rc2 next-20241010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/ntfs3-Fix-WARNING-in-ntfs_extend_initialized_size/20241007-191224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/tencent_EE134FDF8DFFA5E18D84121FDDE5DDB41907%40qq.com
patch subject: [PATCH] ntfs3: Fix WARNING in ntfs_extend_initialized_size
config: i386-buildonly-randconfig-001-20241010 (https://download.01.org/0day-ci/archive/20241010/202410101748.6VtnyCOG-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101748.6VtnyCOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101748.6VtnyCOG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ntfs3/file.c:402:15: error: no member named 'valid' in 'struct ntfs_inode'
     402 |                 WARN_ON(ni->valid >= pos);
         |                         ~~  ^
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   1 error generated.


vim +402 fs/ntfs3/file.c

   379	
   380	static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
   381			       struct file *file)
   382	{
   383		struct ntfs_inode *ni = ntfs_i(inode);
   384		struct address_space *mapping = inode->i_mapping;
   385		loff_t end = pos + count;
   386		bool extend_init = file && pos > ni->i_valid;
   387		int err;
   388	
   389		if (end <= inode->i_size && !extend_init)
   390			return 0;
   391	
   392		/* Mark rw ntfs as dirty. It will be cleared at umount. */
   393		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
   394	
   395		if (end > inode->i_size) {
   396			err = ntfs_set_size(inode, end);
   397			if (err)
   398				goto out;
   399		}
   400	
   401		if (extend_init && !is_compressed(ni)) {
 > 402			WARN_ON(ni->valid >= pos);
   403			err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
   404			if (err)
   405				goto out;
   406		} else {
   407			err = 0;
   408		}
   409	
   410		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
   411		mark_inode_dirty(inode);
   412	
   413		if (IS_SYNC(inode)) {
   414			int err2;
   415	
   416			err = filemap_fdatawrite_range(mapping, pos, end - 1);
   417			err2 = sync_mapping_buffers(mapping);
   418			if (!err)
   419				err = err2;
   420			err2 = write_inode_now(inode, 1);
   421			if (!err)
   422				err = err2;
   423			if (!err)
   424				err = filemap_fdatawait_range(mapping, pos, end - 1);
   425		}
   426	
   427	out:
   428		return err;
   429	}
   430	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

