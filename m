Return-Path: <linux-kernel+bounces-218644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0F90C311
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60A4B21E43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67791BC53;
	Tue, 18 Jun 2024 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejXP4tF/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE433C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688278; cv=none; b=TTM3T84fYnPwRUnhEFmRFIGx3zXrROHXIWHisBFzT7u73DOtFB+36Rf1aq6SH746HbgMjWWyMhU1haYfI2mq2+KVcxjS9mrs9ToTgbFsTxTeX71FDOVZUQvKYnzNVC20TGSbjrX0qHEqH8yLOsDrlN+qS6UBwayrPJK2Etp3DaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688278; c=relaxed/simple;
	bh=jJfPR4QHTWkMGUrAoBmf26Lc/NWHCmoaOl7MqleKAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rSiKuHOxVYmgg0r+GfcJGZUTtN5YuZAPGNsd3kedsjHqv71rHfQoNeG4ia4kgRcfrimeiJqfPNM77NXmsmFsZt6XxZ5OZIDL3bVbiQD1dOygO3WjbegwwR/Ip7e0OEbThkS+wLu8apGxDuv7k4Fke5oyWZJUKrxYJOI7FNJ+slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejXP4tF/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718688277; x=1750224277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJfPR4QHTWkMGUrAoBmf26Lc/NWHCmoaOl7MqleKAcc=;
  b=ejXP4tF/cB3B03HZq5qKZ9tDTsbh08jVug6m1c8M8oXjcrC8I542Xeqt
   I7oOt/IeF7d2/22OZmxkIb/TiP+kkoplgjGkAu8ptr7n7+F9OnfvtauW9
   e2Qa0lDsVBdVjRVEmduCWHzSmcUx6zbQbBDu+RtbTTuSJM2Nke7V0B8N+
   yeYbbA4KH2q54jdfBNE7qnPTsTqI9k3XFeD9q30d+NdMy9OoyWRmUGJ0H
   87I0QcwW/NRike7Jj+WcJrZV5RmU4y8RdNSjjlD86lIE73zoW3NAzHB77
   HZW3JGJ7xBSwSOKDSiaDsdA+WVetZzQRm+Blchsuffo+sMUQCHJ/4N/MB
   Q==;
X-CSE-ConnectionGUID: rTHUBUerR+2Vh0ZrbIxEEQ==
X-CSE-MsgGUID: CR+iV8dlS8yci14HYvLWnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="38064848"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="38064848"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 22:24:37 -0700
X-CSE-ConnectionGUID: WXKXD2NATputQiupD1gRzQ==
X-CSE-MsgGUID: ZSgeD7xYSOibpehWi3PwDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41512985"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2024 22:24:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJRKa-0005Eb-19;
	Tue, 18 Jun 2024 05:24:32 +0000
Date: Tue, 18 Jun 2024 13:23:36 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wcd939x.ko]
 has no CRC!
Message-ID: <202406181338.v4PIq1VH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Neil,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14d7c92f8df9c0964ae6f8b813c1b3ac38120825
commit: 10f514bd172a40b9d03d759678e4711612d671a1 ASoC: codecs: Add WCD939x Codec driver
date:   5 months ago
config: sparc-randconfig-002-20240618 (https://download.01.org/0day-ci/archive/20240618/202406181338.v4PIq1VH-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181338.v4PIq1VH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406181338.v4PIq1VH-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [drivers/media/i2c/tda1997x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/vpx3220.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/common/b2c2/b2c2-flexcop.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/common/saa7146/saa7146.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2tx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/ttpci/budget-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/ttpci/budget.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/pci/ddbridge/ddbridge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7146/hexium_orion.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/cx25821/cx25821.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7134/saa7134.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7134/saa7134-dvb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7164/saa7164.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/solo6x10/solo6x10.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/tw686x/tw686x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/zoran/zr36067.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/m88rs2000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mt312.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/s5h1420.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0299.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv6110.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/zl10353.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/v4l2-core/tuner.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/wdt_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9062_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/alcor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cadence.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/memstick/host/jmb38x_ms.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-is31fl319x.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/siox/siox-bus-gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rapidio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rio-scan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/ad7418.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/ucd9000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ssb/ssb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bcma/bcma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/adl_pci9118.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/amplc_pci230.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/gsc_hpdi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/icp_multi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/jr3_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_pcidas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_pcidio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_pcimio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_daq_700.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_mio_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_labpc_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/nau7802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads7924.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/potentiometer/ad5272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/mprls0025pa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-aspeed.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [sound/core/seq/snd-seq.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ac97/snd-ac97-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/snd-soc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau1701.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau17x1.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-aw8738.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs42l73.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs4265.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-cs4270.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-dmic.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8540.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8824.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sgtl5000.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sta350.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic23.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic3x.ko] has no CRC!
>> WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wcd939x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8510.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8711.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8903.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8961.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8974.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/amd/acp_audio_dma.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-easrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

