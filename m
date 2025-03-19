Return-Path: <linux-kernel+bounces-568801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046DDA69A92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B477A257B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E2215078;
	Wed, 19 Mar 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsObby/p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238D212FA0;
	Wed, 19 Mar 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418375; cv=none; b=talVQkiZV2Z4O6jI+7SlGJlzHRlohc67dhAzMV4Z4Cxn9YiGBjSTk6d7SrLc+NuWz+fUdvcYnqYhLTr1id9Dp+631eCyVI/+ctv/Yz0M0GRihmjaTDsK5ruLi2EoDBQDiS4awdj9sIgFwetyntYP0wJFZUVh468DY0uwD1T/kH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418375; c=relaxed/simple;
	bh=e6HUDFunHFfYtPY/EoRGxpqtTPMlKnvDcmj4WUBULSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO+owXcMJa5t0AhMB2VVVV89uASACJ1tfHnFw6O9rMeYvYlJaHHyT+peeV7qhQc931BoGBPw2dIUzwuaMvD08woRYivEZdqxynR7RIL/WE10gMJ5GVwMZqI3S0M23NqrTVGKjtyhv6iEJ7fXkFFfKPW1O9pTRp/q2pnK1IX+2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsObby/p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742418373; x=1773954373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e6HUDFunHFfYtPY/EoRGxpqtTPMlKnvDcmj4WUBULSs=;
  b=gsObby/p8zCJJsRdKEJxomcWqdY/zu1TgS7CHpr+nKKWmec9yn4darSe
   +MOozQtCqRR8uBjdOTUNems3y2B2j4UQQGCgIrAIxM8hXqc4Ubw1vAUt4
   Qac23pi17wyMbQe5PbDjw2iqcQWpWQXtDozZe3efAScMBBr6NfgfZiCxX
   V1Psw4XiuS7pYyvrXrZ9j81BeoJM6Rku0gpgUGa97e2iaOoH3Wpusarnu
   Wbb9e8bAMAdTCqGBN9DzH7Vh4FRYb6uQmBJWAm66SQQDJ/Pkw1UeP0nVX
   TdctO2pfx5k+eCCHr6pukwKLDuiNRXEredQZqLtFh4zayWExc082gM6f8
   w==;
X-CSE-ConnectionGUID: mC7oJn+pT1qqnmA6lNS7Aw==
X-CSE-MsgGUID: VIPWKFtcSrq+nuHzfUn+xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="61021784"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="61021784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:06:12 -0700
X-CSE-ConnectionGUID: e9lDKsTWTASy50Bmpe8jwQ==
X-CSE-MsgGUID: 5VXOzZZ9QaOhoa2RqDshkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122618558"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Mar 2025 14:06:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv0bU-000FfG-08;
	Wed, 19 Mar 2025 21:05:49 +0000
Date: Thu, 20 Mar 2025 05:05:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Cc: oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <202503200447.aF1NxDEq-lkp@intel.com>
References: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cf25bc61f8aecad9b0c45fe32697e35ea4b13378]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/rust-alloc-replace-Vec-set_len-with-inc_len/20250317-103338
base:   cf25bc61f8aecad9b0c45fe32697e35ea4b13378
patch link:    https://lore.kernel.org/r/20250316-vec-set-len-v1-2-60f98a28723f%40gmail.com
patch subject: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250320/202503200447.aF1NxDEq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200447.aF1NxDEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200447.aF1NxDEq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: method `dec_len` is never used
   --> rust/kernel/alloc/kvec.rs:205:15
   |
   161 | / impl<T, A> Vec<T, A>
   162 | | where
   163 | |     A: Allocator,
   | |_________________- method in this implementation
   ...
   205 |       unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
   |                 ^^^^^^^
   |
   = note: `#[warn(dead_code)]` on by default

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

