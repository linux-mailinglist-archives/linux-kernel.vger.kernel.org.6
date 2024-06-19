Return-Path: <linux-kernel+bounces-220536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FE90E34D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B0281AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7555886;
	Wed, 19 Jun 2024 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGijIjTL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6371E495;
	Wed, 19 Jun 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778057; cv=none; b=ADxSaBwy+fjTrp1ormZbcgfQj468xJjHbszUwXd9xuavk0r2VR0/nhHyA/jU8LClNdUHQeUC+Ic3KX/gq5jBsThbN9WVXJcaftC07G0Zs1YeXrAUPjIPy7JfYWE07wC/NczytK7GIC2435FLI6ahnQF4gVkQt7dyTs1NiuN6PGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778057; c=relaxed/simple;
	bh=XFD15cCIqpCDpe/sTFNoNkjJnF9APKmPNvjg+90uazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ4lmei+4DVwWRzAossaC/M3ByZvs5QB2CI/MetLsxrzENCV4O7aVOZ8/1mCXmp1Rp8mNVVpCK0xjrO8i8JKEcr65J89wDcibvuUAPv26Tj1C6sRqKu2mWOpmHQyAwt2donHrFJx7PBFzXzNHnsWa3c5vdH2WYJjUoFksIN+nVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGijIjTL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718778054; x=1750314054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFD15cCIqpCDpe/sTFNoNkjJnF9APKmPNvjg+90uazc=;
  b=WGijIjTLJ64qAcv4r2c1pza9yQ2kQjzbw5N9rq4dwqy7Fexa+91HgiJJ
   /eDJHsFMLZmHsJywZp6ad8HCsV76r+ETjtv/d4Gu1/sz9w15pbfCAeIzp
   D39DaRwGM2Aqm5G5Nnprjvh8It6TzaCosfV5Z9/P3OoTWXDRtafVrvGRZ
   WvFzn5J2apseTxowC+s93ElzK1bwg+NeRihk7EAXrFwejiGDbYCAHwtte
   z5PkSzDskg77eSHef3uFAFOA0QsXnOL8b+niiWe//mxsiOGAODdkJW21K
   vX+OxcQ7C6aQD88MJTAizRrSu5q4cSWHVVI66/7HOo4JsW/1NekTBuNWU
   A==;
X-CSE-ConnectionGUID: G2kPxB99STSUcuTVmjC4iA==
X-CSE-MsgGUID: WCFCvJK2RD2EeA8hcCDsfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15841495"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15841495"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 23:20:54 -0700
X-CSE-ConnectionGUID: vhrBS1pSRFaDc2hrE5DTxA==
X-CSE-MsgGUID: 4xWa3a2QTESJ40qFT14cAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="46751499"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jun 2024 23:20:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJogZ-0006ML-28;
	Wed, 19 Jun 2024 06:20:47 +0000
Date: Wed, 19 Jun 2024 14:20:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com
Cc: oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
Message-ID: <202406191439.3NcnExKM-lkp@intel.com>
References: <20240618185819.2155595-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618185819.2155595-2-tmaimon77@gmail.com>

Hi Tomer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master pza/reset/next v6.10-rc4 next-20240618]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240619-093532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240618185819.2155595-2-tmaimon77%40gmail.com
patch subject: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
config: arm64-randconfig-051-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191439.3NcnExKM-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:63.7-177.5: Warning (simple_bus_reg): /ahb/apb: simple-bus unit address format error, expected "f0000000"
   arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:50.35-55.5: Warning (unique_unit_address_if_enabled): /ahb/reset-controller@f0801000: duplicate unit-address (also used in node /ahb/clock-controller@f0801000)
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /: memory@0: 'device_type' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: system-controller@f0800000: compatible: ['nuvoton,npcm845-gcr', 'syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-gcr.yaml#
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: interrupt-controller@dfff9000: 'ppi-partitions' does not match any of the regexes: '^v2m@[0-9a-f]+$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic.yaml#
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: ahb: apb:ranges: [[0, 0, 4026531840, 3145728], [4293918720, 0, 4293918720, 90112]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: '#clock-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
>> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: 'clocks' is a required property
   	from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: timer@8000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/timer/nuvoton,npcm7xx-timer.yaml#
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
   arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

