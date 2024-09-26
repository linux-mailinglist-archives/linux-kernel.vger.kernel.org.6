Return-Path: <linux-kernel+bounces-341005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC44987A16
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8412A1F22BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DDD13CABC;
	Thu, 26 Sep 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyAl67OE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D41D5AC5;
	Thu, 26 Sep 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382707; cv=none; b=sbmnSyqjwltl5kKQ64cPsqYiWFuX4/cPI5jEMY/I8sNblSwZEGeSxyaYwg8hAZtC8iZg7i0WODpdEg2ZRaAkXvSR0xFL/z7quP3R+fICdpvKjq/gV7Es1Z4lrZfZvQwk4Q/IxYzcfuvfSSXsiaO7gUmXCoOayR5h9wHDHHB9C54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382707; c=relaxed/simple;
	bh=iZH+ElxSkR/k3giY3/bChPya9hqtm05vBd05Dre3eCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC12E4gGlSBYcPxtSIcJvT2g/thvf5MAzYo45dASu1egnJGcADvANBvBwPIevca5ZHkSDtvuwQMzOgnyb4C4yIR19AcG8TkFsQ+ViAs8o93D2j9HMc4F0xP0hz0mT4fmOCaMqND1K+WNL2QXBgaXFkBGWLEBmVr2J//sQR3QUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyAl67OE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727382705; x=1758918705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZH+ElxSkR/k3giY3/bChPya9hqtm05vBd05Dre3eCo=;
  b=TyAl67OEANA3PQv3xNuIFhp/dVKrO8KMUlsjh13fbnQUBRdKSU8V0+ZC
   2/nDT4nrOJ1G6KmdOXOkba3Xrf1TWr8GcPzT5AzByePH1sEBEeN8wAZFF
   AE95K72rAPZLjnb+3apbrwUO+iC9T0ZETuQqGijJd/N90rMUnlGaaREvA
   v7rcHNyIHhzI/Wu7R0+Xv+tirco3nK42wIWYeggALW2U8Ut39Eyd/E05/
   aqvk2auxQYd8oGjBeO/oyo9vkApkH1Fgqn5XAldK4pb/yC605CbHnJvzi
   9Kcaj2etxI03ZFQw+ScGy5qr62klXLJX4UcrrpqWbz1WBGQULP+9MTJJm
   w==;
X-CSE-ConnectionGUID: FmDZhE5oQGqH46ZBSheuug==
X-CSE-MsgGUID: Y3GThOwMRxqce+XBBFxZzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26690288"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26690288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 13:31:45 -0700
X-CSE-ConnectionGUID: gldxkRZZR7+N+/ya0A+Skg==
X-CSE-MsgGUID: Zerset9BTJazvYoEY6zslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="76657648"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Sep 2024 13:31:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stv9H-000LAt-1X;
	Thu, 26 Sep 2024 20:31:39 +0000
Date: Fri, 27 Sep 2024 04:31:33 +0800
From: kernel test robot <lkp@intel.com>
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <202409270303.kUIAmOmY-lkp@intel.com>
References: <20240925205244.873020-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925205244.873020-2-benno.lossin@proton.me>

Hi Benno,

kernel test robot noticed the following build errors:

[auto build test ERROR on a2f11547052001bd448ccec81dd1e68409078fbb]

url:    https://github.com/intel-lab-lkp/linux/commits/Benno-Lossin/rust-add-untrusted-data-abstraction/20240926-045445
base:   a2f11547052001bd448ccec81dd1e68409078fbb
patch link:    https://lore.kernel.org/r/20240925205244.873020-2-benno.lossin%40proton.me
patch subject: [PATCH v2 1/2] rust: add untrusted data abstraction
config: x86_64-buildonly-randconfig-002-20240927 (https://download.01.org/0day-ci/archive/20240927/202409270303.kUIAmOmY-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409270303.kUIAmOmY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409270303.kUIAmOmY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0004]: non-exhaustive patterns: `Err(_)` not covered
   --> rust/kernel/validate.rs:188:15
   |
   188 |         match unsafe { value.__init(ptr) } {
   |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ pattern `Err(_)` not covered
   |
   note: `core::result::Result<(), Infallible>` defined here
   --> /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/result.rs:502:1
   |
   502 | pub enum Result<T, E> {
   | ^^^^^^^^^^^^^^^^^^^^^
   ...
   511 |     Err(#[stable(feature = "rust1", since = "1.0.0")] E),
   |     --- not covered
   = note: the matched value is of type `core::result::Result<(), Infallible>`
   help: ensure that all possible cases are being handled by adding a match arm with a wildcard pattern or an explicit pattern as shown
   |
   189 ~             Ok(()) => {},
   190 +             Err(_) => todo!()
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

