Return-Path: <linux-kernel+bounces-365593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69199E4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE91F24294
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E481EC018;
	Tue, 15 Oct 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwC2yp0o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB01EC014
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989752; cv=none; b=Cbs0oGxSBa0FTHapWSzx+BDefVx1/1omVRQGcyYl6iGRtbBmIRmxkTia/gzWfMaxjpoJrVj2H9Navb8LsbTqIiHX75paIDmCC6Tk9SIw2YVEmvpnX9enwkhTpoVJRIHqnn36DJsoUSxawYEj3v33JuJc+69FzXkimHTXRHQd+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989752; c=relaxed/simple;
	bh=uJMnlV5EvOX/wkTrKl7C91ww1Y9UgHMvxyrx5CtEtL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TF4pT8n5Y/asAoaenbD3FzEu+2h8BIgwRL4MmN9xId9jUUKtLLTawiaaZk0pj5cltqtoqJq6zQB+3iFX8liU+QHkl8e6OkoXSm0c+gGpD7N4npcgwVhj5+z+wTrQiS0f/7U8otOVxqRSdElTYdlapc0GjAxMFrWDyOoNEZGa4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwC2yp0o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728989750; x=1760525750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uJMnlV5EvOX/wkTrKl7C91ww1Y9UgHMvxyrx5CtEtL4=;
  b=IwC2yp0on3wgG5tBtLrDWWOMWSNbSPmT5reESp9MtDuPtbRC11vjhonN
   zVfbzNjQiDUpmpE0sPdvVUNbip1hS1L3Q/jnKl7iS4YH1K11FoNmkvOLa
   NEVFVqntOaLtPNLyYqHdmj9Jir5R6Yb4xF6fkoRA7tQ3ymehfeoC+IB7B
   e92484Y2D9hKpRMuUQQXLkoHYxMfKdv+xnakHArMQSzMDhMF5Xnu8xsrT
   HOB/OhhEAYj0ebu2+nR3wNPutBLmeRdPDX6M7uE+CGm9qr/HWxcQMkj2I
   kipW+0WyPUc2Ek95EaoYfR7zDdN7qpU4LPip71ugQdSVZ49VoT80kkUXt
   A==;
X-CSE-ConnectionGUID: pv2guJLnQHmkL/jStR3J6g==
X-CSE-MsgGUID: X6jeaGV+Sl+I9mXdCdm0VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32292800"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="32292800"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 03:55:49 -0700
X-CSE-ConnectionGUID: WYeeysv3TiOgG4D01ZlyFA==
X-CSE-MsgGUID: Ja9QJsuiTSqz5QwU+m7GuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="108585839"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2024 03:55:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0fDN-000HzT-1q;
	Tue, 15 Oct 2024 10:55:45 +0000
Date: Tue, 15 Oct 2024 18:55:10 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202410151825.Sp0CwJLa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eca631b8fe808748d7585059c4307005ca5c5820
commit: f072b272aa27d57cf7fe6fdedb30fb50f391974e RISC-V: KVM: Use correct restricted types
date:   8 months ago
config: riscv-randconfig-r132-20241015 (https://download.01.org/0day-ci/archive/20241015/202410151825.Sp0CwJLa-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241015/202410151825.Sp0CwJLa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151825.Sp0CwJLa-lkp@intel.com/

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

