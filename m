Return-Path: <linux-kernel+bounces-412129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D526A9D0430
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414E32820C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6611D8A14;
	Sun, 17 Nov 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LntOGPI3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1071CB518
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731852343; cv=none; b=PjF+O0jHTjCBSwGe1HpkCcrPART7X1jByyyBjVtvn2WqaXYE8en8y6VtoU1bdz5oZLQ7Mzv3A06ZnNbKQBv50zYMEDd8YBePIT9/OHoBEz6E4ZBTaAnBykFjcbsgweNrdmaWTQlSDyr6Gu9sKbji9aOkim51ivmFxk3tdk/OoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731852343; c=relaxed/simple;
	bh=Cd6XoooyHXJe9+XdxD7M/of4C15jxuJAxjL8yUKHMqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EkkwA4rrGg9q5GgYZDLeBp5g/KRmZThjJESCEYFshTN4U129OfnBFLQShqd45quq/QPN0dzS3AsduR42Cv1szx2uFhTIQmZpLUxhKAnTK5BR7WnthKaoG2vEWQNWY2HxtKE/eZAhAtdzmCS5oh2l5dS8clIdw81H0abBgdXOnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LntOGPI3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731852341; x=1763388341;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cd6XoooyHXJe9+XdxD7M/of4C15jxuJAxjL8yUKHMqg=;
  b=LntOGPI3T1LUVD2v0/9fjvYvUqdeZfQcu7AdDKGhFt1j07cXyHdJaznk
   K3KgBGwQKMuHqqZ6BQNy0ue6SyQX5PnehCqMB1JcxK4xopxiLpYhveIMy
   VbSltjFXITSloW3xeaJ93K1tVvvZcAbo42QENcMzoMM0p7jrZq422D7WY
   C29iDh3+6BWop43Aca45M7KPtfqFiSkKaFJJ52v1xu5WBBQeyGhS+ShTp
   AZYjh25SZKDG9H3oX9ez/CO/QjX/Nrrcj3Yxk0infEsTMn/r7ctGASdk7
   JgcOKghBwZRLcgGnz+CgyPQn8QZzxdhbcYrbdn2NN1MiQEO6sUnvt54Xn
   Q==;
X-CSE-ConnectionGUID: B6HGrxD6Rm6beS8J1etDRA==
X-CSE-MsgGUID: xEL8SYg3Qs+7qDxT6WNlcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42334318"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="42334318"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 06:05:41 -0800
X-CSE-ConnectionGUID: MUfqqt05T76KUR9qMHvg6Q==
X-CSE-MsgGUID: KykpxGoCRQ2RZe83+RToaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="112286329"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 06:05:39 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCfuC-0001mv-26;
	Sun, 17 Nov 2024 14:05:36 +0000
Date: Sun, 17 Nov 2024 22:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kvm/../../../virt/kvm/guest_memfd.c:540:18: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202411172120.xEl8Vl4S-lkp@intel.com>
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
commit: 17573fd971f9e31ddee420eca8359ceff87e9e51 KVM: guest_memfd: extract __kvm_gmem_get_pfn()
date:   6 months ago
config: x86_64-randconfig-122-20241116 (https://download.01.org/0day-ci/archive/20241117/202411172120.xEl8Vl4S-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411172120.xEl8Vl4S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172120.xEl8Vl4S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/../../../virt/kvm/guest_memfd.c:540:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:540:18: sparse:    struct file *
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:540:18: sparse:    struct file [noderef] __rcu *
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:121:17: sparse: sparse: context imbalance in 'kvm_gmem_invalidate_begin' - different lock contexts for basic block
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file **f @@     got struct file [noderef] __rcu ** @@
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse:     expected struct file **f
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse:     got struct file [noderef] __rcu **
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file **f @@     got struct file [noderef] __rcu ** @@
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse:     expected struct file **f
   arch/x86/kvm/../../../virt/kvm/guest_memfd.c:293:33: sparse:     got struct file [noderef] __rcu **

vim +540 arch/x86/kvm/../../../virt/kvm/guest_memfd.c

   530	
   531	static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
   532			       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
   533	{
   534		pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
   535		struct kvm_gmem *gmem = file->private_data;
   536		struct folio *folio;
   537		struct page *page;
   538		int r;
   539	
 > 540		if (file != slot->gmem.file) {
   541			WARN_ON_ONCE(slot->gmem.file);
   542			return -EFAULT;
   543		}
   544	
   545		gmem = file->private_data;
   546		if (xa_load(&gmem->bindings, index) != slot) {
   547			WARN_ON_ONCE(xa_load(&gmem->bindings, index));
   548			return -EIO;
   549		}
   550	
   551		folio = kvm_gmem_get_folio(file_inode(file), index, prepare);
   552		if (IS_ERR(folio))
   553			return PTR_ERR(folio);
   554	
   555		if (folio_test_hwpoison(folio)) {
   556			r = -EHWPOISON;
   557			goto out_unlock;
   558		}
   559	
   560		page = folio_file_page(folio, index);
   561	
   562		*pfn = page_to_pfn(page);
   563		if (max_order)
   564			*max_order = 0;
   565	
   566		r = 0;
   567	
   568	out_unlock:
   569		folio_unlock(folio);
   570	
   571		return r;
   572	}
   573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

