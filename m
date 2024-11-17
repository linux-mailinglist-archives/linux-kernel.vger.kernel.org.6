Return-Path: <linux-kernel+bounces-411988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB19D020E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60E6B237B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B462629F;
	Sun, 17 Nov 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFuu5tku"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4423DE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731819900; cv=none; b=gEZBMFr47WkmYu2CQ3QItDHjJULc51hmX1ZeLWCcA63DcZGAD+bSwrcPz8oaaiaUGRIZTDzV69Sn92Oyjt7l1SM6MLTpesZsp6LnjkG2gl07LDrPv+loxE2bxGLsap3eMLOJJh6jGB6xwVanBDlfrek1900cBEQrFv/gOBzQoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731819900; c=relaxed/simple;
	bh=BSA/JVT7I8hzt33cAznv9t1AFwa2XVbsoUrZaZ2JYJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mfZIlVkITpWo0lXogr1nEIOZMGdIrd+f6dUULpWWBTwwolcupkVgJbN/dlUq9lUDA2Ck3tzaGNUN7ek9IDJVCGSF7G18TS6BcgqMffMhAht83SBcUP6SHYDcbsXZIFHps+A3sLL5ESdSUtRiFkPrOGE5rdX//pXA7lWRI8i0Ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFuu5tku; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731819899; x=1763355899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BSA/JVT7I8hzt33cAznv9t1AFwa2XVbsoUrZaZ2JYJ4=;
  b=XFuu5tkudfHUsU42jfXnLshqkwRWAJmlf3GHdbb1aByngqPeNJ7pUfRo
   L49nFePrpj9Vd1R9HEwrUOuybbJN0ZzYP3I/QG7WKmeopDlSMSylYUiYr
   yq+eQoTw1/h5da5aQi9LS43YNdG08N2Xr+crWSiQcVIKbCaTWHY9iAkw1
   AgvdRLMxEsnaJ8UOAZniIWO1bnxvG3/kughbyQVdM8YxnRq2TYwTLRVFE
   Z//XBKqlez6g7qAvbn3NTevkVlw2EJyZzppmuObbE4kqibu0UaD17K2eJ
   uKcPVkGcbHWa/kDkWSJiJJXrqk0lXgvF7h6r8CSlwC9q89qyAOv6BN2i6
   Q==;
X-CSE-ConnectionGUID: 3gvLTgbgSmibEwx+1m6ykQ==
X-CSE-MsgGUID: 2smWgv2sSeWZukz7jIltYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31713533"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31713533"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:04:56 -0800
X-CSE-ConnectionGUID: cCrLfhN+RamDz1PtAQ/f3w==
X-CSE-MsgGUID: YIxF2xUJRiGxkJ7qt9FfKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="119853906"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Nov 2024 21:04:55 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCXSu-0001X1-1x;
	Sun, 17 Nov 2024 05:04:52 +0000
