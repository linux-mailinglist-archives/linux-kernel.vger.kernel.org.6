Return-Path: <linux-kernel+bounces-359037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA339986A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29882813AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E61C689F;
	Thu, 10 Oct 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrQFwCiQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12041C7B68
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564736; cv=none; b=CX/MtGDdwczRYMmR3RbqtDIPB0+eCbaCvjdVMdbrTsJWmIUsVwLU6BIMxa8ofGKQFZGrMPl5kd3ZskwqpxOBh/Q++5LUIC4+jvxg9yZmuAHJp8HJxnM4h1FqJfacG+Dvm2UslC29STj4qrTO2uF5JesDhxcfLVJm9hx9xk7PFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564736; c=relaxed/simple;
	bh=OWW31GL+prw9JjHftIiHStrX0S42nNFeYgoHhk2i+vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuQ/o30hEwnftfi4i5FaiuQhYfLfO2OqCCgm5e8qgC20hvbUMaMDv089ovEcWpSGL5z/EBAUz4icBdzWrxBH2G8mqS3G0yLxZ/Ulom+USwtv7TD9lYh5G/2EYvedavID2uS1R5f7CryB8y7KM6sVA9ATrgLk2lFrX/I3mYf9fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrQFwCiQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728564735; x=1760100735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWW31GL+prw9JjHftIiHStrX0S42nNFeYgoHhk2i+vI=;
  b=UrQFwCiQzWq6TeQOHiGOHAyltZgz3TmwapzuKsAOSNhnl7yiadyKTnrS
   GBn/3gAUK1S2Rd7jN/s7rcv5iUkBiXb/+txHigIz2GGEBQuo7GycLhw8Q
   N3B5GODkIVAHHR9w70AGonpgqZJI9pMEmV0CBTASZwUq67afGzWhCl0Br
   3/6fAetsLRZ3xeR09Lgw/BQdvTeOW+Ypb0e9x0ncspwppXrsJTFs8HmFf
   KGkjVLk/D+NpVxUA5kSly3gfQ64vicrB8AIDxSDODSOOKmJef2OJrlzKm
   r/vGtmwcP1IH8kLXR485YDZHOIknmhNPvRUoR1TP1/+ZCUOH1dJLDo3I+
   Q==;
X-CSE-ConnectionGUID: 98FMbtruQfulvML7m95ovQ==
X-CSE-MsgGUID: 9pVDuwCmQDKAXLo/v03hsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27389352"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27389352"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:52:14 -0700
X-CSE-ConnectionGUID: XyoHadmPQHqZ8Op9r+OaMw==
X-CSE-MsgGUID: ayORUROpT3eXjEsJfskqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="99917176"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2024 05:52:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syseH-000AlL-2t;
	Thu, 10 Oct 2024 12:52:09 +0000
Date: Thu, 10 Oct 2024 20:52:03 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs3: Fix WARNING in ntfs_extend_initialized_size
Message-ID: <202410102052.KIxxilgH-lkp@intel.com>
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
config: i386-randconfig-003-20241010 (https://download.01.org/0day-ci/archive/20241010/202410102052.KIxxilgH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410102052.KIxxilgH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410102052.KIxxilgH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/spinlock.h:60,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/backing-dev.h:13,
                    from fs/ntfs3/file.c:10:
   fs/ntfs3/file.c: In function 'ntfs_extend':
>> fs/ntfs3/file.c:402:29: error: 'struct ntfs_inode' has no member named 'valid'; did you mean 'i_valid'?
     402 |                 WARN_ON(ni->valid >= pos);
         |                             ^~~~~
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~


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

