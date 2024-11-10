Return-Path: <linux-kernel+bounces-403135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556509C3180
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746811C20A70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC03153808;
	Sun, 10 Nov 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1S/OGKo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437401537CB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731231710; cv=none; b=bdo4W2CZ4h2S0i2GXagjVmStzLwFyUlXq629il1M49SHzJhPJBymToQG7punmgSi0KfDpHeOTnVeduXs3oEhCt4V1otZN6XmNIKJRVWZY9P5NeBaLXk0SdXLdJ8eMPLVc3dLsCSSSEwm5QTFtn+zTS/EoS8tlmKpudPzHz0rkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731231710; c=relaxed/simple;
	bh=O6gcBtee8F7pDHU8XSKzSZ8bhN8r1JiN22kEQ9b+yhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qDb/lr4KVzzyp7pKN26qJwb+MuHzzvpa0HBRlCwydC0mga9a+ShxhOZ8PinkKGgyNdz3/fB0VvC3EHvOeoE1KCU3Pv/nMHCLvTMRb1926Rdhf8sAMQxiLwQ3VximoNKkaWhQkuMaqnLzc/yf9EX+MZxZYZC+c/vS510vfHocZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1S/OGKo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731231707; x=1762767707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O6gcBtee8F7pDHU8XSKzSZ8bhN8r1JiN22kEQ9b+yhY=;
  b=g1S/OGKopO8UbqAb1+tPfUJX51sPLmaAxh1lE29IbmmS20KNollDaba/
   P6S6DUrnBUROjJED3rOewEFSl88MtW4q9fc4IRfc8GPzTEARJhPnpKr4H
   jwN/ONCuwldxLgBi6B4OEwg2X+c7Y+aFPnPItftFExOioZbO68/g5TxxC
   pdFagdspIhMosauClri4WNT+/kbAFcCrnFDfd/1YcH+INvwsYUipNxe6G
   4ILfjEPtRUpb/T5G1AQqYk7+yqs52WlMd7A0xU2YBzCLvDNFASGN2SSS2
   zyWWen5VUJJWVWYhSNdpRCWKVd+32a8185555Suln2khFOQCmz6OEmxpr
   w==;
X-CSE-ConnectionGUID: gEWDJGxyTfCxFeqNjAVX8A==
X-CSE-MsgGUID: BKUxgNK3TBGjO1jGZJObgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30914255"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30914255"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 01:41:47 -0800
X-CSE-ConnectionGUID: pHFv7Ze3TemACIde+2843g==
X-CSE-MsgGUID: IAduJv4URA6jJFLa097/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="86694296"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2024 01:41:45 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA4Rz-00004D-19;
	Sun, 10 Nov 2024 09:41:43 +0000
Date: Sun, 10 Nov 2024 17:41:26 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/44x/uic.c:40:12: sparse: sparse: symbol
 'primary_uic' was not declared. Should it be static?
Message-ID: <202411101746.lD8YdVzY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de2f378f2b771b39594c04695feee86476743a69
commit: d5d1a1a55a7f227c0f41847b0598982f0a93170d powerpc/platforms: Move files from 4xx to 44x
date:   5 months ago
config: powerpc-randconfig-r133-20241110 (https://download.01.org/0day-ci/archive/20241110/202411101746.lD8YdVzY-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241110/202411101746.lD8YdVzY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411101746.lD8YdVzY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/44x/uic.c:40:12: sparse: sparse: symbol 'primary_uic' was not declared. Should it be static?
   arch/powerpc/platforms/44x/uic.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
--
>> arch/powerpc/platforms/44x/pci.c:116:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:117:74: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *in_addr @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     expected restricted __be32 const [usertype] *in_addr
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     got unsigned int const [usertype] *
   arch/powerpc/platforms/44x/pci.c:118:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char const volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     expected unsigned char const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     expected unsigned char volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/44x/pci.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +/primary_uic +40 arch/powerpc/platforms/44x/uic.c

e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18  39  
e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18 @40  struct uic *primary_uic;
e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18  41  

:::::: The code at line 40 was first introduced by commit
:::::: e58923ed14370e0facc5eb2c3923216adc3bf260 [POWERPC] Add arch/powerpc driver for UIC, PPC4xx interrupt controller

:::::: TO: David Gibson <david@gibson.dropbear.id.au>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

