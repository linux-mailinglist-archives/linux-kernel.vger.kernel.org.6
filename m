Return-Path: <linux-kernel+bounces-196359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929BD8D5AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F035B1F23277
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD680029;
	Fri, 31 May 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZM0CWkl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315E80617;
	Fri, 31 May 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137848; cv=none; b=rlfKNqYNq77kk812T2RLawIEo7Wz4wGnghpvIwM3imPgKtkKtNcEILLs9ELAA3OMNt8z+RSRt2sAGLa6jbmrT/5tRxHtoxjO6cWa7OPWBID5NIbxnZ6mYZxz2QTcRS1Ezh4geRbG/HdZ+s5gxAm+XKo7fDE4OkAWTaec+EePVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137848; c=relaxed/simple;
	bh=UG2VPXJmnotgQCGbUJuzOG/RmR6KlipUd0UjDzTFmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuMv690125zS4AybR+SOzRiHp7G07DXSqocF6nTNEg5F3DtAXde6LhhhAG2cWbkizq9T8yT8Vsh0kNwPioOCmta2B2KO6LGQjkcNPnQC+0tFXx0jTPtcMryaMUZ9lEyoHZD/Jg0Hu0RfFTewKo4SiCh4NCaMFIAf2pgrRAUaCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZM0CWkl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717137846; x=1748673846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UG2VPXJmnotgQCGbUJuzOG/RmR6KlipUd0UjDzTFmOc=;
  b=YZM0CWklr+d5AEzyUfDHiw6G70pIq1zPbl84ETih1cZ0sHmpx4cZJg91
   ujsN23p1MTVpdLpBkrIPcV3k1ctrcqgIwSh90xgTaSCFJ2TouRlzulp4R
   4B2gAEc/G40BtGaPpggwjB/yzSAjd0PbVNRaCO88jj3gF/tjz/7HSZq6M
   4itWWMkOzqs+fX5Jdu9CMcxk3SYGPH/s2LQjd0uMTDG1sCL2vcpc8M3h7
   DrQpgcz4NquJolwz9QdigWd5gM4yLX09lLzbLBTJqfWmoo3rKkGuUS7kE
   PuIRHG0mR9cCc03EcnF4lxnpLo9XpQeayJiumEpjXuEk7MPc3jrTf20q1
   Q==;
X-CSE-ConnectionGUID: j/NJpsWBT8KTgexo6gJlWw==
X-CSE-MsgGUID: Lg3v9zVGRxOp0EamNz2UXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17497233"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="17497233"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:44:06 -0700
X-CSE-ConnectionGUID: 3FNSixCJRzeU6SpSydb64Q==
X-CSE-MsgGUID: MIPAgyHVT2ebsdue2tL+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36689755"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 30 May 2024 23:43:58 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCvzO-000Gd3-2Y;
	Fri, 31 May 2024 06:43:49 +0000
Date: Fri, 31 May 2024 14:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH v1 1/6] ASoC: codecs: Remove unused of_gpio.h
Message-ID: <202405311428.tzsBMIPs-lkp@intel.com>
References: <20240530230037.1156253-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530230037.1156253-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on shawnguo/for-next rockchip/for-next linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ASoC-codecs-Remove-unused-of_gpio-h/20240531-070350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240530230037.1156253-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/6] ASoC: codecs: Remove unused of_gpio.h
config: i386-buildonly-randconfig-006-20240531 (https://download.01.org/0day-ci/archive/20240531/202405311428.tzsBMIPs-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405311428.tzsBMIPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405311428.tzsBMIPs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/tas2781-comlib.c:408:6: error: call to undeclared function 'gpio_is_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     408 |         if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
         |             ^
   sound/soc/codecs/tas2781-comlib.c:408:6: note: did you mean 'uuid_is_valid'?
   include/linux/uuid.h:102:19: note: 'uuid_is_valid' declared here
     102 | bool __must_check uuid_is_valid(const char *uuid);
         |                   ^
>> sound/soc/codecs/tas2781-comlib.c:409:3: error: call to undeclared function 'gpio_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     409 |                 gpio_free(tas_priv->irq_info.irq_gpio);
         |                 ^
   sound/soc/codecs/tas2781-comlib.c:409:3: note: did you mean 'pmd_free'?
   include/asm-generic/pgtable-nopmd.h:63:20: note: 'pmd_free' declared here
      63 | static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
         |                    ^
   2 errors generated.
--
>> sound/soc/codecs/tas2781-i2c.c:664:6: error: call to undeclared function 'gpio_is_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     664 |         if (gpio_is_valid(tas_priv->irq_info.irq_gpio)) {
         |             ^
   sound/soc/codecs/tas2781-i2c.c:664:6: note: did you mean 'uuid_is_valid'?
   include/linux/uuid.h:102:19: note: 'uuid_is_valid' declared here
     102 | bool __must_check uuid_is_valid(const char *uuid);
         |                   ^
>> sound/soc/codecs/tas2781-i2c.c:665:8: error: call to undeclared function 'gpio_request'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     665 |                 rc = gpio_request(tas_priv->irq_info.irq_gpio,
         |                      ^
>> sound/soc/codecs/tas2781-i2c.c:668:4: error: call to undeclared function 'gpio_direction_input'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     668 |                         gpio_direction_input(
         |                         ^
   sound/soc/codecs/tas2781-i2c.c:668:4: note: did you mean 'gpiod_direction_input'?
   include/linux/gpio/consumer.h:110:5: note: 'gpiod_direction_input' declared here
     110 | int gpiod_direction_input(struct gpio_desc *desc);
         |     ^
>> sound/soc/codecs/tas2781-i2c.c:672:5: error: call to undeclared function 'gpio_to_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     672 |                                 gpio_to_irq(tas_priv->irq_info.irq_gpio);
         |                                 ^
   sound/soc/codecs/tas2781-i2c.c:672:5: note: did you mean 'gpiod_to_irq'?
   include/linux/gpio/consumer.h:167:5: note: 'gpiod_to_irq' declared here
     167 | int gpiod_to_irq(const struct gpio_desc *desc);
         |     ^
   4 errors generated.


vim +/gpio_is_valid +408 sound/soc/codecs/tas2781-comlib.c

ef3bcde75d06d6 Shenghao Ding 2023-06-18  405  
ef3bcde75d06d6 Shenghao Ding 2023-06-18  406  void tasdevice_remove(struct tasdevice_priv *tas_priv)
ef3bcde75d06d6 Shenghao Ding 2023-06-18  407  {
ef3bcde75d06d6 Shenghao Ding 2023-06-18 @408  	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
ef3bcde75d06d6 Shenghao Ding 2023-06-18 @409  		gpio_free(tas_priv->irq_info.irq_gpio);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  410  	mutex_destroy(&tas_priv->codec_lock);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  411  }
ef3bcde75d06d6 Shenghao Ding 2023-06-18  412  EXPORT_SYMBOL_GPL(tasdevice_remove);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  413  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

