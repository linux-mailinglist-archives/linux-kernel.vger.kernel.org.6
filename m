Return-Path: <linux-kernel+bounces-334405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33097D6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E44A287219
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958317BB3F;
	Fri, 20 Sep 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys8hyTci"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4C17838C;
	Fri, 20 Sep 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842360; cv=none; b=Q8hMJDdBEX/Md4C3R9ffrfEVv8tsqbEUBJIbG3xa+T/RhhEYY3FoZWJ9r9aBIJkuam9wNKDG4Q6nEPxXNwUuMcMURWqcFloHuWrPF+daAGsvEj4CKaNwX7jXuCfEtW45/E7q37Wx9leBcB1CtsHja+J7KY2vSdRnsAZL/M1XZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842360; c=relaxed/simple;
	bh=+9pRaSgM2TSiWBfyUh9smEH2QqQGRBBKZosdi4yEFq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAvP1ZC02cnlZYwGfj4HsKJdB4t+K5Ri9tu+X+DY8QzujBpicIrkBWlHrhLe7y1OSv/lPSsyKMyPvPC4tZdCv+IgYU12SEnpAQ8PR/JqnJtNC9Ezzz8hAHB5K2bMdo5DYLYoSoSCk1q6rUAvWAsPpf2+wg8lI0QMRU2oSK2yCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys8hyTci; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726842359; x=1758378359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9pRaSgM2TSiWBfyUh9smEH2QqQGRBBKZosdi4yEFq4=;
  b=Ys8hyTciVuBuEzAcKnr12MVmsp5/tewehsRW85axyM5eHLt0M4H0kEOQ
   SavJh1Fe2Xeuo0bS4Iyn9TjABDRKBUV41JLEUpLaG612GkGhL98Zf1xS5
   shTAlRsFpok4h1x8SResBEpwqv58CYNQvsncHIhapC/rAlr3Ry80LmvEw
   ow2pPItnVl9agXzqSDdFJACvLF/pkyBjhmRyKoWxYPj6gCqcrCc7fqcUW
   vSxxq0+bGZwt+7qVN9WpDGbcaFT5OypFFF/8dhrLa3ciusCTcVyByKoF5
   xWGK9aI4zyHake3K02uEjK4c07e+5Upn1i9EkmlTDkyPbcsYycnWf+IqY
   A==;
X-CSE-ConnectionGUID: W2eceG8oTTOUBnxU28g6YA==
X-CSE-MsgGUID: k8odHNbrRVmaZ4Ludhzt7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="28747481"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="28747481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:25:58 -0700
X-CSE-ConnectionGUID: 5uot3sBDR6OXPe60tNX0Cw==
X-CSE-MsgGUID: +U59R566SqKvf6rhEoeCGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70448960"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Sep 2024 07:25:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srea0-000EX3-1L;
	Fri, 20 Sep 2024 14:25:52 +0000
Date: Fri, 20 Sep 2024 22:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] rust: hrtimer: allow timer restart from timer
 handler
Message-ID: <202409202251.Sfvd2aUn-lkp@intel.com>
References: <20240917222739.1298275-7-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917222739.1298275-7-a.hindborg@kernel.org>

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 98f7e32f20d28ec452afb208f9cffc08448a2652]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/rust-time-Add-Ktime-from_ns/20240918-063405
base:   98f7e32f20d28ec452afb208f9cffc08448a2652
patch link:    https://lore.kernel.org/r/20240917222739.1298275-7-a.hindborg%40kernel.org
patch subject: [PATCH v2 06/14] rust: hrtimer: allow timer restart from timer handler
config: riscv-randconfig-002-20240920 (https://download.01.org/0day-ci/archive/20240920/202409202251.Sfvd2aUn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409202251.Sfvd2aUn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409202251.Sfvd2aUn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
   |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
   clang diag: include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>> error[E0053]: method `from` has an incompatible type for trait
   --> rust/kernel/hrtimer.rs:316:20
   |
   316 |     fn from(value: bindings::hrtimer_restart) -> Self {
   |                    ^^^^^^^^^^^^^^^^^^^^^^^^^
   |                    |
   |                    expected `u32`, found `i32`
   |                    help: change the parameter type to match the trait: `u32`
   |
   = note: expected signature `fn(u32) -> TimerRestart`
   found signature `fn(i32) -> TimerRestart`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

