Return-Path: <linux-kernel+bounces-417646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585909D570D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541A1F23E72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F827136326;
	Fri, 22 Nov 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ygu8Py1o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113A33DB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238729; cv=none; b=Fq6SfP7BocXhLN2pqh5QMjkIfvb6eejKllq4sI4/rdbH5T3j9HxcMsHQjVR4OG2kwPdJYpYIixwnY5Xsgbw5Od65oohIBQzF73CVydRoEFgwaGXZLKLZBSIwp8vYujxkN8PkmzwQ5k/sIVOabtW9BFkK4L6QeKaGXRdVh3KxHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238729; c=relaxed/simple;
	bh=yiVrQcXcR3SMAvbUrpTSa+FXaytkr2Z0JGz57V2IeNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkLVDKM0+wV7daCNoYRQabn87EqlAmGvHrkljLVpJfHmm+FDbj/HKs2rV40vRmx/7DsrfvPLtK8HSk/j8VN/ljn9vHg1lT176KhMiH6H4l7Qm6B823HSj+oE+9sXZ2haOv/35N8oh2MmYP+CKun0XgH4oSD20/4b7HlFKq0tegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ygu8Py1o; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732238727; x=1763774727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yiVrQcXcR3SMAvbUrpTSa+FXaytkr2Z0JGz57V2IeNg=;
  b=Ygu8Py1o8ipbSppEaY5iAflnKqutLQZVtOsVXdzyb49EgnbgAvK01PV0
   WA9pg11ueem3zLiedbQTfMfpAgF4jEfDiH6Fb++Vzx/Zr2JLkkP0nx/FR
   oSjyc+0W8VX2zWhq6YlddBbTzCY1399XL+BVwSHNT5POx+aH2Zsu3p1H6
   +iWBTxxcwd1OCpIkGcffZ3tOF6uapVhDQTMH393smtrPFenrR+agtzZMM
   yjOP4n4ZALRc2i5LGSqEujylY1SC5IAVK3Sj0sdhc2T4mPQlTc4Cc1JGe
   TFQDnql4f9klSotnrUo/cWop+IOD7Qd6DGEzLnHnnJ2W00Lrb1rREcfqN
   A==;
X-CSE-ConnectionGUID: pJmjXWZmRTOfwebAkvua+g==
X-CSE-MsgGUID: 8wK1zxuISMO2RsbBUf0EbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32239185"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="32239185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:25:26 -0800
X-CSE-ConnectionGUID: 2/1VFleGSW672fzZXAmS6Q==
X-CSE-MsgGUID: Dms7lyKISe+k1DShiPQFzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="91227776"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Nov 2024 17:25:25 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEIQE-0003Y7-2Q;
	Fri, 22 Nov 2024 01:25:22 +0000
Date: Fri, 22 Nov 2024 09:24:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] objtool: Handle different entry size of rodata
Message-ID: <202411220727.UfLx4PU8-lkp@intel.com>
References: <20241119065655.21123-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119065655.21123-4-yangtiezhu@loongson.cn>

Hi Tiezhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc7]
[also build test ERROR on next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/objtool-Handle-various-symbol-types-of-rodata/20241121-131412
base:   v6.12-rc7
patch link:    https://lore.kernel.org/r/20241119065655.21123-4-yangtiezhu%40loongson.cn
patch subject: [PATCH v3 03/10] objtool: Handle different entry size of rodata
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241122/202411220727.UfLx4PU8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220727.UfLx4PU8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220727.UfLx4PU8-lkp@intel.com/

All errors (new ones prefixed by >>):

   check.c: In function 'add_jump_table':
>> check.c:2109:42: error: 'R_LARCH_32_PCREL' undeclared (first use in this function); did you mean 'R_ARC_B22_PCREL'?
    2109 |                     reloc_type(reloc) == R_LARCH_32_PCREL)
         |                                          ^~~~~~~~~~~~~~~~
         |                                          R_ARC_B22_PCREL
   check.c:2109:42: note: each undeclared identifier is reported only once for each function it appears in
   make[5]: *** [tools/build/Makefile.build:105: tools/objtool/check.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile:70: tools/objtool/objtool-in.o] Error 2
   make[3]: *** [Makefile:73: objtool] Error 2
   make[2]: *** [Makefile:1370: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

