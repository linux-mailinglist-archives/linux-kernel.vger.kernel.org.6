Return-Path: <linux-kernel+bounces-288794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4AA953EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552DE1F226FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2571D69E;
	Fri, 16 Aug 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B77o9UPi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79F17BA1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770515; cv=none; b=fQhAeyzugFlkU2bka95eiBxY/SEy6rREEvulHAEyk04g7M89tZcmqjlXtJRki0jkjO2PtsdqMD7MHt2UINGXOuqqf1GThKjX18psioEWyWiZcrtJmej3vMB/6UmIcLAx4mHCt0g1W5UaNYQlWHz6mrVpGYBJSYwQXrnfaP9DaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770515; c=relaxed/simple;
	bh=Nekqz3Thd5lwqVHKwV3oGAYO3t5X/LdN4f9+4nQo3tI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SUVolhxOQZE0Beb593huiUvyXDBLeQrhykRdscAl86ckLs76eGu1m7E4DxKqk13RqhDfVoyY2P9H80gfYe8GLhrUFpey8JNL3fHkWJvHnNK4fODjyTzKEw/1pOZIjEJPSosUERlH/5sLdFeOV7O7uUkCixJoPsxQRykeN+lpuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B77o9UPi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723770514; x=1755306514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nekqz3Thd5lwqVHKwV3oGAYO3t5X/LdN4f9+4nQo3tI=;
  b=B77o9UPi90oUK/rtb7oW7H0tBK7C0BZNkpUDik5SdqWVIA8ouMOHu3U9
   Y/bNbjuIrSi2dDLwUVsxzcNpTW7HqfMuhR4JMxlrQBLkx6DcbyEO/Wtyo
   a8d8kixkpjIVFkZcNVIgnN48NZ6x2rJhuRgGfgG8XWN6B7l1zbOchFcRZ
   Rk6/mzxSqv72m7fiX+HyGtXWQo016+fWNOhEHkfMo4OZV0CqNaA5067fn
   H9OKoDDdZUu1gWncf+BPJ5LkeUfU8KkFlXwIPtm8LnALclzLp8exQtcn5
   TmUJwEw9AOWivJXBrEl+k8i4sfrFbaWTq+97PN+NNl8SPSxooqk71iSme
   A==;
X-CSE-ConnectionGUID: CY50jaJHR861McRq0FE+GA==
X-CSE-MsgGUID: uUFnUGbhQ86u+H4CBRbVYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39511201"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39511201"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:08:33 -0700
X-CSE-ConnectionGUID: J0Wrij6+S5eqZbB91+uYdA==
X-CSE-MsgGUID: 0o2xkMmRSOqshXTSon3big==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59162959"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Aug 2024 18:08:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1selS9-0005le-1r;
	Fri, 16 Aug 2024 01:08:29 +0000
Date: Fri, 16 Aug 2024 09:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Foley <pefoley2@pefoley.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file: No
 such file or directory
Message-ID: <202408160932.BvHwO6Qo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7a5aa4b3c007fae50405ca75c40258d90300e96
commit: 83e913f52aba69149261742aa9ea4ceea7bf182d um: Support LTO
date:   1 year, 6 months ago
config: um-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160932.BvHwO6Qo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file: No such file or directory
   clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
--
>> llvm-objcopy: error: 'arch/x86/um/vdso/vdso.so.dbg': No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

