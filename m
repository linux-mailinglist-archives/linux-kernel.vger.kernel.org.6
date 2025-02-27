Return-Path: <linux-kernel+bounces-535790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B295EA47733
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E03B279D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5922759D;
	Thu, 27 Feb 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWk2Ui/6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C524B28;
	Thu, 27 Feb 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643252; cv=none; b=UkYFQqnXmeCJg1zYRTeb8/9rd7Qham8MIBB3iT8rXDI1eeSZa5WFnpZhdf0roz3Po4knVS1ktZpRFHEuDGlbomkkAK9rGfwKz6bmYxfVkycOeLrfdpBegocfNJkexkeMXhEpEAdzHXpZqmvxDE/cKFpX/k4cBRLeS1ipcpvJbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643252; c=relaxed/simple;
	bh=GERZIpGTfivi/XxhhXMCRz1fUPVlachQDluzBuUuNF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ5y6Go8T3xsMOx+PdBj0gCYgYQ27EkGC2Cech+/5D/+2AsLgqCNs9qqOFwJ0yvSjkQTQ2nz6ffCiBkLvvdfK/CZign5se+98on+9jIvb/kArSr6dmTJclKnQ02kTiKVMSMihYi8/Me2/Z8KDs3tqphIWcjTu2/gAllJImMLDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWk2Ui/6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740643251; x=1772179251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GERZIpGTfivi/XxhhXMCRz1fUPVlachQDluzBuUuNF0=;
  b=lWk2Ui/6MucM63o7qLj5snNSj0vLXjbtM5sqVQOXPS5m5p+7y5rM3sCg
   oHUop7Vva2WYu05rdNRJk3CWEmsWu49nOg1Q4lMOqBIghFLepK1wbc6rK
   LvtA6kRckVSfXmeyAhbVT/wDehFey3W0PdmEUXu1cRpXu9lgBdUK9hHO5
   7iZZWsKjacp2BU1mSdMKVYyindp1ZohcF2GIzmpq5u8N9EOwhce4fImGq
   cN/OO6OKZmV6aQHKRoO0VcaThXqr5861Oh1jBvdAcO9gocgUimQRrmRj2
   LT1H9wo2JOUNBV9qshhUfumcxfULEyj2nUoCBI7xc3X7kAUfsbpwFxJa8
   g==;
X-CSE-ConnectionGUID: OpkUqZZnRqyOC6+ijO9NSw==
X-CSE-MsgGUID: viT880xyQCCOgPA5RI0QTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45300314"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45300314"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:00:50 -0800
X-CSE-ConnectionGUID: Mi5AFG9QStWCHdsceajeag==
X-CSE-MsgGUID: 0dQJGJDzR1O3bz8fqtjv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="122067414"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 00:00:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnYoX-000D38-20;
	Thu, 27 Feb 2025 08:00:34 +0000
Date: Thu, 27 Feb 2025 15:59:28 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v2 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
Message-ID: <202502271527.emvNC71m-lkp@intel.com>
References: <20250226-irqchip-gpio-a4-a5-v2-2-c55b1050cb55@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-irqchip-gpio-a4-a5-v2-2-c55b1050cb55@amlogic.com>

Hi Xianwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 953913df9c3ab6f496c6facd5aa7fc9f2f847ac2]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-interrupt-controller-Add-support-for-Amlogic-A4-and-A5-SoCs/20250226-135013
base:   953913df9c3ab6f496c6facd5aa7fc9f2f847ac2
patch link:    https://lore.kernel.org/r/20250226-irqchip-gpio-a4-a5-v2-2-c55b1050cb55%40amlogic.com
patch subject: [PATCH v2 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
config: arc-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271527.emvNC71m-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271527.emvNC71m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271527.emvNC71m-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-meson-gpio.c:58:12: warning: 'meson_ao_gpio_irq_set_type' declared 'static' but never defined [-Wunused-function]
      58 | static int meson_ao_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +58 drivers/irqchip/irq-meson-gpio.c

    45	
    46	struct meson_gpio_irq_controller;
    47	static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
    48					    unsigned int channel, unsigned long hwirq);
    49	static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl);
    50	static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
    51					      unsigned int channel,
    52					      unsigned long hwirq);
    53	static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
    54	static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
    55					    unsigned int type, u32 *channel_hwirq);
    56	static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
    57					      unsigned int type, u32 *channel_hwirq);
  > 58	static int meson_ao_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
    59					      unsigned int type, u32 *channel_hwirq);
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

