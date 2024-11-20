Return-Path: <linux-kernel+bounces-415240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C69D335B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC57AB216F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD16156649;
	Wed, 20 Nov 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jj9mL+QG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC51494BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082399; cv=none; b=MeLwGVHPHmhQyRIATo58v4EIruWYZC5aYDMj934AHN8aw5DLTWn3j1kwl3nH28AXzreQekB3q8YXh/gWUOYLGluG22f9Af+VEyXHJ7Nxg3khcNO/SK/L3kA7RrkRg2WkzPv91zFdWEhCyek2VLHpUzDQR6jFlCXnW5efvzuyWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082399; c=relaxed/simple;
	bh=oh4MxqZTnwT+UplLIOJdHe8W3AnJxfkhhGXs7fUk9tU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gm5Vj7fp7mhvidLVxn/F66etCj3yDw4mqWkhMGdHP+xsMfGYNw9GNfzsEtNG2tQiGTeIPhiCzrRg2ZZHPD0Lc01GcT5c3NtwOSe4Ji/m3iuTC6Z3W1wDbzkihi6D8nisyFXx7gGtoVn7KqHz3Ry/3/L3d1ykf2idkfwOQ+e+9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jj9mL+QG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732082396; x=1763618396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oh4MxqZTnwT+UplLIOJdHe8W3AnJxfkhhGXs7fUk9tU=;
  b=Jj9mL+QGffl9mPmGQ7ta9Yd5K8xThD+EXLt/sHaqXL2Wh5DtydHRE37C
   QCsa46bZoxOh8RUxscMw2YJ0HrQgsFrOwOu0bg0n7mSUG2OLSuNpNMbik
   woRyo57qm+oBOXOLGQcYWcOsmuUiWB3vPa3RPCrPnox81gHOYSb+A3aMN
   BxAmduPE+i9/HAUJI4CVQ7hkhiSXAXIi/74z6wcLAAm9JcVzhelT8gXRL
   QfHNfepcu9zLqjJT1Dt8CmA1ELVCqTL2ppm3qXcmKbwKWZnY5TBEPQkQ9
   iniS6cg3vawYNN3JZ5F/WdGcN2XAQFloNmisnqFsXJ5f3dTt5aRBxxR8R
   Q==;
X-CSE-ConnectionGUID: BSAQBr+PTWewHil5lMoC+w==
X-CSE-MsgGUID: uPiSZalUR9qphOpE3Iwg2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42755085"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42755085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 21:59:56 -0800
X-CSE-ConnectionGUID: HnKFfSNGS++ry89jLLVhCA==
X-CSE-MsgGUID: 5WQc0HFrS2uZ6utf15gDnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="94625799"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2024 21:59:55 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDdkm-0000Vh-2T;
	Wed, 20 Nov 2024 05:59:52 +0000
Date: Wed, 20 Nov 2024 13:59:39 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202411201356.pXoYlKFB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steven,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf9aa14fc523d2763fc9a10672a709224e8fcaf4
commit: 59cbd4eea48fdbc68fc17a29ad71188fea74b28b KVM: Remove HIGH_RES_TIMERS dependency
date:   3 months ago
config: x86_64-randconfig-r133-20241119 (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411201356.pXoYlKFB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
>> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
>> arch/x86/kernel/cpu/sgx/virt.c:354:36: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:385:24: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:385:43: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:385:58: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c: note: in included file (through include/linux/miscdevice.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +59 arch/x86/kernel/cpu/sgx/virt.c

540745ddbc70eab Sean Christopherson 2021-03-19  32  
540745ddbc70eab Sean Christopherson 2021-03-19  33  static int __sgx_vepc_fault(struct sgx_vepc *vepc,
540745ddbc70eab Sean Christopherson 2021-03-19  34  			    struct vm_area_struct *vma, unsigned long addr)
540745ddbc70eab Sean Christopherson 2021-03-19  35  {
540745ddbc70eab Sean Christopherson 2021-03-19  36  	struct sgx_epc_page *epc_page;
540745ddbc70eab Sean Christopherson 2021-03-19  37  	unsigned long index, pfn;
540745ddbc70eab Sean Christopherson 2021-03-19  38  	int ret;
540745ddbc70eab Sean Christopherson 2021-03-19  39  
540745ddbc70eab Sean Christopherson 2021-03-19  40  	WARN_ON(!mutex_is_locked(&vepc->lock));
540745ddbc70eab Sean Christopherson 2021-03-19  41  
540745ddbc70eab Sean Christopherson 2021-03-19  42  	/* Calculate index of EPC page in virtual EPC's page_array */
540745ddbc70eab Sean Christopherson 2021-03-19  43  	index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
540745ddbc70eab Sean Christopherson 2021-03-19  44  
540745ddbc70eab Sean Christopherson 2021-03-19  45  	epc_page = xa_load(&vepc->page_array, index);
540745ddbc70eab Sean Christopherson 2021-03-19  46  	if (epc_page)
540745ddbc70eab Sean Christopherson 2021-03-19  47  		return 0;
540745ddbc70eab Sean Christopherson 2021-03-19  48  
540745ddbc70eab Sean Christopherson 2021-03-19  49  	epc_page = sgx_alloc_epc_page(vepc, false);
540745ddbc70eab Sean Christopherson 2021-03-19  50  	if (IS_ERR(epc_page))
540745ddbc70eab Sean Christopherson 2021-03-19  51  		return PTR_ERR(epc_page);
540745ddbc70eab Sean Christopherson 2021-03-19  52  
540745ddbc70eab Sean Christopherson 2021-03-19  53  	ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
540745ddbc70eab Sean Christopherson 2021-03-19  54  	if (ret)
540745ddbc70eab Sean Christopherson 2021-03-19  55  		goto err_free;
540745ddbc70eab Sean Christopherson 2021-03-19  56  
540745ddbc70eab Sean Christopherson 2021-03-19  57  	pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
540745ddbc70eab Sean Christopherson 2021-03-19  58  
540745ddbc70eab Sean Christopherson 2021-03-19 @59  	ret = vmf_insert_pfn(vma, addr, pfn);
540745ddbc70eab Sean Christopherson 2021-03-19 @60  	if (ret != VM_FAULT_NOPAGE) {
540745ddbc70eab Sean Christopherson 2021-03-19  61  		ret = -EFAULT;
540745ddbc70eab Sean Christopherson 2021-03-19  62  		goto err_delete;
540745ddbc70eab Sean Christopherson 2021-03-19  63  	}
540745ddbc70eab Sean Christopherson 2021-03-19  64  
540745ddbc70eab Sean Christopherson 2021-03-19  65  	return 0;
540745ddbc70eab Sean Christopherson 2021-03-19  66  
540745ddbc70eab Sean Christopherson 2021-03-19  67  err_delete:
540745ddbc70eab Sean Christopherson 2021-03-19  68  	xa_erase(&vepc->page_array, index);
540745ddbc70eab Sean Christopherson 2021-03-19  69  err_free:
540745ddbc70eab Sean Christopherson 2021-03-19  70  	sgx_free_epc_page(epc_page);
540745ddbc70eab Sean Christopherson 2021-03-19  71  	return ret;
540745ddbc70eab Sean Christopherson 2021-03-19  72  }
540745ddbc70eab Sean Christopherson 2021-03-19  73  

:::::: The code at line 59 was first introduced by commit
:::::: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests

:::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

