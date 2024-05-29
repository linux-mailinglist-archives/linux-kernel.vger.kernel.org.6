Return-Path: <linux-kernel+bounces-194327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E88D3A43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FB81F23496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B41667EA;
	Wed, 29 May 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjVAt+7j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36315B11A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995061; cv=none; b=ljf7UkPaL5sxWH6ti2jeV9TccAnr+a1MJgAG52Nit8tEykmeQpi7/dhOFJZcEQzUkmPcS9va8JjlxE3DpFo6nT2zhMQnKDapBWTdI028k43HSRp56Kfw7jZyA3dRGVzQEXPG3Y8J6mNMrqlYvdCSrAyZi2EjIDeCTtzkq2aj8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995061; c=relaxed/simple;
	bh=CfVjJUt8nMdP3neMlxbZxm/ZXmRp+RbGsRhqRw+N5ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeMcRDwr8rLfgglYFE7B2Rd4czXhulUNOAj+Gny+uMNDiGpvFaE8Te2O46b4KsxxgJcuqF7qb97vuh6plVxbAeT/IGghiaB10xnWeNliFcK1Ffn+Fzt2yvJNQ3EF+F3KuBXJ5+garl1ARIYsvJCSyZj4CgihIoJ/xA6GPbvtwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjVAt+7j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995060; x=1748531060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CfVjJUt8nMdP3neMlxbZxm/ZXmRp+RbGsRhqRw+N5ls=;
  b=hjVAt+7jM2oEL5fOeRy7xtkC0VVVCjsEnsB36LghagJgZFcb0OHm1ABN
   imyMAe/6nomQ8IRqzzH2yj2vefx9ceOl0ShrH6bpkePOG159pqFMhdsTN
   SjOJDCjDg+nAQPwJ2rdtODjfWS1kDfz3Tq69OKtoNFMbVWs6Trqdcupdj
   aAFAwnkwjKRNv+EqWZh11xZoGpeFg15wNefoVDH3c/gMe2ZbjZP7ivtX3
   gi84Jwe16w9fZpjamjUldhEauKqXhtL+OC9Bkg9renoL68sRiJiKvxR5r
   vC3CYu5YvFPmPnAQ02GbSB9cVCwFB30AwPLR2FtwjlmC4UuK3d7KPCW+F
   Q==;
X-CSE-ConnectionGUID: taK0BPLaQg+vehAcIm52Kw==
X-CSE-MsgGUID: C0Fc60HoQLqaal3C25Al4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17193945"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17193945"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:04:19 -0700
X-CSE-ConnectionGUID: oDGauErySKiDz+KokTwUuA==
X-CSE-MsgGUID: s/PMuMnATz+hHI+gDy8iJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="39977204"
Received: from unknown (HELO [10.125.111.89]) ([10.125.111.89])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:04:19 -0700
Message-ID: <937b10b1-f1fd-4af5-9e7b-dad5e43504e3@linux.intel.com>
Date: Wed, 29 May 2024 10:04:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: modpost: "__spi_register_driver"
 [sound/soc/codecs/snd-soc-cs35l56-spi.ko] undefined!
To: kernel test robot <lkp@intel.com>,
 Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Bard Liao
 <yung-chuan.liao@linux.intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
References: <202405291344.wWCOfrZR-lkp@intel.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202405291344.wWCOfrZR-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 00:23, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
> commit: b831b4dca48dbe0f1f7705b44460dd9ca7f2f940 ASoC: intel: sof_sdw: Add support for cs42l43-cs35l56 sidecar amps
> date:   4 weeks ago
> config: loongarch-randconfig-r006-20230403 (https://download.01.org/0day-ci/archive/20240529/202405291344.wWCOfrZR-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405291344.wWCOfrZR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405291344.wWCOfrZR-lkp@intel.com/

..

>>> ERROR: modpost: "__spi_register_driver" [sound/soc/codecs/snd-soc-cs35l56-spi.ko] undefined!
>>> ERROR: modpost: "__devm_regmap_init_spi" [sound/soc/codecs/snd-soc-cs35l56-spi.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for SND_SOC_CS35L56_SPI
>    Depends on [n]: SOUND [=m] && SND [=m] && SND_SOC [=m] && SPI_MASTER [=n] && (SOUNDWIRE [=m] || !SOUNDWIRE [=m])
>    Selected by [m]:
>    - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=m] && SOUND [=m] && SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y] && SND_SOC_SOF_INTEL_SOUNDWIRE [=m] && I2C [=y] && ACPI [=y] && (MFD_INTEL_LPSS [=n] || COMPILE_TEST [=y]) && (SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES [=n] || COMPILE_TEST [=y]) && SOUNDWIRE [=m]
> 

should be fixed by

[1/1] ASoC: Intel: sof-sdw: fix missing SPI_MASTER dependency
      commit: b062938fd9afec844c50571fddd8d81623a60ee1


