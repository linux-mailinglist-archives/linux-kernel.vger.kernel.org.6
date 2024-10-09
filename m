Return-Path: <linux-kernel+bounces-356250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932F995E82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F06A1F25E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799092AE8C;
	Wed,  9 Oct 2024 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3Oz5rqM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A138DC0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447511; cv=none; b=CN+HlJWZnTb2sqD//fWA/qDZotrz+/In9bCs+lGH9VXqy66xsOTK4LUyj+k4JvtoEknIHms8d78Xqi/c2B2xDAWqF042kt/OECAGqMuMV3fqOrcgbGWL26zh7SwgwdMkD7nHVNuvTclSg4d8pTLcrMVgQsxXtHtM8h9oLE5w/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447511; c=relaxed/simple;
	bh=8Er+yHdfDHrQaLKNYOK6lB+0j/HarLTpAfEQ1MPOef0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q1y1NgW6mdUW8QcLanad4PPrL0Jq9vkWpAi4JCyCMn5qMkST1IqaTnBybJ3AZcwrNuL8qzgurSuYnn3qFZ6M8r185WW1wzQyejNSfULAi7V9bTwA8hmNhjkq7XmvBYlzxuBvWf7hP+wT4HapvhZ5HzYUx/vuvuFxqiVQVsXtkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3Oz5rqM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447509; x=1759983509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Er+yHdfDHrQaLKNYOK6lB+0j/HarLTpAfEQ1MPOef0=;
  b=j3Oz5rqMb0f/lGLZ5hNA55s4qGu78/wJDyrBoQ27gDl9DLEh7QI29ZWH
   QMqING7fgr+iB9nu7kN/rqFcif68j2q5AaFJCTxOwyljGaYkP8BwqeKd0
   6NQOQMATsie1d467YoJaJWEW9CQ9p1VAhg1tKLEMp2GGt7kJEh0YiIG7D
   27gN3VUuj+6ozoD4WMI7zfgLa+uc84Ifl1zOWiY3lVP5WgM9AGDiaXB8S
   gtxHJQDrlj1JbzhQseBlNahk1ZcQKzM7mS+vvEyhp/3ugWFDHEr1gBy86
   uwWCI338yJN8bBgfcMy0RzAuERrLj+Chbl63vVUqktHpIeJriI8kSBOST
   Q==;
X-CSE-ConnectionGUID: E6mRdzejTWSP7aNtwOZSWA==
X-CSE-MsgGUID: YWi1rvTLSfmSOtnUZzsfHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27173133"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27173133"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:18:29 -0700
X-CSE-ConnectionGUID: fFfd2I8aT/qNZrJhc5sEJg==
X-CSE-MsgGUID: /IqejYZaTHO9GC85IKK6rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80909188"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 21:18:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syO9Y-0008i8-1Z;
	Wed, 09 Oct 2024 04:18:24 +0000
Date: Wed, 9 Oct 2024 12:17:33 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: arch/x86/kvm/svm/svm.c:597:2: error: use of undeclared identifier
 'kvm_rebooting'
Message-ID: <202410091226.UPCqIMOd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paolo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   75b607fab38d149f232f01eae5e6392b394dd659
commit: ea4290d77bda2bd1f173a86f07aa79b568e0a6f8 KVM: x86: leave kvm.ko out of the build if no vendor module is requested
date:   3 days ago
config: i386-randconfig-012-20241009 (https://download.01.org/0day-ci/archive/20241009/202410091226.UPCqIMOd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091226.UPCqIMOd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091226.UPCqIMOd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kvm/svm/svm.c:597:2: error: use of undeclared identifier 'kvm_rebooting'
     597 |         kvm_rebooting = true;
         |         ^
   1 error generated.
--
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:10: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:31: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:466:13: note: expanded from macro '__unqual_scalar_typeof'
     466 |                 _Generic((x),                                           \
         |                           ^
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:473:15: note: expanded from macro '__unqual_scalar_typeof'
     473 |                          default: (x)))
         |                                    ^
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
>> arch/x86/kvm/svm/avic.c:909:33: error: no member named 'irq_routing' in 'struct kvm'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:530:12: note: expanded from macro '__rcu_dereference_check'
     530 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