Date: Sun, 17 Nov 2024 13:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202411171251.zAsEVDv6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a5df37964673effcd9f84041f7423206a5ae5f2
commit: 6c370dc65374db5afbc5c6c64c662f922a2555ad Merge branch 'kvm-guestmemfd' into HEAD
date:   1 year ago
config: x86_64-randconfig-122-20241116 (https://download.01.org/0day-ci/archive/20241117/202411171251.zAsEVDv6-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171251.zAsEVDv6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171251.zAsEVDv6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:76:17: sparse: sparse: context imbalance in 'kvm_gmem_invalidate_begin' - different lock contexts for basic block
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>> arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file **f @@     got struct file [noderef] __rcu ** @@
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse:     expected struct file **f
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse:     got struct file [noderef] __rcu **
>> arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file **f @@     got struct file [noderef] __rcu ** @@
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse:     expected struct file **f
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:248:33: sparse:     got struct file [noderef] __rcu **

vim +248 arch/x86/kvm/../../../virt/kvm/guest_memfd.c

    50	
    51	static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
    52					      pgoff_t end)
    53	{
    54		bool flush = false, found_memslot = false;
    55		struct kvm_memory_slot *slot;
    56		struct kvm *kvm = gmem->kvm;
    57		unsigned long index;
    58	
    59		xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
    60			pgoff_t pgoff = slot->gmem.pgoff;
    61	
    62			struct kvm_gfn_range gfn_range = {
    63				.start = slot->base_gfn + max(pgoff, start) - pgoff,
    64				.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
    65				.slot = slot,
    66				.may_block = true,
    67			};
    68	
    69			if (!found_memslot) {
    70				found_memslot = true;
    71	
    72				KVM_MMU_LOCK(kvm);
    73				kvm_mmu_invalidate_begin(kvm);
    74			}
    75	
  > 76			flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
    77		}
    78	
    79		if (flush)
    80			kvm_flush_remote_tlbs(kvm);
    81	
    82		if (found_memslot)
    83			KVM_MMU_UNLOCK(kvm);
    84	}
    85	
    86	static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
    87					    pgoff_t end)
    88	{
    89		struct kvm *kvm = gmem->kvm;
    90	
    91		if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
    92			KVM_MMU_LOCK(kvm);
    93			kvm_mmu_invalidate_end(kvm);
    94			KVM_MMU_UNLOCK(kvm);
    95		}
    96	}
    97	
    98	static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
    99	{
   100		struct list_head *gmem_list = &inode->i_mapping->private_list;
   101		pgoff_t start = offset >> PAGE_SHIFT;
   102		pgoff_t end = (offset + len) >> PAGE_SHIFT;
   103		struct kvm_gmem *gmem;
   104	
   105		/*
   106		 * Bindings must be stable across invalidation to ensure the start+end
   107		 * are balanced.
   108		 */
   109		filemap_invalidate_lock(inode->i_mapping);
   110	
   111		list_for_each_entry(gmem, gmem_list, entry)
   112			kvm_gmem_invalidate_begin(gmem, start, end);
   113	
   114		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
   115	
   116		list_for_each_entry(gmem, gmem_list, entry)
   117			kvm_gmem_invalidate_end(gmem, start, end);
   118	
   119		filemap_invalidate_unlock(inode->i_mapping);
   120	
   121		return 0;
   122	}
   123	
   124	static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
   125	{
   126		struct address_space *mapping = inode->i_mapping;
   127		pgoff_t start, index, end;
   128		int r;
   129	
   130		/* Dedicated guest is immutable by default. */
   131		if (offset + len > i_size_read(inode))
   132			return -EINVAL;
   133	
   134		filemap_invalidate_lock_shared(mapping);
   135	
   136		start = offset >> PAGE_SHIFT;
   137		end = (offset + len) >> PAGE_SHIFT;
   138	
   139		r = 0;
   140		for (index = start; index < end; ) {
   141			struct folio *folio;
   142	
   143			if (signal_pending(current)) {
   144				r = -EINTR;
   145				break;
   146			}
   147	
   148			folio = kvm_gmem_get_folio(inode, index);
   149			if (!folio) {
   150				r = -ENOMEM;
   151				break;
   152			}
   153	
   154			index = folio_next_index(folio);
   155	
   156			folio_unlock(folio);
   157			folio_put(folio);
   158	
   159			/* 64-bit only, wrapping the index should be impossible. */
   160			if (WARN_ON_ONCE(!index))
   161				break;
   162	
   163			cond_resched();
   164		}
   165	
   166		filemap_invalidate_unlock_shared(mapping);
   167	
   168		return r;
   169	}
   170	
   171	static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
   172				       loff_t len)
   173	{
   174		int ret;
   175	
   176		if (!(mode & FALLOC_FL_KEEP_SIZE))
   177			return -EOPNOTSUPP;
   178	
   179		if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
   180			return -EOPNOTSUPP;
   181	
   182		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
   183			return -EINVAL;
   184	
   185		if (mode & FALLOC_FL_PUNCH_HOLE)
   186			ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
   187		else
   188			ret = kvm_gmem_allocate(file_inode(file), offset, len);
   189	
   190		if (!ret)
   191			file_modified(file);
   192		return ret;
   193	}
   194	
   195	static int kvm_gmem_release(struct inode *inode, struct file *file)
   196	{
   197		struct kvm_gmem *gmem = file->private_data;
   198		struct kvm_memory_slot *slot;
   199		struct kvm *kvm = gmem->kvm;
   200		unsigned long index;
   201	
   202		/*
   203		 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
   204		 * reference to the file and thus no new bindings can be created, but
   205		 * dereferencing the slot for existing bindings needs to be protected
   206		 * against memslot updates, specifically so that unbind doesn't race
   207		 * and free the memslot (kvm_gmem_get_file() will return NULL).
   208		 */
   209		mutex_lock(&kvm->slots_lock);
   210	
   211		filemap_invalidate_lock(inode->i_mapping);
   212	
   213		xa_for_each(&gmem->bindings, index, slot)
   214			rcu_assign_pointer(slot->gmem.file, NULL);
   215	
   216		synchronize_rcu();
   217	
   218		/*
   219		 * All in-flight operations are gone and new bindings can be created.
   220		 * Zap all SPTEs pointed at by this file.  Do not free the backing
   221		 * memory, as its lifetime is associated with the inode, not the file.
   222		 */
   223		kvm_gmem_invalidate_begin(gmem, 0, -1ul);
   224		kvm_gmem_invalidate_end(gmem, 0, -1ul);
   225	
   226		list_del(&gmem->entry);
   227	
   228		filemap_invalidate_unlock(inode->i_mapping);
   229	
   230		mutex_unlock(&kvm->slots_lock);
   231	
   232		xa_destroy(&gmem->bindings);
   233		kfree(gmem);
   234	
   235		kvm_put_kvm(kvm);
   236	
   237		return 0;
   238	}
   239	
   240	static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
   241	{
   242		/*
   243		 * Do not return slot->gmem.file if it has already been closed;
   244		 * there might be some time between the last fput() and when
   245		 * kvm_gmem_release() clears slot->gmem.file, and you do not
   246		 * want to spin in the meanwhile.
   247		 */
 > 248		return get_file_active(&slot->gmem.file);
   249	}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

