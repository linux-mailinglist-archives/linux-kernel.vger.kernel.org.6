Return-Path: <linux-kernel+bounces-515734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E0A3684A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5173B15EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425D1FBEBB;
	Fri, 14 Feb 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H283xcTn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216661922EE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572287; cv=none; b=rzRbK2kxkwAa1nYK9k0X7cC4d1BTCtYrs5ENPAMv+pWkSPBpTf+c9yAnYyR6SJZqcOYcvgCPxCbO2nPueqyDcYgna8zifAZiO5SFYwJAcdjQGfn4mxpGFHuES0WrcTXLxOpe1vtr0R04DEEV4uOHI2u71l9tHvHy+xgG6wy0Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572287; c=relaxed/simple;
	bh=G7vDmKFosVbSuAK7mTbm60on6LiAptdt/5OUfWDMTIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rgFp2Ow5WDbniCG9cCYDKUdMBXw7gOtDvdbJRgHZrPdkeVEYQGJRMKd5t1taP99C/VyxGPGpxiYLm5A2g25NWtvQSojrRewIyjjAhJIP9KZm9ShcS0IF/mkAA4T7FikXJoKeHOnwwbH+5oyUppikqhUzsvHUgdmY8XRsZSi90+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H283xcTn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739572286; x=1771108286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G7vDmKFosVbSuAK7mTbm60on6LiAptdt/5OUfWDMTIs=;
  b=H283xcTnI2cByQpf3Z7HhaBoiwXtIAFOu7zgOyM3JIBqAEkWSM9kghe/
   SIkAmbVArOxitOPbaVRnwf9VN48Qa4CLRYtfRlKE3OZZDEdaFPxhKBsdr
   kjO78KZ/F46Zrn65cxdj42vIROEJ6HeBwCqF2lSfX6lKjzUotyU2XrJue
   xKXWCqwavEpVpAHYXQt5pGkRfYNuLOpk6BTP+Q69FXaYemzA3MWRpUY6V
   nqgq5NFNH5Bdwi4saDAH244qoye4KK6Y+/SzosW1zpYkWuL3OTejNQOG1
   MsKt+V+/HvSSkVPQRW73l6N9sKreWsIYW1ugRkuGH1/hMVtNDDj+drsbR
   A==;
X-CSE-ConnectionGUID: xNzeh4CJQ1CqR11qpbtAow==
X-CSE-MsgGUID: xVR8KFfIS8i8wK7s4eOOeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="39520313"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="39520313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:31:26 -0800
X-CSE-ConnectionGUID: ekeEqoYjSD+h+FbkfXDDPQ==
X-CSE-MsgGUID: vNy2B9+ITJSuzkW+DV3Esw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="118599023"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Feb 2025 14:31:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj4DS-001AEl-02;
	Fri, 14 Feb 2025 22:31:22 +0000
Date: Sat, 15 Feb 2025 06:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: Qiang Zhang <qiang4.zhang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: lib/bootconfig.c:69 xbc_free_mem() warn: unsigned '_x' is never less
 than zero.
Message-ID: <202502150651.mUSSYUxe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04f41cbf03ec7221ab0b179e336f4c805ee55520
commit: 89f9a1e876b5a7ad884918c03a46831af202c8a0 bootconfig: use memblock_free_late to free xbc memory to buddy
date:   10 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250215/202502150651.mUSSYUxe-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150651.mUSSYUxe-lkp@intel.com/

smatch warnings:
lib/bootconfig.c:69 xbc_free_mem() warn: unsigned '_x' is never less than zero.

vim +/_x +69 lib/bootconfig.c

    63	
    64	static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
    65	{
    66		if (early)
    67			memblock_free(addr, size);
    68		else if (addr)
  > 69			memblock_free_late(__pa(addr), size);
    70	}
    71	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

