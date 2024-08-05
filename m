Return-Path: <linux-kernel+bounces-274419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D39477E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9746E1C210E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F61514C8;
	Mon,  5 Aug 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RY21xRkB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5D1494DA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848616; cv=none; b=ZSzIEALCnbVs4X60zLL+zIs8n0wIhTKAjA4oPaxapm2NVRLICQrBH87Yenhr7D7mkYSV1j+xBylYqB7/HKDV5s/u0zFq2s/Kf9R7rcsFMb1hDa8JQyYVUayyrw3658mPO9+fsglFlATZhBX1vlg4bj95yVNRqhCnFYxh3+7xYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848616; c=relaxed/simple;
	bh=yK6i8cyC5igw8vftsB7CAJmBq3CmbKdfNlHCDnUYX0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9TkY9duK6HxUYj03fSeenDbiVN22dulbZ6Ut1Nhe+bWRGDZNlCDHeLM2IsM70NmYGXA5NZxQRaqi+gAHZbf8ZHbmQAMiQM6Y40WB0bgrXVrXV6SM17ctugL0TkeEBjn+WOOR+4y9ZUu7kryLMrtAJNA36mlNjlI5Mw3Bn+6wHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RY21xRkB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722848614; x=1754384614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yK6i8cyC5igw8vftsB7CAJmBq3CmbKdfNlHCDnUYX0U=;
  b=RY21xRkBeJaoHZICOZlid/pNzB7eQCkWus93M8CRUYIlgmVWF1gMtGMK
   exlTK3FCE4wfrEQg/FzQ9sWlJMxAchVgGTrKZB7DxgcpeVxKsPnyRzN6k
   tNryX1TJd/iVx7Ngkl/hXY2cYV1zKrEpM9Gy8m2DwxTsxLu7gKV7uXBjP
   RUYIvjADQ2wY64v/VKgNt73IbPFhEHf9niU11Y4Xb0vMwk3+gWDpYfI9X
   Q207HkX2qgTSbMzwpAIWeeY47oHQb/kZvU4NV9XZnIED/xuFa7+cOsDtu
   zlQPpOsKKr+r2U26WHd76CD+lhS65HHap8WLtgT6F5c/Em8fzIXO/21eg
   g==;
X-CSE-ConnectionGUID: /UghvpVBRPSydVCLGExzDw==
X-CSE-MsgGUID: uMQFgIA3Sa612Hjd4EDRvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20467307"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20467307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 02:03:33 -0700
X-CSE-ConnectionGUID: vXaic2RLTaqL5H1O9BcFXw==
X-CSE-MsgGUID: COf8G/JNRS2PogOUEoj1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="60469933"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 05 Aug 2024 02:03:31 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1satcb-0001rE-0H;
	Mon, 05 Aug 2024 09:03:20 +0000
Date: Mon, 5 Aug 2024 17:03:02 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] objtool: Handle secondary stack related
 instructions
Message-ID: <202408051602.NqvBpTsv-lkp@intel.com>
References: <20240805032700.16038-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805032700.16038-3-yangtiezhu@loongson.cn>

Hi Tiezhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc2 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/objtool-LoongArch-Decode-secondary-stack-instruction/20240805-113316
base:   linus/master
patch link:    https://lore.kernel.org/r/20240805032700.16038-3-yangtiezhu%40loongson.cn
patch subject: [PATCH v2 2/3] objtool: Handle secondary stack related instructions
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240805/202408051602.NqvBpTsv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408051602.NqvBpTsv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408051602.NqvBpTsv-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> check.c:3009:22: error: use of undeclared identifier 'CFI_FP'
    3009 |                                 if (cfa->base == CFI_FP && cfa->offset == 0) {
         |                                                  ^
   1 error generated.
   make[5]: *** [tools/build/Makefile.build:105: tools/objtool/check.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile:70: tools/objtool/objtool-in.o] Error 2
   make[3]: *** [Makefile:72: objtool] Error 2
   make[2]: *** [Makefile:1360: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

