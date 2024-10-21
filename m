Return-Path: <linux-kernel+bounces-373751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBA09A5C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B080F1F222FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1B1D1509;
	Mon, 21 Oct 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbIKYJUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C41D0DF6;
	Mon, 21 Oct 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494310; cv=none; b=LWKF2g+gwsEEwA1wgJI/hkVgqe6rP72E4Rbv8yYViXFCxl1A2Fb2QOsWJcCk8uKfwAUK71OKP86YuOiTkuzboPhLG5Rr/U/osigUaq5loc4ty4s96dznXKpgxbjJFGU0X6Le/m8Fqln+3QxXUwz2djGRX7lRlLcBNXF0TP6O/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494310; c=relaxed/simple;
	bh=T0lSlyP7R84EiF1GQGIg1mzN+miJurdQdvG4OYlGKoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz3/9y7l8IA90H+Kn7N4DJoVVIdlHxeaT6f1bRqg8RwC3/DIQXZa/cdbqCArTOT55dqsmzP0TmNsjvF4Y8+Sc6vKLW5yIpFB5yUEk63KIxyuek7suxjov3LAWq7hbQ/sot0vf5BqY3gAKdfNwBTZa92k/qSmsI7xKoT6XGY+9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbIKYJUF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729494308; x=1761030308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0lSlyP7R84EiF1GQGIg1mzN+miJurdQdvG4OYlGKoA=;
  b=MbIKYJUFrqx4ochYlbOM72KNegZZ1RWxrcl3gLEDssa8mRQLiU9xRZmM
   VMlBRYkj3yR0gyRX++iaQ+hTEfG4lYgmO/ORSUxqLBk0jyTQ0sbo6Z/AL
   tpEitNJ4BHKl60qVk9c6FAqrmpqe1VYDlNeVTFGj6h+fJl0Udem7vmK6v
   A3QmiDKu6SEHr9L0wnpv/o0VKRj2NzTDqF7tsVKa1h3xhktgA4U35WMwK
   0jWLa+BnhetbnYGSVjanaXPtsNaR7lE1z+0R4dwERKXvLzIh/NoCAy/+1
   YPRQlSDcrKpxgcL7uP7e73NS381c/cbc54TwNRSe+O5CI5H2H0Wbr+XHt
   Q==;
X-CSE-ConnectionGUID: ujs366P/QxeGo+1thuqDSg==
X-CSE-MsgGUID: rGsGpRosT86W6uWWRh+WqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29174696"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29174696"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:04:51 -0700
X-CSE-ConnectionGUID: h1U1MF4tRXWrMcHG+thBiA==
X-CSE-MsgGUID: Kxqmup7cS8+LDvrNbB9/cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="116892422"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Oct 2024 00:04:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2mT5-000RIp-2R;
	Mon, 21 Oct 2024 07:04:43 +0000
Date: Mon, 21 Oct 2024 15:04:39 +0800
From: kernel test robot <lkp@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, will@kernel.org,
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
Message-ID: <202410211410.nrFYq3s2-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20241021/202410211410.nrFYq3s2-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410211410.nrFYq3s2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211410.nrFYq3s2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:2140,
                    from arch/openrisc/kernel/asm-offsets.c:23:
   include/linux/spinlock.h: In function 'spin_lock_irq_disable':
>> include/linux/spinlock.h:275:41: error: implicit declaration of function '_raw_spin_lock_irq_disable'; did you mean 'raw_spin_lock_irq_disable'? [-Wimplicit-function-declaration]
     275 | #define raw_spin_lock_irq_disable(lock) _raw_spin_lock_irq_disable(lock)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:383:9: note: in expansion of macro 'raw_spin_lock_irq_disable'
     383 |         raw_spin_lock_irq_disable(&lock->rlock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h: In function 'spin_unlock_irq_enable':
>> include/linux/spinlock.h:279:49: error: implicit declaration of function '_raw_spin_unlock_irq_enable'; did you mean 'raw_spin_unlock_irq_enable'? [-Wimplicit-function-declaration]
     279 | #define raw_spin_unlock_irq_enable(lock)        _raw_spin_unlock_irq_enable(lock)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:413:9: note: in expansion of macro 'raw_spin_unlock_irq_enable'
     413 |         raw_spin_unlock_irq_enable(&lock->rlock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/openrisc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +275 include/linux/spinlock.h

   273	
   274	#define raw_spin_lock_irq(lock)		_raw_spin_lock_irq(lock)
 > 275	#define raw_spin_lock_irq_disable(lock)	_raw_spin_lock_irq_disable(lock)
   276	#define raw_spin_lock_bh(lock)		_raw_spin_lock_bh(lock)
   277	#define raw_spin_unlock(lock)		_raw_spin_unlock(lock)
   278	#define raw_spin_unlock_irq(lock)	_raw_spin_unlock_irq(lock)
 > 279	#define raw_spin_unlock_irq_enable(lock)	_raw_spin_unlock_irq_enable(lock)
   280	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

