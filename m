Return-Path: <linux-kernel+bounces-233164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527E91B319
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999FEB220A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CAA38;
	Fri, 28 Jun 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKidaqmw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9917999;
	Fri, 28 Jun 2024 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532973; cv=none; b=PrSlpjUVBfpQbBESTwR/DdZ0amcBUjyyLG9bcAJPWaEoEDCG+P0NvyYzFBMnOM6867dKf7lP4qIa0QPBoaSEMoPamPBxdz3mNEVQCMhInmmNbAqkUsTH0afaDi+P+U/tq7u1dASxAkXtduScdPqSzeZvQ/kOPiF1XxhAOZyERFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532973; c=relaxed/simple;
	bh=mZjzbLJm2O0tHpL/cbdHIH5/7khS3AgCyWr3Lg/WQC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwe3+jyfH7+C7MAsryPcy87MVhC2ydCwICwHcIm1deyT50+11UzVr+GINrPPFsYUdssR7h9OhfoZlcQGfANqB3GmHTCFQrTqpW3WZK1o5lfbc+PH5Fcf0D0DorgkZopEaOM9zkxONX9TKt/AYr9xL2+H96fDC913e06eDJ9wda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKidaqmw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719532971; x=1751068971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZjzbLJm2O0tHpL/cbdHIH5/7khS3AgCyWr3Lg/WQC0=;
  b=NKidaqmw5J/816TkPp/MKVLho1GNwqmrlhVAn7ytXgH7tcFKZubLzDc3
   gokbSq53NhBZ8KkXcUIhLKr6glrxRPAMfyGmrI3i8wOStdFB5eOHV0DKn
   ZOtBGBRj98riP2ZFRG1UsYsigx8rATDh9ajZtqtMB0/iTBTRwNcE10nAl
   uKUI7CYW/rZ3z1IJ6eon6G7wzjcBMWtv1xX856dV+Si14bJvVsPBhsOmw
   t6IltDAOukwjca0GCdzprN+W7ALpDhuz4n1h2+BSCsB1IQBES2TQSMs98
   yKRbvO9GbiD0radctVtBzewzDcO1DG/Tx59sbFCpvPx3uqZ/wptVeXXpQ
   A==;
X-CSE-ConnectionGUID: Yrm78TKdSnCKnBXDTBjlcA==
X-CSE-MsgGUID: BVRwaSLXSiaEPcB4fhyvzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27386486"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27386486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 17:02:51 -0700
X-CSE-ConnectionGUID: vfIoZHpFQe2CmfRuc4So6w==
X-CSE-MsgGUID: +kNRcqUJSMeCacVTgFpz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="48891275"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2024 17:02:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMz4g-000Gdu-1A;
	Fri, 28 Jun 2024 00:02:46 +0000
Date: Fri, 28 Jun 2024 08:01:53 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
Message-ID: <202406280724.E053qdhz-lkp@intel.com>
References: <20240626230319.1425316-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230319.1425316-3-jonas@kwiboo.se>

Hi Jonas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on robh/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Karlman/dt-bindings-arm-rockchip-Add-Xunlong-Orange-Pi-3B/20240627-175050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240626230319.1425316-3-jonas%40kwiboo.se
patch subject: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406280724.E053qdhz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280724.E053qdhz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280724.E053qdhz-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
--
>> arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

