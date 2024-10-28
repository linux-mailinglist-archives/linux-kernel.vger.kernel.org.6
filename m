Return-Path: <linux-kernel+bounces-385683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214979B3A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF7E28262C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D718F2C5;
	Mon, 28 Oct 2024 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyxQogQr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D618D65D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143105; cv=none; b=j4QHzYIZ41TISkSLwrvplcVM2QNbDSQl8TuFEF740KZxNdy0ZFRZTgRJLhljHG/+WQWP5NCH9Bjg/ohjTbzk4B3IrmHcuimknc214SyPfF3+WMACq826M4X/IqkoDdKeVgMF7VNqxXTkltIi2D1NtTdAVFo9w2JtNP79YtyUYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143105; c=relaxed/simple;
	bh=G2BYRckaH6OfB9BgxU2lNZ/wbqKUWYzaYH4eq9h3nT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkTgxxcwYZcORyggcRhnHFrc5lXQURBabwdOGC0W/OOhhYd4MPHKEh2SygDCnu/lz1UijusXVkPAvoV5z7VGJJjhqOxJjAuerkHCcM+cSWDxKhS74PtM62zRCz0iYJI8+YOvNnZm32YzSaccBohXOU+Uu9UyyyvHYW/kQ/J6aR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyxQogQr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730143103; x=1761679103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2BYRckaH6OfB9BgxU2lNZ/wbqKUWYzaYH4eq9h3nT8=;
  b=AyxQogQr/DLsmheCmp03/3sUeDVWAk5BWgix/FSsJ8xAYX0V+IfCykc4
   W0hkUDtVlcFiyxwVRx9j7Uaj+CkHB0npAXWNkTGmS7jXeJKEMWpNQMSAv
   JFhMSjnDlKRLPMHbTYrJpFIxdDB/CaZVk7f3jle570skNmVrtk/jx5aCj
   ylhSsqJAccFqeaKa2K33TnSXvoO67aMZYGXOkxLTclcefXCYRdG4+gMx7
   S+671aqMFfeSznAvx6IMAb1KPGmwP31oygRNhjiPsv3pNldZ9yukfjho3
   57B+ALuPfbE2y3BUQjtPFuIFqwZsmmEzO65XqucPh4XlaoNQTJ2nO1/3l
   A==;
X-CSE-ConnectionGUID: 7bBzIRA1Twu4CZWJifNeMA==
X-CSE-MsgGUID: 3Si0JmsgQNiUTUVGPyI5aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40295613"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40295613"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 12:18:22 -0700
X-CSE-ConnectionGUID: 4d/BscNDRhimKOfdpZuXKw==
X-CSE-MsgGUID: ACYiNxGXQaCxUnN8/Bm6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="85664044"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Oct 2024 12:18:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5VFo-000cnA-2T;
	Mon, 28 Oct 2024 19:18:16 +0000
