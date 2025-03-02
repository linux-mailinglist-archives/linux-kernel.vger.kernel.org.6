Return-Path: <linux-kernel+bounces-540477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2399A4B122
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3190C1889F96
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10C1C5485;
	Sun,  2 Mar 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2euvqAU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D66E1CAA90
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914327; cv=none; b=tlnQu+wyouPX9uW3WCSG6SwyDv38s3ls6hS+/aQGb3UFsXULuaJPwb96WMzHqwQvGW6hMH+lXWa+jwrwf3Tz8pMnjyxK1iA4l1Gr98k/8ymGBrWGe8avL9rXWe7mrR8peYIh4/7LBlUNAhy3CpznPSU89LfYYYoXr8iGLkp/9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914327; c=relaxed/simple;
	bh=MZzFYQuosliF1iyzElLVnlzpUwr2kwZXUyaXkHxYMig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=onIFIFVpvxfzawnajUXuApHPLK+gXU5/qEeW0HQte36kfSyWAp8RmAzv/vLVTm6Qx9N+HaWirRcUuTGOtOBmZuM76Xe88oDUHUScQe71HtDq6hBOubXf/qIJ7ok+H9knOyE9oE0upz9/sc5AVALmm3ZfCtafeL1FUhmodul0mw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2euvqAU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740914327; x=1772450327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MZzFYQuosliF1iyzElLVnlzpUwr2kwZXUyaXkHxYMig=;
  b=X2euvqAUr9pTTafyGQeFVaCTaofJxOrViHXc70mOK24LnrflkpCH9KGO
   TwjCS8l3KTGz7jjx7uKV5InAaVkAXxR8eylWXSA4Jwy+FPuoEBC+WqCoJ
   VPwzNp9XjPc1W9TzY0QF9KouhLnKO9ZxET21iComKIhWKfo/LDVw13kpk
   cCckX0ErTb8jSxsUT+aZmFT9uyWCi1LLA4qC1KZh4V+1sXeJ2GhEGkPqQ
   WMIYMHB0WUcp46QEKa/W1u3mGfi4ejC21OENaajxr+vyaBc/M2PVehwKh
   XDz1WU67wgm05GKK1hRL3Aj+p8rtNTUShJDVifu/dt6GEuQjd8g/YYGlm
   Q==;
X-CSE-ConnectionGUID: RXX1wH6ER6qYdQ4B2/9PNA==
X-CSE-MsgGUID: ZuG/k+HpQHOdqHcetPFZBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41496324"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41496324"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 03:18:46 -0800
X-CSE-ConnectionGUID: Qx5FlSpeS5KsKDR155XR5Q==
X-CSE-MsgGUID: IiidHD+rSGCyF81i/2LEUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118293338"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Mar 2025 03:18:44 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tohL4-000HH8-2N;
	Sun, 02 Mar 2025 11:18:35 +0000
Date: Sun, 2 Mar 2025 19:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>
Subject: drivers/hv/channel.c:597: warning: Function parameter or struct
 member 'size' not described in 'request_arr_init'
Message-ID: <202503021934.wH1BERla-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Saurabh,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ece144f151ac7bf8bb5b98f7d4aeeda7a2eed02a
commit: f83705a51275ed29117d46e1d68e8b16dcb40507 Driver: VMBus: Add Devicetree support
date:   1 year, 11 months ago
config: x86_64-buildonly-randconfig-004-20241224 (https://download.01.org/0day-ci/archive/20250302/202503021934.wH1BERla-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021934.wH1BERla-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021934.wH1BERla-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/channel.c:597: warning: Function parameter or struct member 'size' not described in 'request_arr_init'


vim +597 drivers/hv/channel.c

3e7ee4902fe6996 drivers/staging/hv/Channel.c Hank Janssen   2009-07-13  588  
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  589  /**
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  590   * request_arr_init - Allocates memory for the requestor array. Each slot
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  591   * keeps track of the next available slot in the array. Initially, each
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  592   * slot points to the next one (as in a Linked List). The last slot
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  593   * does not point to anything, so its value is U64_MAX by default.
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  594   * @size The size of the array
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  595   */
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  596  static u64 *request_arr_init(u32 size)
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09 @597  {
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  598  	int i;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  599  	u64 *req_arr;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  600  
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  601  	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  602  	if (!req_arr)
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  603  		return NULL;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  604  
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  605  	for (i = 0; i < size - 1; i++)
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  606  		req_arr[i] = i + 1;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  607  
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  608  	/* Last slot (no more available slots) */
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  609  	req_arr[i] = U64_MAX;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  610  
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  611  	return req_arr;
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  612  }
e8b7db38449ac5b drivers/hv/channel.c         Andres Beltran 2020-11-09  613  

:::::: The code at line 597 was first introduced by commit
:::::: e8b7db38449ac5b950a3f00519171c4be3e226ff Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening

:::::: TO: Andres Beltran <lkmlabelt@gmail.com>
:::::: CC: Wei Liu <wei.liu@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

