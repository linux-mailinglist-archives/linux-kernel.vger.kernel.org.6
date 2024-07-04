Return-Path: <linux-kernel+bounces-240582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5C926F54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F161F22AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C51A01B9;
	Thu,  4 Jul 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGw8qtSb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D506FC0A;
	Thu,  4 Jul 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073358; cv=none; b=Rsl1ipfCFgFGbhxgGolWzp8VqPcM8pwwxpHdEhOlWmD+WIEIL2k4eQCMfb5saRlXm4dYf9Op1BNOhZaM3NXgU+BhITKYnMj9puPDsuGMNF0VEXa0A0A9ZLv3pJDXExGS4PdipZiSGp1eRT+BCFUk3/XOLcvtLc1iSIweMx3zmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073358; c=relaxed/simple;
	bh=pPrL20troWYfB5rDidUUA+6ppOXIvBHM99wUfpYq0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsxeX1Ih7ZYTOocTxvbF1RByumPAGduBsHEJkayacMxguBpsMUfDfUNfd4TeLqpRrPRr1gikysKtVLxmtGKgdI4jUYU5S7jIGbA1P+WJD/DXISNzkzvYpkgLolm7WYXCnLyVDZjsWRk7XylotJcVn5uy7WKNAZzACKG4gvmLRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGw8qtSb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720073355; x=1751609355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pPrL20troWYfB5rDidUUA+6ppOXIvBHM99wUfpYq0BI=;
  b=WGw8qtSb9komvqrmZcuQG4Sk+u3Rq2NMPdqoPeT31CwqhcnGww71r7as
   3lRRof5idY0LFgRIww9ZS+stZVcVzNjprJtW/lgmFmS7seB10wHYvYMN1
   AoDbsX1cA1eQ5cS19N2cJ8JRa3cs10rjkvHJNRJ9l+TUli1TWUDJD8MsF
   ViDb6edjw/e1Nm57k5IIL5EC8gF5Ib8/bwCARtJty8iD8CL1CiXzanmgo
   spUk6eXl7wa9wsEXx5awL9gV2gJemjEn4iEqSPZjnS+u1WGjGmVCm12xV
   x91f2vH1ubhnE+pK4Ja3/prk9Z/9Uh4+2JXDuKLVRvDBheOOSvt3H23yY
   Q==;
X-CSE-ConnectionGUID: Bk1R6R1sRwCVkrftxXHS5Q==
X-CSE-MsgGUID: 56wfi0X9Qr6a/oNFoTpz7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27933677"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27933677"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 23:09:14 -0700
X-CSE-ConnectionGUID: ujL1ThuaT6u4B5IK+EvfHA==
X-CSE-MsgGUID: ru0SIWscSZqNM0pMdSelDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51356292"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Jul 2024 23:09:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPFeW-000QdQ-0r;
	Thu, 04 Jul 2024 06:09:08 +0000
Date: Thu, 4 Jul 2024 14:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: zelong dong <zelong.dong@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kelvin.zhang@amlogic.com, Zelong Dong <zelong.dong@amlogic.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic A4/A5 Reset Controller
Message-ID: <202407041333.QnHEnGRY-lkp@intel.com>
References: <20240703061610.37217-2-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703061610.37217-2-zelong.dong@amlogic.com>

Hi zelong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240703]
[also build test WARNING on linus/master v6.10-rc6]
[cannot apply to robh/for-next pza/reset/next pza/imx-drm/next v6.10-rc6 v6.10-rc5 v6.10-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zelong-dong/dt-bindings-reset-Add-compatible-and-DT-bindings-for-Amlogic-A4-A5-Reset-Controller/20240703-184517
base:   next-20240703
patch link:    https://lore.kernel.org/r/20240703061610.37217-2-zelong.dong%40amlogic.com
patch subject: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings for Amlogic A4/A5 Reset Controller
config: arm64-randconfig-051-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041333.QnHEnGRY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041333.QnHEnGRY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041333.QnHEnGRY-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:97.34-111.6: Warning (unit_address_vs_reg): /soc/bus@fe000000/pinctrl@4000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:97.34-111.6: Warning (simple_bus_reg): /soc/bus@fe000000/pinctrl@4000: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dtb: reset-controller@2000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['amlogic,c3-reset'] is too short
   	'amlogic,c3-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset', 'amlogic,meson-a1-reset', 'amlogic,meson-s4-reset', 'amlogic,t7-reset']
   	from schema $id: http://devicetree.org/schemas/reset/amlogic,meson-reset.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