Date: Tue, 29 Oct 2024 03:17:29 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 04/31] KVM: x86: Switch to use hrtimer_setup()
Message-ID: <202410290239.urBaNd5D-lkp@intel.com>
References: <8774212e6c10c550743219e00738492eb379227c.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8774212e6c10c550743219e00738492eb379227c.1729864823.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on tip/sched/core perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools tip/timers/core axboe-block/for-next linus/master v6.12-rc5 next-20241028]
[cannot apply to kvm/linux-next acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/KVM-MIPS-Switch-to-use-hrtimer_setup/20241028-154142
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/8774212e6c10c550743219e00738492eb379227c.1729864823.git.namcao%40linutronix.de
patch subject: [PATCH 04/31] KVM: x86: Switch to use hrtimer_setup()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241029/202410290239.urBaNd5D-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290239.urBaNd5D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290239.urBaNd5D-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/lapic.c:20:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/lapic.c:2878:2: error: call to undeclared function 'hrtimer_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2878 |         hrtimer_setup(&apic->lapic_timer.timer, apic_timer_fn, CLOCK_MONOTONIC,
         |         ^
   arch/x86/kvm/lapic.c:2878:2: note: did you mean 'hrtimer_start'?
   include/linux/hrtimer.h:272:20: note: 'hrtimer_start' declared here
     272 | static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
         |                    ^
   4 warnings and 1 error generated.
--
   In file included from arch/x86/kvm/i8254.c:35:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/i8254.c:693:2: error: call to undeclared function 'hrtimer_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     693 |         hrtimer_setup(&pit_state->timer, pit_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
         |         ^
   arch/x86/kvm/i8254.c:693:2: note: did you mean 'hrtimer_start'?
   include/linux/hrtimer.h:272:20: note: 'hrtimer_start' declared here
     272 | static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
         |                    ^
   4 warnings and 1 error generated.
--
   In file included from arch/x86/kvm/hyperv.c:22:
   In file included from arch/x86/kvm/x86.h:5:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/hyperv.c:955:2: error: call to undeclared function 'hrtimer_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     955 |         hrtimer_setup(&stimer->timer, stimer_timer_callback, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
         |         ^
   arch/x86/kvm/hyperv.c:955:2: note: did you mean 'hrtimer_start'?
   include/linux/hrtimer.h:272:20: note: 'hrtimer_start' declared here
     272 | static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
         |                    ^
   4 warnings and 1 error generated.
--
   In file included from arch/x86/kvm/vmx/nested.c:8:
   In file included from arch/x86/include/asm/mmu_context.h:8:
   In file included from include/linux/pkeys.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/nested.c:5278:2: error: call to undeclared function 'hrtimer_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5278 |         hrtimer_setup(&vmx->nested.preemption_timer, vmx_preemption_timer_fn, CLOCK_MONOTONIC,
         |         ^
   arch/x86/kvm/vmx/nested.c:5278:2: note: did you mean 'hrtimer_start'?
   include/linux/hrtimer.h:272:20: note: 'hrtimer_start' declared here
     272 | static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
         |                    ^
   4 warnings and 1 error generated.


vim +/hrtimer_setup +2878 arch/x86/kvm/lapic.c

  2847	
  2848	int kvm_create_lapic(struct kvm_vcpu *vcpu)
  2849	{
  2850		struct kvm_lapic *apic;
  2851	
  2852		ASSERT(vcpu != NULL);
  2853	
  2854		if (!irqchip_in_kernel(vcpu->kvm)) {
  2855			static_branch_inc(&kvm_has_noapic_vcpu);
  2856			return 0;
  2857		}
  2858	
  2859		apic = kzalloc(sizeof(*apic), GFP_KERNEL_ACCOUNT);
  2860		if (!apic)
  2861			goto nomem;
  2862	
  2863		vcpu->arch.apic = apic;
  2864	
  2865		if (kvm_x86_ops.alloc_apic_backing_page)
  2866			apic->regs = kvm_x86_call(alloc_apic_backing_page)(vcpu);
  2867		else
  2868			apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
  2869		if (!apic->regs) {
  2870			printk(KERN_ERR "malloc apic regs error for vcpu %x\n",
  2871			       vcpu->vcpu_id);
  2872			goto nomem_free_apic;
  2873		}
  2874		apic->vcpu = vcpu;
  2875	
  2876		apic->nr_lvt_entries = kvm_apic_calc_nr_lvt_entries(vcpu);
  2877	
> 2878		hrtimer_setup(&apic->lapic_timer.timer, apic_timer_fn, CLOCK_MONOTONIC,
  2879			      HRTIMER_MODE_ABS_HARD);
  2880		if (lapic_timer_advance)
  2881			apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_NS_INIT;
  2882	
  2883		/*
  2884		 * Stuff the APIC ENABLE bit in lieu of temporarily incrementing
  2885		 * apic_hw_disabled; the full RESET value is set by kvm_lapic_reset().
  2886		 */
  2887		vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
  2888		static_branch_inc(&apic_sw_disabled.key); /* sw disabled at reset */
  2889		kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
  2890	
  2891		/*
  2892		 * Defer evaluating inhibits until the vCPU is first run, as this vCPU
  2893		 * will not get notified of any changes until this vCPU is visible to
  2894		 * other vCPUs (marked online and added to the set of vCPUs).
  2895		 *
  2896		 * Opportunistically mark APICv active as VMX in particularly is highly
  2897		 * unlikely to have inhibits.  Ignore the current per-VM APICv state so
  2898		 * that vCPU creation is guaranteed to run with a deterministic value,
  2899		 * the request will ensure the vCPU gets the correct state before VM-Entry.
  2900		 */
  2901		if (enable_apicv) {
  2902			apic->apicv_active = true;
  2903			kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
  2904		}
  2905	
  2906		return 0;
  2907	nomem_free_apic:
  2908		kfree(apic);
  2909		vcpu->arch.apic = NULL;
  2910	nomem:
  2911		return -ENOMEM;
  2912	}
  2913	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

