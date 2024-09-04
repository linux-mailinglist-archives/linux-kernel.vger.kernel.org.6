Return-Path: <linux-kernel+bounces-314190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13496AFE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4806728649E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC948172A;
	Wed,  4 Sep 2024 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWPFdv9N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68B18C36
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424414; cv=none; b=b7tpWNv7X27YNJJWeA5/oTmBm5iW7rIXIlXEDFrqQVU8tX6fGHWRR6jfo6gG2BiltmIh45Q3zSJXUXKmJ2duQniDTp8AB0Z4t2cxcT22nulmCSU5kys/Pt507rqZ2UoL0SMxHUkcccWVO6p1rLEkrvFSeuB21oM1IhLYXiBa4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424414; c=relaxed/simple;
	bh=N7+Tit0TKYpEJm5NWnVhw9St9WnsK2y8w4W1tDwOzas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljEIJ/9U9kpWCVM1Qgek14p/4lc/DplfUmy6atVP78RTFIihA8OHhXeDaSuE1sOheSwQgRigFZtDVxNfYBHLp360JWK92awCDIMUnR1KLP6HfqUDlfBTPt5NKEP2jt/WK2esuGBHD5iXgncY0pgqUlClys4bd3AHHfikXvb3B+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWPFdv9N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725424412; x=1756960412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N7+Tit0TKYpEJm5NWnVhw9St9WnsK2y8w4W1tDwOzas=;
  b=NWPFdv9NXNQHIpFyYVhidtCQhzFTmRDQxWbvjYvVaXM6tX3Yjo/zRemu
   XHDKFxMOjGpzcg3hfpCSbFmX9DoXeW4Wc93rBLR7g40st48DGxw4DoezO
   tQcIYRcYJWs1eKec0nNd5AhNKg9fNDQHqr/Oinv4NgDK4KH9uQf18JmGu
   eWwY0/m+bUy2lvKJvB7C9V3qqrXo0hoDXvf1t8cs3+esmuBNLGsysdvRs
   n+eps/3caAtmeeRg29v7laBCIJWjYlUGRvdsiEv2ZB+L0z+t0Oc3PHFLt
   L372VLrtDV7c+iTEDMF6xaI4KyVfQrTgu153eB6dD6wuHNtxYgjmk5EUD
   g==;
X-CSE-ConnectionGUID: XloQ9JNNRtqTRFfNScvC3A==
X-CSE-MsgGUID: c6Xt5MmxSROk+8FZP+PJ1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23570847"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="23570847"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 21:31:49 -0700
X-CSE-ConnectionGUID: ktrIdsbqS8CtjZzr5qJnjw==
X-CSE-MsgGUID: EMV9DTSlSeKucy5upaZ7PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="64784147"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2024 21:31:48 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slhgI-0007Xl-0y;
	Wed, 04 Sep 2024 04:31:46 +0000
Date: Wed, 4 Sep 2024 12:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: arm-linux-gnueabi-ld:
 drivers/net/dsa/realtek/rtl8366rb.c:980:undefined reference to
 `devm_led_classdev_register_ext'
Message-ID: <202409041221.YNEn6wcn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88fac17500f4ea49c7bac136cf1b27e7b9980075
commit: 32d617005475a71ebcc4ec8b2791e8d1481e9a10 net: dsa: realtek: add LED drivers for rtl8366rb
date:   4 months ago
config: arm-randconfig-r062-20240812 (https://download.01.org/0day-ci/archive/20240904/202409041221.YNEn6wcn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409041221.YNEn6wcn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409041221.YNEn6wcn-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/dsa/realtek/rtl8366rb.o: in function `rtl8366rb_setup_led':
   drivers/net/dsa/realtek/rtl8366rb.c:953:(.text.unlikely+0x6ac): undefined reference to `led_init_default_state_get'
>> arm-linux-gnueabi-ld: drivers/net/dsa/realtek/rtl8366rb.c:980:(.text.unlikely+0x850): undefined reference to `devm_led_classdev_register_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

