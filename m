Return-Path: <linux-kernel+bounces-516571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3EA37421
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3C2189073D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5519191461;
	Sun, 16 Feb 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aORRIOTg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DA18C91F;
	Sun, 16 Feb 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709375; cv=none; b=fvVqhAc0rtY+E+AWTH1n5DsvXHWtp1LTAfA6IMcU18nBdxyFmNO/LQ6q9RCYD3+FQ02FPnDaFWDaDAoQm2Ejfx4N0JH/V4Z1RJbP0Sh5SmG8f4VIUjGPs3acgTg8hQ+MskyBG8r3Kksx4NjIioS0rO5VWK4GCBgulGQ0d18bEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709375; c=relaxed/simple;
	bh=uzjQ5966InuPnGGMdyDjOTWFoAV7hcjkEWlATi0x8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hklg3wcimInYBVkx9yhm3qQl0FkY3kxtS1+ii3HDKzVSRF9VsHE/fy0FHCfomjMGywH6Y66b+QFoivsjtphr0Pq8/JtjuUkvIgcf1aaRkNTev++FWQx2PzmuFAdB4qs/HJ0mHvPG4csQp6DbNSXJC0t/4vjMu50ncP064Cx4m3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aORRIOTg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739709373; x=1771245373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzjQ5966InuPnGGMdyDjOTWFoAV7hcjkEWlATi0x8xc=;
  b=aORRIOTg3sHJ76Tg41Ve24nGOekaREgiQtFO21I9GYUlEv5i/mA9WSB1
   dO4dpBDYN+nhrIRhP2yNOqZ3swI/bJhEur+l99zEZvus37gOzY++90kBn
   bnKK3G42lMHMUOkHOl+JQppYwZsexWZo2wtaVHOV6M6L6m1hvl5AACLa/
   tcx0P+UXAT9u6PN3o9Ipe+aeCsTJUeJ21b6J8L9DVLvgdF4uEifUTNtLf
   zTXmVygYu33Q/LS/lS7H+D2fdRQE8kZCnc76NxBmuv+0sTErKBFi4lJOP
   vfIOYMXOrrzIkeqTlAwe8PG/iGAzEobguMH7/5hoICQMjNnENoo+nINYE
   g==;
X-CSE-ConnectionGUID: Urb+Wx/7QoeShkO/RsyJCw==
X-CSE-MsgGUID: ElNLd6NfQBW47nG9Uf8b/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57810243"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="57810243"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 04:36:13 -0800
X-CSE-ConnectionGUID: J/+Pk537QyqW2XIUOlDd8w==
X-CSE-MsgGUID: fin8e3KDRSSfzdTpStsqfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114777410"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Feb 2025 04:36:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjdsR-001Bud-2G;
	Sun, 16 Feb 2025 12:36:03 +0000
Date: Sun, 16 Feb 2025 20:35:59 +0800
From: kernel test robot <lkp@intel.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com,
	axboe@kernel.dk, benno.lossin@proton.me, bhelgaas@google.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	dwaipayanray1@gmail.com, ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com, gary@garyguo.net,
	gregkh@linuxfoundation.org, joe@perches.com,
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com,
	tmgross@umich.edu, walmeida@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	trintaeoitogc@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
Message-ID: <202502162042.nKMk0Rff-lkp@intel.com>
References: <20250214184550.120775-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214184550.120775-2-trintaeoitogc@gmail.com>

Hi Guilherme,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on pci/next pci/for-linus char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.14-rc2 next-20250214]
[cannot apply to rust/rust-block-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guilherme-Giacomo-Simoes/rust-module-change-author-to-be-a-array/20250215-024906
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20250214184550.120775-2-trintaeoitogc%40gmail.com
patch subject: [PATCH V2 1/2] rust: module: change author to be a array
config: x86_64-randconfig-006-20250216 (https://download.01.org/0day-ci/archive/20250216/202502162042.nKMk0Rff-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502162042.nKMk0Rff-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502162042.nKMk0Rff-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: proc macro panicked
   --> samples/rust/rust_driver_platform.rs:43:1
   |
   43 | / kernel::module_platform_driver! {
   44 | |     type: SampleDriver,
   45 | |     name: "rust_driver_platform",
   46 | |     author: "Danilo Krummrich",
   47 | |     description: "Rust Platform driver",
   48 | |     license: "GPL v2",
   49 | | }
   | |_^
   |
   = help: message: Expected Group
   = note: this error originates in the macro `$crate::module_driver` which comes from the expansion of the macro `kernel::module_platform_driver` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0277]: the trait bound `DriverModule: ModuleMetadata` is not satisfied
   --> samples/rust/rust_driver_platform.rs:43:1
   |
   43 | / kernel::module_platform_driver! {
   44 | |     type: SampleDriver,
   45 | |     name: "rust_driver_platform",
   46 | |     author: "Danilo Krummrich",
   47 | |     description: "Rust Platform driver",
   48 | |     license: "GPL v2",
   49 | | }
   | |_^ the trait `ModuleMetadata` is not implemented for `DriverModule`
   |
   = note: this error originates in the macro `$crate::module_driver` which comes from the expansion of the macro `kernel::module_platform_driver` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error: proc macro panicked
   --> drivers/net/phy/ax88796b_rust.rs:14:1
   |
   14 | / kernel::module_phy_driver! {
   15 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
   16 | |     device_table: [
   17 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
   ...  |
   24 | |     license: "GPL",
   25 | | }
   | |_^
   |
   = help: message: Expected Group
   = note: this error originates in the macro `kernel::module_phy_driver` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

