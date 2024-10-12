Return-Path: <linux-kernel+bounces-362250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA099B2AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CCB1C21333
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F514F9CC;
	Sat, 12 Oct 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDDl+aZw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611414D708
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726782; cv=none; b=N7MxI3oEiG0DPIZwbVz7LfHpGs/om0E5GdTccYHrGOfN1CwgRM3LCdRCGy1yWpiZ9rME9lxhgwUPvnsH57AvBrqN5QXYJtMGcp6a0iQUQx74NSoPkyM167CB3LWELE+UAIKs7sTtXnXlbXqz0HjyDZzbGV0SM7MlZNIaB+hldlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726782; c=relaxed/simple;
	bh=ZyPnTTsJuRHPjbCeFExRGkpusQ8tLFwAuDKoNS0q9H4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sgA5TMevTK3twGRiQxPPo5Qe5+P8+NUscI1wMbH79QyUHZpVlVZtXkc0lOw5t48UBgK4wVnx01yu0qqxHnlwceRaHi0WRpx9OjlYGigTYhAmiiOJzO9lImLo62Xm5fP/r9wGq+y/Kr5qzTJAtF82j0dIgRmsGG9giM67Fx0Hzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDDl+aZw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728726781; x=1760262781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZyPnTTsJuRHPjbCeFExRGkpusQ8tLFwAuDKoNS0q9H4=;
  b=NDDl+aZwrQAFlOqGJJf/syv2a3+xrx7NT7C3oK4L5Ukz62Vrx/QuzSnN
   te3EkgBcLENq4EEUTE8Kh9fmwc8eIwvY4p3AaWwp2Nda65laBgSX2CLzz
   SOktlaWTu2BUeZbGpagOIAgb1nn2zvhOMNxRjcPubR75BlsIqr9UWWZOK
   1MxZzeG9R8m1LPwRH8FYrRQJvdtz0zGlXa4bZhIJs//PjBdt9cKJA34X3
   s6A4vpqLrX1pCzweGb1k+tfnemem5AHZx0aDCmZswWmVHTzipj3nFbQkI
   O69ydvxtsWq2ztOCwz+r8xQdJZ0jHIjN0vqMeMo4tyvYtwh8X72P/WVwm
   g==;
X-CSE-ConnectionGUID: fj8I74FgTzW+8MSbHY6FIw==
X-CSE-MsgGUID: ErswSU0sQMyuAGQvy/tjvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39249817"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="39249817"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 02:53:00 -0700
X-CSE-ConnectionGUID: mcCelYV0RBqZni+Ulx1oJA==
X-CSE-MsgGUID: jLE7+SXZSeCuxUo0BgEeVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77133637"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Oct 2024 02:53:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szYnx-000DGB-1l;
	Sat, 12 Oct 2024 09:52:57 +0000
Date: Sat, 12 Oct 2024 17:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mv78xx0/pcie.c:43:5: sparse: sparse: symbol
 'pcie_port_size' was not declared. Should it be static?
Message-ID: <202410121730.ViWfi0F2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
commit: e2fe85aa6a6387c4babe4c191e50b7af8ee37faf ARM: mv78xx0: un-deprecate Terastation WXL
date:   1 year, 9 months ago
config: arm-randconfig-r122-20241012 (https://download.01.org/0day-ci/archive/20241012/202410121730.ViWfi0F2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241012/202410121730.ViWfi0F2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410121730.ViWfi0F2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-mv78xx0/pcie.c:43:5: sparse: sparse: symbol 'pcie_port_size' was not declared. Should it be static?

vim +/pcie_port_size +43 arch/arm/mach-mv78xx0/pcie.c

cfdeb6376e439c Lennert Buytenhek 2009-02-20  42  
0b9b18e0166d89 Rob Herring       2012-07-09 @43  u32 pcie_port_size[8] = {
0b9b18e0166d89 Rob Herring       2012-07-09  44  	0,
0b9b18e0166d89 Rob Herring       2012-07-09  45  	0x30000000,
0b9b18e0166d89 Rob Herring       2012-07-09  46  	0x10000000,
0b9b18e0166d89 Rob Herring       2012-07-09  47  	0x10000000,
0b9b18e0166d89 Rob Herring       2012-07-09  48  	0x08000000,
0b9b18e0166d89 Rob Herring       2012-07-09  49  	0x08000000,
0b9b18e0166d89 Rob Herring       2012-07-09  50  	0x08000000,
0b9b18e0166d89 Rob Herring       2012-07-09  51  	0x04000000,
0b9b18e0166d89 Rob Herring       2012-07-09  52  };
0b9b18e0166d89 Rob Herring       2012-07-09  53  

:::::: The code at line 43 was first introduced by commit
:::::: 0b9b18e0166d8925ed222335efbc3cfd66aa882f ARM: mv78xx0: use fixed pci i/o mapping

:::::: TO: Rob Herring <rob.herring@calxeda.com>
:::::: CC: Rob Herring <rob.herring@calxeda.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

