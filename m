Return-Path: <linux-kernel+bounces-572114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD0A6C6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0885189E616
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A091372;
	Sat, 22 Mar 2025 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWXLP4+o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED322C80
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602467; cv=none; b=eX6cfHr/K7AZwYsdp0VLCPYzmnueaGkSx1sm1mjiOZzT2UCm6R15Y4Yc7zYZnn4fvJI9TlDoEtgkESFmxnRElKJ3e3q4utF7+gM9jh3qN+73QCigncviRocJp6+Gip1X6mqChb1PCMqWX7pC1F4p1GYBvd7G6BEHIQ1RtPMwNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602467; c=relaxed/simple;
	bh=M8xv6tQ2LU7qmvVTjZQ4cAMNvN9IogQ1DT8myooyGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QACkMFj1s9kLjTI5j+ATHcj6uJAiHT4X/P07bP8RaRPTkheyZXz2EFnSq9TGKlIusGWvTRgil6CRAA8TDJ8QDY8RBKHd9iqNeVtKLxYKYXWVRMQOL4c019WKjlzmkqLuTglKH5WKKTYluujVGUhyApuSiHGhwlri1wYOUpvMcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWXLP4+o; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742602464; x=1774138464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M8xv6tQ2LU7qmvVTjZQ4cAMNvN9IogQ1DT8myooyGvs=;
  b=WWXLP4+ou6m1gAtXtBqoANS9qATnzKNC2W1JCEMrtT+HvOgpuBpx8rQ8
   HujWifqy3xwFKVt8WVMop8I8uzU2oAQi1hC7bSBGnRMzVJzj+L17fCfCg
   FSaxCQ5Zaj1Jh36nknPSjTjZ1qp5p5iWu5l9iorRH33VvovTROsF1hchP
   7G8KpbfvcB+3CNldvL78EWPB7f0oGZy924sXgMve1aKYXwYaexngjnh8B
   y3hiKbEQ4GLpoBGyUxEUcvU25N/nEKug1Sj2mvtqogkV5FmUdcut37HXE
   80MriV7hs6M2usEoHVGLs1qt49vQIW4IVogXFCHYvF/4ZM20OVy6NMyEF
   w==;
X-CSE-ConnectionGUID: 0EcNcDlLTw6JCc4B/tV99w==
X-CSE-MsgGUID: hCyJXOikQyiUJyCKLjp4+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61404818"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="61404818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 17:14:23 -0700
X-CSE-ConnectionGUID: ZtuIOGjnSRKy9miYF0E56Q==
X-CSE-MsgGUID: UMTZuR2IRm+n6LQs1Q+apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="124491901"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2025 17:14:21 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvmTx-0001nb-1V;
	Sat, 22 Mar 2025 00:13:27 +0000
Date: Sat, 22 Mar 2025 08:12:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/include/asm/syscall_wrapper.h:35:14: warning:
 '__se_sys_uselib' alias between functions of incompatible types 'long
 int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long
 int(long unsigned int,  long unsigned int,  long unsigned...
Message-ID: <202503220830.pNu6WllX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
commit: a9ad73295cc1e3af0253eee7d08943b2419444c4 riscv: Fix syscall wrapper for >word-size arguments
date:   1 year ago
config: riscv-randconfig-r122-20250322 (https://download.01.org/0day-ci/archive/20250322/202503220830.pNu6WllX-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250322/202503220830.pNu6WllX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503220830.pNu6WllX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/compat.h:34,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from fs/exec.c:33:
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_uselib' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:124:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(uselib, const char __user *, library)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:124:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(uselib, const char __user *, library)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_execveat' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:2116:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(execveat,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:2116:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(execveat,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_execve' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:2108:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(execve,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   fs/exec.c:2108:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(execve,
    ^~~~~~~~~~~~~~~
--
   In file included from include/linux/compat.h:34,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:93,
                    from mm/mincore.c:15:
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_mincore' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mincore.c:232:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mincore.c:232:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
    ^~~~~~~~~~~~~~~
--
   In file included from include/linux/compat.h:34,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from mm/mlock.c:13:
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_mlock' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:671:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:671:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
    ^~~~~~~~~~~~~~~
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_mlockall' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:754:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(mlockall, int, flags)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:754:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(mlockall, int, flags)
    ^~~~~~~~~~~~~~~
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_munlock' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:689:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:689:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
    ^~~~~~~~~~~~~~~
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_mlock2' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:676:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mlock.c:676:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
    ^~~~~~~~~~~~~~~
--
   In file included from include/linux/compat.h:34,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/backing-dev.h:15,
                    from mm/mmap.c:14:
   arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_brk' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:178:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(brk, unsigned long, brk)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:222:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:178:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    SYSCALL_DEFINE1(brk, unsigned long, brk)
    ^~~~~~~~~~~~~~~
>> arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_remap_file_pages' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:3004:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:3004:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_munmap' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:2994:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:223:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:2994:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:35:14: warning: '__se_sys_mmap_pgoff' alias between functions of incompatible types 'long int(ulong,  ulong,  ulong,  ulong,  ulong,  ulong,  ulong)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
     static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong,  \
                 ^~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:227:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:1432:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: aliased declaration here
     static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
                 ^~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: in expansion of macro '__SYSCALL_SE_DEFINEx'
     __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:233:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:227:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   mm/mmap.c:1432:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
..


vim +35 arch/riscv/include/asm/syscall_wrapper.h

    16	
    17	#define __SYSCALL_SE_DEFINEx(x, prefix, name, ...)					\
    18		static long __se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
    19		static long __se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
    20	
    21	#define SC_RISCV_REGS_TO_ARGS(x, ...)							\
    22		__MAP(x,__SC_ARGS								\
    23		      ,,regs->orig_a0,,regs->a1,,regs->a2					\
    24		      ,,regs->a3,,regs->a4,,regs->a5,,regs->a6)
    25	
    26	#else
    27	/*
    28	 * Use type aliasing to ensure registers a0-a6 are correctly passed to the syscall
    29	 * implementation when >word-size arguments are used.
    30	 */
    31	#define __SYSCALL_SE_DEFINEx(x, prefix, name, ...)					\
    32		__diag_push();									\
    33		__diag_ignore(GCC, 8, "-Wattribute-alias",					\
    34				"Type aliasing is used to sanitize syscall arguments");		\
  > 35		static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong, 	\
    36						ulong)						\
    37				__attribute__((alias(__stringify(___se_##prefix##name))));	\
    38		__diag_pop();									\
    39		static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
    40		static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

