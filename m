Return-Path: <linux-kernel+bounces-568631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF01AA69899
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762947AAC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900721420E;
	Wed, 19 Mar 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6cNoFa9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B20AF6C;
	Wed, 19 Mar 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411011; cv=none; b=DKgA5I2VYP4Wi0Niz+GTy6Q7wklu6JBloeKhy5WdguYG1/YTLNOLxHtb/PHy4ys4yPfO047XP/nEQrFa+ss/qmvkSPK4j5//RhCfsNCU9Ja/SjAwC+Ij4wQ1oS5N5Aujw4Ih3k1d4cK2y0TN1Z6SHO5cE3O6J1FVqywXaZ7Dzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411011; c=relaxed/simple;
	bh=kwOrHksy+YhrJJoSEw9ASHTSL1O0f+mcM2mEQsUJ2wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqbs4ZFDWWpkcpdQ55IoOw+y6Unrk3kUVFF6mfsK9c1qur8A7gBJC1ptd+BMaHRxCJ8etQgijU8HG5cJFWYozClKEFqn7N6pDfyaJSRm+SaTy8yyPTP0LKYbMn2XTb8KmujX6uJ1R16P3QzNOquM5ZN4GzpSD5/ihp+6SrPC0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6cNoFa9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742411010; x=1773947010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwOrHksy+YhrJJoSEw9ASHTSL1O0f+mcM2mEQsUJ2wI=;
  b=T6cNoFa9acwzV7gGuNP0T9l580e6B1KGPXCqLUnWVxRuCzUyETEoBLZa
   a43VCIOciCC6AcOcb5dO8HMkzmNWeoXdkHx0CAPmtLJqum5Ly44feh832
   nojbj8o4Koa/wgYCude98e+Fs6qUH7kJHerFgQKqS6TwwZrILgF66rRRP
   ATlFk1EsQNxKe43I4EDr2lbU/KrFjlJcZgKRcCl/txQOVxXI+M8PNuAbO
   SKcaymsFrjNm6/akt03uZ9VkQ6n/bM5XKxRAmVHDce4rUWbYGkLu4LcEW
   6iOrNpsxIqgDkRgWxn59PM/LbM412n3IxllOwlF/+hpu/ToGY7+zXhEdP
   A==;
X-CSE-ConnectionGUID: IH7sMZLeTFGkFxya1loBSA==
X-CSE-MsgGUID: wU/lHgSoTk2ny+rfoj6Hbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54997452"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54997452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 12:03:29 -0700
X-CSE-ConnectionGUID: Mbl85Yu1QW60SEdFPGiOjw==
X-CSE-MsgGUID: RJQQdPK8QPK/WswUp91UjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122769594"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2025 12:03:24 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuyhG-000FcE-0R;
	Wed, 19 Mar 2025 19:03:22 +0000
Date: Thu, 20 Mar 2025 03:02:22 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com,
	jiebing chen <jiebing.chen@amlogic.com>
Subject: Re: [PATCH v4 4/6] ASoC: meson: g12a-toacodec: Add s4 tocodec driver
Message-ID: <202503200205.amGhOXua-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20250320 (https://download.01.org/0day-ci/archive/20250320/202503200205.amGhOXua-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200205.amGhOXua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200205.amGhOXua-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/meson/g12a-toacodec.c:135:38: warning: 's4_toacodec_clk_enable' defined but not used [-Wunused-const-variable=]
     135 | static const struct snd_kcontrol_new s4_toacodec_clk_enable =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~


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

