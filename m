Return-Path: <linux-kernel+bounces-527093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF1A40733
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688753BD042
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B9207A34;
	Sat, 22 Feb 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdL/3ctV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A342207A26
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218339; cv=none; b=ba/8+ah46B61h2QsT5Sun+GS3W6pe9FRLTAO+dHow/irbLLJwsfVF4vjIJfHeFnWe9JGWcb42c83IpjOkVKuYekmft5dbC4wrqDI7dDGNQfGNue6Na1mGb32CdbIJP7xIXwgr22532fC32+e1o4prH6TxtMnVaplLW0WOyqL5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218339; c=relaxed/simple;
	bh=se9w2vU0xYQrK1GndXLdvM2DXLeY6zcipcqfUFKQ6/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p3lyYV3qGy4mXv4x4HoLMxcd+vDTGks2X1RRnj71ReyS1x6rpa5/IocGBaz1riTV7sSeIx0bctVR/XVvZALyonx3WhTc8uwaLh5CnIhNMbmTAzFEfrO+lL5bp++lx3a/q0PyFY7m+8nEvyZqy0M0fEdKXH+n5I4zI35LqTn9z0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdL/3ctV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740218338; x=1771754338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=se9w2vU0xYQrK1GndXLdvM2DXLeY6zcipcqfUFKQ6/M=;
  b=BdL/3ctVRtiUkAulsQSUbNTpOanraWJDDr4LBvTuKVutk5iTp+ryE2/3
   FkIGE1CRe6lL6j+GCwpDb0zT8rqfg1OFNozCINJKqaCVnJxnyeK24+kOn
   Pe1wSnSApyYZxqCgM2EXruLlvh86InO8vtlen8pEMu5ilf9vIRaPx2Seh
   L19n5+i4sLdA/k+3Kghr0AdVF+ckRbvwROG07eHT0Gma5STHYksct402m
   NBKC61Iqtty/Whot8uJ2awrZOFWSy2N5DI8J+Z0p8y3RkoEWUx70VLICu
   jO6TfaD/rkYo+5TMYnTO9CthkY9wna097rvzfz2NypKy5gb/cjbl59v0x
   w==;
X-CSE-ConnectionGUID: N8dyA2qzQXORt0uLcSYIyQ==
X-CSE-MsgGUID: nw5E/i5OTcurOUWcEFdsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51250396"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="51250396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 01:58:57 -0800
X-CSE-ConnectionGUID: QEYd5HZoTf6n0wxLu3jI4w==
X-CSE-MsgGUID: ZnomUuAATQK/0Ec6TkszPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="115305983"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 Feb 2025 01:58:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlmHd-0006Sx-1H;
	Sat, 22 Feb 2025 09:58:53 +0000
Date: Sat, 22 Feb 2025 17:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>, Rong Xu <xur@google.com>
Subject: (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26
 against `no symbol'
Message-ID: <202502221728.6WLWBLJO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff202c5028a195c07b16e1a2fbb8ca6b7ba11a1c
commit: a412f04070e52e6d6b5f6f964b9d9644de16bb81 openrisc: place exception table at the head of vmlinux
date:   2 months ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250222/202502221728.6WLWBLJO-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502221728.6WLWBLJO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502221728.6WLWBLJO-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/openrisc/kernel/head.o: in function `_dispatch_do_ipage_fault':
>> (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   (.head.text+0xa00): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_dtranslation':
>> (.init.text+0x21bc): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_itranslation':
   (.init.text+0x2264): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   init/main.o: in function `trace_event_raw_event_initcall_level':
   main.c:(.text+0x28c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strlen' defined in .text section in lib/string.o
   init/main.o: in function `initcall_blacklisted':
   main.c:(.text+0x6f4): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strcmp' defined in .text section in lib/string.o
   init/main.o: in function `trace_initcall_finish_cb':
   main.c:(.text+0x818): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x83c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x87c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x8a8): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   init/main.o: in function `do_one_initcall':
   main.c:(.text+0xec0): additional relocation overflows omitted from the output

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

