Return-Path: <linux-kernel+bounces-423581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0779DA9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C83B21887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCA1FF7AC;
	Wed, 27 Nov 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW0OiRON"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8C1FECCB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718254; cv=none; b=YIqKeKVFTc5+nwIKun5Ihw6rBQ/wwOwpmEEyopy/CMPUGD4CyT4xCG9971frHY/BSpbDqWwEy/ELi6L95FMTo+y9xmbMApPMBoM+g4NYMA6/vRclR382WUxuoFYJx+Z2cc8+hL7PSUVmNDuKKhp8TWbnTg6IorM+4Vz7rVLtVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718254; c=relaxed/simple;
	bh=idDdijuSl6TpC7xZI34FqxTidsAYrtNZu4a2lFJHarU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hwNWEmIDLow9Yz1kD04VgUeMKnhFXK6xQRDQHKNCTjlq8CwIl15LSP+l8v/nw6ikPqoon5Lt5sGwhCovMTbsiNhPTz32vR/BVq6kkC1Q7zIII+PhF4A7ocuj+kF5wVSyx1stDaiMWEkxBqGBAjBEYFP/n/0XIwjmsPR4SO6/gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW0OiRON; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732718251; x=1764254251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=idDdijuSl6TpC7xZI34FqxTidsAYrtNZu4a2lFJHarU=;
  b=JW0OiRONAU8unph4dOCcrqaW6ksoa5a8cJ7ZSeCKGySEFAC6DZlyut0m
   +B+uthKnsVx+QckM/vObOu30t8oiFaM2zRiYtD9jk6Or5XMcJvfDQPLd2
   YXnQgcyUtlZg6wdtKjUCH/xIWWcw4bcW40GQXrrfrrO+nvPoG8nd3l1Xi
   f/eCxbRSeiLZ1WcHlevMO5sDrzZGgw06Hodz/No3ILmlsnVbirFSkvN1f
   PGKbA89KGzDTJlDAf3mJkd0p7ExwalrHqHB+zSyghevpqj87s2H3iISIN
   cIjcPNWZC0QyPW3/ceE6HWhj09FUKOm7KWS3K8fVfDjaA9vF4CUvaZ82/
   A==;
X-CSE-ConnectionGUID: 0w2I5bqoRBKTF2eomAgQoA==
X-CSE-MsgGUID: CsKI1dyMRVyhymlEAnaP9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32779688"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="32779688"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 06:37:30 -0800
X-CSE-ConnectionGUID: +Quh8qs+SpKsQpfVD4VsRg==
X-CSE-MsgGUID: 33DvVVl6QECqr3k2MVpS4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="96906019"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Nov 2024 06:37:28 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGJAU-000843-0c;
	Wed, 27 Nov 2024 14:37:26 +0000
Date: Wed, 27 Nov 2024 22:36:49 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: arch/s390/kernel/guarded_storage.c:109:1: sparse: sparse: Using
 plain integer as NULL pointer
