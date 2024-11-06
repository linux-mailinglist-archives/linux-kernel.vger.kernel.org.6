Return-Path: <linux-kernel+bounces-397307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B89BDA4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD422851E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5282D052;
	Wed,  6 Nov 2024 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZZ9FMkD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109C15E8B;
	Wed,  6 Nov 2024 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852905; cv=none; b=XtWn5+KAyV2p0TQwDyEYqwcb9I1K/90myTqTv4Klzx4ZtEzFD72yeZ1iq8XieThlRIvQ2hkyg/W+9l1HzFJUfgp57Hw7RPDbNbiA8hMjPVwOBtBYOn4ry5q5Ndbiof7Xk1C9w88oPTFXZbVBGlxhzWwuGcJEQal1xJnXd1nSFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852905; c=relaxed/simple;
	bh=112D4tuzI2xIXLLm19Jm49K0UIYLzqkk6fpdRmVG7kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1AiDJWy1Y6yKU/Qjg9gL3Gzqp3EvYNNTiYfuRI/0RLrfznR115blWf16L+QMUhJ415lZSqVchVRVAIFSbKxIY+m8v8BTjGUWPZZQxtPwVfaGbAMrf+yMtWyGSZzSJlUxrSy8hEBz6E6Ty00uIn2nOF0XusbRHawrmpSym++ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZZ9FMkD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730852904; x=1762388904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=112D4tuzI2xIXLLm19Jm49K0UIYLzqkk6fpdRmVG7kA=;
  b=aZZ9FMkDWPxK8Jn1nfZ2MqG701YV3nLQnzMhMV0JUodXh0W/nYkqj8nq
   g6IJ4UYoZNAq4G3cQc68SMkhOn/2p+Cgbsh8V2cUqrqf1phvUW4OKYkwV
   6b+Pa1/spejxiIS3juTVD1M4JwPUr+ffo0cLdn1Dt0/a/d2+mhrakyGyb
   mooPL7ZbWMAfpyNUsGPwa73eNrcBq0KTk6e/1sQZad2XCmhHTyuReA0Z8
   dDKrz9pR3sJfSxwWDenrni7YmeEeGPDchVNbDCG8KPENr9ahiCGwiq2ms
   ByJoN0R2I3BDpPewok/q1kDhMv0dLbJ9Cq+u4/TmKcKSKVZhs9NcPod+l
   Q==;
X-CSE-ConnectionGUID: XWPlrbX7QqqXKWa6q80+RQ==
X-CSE-MsgGUID: v+pEF7cqSLOPOFGCYa667g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30403676"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30403676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 16:28:23 -0800
X-CSE-ConnectionGUID: q8R2r8GiSWKV3znXms6uXg==
X-CSE-MsgGUID: rOQWAb0MTW6mqFrdBLbJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="83766193"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2024 16:27:53 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Ttn-000mdZ-1c;
	Wed, 06 Nov 2024 00:27:51 +0000
Date: Wed, 6 Nov 2024 08:27:36 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair23@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, ojeda@kernel.org,
	boqun.feng@gmail.com, a.hindborg@kernel.org, benno.lossin@proton.me,
	aliceryhl@google.com, tmgross@umich.edu, gary@garyguo.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] rust: bindings: Support some inline static functions
Message-ID: <202411060829.3NoGuTYU-lkp@intel.com>
References: <20241105022143.1087112-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105022143.1087112-1-alistair.francis@wdc.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc6]
[also build test ERROR on linus/master]
[cannot apply to rust/rust-next next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/rust-bindings-Support-some-inline-static-functions/20241105-102435
base:   v6.12-rc6
patch link:    https://lore.kernel.org/r/20241105022143.1087112-1-alistair.francis%40wdc.com
patch subject: [PATCH] rust: bindings: Support some inline static functions
config: um-randconfig-001-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060829.3NoGuTYU-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060829.3NoGuTYU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060829.3NoGuTYU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> cp: cannot stat '/tmp/bindgen/extern.c': No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

