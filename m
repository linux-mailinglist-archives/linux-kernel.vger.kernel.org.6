Return-Path: <linux-kernel+bounces-238652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA905924D79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E5282C17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56667442C;
	Wed,  3 Jul 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YE+Cu7T5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8B1C2E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972588; cv=none; b=n52jlEFgMkRqghESJP4WsfFp+KZobh/ujYDUUZNbf+wSTaWVW+1R7HQS+PHhQsksxqlO0ezNePbJAcX9ORMQQMAC+pbds7cUCozH7UNvL+YH3haPRgWQ0x5kHZgFvkKJBfvdDUtB58fZ+i4FJszI0hg5SlZ6/2dtI5KjmKoEqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972588; c=relaxed/simple;
	bh=agajvCivFdkzHTcK2qV0G18SpVRD8KhPbNoX4ZI/vJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoUXh0ksFq3NRsFMeVnLkZNsE1ydg7Zc+IVTPYbh0YyQ/Q+PGnZuvK+Gr47Ak8y3Wc4pdQZmCBOqlRLg8Z5ANwr4OEqOtbilKtsMH1y4u9Xv6J4UjMaLnSTCG7JElnAETmo+3DBwvobT6XY0LVpn377jnPKHtJe7emdU193tQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YE+Cu7T5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719972587; x=1751508587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agajvCivFdkzHTcK2qV0G18SpVRD8KhPbNoX4ZI/vJ4=;
  b=YE+Cu7T5mzew7eJxyDfbPbS0chRxxTF4nQDMY/j425cpOgiTF+JHNBjm
   EGn/rDUrKB+p4KQO1/w+ATcF1cXn8OARXBFWVUxtLQeeM/5Je2prMnEd3
   VyZMINj2s4aO9iTKe9QkSYYYVSgyzR58v7sBfmNDBPOqAJexhxcEEZLaJ
   GXt/X9RUHLGp5OIMMKukj8rw/eLevGZd8bLbmPGqkjWAl8qTJ94s+csOm
   /hxzAOYh3ZRWKI2i1MRlcsJDIPVdHE8+wrz+vCr9zmLwT7qFrgLdNcj7x
   X7sZedDikkKiiAwodlNtl/MW3v3dqsfRQjgVP7PC69HRqzNfiqXGYQcL/
   Q==;
X-CSE-ConnectionGUID: iNTmXdTCRsaxA1Rzi1+W7w==
X-CSE-MsgGUID: zdHqDOntRsm/5HBodfhNog==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="42606833"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="42606833"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:09:46 -0700
X-CSE-ConnectionGUID: JbhFs33uQbyIk3a9dhQSnA==
X-CSE-MsgGUID: A4ylhif6SKu74ahUsalp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50702291"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Jul 2024 19:09:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOpRC-000P8j-2Y;
	Wed, 03 Jul 2024 02:09:38 +0000
Date: Wed, 3 Jul 2024 10:09:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <202407030941.LFCgSw4G-lkp@intel.com>
References: <20240701185132.319995-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701185132.319995-5-jesse@rivosinc.com>

Hi Jesse,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.10-rc6 next-20240702]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-pi-Force-hidden-visibility-for-all-symbol-references/20240702-025515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240701185132.319995-5-jesse%40rivosinc.com
patch subject: [PATCH v3 4/4] RISC-V: Use Zkr to seed KASLR base address
config: riscv-randconfig-001-20240703 (https://download.01.org/0day-ci/archive/20240703/202407030941.LFCgSw4G-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240703/202407030941.LFCgSw4G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407030941.LFCgSw4G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined hidden symbol: __pi___fortify_panic
   >>> referenced by fdt_early.c:24 (arch/riscv/kernel/pi/fdt_early.c:24)
   >>>               arch/riscv/kernel/pi/fdt_early.pi.o:(__pi_fdt_early_match_extension_isa) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

