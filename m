Return-Path: <linux-kernel+bounces-440951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FF9EC6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3361B169E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F191D7E4F;
	Wed, 11 Dec 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxvYBSWX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2B1D63D6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905225; cv=none; b=cNn6nS1KN4ZWnOz5Gdl609NlBipMomzY6kupT26hu9KhCX/XW4aN1kZZ35lrh2Lw+W7EEG6c1RB3sUZE7Ue2pX2VRNSF5zCSi0yB5SW+Xoyxa4vnkwoZ4/By12GXLYji8EvWNev26AeD5VBgB06RRaF00SeeWFbi0ki1/ThBT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905225; c=relaxed/simple;
	bh=zXMCh5sqct9h/IPu7Bf0WTK+X+p590u/gwwEPWr8FQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=miGiDvBN3IbODlXPEQ02im0OBWYo+oUdk1Wwkj7FhHFqDPqeLS+sb2AcvC/0JnEtAtA2YXoQXpHLxcZsgAuOIbI67i4duiGmIbYfiyWsjaQTLN6Ev84BuFBqRc1SK8ajyuqrgCA3Rchh9E//cSPDxdl+MvtxCv3/soh5YBIa3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxvYBSWX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733905224; x=1765441224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zXMCh5sqct9h/IPu7Bf0WTK+X+p590u/gwwEPWr8FQQ=;
  b=NxvYBSWXYcO8shRx4GBX6lTpPLUPzxYfK3j8PsVbUJySTav6NAWlHENm
   IimBZOpRJNWL+e5bAq8F2CXx7MplSQkQY+Zrx/XJd45+aTv2HTeWhUu31
   rCbscIhgYLEBRMI3x+6p3Vi0FX6G6gYFMDKQRO4NUELzU6fJCLGEYG2cm
   +XPWSOO7ce3Z7KQQUf1Gyk3Ui9o2BDneLI34wY6gnqZlYpTE8NDN1w9lX
   CGgSbqRHiPxU9TiCsv3Gavw0DAF123NmEPv3IlFpo4QWgCf7B2CSQiEVt
   MsanZjvgeo5+OjVItVoEf68VEP7N008f8p7Pr+q9tMcf0aKkcW30yRlF5
   Q==;
X-CSE-ConnectionGUID: si24zXB4RUGhnM7V75mzIw==
X-CSE-MsgGUID: hSpU7ymnTAKK1m1INoXbbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37961064"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37961064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:20:23 -0800
X-CSE-ConnectionGUID: XXOiYFkQSWmcmLkRqjy+8A==
X-CSE-MsgGUID: UbbBLE++TOWEjKd+GDYYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118954187"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 00:20:21 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLHxD-0006R1-1E;
	Wed, 11 Dec 2024 08:20:19 +0000
Date: Wed, 11 Dec 2024 16:19:57 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: error[E0425]: cannot find value `__tracepoint_rust_sample_loaded` in
 crate `$crate::bindings`
Message-ID: <202412111617.7lVvmoPB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f92f4749861b06fed908d336b4dee1326003291b
commit: 91d39024e1b02914cc5e2dbc137908e29b269ce4 rust: samples: add tracepoint to Rust sample
date:   5 weeks ago
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20241211/202412111617.7lVvmoPB-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412111617.7lVvmoPB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111617.7lVvmoPB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `__tracepoint_rust_sample_loaded` in crate `$crate::bindings`
   --> samples/rust/rust_print.rs:87:5
   |
   87 | /     kernel::declare_trace! {
   88 | |         /// # Safety
   89 | |         ///
   90 | |         /// Always safe to call.
   91 | |         unsafe fn rust_sample_loaded(magic: c_int);
   92 | |     }
   | |_____^ not found in `$crate::bindings`
   |
   = note: this error originates in the macro `kernel::declare_trace` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `rust_do_trace_rust_sample_loaded` in crate `$crate::bindings`
   --> samples/rust/rust_print.rs:87:5
   |
   87 | /     kernel::declare_trace! {
   88 | |         /// # Safety
   89 | |         ///
   90 | |         /// Always safe to call.
   91 | |         unsafe fn rust_sample_loaded(magic: c_int);
   92 | |     }
   | |_____^ not found in `$crate::bindings`
   |
   = note: this error originates in the macro `kernel::declare_trace` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

