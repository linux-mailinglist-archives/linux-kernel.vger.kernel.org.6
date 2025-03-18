Return-Path: <linux-kernel+bounces-565498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D29A66991
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FE77A6570
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491931DB37B;
	Tue, 18 Mar 2025 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Huljf++6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122B1C9B97
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276410; cv=none; b=W/aKf5ATjACc2AAzMiGkhndvnwym6cizsaYiCUYOHuLL7VWnJ6sQrhvIiRs/Iz4RtfWvVDN68AvFvh6+8T+VJTVjlefWMSL8BW3rWl6ZzuFZsIjRQkTL5pUTbGnbCs08enQGeT9ijJheRkIi47EAlFyZSfk3wmf6fLBSQzbg/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276410; c=relaxed/simple;
	bh=HFrmONqkVemhA81XFnDlbnbFAvrPsvYETccZw5Mt8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gQrnaQOCRdbG2nli/HqVFzhHfh3WdlB/YBKKfAlE5xTPD2nPZGOPGr4IFPzFdSg43CSJmOl5NVRwITJ7lPYxDKi07UjyGw2GpkEnoaVYfmaWidT46fWU2qZ1BVWVufBUnq+3N/9OpF1Cm4NdxkATxc79Dv+jjRTeehN8ssHN/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Huljf++6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742276407; x=1773812407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HFrmONqkVemhA81XFnDlbnbFAvrPsvYETccZw5Mt8Wg=;
  b=Huljf++6z69dfrWx3Xmq74sH1xkbU9jTX5MWStHG/2Fab0zxL29u5Y+g
   mSTBtVprIJrP4ijbYACHuebNjo0ptwXL01JTF7XuhRGBMTG+VTRJBjmDL
   OGCZLQxdLi+YWcKwH7+kzFveRLXC5ZhBQ0xjHpc4bNhC9m8naFgfuVGIo
   LfuHfSXqjri06nE7QbuCTvs8FIEaE0BbpB44A5sN5pGIMnHp8m41Yh67v
   fxXe2tR1rjQ8eR6VeRIqRPH1CLUlaO8vXIfUkJGtMSeV9EG0/ZKumxbF+
   mHgU7Y8KpfvPgjxAIaVNjNrRQz59QqIcaBASLjOfopAYL1iYwR1JyMX9D
   g==;
X-CSE-ConnectionGUID: ybj4NXHWRa2M0QrbhBdYnQ==
X-CSE-MsgGUID: lpGpEHsEQjO5EYiomCfk7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42573833"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="42573833"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:37:35 -0700
X-CSE-ConnectionGUID: xiwzGKI/SQ2kG2HmKVAE6Q==
X-CSE-MsgGUID: tkgtoQs3RziekJvll6YR3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122655392"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2025 22:37:34 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuPdT-000DQy-0p;
	Tue, 18 Mar 2025 05:37:15 +0000
Date: Tue, 18 Mar 2025 13:36:14 +0800
From: kernel test robot <lkp@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/mtd/spinand.h:70:6: error: implicit declaration of
 function '__VA_OPT__'; did you mean '__SSP__'?
