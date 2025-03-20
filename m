Return-Path: <linux-kernel+bounces-569319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E29A6A164
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E18A6E08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67C215F49;
	Thu, 20 Mar 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5JDsh8q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FE17A30D;
	Thu, 20 Mar 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459439; cv=none; b=hl+ZkIxVd2z3+ndvaBm6sxwlSeRSTQAXX6RFX4tmIW6R9q8Ev8THZriZ+iSb1YfYg0pCI6rXAFYO3Ylrs/rU0ljX7J/AfSqaaqUiwSUpIqvjQgu3Xc8Ps/Z4QXj+mpf5bh5wZ7n0Gnv3f+FBYEPkLCrap/yMvM/e92/JuvD1hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459439; c=relaxed/simple;
	bh=2i1Q07byf32WTdPpCVWmD1WwQ9vrhVP60iBQr1OWOto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASE5Mkdz+gBP4RdIA53lX7uOpRbuIXwFEX9gkvEsHv5IYJnVNuLY7xPoVLgAjzEEz0fAXPfM7K5e25ObjzoQeylwJiJEhDM+OZDRTWotkgGMl5zcOjyXwfr9e99Wwq/QI4F+RFtY7U1A/SKnCC+N0iQZbnbsMfl/ETapXI3A4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5JDsh8q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742459436; x=1773995436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2i1Q07byf32WTdPpCVWmD1WwQ9vrhVP60iBQr1OWOto=;
  b=j5JDsh8qYpjPqrYZJi2jTBmofgPePwzxYWwolkQ2OuSNVLNOezZxtzV0
   YdGdPUQN7b1ym2ah8f0BvkUELYQxDXPMyEhE/UWCTbuKRcfGqY8t9Tn2E
   VOcyBEZZYRgUAVPSKRKQlmwLsvF32c9SsGsxX3rL9wIYTsZwnqtzvknhx
   E+frREOfcxbLYPa9se/5Hlrv1wHVD0Fu9qaYLff8xtCSdJ8qcYMtjFJaB
   0Bg8C7qWP2Hm+i9Bfvxd9bOIZtsuG43K6nPQEal5oVD1qnyyLDoCzUohg
   5UHwgTRqvWHhkFegPSjH/7KF6Ypojv1GlaveL1hMhV6C4824id2vNWdVI
   w==;
X-CSE-ConnectionGUID: O3csakSSRS2v4VKEZlUeng==
X-CSE-MsgGUID: jKr/sIKaR0+n+q6m7qkVcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31264195"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="31264195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 01:30:35 -0700
X-CSE-ConnectionGUID: y1wTRDJWSvqu5O+/2S+L3Q==
X-CSE-MsgGUID: fro6DZG5Qb+wS2jO1ntJwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="122961957"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2025 01:30:30 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvBIJ-0000Is-2T;
	Thu, 20 Mar 2025 08:30:27 +0000
Date: Thu, 20 Mar 2025 16:29:52 +0800
From: kernel test robot <lkp@intel.com>
To: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com,
	jiebing chen <jiebing.chen@amlogic.com>
Subject: Re: [PATCH v4 4/6] ASoC: meson: g12a-toacodec: Add s4 tocodec driver
Message-ID: <202503201641.wf8Oe0aR-lkp@intel.com>
References: <20250319-audio_drvier-v4-4-686867fad719@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-audio_drvier-v4-4-686867fad719@amlogic.com>

Hi jiebing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab]

url:    https://github.com/intel-lab-lkp/linux/commits/jiebing-chen-via-B4-Relay/dt-bindings-clock-meson-Add-audio-power-domain-for-s4-soc/20250319-151110
base:   6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
patch link:    https://lore.kernel.org/r/20250319-audio_drvier-v4-4-686867fad719%40amlogic.com
patch subject: [PATCH v4 4/6] ASoC: meson: g12a-toacodec: Add s4 tocodec driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250320/202503201641.wf8Oe0aR-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503201641.wf8Oe0aR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503201641.wf8Oe0aR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/meson/g12a-toacodec.c:135:38: warning: unused variable 's4_toacodec_clk_enable' [-Wunused-const-variable]
     135 | static const struct snd_kcontrol_new s4_toacodec_clk_enable =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/s4_toacodec_clk_enable +135 sound/soc/meson/g12a-toacodec.c

   112	
   113	static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
   114				    CTRL0_DAT_SEL_LSB,
   115				    g12a_toacodec_mux_texts);
   116	
   117	static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
   118				    CTRL0_DAT_SEL_SM1_LSB,
   119				    g12a_toacodec_mux_texts);
   120	
   121	static const struct snd_kcontrol_new g12a_toacodec_mux =
   122		SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
   123				  snd_soc_dapm_get_enum_double,
   124				  g12a_toacodec_mux_put_enum);
   125	
   126	static const struct snd_kcontrol_new sm1_toacodec_mux =
   127		SOC_DAPM_ENUM_EXT("Source", sm1_toacodec_mux_enum,
   128				  snd_soc_dapm_get_enum_double,
   129				  g12a_toacodec_mux_put_enum);
   130	
   131	static const struct snd_kcontrol_new g12a_toacodec_out_enable =
   132		SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
   133					    CTRL0_ENABLE_SHIFT, 1, 0);
   134	
 > 135	static const struct snd_kcontrol_new s4_toacodec_clk_enable =
   136		SOC_DAPM_DOUBLE("Switch", TOACODEC_CTRL0,
   137				CTRL0_BCLK_ENABLE_SHIFT, CTRL0_MCLK_ENABLE_SHIFT, 1, 0);
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

