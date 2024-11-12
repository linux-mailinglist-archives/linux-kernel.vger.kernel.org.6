Return-Path: <linux-kernel+bounces-405504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AB9C523D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C91B30FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595720DD78;
	Tue, 12 Nov 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0kBBUyf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BB20DD6A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404243; cv=none; b=o0GFGHfGqqoKyrL+KLUzZd8bWVJhwdKasL19kte7k8d8qtza0QyrzT14KZs53a9NaeyU6cW5mIUso5W7Ww4o+iFulfjoVn+3jIYQR4FRQCTyehVA1ojPoxl45pDDvUaD+lYN6yCh473Oq+5BLd8CbAukUrZdUL61AbvEugEJwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404243; c=relaxed/simple;
	bh=x6RpGeAnIQkUeeqnZeB9oJx8eLP+7qJn7Agivvr1kH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU8eASDfPNhdpZ1BrOf5C1r+h4bM9XKM6xolFnHmTKyNBEGRMv9fMg8bzRduud2fr30zi81o+0idD+Tks8mxQsJuL8JjrSlaQQXBuCxn9itwQkmHn3DTDkWbwqya/Y12LA7gQeetDJbdQD0c4VBkQ4SOExvsRNtBi9RHmtUdlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0kBBUyf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404242; x=1762940242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6RpGeAnIQkUeeqnZeB9oJx8eLP+7qJn7Agivvr1kH0=;
  b=b0kBBUyfBENUJe+rJC4pXXkievIb6u6xKrXdvT6snA8k39iKwmTjx3ug
   VebbZNx7UcjiVI+bZbzIeuHgTvyN5ponuI6owtUAjLnufpwBuKRWv9wkA
   rWWw4wgA0MP/8tsTRx61BO5/hLu76dHjnzDNQkF1OsU1hwgWwG+h9Jye8
   baC4EFnCR73+XPRBPGraYkQ5PJuvZJVy42YsAaSAov2+EeAgxGeOobsTC
   B4QK7z2zIdoS3ZrBF9MS/Dw800XrlXbrLygQgrB9AzEsctMz5EOwUOUVw
   lIpNAgAPwTEAD1xTj2Oo3lZqTFU9166tgOnuciZM2/IFjMQCNzWpKUMyh
   A==;
X-CSE-ConnectionGUID: kyNUcCWvQzW7OmCPDngnFQ==
X-CSE-MsgGUID: BsGhLBECTtyq3bUvhuDpZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31324328"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31324328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:37:21 -0800
X-CSE-ConnectionGUID: hI9Z+u1QTGCwCowQKLlgfg==
X-CSE-MsgGUID: qS5Oh+8QSOOoIlWEEEnIVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87726566"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 01:37:11 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnKd-0000fh-1o;
	Tue, 12 Nov 2024 09:37:07 +0000
