Return-Path: <linux-kernel+bounces-278829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760D194B561
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17871C21A68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11142AB0;
	Thu,  8 Aug 2024 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCvGZzrS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61710A0D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087008; cv=none; b=nkHQbRKPnS0Fc8o5D+ORSMURst8nn04j1BDLPfwSf6yB86iDBI+eQnRrsPsktKZ1A5CGlkjj7hcuQi2NK4khUfYy30ifIQ0tz/MrkmUNiFMqUy1XDS6qANwr8/glNjz1bOvFHcVNCyWCH8v2+MYY92Rgb3oc128SIw0CFAiKBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087008; c=relaxed/simple;
	bh=A8xU9k4hRyFBgfPyMNhTQezZabXu3vv0f2eI1zyTczk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FtsYldwBY45ugXNpozosXrhzc3Nk/KOSN+6VeAoE/984Y1IgQUwD+1DatDCgoIxquS1loIbsL1jlrug/f2Dg/6VN1vW1BUmW9aqFdU4fexjH+nkds1am7RGq6HHsisL+KMNUIhbLgLW+8H3aFpbNLIiIV5CNiinLXb81fYRJ4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCvGZzrS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723087007; x=1754623007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A8xU9k4hRyFBgfPyMNhTQezZabXu3vv0f2eI1zyTczk=;
  b=iCvGZzrSp55Jw4+HcumTtyjhbYqK9LhJi04EU0ziipQm8wVTHpH+Leot
   v7Vcxub/aYvVBL9v5wZvtEFUdJKy/TBh/H7nbjny8Y7p9r5Lb4EhZ8x9W
   IgEDYQhL0BlwPVSzMH/s8AwEGNME+lzhUyxWqf34D3FqXAmcktTvnuWUR
   Cee5FIG0KyXH4vL947w6XErJsrXgdYAOdiA6ud9DV+wFEGOPVjkC11V2l
   9SejLoxFM4XKCwtPBzEZ/94W+vQu2XGiZF3UOJONfWmdvh/tQtYudeFp/
   lA5Lb0Zp7UIhm0emoxQgeogeBnxhBPKDDtirvWiwMD+8r4Lp8Z5TD0V9D
   Q==;
X-CSE-ConnectionGUID: e1rr2JxGSTq0nhsoAXWebQ==
X-CSE-MsgGUID: ti23cSIKTb21Geolxw0Ekw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38648958"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="38648958"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 20:16:47 -0700
X-CSE-ConnectionGUID: PZaVSFZlRfKDW6iPwG+rvQ==
X-CSE-MsgGUID: AcLTCbtiSoGjhulurif7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56993578"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 07 Aug 2024 20:16:45 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbtdq-0005tK-2G;
	Thu, 08 Aug 2024 03:16:42 +0000
Date: Thu, 8 Aug 2024 11:15:58 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: ERROR: modpost: "__popcountsi2" [drivers/mmc/host/bcm2835.ko]
 undefined!
Message-ID: <202408081106.qmqrtvNa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a0e38264012809afa24113ee2162dc07f4ed22b
commit: 64ea30d1a192e2866397169ebfe3d0109878d040 clk: imx: fix compile testing imxrt1050
date:   1 year, 6 months ago
config: arm-randconfig-r112-20240807 (https://download.01.org/0day-ci/archive/20240808/202408081106.qmqrtvNa-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce: (https://download.01.org/0day-ci/archive/20240808/202408081106.qmqrtvNa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408081106.qmqrtvNa-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__popcountsi2" [fs/ext2/ext2.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/hfs/hfs.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/ufs/ufs.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/soc/aspeed/aspeed-lpc-ctrl.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/iommu/iova.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/usb/gadget/udc/udc-xilinx.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/md/bcache/bcache.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/mmc/host/bcm2835.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/mmc/core/mmc_core.ko] undefined!
WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

