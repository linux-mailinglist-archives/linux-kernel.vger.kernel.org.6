Return-Path: <linux-kernel+bounces-428756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927499E12FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A02282B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379D170A37;
	Tue,  3 Dec 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPnek5Gu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D46FC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204624; cv=none; b=OF+OdAI+bkGLgYfJMU9lzWh76e6fREfwjbdvHgkd/ACVsmSFIpWGDd9oIvG79/NgErsxPdzjss7WIlLNiI2UWN6Rt9Pu1IoSVaRRLjXL6OurS1imAEY+a9KNPy4pC/mVcOaehVvNpctd3iIAyA15F9uTKk31DoG6hRMsTw/QXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204624; c=relaxed/simple;
	bh=w7JMieqJaIpZREboha6uQByQHib6tCsCSHYWdIAUQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XzIKQzaqW6TZJ4dTVUWpq+x5RuMiBZGKVO78xoYNdpVfV6RmqD1n/qaP3p/SyR5h0TaodUrh0ySpqvE3t6E7dPDf/ZvR5NhbVnEjapLBXon9yVpr0rnI9DaubIhZGNJQek1pgCciFYgr6AAHjn3Tp0lcVQ+f3HHTTbRiKYDwyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPnek5Gu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733204623; x=1764740623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w7JMieqJaIpZREboha6uQByQHib6tCsCSHYWdIAUQBs=;
  b=RPnek5Gu3FTr3OmKPC+I24YHH/rDP4oKcNkgEWpOLwIzcv/EDu9jbhYg
   n+i438nch6Nzp1u+0j4QkmK8PM9vD6iytuGdsvVA2wAYQp1DPmIzILZnU
   5Yt2UQRY/y4b8y+UnirW0CMOa7hCP1zA2yEBJ667GKuoPOthudmAOHkty
   q/LnfxrY6c89ljzx0f6SwKurFNxU1wxwW8XVTbdlnkUK1UrQX1W6F42Ys
   d5fClZQRLpKeE85uEeYEw/vkVx02tY8t2Q6AloSIvTjWbjmKqRt28E6LG
   iqWFJNojpbuJVyeJ9pZNisqnzAMBNn9UhjM0PFBTnCzLn/RLZYYVqKIPB
   Q==;
X-CSE-ConnectionGUID: UaAlUU+OSAertXa9H9aeHQ==
X-CSE-MsgGUID: rmIQoO61S+qDLduRmOWV/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44787574"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44787574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 21:43:43 -0800
X-CSE-ConnectionGUID: sR2emh6VSbS6eoanaiRjrA==
X-CSE-MsgGUID: VZNdvbzOR2Ol4lXFPe50Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93521945"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Dec 2024 21:43:41 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tILhD-0000Ax-0g;
	Tue, 03 Dec 2024 05:43:39 +0000
Date: Tue, 3 Dec 2024 13:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Rob Herring <robh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/regulator/da9121-regulator.c:1133:24: warning: cast to
 smaller integer type 'enum da9121_subvariant' from 'const void *'
Message-ID: <202412031346.i4MX8xOA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 46537a8676d6555141c4b98ec1bf5f3eea971128 regulator: da9121: Use i2c_get_match_data()
date:   1 year, 2 months ago
config: x86_64-randconfig-001-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031346.i4MX8xOA-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031346.i4MX8xOA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031346.i4MX8xOA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/da9121-regulator.c:1133:24: warning: cast to smaller integer type 'enum da9121_subvariant' from 'const void *' [-Wvoid-pointer-to-enum-cast]
    1133 |         chip->subvariant_id = (enum da9121_subvariant)i2c_get_match_data(i2c);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1133 drivers/regulator/da9121-regulator.c

  1119	
  1120	static int da9121_i2c_probe(struct i2c_client *i2c)
  1121	{
  1122		struct da9121 *chip;
  1123		const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
  1124		int ret = 0;
  1125	
  1126		chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
  1127		if (!chip) {
  1128			ret = -ENOMEM;
  1129			goto error;
  1130		}
  1131	
  1132		chip->pdata = i2c->dev.platform_data;
> 1133		chip->subvariant_id = (enum da9121_subvariant)i2c_get_match_data(i2c);
  1134	
  1135		ret = da9121_assign_chip_model(i2c, chip);
  1136		if (ret < 0)
  1137			goto error;
  1138	
  1139		ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
  1140		if (ret != 0) {
  1141			dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
  1142			goto error;
  1143		}
  1144	
  1145		ret = da9121_set_regulator_config(chip);
  1146		if (ret < 0)
  1147			goto error;
  1148	
  1149		ret = da9121_config_irq(i2c, chip);
  1150	
  1151	error:
  1152		return ret;
  1153	}
  1154	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

