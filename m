Return-Path: <linux-kernel+bounces-373818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D19A5D33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E5FB243A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBB1E00BB;
	Mon, 21 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8+3IGt5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8EA1E00B9;
	Mon, 21 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496155; cv=none; b=rofhfdS+c8s6Nwi67LTcYcpLRk/BcyXM66SGtw/lnKPPTRMOlb/PQQNZy8IcRlY68OrfshVyTEa8v28GGyJEq+jHZtDoCF4l4qUlj5JFEIyP9VdCI1m0kafULZ4JyRsuOBx08+tMxeJFiHvZVQcpSVT/4iGY+04Kmm0TTaWm3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496155; c=relaxed/simple;
	bh=eyKMY0O6mnjml0jyJU60F1X055RmKPZvZQ9fciG1aJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Qln1+L+3t7cqjjrCNPISst2rKJuqO6cTQo4aawFQNSECFMQ8I9GF9qRYoW7ahbtAse54ZOXeN1UvwSsp6ASNA7ipndfKSbtavjgcXahYJqxXfYolP1WYZr2i8X6ZtUzDiqh25lwHBbNke/k1H1bYPjxHDDARSzpYDIDrbrtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8+3IGt5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729496154; x=1761032154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyKMY0O6mnjml0jyJU60F1X055RmKPZvZQ9fciG1aJc=;
  b=f8+3IGt5TO5ieDW+ZuCnnZ2s+mSaHm1ic//BS0/U4AJ2+DZx30imBmE8
   eXxCQbAJeOKwpqtmE4KpCUMn19AKLccdD9MLf/nxMMKMsIjXVVgZOolmW
   pEWSVkjttLMR13HBLiFQAvGLytKCAXzy4JO+kBi/OS9b9bQHeT6WCSivn
   56s38w9t5ngb+9tfP6ZzqkSWqxcN0g0bq7WyvFFP/oPYeVPBUKr6HJjtL
   UXp/MJhKGC3mUFX0aOOuqpccUhSpIyKzwyYGqmmYAQ99Ck0qH77FCMj3I
   oqCxzEKEnK6sxBLWteg8SjyvgkrMTNhVZaVKawCerMHGNPXWYZ1oRvACu
   g==;
X-CSE-ConnectionGUID: /CXQnwPgQYmqk+pm0E/xxA==
X-CSE-MsgGUID: sesEj+WJSMe+vaWZoSqn1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40091612"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40091612"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:35:53 -0700
X-CSE-ConnectionGUID: NTez+8RWTUOxNMXAa5/9xw==
X-CSE-MsgGUID: pFsvyB0XT5i66gPjWQKWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79449131"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Oct 2024 00:35:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2mx7-000RKs-1N;
	Mon, 21 Oct 2024 07:35:45 +0000
Date: Mon, 21 Oct 2024 15:35:18 +0800
From: kernel test robot <lkp@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <202410211503.Ri6kGlzj-lkp@intel.com>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018055125.2784186-2-boqun.feng@gmail.com>

Hi Boqun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.12-rc4 next-20241018]
[cannot apply to rust/rust-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boqun-Feng/irq-spin_lock-Add-counted-interrupt-disabling-enabling/20241018-135435
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20241018055125.2784186-2-boqun.feng%40gmail.com
patch subject: [POC 1/6] irq & spin_lock: Add counted interrupt disabling/enabling
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20241021/202410211503.Ri6kGlzj-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410211503.Ri6kGlzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211503.Ri6kGlzj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/um/kernel/asm-offsets.c:1:
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:3:
   In file included from include/linux/sched.h:2140:
>> include/linux/spinlock.h:383:2: error: call to undeclared function '_raw_spin_lock_irq_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     383 |         raw_spin_lock_irq_disable(&lock->rlock);
         |         ^
   include/linux/spinlock.h:275:41: note: expanded from macro 'raw_spin_lock_irq_disable'
     275 | #define raw_spin_lock_irq_disable(lock) _raw_spin_lock_irq_disable(lock)
         |                                         ^
   include/linux/spinlock.h:383:2: note: did you mean 'spin_lock_irq_disable'?
   include/linux/spinlock.h:275:41: note: expanded from macro 'raw_spin_lock_irq_disable'
     275 | #define raw_spin_lock_irq_disable(lock) _raw_spin_lock_irq_disable(lock)
         |                                         ^
   include/linux/spinlock.h:381:29: note: 'spin_lock_irq_disable' declared here
     381 | static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
         |                             ^
>> include/linux/spinlock.h:413:2: error: call to undeclared function '_raw_spin_unlock_irq_enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     413 |         raw_spin_unlock_irq_enable(&lock->rlock);
         |         ^
   include/linux/spinlock.h:279:42: note: expanded from macro 'raw_spin_unlock_irq_enable'
     279 | #define raw_spin_unlock_irq_enable(lock)        _raw_spin_unlock_irq_enable(lock)
         |                                                 ^
   include/linux/spinlock.h:413:2: note: did you mean 'spin_unlock_irq_enable'?
   include/linux/spinlock.h:279:42: note: expanded from macro 'raw_spin_unlock_irq_enable'
     279 | #define raw_spin_unlock_irq_enable(lock)        _raw_spin_unlock_irq_enable(lock)
         |                                                 ^
   include/linux/spinlock.h:411:29: note: 'spin_unlock_irq_enable' declared here
     411 | static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
         |                             ^
   2 errors generated.
   make[3]: *** [scripts/Makefile.build:102: arch/um/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_raw_spin_lock_irq_disable +383 include/linux/spinlock.h

   380	
   381	static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
   382	{
 > 383		raw_spin_lock_irq_disable(&lock->rlock);
   384	}
   385	
   386	#define spin_lock_irqsave(lock, flags)				\
   387	do {								\
   388		raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
   389	} while (0)
   390	
   391	#define spin_lock_irqsave_nested(lock, flags, subclass)			\
   392	do {									\
   393		raw_spin_lock_irqsave_nested(spinlock_check(lock), flags, subclass); \
   394	} while (0)
   395	
   396	static __always_inline void spin_unlock(spinlock_t *lock)
   397	{
   398		raw_spin_unlock(&lock->rlock);
   399	}
   400	
   401	static __always_inline void spin_unlock_bh(spinlock_t *lock)
   402	{
   403		raw_spin_unlock_bh(&lock->rlock);
   404	}
   405	
   406	static __always_inline void spin_unlock_irq(spinlock_t *lock)
   407	{
   408		raw_spin_unlock_irq(&lock->rlock);
   409	}
   410	
   411	static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
   412	{
 > 413		raw_spin_unlock_irq_enable(&lock->rlock);
   414	}
   415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