Date: Tue, 12 Nov 2024 17:36:43 +0800
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
Message-ID: <202411121742.VK3YF84e-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 931086f2a88086319afb57cd3925607e8cda0a9f]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-introduce-vma_start_read_locked-_nested-helpers/20241112-050531
base:   931086f2a88086319afb57cd3925607e8cda0a9f
patch link:    https://lore.kernel.org/r/20241111205506.3404479-3-surenb%40google.com
patch subject: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
config: um-defconfig (https://download.01.org/0day-ci/archive/20241112/202411121742.VK3YF84e-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121742.VK3YF84e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121742.VK3YF84e-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |         ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:255:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     255 |         case 2: set->sig[1] = -1;
         |                 ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from ipc/msg.c:30:
   In file included from include/linux/mm.h:2234:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from ipc/msg.c:33:
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
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from ipc/msg.c:33:
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
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from ipc/msg.c:33:
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
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> ipc/msg.c:497:20: warning: implicit conversion from 'int' to 'unsigned short' changes value from 32768000 to 0 [-Wconstant-conversion]
     497 |         msginfo->msgseg = MSGSEG;
         |                         ~ ^~~~~~
   include/uapi/linux/msg.h:87:38: note: expanded from macro 'MSGSEG'
      87 | #define MSGSEG (__MSGSEG <= 0xffff ? __MSGSEG : 0xffff)
         |                                      ^~~~~~~~
   include/uapi/linux/msg.h:86:36: note: expanded from macro '__MSGSEG'
      86 | #define __MSGSEG ((MSGPOOL * 1024) / MSGSSZ) /* max no. of segments */
         |                   ~~~~~~~~~~~~~~~~~^~~~~~~~
   63 warnings and 3 errors generated.
--
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   include/linux/mm.h:877:2: error: call to undeclared function 'vma_lock_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     877 |         vma_lock_init(&vma->vm_lock);
         |         ^
   include/linux/mm.h:877:2: note: did you mean 'osq_lock_init'?
   include/linux/osq_lock.h:23:20: note: 'osq_lock_init' declared here
      23 | static inline void osq_lock_init(struct optimistic_spin_queue *lock)
         |                    ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   include/linux/mm.h:877:22: error: no member named 'vm_lock' in 'struct vm_area_struct'
     877 |         vma_lock_init(&vma->vm_lock);
         |                        ~~~  ^
   include/linux/mm.h:878:7: error: no member named 'vm_lock_seq' in 'struct vm_area_struct'
     878 |         vma->vm_lock_seq = UINT_MAX;
         |         ~~~  ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2234:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/tty/tty_port.c:8:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/tty/tty_port.c:266:2: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     266 |         INIT_KFIFO(port->xmit_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:136:69: note: expanded from macro 'INIT_KFIFO'
     136 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
         |                       ~                             ~~~~~~~~~~~~~~~~~~~~~~~^~~
   14 warnings and 3 errors generated.


vim +497 ipc/msg.c

a0d092fc2df845 Pierre Peiffer  2008-04-29  476  
156d9ed1260ee5 Al Viro         2017-07-09  477  static int msgctl_info(struct ipc_namespace *ns, int msqid,
156d9ed1260ee5 Al Viro         2017-07-09  478  			 int cmd, struct msginfo *msginfo)
a0d092fc2df845 Pierre Peiffer  2008-04-29  479  {
2cafed30f150f7 Davidlohr Bueso 2013-07-08  480  	int err;
27c331a1746142 Manfred Spraul  2018-08-21  481  	int max_idx;
5a06a363ef4844 Ingo Molnar     2006-07-30  482  
5a06a363ef4844 Ingo Molnar     2006-07-30  483  	/*
5a06a363ef4844 Ingo Molnar     2006-07-30  484  	 * We must not return kernel stack data.
^1da177e4c3f41 Linus Torvalds  2005-04-16  485  	 * due to padding, it's not enough
^1da177e4c3f41 Linus Torvalds  2005-04-16  486  	 * to set all member fields.
^1da177e4c3f41 Linus Torvalds  2005-04-16  487  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  488  	err = security_msg_queue_msgctl(NULL, cmd);
^1da177e4c3f41 Linus Torvalds  2005-04-16  489  	if (err)
^1da177e4c3f41 Linus Torvalds  2005-04-16  490  		return err;
^1da177e4c3f41 Linus Torvalds  2005-04-16  491  
156d9ed1260ee5 Al Viro         2017-07-09  492  	memset(msginfo, 0, sizeof(*msginfo));
156d9ed1260ee5 Al Viro         2017-07-09  493  	msginfo->msgmni = ns->msg_ctlmni;
156d9ed1260ee5 Al Viro         2017-07-09  494  	msginfo->msgmax = ns->msg_ctlmax;
156d9ed1260ee5 Al Viro         2017-07-09  495  	msginfo->msgmnb = ns->msg_ctlmnb;
156d9ed1260ee5 Al Viro         2017-07-09  496  	msginfo->msgssz = MSGSSZ;
156d9ed1260ee5 Al Viro         2017-07-09 @497  	msginfo->msgseg = MSGSEG;
d9a605e40b1376 Davidlohr Bueso 2013-09-11  498  	down_read(&msg_ids(ns).rwsem);
72d1e611082eda Jiebin Sun      2022-09-14  499  	if (cmd == MSG_INFO)
156d9ed1260ee5 Al Viro         2017-07-09  500  		msginfo->msgpool = msg_ids(ns).in_use;
72d1e611082eda Jiebin Sun      2022-09-14  501  	max_idx = ipc_get_maxidx(&msg_ids(ns));
72d1e611082eda Jiebin Sun      2022-09-14  502  	up_read(&msg_ids(ns).rwsem);
72d1e611082eda Jiebin Sun      2022-09-14  503  	if (cmd == MSG_INFO) {
72d1e611082eda Jiebin Sun      2022-09-14  504  		msginfo->msgmap = min_t(int,
72d1e611082eda Jiebin Sun      2022-09-14  505  				     percpu_counter_sum(&ns->percpu_msg_hdrs),
72d1e611082eda Jiebin Sun      2022-09-14  506  				     INT_MAX);
72d1e611082eda Jiebin Sun      2022-09-14  507  		msginfo->msgtql = min_t(int,
72d1e611082eda Jiebin Sun      2022-09-14  508  		                     percpu_counter_sum(&ns->percpu_msg_bytes),
72d1e611082eda Jiebin Sun      2022-09-14  509  				     INT_MAX);
^1da177e4c3f41 Linus Torvalds  2005-04-16  510  	} else {
156d9ed1260ee5 Al Viro         2017-07-09  511  		msginfo->msgmap = MSGMAP;
156d9ed1260ee5 Al Viro         2017-07-09  512  		msginfo->msgpool = MSGPOOL;
156d9ed1260ee5 Al Viro         2017-07-09  513  		msginfo->msgtql = MSGTQL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  514  	}
27c331a1746142 Manfred Spraul  2018-08-21  515  	return (max_idx < 0) ? 0 : max_idx;
^1da177e4c3f41 Linus Torvalds  2005-04-16  516  }
2cafed30f150f7 Davidlohr Bueso 2013-07-08  517  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

