Return-Path: <linux-kernel+bounces-216068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D8909AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B01F219CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CE1849;
	Sun, 16 Jun 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY1gDDpp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D781847;
	Sun, 16 Jun 2024 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718498469; cv=none; b=Tgz8kRdFWtVW3UJ6huDeh4oDK8aOmSXo4dq9NLxh8P5Kdbim5XhQuM0pxjIWk200TMHStwCLGbgjHAxcbKXwBukXu+70/su97lqGO4ON7QzQYD3R4dD4Avj4bsDX8AP+q65ddiJq0eYyFjDdJxa2flY3k5PqOSz6nDrKF/jcNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718498469; c=relaxed/simple;
	bh=80XxlEDYtt1XhtOCHEj2fkh3ftEPNrBzkDjxXzMkpG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBJHJGXv8+t54eIdraI98MQg8WgZCZc8gXD1EaIWbuKui4VhmXcGsk5gaofjX2F20+oZVJ2iORWoGrMK9HzQYMyJNU7mFvKsvWBtx+Z7CVP080fIBgyD5sWjFAGIOBcWxa8lNQDut9gz54Z9pieaZzsRHfe9cdcEJDHbTr/vmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY1gDDpp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718498468; x=1750034468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80XxlEDYtt1XhtOCHEj2fkh3ftEPNrBzkDjxXzMkpG8=;
  b=IY1gDDppdTugANPAWyvCUivGinSkaK5jK0dFh9HsIkftcJM4kIY2Pz0B
   ZgX9eNsidGM/aVDZ/uHudEwep514fSaK+aCB435vHx5g1oHbMijsg9iHF
   jiVb7oWvLRClk6GMd/QwZ5qMumTw50RAYCLXQ57KzZmPGdDzOpBGa6JxA
   F5r/VPyQAE7yWAH387T9YVAoVTqKI1pYIQGndOW9GRJOmVtF1u+KjsMAr
   BGfk2sgcrTmOEh88mhybV94mJGWh6Lp7K8EDdNBlaywiqYJOL14gt4Xw6
   XokRVkdkb6AjkypbugtyxB6WtZF1ua0DRPdON3AI9Sv2lqoa95Htkr/yM
   A==;
X-CSE-ConnectionGUID: t2bSyMEYROC80n+xVsRe/w==
X-CSE-MsgGUID: kbeTk6rmQQqHa/iZnsMgsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="12092979"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="12092979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 17:41:08 -0700
X-CSE-ConnectionGUID: EyIdXvsbQVeCVwFOr2lbTA==
X-CSE-MsgGUID: YghvtLYNQEGr1d1qUBqQAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40954586"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jun 2024 17:41:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIdx8-0000fI-2x;
	Sun, 16 Jun 2024 00:41:02 +0000
Date: Sun, 16 Jun 2024 08:40:54 +0800
From: kernel test robot <lkp@intel.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: realtek,rt5631: Convert to
 dtschema
Message-ID: <202406160820.L8HvSS8W-lkp@intel.com>
References: <20240614033812.51312-3-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614033812.51312-3-animeshagarwal28@gmail.com>

Hi Animesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Animesh-Agarwal/ASoC-dt-bindings-realtek-rt5514-Convert-to-dtschema/20240614-114128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240614033812.51312-3-animeshagarwal28%40gmail.com
patch subject: [PATCH 2/2] ASoC: dt-bindings: realtek,rt5631: Convert to dtschema
config: arm-randconfig-051-20240614 (https://download.01.org/0day-ci/archive/20240616/202406160820.L8HvSS8W-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406160820.L8HvSS8W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406160820.L8HvSS8W-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: mmc@d4280000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: mmc@d4280800: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: mmc@d4281000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: dma-controller@d42a0800: Unevaluated properties are not allowed ('iram' was unexpected)
   	from schema $id: http://devicetree.org/schemas/dma/marvell,mmp-dma.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: /soc/axi@d4200000/ap-sp@d4290000: failed to match any schema with compatible: ['olpc,ap-sp']
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: /soc/apb@d4000000: failed to match any schema with compatible: ['mrvl,apb-bus', 'simple-bus']
>> arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: audio-codec@1a: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5631.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: /soc/apb@d4000000/i2c@d4034000/accelerometer@1d: failed to match any schema with compatible: ['st,lis331dlh', 'st,lis3lv02d']
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: gpio-keys: 'lid', 'tablet_mode' do not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
   arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dtb: /i2c/camera@21: failed to match any schema with compatible: ['ovti,ov7670']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

