Return-Path: <linux-kernel+bounces-428145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC59E0AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B34D1604F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3E1DE2AD;
	Mon,  2 Dec 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK5JL2ls"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877E1DDA3E;
	Mon,  2 Dec 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162998; cv=none; b=RBYvk2yxkXmexjjZ40DJRvBvF+TJXY32Un7GrSXb398R4+pabnBvG1UaoML5zg18DK1o4FkaY1PL9GCVr2mkvU8CViT9QTvAtbOuEz2a57N4KOypUbSbyv5yfE4w0Wp+GAdagpwN3MSor+aeO6WdoO8cRsEV2UYTFTZ6b0GEilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162998; c=relaxed/simple;
	bh=nYDjefpF3SzrsKFGQUqg+JR6F6Cz+vcqakgcruJHmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQfqjAcPhFHvDuxeAs0Pg10RxzdodPVFo2XKG102hXsWWhspOMV2eXJAN8IHrzI60soINMxfbnTMNfaiFSuy57o1gRhHui2dKlsVhVgQXXAiPZoxRsZVnB8T9IoZnG01gjqUdyomoTM+T1iA6pAVUu+sasiiB0BH/DtRZ0EJLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK5JL2ls; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733162995; x=1764698995;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nYDjefpF3SzrsKFGQUqg+JR6F6Cz+vcqakgcruJHmbA=;
  b=JK5JL2lsP5ws6+soOvguyS+HwfTQggl3NXAFzFKltCSY96sgeQZ4qqCq
   pOUMclj+Z+3uto0bg6hsszhWi/UFa/mZ3Wmdz11yuAvPE5iAoQ+lnFfg4
   lNfDjgqA8I/mKs/slKRt91QqUvR0u5nDrEFD3WaBCbNxyLDWIvTWk3lcy
   +pR1akInzlF13+z0UtzUTDBFiDIFdBqgRuoSoh1RgF2j5Hh6NGJOVf6El
   Ql01Arwvef2EqsGt1LUHb3kCpYXEhWdHydPKI/IXBzp/vuNcsd30CXP4/
   rUfXLZjT1+GIP3UBvw0aTdsxaxnjn94ZCrbDwBUaqSnAlIv2YcsmyrfjR
   Q==;
X-CSE-ConnectionGUID: IHCIRBWrS52WEI4jl5JHnQ==
X-CSE-MsgGUID: iQYevqQ5RDC1aIFu9QqSSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44731082"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44731082"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:09:54 -0800
X-CSE-ConnectionGUID: biV1p/54Qgegk6CrVFLakQ==
X-CSE-MsgGUID: spgtlyGsQAqE/Y+uUqvhuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93358378"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Dec 2024 10:09:54 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIArn-0002hw-0T;
	Mon, 02 Dec 2024 18:09:51 +0000
Date: Tue, 3 Dec 2024 02:08:33 +0800
From: kernel test robot <lkp@intel.com>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-doc@vger.kernel.org
Subject: htmldocs: Warning:
 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
 references a file that doesn't exist:
 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
Message-ID: <202412030201.ikUpdSN3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
commit: d496d68d6ba6debcc135794edb5fdc5a5b4531f1 dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
date:   2 years, 7 months ago
reproduce: (https://download.01.org/0day-ci/archive/20241203/202412030201.ikUpdSN3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030201.ikUpdSN3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/dev-tools/kunit/run_wrapper.rst references a file that doesn't exist: Documentation/dev-tools/kunit/non_uml.rst
   Warning: Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt references a file that doesn't exist: Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
   Warning: Documentation/devicetree/bindings/gnss/mediatek.txt references a file that doesn't exist: Documentation/devicetree/bindings/gnss/gnss.txt
   Warning: Documentation/devicetree/bindings/leds/leds-mt6360.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6360.yaml
   Warning: Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/translations/it_IT/networking/netdev-FAQ.rst references a file that doesn't exist: Documentation/networking/netdev-FAQ.rst
   Warning: Documentation/translations/zh_CN/devicetree/index.rst references a file that doesn't exist: Documentation/Devicetree/index.rst
   Warning: Documentation/translations/zh_CN/devicetree/of_unittest.rst references a file that doesn't exist: Documentation/Devicetree/of_unittest.rst
   Warning: Documentation/translations/zh_CN/devicetree/usage-model.rst references a file that doesn't exist: Documentation/Devicetree/usage-model.rst
   Warning: Documentation/translations/zh_CN/doc-guide/kernel-doc.rst references a file that doesn't exist: Documentation/rust/docs.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

