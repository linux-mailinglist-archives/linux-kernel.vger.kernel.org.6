Return-Path: <linux-kernel+bounces-348444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA05A98E7C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3751F27911
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7109479;
	Thu,  3 Oct 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWJEXH6p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292F11CA0;
	Thu,  3 Oct 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915273; cv=none; b=M+QY22iw8kuoaL9ffPKzS41bqzV/tBNGaemxR7XRWC3kxIwcuq4yy7yRT09o3u9weZl+P2LoQA2vEp+gWR8nGAkpg1w6+QXsGpa0oupr/s+poDdxiWLFcPFJ2RU/B7t31PVZBJwnqSvGleSwfV9hEVlZfOiGFRx0Ghbch47ECM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915273; c=relaxed/simple;
	bh=4jOSy2S5vzvt4SXm1y8gfO76VgZUH7wm+QIBYnhH3Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBhGe0JDoKKVYcJbhouViOQbGFLI9M+ZCw1Jpceox/P9jyy3OgfbMm2+cwqE53YWjKpyW+tVhTRp5vx/htixJnC/J7uA6hpiF548tNDdie4WGS5+D0pgGMgdmQwdQKOlpAGESvhkyiX9FbEQTXPVNEi6UNGxz4ysT5CdVltxzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWJEXH6p; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727915272; x=1759451272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jOSy2S5vzvt4SXm1y8gfO76VgZUH7wm+QIBYnhH3Cg=;
  b=FWJEXH6pFiMldM9nE3x3PMaexwnVe+ympLpzGwsqN0b+pHLt9742g+IU
   lN9cGq0fAJ0vXqPqPLgzyVS4RbpfbDztc1I41bYotK+Gad4+LDpmeRfB1
   ZZOWycPcOIxD9dkHF+PnsPn7o/dFbEqO/x5o2/LcRYXoxeTcJ1qqyXaRE
   cXZjD37oNjaKiOtJVonRNRZktqEQ5nkXmcC0oz2ey3Cg1c8vqbas3U7DB
   onsxZu71E8gu3DrOc410OeEfZ8Djlm9lbah+xVUL46e+5ZBPLJdAgVS4k
   cTzPOZ4IkNwzwWA7tpl4VYJSgxANHiZLM6x1ftk4sqOiSB/Wtu8Eda+gE
   w==;
X-CSE-ConnectionGUID: Q2DkQMeiTayRxeeg8mB9PA==
X-CSE-MsgGUID: G+lGHATQSqqjHrb8KLVI3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30983717"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="30983717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:27:51 -0700
X-CSE-ConnectionGUID: dwjIvjloTeinYpM1Frs8nw==
X-CSE-MsgGUID: xpDUIod3TPOk3JYCsRfp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74293881"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Oct 2024 17:27:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw9h1-000Ujz-0l;
	Thu, 03 Oct 2024 00:27:43 +0000
Date: Thu, 3 Oct 2024 08:27:34 +0800
From: kernel test robot <lkp@intel.com>
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v8 15/29] rust: alloc: introduce `ArrayLayout`
Message-ID: <202410030724.cV9BEoNG-lkp@intel.com>
References: <20241001150008.183102-16-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001150008.183102-16-dakr@kernel.org>

Hi Danilo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/rust-alloc-add-Allocator-trait/20241001-230558
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241001150008.183102-16-dakr%40kernel.org
patch subject: [PATCH v8 15/29] rust: alloc: introduce `ArrayLayout`
config: riscv-randconfig-001-20241002 (https://download.01.org/0day-ci/archive/20241003/202410030724.cV9BEoNG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410030724.cV9BEoNG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410030724.cV9BEoNG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `size_of` in this scope
   --> rust/kernel/alloc/layout.rs:47:31
   |
   47 |         match len.checked_mul(size_of::<T>()) {
   |                               ^^^^^^^ not found in this scope
   |
   help: consider importing this function
   |
   7  + use core::mem::size_of;
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

