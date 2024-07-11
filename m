Return-Path: <linux-kernel+bounces-248989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250B92E4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A231F2246B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141DB158DAE;
	Thu, 11 Jul 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLdmlF4O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7B158A35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693797; cv=none; b=ZG2OMqD99E5pkUUbQTC3FHWxFDoF6kIY4uoFKa6os9wn3oG7ERPCHhkPx+/pzfa7NxlwQrNF3cyots6+qbLKf9k0Ei1U7rTPjBZWfoUr8ZcCkzL6uihk5euPIWP+A9BtpKdFdGCiiSQ1+9FACOhEz9JKRP6Xy1UAJ0IzSFC8NAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693797; c=relaxed/simple;
	bh=xLgi/0Ii4CNpvpkadATzALUKGDUyECn2vzUaJG09SM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ujLungYKJqrNo/IosJ/5jg6tjQYF8w3J96pHEmu5npxn8LbvGjUH6yDgV2E2yfacK5SlLbkye/ClvjAV8yvSSeisfdcgCX8q4MgLDa584Bfj0TLQ7LmMCejfEsQAINPgCJLHqoRA4G4kGwA+W2BPPnEmTgYYna34cH5WyD/+xgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLdmlF4O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720693796; x=1752229796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xLgi/0Ii4CNpvpkadATzALUKGDUyECn2vzUaJG09SM8=;
  b=NLdmlF4OqR/IDA2APMFZuVrkvaiv1cV7ilnYFMGiqOeA3XMpWwrR7QTC
   jmJ3zsLV085yFqUmFrpjUBPrXJtNSpX/ViRz2Re0I+sQ+qnB4FZOQXQdY
   hDyPzMIWtD/ntCSwDxgKX5xWl3nabnSlBr+ZMRi/ujHqA8WczJX+VyqCf
   cqrDH4bQFwl2zYmyOxUGBSeCIx0FZpNFbZ1+C5J15q0gVi7ZgRSWRuu2g
   kRqF3KCvMpFSSksmT9Xt1d3FAtiVMPuAf5dH0gg29rbTkXiucJ12dSBJC
   KRxE5GRxzKbAL//Ywp8zu4p20VFTxHN6+Dh00vSLJjel61rgwJoovArYo
   A==;
X-CSE-ConnectionGUID: MobTSPS5SNGEgToKZiy3+g==
X-CSE-MsgGUID: 4Pw74pKBQiSccGnkxOylxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29467716"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="29467716"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:29:21 -0700
X-CSE-ConnectionGUID: YA9xCeEMSVm7c7qGgEI59Q==
X-CSE-MsgGUID: ezwYpHuwTBKuHu55RQEpEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="86014963"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jul 2024 03:29:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRr37-000Z9j-1P;
	Thu, 11 Jul 2024 10:29:17 +0000
Date: Thu, 11 Jul 2024 18:29:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: error: unknown target CPU 'mips64r1'
Message-ID: <202407111851.LwDasTcp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: e7a30874b348d23898f64545b4086edc0741d715 MIPS: BMIPS: Drop unnecessary assembler flag
date:   5 months ago
config: mips-randconfig-r052-20240711 (https://download.01.org/0day-ci/archive/20240711/202407111851.LwDasTcp-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111851.LwDasTcp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111851.LwDasTcp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: unknown target CPU 'mips64r1'
   note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5, mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2, mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> error: unknown target CPU 'mips64r1'
   note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5, mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2, mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
   make[3]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
>> error: unknown target CPU 'mips64r1'
   note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5, mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2, mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
   make[3]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1198: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

