Return-Path: <linux-kernel+bounces-334899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D178997DE18
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B1281E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D417A938;
	Sat, 21 Sep 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwUV9wTw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659A16F265;
	Sat, 21 Sep 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726940346; cv=none; b=SGRNQaMXP7eXoFPBYVdjlpncr0LMaRFwIoJBqGqqcoMVqqpHEzYqOX5IhiSfR09hM/gonfHGqT36QoM8IJXCAhAauyFA4VUb2QvBXNSTg66b4GRkvsl71vWiCfkGidAum9FTCto4umibYRLnkhPW9+dpLKdsqUGQZfPILg1QgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726940346; c=relaxed/simple;
	bh=ilV8DV0/0cA2R2gNxR9zCw8bK2HJq8L4H4tzzud9HTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scEQ5+4gjTPK4bUDWedAXrmpF1GBaW6bqThrtif8DvH+abeyM3s5ODwSIj8xnGz+uTofVGTxmP4Jq2EkYDw+DamhLF8PECSPwMsb2kDAa5pMQG9ClKm1xpiq4S4pTtlA2xz7A7aGUleB20OREH0sMyoUX+io9HMKPpOziSzXMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwUV9wTw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726940343; x=1758476343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ilV8DV0/0cA2R2gNxR9zCw8bK2HJq8L4H4tzzud9HTk=;
  b=iwUV9wTwdtc8YcGeeIqFxmpBj1RFml5vYarVDotwVGHPOmIVu1dap8/f
   Qnw1BgOlmlfVhxSIxqNexsrhvMS29cCtAH/iFHAc47OTs/L6W/pxChrnJ
   sOg6dNqM4zm68wHkBXgBPJCfWaWrPVhmF8X69Y5nUGnOc1EEecxeacPgf
   OSRC8T44PihfnsxzW3X2WwnmdwrTQ33bTgnIPUfzlQOQk2CGTHG3zWOl3
   vBuse5rdh8fQHIvTb7YKuwOB57ZnazeZRqKelJVrfwuQnEY47XMjaCeH3
   LjJZ37fwAlWuFa8MaMhC2hw440Nw6gMmtF9uNzLcYinRd6tG/CdcE4BbX
   A==;
X-CSE-ConnectionGUID: 6wF0f/zVQ82JdgCw+krAXw==
X-CSE-MsgGUID: gcJ+2DRiR4S9aouGEqi7XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26053202"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="26053202"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 10:39:02 -0700
X-CSE-ConnectionGUID: HcJg7Uy9QoiT9dVw1Sxmeg==
X-CSE-MsgGUID: RpNSW0pYQDerDgobzML/PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="70670154"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Sep 2024 10:38:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss44O-000FeN-1P;
	Sat, 21 Sep 2024 17:38:56 +0000
Date: Sun, 22 Sep 2024 01:38:41 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Prusov <ivprusov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@salutedevices.com, prusovigor@gmail.com,
	David Yang <yangxiaohua@everest-semi.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add ES7243E ADC driver
Message-ID: <202409220118.t4hCju9t-lkp@intel.com>
References: <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>

Hi Igor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on baeb9a7d8b60b021d907127509c44507539c15e5]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Prusov/ASoC-dt-bindings-Add-Everest-ES7243E/20240920-235246
base:   baeb9a7d8b60b021d907127509c44507539c15e5
patch link:    https://lore.kernel.org/r/20240920-es7243e-adc-v2-2-0be019735b81%40salutedevices.com
patch subject: [PATCH v2 2/2] ASoC: codecs: add ES7243E ADC driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240922/202409220118.t4hCju9t-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220118.t4hCju9t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220118.t4hCju9t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/es7243e.c:23: warning: expecting prototype for es7243e.c(). Prototype was for ES7243E_RESET() instead


vim +23 sound/soc/codecs/es7243e.c

    22	
  > 23	#define ES7243E_RESET			0x00
    24	#define ES7243E_CLK1			0x01
    25	#define  ES7243E_CLK1_ANA_ON		BIT(1)
    26	#define  ES7243E_CLK1_ADC_ON		BIT(3)
    27	#define ES7243E_CLK2			0x02
    28	#define  ES7243E_CLK2_BCLK_INV		BIT(0)
    29	#define ES7243E_ADC_OSR			0x03
    30	#define ES7243E_MCLK_PRE		0x04
    31	#define ES7243E_CF_DSP_DIV		0x05
    32	#define ES7243E_BCLK_DIV		0x06
    33	#define ES7243E_CLK7			0x07
    34	#define  ES7243E_CLK7_LRCK_DIV_HI	GENMASK(3, 0)
    35	#define ES7243E_LRCK_DIV		0x08
    36	#define ES7243E_S1_SEL			0x09
    37	#define ES7243E_S3_SEL			0x0A
    38	#define ES7243E_SDP			0x0B
    39	#define  ES7243E_SDP_MUTE		GENMASK(7, 6)
    40	#define  ES7243E_SDP_LRP		BIT(5)
    41	#define  ES7243E_SDP_WL			GENMASK(4, 2)
    42	#define  ES7243E_SDP_FMT		GENMASK(1, 0)
    43	#define ES7243E_TDM			0x0B
    44	#define ES7243E_ADCCTL1			0x0D
    45	#define  ES7243E_ADCCTL1_SCALE		GENMASK(2, 0)
    46	#define ES7243E_ADC_VOL			0x0E
    47	#define ES7243E_ADCCTL2			0x0F
    48	#define ES7243E_AUTOMUTE1		0x10
    49	#define ES7243E_AUTOMUTE2		0x11
    50	#define ES7243E_AUTOMUTE3		0x12
    51	#define ES7243E_AUTOMUTE4		0x13
    52	#define ES7243E_ADC_HPF1		0x14
    53	#define ES7243E_ADC_HPF2		0x15
    54	#define ES7243E_PDN			0x16
    55	#define  ES7243E_PDN_ANA		BIT(7)
    56	#define  ES7243E_PDN_BIAS		BIT(6)
    57	#define  ES7243E_PDN_MOD1_RST		BIT(5)
    58	#define  ES7243E_PDN_MOD2_RST		BIT(4)
    59	#define  ES7243E_PDN_MOD1		BIT(3)
    60	#define  ES7243E_PDN_MOD2		BIT(2)
    61	#define  ES7243E_PDN_PGA1		BIT(1)
    62	#define  ES7243E_PDN_PGA2		BIT(0)
    63	#define ES7243E_VMIDSEL			0x17
    64	#define ES7243E_ADC_BIAS_0x18		0x18
    65	#define ES7243E_PGA_BIAS		0x19
    66	#define ES7243E_ADC_BIAS_0x1A		0x1A
    67	#define ES7243E_ADC_MICBIAS		0x1B
    68	#define ES7243E_ADC_VRPBIAS		0x1C
    69	#define ES7243E_ADC_LP			0x1D
    70	#define ES7243E_ADC_PGA_LP		0x1E
    71	#define ES7243E_ADC_VMID		0x1F
    72	#define ES7243E_PGA1			0x20
    73	#define	 ES7243E_PGA1_EN		BIT(4)
    74	#define ES7243E_PGA2			0x21
    75	#define	 ES7243E_PGA2_EN		BIT(4)
    76	#define ES7243E_DLL_PWN			0xF9
    77	#define ES7243E_I2C_CONFIG		0xFC
    78	#define ES7243E_FLAG			0xFA
    79	#define ES7243E_CHIP_ID1		0xFD
    80	#define ES7243E_CHIP_ID2		0xFE
    81	#define ES7243E_CHIP_VER		0xFF
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

