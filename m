Return-Path: <linux-kernel+bounces-197569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8E8D6C92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB41C23DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7E8174E;
	Fri, 31 May 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxvKrD5h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE438172E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195462; cv=none; b=pmL2chL8WjgAZV97eWt69Bocb41mIA/kdsOvDBtFlvKoDtjxSHFUff4fufs1XLR7rJRxs7xWAjduFbayBZ/2Z8pdeXlYVg5PYHwJ/BcAIBWPwW8dYsWTNXs6st7wFVSyD3U6EAzZ+/o/LJiH+4Jh9QpRyyutMzZuALjZ88qasHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195462; c=relaxed/simple;
	bh=Sus4y6UmNR5dzGV4IzmSLrPvvrNGonDyWCvKjZx6etY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oROkJZXF6jW1sR8W9+GDDoFLS6cn+mZUqpdcoLG18YyedDO5ytNOi21vGByGXYXqdBKniWhZi5leNEBQNKBl9I1rCErcFgmEy5kjYilCAy5YtR/9jTrM5vvXzgl26Znc1UsIMn/2lVkJtjkJmwXkCuML4EaPRP+7SZjEHwKxTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxvKrD5h; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717195461; x=1748731461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sus4y6UmNR5dzGV4IzmSLrPvvrNGonDyWCvKjZx6etY=;
  b=hxvKrD5hra1wLW3qK0yRhSiB5AicBGB/ra6yy0MEhMUvXHnqtaXbTbgG
   6sTIi5NCmHZp8yqkTfzEPnYKbKya2mUdAY1auwKI4W1rCwyiFiE30IsG0
   0hM+c/VypCR+sBdiJSk5OFAaDeKx9z7Nn51NYcTJcIvDAEgoWpqcnneHS
   RekTa6le5G2kdggN/Qh68u9aXnyOGLSS+Qtc9Fxqrc1c7se0ZR8fqBX9L
   YDfWfVVzpngrLbm7V3NbCe8NKrVk4KOM9Vyn1H+STrcwq58W+kot2Jmnl
   r9Za93X25/Z8LjSDGqH/dN+FT0xDSr9bWEHNWEvN3n6XjJBh5n1S846Jg
   Q==;
X-CSE-ConnectionGUID: to1FvddiSZq1C/3nsJh1/g==
X-CSE-MsgGUID: 4JEnU4CoSl2ab6xgql7sbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13882286"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13882286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:44:20 -0700
X-CSE-ConnectionGUID: ngmWe3QmTvmwk9vRxe5PZg==
X-CSE-MsgGUID: 76dvYXejRtWErjwhEgsmwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="41223266"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 31 May 2024 15:44:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDAys-000HxN-1J;
	Fri, 31 May 2024 22:44:14 +0000
Date: Sat, 1 Jun 2024 06:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <202406010606.hHFDxmHY-lkp@intel.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531162327.2436962-1-jesse@rivosinc.com>

Hi Jesse,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-Use-Zkr-to-seed-KASLR-base-address/20240601-002545
base:   linus/master
patch link:    https://lore.kernel.org/r/20240531162327.2436962-1-jesse%40rivosinc.com
patch subject: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240601/202406010606.hHFDxmHY-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010606.hHFDxmHY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010606.hHFDxmHY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __pi__printk
   >>> referenced by __pi_archrandom_early.c
   >>>               arch/riscv/kernel/pi/archrandom_early.pi.o:(__pi_get_kaslr_seed_zkr) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

