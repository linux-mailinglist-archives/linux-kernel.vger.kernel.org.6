Return-Path: <linux-kernel+bounces-340315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6084987178
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B151C24023
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F21ACE19;
	Thu, 26 Sep 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="magBxSp6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CA1AC441
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346371; cv=none; b=H6AiZSIbxzOIhNrZlEYJCqa9uDNai80hF3ArmgaDkBPA0cII5NjXqFv2aYaBmY/MAi5jEeiWSyADGuipZ01eOGDqADvi73UUsLUODBuqUUtKNAIl99O5aIaqzxShlvSDXBXFhQxUQAmVYgfMIoMOp+8Ssyygu4952XCzhjI+D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346371; c=relaxed/simple;
	bh=2xiEpAqwiURqhbLx9UQ7eaejJ7Cx2bw8HpjcojrX+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyJ/QL+8MFcKaWmHu/memIkDdRzvYxo5Og5AmFW/+Ih9chotAIT50S3awaZTrswIrLnFeP71tce7fzyS7xgQDWXSAGfBt+aHSEZUTvzUS8ytkRdpM3qjpUP6DlBzfDLsPKxOpdsP3R/Q7beT4FlKAAfwUx5DaBaG0ow6HeSCqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=magBxSp6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727346369; x=1758882369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2xiEpAqwiURqhbLx9UQ7eaejJ7Cx2bw8HpjcojrX+M4=;
  b=magBxSp6jJSYq5R30jwvHAwpQAKCyUeiRez0bZnbgdjFAN0523vutbw8
   Em1mRLQ/pnZ6IsJY/TxfdheFJDbh5vV3OoT/79TxqTu0tx7aAO6e6Spcc
   n34tzRnreoU4dUJY2zZcllSemgX/q6KritUFaMn+zT+KTIqyLxBdtW54W
   GqmdlaWbiQhMIJOzbtlOK8faPeh6w3rAcTfnmmBPSq7GmlA7lUW852UDH
   RHSR1wlTMOMBqxRasGMn04r7nUenL/w+ZrUxsaI3JQuJC859lUA0qXnEw
   8m4lCgfsKN2mWP5ieyYons0V7ZNd9JVP1pSGq6DYrjlZgxIt1J0Vzbtm9
   Q==;
X-CSE-ConnectionGUID: ZMJJSQn+QaqdHQr+qevfig==
X-CSE-MsgGUID: F0E/i1/7SDW5EVEUQ0JH3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26295834"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="26295834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 03:26:09 -0700
X-CSE-ConnectionGUID: GBl5vdDLTrWGZYWGySjx8A==
X-CSE-MsgGUID: ZXMYfOK2R2+3sCLB+1f5mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="109570691"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2024 03:26:07 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stlhE-000KZ1-2r;
	Thu, 26 Sep 2024 10:26:04 +0000
Date: Thu, 26 Sep 2024 18:25:37 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: arch/riscv/kvm/vcpu_sbi_sta.c:58:20: sparse: sparse: cast to
 restricted __le32
