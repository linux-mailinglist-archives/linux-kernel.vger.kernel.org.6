Return-Path: <linux-kernel+bounces-216106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1B909B70
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 05:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E10B21304
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58416191A;
	Sun, 16 Jun 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRhSe/el"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267223DE
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718510116; cv=none; b=cw5cRjUpvgJr+/xicaa16ETI4a441jg4xVwoC4uHnptQB7gtYobpQsQFxbtgwsaMb5Q5CZP1wjtgfaB+9sSgKT9syDQrWXepx7Wg/acmCV87FWAVUzJ8LLZ3Ke/Xv9m6yQB7mqnI4gAOf0eqT735zDqz+UGFgz1OzI4FUPkGVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718510116; c=relaxed/simple;
	bh=hUM2e6oic+4mLX2gpbYtmFKrZG771sLFgevFtnbtBmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KI2wzod0Gfug80RqbE//0Tq4wibGfakqJbkgMaRssL7gmsJrUwKoQc6qoegYM/uK0MiayCAs98t3OUtERnO0pBvdJYsNltLM1JVn4LIFV25Ume5NZjMLdr2Oi6shX36YycLKSAXJJi1GHx0OZSgxSdSXLhJxg0b9RMR+b8kwUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRhSe/el; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718510115; x=1750046115;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hUM2e6oic+4mLX2gpbYtmFKrZG771sLFgevFtnbtBmA=;
  b=iRhSe/elb3WqS2sIpjf5bwCcT/ruRr3kI/aB/jytQMezU7WDpMIhyBBM
   KsK9ymayD6VHM2ItJ1QFYkQaxleEcm95yWga5kfyG52pPGHfPpcxnBD+1
   0aHvu0TkwgdYZyf5wkplDnH7sdcEY0B90+xJb4cP4vkjOtZOxrnud+LUz
   J7gYcaMjoPBOWU40zWUf6PdMFthPE4yrVeUwL4XjViifspGWgBpBCx586
   LsCoszpXlGls+sb8SfbNJnEp1blxOhugAbEzJyAiRAff5MDBHihCsQAYK
   DztpvRcZeDF1SRJa2sDescBlBl/uDaa4+cfYFLXclTOixr4ooUgJrWFkb
   g==;
X-CSE-ConnectionGUID: 7QQvuud5Q9iyMeonVcZCSg==
X-CSE-MsgGUID: pbuW6Nz3REqTqbDGrSpcBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15201159"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15201159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:55:14 -0700
X-CSE-ConnectionGUID: LaS5YVJ2SMewhjJcfH5P9Q==
X-CSE-MsgGUID: F5sd+eRbSgGrPymwTS4hcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40988869"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jun 2024 20:55:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIgz0-0000oU-1P;
	Sun, 16 Jun 2024 03:55:10 +0000
Date: Sun, 16 Jun 2024 11:54:42 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: csky-linux-ld: rtl8366rb.c:undefined reference to
 `devm_led_classdev_register_ext'
Message-ID: <202406161120.M2A3cA6J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: 32d617005475a71ebcc4ec8b2791e8d1481e9a10 net: dsa: realtek: add LED drivers for rtl8366rb
date:   7 weeks ago
config: csky-randconfig-s031-20230329 (https://download.01.org/0day-ci/archive/20240616/202406161120.M2A3cA6J-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406161120.M2A3cA6J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406161120.M2A3cA6J-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/net/dsa/realtek/rtl8366rb.o: in function `rtl8366rb_setup_led':
   rtl8366rb.c:(.text+0xff8): undefined reference to `led_init_default_state_get'
>> csky-linux-ld: rtl8366rb.c:(.text+0x10ce): undefined reference to `devm_led_classdev_register_ext'
>> csky-linux-ld: rtl8366rb.c:(.text+0x10f4): undefined reference to `led_init_default_state_get'
   csky-linux-ld: rtl8366rb.c:(.text+0x110c): undefined reference to `devm_led_classdev_register_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

