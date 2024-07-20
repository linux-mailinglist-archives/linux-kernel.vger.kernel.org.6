Return-Path: <linux-kernel+bounces-257817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBAD937F59
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081C0B212C0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89116419;
	Sat, 20 Jul 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnBVTdbV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34812E61
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721458325; cv=none; b=uXkN6YWLVZn3uswLKOuxfI8lDuhLIkzp9f0KvJvuT3GLyjCpgDUROXgsyzjK3wCWM+ETTN27wG0ultbg3o4XIPJiXzTvJj770do4ApOHDyIf5pGRry3O7h5+beAw7eQ9PQWkEg5C19RN/RuYk3zBXDAwDr7vGt20iMa4g2voxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721458325; c=relaxed/simple;
	bh=iW4xld3yqHSHc0UfuFsGiSyCvDgQzg1uUU4yj5DjdUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iVdeu+Fzs6mcir4+b/y7nQJPVdA/8uGaiTdo5t0yX4KfkA1XYK87TcVMKw43q6ZgEHX1pTfavFUBElMr5st+6cVz1pxvOo+Ir9eJwXNsxeANaqA4aBnBlR7s6RW9K5qxFHuDo4UBUrvgl0FmryAgk5i34XIkLlLjoi6Jsf6khUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnBVTdbV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721458324; x=1752994324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iW4xld3yqHSHc0UfuFsGiSyCvDgQzg1uUU4yj5DjdUo=;
  b=jnBVTdbVrABBMPUBuXkSZ7SwqAZeKXBU5r9+271uCUR/GWvfHkZLSpwK
   RS3zhZTeH/P0zyAJdudhwfpdT49ketVGPGx/g7YodaFj3PbxvNmxBb+Kf
   S8z6FHIfVdOKwGWVevW4k0iHRJz1Ohyf2Ds9INK7R/G2bJ777RKpfX4Sp
   8oJe+8GGRKlN/Yh0+xOHbvyP2tR/Tw17cFV4aPdlGYkh4tbNXn/YdBf7H
   /CPMLAwRjLxXWyw/SNGN2iJtfLvOrxq6RseXwgFCJKSAGibypLNRyJy+N
   1ay9tbOT5I2lbpgpMyMKsI3RFL/gD2rbJSP0r176FYN7kObzD4YuSE+cq
   A==;
X-CSE-ConnectionGUID: Q6eztGKxSkCzeHqltHsuXg==
X-CSE-MsgGUID: OZcXFStgQsWBMWJV0TutXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="21985555"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="21985555"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:52:03 -0700
X-CSE-ConnectionGUID: v2cbz/24REaMOwWbk5Jddg==
X-CSE-MsgGUID: ViP3wWV9QlmCmx9RBT+L8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="56171196"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jul 2024 23:52:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sV3wk-000iwE-2v;
	Sat, 20 Jul 2024 06:51:58 +0000
Date: Sat, 20 Jul 2024 14:51:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: s390-linux-ld: drivers/net/dsa/realtek/rtl8366rb.c:980:undefined
 reference to `devm_led_classdev_register_ext'
Message-ID: <202407201701.nkpQZJZw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3c3ff7be9729959699eb6cbc7fd7303566d74069
commit: 32d617005475a71ebcc4ec8b2791e8d1481e9a10 net: dsa: realtek: add LED drivers for rtl8366rb
date:   3 months ago
config: s390-randconfig-s033-20221201 (https://download.01.org/0day-ci/archive/20240720/202407201701.nkpQZJZw-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407201701.nkpQZJZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407201701.nkpQZJZw-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/dsa/realtek/rtl8366rb.o: in function `rtl8366rb_setup_led':
   drivers/net/dsa/realtek/rtl8366rb.c:953:(.text+0x2e30): undefined reference to `led_init_default_state_get'
>> s390-linux-ld: drivers/net/dsa/realtek/rtl8366rb.c:980:(.text+0x30ba): undefined reference to `devm_led_classdev_register_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

