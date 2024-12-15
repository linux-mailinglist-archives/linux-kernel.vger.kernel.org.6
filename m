Return-Path: <linux-kernel+bounces-446391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9659F23C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E117616454F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C81865F0;
	Sun, 15 Dec 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6syRrhx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34131A89
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266200; cv=none; b=XTd/hDBw2zNeejJX8Eek74EMsnC01q+SBUIsJMgABYDdxY0q/kwUhVZn6+JB62SUsVqlQqARRu9tS3v9CffX2k/VU6Fggf9AYpdy8M5uv/1yy+zzagAeypCd+MJNfqYKY8kAWVGhOhxF+1ZtccuI/bi6F5NvCBcatUI/ZryjT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266200; c=relaxed/simple;
	bh=5e8fb8SP+GkRSkzBlX7AXt4ERtJ7Xf7OGV8o4T6wlQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ngt8Vs6oRcbbp0rWAs5E5HsG+w3K6EhQpWtnEzlRYK1XciTY7aBdVvovL6sJYMrFB9LWpGdy19Rt746yZS6gFYMrFFWcs2VqtVzJ2gP+NrwrDj7rfVgGXPScpkStcVzBwH8jLoTj4OuU6nQzbICG9O/24KhQuHM3Yew26xYjz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6syRrhx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734266198; x=1765802198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5e8fb8SP+GkRSkzBlX7AXt4ERtJ7Xf7OGV8o4T6wlQA=;
  b=j6syRrhxaMCNq7jDYp26dWyws3c9jcj+L6YfmZi3UzXTGBMuQfu4w7do
   LexDEcS1XcV5WF5Ks9C+/mP2x028Af/nKKFpxNTlVbF46rGUIIH4xlz4R
   WrBYEd1RMVPiZfXdnokboaxbr/4EbBtGfTkSF68FESWy7BAQ0+86Jh13c
   QQHfRIh4r6gEV8Ch8Qk0spD9gtsx35/teW8wpnJapuJYqCysFs/eWVdM0
   VsQUXYEukCy+x+vWM6QlBTJvEolOlRTJlfD5amjKEIL/aR+BNg9fKG58y
   TfeKFOlf1pLURaQkiD2VRBVpzyDwy88JF5eLb9bG5S5X9MMb5zUYvkPE0
   Q==;
X-CSE-ConnectionGUID: 6+mw6tYuR82yFbkzpJIYVw==
X-CSE-MsgGUID: oLFlpUAiTreeGKx8Ax15lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34389309"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="34389309"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 04:36:38 -0800
X-CSE-ConnectionGUID: /M/LD2OaSEONTxSzFWrNyg==
X-CSE-MsgGUID: FQipea7+QxS3a2mAryyopg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97191827"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2024 04:36:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMnrO-000DcE-1L;
	Sun, 15 Dec 2024 12:36:34 +0000
Date: Sun, 15 Dec 2024 20:36:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: rtl8366rb.c:undefined reference to `led_init_default_state_get'
Message-ID: <202412152006.8cAlfJ55-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
commit: 32d617005475a71ebcc4ec8b2791e8d1481e9a10 net: dsa: realtek: add LED drivers for rtl8366rb
date:   8 months ago
config: csky-randconfig-r061-20241215 (https://download.01.org/0day-ci/archive/20241215/202412152006.8cAlfJ55-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152006.8cAlfJ55-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152006.8cAlfJ55-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/net/dsa/realtek/rtl8366rb.o: in function `rtl8366rb_setup_led':
>> rtl8366rb.c:(.text.unlikely+0x1ac): undefined reference to `led_init_default_state_get'
>> csky-linux-ld: rtl8366rb.c:(.text.unlikely+0x272): undefined reference to `devm_led_classdev_register_ext'
>> csky-linux-ld: rtl8366rb.c:(.text.unlikely+0x2b0): undefined reference to `led_init_default_state_get'
   csky-linux-ld: rtl8366rb.c:(.text.unlikely+0x2d0): undefined reference to `devm_led_classdev_register_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

