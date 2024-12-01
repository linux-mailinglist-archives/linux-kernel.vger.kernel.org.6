Return-Path: <linux-kernel+bounces-426573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16289DF51B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5662811AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551A81727;
	Sun,  1 Dec 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7HmgBwg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14562CA8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045760; cv=none; b=NJCUNvz3sXM1vpu3Km0Ju3q88qmkcZYH2bCLbQJg6FWnxIgZmGw29FLeEzXaYjp9kUIZT+GEvCsL7fBM5nO4F2M4pTIiaBQXqGfzQT2V6az3A8kohbDwRHl6i34hnc9ho8kTdOocJUDxVxoAGqT5ulBulcGLrS1/BrGKvuqNiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045760; c=relaxed/simple;
	bh=Stho1LITp7cgqHUmCplR2naLR5n8smAKlOObDrZXyhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lM6PUR7XDNSdytY056VAFrajjrHRKpn38UQaiqFd84SD6twKcmFxwvSP1tCiQodDBWRfgd6ACjrMpt7k3KnqC5uyemJJt7vXTJUJJTfuIggKnaxmsoImGoYQxOjaEkGNyEtpjE3Soo+8AEdf9e35yQ1M775EJV7bRmz2PguzwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7HmgBwg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733045757; x=1764581757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Stho1LITp7cgqHUmCplR2naLR5n8smAKlOObDrZXyhA=;
  b=A7HmgBwgSa/OAXjMyVkCfZlaS2nZ2qbPlJBlrDL4wt9psyAh5ee7ERJs
   a85jzFo03ZehtdbVrpan0qiAjhFGx3eavtcTBFm26PAhxuff9n0nw5jJf
   11gkMtLjWMM2Yu9XMINzZWnabT9zTo+MFFA3qCVdhjXM7kTaTbAswqsou
   lpfOAVtlnJFwya/iecF9UknwfiEmDxhjHt+a+CAv19elJe7eHVuUBd+Ys
   ZG/t9nVF0RAuFhas+JQHXLeI8l74paDtfX69mG6kwAji+Sjy/EUR/ngdp
   ZqcDDCmq2kxOfxtjNvVBiPuYl0rBaPDUVPhuhDHRWQ9eA5SddgSEB3sLz
   g==;
X-CSE-ConnectionGUID: /rA9W6QBRlGJmu5DNR/hxg==
X-CSE-MsgGUID: 5CxESyv/QtOupRgUGgPsrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="32575894"
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="32575894"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 01:35:57 -0800
X-CSE-ConnectionGUID: ccCwIqkbQq2lhZC6L9Omeg==
X-CSE-MsgGUID: vF2GWBjISLisA95SML3dAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="92745875"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 01 Dec 2024 01:35:56 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHgL6-0001Qh-2i;
	Sun, 01 Dec 2024 09:35:03 +0000
Date: Sun, 1 Dec 2024 17:29:50 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kvm/../../../virt/kvm/guest_memfd.c:540:18: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202412011712.1CoGhyrO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
commit: 17573fd971f9e31ddee420eca8359ceff87e9e51 KVM: guest_memfd: extract __kvm_gmem_get_pfn()
date:   7 months ago
config: x86_64-randconfig-122-20241116 (https://download.01.org/0day-ci/archive/20241201/202412011712.1CoGhyrO-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011712.1CoGhyrO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011712.1CoGhyrO-lkp@intel.com/

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