Message-ID: <202503181330.YcDXGy7F-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc444ada131001812c5d10b380837238c9cf7c8c
commit: 7ce0d16d5802bfde4209e52ee8ad644ca1eab423 mtd: spinand: Add an optional frequency to read from cache macros
date:   9 weeks ago
config: xtensa-randconfig-002-20250318 (https://download.01.org/0day-ci/archive/20250318/202503181330.YcDXGy7F-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181330.YcDXGy7F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181330.YcDXGy7F-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/nand/spi/xtx.c:10:0:
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/xtx.c:31:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/xtx.c:31:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd/nand/spi/alliancememory.c:8:0:
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/alliancememory.c:25:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/alliancememory.c:25:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd/nand/spi/esmt.c:10:0:
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/esmt.c:19:7: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
          SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/esmt.c:19:7: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
          SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd/nand/spi/skyhigh.c:11:0:
   include/linux/stddef.h:8:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
    #define NULL ((void *)0)
                 ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:47: note: in expansion of macro 'NULL'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                                  ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for '(anonymous)[4].data.nbytes')
    #define NULL ((void *)0)
                 ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:47: note: in expansion of macro 'NULL'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                                  ^~~~
   drivers/mtd/nand/spi/skyhigh.c:24:44: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                               ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:44: note: (near initialization for '(anonymous)[4].data.buf.in')
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                               ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:8:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
    #define NULL ((void *)0)
                 ^
   include/linux/mtd/spinand.h:308:41: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .nops = sizeof((struct spi_mem_op[]){ __VA_ARGS__ }) / \
                                            ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:47: note: in expansion of macro 'NULL'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                                  ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for '(anonymous)[4].data.nbytes')
    #define NULL ((void *)0)
                 ^
   include/linux/mtd/spinand.h:308:41: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .nops = sizeof((struct spi_mem_op[]){ __VA_ARGS__ }) / \
                                            ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:47: note: in expansion of macro 'NULL'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                                  ^~~~
   drivers/mtd/nand/spi/skyhigh.c:24:44: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                               ^
   include/linux/mtd/spinand.h:308:41: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .nops = sizeof((struct spi_mem_op[]){ __VA_ARGS__ }) / \
                                            ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:44: note: (near initialization for '(anonymous)[4].data.buf.in')
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
                                               ^
   include/linux/mtd/spinand.h:308:41: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .nops = sizeof((struct spi_mem_op[]){ __VA_ARGS__ }) / \
                                            ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:69:6: note: in expansion of macro 'SPI_MEM_OP_DATA_IN'
         SPI_MEM_OP_DATA_IN(len, buf, 1),   \
         ^~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:308:41: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .nops = sizeof((struct spi_mem_op[]){ __VA_ARGS__ }) / \
                                            ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/skyhigh.c:24:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd/nand/spi/foresee.c:10:0:
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/foresee.c:18:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/foresee.c:18:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd/nand/spi/winbond.c:12:0:
>> include/linux/mtd/spinand.h:70:6: error: implicit declaration of function '__VA_OPT__'; did you mean '__SSP__'? [-Werror=implicit-function-declaration]
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
         ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   drivers/mtd/nand/spi/winbond.c:26:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spi/spi-mem.h:113:2: error: expected expression before '.' token
     .max_freq = __freq
     ^
   include/linux/mtd/spinand.h:307:34: note: in definition of macro 'SPINAND_OP_VARIANTS'
      .ops = (struct spi_mem_op[]) { __VA_ARGS__ },  \
                                     ^~~~~~~~~~~
   include/linux/mtd/spinand.h:66:2: note: in expansion of macro 'SPI_MEM_OP'
     SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),    \
     ^~~~~~~~~~
   include/linux/mtd/spinand.h:70:17: note: in expansion of macro 'SPI_MEM_OP_MAX_FREQ'
         __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
                    ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/winbond.c:26:3: note: in expansion of macro 'SPINAND_PAGE_READ_FROM_CACHE_OP'
      SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +70 include/linux/mtd/spinand.h

    18	
    19	/**
    20	 * Standard SPI NAND flash operations
    21	 */
    22	
    23	#define SPINAND_RESET_OP						\
    24		SPI_MEM_OP(SPI_MEM_OP_CMD(0xff, 1),				\
    25			   SPI_MEM_OP_NO_ADDR,					\
    26			   SPI_MEM_OP_NO_DUMMY,					\
    27			   SPI_MEM_OP_NO_DATA)
    28	
    29	#define SPINAND_WR_EN_DIS_OP(enable)					\
    30		SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
    31			   SPI_MEM_OP_NO_ADDR,					\
    32			   SPI_MEM_OP_NO_DUMMY,					\
    33			   SPI_MEM_OP_NO_DATA)
    34	
    35	#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
    36		SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
    37			   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
    38			   SPI_MEM_OP_DUMMY(ndummy, 1),				\
    39			   SPI_MEM_OP_DATA_IN(len, buf, 1))
    40	
    41	#define SPINAND_SET_FEATURE_OP(reg, valptr)				\
    42		SPI_MEM_OP(SPI_MEM_OP_CMD(0x1f, 1),				\
    43			   SPI_MEM_OP_ADDR(1, reg, 1),				\
    44			   SPI_MEM_OP_NO_DUMMY,					\
    45			   SPI_MEM_OP_DATA_OUT(1, valptr, 1))
    46	
    47	#define SPINAND_GET_FEATURE_OP(reg, valptr)				\
    48		SPI_MEM_OP(SPI_MEM_OP_CMD(0x0f, 1),				\
    49			   SPI_MEM_OP_ADDR(1, reg, 1),				\
    50			   SPI_MEM_OP_NO_DUMMY,					\
    51			   SPI_MEM_OP_DATA_IN(1, valptr, 1))
    52	
    53	#define SPINAND_BLK_ERASE_OP(addr)					\
    54		SPI_MEM_OP(SPI_MEM_OP_CMD(0xd8, 1),				\
    55			   SPI_MEM_OP_ADDR(3, addr, 1),				\
    56			   SPI_MEM_OP_NO_DUMMY,					\
    57			   SPI_MEM_OP_NO_DATA)
    58	
    59	#define SPINAND_PAGE_READ_OP(addr)					\
    60		SPI_MEM_OP(SPI_MEM_OP_CMD(0x13, 1),				\
    61			   SPI_MEM_OP_ADDR(3, addr, 1),				\
    62			   SPI_MEM_OP_NO_DUMMY,					\
    63			   SPI_MEM_OP_NO_DATA)
    64	
    65	#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len, ...) \
    66		SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
    67			   SPI_MEM_OP_ADDR(2, addr, 1),				\
    68			   SPI_MEM_OP_DUMMY(ndummy, 1),				\
    69			   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
  > 70			   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
    71	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

