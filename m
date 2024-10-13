Return-Path: <linux-kernel+bounces-362665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84F99B7D5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137A5B21D46
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D51870;
	Sun, 13 Oct 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLYwXtdf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4E1849
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728781414; cv=none; b=X5fO73GMgBFfQ1iC5TztW57ZaVAh8/yBJuZ+F2zjDUT7Xunr0WlpmkymypoLsLvgQKC+m1iioGX4nTdF6OLfVoMftPippA3HEE09gwfS1GZ4FJFXWGQ/mwH2S1aVJndxhnD15aulSVJqv+XoOaZH2swCTMmkcqBrgEL1YiKN2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728781414; c=relaxed/simple;
	bh=onQianqy7lCHxn/BoIBolTQEGs3mPxp+R6ytz+PsC1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5sTVqq8GYV7lqdl7NsRkMygAKVwmRlh471mTW/g0mnxMbpuQl7kgZhvm60FCUv+D0GQ4KetKk3SKuyZwI4uft77iUHwRgcTSvmAmlDG+5mknQWa+F4NuPzsh6YPsxyK6tiwyhdwOomfuPZZ89uoj1sW2Uq8Wo4M13aT3fNTfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLYwXtdf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728781411; x=1760317411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onQianqy7lCHxn/BoIBolTQEGs3mPxp+R6ytz+PsC1s=;
  b=YLYwXtdf5Z29PJV5mA/RlfOsslsnBaNnLskxqA8nbD52li3hzY+DZoPC
   Jj+ZhHZUHS+zq+ak1c884R+env6NDnd2WL9Oaw/sdsehQyzM1TMTFm/53
   eYM/xOwMDdcK4kpSiwSFXc1eCf1/WT81nGHfg66jeO+DXekqnDzJFUIyv
   iW6zTJ/stv1+uuC9JSa+7O9kBcK8ub7LGWLihziR/wTxn8mToE7XnTuMC
   OjHC9+n5JPjo++ripr7GsW3gw8jpDIhAdvQmVpa6cKPWzOY/DaqUoVP6a
   sVBpj6sghzGNhy/zwMrudmIJcLXrYKuZwyJyL+xnKYRINnmNm98cicCfY
   w==;
X-CSE-ConnectionGUID: GGI8u85BQZOwtkUXgIai9A==
X-CSE-MsgGUID: XGPCQdVoRq6E3Eh+9mw36Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31956494"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31956494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 18:03:30 -0700
X-CSE-ConnectionGUID: zBXMegZAR6aIgE9z8KwoIA==
X-CSE-MsgGUID: IN2Ixr8xQZitWCFXHJymXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="77337101"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Oct 2024 18:03:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szn15-000Dvp-0M;
	Sun, 13 Oct 2024 01:03:27 +0000
Date: Sun, 13 Oct 2024 09:03:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: Re: [PATCH 1/6] misc: keba: Add SPI controller device
Message-ID: <202410130817.NXBCxx4q-lkp@intel.com>
References: <20241009202949.20164-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009202949.20164-2-gerhard@engleder-embedded.com>

Hi Gerhard,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerhard-Engleder/misc-keba-Add-SPI-controller-device/20241010-051016
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241009202949.20164-2-gerhard%40engleder-embedded.com
patch subject: [PATCH 1/6] misc: keba: Add SPI controller device
config: csky-randconfig-r123-20241012 (https://download.01.org/0day-ci/archive/20241013/202410130817.NXBCxx4q-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241013/202410130817.NXBCxx4q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410130817.NXBCxx4q-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/misc/keba/cp500.o: in function `cp500_nvmem_match':
>> drivers/misc/keba/cp500.c:396:(.text+0x15e): undefined reference to `i2c_verify_client'
   csky-linux-ld: drivers/misc/keba/cp500.o: in function `cp500_i2c_release':
   drivers/misc/keba/cp500.c:287:(.text+0x1c0): undefined reference to `i2c_verify_client'


vim +396 drivers/misc/keba/cp500.c

   388	
   389	static int cp500_nvmem_match(struct device *dev, const void *data)
   390	{
   391		const struct cp500 *cp500 = data;
   392		struct i2c_client *client;
   393	
   394		/* match only CPU EEPROM below the cp500 device */
   395		dev = dev->parent;
 > 396		client = i2c_verify_client(dev);
   397		if (!client || client->addr != CP500_EEPROM_ADDR)
   398			return 0;
   399		while ((dev = dev->parent))
   400			if (dev == &cp500->pci_dev->dev)
   401				return 1;
   402	
   403		return 0;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