>> arch/x86/kvm/svm/avic.c:909:9: error: assigning to 'struct kvm_irq_routing_table *' from incompatible type 'void'
     909 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/svm/avic.c:911:25: error: incomplete definition of type 'struct kvm_irq_routing_table'
     911 |         if (guest_irq >= irq_rt->nr_rt_entries ||
         |                          ~~~~~~^
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/svm/avic.c:912:22: error: incomplete definition of type 'struct kvm_irq_routing_table'
     912 |                 hlist_empty(&irq_rt->map[guest_irq])) {
         |                              ~~~~~~^
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/svm/avic.c:914:26: error: incomplete definition of type 'struct kvm_irq_routing_table'
     914 |                              guest_irq, irq_rt->nr_rt_entries);
         |                                         ~~~~~~^
   include/linux/printk.h:623:42: note: expanded from macro 'pr_warn_once'
     623 |         printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                                 ^~~~~~~~~~~
   include/linux/printk.h:604:30: note: expanded from macro 'printk_once'
     604 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~~
   include/linux/once_lite.h:11:32: note: expanded from macro 'DO_ONCE_LITE'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/linux/once_lite.h:31:9: note: expanded from macro 'DO_ONCE_LITE_IF'
      31 |                         func(__VA_ARGS__);                              \
         |                              ^~~~~~~~~~~
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/svm/avic.c:918:33: error: incomplete definition of type 'struct kvm_irq_routing_table'
     918 |         hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
         |                                  ~~~~~~^
   include/linux/list.h:1163:31: note: expanded from macro 'hlist_for_each_entry'
    1163 |         for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
         |                                      ^~~~
   include/linux/list.h:1152:12: note: expanded from macro 'hlist_entry_safe'
    1152 |         ({ typeof(ptr) ____ptr = (ptr); \
         |                   ^~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/svm/avic.c:918:33: error: incomplete definition of type 'struct kvm_irq_routing_table'
     918 |         hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
         |                                  ~~~~~~^
   include/linux/list.h:1163:31: note: expanded from macro 'hlist_for_each_entry'
    1163 |         for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
         |                                      ^~~~
   include/linux/list.h:1152:28: note: expanded from macro 'hlist_entry_safe'
    1152 |         ({ typeof(ptr) ____ptr = (ptr); \
         |                                   ^~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   17 errors generated.
--
>> arch/x86/kvm/vmx/posted_intr.c:178:3: error: call to undeclared function '__apic_send_IPI_self'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     178 |                 __apic_send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
         |                 ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:10: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:31: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:466:13: note: expanded from macro '__unqual_scalar_typeof'
     466 |                 _Generic((x),                                           \
         |                           ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:473:15: note: expanded from macro '__unqual_scalar_typeof'
     473 |                          default: (x)))
         |                                    ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
>> arch/x86/kvm/vmx/posted_intr.c:286:33: error: no member named 'irq_routing' in 'struct kvm'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                                   ~~~  ^
   include/linux/srcu.h:217:58: note: expanded from macro 'srcu_dereference'
     217 | #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
         |                                                          ^
   include/linux/srcu.h:204:27: note: expanded from macro 'srcu_dereference_check'
     204 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:530:12: note: expanded from macro '__rcu_dereference_check'
     530 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
>> arch/x86/kvm/vmx/posted_intr.c:286:9: error: assigning to 'struct kvm_irq_routing_table *' from incompatible type 'void'
     286 |         irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
         |                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/posted_intr.c:287:25: error: incomplete definition of type 'struct kvm_irq_routing_table'
     287 |         if (guest_irq >= irq_rt->nr_rt_entries ||
         |                          ~~~~~~^
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/vmx/posted_intr.c:288:25: error: incomplete definition of type 'struct kvm_irq_routing_table'
     288 |             hlist_empty(&irq_rt->map[guest_irq])) {
         |                          ~~~~~~^
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/vmx/posted_intr.c:290:26: error: incomplete definition of type 'struct kvm_irq_routing_table'
     290 |                              guest_irq, irq_rt->nr_rt_entries);
         |                                         ~~~~~~^
   include/linux/printk.h:623:42: note: expanded from macro 'pr_warn_once'
     623 |         printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                                 ^~~~~~~~~~~
   include/linux/printk.h:604:30: note: expanded from macro 'printk_once'
     604 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~~
   include/linux/once_lite.h:11:32: note: expanded from macro 'DO_ONCE_LITE'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |                                       ^~~~~~~~~~~
   include/linux/once_lite.h:31:9: note: expanded from macro 'DO_ONCE_LITE_IF'
      31 |                         func(__VA_ARGS__);                              \
         |                              ^~~~~~~~~~~
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/vmx/posted_intr.c:294:33: error: incomplete definition of type 'struct kvm_irq_routing_table'
     294 |         hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
         |                                  ~~~~~~^
   include/linux/list.h:1163:31: note: expanded from macro 'hlist_for_each_entry'
    1163 |         for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
         |                                      ^~~~
   include/linux/list.h:1152:12: note: expanded from macro 'hlist_entry_safe'
    1152 |         ({ typeof(ptr) ____ptr = (ptr); \
         |                   ^~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   arch/x86/kvm/vmx/posted_intr.c:294:33: error: incomplete definition of type 'struct kvm_irq_routing_table'
     294 |         hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
         |                                  ~~~~~~^
   include/linux/list.h:1163:31: note: expanded from macro 'hlist_for_each_entry'
    1163 |         for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
         |                                      ^~~~
   include/linux/list.h:1152:28: note: expanded from macro 'hlist_entry_safe'
    1152 |         ({ typeof(ptr) ____ptr = (ptr); \
         |                                   ^~~
   include/linux/kvm_types.h:11:8: note: forward declaration of 'struct kvm_irq_routing_table'
      11 | struct kvm_irq_routing_table;
         |        ^
   18 errors generated.
..


vim +/kvm_rebooting +597 arch/x86/kvm/svm/svm.c

76ab8161083bfd Sean Christopherson 2023-07-21  594  
0617a769ce16b8 Sean Christopherson 2024-08-29  595  static void svm_emergency_disable_virtualization_cpu(void)
baeb4de7ad12b7 Sean Christopherson 2023-07-21  596  {
6ae44e012f4c35 Sean Christopherson 2023-07-21 @597  	kvm_rebooting = true;
6ae44e012f4c35 Sean Christopherson 2023-07-21  598  
76ab8161083bfd Sean Christopherson 2023-07-21  599  	kvm_cpu_svm_disable();
11d39e8cc43e1c Maxim Levitsky      2022-06-06  600  }
11d39e8cc43e1c Maxim Levitsky      2022-06-06  601  

:::::: The code at line 597 was first introduced by commit
:::::: 6ae44e012f4c35fb67bc61bd0bf1b3c5f504d931 KVM: x86: Force kvm_rebooting=true during emergency reboot/crash

:::::: TO: Sean Christopherson <seanjc@google.com>
:::::: CC: Sean Christopherson <seanjc@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

