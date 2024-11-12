Return-Path: <linux-kernel+bounces-405520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB889C525E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE522835F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CEE2101B8;
	Tue, 12 Nov 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENFIVRfb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0F20EA20
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404843; cv=none; b=au7uA8ghWnnKW+hFujL/NYYNBehugIrbICK7KOOE+sALrksO11suOdxl0Rb2N26YLmzjcaz5sp2sjb+OSUsaSXLGdoMw0IoSmdIKKU12ofw7S7/SqCI8Xa5sfqHrtVH8HBd9D38XsRH7jIAKl4KKY8oYgersC18y6D9S6028ZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404843; c=relaxed/simple;
	bh=0UQNzu2yoylWuobadC3WUbMF9p/Em6JuBrZB7HyucUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXwhySH628tjphVUA6YlU1T2I/V9xRQ5aCo7ypmmIi3XbEAbUvVy6q0LcOi0LSjCPiGus+O08rndHPop369Dg1YW1OK4fdOJ6eTBg0zCS2vIbsPEngzsAl202P7vFwbXEdCgkv0ggLFGTjoW0eQQWBMYMph7/HkAOLGvla39O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENFIVRfb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404842; x=1762940842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0UQNzu2yoylWuobadC3WUbMF9p/Em6JuBrZB7HyucUk=;
  b=ENFIVRfbmR+gzVx8AMa9s3nT9nPIOld0drDqraIK3V0eMA/gSg8/303H
   RkaHr2A9ThNGh3PfsIRekSof3V8vSsOk7wCPT4X1ahmo1x5o9e1el/Oar
   3PQ/9KMuN41yqrWgwToczznU6Zt9Wz4PqVupVasIGULResEASPI+cfIrG
   oXZkVbh6xYfBIWBD821zoTR7hcDWfPxULVIIMPOQTCRsxaAkQJGevD+8y
   WAbUZWVDlID3s7vNrNp7ih0j1hn3HNy1t48P0inNCXCz/SG9x/tV7SwAW
   kORcki3Qfl5tShkNGi1qGMFpsaNc4Iz40t4MNayGg81b8xvek3Qowf5E9
   w==;
X-CSE-ConnectionGUID: nY5k102QT6aA03Wl8Ie4xA==
X-CSE-MsgGUID: T19/162sQD+y2I1viTsrQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31383972"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31383972"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:47:19 -0800
X-CSE-ConnectionGUID: pikEPHG3Tn++GpNCZJPLQg==
X-CSE-MsgGUID: uCP6iulXQL6ohMeG68rL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92318218"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2024 01:47:12 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnUL-0000gb-0i;
	Tue, 12 Nov 2024 09:47:09 +0000
Date: Tue, 12 Nov 2024 17:47:05 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	surenb@google.com
Subject: Re: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
Message-ID: <202411121745.VmaDStMg-lkp@intel.com>
References: <20241111205506.3404479-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-3-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build errors:

[auto build test ERROR on 931086f2a88086319afb57cd3925607e8cda0a9f]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-introduce-vma_start_read_locked-_nested-helpers/20241112-050531
base:   931086f2a88086319afb57cd3925607e8cda0a9f
patch link:    https://lore.kernel.org/r/20241111205506.3404479-3-surenb%40google.com
patch subject: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20241112/202411121745.VmaDStMg-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121745.VmaDStMg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121745.VmaDStMg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ipc/util.c:47:
>> include/linux/mm.h:877:2: error: call to undeclared function 'vma_lock_init'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           vma_lock_init(&vma->vm_lock);
           ^
   include/linux/mm.h:877:2: note: did you mean 'osq_lock_init'?
   include/linux/osq_lock.h:23:20: note: 'osq_lock_init' declared here
   static inline void osq_lock_init(struct optimistic_spin_queue *lock)
                      ^
   In file included from ipc/util.c:47:
   include/linux/mm.h:877:22: error: no member named 'vm_lock' in 'struct vm_area_struct'
           vma_lock_init(&vma->vm_lock);
                          ~~~  ^
   include/linux/mm.h:878:7: error: no member named 'vm_lock_seq' in 'struct vm_area_struct'
           vma->vm_lock_seq = UINT_MAX;
           ~~~  ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/util.c:47:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
--
   In file included from ipc/msgutil.c:9:
   In file included from include/linux/security.h:33:
>> include/linux/mm.h:877:2: error: call to undeclared function 'vma_lock_init'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           vma_lock_init(&vma->vm_lock);
           ^
   include/linux/mm.h:877:2: note: did you mean 'osq_lock_init'?
   include/linux/osq_lock.h:23:20: note: 'osq_lock_init' declared here
   static inline void osq_lock_init(struct optimistic_spin_queue *lock)
                      ^
   In file included from ipc/msgutil.c:9:
   In file included from include/linux/security.h:33:
   include/linux/mm.h:877:22: error: no member named 'vm_lock' in 'struct vm_area_struct'
           vma_lock_init(&vma->vm_lock);
                          ~~~  ^
   include/linux/mm.h:878:7: error: no member named 'vm_lock_seq' in 'struct vm_area_struct'
           vma->vm_lock_seq = UINT_MAX;
           ~~~  ^
   In file included from ipc/msgutil.c:9:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from ipc/msgutil.c:9:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from ipc/msgutil.c:9:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   12 warnings and 3 errors generated.
--
   In file included from ipc/msg.c:30:
>> include/linux/mm.h:877:2: error: call to undeclared function 'vma_lock_init'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           vma_lock_init(&vma->vm_lock);
           ^
   include/linux/mm.h:877:2: note: did you mean 'osq_lock_init'?
   include/linux/osq_lock.h:23:20: note: 'osq_lock_init' declared here
   static inline void osq_lock_init(struct optimistic_spin_queue *lock)
                      ^
   In file included from ipc/msg.c:30:
   include/linux/mm.h:877:22: error: no member named 'vm_lock' in 'struct vm_area_struct'
           vma_lock_init(&vma->vm_lock);
                          ~~~  ^
   include/linux/mm.h:878:7: error: no member named 'vm_lock_seq' in 'struct vm_area_struct'
           vma->vm_lock_seq = UINT_MAX;
           ~~~  ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
..


vim +/vma_lock_init +877 include/linux/mm.h

   868	
   869	static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
   870	{
   871		memset(vma, 0, sizeof(*vma));
   872		vma->vm_mm = mm;
   873		vma->vm_ops = &vma_dummy_vm_ops;
   874		INIT_LIST_HEAD(&vma->anon_vma_chain);
   875		vma_mark_detached(vma, false);
   876		vma_numab_state_init(vma);
 > 877		vma_lock_init(&vma->vm_lock);
   878		vma->vm_lock_seq = UINT_MAX;
   879	}
   880	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

