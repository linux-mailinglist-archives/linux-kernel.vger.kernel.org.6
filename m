Return-Path: <linux-kernel+bounces-288433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2533953A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5673228666C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E513C909;
	Thu, 15 Aug 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLiTt8SK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36845144D18
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746546; cv=none; b=jR394Zt11PM/s6iPmE5BUMhL5DG9/532p/QqTpjE52epuVjX0ARGMFb5L971crp6Mw5zddyPwGhmDjIv3qUiZgDu8ySVzu85CR3aJ6YMkWF49BE5138Tn5AhixUTP6d0GbhXlQvYpFYklmRqVYbgA0AaniYKrvVxmQ4ib1UB7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746546; c=relaxed/simple;
	bh=Ff2Fzd5k0YVT5teeqp00lwdQRFZJavfRfjgx197Q6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BnrOHuXDM+orK6CjRaxdVFZ/p/E4XWa6EnZKwOzv8TQm/aqFZZZ6/6NRM8GYHTiUQ5p6lAeFOTEqzyTGPKA0H8iudG4Obl1edX4Q+ldmxENr8sR8sd9tqfMRSSMQc9yeXAfcnAwWt+gxib4HDQIFmdAuTePlKWtjbiTW+2dliSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLiTt8SK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723746545; x=1755282545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ff2Fzd5k0YVT5teeqp00lwdQRFZJavfRfjgx197Q6e8=;
  b=YLiTt8SK1+iNqMuLvQLNy7mPn+K5IuPU8Qb/+xJe/ZUFMmSHHTDm7ezF
   Z2L8ZRAdu1uinUiyWhNqyKpd0BRiYmQCUIn6/BMgDORK5vT3Erl3wpouh
   x1LniEHnn4UGEb/P4AcNUN8az/qzIt1bvhw4vI3WxWa8ClYDl1hlqh9h5
   k4ZsKIn9scyFTcx5hyawBk5ITHzcBwRhRIdeIvj7pCQRyEsN3Sv23GUHT
   cDyD262ZPO40oBtmQfhjLVLfWUo5Vk+liroKn8TTcTh2YirDdlYmZPrA6
   bOU+vswk144NmMts0aG7jzBoJPeyZTMcApikbqCBbYdMXvWSyqv9boqV+
   Q==;
X-CSE-ConnectionGUID: 3p8FaXYNQZufueHsyyRA7g==
X-CSE-MsgGUID: Wky2CcQFS26jBIJAS5KOsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="24921696"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="24921696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 11:29:04 -0700
X-CSE-ConnectionGUID: 2wFHRPpjTZuqTdIJbeY0fg==
X-CSE-MsgGUID: 2UdS7zfRRMKZXf/bo5F5jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59428355"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Aug 2024 11:29:04 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sefDY-0004n0-3D;
	Thu, 15 Aug 2024 18:29:01 +0000
Date: Fri, 16 Aug 2024 02:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: drivers/platform/cznic/turris-omnia-mcu-trng.c:(.text.omnia_mcu_register_trng+0x1a4):
 undefined reference to `devm_hwrng_register'
Message-ID: <202408160251.1obs1D1q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1fb918967b56df3262ee984175816f0acb310501
commit: c7da0d4e33ce262dbed7b9ae4cf013aad0f541f6 platform: cznic: turris-omnia-mcu: Make TRNG code optional
date:   8 days ago
config: mips-randconfig-r064-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160251.1obs1D1q-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160251.1obs1D1q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160251.1obs1D1q-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/platform/cznic/turris-omnia-mcu-trng.o: in function `omnia_mcu_register_trng':
>> drivers/platform/cznic/turris-omnia-mcu-trng.c:(.text.omnia_mcu_register_trng+0x1a4): undefined reference to `devm_hwrng_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

