Return-Path: <linux-kernel+bounces-207397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F5901680
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E63AB21039
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67546435;
	Sun,  9 Jun 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3jXnIak"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B742A91;
	Sun,  9 Jun 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947740; cv=none; b=DNJFJovhA0UR5wx43miEDq0CqSCEm/NuvzbTMZaQmkmxs1Cvtkn4JFLfGMbHfBYUclm7wccCU6gk7X06TGsJK5CXMs1hhVotXfroxhbtZS1b5Hqhwd1qdNfRSmc2VRvQV+7lKRZM5RyFN2IhE+8IeuNkWTNUEFrDEUHlpBw0jUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947740; c=relaxed/simple;
	bh=jjZOAJDH3CXwj+75keK9jfIEu+0mkRJEuEOYmcBRoHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTuC50ETLmICE0l+i/vRxt5Tjbx3uXqv8AB48NV4jqeV267FoBFKauD1LevkMRFr9nWIHIrslkgPDr5kSscxL5OHdBWVg52wSyz8PbKuw4qQ3U4wdnBSO86Bn+iXQFHn8cF6MwyzWY47KQAX8a87k7qKyXvroQremfOPWBP5pcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3jXnIak; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717947738; x=1749483738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjZOAJDH3CXwj+75keK9jfIEu+0mkRJEuEOYmcBRoHQ=;
  b=F3jXnIakmWKSTGAWlq/CFng+zDqs96WBEq7Hot4zdYyrMFjEO1TmCeAq
   JXB72Xcf1ETYe1K37Q+3h+E5V3gxnoMu8Kj0FvwwPACtnCFdXp6uDKXOU
   TxJ6xGgjtL/0qvddnJWuQ0qJDv7F7N7tWHLQo5uy1jYhIIl2jHMPbOJZB
   U2gO4GLd99PA/dlSGOO5HETSKaxHv8jcvy9z4anvjqjtU3XwnYlhFv8YG
   RiXgRe6N5LFMpmjpC511aT1HSN9LO1K69zR1jgmXLLhCI0oVBlGa53L/d
   PEzpZkPm1SN6K4wis0eU+GdGOsDggtjz6z+yJhAbY3rbpZAQ+WYdR/UFt
   g==;
X-CSE-ConnectionGUID: HpLoFEvASyqNtxBdr5thPA==
X-CSE-MsgGUID: 3v5+Lr9cRKa8bwYsv5BsKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="32151653"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="32151653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 08:42:17 -0700
X-CSE-ConnectionGUID: schCzkAoRBSIby+nbUxnhQ==
X-CSE-MsgGUID: li9A0onhT+eAevH2f6SmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="43256567"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2024 08:42:14 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGKgO-0001MA-1E;
	Sun, 09 Jun 2024 15:42:12 +0000
Date: Sun, 9 Jun 2024 23:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Bocharov <adeep@lexina.in>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: meson-axg: add support for JetHome
 JetHub D2 (j200)
Message-ID: <202406092342.w4H7PE64-lkp@intel.com>
References: <20240607145148.2246990-3-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145148.2246990-3-adeep@lexina.in>

Hi Viacheslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32f88d65f01bf6f45476d7edbe675e44fb9e1d58]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Bocharov/dt-bindings-arm-amlogic-add-binding-for-JetHome-JetHub-D2/20240607-225905
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240607145148.2246990-3-adeep%40lexina.in
patch subject: [PATCH v1 2/2] arm64: dts: meson-axg: add support for JetHome JetHub D2 (j200)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240609/202406092342.w4H7PE64-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406092342.w4H7PE64-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: /soc/bus@ff600000/bus@60000/clock-controller@0: failed to match any schema with compatible: ['amlogic,sm1-audio-clkc']
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@300: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@340: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@3c0: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
>> arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
   arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
   	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

