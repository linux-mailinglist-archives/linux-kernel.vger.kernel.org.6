Return-Path: <linux-kernel+bounces-436733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870459E8A11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BC281713
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5F15574E;
	Mon,  9 Dec 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utn89jLV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8579C4;
	Mon,  9 Dec 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716810; cv=none; b=mJrkH5Gg8pBvPiBAbwOY04DkvaV9tpKMXaLGIr/golOqQnti/MfL75Jq6UM5C4Psf4ZtYU5uQt5B5wZ1KQImbUbtbpzCCocgXG3OVXRHDFCP8NPHfh+ZYt00NfeEWP2UwWGFg/OGuknFBTXsbi3RHiaiJVf9c5HMgVHydz2NjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716810; c=relaxed/simple;
	bh=SKExWa1EiW94BLNQGCMH3ghkp+II8fMxh3AXLcVxkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tty8tRduVzhfCbNMSaZTduWDIoV7hH9rIJOzVmSuINbvX2TR1TttCbu6CaE5iAoTuetf1rYvJRioYRV0GjbMZGjgAu7TQe8mJtPhw7p0nviCoaWDu/OvdnKgrz8Ojth35C01TU1Nh9JZHA8qdzWBU4wa7lJrTOe+S6rI2URSrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utn89jLV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733716809; x=1765252809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKExWa1EiW94BLNQGCMH3ghkp+II8fMxh3AXLcVxkJ0=;
  b=Utn89jLVojeS5jt2FDoEbcw5QdZ7r9NxVJ6EgfxP31B/CXPq4zANxtFW
   OxIrN+3VaHElnba/MDbKL5zS5vf7DGSIrkGL3yEVKb3Qf8iDTK4rxQUpm
   a73eMI1BkF5W5/9r4FRBS6SR7W/daZ+znqCASVAa4NxZWlpMgQb5CVzo/
   PTNWXyhsc3mnpbCFX4XfSu4ZHaZ++a6b7oZ2cPpuxc82PQr7vjwnCOjpc
   UtxmnkJgP0M24ikJ6uKRCA/g7VOmHRDuaiYEnRTu8oH5wZZaOdhrXh0pe
   q0McPhv01qTyITZefzfh9rkIaJij6+qay62Id4W7z0a+PQFn/fXnUEBo1
   g==;
X-CSE-ConnectionGUID: z6S7ASUMS0uRzxOQlLKXgQ==
X-CSE-MsgGUID: FfNQie71ROSrIR7woMubNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="21589709"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="21589709"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:00:07 -0800
X-CSE-ConnectionGUID: rDwz0puNRKq2iS3sN4FiEQ==
X-CSE-MsgGUID: T+xgINyBRHKCLt1NKyx6fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125839274"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Dec 2024 20:00:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUwD-0003ll-1G;
	Mon, 09 Dec 2024 04:00:01 +0000
Date: Mon, 9 Dec 2024 11:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: guilherme giacomo simoes <trintaeoitogc@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	walmeida@microsoft.com, fujita.tomonori@gmail.com,
	tahbertschinger@gmail.com
Cc: oe-kbuild-all@lists.linux.dev,
	guilherme giacomo simoes <trintaeoitogc@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] rust: macros: add authors
Message-ID: <202412070956.2hbXpu7r-lkp@intel.com>
References: <20241206192244.443486-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206192244.443486-1-trintaeoitogc@gmail.com>

Hi guilherme,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guilherme-giacomo-simoes/rust-macros-add-authors/20241207-032454
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20241206192244.443486-1-trintaeoitogc%40gmail.com
patch subject: [PATCH] [PATCH] rust: macros: add authors
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20241207/202412070956.2hbXpu7r-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070956.2hbXpu7r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070956.2hbXpu7r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unneeded `return` statement
   --> rust/macros/module.rs:125:9
   |
   125 |         return false;
   |         ^^^^^^^^^^^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
   = note: `-W clippy::needless-return` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::needless_return)]`
   help: remove `return`
   |
   125 -         return false;
   125 +         false
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

