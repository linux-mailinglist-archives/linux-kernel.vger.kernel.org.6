Return-Path: <linux-kernel+bounces-175066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED318C19CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676911F235D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6612DD9E;
	Thu,  9 May 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKQMcdTH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F411292E6;
	Thu,  9 May 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296235; cv=none; b=iQ4Iapg7z4hy3bETZwLAKGvhWK+oIkKcHbT5RIY9NSd9GbKv30ASBp93iQmAbSZRlQFeLyhvIGt8WJbQRA5XnLT04nfLMST5BGcGFdKD0nQXphnVyuanbnyUtG0hPt+Uooh9kib0hlsYHdZEKD3URJgfN3g22TN3NvoG5uvvlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296235; c=relaxed/simple;
	bh=MGh8/Zydz2ujwedtTOqwlPTEuKsnkt8sbW0reAIUVv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxju652e0LMy+EWCQmFpzEoH0xPCtJ8/pbEG1O/AghxCK815JApFYpk25xoFRpFXrUH0srlQN91YvcPLuprdnwDbt9jFy/G1IWHGGjmiuNbgZRmiN3hGq9RTH8XBoeDzFH/TEWqPfcNlAsqUzS87m2WK4mpL8ximQcOQerF268w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKQMcdTH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715296234; x=1746832234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGh8/Zydz2ujwedtTOqwlPTEuKsnkt8sbW0reAIUVv0=;
  b=jKQMcdTH0TtVljeleZYMMH2bFZud/kYr4I9e0VIb2oJyzdgiVJ0Jysof
   EC7GlJ+OeBWEToOgISezVc6Wyr73KElqr0nYFC3RMcU9gKpyFSWcNAgaW
   UzRfPwPzOKbGePT3bEArlnS89oSj9iBGeCUudPiaH/y5nscM0/XfKyyjM
   N3nVrA5oLLage7XHXsoQcpeUzsFxZZU2LW+KSFabHlslIqeuscTGH59W7
   rIiPmPBT1sLi9fd9DllFiSac78jJD03Z5ymmOGT0EWx7yfODSlfo9n4Xz
   jsYriPsDursOEbhL4/vdGZxR4n8uQyneM4CkpWlCauYIFc/EYBOas+hgS
   w==;
X-CSE-ConnectionGUID: Gygu4rpuSd+FPIWQrDzFtQ==
X-CSE-MsgGUID: v7pn/Vg2RnyYpvWD7lDwJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28737686"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="28737686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:10:33 -0700
X-CSE-ConnectionGUID: rhUqsZuZRka0osey9Emkxw==
X-CSE-MsgGUID: pnt6RfLSTl+2NA+rjLRrsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33940273"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 May 2024 16:10:28 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5CuA-0005Tj-0H;
	Thu, 09 May 2024 23:10:26 +0000
Date: Fri, 10 May 2024 07:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
	broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/4] ASoC: fsl_xcvr: Support reparent pll clocks for
 phy_clk
Message-ID: <202405100658.D0KXAx8b-lkp@intel.com>
References: <1715223460-32662-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715223460-32662-4-git-send-email-shengjiu.wang@nxp.com>

Hi Shengjiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.9-rc7 next-20240509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/ASoC-dt-bindings-fsl-xcvr-Add-compatible-string-for-i-MX95/20240509-112112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/1715223460-32662-4-git-send-email-shengjiu.wang%40nxp.com
patch subject: [PATCH 3/4] ASoC: fsl_xcvr: Support reparent pll clocks for phy_clk
config: x86_64-randconfig-103-20240509 (https://download.01.org/0day-ci/archive/20240510/202405100658.D0KXAx8b-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405100658.D0KXAx8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405100658.D0KXAx8b-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp437.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp855.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp860.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp865.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp866.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp950.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-7.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-r.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-ru.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-cyrillic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-greek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-roman.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_misc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/jbd2/jbd2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/af_alg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/algif_hash.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/curve25519-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/prime_numbers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libarc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-pcf857x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-stub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/rt4831-backlight.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_accel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_DAC1064.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_Ti3026.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/macmodes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/via/viafb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/kyro/kyrofb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/acpi_tad.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/platform_profile.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/amd64-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/via-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-sccb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi-avmm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/rt4831.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ccgx-ucsi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/i2c/uda1342.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/au8522_decoder.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/watchdog/simatic-ipc-wdt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/amilo-rfkill.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/ibm_rtl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/firmware_attributes_class.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/core/snd-pcm-dmaengine.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-sigmadsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-wm-adsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/yc/snd-soc-acp6x-mach.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/ps/snd-soc-ps-mach.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/ac97_bus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/video/fbdev.o
>> ERROR: modpost: "fsl_asoc_reparent_pll_clocks" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] undefined!
>> ERROR: modpost: "fsl_asoc_get_pll_clocks" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

