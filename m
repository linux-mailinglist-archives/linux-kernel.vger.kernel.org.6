Return-Path: <linux-kernel+bounces-224582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5EB91243D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E608728A726
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053D175567;
	Fri, 21 Jun 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht2M7X6j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D2176231;
	Fri, 21 Jun 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970007; cv=none; b=Iqy0tzg2e++jLi46zQll/luxN3v8DJy4ArywXBVNFA0A8UbrA3EPYgnMvTeNQCkKcOZY4RCeD+Mev4uXXzK4c0ZVAPkrY86Yt9citdDwyaMBQ7UPIYOEPTONxtduOAyAdvHIsNA8Qi8T6veS0RjlwM52fbrT3Fu4LRY+1RsnShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970007; c=relaxed/simple;
	bh=A7fe/rmNeatZoT47KW1uJmACk0ZsVe99J4Vy/X6Gee0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAdMAzh+SjEn4drGM+D1DsIvXbfpt5VQjJwUC56DICTjgHt8snMsO4KR2hygAKfGZ4jN1KtG+11NzdriovS+B2iWB6KCaTmwqqaPvcnT1Km0mStRNdZZLcE7p5FQr8zEMpK0XTRZaUPzezF7iaELPJGTeZrWX3DQqYvU0YOctxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht2M7X6j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718970004; x=1750506004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7fe/rmNeatZoT47KW1uJmACk0ZsVe99J4Vy/X6Gee0=;
  b=Ht2M7X6jZG3zAwjUEd3mqZtnyhYKP+uTGwhAKvdkcPT1zu/rLaVpP+qx
   OWXCz33MBtBUH7aU+2d7C4RMz12F6WvlJDedvutn7R9uPQII/089ocSHU
   Rin5zhJBIc+Zuy1DxBfoU0OR+wV0puvi5RFo4Vb+Wr+j9ovxonYoR1xPd
   kwM2vi558SAHt2W8ACxlAfvr/PEdtc1ORjtgOe8+TUL+9T93J3Er9NWHk
   B+PhjsTAbUXTGdjGOrymMvZW0DViYl7k5+FUjmu1robZSrQ7RV8GvytMa
   fxFV8XZ0txDhLZfrwG+nwIZBKjLreDdlf4EPxclLt2uMETZme7m23tpdh
   Q==;
X-CSE-ConnectionGUID: mJinsS6JSBSjHvORmZcUXw==
X-CSE-MsgGUID: +ZSf1InNSo61ne5JL4TZ4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33541782"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="33541782"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 04:40:03 -0700
X-CSE-ConnectionGUID: j1UZwtamTsuQ2iTqvQjRdw==
X-CSE-MsgGUID: BlaiZ1oSTN6ItkMUod1vYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="46921413"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jun 2024 04:40:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKccY-0008VW-1u;
	Fri, 21 Jun 2024 11:39:58 +0000
Date: Fri, 21 Jun 2024 19:39:54 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Frank.Li@nxp.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org,
	laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
	stuyoder@gmail.com
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml
 format
Message-ID: <202406211921.SuMJLQwU-lkp@intel.com>
References: <20240617170934.813321-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617170934.813321-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc4 next-20240620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-misc-fsl-qoriq-mc-convert-to-yaml-format/20240618-011116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240617170934.813321-1-Frank.Li%40nxp.com
patch subject: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml format
config: arm64-randconfig-051-20240621 (https://download.01.org/0day-ci/archive/20240621/202406211921.SuMJLQwU-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406211921.SuMJLQwU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406211921.SuMJLQwU-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: wdt@c030000: $nodename:0: 'wdt@c030000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: wdt@c100000: $nodename:0: 'wdt@c100000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: wdt@c110000: $nodename:0: 'wdt@c110000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: wdt@c120000: $nodename:0: 'wdt@c120000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: wdt@c130000: $nodename:0: 'wdt@c130000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
>> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: dpmacs:ethernet@1: 'sfp' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: dpmacs:ethernet@2: 'sfp' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: ethernet@1: 'sfp' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: ethernet@2: 'sfp' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,ls1088a-rcpm', 'fsl,qoriq-rcpm-2.1+']
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c47000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: /soc/mdio@8c4b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: pinmux@70010012c: #size-cells:0:0: 0 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: fsl-mc@80c000000: dpmacs:ethernet@12: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet@12: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c47000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: /soc/mdio@8c4b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: pinmux@70010012c: #size-cells:0:0: 0 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: fsl-mc@80c000000: dpmacs:ethernet@12: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3-rev-a.dtb: ethernet@12: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c47000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/mdio@8c4b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: pinmux@70010012c: #size-cells:0:0: 0 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: fsl-mc@80c000000: dpmacs:ethernet@7: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: fsl-mc@80c000000: dpmacs:ethernet@8: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: fsl-mc@80c000000: dpmacs:ethernet@9: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: fsl-mc@80c000000: dpmacs:ethernet@a: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: ethernet@7: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: ethernet@8: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: ethernet@9: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: ethernet@a: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c47000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: /soc/mdio@8c4b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: pinmux@70010012c: #size-cells:0:0: 0 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@7: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@8: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@9: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@a: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: ethernet@7: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: ethernet@8: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: ethernet@9: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: ethernet@a: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
--
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c37000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c3b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c3f000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c43000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c47000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: /soc/mdio@8c4b000: failed to match any schema with compatible: ['fsl,fman-memac-mdio']
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: pinmux@70010012c: #size-cells:0:0: 0 was expected
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@3: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@4: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@5: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@6: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@b: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@c: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@d: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@e: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@f: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
>> arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@10: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@11: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: fsl-mc@80c000000: dpmacs:ethernet@12: 'phys' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: ethernet@3: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: ethernet@4: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#
   arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: ethernet@5: 'phys', 'sfp' do not match any of the regexes: 'pinctrl-[0-9]+'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