Message-ID: <202411272233.Dh4B5mNx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aaf20f870da056752f6386693cc0d8e25421ef35
commit: aa0d6e70d3b34e710a6a57a53a3096cb2e0ea99f s390: autogenerate compat syscall wrappers
date:   6 years ago
config: s390-randconfig-r133-20241121 (https://download.01.org/0day-ci/archive/20241127/202411272233.Dh4B5mNx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241127/202411272233.Dh4B5mNx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411272233.Dh4B5mNx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/s390/kernel/guarded_storage.c:109:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/guarded_storage.c:109:1: sparse: sparse: Using plain integer as NULL pointer
--
>> arch/s390/kernel/sthyi.c:490:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/sthyi.c:490:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/sthyi.c:490:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/sthyi.c:490:1: sparse: sparse: Using plain integer as NULL pointer
--
>> arch/s390/pci/pci_mmio.c:35:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/pci/pci_mmio.c:35:1: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/pci/pci_mmio.c:75:1: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/pci/pci_mmio.c:75:1: sparse: sparse: Using plain integer as NULL pointer
--
   drivers/char/random.c:418:19: sparse: sparse: symbol 'primary_crng' was not declared. Should it be static?
>> drivers/char/random.c:2040:1: sparse: sparse: Using plain integer as NULL pointer
>> drivers/char/random.c:2040:1: sparse: sparse: Using plain integer as NULL pointer
   drivers/char/random.c:2256:9: sparse: sparse: context imbalance in 'get_random_u64' - different lock contexts for basic block
   drivers/char/random.c:2286:9: sparse: sparse: context imbalance in 'get_random_u32' - different lock contexts for basic block
--
   fs/read_write.c:335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:481:9: sparse: sparse: symbol '__vfs_write' was not declared. Should it be static?
   fs/read_write.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:607:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:607:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:633:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:633:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:659:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:659:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1100:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1100:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1106:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1106:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1112:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1112:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1120:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1120:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/read_write.c:1120:1: sparse: sparse: cast to restricted __kernel_rwf_t
   fs/read_write.c:1132:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1132:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1140:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1140:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1140:1: sparse: sparse: cast to restricted __kernel_rwf_t
   fs/read_write.c:1192:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1192:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1227:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1227:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1245:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1245:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1298:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1298:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1333:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1333:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1351:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1351:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1464:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1464:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1483:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1483:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1501:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1501:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1521:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1521:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1627:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1627:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1627:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:1627:1: sparse: sparse: Using plain integer as NULL pointer
   fs/read_write.c:315:36: sparse: sparse: self-comparison always evaluates to false
--
>> fs/pipe.c:845:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/pipe.c:845:1: sparse: sparse: Using plain integer as NULL pointer
   fs/pipe.c:850:1: sparse: sparse: Using plain integer as NULL pointer
   fs/pipe.c:850:1: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/namei.c:3786:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/namei.c:3786:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3792:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3792:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3848:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3848:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3853:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3853:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3956:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:3956:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4096:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4096:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4107:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4107:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4164:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4164:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4164:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4164:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4170:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4170:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4170:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4170:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4329:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4329:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4329:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4329:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4335:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4658:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4658:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4658:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4658:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4664:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4664:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4664:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4664:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4670:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4670:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4670:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c:4670:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namei.c: note: in included file (through include/linux/srcu.h, include/linux/notifier.h, include/linux/memory_hotplug.h, ...):
   include/linux/rcupdate.h:660:9: sparse: sparse: context imbalance in 'terminate_walk' - unexpected unlock
   include/linux/rcupdate.h:660:9: sparse: sparse: context imbalance in 'unlazy_walk' - unexpected unlock
   include/linux/rcupdate.h:660:9: sparse: sparse: context imbalance in 'unlazy_child' - unexpected unlock
   include/linux/rcupdate.h:660:9: sparse: sparse: context imbalance in 'pick_link' - unexpected unlock
   fs/namei.c:2172:19: sparse: sparse: context imbalance in 'path_init' - wrong count at exit
--
>> fs/namespace.c:1667:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/namespace.c:1667:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:1677:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:1677:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:1691:22: sparse: sparse: symbol 'to_mnt_ns' was not declared. Should it be static?
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3074:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3130:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3130:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3130:1: sparse: sparse: Using plain integer as NULL pointer
   fs/namespace.c:3130:1: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/xattr.c:480:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:487:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:494:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:494:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:494:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:494:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:574:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:580:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:586:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:650:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:650:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:650:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:650:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:656:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:656:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:656:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:656:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:662:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:662:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:715:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:715:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:715:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:715:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:721:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:721:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:721:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:721:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:727:1: sparse: sparse: Using plain integer as NULL pointer
   fs/xattr.c:727:1: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/d_path.c:424:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/d_path.c:424:1: sparse: sparse: Using plain integer as NULL pointer
   fs/d_path.c:153:9: sparse: sparse: context imbalance in 'prepend_path' - wrong count at exit
   fs/d_path.c:366:23: sparse: sparse: context imbalance in '__dentry_path' - different lock contexts for basic block
--
>> ipc/syscall.c:110:1: sparse: sparse: Using plain integer as NULL pointer
>> ipc/syscall.c:110:1: sparse: sparse: Using plain integer as NULL pointer
--
   kernel/fork.c:1470:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1470:9: sparse:    struct sighand_struct [noderef] __rcu *
   kernel/fork.c:1470:9: sparse:    struct sighand_struct *
>> kernel/fork.c:1599:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/fork.c:1599:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/fork.c:2024:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2024:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2024:32: sparse:     got struct task_struct *
   kernel/fork.c:2076:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2076:54: sparse:     expected struct list_head *head
   kernel/fork.c:2076:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2317:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/fork.c:2317:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/fork.c:2317:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/fork.c:2317:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/fork.c:2362:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2362:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2362:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:1778:27: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1778:27: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1780:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/linux/ftrace.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:211:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:211:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:211:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:211:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:211:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:211:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2074:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2075:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2154:9: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2154:9: sparse: sparse: dereference of noderef expression
--
>> kernel/capability.c:150:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/capability.c:150:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/capability.c:150:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/capability.c:150:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/capability.c:224:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/capability.c:224:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/capability.c:224:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/capability.c:224:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/capability.c:197:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:197:43: sparse:     expected void const *from
   kernel/capability.c:197:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:174:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:175:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:248:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:248:29: sparse:     expected void *to
   kernel/capability.c:248:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:252:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:253:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:254:43: sparse: sparse: dereference of noderef expression
--
>> kernel/reboot.c:308:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/reboot.c:308:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/groups.c:153:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/groups.c:153:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/groups.c:190:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/groups.c:190:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/uid16.c:23:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/uid16.c:23:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:28:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:28:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:64:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:87:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:154:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:154:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:177:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/uid16.c:177:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/kexec_file.c:319:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/kexec_file.c:319:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/rseq.c:308:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/rseq.c:308:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/bpf/syscall.c:2580:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/bpf/syscall.c:2580:1: sparse: sparse: Using plain integer as NULL pointer
--
>> mm/mincore.c:156:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/mincore.c:156:1: sparse: sparse: Using plain integer as NULL pointer
--
>> mm/swapfile.c:2510:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/swapfile.c:2510:1: sparse: sparse: Using plain integer as NULL pointer
   mm/swapfile.c:3090:1: sparse: sparse: Using plain integer as NULL pointer
   mm/swapfile.c:3090:1: sparse: sparse: Using plain integer as NULL pointer
   mm/swapfile.c:441:35: sparse: sparse: context imbalance in 'swap_do_scheduled_discard' - different lock contexts for basic block
   mm/swapfile.c:612:23: sparse: sparse: context imbalance in 'scan_swap_map_try_ssd_cluster' - different lock contexts for basic block
   mm/swapfile.c:856:20: sparse: sparse: context imbalance in 'scan_swap_map_slots' - unexpected unlock
   mm/swapfile.c:938:23: sparse: sparse: context imbalance in 'swap_free_cluster' - different lock contexts for basic block
   mm/swapfile.c:1121:9: sparse: sparse: context imbalance in 'swap_info_get' - wrong count at exit
   mm/swapfile.c:1133:36: sparse: sparse: context imbalance in 'swap_info_get_cont' - unexpected unlock
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in '__swap_entry_free' - different lock contexts for basic block
   mm/swapfile.c:1203:23: sparse: sparse: context imbalance in 'swap_entry_free' - different lock contexts for basic block
   mm/swapfile.c:1260:34: sparse: sparse: context imbalance in 'put_swap_page' - different lock contexts for basic block
   mm/swapfile.c:1321:28: sparse: sparse: context imbalance in 'swapcache_free_entries' - unexpected unlock
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in 'page_swapcount' - different lock contexts for basic block
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in 'swap_swapcount' - different lock contexts for basic block
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in 'swp_swapcount' - different lock contexts for basic block
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in 'swap_page_trans_huge_swapped' - different lock contexts for basic block
   mm/swapfile.c:1570:44: sparse: sparse: context imbalance in 'reuse_swap_page' - unexpected unlock
   mm/swapfile.c:337:9: sparse: sparse: context imbalance in '__swap_duplicate' - different lock contexts for basic block
   mm/swapfile.c:3603:23: sparse: sparse: context imbalance in 'add_swap_count_continuation' - unexpected unlock
--
>> mm/memfd.c:247:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/memfd.c:247:1: sparse: sparse: Using plain integer as NULL pointer
--
>> net/socket.c:1455:1: sparse: sparse: Using plain integer as NULL pointer
>> net/socket.c:1455:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1492:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1492:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1622:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1622:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1622:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1622:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1628:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1628:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1628:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1628:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1672:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1672:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1710:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1710:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1710:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1710:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1746:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1746:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1746:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1746:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1796:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1796:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1796:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1796:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1807:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1807:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1859:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1870:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1870:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1910:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1910:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1947:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1947:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1947:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:1947:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2161:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2161:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2237:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2237:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2334:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2334:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2486:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2486:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2486:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2486:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2497:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2497:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2497:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2497:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2528:1: sparse: sparse: Using plain integer as NULL pointer
   net/socket.c:2528:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/printk/printk.c:1564:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/printk/printk.c:1564:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/printk/printk.c:2875:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __percpu *__p @@     got int * @@
   kernel/printk/printk.c:2875:23: sparse:     expected int [noderef] __percpu *__p
   kernel/printk/printk.c:2875:23: sparse:     got int *
   kernel/printk/printk.c:2875:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __percpu *__p @@     got int * @@
   kernel/printk/printk.c:2875:23: sparse:     expected int [noderef] __percpu *__p
   kernel/printk/printk.c:2875:23: sparse:     got int *
   kernel/printk/printk.c:2875:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __percpu *__p @@     got int * @@
   kernel/printk/printk.c:2875:23: sparse:     expected int [noderef] __percpu *__p
   kernel/printk/printk.c:2875:23: sparse:     got int *
   kernel/printk/printk.c:2875:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __percpu *__p @@     got int * @@
   kernel/printk/printk.c:2875:23: sparse:     expected int [noderef] __percpu *__p
   kernel/printk/printk.c:2875:23: sparse:     got int *
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
   kernel/printk/printk.c:2875:23: sparse: sparse: dereference of noderef expression
--
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
>> security/keys/keyctl.c:61:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:157:1: sparse: sparse: Using plain integer as NULL pointer
   security/keys/keyctl.c:1516:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct key [noderef] __rcu *session_keyring @@     got struct key * @@
   security/keys/keyctl.c:1516:31: sparse:     expected struct key [noderef] __rcu *session_keyring
   security/keys/keyctl.c:1516:31: sparse:     got struct key *
   security/keys/keyctl.c:1526:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   security/keys/keyctl.c:1526:16: sparse:     expected struct task_struct *parent
   security/keys/keyctl.c:1526:16: sparse:     got struct task_struct [noderef] __rcu *real_parent
   security/keys/keyctl.c:1558:27: sparse: sparse: dereference of noderef expression
   security/keys/keyctl.c:1558:27: sparse: sparse: dereference of noderef expression
   security/keys/keyctl.c:1559:27: sparse: sparse: dereference of noderef expression
   security/keys/keyctl.c:1559:27: sparse: sparse: dereference of noderef expression
   security/keys/keyctl.c:1754:43: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct keyctl_pkey_query [noderef] __user * @@     got struct keyctl_pkey_query * @@
   security/keys/keyctl.c:1754:43: sparse:     expected struct keyctl_pkey_query [noderef] __user *
   security/keys/keyctl.c:1754:43: sparse:     got struct keyctl_pkey_query *
--
   fs/notify/inotify/inotify_user.c:544:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *conn @@     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks @@
   fs/notify/inotify/inotify_user.c:544:51: sparse:     expected struct fsnotify_mark_connector *conn
   fs/notify/inotify/inotify_user.c:544:51: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks
>> fs/notify/inotify/inotify_user.c:696:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/notify/inotify/inotify_user.c:696:1: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/quota/quota.c:890:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/quota/quota.c:890:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/quota/quota.c:890:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/quota/quota.c:890:1: sparse: sparse: Using plain integer as NULL pointer

vim +109 arch/s390/kernel/guarded_storage.c

916cda1aa1b412 Martin Schwidefsky 2016-01-26  108  
916cda1aa1b412 Martin Schwidefsky 2016-01-26 @109  SYSCALL_DEFINE2(s390_guarded_storage, int, command,

:::::: The code at line 109 was first introduced by commit
:::::: 916cda1aa1b412d7cf2991c3af7479544942d121 s390: add a system call for guarded storage

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

