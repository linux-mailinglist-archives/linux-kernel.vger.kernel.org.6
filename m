Return-Path: <linux-kernel+bounces-340581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91E987587
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB662888E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39F142624;
	Thu, 26 Sep 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4SOv0NH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6114A60C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360602; cv=none; b=nb957NoARfyZChqpoSE+eKrDsaRCD6cJAw01abY8LtohXSamo/a4n/5eUojkc1jlzN1/UefA3++cn2mTQMnOdCLGr+UvGCql/pbEkBumldtj0OiBF73Wr1OJb+EPLRB9JBHNMTV+AcJ3F9jjKRmqcC7ioEywD9YUbbR2UrFYJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360602; c=relaxed/simple;
	bh=XtqOLIdUR3x/UfMY0vCPDY01gWRLFcC57uTV5m6aJVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B23CdBOg2H+bsBlt5xY36jk8mM7GK9fFRsJW43BBuDZ6ffWCfHCkQ18MbiB5frUHPghGK3PP4R4QAc7+9Iotn09PCWpGsl+mcRZvfCRCuYdk9GD0L9Mu9kC1gU176eVobUazY40Tsz5icSSX4lN/lJjFqU1eGLVyrsK7xXXlAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4SOv0NH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727360600; x=1758896600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XtqOLIdUR3x/UfMY0vCPDY01gWRLFcC57uTV5m6aJVY=;
  b=j4SOv0NHsyf0pOnsMb//P3VqLYHspzz/KX1k9a3rA1ySGgsz/PSjHA7Q
   jUk6SGtQl8lrO+8YumYMZg/UB0ir5CjURQI63k8qSA5oHw5jEcHwtC69T
   rbn0XcQMG6ovdBieKg8MHfjW5Z4+43wMPFbgqvnpyb9Ow+vWYY5MkrSKR
   WrEWnnhOstgInWPvTewF09ATloOK5TRqr1w/cCc6CPB9Tc7Pd7Xmm16g4
   BrqyDTKGhY49zQerf+PMc/1NYkJO/SjKJAQWQOLI+q1Bc0itImsW/wjeq
   fhlv4N4juLfJiUe9S+IoatTpiTC1+/CJZwWmOlAEN/czbWPP0H0RJrvYT
   Q==;
X-CSE-ConnectionGUID: /OR/IuZZT0KzjNkZ/JuVrw==
X-CSE-MsgGUID: zfbjYEBeQueJuC4jxto9kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37040849"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="37040849"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:23:19 -0700
X-CSE-ConnectionGUID: nEAYdrTSQ82Huths5LvUhg==
X-CSE-MsgGUID: q777GRWYSt6OPbWpQLuboQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72065901"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Sep 2024 07:23:18 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stpOl-000Knl-1E;
	Thu, 26 Sep 2024 14:23:15 +0000
Date: Thu, 26 Sep 2024 22:22:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202409262245.0oAITGgt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11a299a7933e03c83818b431e6a1c53ad387423d
commit: f072b272aa27d57cf7fe6fdedb30fb50f391974e RISC-V: KVM: Use correct restricted types
date:   8 months ago
config: riscv-randconfig-r133-20240926 (https://download.01.org/0day-ci/archive/20240926/202409262245.0oAITGgt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce: (https://download.01.org/0day-ci/archive/20240926/202409262245.0oAITGgt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409262245.0oAITGgt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: restricted __le32 degrades to integer
>> arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: restricted __le32 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: cast to restricted __le32
   arch/riscv/kvm/vcpu_sbi_sta.c:65:13: sparse: sparse: restricted __le32 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:65:13: sparse: sparse: restricted __le32 degrades to integer
>> arch/riscv/kvm/vcpu_sbi_sta.c:65:13: sparse: sparse: cast from restricted __le32
>> arch/riscv/kvm/vcpu_sbi_sta.c:68:14: sparse: sparse: restricted __le64 degrades to integer
>> arch/riscv/kvm/vcpu_sbi_sta.c:68:14: sparse: sparse: restricted __le64 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:68:14: sparse: sparse: cast to restricted __le64
   arch/riscv/kvm/vcpu_sbi_sta.c:72:17: sparse: sparse: restricted __le64 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:72:17: sparse: sparse: restricted __le64 degrades to integer
>> arch/riscv/kvm/vcpu_sbi_sta.c:72:17: sparse: sparse: cast from restricted __le64
   arch/riscv/kvm/vcpu_sbi_sta.c:76:9: sparse: sparse: restricted __le32 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:76:9: sparse: sparse: restricted __le32 degrades to integer
   arch/riscv/kvm/vcpu_sbi_sta.c:76:9: sparse: sparse: cast from restricted __le32

vim +59 arch/riscv/kvm/vcpu_sbi_sta.c

    24	
    25	void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
    26	{
    27		gpa_t shmem = vcpu->arch.sta.shmem;
    28		u64 last_steal = vcpu->arch.sta.last_steal;
    29		__le32 __user *sequence_ptr;
    30		__le64 __user *steal_ptr;
    31		__le32 sequence_le;
    32		__le64 steal_le;
    33		u32 sequence;
    34		u64 steal;
    35		unsigned long hva;
    36		gfn_t gfn;
    37	
    38		if (shmem == INVALID_GPA)
    39			return;
    40	
    41		/*
    42		 * shmem is 64-byte aligned (see the enforcement in
    43		 * kvm_sbi_sta_steal_time_set_shmem()) and the size of sbi_sta_struct
    44		 * is 64 bytes, so we know all its offsets are in the same page.
    45		 */
    46		gfn = shmem >> PAGE_SHIFT;
    47		hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
    48	
    49		if (WARN_ON(kvm_is_error_hva(hva))) {
    50			vcpu->arch.sta.shmem = INVALID_GPA;
    51			return;
    52		}
    53	
    54		sequence_ptr = (__le32 __user *)(hva + offset_in_page(shmem) +
    55				       offsetof(struct sbi_sta_struct, sequence));
    56		steal_ptr = (__le64 __user *)(hva + offset_in_page(shmem) +
    57				    offsetof(struct sbi_sta_struct, steal));
    58	
  > 59		if (WARN_ON(get_user(sequence_le, sequence_ptr)))
    60			return;
    61	
    62		sequence = le32_to_cpu(sequence_le);
    63		sequence += 1;
    64	
  > 65		if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
    66			return;
    67	
  > 68		if (!WARN_ON(get_user(steal_le, steal_ptr))) {
    69			steal = le64_to_cpu(steal_le);
    70			vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
    71			steal += vcpu->arch.sta.last_steal - last_steal;
  > 72			WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
    73		}
    74	
    75		sequence += 1;
    76		WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
    77	
    78		kvm_vcpu_mark_page_dirty(vcpu, gfn);
    79	}
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

