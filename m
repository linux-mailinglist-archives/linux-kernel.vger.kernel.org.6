Return-Path: <linux-kernel+bounces-225908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B4913748
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE51B1F2261F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C92372;
	Sun, 23 Jun 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIPF7IN2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C607257B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719108135; cv=none; b=EUYJ20elcQ6Vg5HW4DZ/BXiPy66Eb9kTJaL0GK7FGUVgQvhVgmXfjOUxHEk7sLrQCKCX2EvxsoXBBwaIErDDyY3d8tBY+EHO26fWlemgdGKE5OiwX9W7lACgXjqUODVMqBnjEC6tInT5gy5KkPAribUXXgM0B5k0KwGjUcYyUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719108135; c=relaxed/simple;
	bh=h1N9BbSsxrG7WSx3YjhjY6wHi48QSKB0RFaKMUWGCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WjMTsXmXm/C3jH2zrnUbIHQ8J6v3lToihDdEnzF4O+LUNR9hULdze7L7BSx9cSgsXrA8hskvTHNfpm6Bq/UsO2eiI4eOSnhraFJKd6NDv2dYwXI252FSnZ/ADMQ/LTPdVQPEK9TJ0xMqw+Xmo2cSmnML/W/ovQCWPr736X1l7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIPF7IN2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719108134; x=1750644134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h1N9BbSsxrG7WSx3YjhjY6wHi48QSKB0RFaKMUWGCsA=;
  b=SIPF7IN2KbLJzCDLRLSkk3GsUHtiDOzBOmS4vvm0J0NIdDhuxoR9FJuH
   +c+9PUEpOzP9yo7LKsmKUhrVVzHwTB+cYhBBzOJwTuPcPyN5VS1zx6Axo
   xsWHfaQo9wpOgBIHbT9+GvdvDjoMOaADSyl0ERU9JvSIFF5RwoRjdNCdm
   asFFtL1QkUbzGEuPgc9LoeqFw8hEmGo/HNgdQVpj5ywlkdB0SRZjk0o3h
   46/ahbU7hpJDXMzDm2QK9hcG/TmetW6BB1U2iFV/PyfUk8zyAFbvXiPC+
   Qs+8fHOnvM/KEihy2F042EKb3s1T6DLD2fv3LrwGJ1ChS94TX2NAY3OL3
   w==;
X-CSE-ConnectionGUID: kjcq3DQfROa9kA0oIo8iyQ==
X-CSE-MsgGUID: igrgZzcmR6Sl9Cox10sUeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="15938083"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="15938083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 19:02:12 -0700
X-CSE-ConnectionGUID: PmUJVu4HQzSGm8LdDAbaxg==
X-CSE-MsgGUID: db0Yfp9qQ/ihglgjzfD3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="42921677"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2024 19:02:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLCYR-000A9e-23;
	Sun, 23 Jun 2024 02:02:07 +0000
Date: Sun, 23 Jun 2024 10:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: arch/riscv/kvm/vcpu_sbi_sta.c:59:13: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202406230951.z2XjxdWg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f583a3162ffd9f7999af76b8ab634ce2dac9f90
commit: f072b272aa27d57cf7fe6fdedb30fb50f391974e RISC-V: KVM: Use correct restricted types
date:   5 months ago
config: riscv-randconfig-r113-20240623 (https://download.01.org/0day-ci/archive/20240623/202406230951.z2XjxdWg-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240623/202406230951.z2XjxdWg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406230951.z2XjxdWg-lkp@intel.com/

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

