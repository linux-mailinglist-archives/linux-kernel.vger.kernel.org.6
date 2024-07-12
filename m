Return-Path: <linux-kernel+bounces-250886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620492FE23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C5F1C23E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3417624F;
	Fri, 12 Jul 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYubKhbj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA217557E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800279; cv=none; b=pf/tX71n7s3z4CC8SANNabKyIHv6Rg4akfahPv80EEqV+mi3K35PPpP5Fmi4bLSvQVOxcSGfBzpxlNP9PirE9nKF71P2uUdK1DeNOaTRfvIOvg9+1oAbe0um+ugSkHzY6TkwNAc8DKgEKrdqGiFxJVzvLCAazjhDuBriOmx3U78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800279; c=relaxed/simple;
	bh=PrS7/hiydmmIrI/4eU8UQmnYT4Fs6FNxX99+1XPQp5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPyw3fyBhGYboNWU3hCEW/9xye6rclWZ9mtO0UHpxoLHSM0Jp7jUtGfu5XZLINMrJU+PrBVHw71gSlIwJag/wU7lN+k+oA0IU+Rh6Gj3h7BxOY0ufomz0c+1edmei34+nrIKkXF92A/8Zxj7Bgtw5rDHxYUmJtjS7DKGY/NRhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYubKhbj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720800276; x=1752336276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrS7/hiydmmIrI/4eU8UQmnYT4Fs6FNxX99+1XPQp5g=;
  b=IYubKhbjGCMjGQu63nlGQl1ToPSmWjhRSCFAziCRIDUsPbM4ngwKjVop
   JArsRoJzzE65juXtjPxR3TUmvhYzLmz7Z/qKe+f0eGVqYqFWmEYvBNbPn
   ptKxRmAtOqKx5EcgI3kZZRl5XIEWoXz4G8XgdAKicaqrkoOauv6XkWyW4
   oOSTgRzb1YSG0+TbBsvPnGgAlfaxLPZubeDK2RZYb4qtDPp1/b8C/CxtK
   oUJTAs0PE1MsRCwjWMtqqZjnV/3FJ5csrvNQDglP48zTeBfQWByzzM7fR
   9kVOBA3iZ3R0xYsfsM7R7UyP6HCok7zOrxnJZGh4cbuIJceM6N0kpctNK
   A==;
X-CSE-ConnectionGUID: 3tLRlwftQ3SfRo4AWjErJA==
X-CSE-MsgGUID: qCXnJwXxSw61iL2sCd0SEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29653984"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="29653984"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 09:04:36 -0700
X-CSE-ConnectionGUID: fTm1fZsjS9OPqAi2nNETVg==
X-CSE-MsgGUID: 2/xcHUf6T0ydbDSMfiqbAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="48838240"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Jul 2024 09:04:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSIl3-000awc-2n;
	Fri, 12 Jul 2024 16:04:29 +0000
Date: Sat, 13 Jul 2024 00:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Esben Haabendal <esben@geanix.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	linux-arm-kernel@lists.infradead.org,
	Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH v3 14/15] mtd: spi-nor: Drop deprecated mechanism for
 optional SFDP parsing
Message-ID: <202407122344.BP3r1VyN-lkp@intel.com>
References: <20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d@geanix.com>

Hi Esben,

kernel test robot noticed the following build errors:

[auto build test ERROR on a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6]

url:    https://github.com/intel-lab-lkp/linux/commits/Esben-Haabendal/mtd-spi-nor-core-add-flag-for-doing-optional-SFDP-parsing/20240711-224454
base:   a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
patch link:    https://lore.kernel.org/r/20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d%40geanix.com
patch subject: [PATCH v3 14/15] mtd: spi-nor: Drop deprecated mechanism for optional SFDP parsing
config: arm-randconfig-003-20240712 (https://download.01.org/0day-ci/archive/20240712/202407122344.BP3r1VyN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407122344.BP3r1VyN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407122344.BP3r1VyN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/spi-nor/atmel.c:9:
   drivers/mtd/spi-nor/core.h: In function 'spi_nor_try_sfdp':
>> drivers/mtd/spi-nor/core.h:722:61: error: expected ';' before '}' token
     722 |         return (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
         |                                                             ^
         |                                                             ;
     723 | }
         | ~                                                            


vim +722 drivers/mtd/spi-nor/core.h

   712	
   713	/**
   714	 * spi_nor_try_sfdp() - returns true if optional SFDP parsing should be tried
   715	 * for this flash, with fallback to static parameters and settings based on
   716	 * flash ID if SFDP parsing fails.
   717	 *
   718	 * Return: true if optional SFDP parsing should be tried
   719	 */
   720	static inline bool spi_nor_try_sfdp(const struct spi_nor *nor)
   721	{
 > 722		return (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
   723	}
   724	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

