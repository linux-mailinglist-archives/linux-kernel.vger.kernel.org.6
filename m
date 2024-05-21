Return-Path: <linux-kernel+bounces-184619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853678CA9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D1284C18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB45579F;
	Tue, 21 May 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdDnJfKx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E654277
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279019; cv=none; b=SSzgRlLp4V+FB4uPst0zS9YgO1yot/7jylZpYzLTF9Uuc2TcnS/R4ZdBkpd3ddPc3v3kByJgB9DnmtiKIX53UWety1mlWtp722eQ6n1vdDL6ZY+9jMu7Ty+0ZfwT+6WV1d/e+gGdR6+g/vbSC0T5RnXt4mchoIIBtLDaor7LMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279019; c=relaxed/simple;
	bh=EIVvD//jBwLUIZqnAqldAaSFJ5k+6u5rzaPCQ/h6cSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MY5IIewO5GMx8vVt/5trVDuoKDvuK+AQKEztkRa0bGOg1N3JF43zqOJNkogfwEJmqoYYz13YeszQ7fWIvwu9F7Ys0AcuU48Sh8Q2vP86y78qZOoiX3MQCKJffqxgP5+J1dy8GW30andew3M4rbdbI93AhXJLLu+vbdDjI9Gl7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdDnJfKx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716279015; x=1747815015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EIVvD//jBwLUIZqnAqldAaSFJ5k+6u5rzaPCQ/h6cSY=;
  b=QdDnJfKxrMG07NnOX8Dycttu5QI+nkA4wLzDnIRwBnVGP0hCpPs6mBo3
   6A1XBuA3ctF4bV/XiknESTZMHG0SIBtlBXuKOZNO9AHtzRcuCzsFLLiJ1
   AajTeQvZYm/fsKSFviou9h+0bRRyA+wT9FXjrmR8HSjMFg1ga32nYDugo
   r2eigIgEU6uZBAcSW2CEC0Upcf22MDNfSMfLhgux//pkz8EvC5nfNmKlw
   TCAOjUmr+KoFpsrFdwK7C97sFbn9tJp75cPIXQsOJDhaV7fSkw5NC3Lik
   2drXKhR2zO8kGb9MeAq+KSYHH/Nszv/1ULPeiS0d/l8aC/1669Pt8S3Hl
   A==;
X-CSE-ConnectionGUID: OYPqglTYTXq611emufZ1pQ==
X-CSE-MsgGUID: BRXGNs3uQKqEX/vzJmUpSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16242360"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16242360"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 01:10:15 -0700
X-CSE-ConnectionGUID: o77A5059RHSyk+NUT+Dy5w==
X-CSE-MsgGUID: KybhfvFxTLiDB1BzcltNtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="32739998"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 01:10:13 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9KZX-00064i-2X;
	Tue, 21 May 2024 08:10:11 +0000
Date: Tue, 21 May 2024 16:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: include/linux/vmstat.h:522:36: error: arithmetic between different
 enumeration types ('enum node_stat_item' and 'enum lru_list')
