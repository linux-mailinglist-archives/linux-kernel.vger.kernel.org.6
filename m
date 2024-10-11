Return-Path: <linux-kernel+bounces-360750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789C999F05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE931F2513C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5420B1E7;
	Fri, 11 Oct 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S87bKWy5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D820ADD2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635349; cv=none; b=myuVEDzhM8txwCAFrpv1uzzKA+daYbAeJsTpdDRRjkwGE1yKTp1yEZvC9GiJ0RT40MPF7Jk+OdHNGUUjQn2F4JQg1a6SA6GXKyPGL3n3xFSY9e+bxCvLmnxipAAbOhKdNcXcJW4GxbKgnyRwo93JEe2H38So3n+1L/Vf9VIOuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635349; c=relaxed/simple;
	bh=sWApX7hW1a/Db71jMjGkUBroIFAwYgNAzreL76Vtd6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNTDyUNWf5cwK571bNiarDtKLC8fsPzYE46DiOFy43VGMqlt6g2dv0H86dcBvQIONVqBv/sQ4rxOrfWO5SUYw872oeLKxtxQa/hDotc6asP0qXCWRMQxeGxnCzb/22jPwrcA2MIxd6tae2c1KljkrPfSQnl1mUcUJQWwF605W3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S87bKWy5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728635348; x=1760171348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWApX7hW1a/Db71jMjGkUBroIFAwYgNAzreL76Vtd6c=;
  b=S87bKWy5Z2Euj4Ci8OJ/Is/3hzz5j2wcYY3+VWvwUP2ICxlPprdBt+gF
   EWM7RQkXwKPWRI7vMCJVEpcF2ArwMJzfMab4BoXh3KNiK83SJCoS7ETlk
   Di7fO2I6GuwaSoDdV/xcOhywPbKF6o6dyykuA7CJ7q6cJMobzoGqHfre1
   +JUIs2cmc9bSMC0gkuGbBAMISbwpU26d2KBuR4nV/PsNo4vzjcXW+drJl
   3OuzY2vVLWxU3WJDnSN90QR0QrzGqeV7uJQWuS3+nkZQZbr+LF+PQd2k6
   KLAc7F+F9B/fR2MlNfKoZMeDmHTz02r70xL07ANI/j+LASD0RjQvdz+J9
   w==;
X-CSE-ConnectionGUID: 19DiBO5yTxi+oxKtSRaRKA==
X-CSE-MsgGUID: Y4gl3zJmRdSCtGSY+FJ4Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27479151"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27479151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:29:08 -0700
X-CSE-ConnectionGUID: UoFFdTY9RPeC9ZLcflbb8g==
X-CSE-MsgGUID: 7UWXSOB5TWaM6WZ/xgR6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76467530"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Oct 2024 01:29:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szB1D-000C4f-1R;
	Fri, 11 Oct 2024 08:29:03 +0000
Date: Fri, 11 Oct 2024 16:28:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: Re: [PATCH 2/6] misc: keba: Add LAN9252 driver
Message-ID: <202410111611.EMSfFrYK-lkp@intel.com>
References: <20241009202949.20164-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009202949.20164-3-gerhard@engleder-embedded.com>

Hi Gerhard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.12-rc2 next-20241010]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerhard-Engleder/misc-keba-Add-SPI-controller-device/20241010-051016
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241009202949.20164-3-gerhard%40engleder-embedded.com
patch subject: [PATCH 2/6] misc: keba: Add LAN9252 driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241011/202410111611.EMSfFrYK-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111611.EMSfFrYK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111611.EMSfFrYK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/misc/keba/lan9252.c:299:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     299 |                 return ret;
         |                        ^~~
   drivers/misc/keba/lan9252.c:291:9: note: initialize the variable 'ret' to silence this warning
     291 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +299 drivers/misc/keba/lan9252.c

   286	
   287	static int lan9252_probe(struct spi_device *spi)
   288	{
   289		u32 data;
   290		int retry = SPI_RETRY_COUNT;
   291		int ret;
   292	
   293		/* execute specified initialization sequence */
   294		while (retry && !lan9252_init(spi))
   295			retry--;
   296		if (retry == 0) {
   297			dev_err(&spi->dev,
   298				"Can't initialize LAN9252 SPI communication!");
 > 299			return ret;
   300		}
   301	
   302		/* enable access to MII management for PDI */
   303		ret = lan9252_access_mii(spi, true);
   304		if (ret) {
   305			dev_err(&spi->dev, "Can't enable access to MII management!");
   306			return ret;
   307		}
   308	
   309		/*
   310		 * check PHY configuration and configure if necessary
   311		 *	- full duplex
   312		 *	- auto negotiation disabled
   313		 *	- 100 Mbps
   314		 */
   315		ret = lan9252_mii_read(spi, PHY_ADDRESS, MII_BMCR, &data);
   316		if (ret) {
   317			dev_err(&spi->dev, "Can't read LAN9252 configuration!");
   318			goto out;
   319		}
   320		if (!(data & BMCR_FULLDPLX) || (data & BMCR_ANENABLE) ||
   321		    !(data & BMCR_SPEED100)) {
   322			/*
   323			 */
   324			data &= ~(BMCR_ANENABLE);
   325			data |= (BMCR_FULLDPLX | BMCR_SPEED100);
   326			ret = lan9252_mii_write(spi, PHY_ADDRESS, MII_BMCR, data);
   327			if (ret)
   328				dev_err(&spi->dev,
   329					"Can't write LAN9252 configuration!");
   330		}
   331	
   332		dev_info(&spi->dev, "LAN9252 PHY configuration");
   333	
   334	out:
   335		/* disable access to MII management for PDI */
   336		lan9252_access_mii(spi, false);
   337	
   338		return ret;
   339	}
   340	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

