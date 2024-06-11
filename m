Return-Path: <linux-kernel+bounces-209840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85335903BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BF282DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E317C201;
	Tue, 11 Jun 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG6Li9wb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D140BE3;
	Tue, 11 Jun 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108185; cv=none; b=F94DLcQNWXisQt2giNv6ktqNTKxaeKiHe3U4P4aT88otOJRINbYpAYZxYFlS5fDW1G3+8ZNJErh1e4I7foEl0LHbjJUnzc/ViQt58izj1cYly8RJbCfYDNF0Rnn7GZ3Dz+6ilKMUrQV3MuE+Wgo5vmXR5rS/FdzvtPaRkOdzCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108185; c=relaxed/simple;
	bh=5b71ZBPr1TDpwCIeu665mxKoJgWHyJPgN+lDoMuCdEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2P96vRJZ01K8nl33I6ZNwg6yjnN8UsbkEqt9L1TVJGzxmr+Nq4+RZ+euoJD4dUCcHBQ8xPK7QpgjMC32bTi3bULXjNYiebw40E5lf2GmBgoAANyoWCCou6RuFuUlMaJcAOEBt0YFopkYzdRtkUb4nFjgH0fx12SVlK2ENQHAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG6Li9wb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718108183; x=1749644183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5b71ZBPr1TDpwCIeu665mxKoJgWHyJPgN+lDoMuCdEQ=;
  b=nG6Li9wbBSk0Bwfkr2n+tNNBq20b9JSseEvsZEa0gE7Z5pQ+4ovaJnnR
   uQL0CsFyrRauhygjJWCcdOqtsG+JJPwYeMqAe6DwA1cuJ3LtR+djlLvcm
   5C1fUzKDcZYg3OgaNwRvffGvTlrKY+HqYfmP23tWww9UnaYrsNbVunWbs
   UNLyb16Ze1oBfsobyWxKFcGQef8OBYg+Nz+O4Kp6foyLeIJHrtqjJUk6f
   PFnrLr/lRqUlAqo40jLO797huAprBDfCXdFxisB4HnrY9DokdMbRru6p6
   NZ31sumE0y1V5MgY0NmUvetepy8Icoj0A6JyxXo6FbHlg8cNr1AzSyRSd
   A==;
X-CSE-ConnectionGUID: S3LuHc1BRw61ZSLeHYp42A==
X-CSE-MsgGUID: Y/5FvykWR4qCuWJwc+P8IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32297230"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="32297230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:16:22 -0700
X-CSE-ConnectionGUID: lbBnx0IQSpu+4NO7yCW7dw==
X-CSE-MsgGUID: XWVxDBsdS9S6W/BCtBEzbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39879681"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Jun 2024 05:16:19 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH0QD-0000Ow-1B;
	Tue, 11 Jun 2024 12:16:17 +0000
Date: Tue, 11 Jun 2024 20:16:11 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Message-ID: <202406112047.aKSKbmw4-lkp@intel.com>
References: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>

Hi Neil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3f38fa61af77b49866b006939479069cd451173]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/ASoC-dt-bindings-convert-tas571x-txt-to-dt-schema/20240607-175726
base:   c3f38fa61af77b49866b006939479069cd451173
patch link:    https://lore.kernel.org/r/20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1%40linaro.org
patch subject: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240611/202406112047.aKSKbmw4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406112047.aKSKbmw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406112047.aKSKbmw4-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:263.22-266.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@3: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:268.22-273.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@4: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:275.24-278.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@5: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:280.22-283.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@6: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:285.22-288.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@7: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:290.29-293.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@8: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:305.11-309.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi:311.11-315.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@1: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts:71.10-75.5: Warning (unit_address_vs_reg): /spdif-out/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts:82.10-86.5: Warning (unit_address_vs_reg): /comp-spdif-out/port@0: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: audio-codec@1d: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: /soc@0/smpctrl@59801000: failed to match any schema with compatible: ['socionext,uniphier-smpctrl']
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld11-global.dtb: comp-spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:396.22-399.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@3: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:401.22-406.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@4: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:408.24-411.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@5: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:413.22-416.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@6: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:418.22-421.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@7: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:423.29-426.6: Warning (unit_address_vs_reg): /soc@0/audio@56000000/port@8: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:438.11-442.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi:444.11-448.6: Warning (unit_address_vs_reg): /soc@0/codec@57900000/port@1: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts:71.10-75.5: Warning (unit_address_vs_reg): /spdif-out/port@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts:82.10-86.5: Warning (unit_address_vs_reg): /comp-spdif-out/port@0: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: audio-codec@1b: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: /soc@0/smpctrl@59801000: failed to match any schema with compatible: ['socionext,uniphier-smpctrl']
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: /soc@0/usb@65a00000: failed to match any schema with compatible: ['socionext,uniphier-dwc3', 'snps,dwc3']
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
   arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb: comp-spdif-out: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

