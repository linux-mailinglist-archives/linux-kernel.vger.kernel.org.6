Return-Path: <linux-kernel+bounces-411936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA509D017F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F66AB22BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96933209;
	Sun, 17 Nov 2024 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQZAVGRi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DD38C;
	Sun, 17 Nov 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731801747; cv=none; b=daKNCdgxDlA7r92UNnk/uc18eOagMtgmyk+9/GX5VPvyWAt/Y/q4b3LMd5aquXzFHrUrlsVNjCUkZ5Zgnc5LuVdu9lueUJihyD9pILiUwvFSc4Vm44oeqw/EiGdvNEaYTV8+/0CsxKv7jzkx016UjDcnf/Zp/YMjVUEYCa8HieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731801747; c=relaxed/simple;
	bh=gxKgLgaDLjJze/Htyj3X1BttLL7u3v4J/jz7At2NUZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYD36t5zCkGsOKHAZR6AOSv+dTBrAj4XyTzoIGlInQoxR8lei4VJSzI3OokrLucTtdyEmfVFwHfTuAJRP3xg1YRDUn7L8nobJiAWXvAlKrFogklhaLMj/EaILjn56rFlvEQ/OOtmLE6G02JeYmJsCRwh1Kwk8kpmCbbdW47aUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQZAVGRi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731801745; x=1763337745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxKgLgaDLjJze/Htyj3X1BttLL7u3v4J/jz7At2NUZ8=;
  b=YQZAVGRiwo/sA4Y1oF/GgLOdu78rJonr4PkSot1wrvYC9qIHMKzKO7Dj
   Qcwm5j3mjnv4PJa9SJwA2SsKw2Xqz4Zjvrno8AlekssGTLO9iup1q+cAN
   G6BBVTV4wEF82vgmG+l4v88BHuMC1g/dpBiJXxAlzscNKY2oWxShpcVCn
   YR4uainE+3+UDD1J2o9Qu2J0ZAZNBT0+CH1lqSiVKb5lP56bJc/Sp2Kzp
   0p3TN5XuFBwtJ2napaqJ6MSpBPWVg5gH5cBwVmeykMyc5neFos8eftYI6
   cQwPsZu+zF9xd31HuWf+TV6cqh3NaOrO2iNkwCIwmQ/6iFzDQ5q5ckiG4
   Q==;
X-CSE-ConnectionGUID: unmLaqRrT8ux8Uvy7PNEsw==
X-CSE-MsgGUID: UOysgSPKTySvl2ajmDeDbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="32027333"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="32027333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 16:02:25 -0800
X-CSE-ConnectionGUID: AJMT17puQ4uybtOhMITHQQ==
X-CSE-MsgGUID: 7wYf6vcVQbCNRNHNE56khQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="89289158"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2024 16:02:22 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCSk7-0001Av-1I;
	Sun, 17 Nov 2024 00:02:19 +0000
Date: Sun, 17 Nov 2024 08:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
	frattaroli.nicolas@gmail.com, linux-rockchip@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, heiko@sntech.de,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH sound-next] ASoC: rockchip: i2s-tdm: Fix a useless call
 issue
Message-ID: <202411170713.FymmFfl3-lkp@intel.com>
References: <20241115114924.23843-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115114924.23843-1-dheeraj.linuxdev@gmail.com>

Hi Dheeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dheeraj-Reddy-Jonnalagadda/ASoC-rockchip-i2s-tdm-Fix-a-useless-call-issue/20241115-195011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20241115114924.23843-1-dheeraj.linuxdev%40gmail.com
patch subject: [PATCH sound-next] ASoC: rockchip: i2s-tdm: Fix a useless call issue
config: loongarch-randconfig-r054-20241117 (https://download.01.org/0day-ci/archive/20241117/202411170713.FymmFfl3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170713.FymmFfl3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170713.FymmFfl3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/rockchip/rockchip_i2s_tdm.c:517:12: warning: 'rockchip_i2s_ch_to_io' defined but not used [-Wunused-function]
     517 | static int rockchip_i2s_ch_to_io(unsigned int ch, bool substream_capture)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/rockchip_i2s_ch_to_io +517 sound/soc/rockchip/rockchip_i2s_tdm.c

081068fd641403 Nicolas Frattaroli 2021-10-01  516  
081068fd641403 Nicolas Frattaroli 2021-10-01 @517  static int rockchip_i2s_ch_to_io(unsigned int ch, bool substream_capture)
081068fd641403 Nicolas Frattaroli 2021-10-01  518  {
081068fd641403 Nicolas Frattaroli 2021-10-01  519  	if (substream_capture) {
081068fd641403 Nicolas Frattaroli 2021-10-01  520  		switch (ch) {
081068fd641403 Nicolas Frattaroli 2021-10-01  521  		case I2S_CHN_4:
081068fd641403 Nicolas Frattaroli 2021-10-01  522  			return I2S_IO_6CH_OUT_4CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  523  		case I2S_CHN_6:
081068fd641403 Nicolas Frattaroli 2021-10-01  524  			return I2S_IO_4CH_OUT_6CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  525  		case I2S_CHN_8:
081068fd641403 Nicolas Frattaroli 2021-10-01  526  			return I2S_IO_2CH_OUT_8CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  527  		default:
081068fd641403 Nicolas Frattaroli 2021-10-01  528  			return I2S_IO_8CH_OUT_2CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  529  		}
081068fd641403 Nicolas Frattaroli 2021-10-01  530  	} else {
081068fd641403 Nicolas Frattaroli 2021-10-01  531  		switch (ch) {
081068fd641403 Nicolas Frattaroli 2021-10-01  532  		case I2S_CHN_4:
081068fd641403 Nicolas Frattaroli 2021-10-01  533  			return I2S_IO_4CH_OUT_6CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  534  		case I2S_CHN_6:
081068fd641403 Nicolas Frattaroli 2021-10-01  535  			return I2S_IO_6CH_OUT_4CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  536  		case I2S_CHN_8:
081068fd641403 Nicolas Frattaroli 2021-10-01  537  			return I2S_IO_8CH_OUT_2CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  538  		default:
081068fd641403 Nicolas Frattaroli 2021-10-01  539  			return I2S_IO_2CH_OUT_8CH_IN;
081068fd641403 Nicolas Frattaroli 2021-10-01  540  		}
081068fd641403 Nicolas Frattaroli 2021-10-01  541  	}
081068fd641403 Nicolas Frattaroli 2021-10-01  542  }
081068fd641403 Nicolas Frattaroli 2021-10-01  543  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

