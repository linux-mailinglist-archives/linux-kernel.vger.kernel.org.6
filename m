Return-Path: <linux-kernel+bounces-420511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF689D7BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19004B20DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AA8176AB5;
	Mon, 25 Nov 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLTshtrU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723645003
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732518526; cv=none; b=TfH7lVCkvxHXXNmukYtLd+mMbuP0lo9HZmxWu3rvK3WwLHyewz8m9FLbQCxerxJ7EPA1N9R/Zgm42l44h3/tLCYI+xIGl9JLi59Nn5WBvS9IlPCPnNCOEQytCzUCAYreik62ydHZ8yBVQiGm956O11JvmDYcGjLz414uLEBivXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732518526; c=relaxed/simple;
	bh=WJbXdcgfvguf8CuGHlRWBxJdyi6RsDDATGIB0c4kkz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr67oiSuCReZ5iZsgSJ2EDohe/rlsI/O5U4+mkYgK24Zr8GJutGyiQ8Fiyiblxq6aCg10t5hqa0uOY+Q2i758YSuYXpG8i7/29YYt804XBfSXzxc/l3w+sBn6DW+Yd8fxwumr/3WPFE8cKx49lJd69NB8VClG7LKYo5B6/yE6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLTshtrU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732518524; x=1764054524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJbXdcgfvguf8CuGHlRWBxJdyi6RsDDATGIB0c4kkz8=;
  b=KLTshtrUgQ3feIXaOiJ3qDnWD6TeWSpnO4Q2dF5PB9dZU7+6+s4Rv01U
   RMMEKvthfW3SbzYG+CG4rjETXNtjf+82/zvHxYLOdZCPg0Z2yK6C57I7Y
   vuPYVkRiPfWSuMkdk9QihzoqulGZikobx2xjHtbZpB2adi7lixTL4Ix9+
   bSsQsTsE7EESZOy4YRT1zASM3PeyBgoQ57aTt/pmuQ4bStqXc6L3U7J82
   jIaKQErm6euCDF4sVZpDl+2JOp/0o/Xx3ttaU9ks+op1Ym5z/WN2a5F5F
   xJqDBpWNHpZY/lSbpLi5sCTU5Vhwm4kzr51EgHw6YmVI2QJGyUgVQUCPQ
   w==;
X-CSE-ConnectionGUID: v6QRAxQqTuGz5s30o1uzyQ==
X-CSE-MsgGUID: NzptnrySTqKGgenLVM8mUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="35460733"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="35460733"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 23:08:44 -0800
X-CSE-ConnectionGUID: sI4dlCLDSuaWIaYkIUCAqQ==
X-CSE-MsgGUID: GF7Z3ytISYCEVbkrKznaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="122129776"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Nov 2024 23:08:42 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFTD5-00060n-2j;
	Mon, 25 Nov 2024 07:08:39 +0000
Date: Mon, 25 Nov 2024 15:08:13 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] objtool: Add noinstr validation for static
 branches/calls
Message-ID: <202411251459.P7KctSbw-lkp@intel.com>
References: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>

Hi Josh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12 next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Poimboeuf/jump_label-Add-annotations-for-validating-noinstr-usage/20241125-105905
base:   linus/master
patch link:    https://lore.kernel.org/r/b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe%40kernel.org
patch subject: [PATCH 3/3] objtool: Add noinstr validation for static branches/calls
config: powerpc-motionpro_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251459.P7KctSbw-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251459.P7KctSbw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251459.P7KctSbw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> init/main.c:821:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     821 | DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
         | ^
   include/linux/jump_label.h:430:2: note: expanded from macro 'DEFINE_STATIC_KEY_MAYBE_RO'
     430 |         __PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
         |         ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:51:1: note: expanded from here
      51 | _DEFINE_STATIC_KEY_RO_0
         | ^
   include/linux/jump_label.h:428:39: note: expanded from macro '_DEFINE_STATIC_KEY_RO_0'
     428 | #define _DEFINE_STATIC_KEY_RO_0(name)   DEFINE_STATIC_KEY_FALSE_RO(name)
         |                                         ^
   include/linux/jump_label.h:388:2: note: expanded from macro 'DEFINE_STATIC_KEY_FALSE_RO'
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^
>> init/main.c:822:7: error: a parameter list without types is only allowed in a function definition
     822 |                            randomize_kstack_offset);
         |                            ^
   2 errors generated.


vim +/int +821 init/main.c

4e37958d1288ce Steven Rostedt (VMware  2018-03-26  819) 
8cb37a5974a485 Marco Elver             2022-01-31  820  #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
39218ff4c625db Kees Cook               2021-04-01 @821  DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
39218ff4c625db Kees Cook               2021-04-01 @822  			   randomize_kstack_offset);
39218ff4c625db Kees Cook               2021-04-01  823  DEFINE_PER_CPU(u32, kstack_offset);
39218ff4c625db Kees Cook               2021-04-01  824  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

