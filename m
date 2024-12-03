Return-Path: <linux-kernel+bounces-428597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AA9E110D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFA81643FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2E13AD38;
	Tue,  3 Dec 2024 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBB8yp1R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D8154430
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191492; cv=none; b=KJzEWoemt/ol4PHDt46r3hYEeVwYNdDV9E9DAv15vkDE+OByQj7oizYcSaXJT7VFvcC7BeKemJtI39Cga/TAeMll7YnylrUUGpB/1TzN/UI4We4zgqVoDKDU8WhjGudafybW+Z9ERtfA58fzDHOv5mRlzIacNgrKo/C8Nn5RWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191492; c=relaxed/simple;
	bh=zHaBySKOWsAgJC+LLwtnmRKy62kVaj2vJSHwMqQWXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BuR56KZGzIEoln47pS+XCqy8j9R/6/E2wm+n/YWc557wBmVnQGFDl+MlLccrqzqyozDcvpZZgWlC0jtfRjBmUM2LFBOAwuQroxNdL2WTJ3xdfAQQEjv/FUNBrH/8nFGZBKK0bJTlKS8tIE57MW1XQecvCOFGbTeQfm6tpLzbYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBB8yp1R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733191491; x=1764727491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zHaBySKOWsAgJC+LLwtnmRKy62kVaj2vJSHwMqQWXQ4=;
  b=aBB8yp1RNbxrvkJjpZvnjbp2fkj4T86zPqVCQm8U9ENbVI3Xv4RPQsev
   a8/VbKkW5rX5rkHdTB/N8LcMlDObZ2JWoa5adXbpIN9g8a3aQ4HjB1/Mj
   X4Ec0EScORBAS5k+hW4Fk7Gd4byRT+w4z0W5LRRzk5fnpV+XO/k9JDdSA
   IBgsglDyBjW7V2NJPy3oHF7NO+UpbZmP4Uy9T7dXBbaXStchUTtSpMlJ2
   Gn6g9Y9L/UVoAiI9VO5RzfxEUefz6l3RxYbvGDmmp+YaIx6CSXGOfy/iB
   bErrFlLyU+L/QN04VY/Mqx3HvzcAxDNDheW70UBy32o4zgi0TFoXe9Jbb
   g==;
X-CSE-ConnectionGUID: /OaSzCjNTS+vccixaAWx1A==
X-CSE-MsgGUID: S07xkH/RSv6et+DHBNZHVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33535871"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33535871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:04:51 -0800
X-CSE-ConnectionGUID: yJS2GXG4TSS/3HxxsvnUjg==
X-CSE-MsgGUID: lFo5X/n8QuOmydUQstP/IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97718715"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2024 18:04:48 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIHJ-00039q-3B;
	Tue, 03 Dec 2024 02:04:43 +0000
Date: Tue, 3 Dec 2024 10:03:59 +0800
From: kernel test robot <lkp@intel.com>
To: Aswath Govindraju <a-govindraju@ti.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/adgs1408.c:62:12: warning: cast to smaller integer type
 'enum adgs1408_chip_id' from 'const void *'
Message-ID: <202412031033.V6Bj93BG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aswath,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   2 years, 8 months ago
config: x86_64-buildonly-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20241203/202412031033.V6Bj93BG-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031033.V6Bj93BG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031033.V6Bj93BG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mux/adgs1408.c:62:12: warning: cast to smaller integer type 'enum adgs1408_chip_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
      62 |         chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +62 drivers/mux/adgs1408.c

8b9ce6954c05e3 Mircea Caprioru     2018-08-01   52  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   53  static int adgs1408_probe(struct spi_device *spi)
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   54  {
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   55  	struct device *dev = &spi->dev;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   56  	enum adgs1408_chip_id chip_id;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   57  	struct mux_chip *mux_chip;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   58  	struct mux_control *mux;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   59  	s32 idle_state;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   60  	int ret;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   61  
b7820ae2d2929d Andy Shevchenko     2020-05-29  @62  	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   63  	if (!chip_id)
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   64  		chip_id = spi_get_device_id(spi)->driver_data;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   65  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   66  	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   67  	if (IS_ERR(mux_chip))
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   68  		return PTR_ERR(mux_chip);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   69  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   70  	mux_chip->ops = &adgs1408_ops;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   71  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   72  	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   73  	if (ret < 0)
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   74  		return ret;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   75  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   76  	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   77  	if (ret < 0)
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   78  		idle_state = MUX_IDLE_AS_IS;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   79  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   80  	mux = mux_chip->mux;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   81  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   82  	if (chip_id == ADGS1408)
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   83  		mux->states = 8;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   84  	else
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   85  		mux->states = 4;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   86  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   87  	switch (idle_state) {
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   88  	case MUX_IDLE_DISCONNECT:
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   89  	case MUX_IDLE_AS_IS:
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   90  	case 0 ... 7:
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   91  		/* adgs1409 supports only 4 states */
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   92  		if (idle_state < mux->states) {
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   93  			mux->idle_state = idle_state;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   94  			break;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   95  		}
df561f6688fef7 Gustavo A. R. Silva 2020-08-23   96  		fallthrough;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   97  	default:
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   98  		dev_err(dev, "invalid idle-state %d\n", idle_state);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01   99  		return -EINVAL;
8b9ce6954c05e3 Mircea Caprioru     2018-08-01  100  	}
8b9ce6954c05e3 Mircea Caprioru     2018-08-01  101  
8b9ce6954c05e3 Mircea Caprioru     2018-08-01  102  	return devm_mux_chip_register(dev, mux_chip);
8b9ce6954c05e3 Mircea Caprioru     2018-08-01  103  }
8b9ce6954c05e3 Mircea Caprioru     2018-08-01  104  

:::::: The code at line 62 was first introduced by commit
:::::: b7820ae2d2929d4d6e52462a820e760db35fdad6 mux: adgs1408: Add mod_devicetable.h and remove of_match_ptr

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

