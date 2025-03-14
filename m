Return-Path: <linux-kernel+bounces-560708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36502A60881
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3369D17EFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E36149C53;
	Fri, 14 Mar 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+SWCfO5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED613B7AE;
	Fri, 14 Mar 2025 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931687; cv=none; b=a0yUQN2OaJivr3Ft1UBh5mCyXP7o/tPOl+c0x0tzypz8OWdZf7+gwJ+ZIx8Vndm86pApdDP9Y2gRqWMFKePatPJZUf5cIfFg9CLSGOJ8+pMMs7c4j4E5KBLixfqSsykBv+4p/35mg/GbCSNxAsDG5wZ1pq5NF9mg4y7h3xRxBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931687; c=relaxed/simple;
	bh=3ywO26UG2L26JLK96tkGan86X/b1+caxiIYeGclVZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0ql+Q6edEiCGB++06YpbSmQau0wYs/MFu0NgMwheMyX5RSgoupx62FnjTO6oJr28B7ZCdSUKAjOTueClJ7wNfN5XwysVh4U1YTasIiGv12pyS0uLkbxZaDdGnPuhRiUshGmuK5NNuMIB0m+x70viUW3ALIOBtqLXwJvLxovukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+SWCfO5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741931685; x=1773467685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ywO26UG2L26JLK96tkGan86X/b1+caxiIYeGclVZwg=;
  b=j+SWCfO5bt3BsqlacEqms62Tl6Bsmu4+ZPIDZOaHPFhU3+t0oAfmcRk/
   hLOJhVzT5qduAEtJexsJVfW4rVcYG4EqV2/U1Ny4fNasWPZSCF5+VB5YZ
   qWZruTmYbUrKdTtbEeGY3ZZgPXUMcCNL/eeBJrdVhA1taVSjA0tJ5pjQC
   eWM7fBRuIwJK0NhWwJDQjw8kogaaCx1Piq/kdcxIXFn2Rjky5aBW4PQm3
   VkHmzf96RaYx0bDd5/U687EBNWDH9nPZoWDl2dNvLVj0ym80qoBF2GuLk
   covnkxqwkv3Xs+LJSKDDx7PVoWRRUXDZWi9Q4TqldHrsu1rMBGhp+r2F4
   A==;
X-CSE-ConnectionGUID: Ypcc2i/+TVeNJvzc7om7+A==
X-CSE-MsgGUID: TTku93sfS8aS88N55O7Gsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42980396"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42980396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 22:54:45 -0700
X-CSE-ConnectionGUID: StOHNbAiRruTmfjSabklTQ==
X-CSE-MsgGUID: 6Tl881GwSya0uExwGMMMng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="158306835"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Mar 2025 22:54:41 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsy0E-000A96-2y;
	Fri, 14 Mar 2025 05:54:38 +0000
Date: Fri, 14 Mar 2025 13:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Hickey <contact@antoniohickey.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: clippy: disable `addr_of!` and `addr_of_mut`
 macros
Message-ID: <202503141300.7VvqEzvm-lkp@intel.com>
References: <010001958dfeb4c7-0ed042d2-613b-4023-bb91-0c64f8a84fc9-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001958dfeb4c7-0ed042d2-613b-4023-bb91-0c64f8a84fc9-000000@email.amazonses.com>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus shuah-kselftest/kunit shuah-kselftest/kunit-fixes pci/next pci/for-linus linus/master v6.14-rc6 next-20250313]
[cannot apply to rust/rust-block-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Hickey/rust-clippy-disable-addr_of-and-addr_of_mut-macros/20250313-133646
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/010001958dfeb4c7-0ed042d2-613b-4023-bb91-0c64f8a84fc9-000000%40email.amazonses.com
patch subject: [PATCH 2/3] rust: clippy: disable `addr_of!` and `addr_of_mut` macros
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250314/202503141300.7VvqEzvm-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141300.7VvqEzvm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141300.7VvqEzvm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/fs/file.rs:334:18
   |
   334 |         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
   |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros
--
>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/list.rs:179:34
   |
   179 |         unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
   |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros
--
>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/sync/arc.rs:246:18
   |
   246 |         unsafe { core::ptr::addr_of!((*ptr).data) }
   |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros
--
>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/task.rs:260:29
   |
   260 |         let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
   |                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros
--
>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/task.rs:272:19
   |
   272 |         unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
   |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros
--
>> warning: use of a disallowed macro `core::ptr::addr_of`
   --> rust/kernel/workqueue.rs:406:34
   |
   406 |         unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
   |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: use `&raw` instead `addr_of!` (from clippy.toml)
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_macros

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

