Return-Path: <linux-kernel+bounces-381804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2A9B04B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CA285119
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBC1F757E;
	Fri, 25 Oct 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcBA7oKU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790751E1A39;
	Fri, 25 Oct 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864512; cv=none; b=LvasQerYwZJPsIFzZ7OszdfFuLAI3OwkHX6LkW3zCWJYPNKDxFXzhaTuOLPNBUwx2oTtclWqRqrS9RnDfqmwr1QgtQR+4xwEGvToTHOakmiVNwhMrhpLMTE8KJD1J0g0w4ZfDjRt9K3PcfJjz/2FTAx/0V0L7zGnA0jsRv5wUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864512; c=relaxed/simple;
	bh=7NqT3649F1dXeuQNWNY44V3yXWIYCEWHbVLE10r7iAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQOclFdHmeQtNa2blhuO957zeqD04s5FYzEiCf9ji9HXg3bgLLs7R7WGNhSfdEPNaW+EM3HMkTLH1xJ4j4nw9dUsUO7ooipYgxKjp7j5Ux1FdKnbEPw8tkrd3/Tf5nWEr0TFkviGX+S++9WWuaAPMaOaajmC4Q7/z1BAGSeyA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcBA7oKU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864510; x=1761400510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NqT3649F1dXeuQNWNY44V3yXWIYCEWHbVLE10r7iAE=;
  b=mcBA7oKU0yGnldiSiv2oCxlJWhopjigMRv1oN1wpOap/Bjes6zzL99BQ
   haO6eTRWcM+jsAM0kEOSfy48bOTvbvSA3PafY6iDMna4tQJIdnaL2qryD
   Je0bCz3joJalvlGLOyit4Qm5RAnXKt6bhTXXiZgBEKhPnEwhCM7Wn8xNb
   8o92LUKFOJAP8qNKMZWqOpFWWKE23lx5HNRRSzKFXOfIhe63OsDIE2MFC
   eWMo2HilD9Y51nzPHQpbl5+ZRaVo+1mxZVYtO3GTSO1y3ISIgFYAcNRal
   7SM6+bqMPmjx5TY++J8o4ablL0aJdXdJhzYvo5ZIT//DNCXi5x245UhwS
   Q==;
X-CSE-ConnectionGUID: bZlpI/3yQviK0wHq9J6uPQ==
X-CSE-MsgGUID: e3mSbVLpTYWTKmMG+TeR4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46997858"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46997858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:55:10 -0700
X-CSE-ConnectionGUID: 6qxGZX07Trmb36yDd1F4OQ==
X-CSE-MsgGUID: 4rqoCvHUTzWLQ6lBj85Wqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85499018"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2024 06:55:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4KmO-000YK2-2V;
	Fri, 25 Oct 2024 13:55:04 +0000
Date: Fri, 25 Oct 2024 21:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2] rust: kernel: add support for bits/genmask macros
Message-ID: <202410252126.lJKyvEk1-lkp@intel.com>
References: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 91e21479c81dd4e9e22a78d7446f92f6b96a7284]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/rust-kernel-add-support-for-bits-genmask-macros/20241024-222614
base:   91e21479c81dd4e9e22a78d7446f92f6b96a7284
patch link:    https://lore.kernel.org/r/20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea%40collabora.com
patch subject: [PATCH v2] rust: kernel: add support for bits/genmask macros
config: x86_64-buildonly-randconfig-003-20241025 (https://download.01.org/0day-ci/archive/20241025/202410252126.lJKyvEk1-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252126.lJKyvEk1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252126.lJKyvEk1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0015]: cannot call non-const fn `kunit_get_current_test` in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error: `core::ptr::mut_ptr::<impl *mut T>::is_null` is not yet stable as a const fn
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = help: add `#![feature(const_ptr_is_null)]` to the crate attributes to enable
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0015]: cannot call non-const fn `Arguments::<'_>::new_v1` in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `format_args` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0015]: cannot call non-const fn `err` in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error: `Arguments::<'a>::new_const` is not yet stable as a const fn
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = help: add `#![feature(const_fmt_arguments_new)]` to the crate attributes to enable
   = note: this error originates in the macro `format_args` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0658]: referencing statics in constants is unstable
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: see issue #119618 <https://github.com/rust-lang/rust/issues/119618> for more information
   = help: add `#![feature(const_refs_to_static)]` to the crate attributes to enable
   = note: this compiler was built on 2024-04-29; consider upgrading it if it is out of date
   = note: `static` and `const` variables can refer to other `const` variables. A `const` variable, however, cannot refer to a `static` variable.
   = help: to fix this, the value can be extracted to a `const` and then used.
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0015]: cannot call non-const fn `__kunit_do_failed_assertion` in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0015]: cannot call non-const fn `__kunit_abort` in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `kernel::kunit_assert` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0015]: cannot call non-const formatting macro in constants
   --> rust/doctests_kernel_generated.rs:317:16
   |
   317 |     let mask = genmask!(39, 21);
   |                ^^^^^^^^^^^^^^^^
   |
   = note: calls in constants are limited to constant functions, tuple structs and tuple variants
   = note: this error originates in the macro `format_args` which comes from the expansion of the macro `genmask` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

