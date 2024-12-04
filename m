Return-Path: <linux-kernel+bounces-431945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823C9E42F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCC1658D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA115C13A;
	Wed,  4 Dec 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3L5BOIV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D84A28
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335543; cv=none; b=QluGBuRuOiDEZtDaZ/iiUk6KuQyH02CAgEEWfP/PYXLTYU/wACI/9hqaqwDrbESdA/U+0Pi9PpgaB19hPpaccqbLQ8BCKHdpPmlW2ZRAd1Y7zlzko4rwEsVJOW2yYXc/fPU/IbKbNaYkRnAZAY4/WPVfjAE5lzXsZmZMITYiBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335543; c=relaxed/simple;
	bh=KDsqjPGEdAfkJJCjm3Se/f6wlCOq6Ea/0n/FOMljskc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uRJjyr9mh0AXoRxASC02BVLqmjvOtqCwH4d5XtExoOY7m3hFYOEVBlmSJVr/KD+PGszinRsqd+NWA4cbI2YiAGVdvIxIqLpJ7bYUr6yDjItnEiZAx2oj8ZmcE+yzxu4xCgnTXdpH2A1nt95h6gb48YjfyE4JV3thvOProfmIZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3L5BOIV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733335539; x=1764871539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KDsqjPGEdAfkJJCjm3Se/f6wlCOq6Ea/0n/FOMljskc=;
  b=X3L5BOIVq+Zqb4dGkXsv+Wn27TQBhMQvBdBvRXXjSlk6FJUZClkzRXku
   W6sFqqawi4wWBeAgMd+2Coa4WATC+iA+dOaEfULHqisHBZhvSY+0wwlLX
   z/hgFl2eXi1+TxjuyQLWhYRJQexEOmmaVedIO+o0bPmDvwGlh9kng+Biq
   pF/vXTFHx7GY5iBZN6e3YLun729JlYlZdAYncrln6XNLgf2rjq9X+M4w6
   gcPfaqnE0nQ+U+/Dppc+arAIyJgs7yE/fWnKA7NkcGHVADzvsmFyQ5Bml
   sw66AWpT59t4Xt+LDCH+ZKljkWgsxyWIslwoiR2KVLND1S+7z7RkZj89o
   Q==;
X-CSE-ConnectionGUID: 8Qoy9MzyQTag/Hd4haXTLg==
X-CSE-MsgGUID: tGFBWj2aToqKe6IK2DBbAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33677921"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33677921"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 10:05:39 -0800
X-CSE-ConnectionGUID: 56yBBsQiS5Gc7nTfs+RHPw==
X-CSE-MsgGUID: izkEEc6nSpC0naQl+YKYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93688417"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 10:05:36 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tItkk-0003Mp-1Y;
	Wed, 04 Dec 2024 18:05:34 +0000
Date: Thu, 5 Dec 2024 02:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse:
 cast to restricted __be32