Message-ID: <202405211551.VnBA7xye-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
date:   5 months ago
config: riscv-randconfig-002-20240521 (https://download.01.org/0day-ci/archive/20240521/202405211551.VnBA7xye-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405211551.VnBA7xye-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405211551.VnBA7xye-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:4:
   In file included from drivers/gpu/drm/xe/xe_uc_types.h:9:
   In file included from drivers/gpu/drm/xe/xe_guc_types.h:13:
   In file included from drivers/gpu/drm/xe/xe_guc_ct_types.h:10:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 error generated.
--
   In file included from drivers/gpu/drm/xe/xe_pcode.c:9:
   In file included from drivers/gpu/drm/xe/xe_gt.h:9:
   In file included from include/drm/drm_util.h:35:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_pcode.c:74:44: error: variable 'timeout' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
      74 |                 _wait_for_atomic(pcode_mailbox_done(gt), timeout * 1000, 1);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:299:27: note: expanded from macro '_wait_for_atomic'
     299 |         int cpu, ret, timeout = (US) * 1000; \
         |                       ~~~~~~~    ^~
   2 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_wait_user_fence.c:7:
   In file included from include/drm/drm_file.h:39:
   In file included from include/drm/drm_prime.h:37:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_wait_user_fence.c:59:5: error: no previous prototype for function 'check_hw_engines' [-Werror,-Wmissing-prototypes]
      59 | int check_hw_engines(struct xe_device *xe,
         |     ^
   drivers/gpu/drm/xe/xe_wait_user_fence.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      59 | int check_hw_engines(struct xe_device *xe,
         | ^
         | static 
   drivers/gpu/drm/xe/xe_wait_user_fence.c:85:5: error: no previous prototype for function 'xe_wait_user_fence_ioctl' [-Werror,-Wmissing-prototypes]
      85 | int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
         |     ^
   drivers/gpu/drm/xe/xe_wait_user_fence.c:85:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      85 | int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
         | ^
         | static 
   3 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_irq.c:10:
   In file included from drivers/gpu/drm/xe/xe_device.h:12:
   In file included from include/drm/drm_util.h:35:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_irq.c:451:6: error: no previous prototype for function 'xe_irq_reset' [-Werror,-Wmissing-prototypes]
     451 | void xe_irq_reset(struct xe_device *xe)
         |      ^
   drivers/gpu/drm/xe/xe_irq.c:451:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     451 | void xe_irq_reset(struct xe_device *xe)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_irq.c:467:6: error: no previous prototype for function 'xe_gt_irq_postinstall' [-Werror,-Wmissing-prototypes]
     467 | void xe_gt_irq_postinstall(struct xe_gt *gt)
         |      ^
   drivers/gpu/drm/xe/xe_irq.c:467:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     467 | void xe_gt_irq_postinstall(struct xe_gt *gt)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_irq.c:515:5: error: no previous prototype for function 'xe_irq_install' [-Werror,-Wmissing-prototypes]
     515 | int xe_irq_install(struct xe_device *xe)
         |     ^
   drivers/gpu/drm/xe/xe_irq.c:515:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     515 | int xe_irq_install(struct xe_device *xe)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_irq.c:545:6: error: no previous prototype for function 'xe_irq_shutdown' [-Werror,-Wmissing-prototypes]
     545 | void xe_irq_shutdown(struct xe_device *xe)
         |      ^
   drivers/gpu/drm/xe/xe_irq.c:545:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     545 | void xe_irq_shutdown(struct xe_device *xe)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_irq.c:550:6: error: no previous prototype for function 'xe_irq_suspend' [-Werror,-Wmissing-prototypes]
     550 | void xe_irq_suspend(struct xe_device *xe)
         |      ^
   drivers/gpu/drm/xe/xe_irq.c:550:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     550 | void xe_irq_suspend(struct xe_device *xe)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_irq.c:558:6: error: no previous prototype for function 'xe_irq_resume' [-Werror,-Wmissing-prototypes]
     558 | void xe_irq_resume(struct xe_device *xe)
         |      ^
   drivers/gpu/drm/xe/xe_irq.c:558:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     558 | void xe_irq_resume(struct xe_device *xe)
         | ^
         | static 
   7 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_gt_topology.c:8:
   In file included from drivers/gpu/drm/xe/xe_gt.h:9:
   In file included from include/drm/drm_util.h:35:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_gt_topology.c:98:1: error: no previous prototype for function 'xe_gt_topology_count_dss' [-Werror,-Wmissing-prototypes]
      98 | xe_gt_topology_count_dss(xe_dss_mask_t mask)
         | ^
   drivers/gpu/drm/xe/xe_gt_topology.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      97 | unsigned int
         | ^
         | static 
   drivers/gpu/drm/xe/xe_gt_topology.c:104:1: error: no previous prototype for function 'xe_gt_topology_dss_group_mask' [-Werror,-Wmissing-prototypes]
     104 | xe_gt_topology_dss_group_mask(xe_dss_mask_t mask, int grpsize)
         | ^
   drivers/gpu/drm/xe/xe_gt_topology.c:103:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     103 | u64
         | ^
         | static 
   3 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_tuning.c:9:
   In file included from drivers/gpu/drm/xe/xe_gt_types.h:14:
   In file included from drivers/gpu/drm/xe/xe_uc_types.h:9:
   In file included from drivers/gpu/drm/xe/xe_guc_types.h:13:
   In file included from drivers/gpu/drm/xe/xe_guc_ct_types.h:10:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_tuning.c:36:6: error: no previous prototype for function 'xe_tuning_process_gt' [-Werror,-Wmissing-prototypes]
      36 | void xe_tuning_process_gt(struct xe_gt *gt)
         |      ^
   drivers/gpu/drm/xe/xe_tuning.c:36:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      36 | void xe_tuning_process_gt(struct xe_gt *gt)
         | ^
         | static 
   2 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_guc_pc.c:7:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from drivers/gpu/drm/xe/xe_bo_types.h:12:
   In file included from include/drm/ttm/ttm_bo.h:34:
   In file included from include/drm/drm_gem.h:42:
   In file included from include/drm/drm_vma_manager.h:27:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_guc_pc.c:721:5: error: no previous prototype for function 'xe_guc_pc_start' [-Werror,-Wmissing-prototypes]
     721 | int xe_guc_pc_start(struct xe_guc_pc *pc)
         |     ^
   drivers/gpu/drm/xe/xe_guc_pc.c:721:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     721 | int xe_guc_pc_start(struct xe_guc_pc *pc)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_guc_pc.c:771:5: error: no previous prototype for function 'xe_guc_pc_stop' [-Werror,-Wmissing-prototypes]
     771 | int xe_guc_pc_stop(struct xe_guc_pc *pc)
         |     ^
   drivers/gpu/drm/xe/xe_guc_pc.c:771:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     771 | int xe_guc_pc_stop(struct xe_guc_pc *pc)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_guc_pc.c:812:5: error: no previous prototype for function 'xe_guc_pc_init' [-Werror,-Wmissing-prototypes]
     812 | int xe_guc_pc_init(struct xe_guc_pc *pc)
         |     ^
   drivers/gpu/drm/xe/xe_guc_pc.c:812:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     812 | int xe_guc_pc_init(struct xe_guc_pc *pc)
         | ^
         | static 
   4 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_gt.c:11:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from drivers/gpu/drm/xe/xe_bo_types.h:12:
   In file included from include/drm/ttm/ttm_bo.h:34:
   In file included from include/drm/drm_gem.h:42:
   In file included from include/drm/drm_vma_manager.h:27:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_gt.c:211:5: error: no previous prototype for function 'emit_nop_job' [-Werror,-Wmissing-prototypes]
     211 | int emit_nop_job(struct xe_gt *gt, struct xe_engine *e)
         |     ^
   drivers/gpu/drm/xe/xe_gt.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     211 | int emit_nop_job(struct xe_gt *gt, struct xe_engine *e)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_gt.c:245:5: error: no previous prototype for function 'emit_wa_job' [-Werror,-Wmissing-prototypes]
     245 | int emit_wa_job(struct xe_gt *gt, struct xe_engine *e)
         |     ^
   drivers/gpu/drm/xe/xe_gt.c:245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     245 | int emit_wa_job(struct xe_gt *gt, struct xe_engine *e)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_gt.c:596:5: error: no previous prototype for function 'do_gt_reset' [-Werror,-Wmissing-prototypes]
     596 | int do_gt_reset(struct xe_gt *gt)
         |     ^
   drivers/gpu/drm/xe/xe_gt.c:596:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     596 | int do_gt_reset(struct xe_gt *gt)
         | ^
         | static 
   4 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_guc.c:6:
   In file included from drivers/gpu/drm/xe/xe_bo.h:9:
   In file included from drivers/gpu/drm/xe/xe_bo_types.h:12:
   In file included from include/drm/ttm/ttm_bo.h:34:
   In file included from include/drm/drm_gem.h:42:
   In file included from include/drm/drm_vma_manager.h:27:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_guc.c:239:6: error: no previous prototype for function 'guc_write_params' [-Werror,-Wmissing-prototypes]
     239 | void guc_write_params(struct xe_guc *guc)
         |      ^
   drivers/gpu/drm/xe/xe_guc.c:239:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     239 | void guc_write_params(struct xe_guc *guc)
         | ^
         | static 
   drivers/gpu/drm/xe/xe_guc.c:574:6: error: no previous prototype for function 'guc_enable_irq' [-Werror,-Wmissing-prototypes]
     574 | void guc_enable_irq(struct xe_guc *guc)
         |      ^
   drivers/gpu/drm/xe/xe_guc.c:574:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     574 | void guc_enable_irq(struct xe_guc *guc)
         | ^
         | static 
   3 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_dma_buf.c:6:
   In file included from include/linux/dma-buf.h:19:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/xe/xe_dma_buf.c:306:
   drivers/gpu/drm/xe/tests/xe_dma_buf.c:255:6: error: no previous prototype for function 'xe_dma_buf_kunit' [-Werror,-Wmissing-prototypes]
     255 | void xe_dma_buf_kunit(struct kunit *test)
         |      ^
   drivers/gpu/drm/xe/tests/xe_dma_buf.c:255:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     255 | void xe_dma_buf_kunit(struct kunit *test)
         | ^
         | static 
   2 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_ring_ops.c:7:
   In file included from drivers/gpu/drm/xe/xe_gt.h:9:
   In file included from include/drm/drm_util.h:35:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2177:
>> include/linux/vmstat.h:522:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/xe/xe_ring_ops.c:288:20: error: array index 0 is past the end of the array (that has type 'u64[0]' (aka 'unsigned long long[0]')) [-Werror,-Warray-bounds]
     288 |         i = emit_bb_start(job->batch_addr[0], BIT(8), dw, i);
         |                           ^               ~
   drivers/gpu/drm/xe/xe_sched_job_types.h:43:2: note: array 'batch_addr' declared here
      43 |         u64 batch_addr[0];
         |         ^
   drivers/gpu/drm/xe/xe_ring_ops.c:294:20: error: array index 1 is past the end of the array (that has type 'u64[0]' (aka 'unsigned long long[0]')) [-Werror,-Warray-bounds]
     294 |         i = emit_bb_start(job->batch_addr[1], BIT(8), dw, i);
         |                           ^               ~
   drivers/gpu/drm/xe/xe_sched_job_types.h:43:2: note: array 'batch_addr' declared here
      43 |         u64 batch_addr[0];
         |         ^
   3 errors generated.
.


vim +522 include/linux/vmstat.h

9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  519  
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  520  static inline const char *lru_list_name(enum lru_list lru)
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  521  {
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04 @522  	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  523  }
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  524  

:::::: The code at line 522 was first introduced by commit
:::::: 9d7ea9a297e6445d567056f15b469dde13ca4134 mm/vmstat: add helpers to get vmstat item names for each enum type

:::::: TO: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

