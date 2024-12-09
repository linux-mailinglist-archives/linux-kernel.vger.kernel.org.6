Return-Path: <linux-kernel+bounces-436741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365409E8A25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2079316336C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68130156885;
	Mon,  9 Dec 2024 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMA16FKl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E115666B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717472; cv=none; b=W0SbKFMgecX4CfFNGHVUUp8YGIns/PThk3mvdbyNHmVdGoteWTtZWClHU/LOhTSfLsXfGLBAADvFj4uyrAp+CX2n3JtMlhO7ZNwTdAJpNamkvljebNh6FjFr6DVU+vqfabiHsjggsUe6RetrFV7qtjCO/2gqvGOSFtuBNN1MBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717472; c=relaxed/simple;
	bh=e5lSDI07FMVuwWtwFVHQ/BSRsDcUV16G0hl8ZZi7tmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HmlkEmyge2dZLQQNF6ZLL129gixbSNffnNRdMyfNKRtLMwnXSOA3hPswaCWdWT3Ew02YtqOcEjivz9QflrN0K6QnI+huQpHJ/+V1nhZpd6X9f3be5emng+ClgtlJar25aMlwz9usIZPOO0z+twK4uoMBWkS/YroJAavAOUmWC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMA16FKl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717471; x=1765253471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e5lSDI07FMVuwWtwFVHQ/BSRsDcUV16G0hl8ZZi7tmI=;
  b=FMA16FKlaVskCFkfxjRtjmYfhFaDNsE2MWr/YLrba05fKX0rjXKRMJp6
   jOLPAK5w/4ZFkcYdytEb8pq2/UcUAzx7bbpFIY0gM4PVTN4+UiWiLkgCC
   +R4AEP/DSBLNEfdSq49uuQYha0Okofig9CZNnh50rD3pC5UWfS0Qt1Qmk
   lC2zv7PvXC/tSRSavj4b+F9+Irb2zf9dWFCcZK4e9felDSpL4YEpX5vQB
   Ow1uam8hyyxgPmqOMzGEZwyfQIW53n8v3RkMOZKmKZBEFCniTh9EglQGa
   sCeoj+gHdPLuwRwtDO01DCXBRJrh1/+hj2YT2jYNpGwrE8ox+SoHJVrzd
   w==;
X-CSE-ConnectionGUID: +8LjdGP3SD6DEsiV88Kakw==
X-CSE-MsgGUID: f7YhNWyyQAafd0U+AVP/2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33330648"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33330648"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:11:10 -0800
X-CSE-ConnectionGUID: eyUMPm85Q9uld4cdafJ+cA==
X-CSE-MsgGUID: x5oF/O1XTGOrLA2AGKSgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100003658"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 20:11:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV6v-0003o2-1f;
	Mon, 09 Dec 2024 04:11:05 +0000
Date: Mon, 9 Dec 2024 12:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Nianyao Tang <tangnianyao@huawei.com>,
	Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-gic-v3-its.c:3896:30: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202412071436.UuBR3FRD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: f82e62d470cc990ebd9d691f931dd418e4e9cea9 irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801
date:   11 days ago
config: arm-randconfig-r111-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071436.UuBR3FRD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412071436.UuBR3FRD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071436.UuBR3FRD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/irqchip/irq-gic-v3-its.c:1552:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:1552:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:1552:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:1558:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:1558:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:1558:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:2926:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cpumask [usertype] **mask @@     got struct cpumask [usertype] *[noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:2926:45: sparse:     expected struct cpumask [usertype] **mask
   drivers/irqchip/irq-gic-v3-its.c:2926:45: sparse:     got struct cpumask [usertype] *[noderef] __percpu *
>> drivers/irqchip/irq-gic-v3-its.c:3896:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *l @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:3896:30: sparse:     expected struct raw_spinlock [usertype] *l
   drivers/irqchip/irq-gic-v3-its.c:3896:30: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4424:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4424:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4424:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4442:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4442:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:354:12: sparse: sparse: context imbalance in 'vpe_to_cpuid_lock' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:360:13: sparse: sparse: context imbalance in 'vpe_to_cpuid_unlock' - unexpected unlock
   drivers/irqchip/irq-gic-v3-its.c:1403:13: sparse: sparse: context imbalance in 'its_send_vmovp' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:1554:18: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:1875:13: sparse: sparse: context imbalance in 'its_map_vm' - different lock contexts for basic block
   drivers/irqchip/irq-gic-v3-its.c:1902:13: sparse: sparse: context imbalance in 'its_unmap_vm' - different lock contexts for basic block
   drivers/irqchip/irq-gic-v3-its.c:2039:12: sparse: sparse: context imbalance in 'its_irq_set_vcpu_affinity' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:2325:23: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2325:23: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2741:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2741:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2762:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2798:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2798:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2802:38: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2820:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2820:49: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2821:25: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2831:30: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2874:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2901:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c: note: in included file (through include/linux/irqchip/arm-gic-v3.h):
   arch/arm/include/asm/arch_gicv3.h:146:9: sparse: sparse: cast truncates bits from constant value (2000000000000000 becomes 0)
   drivers/irqchip/irq-gic-v3-its.c:2930:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2931:14: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3001:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3015:45: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3015:45: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3017:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3068:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3068:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3083:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3083:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3108:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3156:31: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3161:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3180:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3185:21: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3245:43: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3279:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3280:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3311:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3314:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3314:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3870:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3897:18: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3888:13: sparse: sparse: context imbalance in 'its_vpe_4_1_invall_locked' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:3950:22: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3986:9: sparse: sparse: context imbalance in 'its_vpe_set_affinity' - different lock contexts for basic block
   drivers/irqchip/irq-gic-v3-its.c:3991:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4005:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4041:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4050:13: sparse: sparse: context imbalance in 'its_vpe_invall' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:4153:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4233:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4248:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4425:16: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5326:19: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5326:19: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5331:31: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5351:14: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5428:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5431:21: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5441:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5443:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5455:9: sparse: sparse: dereference of noderef expression

vim +3896 drivers/irqchip/irq-gic-v3-its.c

  3887	
  3888	static void its_vpe_4_1_invall_locked(int cpu, struct its_vpe *vpe)
  3889	{
  3890		void __iomem *rdbase;
  3891		u64 val;
  3892	
  3893		val  = GICR_INVALLR_V;
  3894		val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
  3895	
> 3896		guard(raw_spinlock)(&gic_data_rdist_cpu(cpu)->rd_lock);
  3897		rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
  3898		gic_write_lpir(val, rdbase + GICR_INVALLR);
  3899		wait_for_syncr(rdbase);
  3900	}
  3901	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