Message-ID: <202412050113.Q4ffIgnH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miquel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   6 years ago
config: arm-randconfig-r132-20240106 (https://download.01.org/0day-ci/archive/20241205/202412050113.Q4ffIgnH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241205/202412050113.Q4ffIgnH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050113.Q4ffIgnH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1517:41: sparse: sparse: dubious: x | !y

vim +1403 drivers/mtd/nand/raw/brcmnand/brcmnand.c

27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1310  
5295cf2e047cf6 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1311  static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1312  			     int column, int page_addr)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1313  {
5295cf2e047cf6 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1314  	struct mtd_info *mtd = nand_to_mtd(chip);
d699ed250c0738 drivers/mtd/nand/brcmnand/brcmnand.c     Boris Brezillon 2015-12-10  1315  	struct brcmnand_host *host = nand_get_controller_data(chip);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1316  	struct brcmnand_controller *ctrl = host->ctrl;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1317  	u64 addr = (u64)page_addr << chip->page_shift;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1318  	int native_cmd = 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1319  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1320  	if (command == NAND_CMD_READID || command == NAND_CMD_PARAM ||
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1321  			command == NAND_CMD_RNDOUT)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1322  		addr = (u64)column;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1323  	/* Avoid propagating a negative, don't-care address */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1324  	else if (page_addr < 0)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1325  		addr = 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1326  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1327  	dev_dbg(ctrl->dev, "cmd 0x%x addr 0x%llx\n", command,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1328  		(unsigned long long)addr);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1329  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1330  	host->last_cmd = command;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1331  	host->last_byte = 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1332  	host->last_addr = addr;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1333  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1334  	switch (command) {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1335  	case NAND_CMD_RESET:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1336  		native_cmd = CMD_FLASH_RESET;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1337  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1338  	case NAND_CMD_STATUS:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1339  		native_cmd = CMD_STATUS_READ;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1340  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1341  	case NAND_CMD_READID:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1342  		native_cmd = CMD_DEVICE_ID_READ;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1343  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1344  	case NAND_CMD_READOOB:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1345  		native_cmd = CMD_SPARE_AREA_READ;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1346  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1347  	case NAND_CMD_ERASE1:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1348  		native_cmd = CMD_BLOCK_ERASE;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1349  		brcmnand_wp(mtd, 0);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1350  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1351  	case NAND_CMD_PARAM:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1352  		native_cmd = CMD_PARAMETER_READ;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1353  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1354  	case NAND_CMD_SET_FEATURES:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1355  	case NAND_CMD_GET_FEATURES:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1356  		brcmnand_low_level_op(host, LL_OP_CMD, command, false);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1357  		brcmnand_low_level_op(host, LL_OP_ADDR, column, false);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1358  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1359  	case NAND_CMD_RNDOUT:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1360  		native_cmd = CMD_PARAMETER_CHANGE_COL;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1361  		addr &= ~((u64)(FC_BYTES - 1));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1362  		/*
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1363  		 * HW quirk: PARAMETER_CHANGE_COL requires SECTOR_SIZE_1K=0
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1364  		 * NB: hwcfg.sector_size_1k may not be initialized yet
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1365  		 */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1366  		if (brcmnand_get_sector_size_1k(host)) {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1367  			host->hwcfg.sector_size_1k =
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1368  				brcmnand_get_sector_size_1k(host);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1369  			brcmnand_set_sector_size_1k(host, 0);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1370  		}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1371  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1372  	}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1373  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1374  	if (!native_cmd)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1375  		return;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1376  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1377  	brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1378  		(host->cs << 16) | ((addr >> 32) & 0xffff));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1379  	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1380  	brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS, lower_32_bits(addr));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1381  	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1382  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1383  	brcmnand_send_cmd(host, native_cmd);
f1d46942e823ff drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1384  	brcmnand_waitfunc(chip);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1385  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1386  	if (native_cmd == CMD_PARAMETER_READ ||
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1387  			native_cmd == CMD_PARAMETER_CHANGE_COL) {
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1388  		/* Copy flash cache word-wise */
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1389  		u32 *flash_cache = (u32 *)ctrl->flash_cache;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1390  		int i;
c26211d37f11d5 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-05-12  1391  
eab7fdc7bb8404 drivers/mtd/nand/brcmnand/brcmnand.c     Ray Jui         2016-07-20  1392  		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
c26211d37f11d5 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-05-12  1393  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1394  		/*
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1395  		 * Must cache the FLASH_CACHE now, since changes in
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1396  		 * SECTOR_SIZE_1K may invalidate it
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1397  		 */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1398  		for (i = 0; i < FC_WORDS; i++)
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1399  			/*
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1400  			 * Flash cache is big endian for parameter pages, at
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1401  			 * least on STB SoCs
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1402  			 */
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16 @1403  			flash_cache[i] = be32_to_cpu(brcmnand_read_fc(ctrl, i));
c26211d37f11d5 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-05-12  1404  
eab7fdc7bb8404 drivers/mtd/nand/brcmnand/brcmnand.c     Ray Jui         2016-07-20  1405  		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
c26211d37f11d5 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-05-12  1406  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1407  		/* Cleanup from HW quirk: restore SECTOR_SIZE_1K */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1408  		if (host->hwcfg.sector_size_1k)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1409  			brcmnand_set_sector_size_1k(host,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1410  						    host->hwcfg.sector_size_1k);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1411  	}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1412  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1413  	/* Re-enable protection is necessary only after erase */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1414  	if (command == NAND_CMD_ERASE1)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1415  		brcmnand_wp(mtd, 1);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1416  }
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1417  
7e534323c41621 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1418  static uint8_t brcmnand_read_byte(struct nand_chip *chip)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1419  {
d699ed250c0738 drivers/mtd/nand/brcmnand/brcmnand.c     Boris Brezillon 2015-12-10  1420  	struct brcmnand_host *host = nand_get_controller_data(chip);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1421  	struct brcmnand_controller *ctrl = host->ctrl;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1422  	uint8_t ret = 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1423  	int addr, offs;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1424  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1425  	switch (host->last_cmd) {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1426  	case NAND_CMD_READID:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1427  		if (host->last_byte < 4)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1428  			ret = brcmnand_read_reg(ctrl, BRCMNAND_ID) >>
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1429  				(24 - (host->last_byte << 3));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1430  		else if (host->last_byte < 8)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1431  			ret = brcmnand_read_reg(ctrl, BRCMNAND_ID_EXT) >>
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1432  				(56 - (host->last_byte << 3));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1433  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1434  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1435  	case NAND_CMD_READOOB:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1436  		ret = oob_reg_read(ctrl, host->last_byte);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1437  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1438  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1439  	case NAND_CMD_STATUS:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1440  		ret = brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS) &
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1441  					INTFC_FLASH_STATUS;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1442  		if (wp_on) /* hide WP status */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1443  			ret |= NAND_STATUS_WP;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1444  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1445  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1446  	case NAND_CMD_PARAM:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1447  	case NAND_CMD_RNDOUT:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1448  		addr = host->last_addr + host->last_byte;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1449  		offs = addr & (FC_BYTES - 1);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1450  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1451  		/* At FC_BYTES boundary, switch to next column */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1452  		if (host->last_byte > 0 && offs == 0)
97d90da8a88694 drivers/mtd/nand/brcmnand/brcmnand.c     Boris Brezillon 2017-11-30  1453  			nand_change_read_column_op(chip, addr, NULL, 0, false);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1454  
d618baf94c62eb drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-11-16  1455  		ret = ctrl->flash_cache[offs];
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1456  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1457  	case NAND_CMD_GET_FEATURES:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1458  		if (host->last_byte >= ONFI_SUBFEATURE_PARAM_LEN) {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1459  			ret = 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1460  		} else {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1461  			bool last = host->last_byte ==
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1462  				ONFI_SUBFEATURE_PARAM_LEN - 1;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1463  			brcmnand_low_level_op(host, LL_OP_RD, 0, last);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1464  			ret = brcmnand_read_reg(ctrl, BRCMNAND_LL_RDATA) & 0xff;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1465  		}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1466  	}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1467  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1468  	dev_dbg(ctrl->dev, "read byte = 0x%02x\n", ret);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1469  	host->last_byte++;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1470  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1471  	return ret;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1472  }
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1473  
7e534323c41621 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1474  static void brcmnand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1475  {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1476  	int i;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1477  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1478  	for (i = 0; i < len; i++, buf++)
7e534323c41621 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1479  		*buf = brcmnand_read_byte(chip);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1480  }
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1481  
c0739d85723a38 drivers/mtd/nand/raw/brcmnand/brcmnand.c Boris Brezillon 2018-09-06  1482  static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1483  			       int len)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1484  {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1485  	int i;
d699ed250c0738 drivers/mtd/nand/brcmnand/brcmnand.c     Boris Brezillon 2015-12-10  1486  	struct brcmnand_host *host = nand_get_controller_data(chip);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1487  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1488  	switch (host->last_cmd) {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1489  	case NAND_CMD_SET_FEATURES:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1490  		for (i = 0; i < len; i++)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1491  			brcmnand_low_level_op(host, LL_OP_WR, buf[i],
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1492  						  (i + 1) == len);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1493  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1494  	default:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1495  		BUG();
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1496  		break;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1497  	}
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1498  }
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1499  
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1500  /**
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1501   * Construct a FLASH_DMA descriptor as part of a linked list. You must know the
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1502   * following ahead of time:
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1503   *  - Is this descriptor the beginning or end of a linked list?
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1504   *  - What is the (DMA) address of the next descriptor in the linked list?
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1505   */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1506  static int brcmnand_fill_dma_desc(struct brcmnand_host *host,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1507  				  struct brcm_nand_dma_desc *desc, u64 addr,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1508  				  dma_addr_t buf, u32 len, u8 dma_cmd,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1509  				  bool begin, bool end,
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1510  				  dma_addr_t next_desc)
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1511  {
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1512  	memset(desc, 0, sizeof(*desc));
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1513  	/* Descriptors are written in native byte order (wordwise) */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1514  	desc->next_desc = lower_32_bits(next_desc);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1515  	desc->next_desc_ext = upper_32_bits(next_desc);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1516  	desc->cmd_irq = (dma_cmd << 24) |
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06 @1517  		(end ? (0x03 << 8) : 0) | /* IRQ | STOP */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1518  		(!!begin) | ((!!end) << 1); /* head, tail */
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1519  #ifdef CONFIG_CPU_BIG_ENDIAN
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1520  	desc->cmd_irq |= 0x01 << 12;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1521  #endif
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1522  	desc->dram_addr = lower_32_bits(buf);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1523  	desc->dram_addr_ext = upper_32_bits(buf);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1524  	desc->tfr_len = len;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1525  	desc->total_len = len;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1526  	desc->flash_addr = lower_32_bits(addr);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1527  	desc->flash_addr_ext = upper_32_bits(addr);
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1528  	desc->cs = host->cs;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1529  	desc->status_valid = 0x01;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1530  	return 0;
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1531  }
27c5b17cd1b105 drivers/mtd/nand/brcmnand/brcmnand.c     Brian Norris    2015-03-06  1532  

:::::: The code at line 1403 was first introduced by commit
:::::: d618baf94c62eb63b5b7f6159fb6aee5550a2e10 mtd: brcmnand: clean up flash cache for parameter pages

:::::: TO: Brian Norris <computersforpeace@gmail.com>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

