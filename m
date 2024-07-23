Return-Path: <linux-kernel+bounces-259597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D793992F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51531C219D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D313C832;
	Tue, 23 Jul 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuMNUO8j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154F13A24A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712747; cv=none; b=ufzTQrN/nN+PCr3Kgfej5exg2XU21mdqv9BbbxTQdd9CmBqFYQFQBUMHqZrN0uJWBvkPot2JBJZPhw2auozQpztGAxZlJvdD7iLf7cxlY5pcVwRDpi7GadLOcENvjX4kz++H+dRGmA2Q7bF7sUGqEZJPdYyjqEXBbDnu3IxVLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712747; c=relaxed/simple;
	bh=6/JLmxgow1q7F/M3XuCpeol6FrBvBdBp1nlD2GTUlWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OWJOI0I1J3MD3KmO1/ql/0QRo4dSYNBousDDT5bthPWFrA1d9fquhPOZkOVYdxMCbrxMcOte3Bp+k3bDXMvgnIqktN80hXANE3lre0VEVk09DRGLjkexwOEzMIWozE73K7iAk4rH4AbOI/z25rrmxLCBkcCB4eocOGRK++7YAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuMNUO8j; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721712745; x=1753248745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6/JLmxgow1q7F/M3XuCpeol6FrBvBdBp1nlD2GTUlWY=;
  b=JuMNUO8j4O0ThDkCpPzTH5Qzav/7sgNvIeURjeb9KIfbqtPA7zqw1jCt
   6f9FlFcoPPnUQ1elvhZOEE56BfhhK3g46+X9J8l70GCeoiUkZtju0xhJt
   wmqdFmRoNLcITievH0rxANi47g9lNhCXCs+m6fFG0hEWLVQSMzLisyQwu
   hqMe3XKHk91drRSxXNu7DZF4fShPgdEQWnzk/iac/aa1JdiIAos2vX2ap
   spmCJ1b3lyCfoSoO7kV0XczJ0Mo5hKrB4Zapg3MJxpvlmi6lW2/40KJTA
   6QPcmCaFBZQM2G97CAQistztgK9mGRHVKrlmggS/kDo6vIU/6DsYGILkU
   g==;
X-CSE-ConnectionGUID: l+dk+YiYS0i46Nbri+oTbQ==
X-CSE-MsgGUID: EWB0weyxSvq4R4db+Ai50g==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="23182478"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="23182478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 22:32:19 -0700
X-CSE-ConnectionGUID: n0ZTIB68Sf6iOil8NmhiDg==
X-CSE-MsgGUID: BFdLjrpnS0K2+L/F5ySH+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="52349296"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Jul 2024 22:32:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW88F-000lfy-1E;
	Tue, 23 Jul 2024 05:32:15 +0000
Date: Tue, 23 Jul 2024 13:32:02 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8:
 unreachable instruction
Message-ID: <202407231331.vNHHJPnu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   66ebbdfdeb093e097399b1883390079cd4c3022b
commit: eb1fa9ab470285d39bee268bc2a90d1786610711 btrfs: make insert_inline_extent() accept one page directly
date:   3 months ago
config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407231331.vNHHJPnu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_del_delalloc_inode+0xb0: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_set_delalloc_extent+0x18c: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_evict_inode+0x9c: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_get_extent+0x3d0: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_set_range_writeback+0x7c: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: compress_file_range+0x388: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: cow_file_range+0x128: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_finish_one_ordered+0x174: unreachable instruction
   fs/btrfs/inode.o: warning: objtool: btrfs_invalidate_folio+0x1b8: unreachable instruction


objdump-func vmlinux.o insert_inline_extent:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

