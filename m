Return-Path: <linux-kernel+bounces-373324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E09A5547
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB001F22337
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F13194AD6;
	Sun, 20 Oct 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjEKczbw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81656AA7;
	Sun, 20 Oct 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442821; cv=none; b=W33J3n0snAQZtQRJCd3p9jFSfKn0U29RRb9ELv/PbS2rLCxMXGf5fP86OJx23Yg7VRpzJwmViFHp9HFaieS9NZeeRk/foOJciWCwZ3llCUeMTVhattHVIeunimT5E3RNzqrDruVdf9JPZvoGDe6guyrevYGtQXXpnzR2eHxxIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442821; c=relaxed/simple;
	bh=EWVi1GcxrkqX5S7c3qAcXdg9VPY1LGhqqDRaPzBX8Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Ki+pCxo2lPg2NVTmdujIOFnMPvap8eMNX2B2z5aNLkjd9+gwHOEFE3C7TS4MOFsaZtZ+FtFUx7XraknVaJf9mm+srJOTlwvXUtwrOp1DDItbtT6jyYkG1r7ls3AL3w2k9tb4IHJqfBb4KBHf2Z605WaXqz/kl+TtGDmJBGIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjEKczbw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729442819; x=1760978819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWVi1GcxrkqX5S7c3qAcXdg9VPY1LGhqqDRaPzBX8Rs=;
  b=jjEKczbwspWmk16i4RdHsLqoV3ge2QWwcYk7M9Yb0oXkHEqx9VBLYqRu
   /HOj8XIRB7jz9C9B2CYtgakqsYZr7d5T5GhpQJ1Bw9Z6C3r5P6eCSvxae
   jci17XTu2HtTQEyf9EE9Wd9i8pC2Ly/8pZMFHSySOiKlregaW/2XmwQfR
   ECy1h9hVWMIkZgp70ozH2kFYerwGeXNnJeS6iqwzzMD7LAB29GaATdTWh
   0sGrcZamCbZX5VpgZiyTL4DbeXM6voB7sYbVpxvmwkFLfOuw4o3yPLC6/
   DuOptcpCfJPkSsK7n+q+YCwiIlIC0z3GadNg4rGtwd/ttDL0xXbXi9skA
   Q==;
X-CSE-ConnectionGUID: QtFBghdvTpGo/QPCli9frg==
X-CSE-MsgGUID: 9+qHSpCkSnGSe9p6dcYKpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29138971"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="29138971"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 09:46:58 -0700
X-CSE-ConnectionGUID: URFWmaxgQyO6rCvrW1T5ug==
X-CSE-MsgGUID: Af5LEzOVS2SRH54IU5gHmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79244017"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2024 09:46:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Z4u-000QV3-0f;
	Sun, 20 Oct 2024 16:46:52 +0000
Date: Mon, 21 Oct 2024 00:46:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v3 05/13] rust: hrtimer: allow timer restart from timer
 handler
Message-ID: <202410210020.W6cyMg2D-lkp@intel.com>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-5-59a75cbb44da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-5-59a75cbb44da@kernel.org>

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/rust-time-Add-Ktime-from_ns/20241017-211351
base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
patch link:    https://lore.kernel.org/r/20241017-hrtimer-v3-v6-12-rc2-v3-5-59a75cbb44da%40kernel.org
patch subject: [PATCH v3 05/13] rust: hrtimer: allow timer restart from timer handler
config: um-randconfig-002-20241020 (https://download.01.org/0day-ci/archive/20241021/202410210020.W6cyMg2D-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410210020.W6cyMg2D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410210020.W6cyMg2D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0053]: method `from` has an incompatible type for trait
   --> rust/kernel/hrtimer.rs:282:20
   |
   282 |     fn from(value: bindings::hrtimer_restart) -> Self {
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