Message-ID: <202409261846.kWf2YRgc-lkp@intel.com>
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
commit: e9f12b5fff8ad0eefd0340273767d329ef65fd69 RISC-V: KVM: Implement SBI STA extension
date:   9 months ago
config: riscv-randconfig-r133-20240926 (https://download.01.org/0day-ci/archive/20240926/202409261846.kWf2YRgc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce: (https://download.01.org/0day-ci/archive/20240926/202409261846.kWf2YRgc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261846.kWf2YRgc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/riscv/kvm/vcpu_sbi_sta.c:55:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__p @@     got unsigned int [usertype] *[assigned] sequence_ptr @@
   arch/riscv/kvm/vcpu_sbi_sta.c:55:13: sparse:     expected unsigned int const [noderef] __user *__p
   arch/riscv/kvm/vcpu_sbi_sta.c:55:13: sparse:     got unsigned int [usertype] *[assigned] sequence_ptr
>> arch/riscv/kvm/vcpu_sbi_sta.c:58:20: sparse: sparse: cast to restricted __le32
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[assigned] sequence_ptr @@
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse:     expected unsigned int [noderef] __user *__p
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse:     got unsigned int [usertype] *[assigned] sequence_ptr
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int __val @@     got restricted __le32 [usertype] @@
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse:     expected unsigned int __val
   arch/riscv/kvm/vcpu_sbi_sta.c:61:13: sparse:     got restricted __le32 [usertype]
   arch/riscv/kvm/vcpu_sbi_sta.c:64:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__p @@     got unsigned long long [usertype] *[assigned] steal_ptr @@
   arch/riscv/kvm/vcpu_sbi_sta.c:64:14: sparse:     expected unsigned long long const [noderef] __user *__p
   arch/riscv/kvm/vcpu_sbi_sta.c:64:14: sparse:     got unsigned long long [usertype] *[assigned] steal_ptr
>> arch/riscv/kvm/vcpu_sbi_sta.c:65:25: sparse: sparse: cast to restricted __le64
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[assigned] steal_ptr @@
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse:     expected unsigned long long [noderef] __user *__p
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse:     got unsigned long long [usertype] *[assigned] steal_ptr
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long __val @@     got restricted __le64 [usertype] @@
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse:     expected unsigned long long __val
   arch/riscv/kvm/vcpu_sbi_sta.c:68:17: sparse:     got restricted __le64 [usertype]
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[assigned] sequence_ptr @@
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse:     expected unsigned int [noderef] __user *__p
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse:     got unsigned int [usertype] *[assigned] sequence_ptr
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int __val @@     got restricted __le32 [usertype] @@
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse:     expected unsigned int __val
   arch/riscv/kvm/vcpu_sbi_sta.c:72:9: sparse:     got restricted __le32 [usertype]

vim +58 arch/riscv/kvm/vcpu_sbi_sta.c

    24	
    25	void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
    26	{
    27		gpa_t shmem = vcpu->arch.sta.shmem;
    28		u64 last_steal = vcpu->arch.sta.last_steal;
    29		u32 *sequence_ptr, sequence;
    30		u64 *steal_ptr, steal;
    31		unsigned long hva;
    32		gfn_t gfn;
    33	
    34		if (shmem == INVALID_GPA)
    35			return;
    36	
    37		/*
    38		 * shmem is 64-byte aligned (see the enforcement in
    39		 * kvm_sbi_sta_steal_time_set_shmem()) and the size of sbi_sta_struct
    40		 * is 64 bytes, so we know all its offsets are in the same page.
    41		 */
    42		gfn = shmem >> PAGE_SHIFT;
    43		hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
    44	
    45		if (WARN_ON(kvm_is_error_hva(hva))) {
    46			vcpu->arch.sta.shmem = INVALID_GPA;
    47			return;
    48		}
    49	
    50		sequence_ptr = (u32 *)(hva + offset_in_page(shmem) +
    51				       offsetof(struct sbi_sta_struct, sequence));
    52		steal_ptr = (u64 *)(hva + offset_in_page(shmem) +
    53				    offsetof(struct sbi_sta_struct, steal));
    54	
    55		if (WARN_ON(get_user(sequence, sequence_ptr)))
    56			return;
    57	
  > 58		sequence = le32_to_cpu(sequence);
    59		sequence += 1;
    60	
    61		if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
    62			return;
    63	
    64		if (!WARN_ON(get_user(steal, steal_ptr))) {
  > 65			steal = le64_to_cpu(steal);
    66			vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
    67			steal += vcpu->arch.sta.last_steal - last_steal;
    68			WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
    69		}
    70	
    71		sequence += 1;
    72		WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
    73	
    74		kvm_vcpu_mark_page_dirty(vcpu, gfn);
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

