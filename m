Return-Path: <linux-kernel+bounces-319930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05B9703E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00771C2190B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093D165F1B;
	Sat,  7 Sep 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CODpXA8v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0E3B1A2;
	Sat,  7 Sep 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737008; cv=none; b=Pkoa7vO5Thu/pVQiA2al/0Ir6KYFc9jbpqm+NH0jChbPKFHBD6wTUVl394AO38mn4NeTjjPBg+n+Pd75PWF8RRDUcaOUVpJa6TZzzImZwnftm4I0ncR82BP/T5P/mnSQLiew2KLpQ5SxzvmOlS6Q8/sZdSyRtxKWHu/HgpCumJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737008; c=relaxed/simple;
	bh=zNLjwJ2Out8iwiXehFnnzK2Uej5uxW5m5QOSXtuoZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMKqPvgSK3Y2fK7V8ZlX19ascjOy16BTdTWF7bIRV9FQ7vJ9DCZhDzz4iaaPZtdGMKNzVS0/OEZ+Fkjq/HIrX2ifuyHoMwzxjTdmJrmClSDzVs9S1xb9m+sGQAiD6FOZKLXZuYrvNgY7hHSrnWDp6XnNUV1oRGXX8rIXEQCULa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CODpXA8v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725737006; x=1757273006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNLjwJ2Out8iwiXehFnnzK2Uej5uxW5m5QOSXtuoZ/E=;
  b=CODpXA8vxUB40+Ov72mjc6bZGa1BonxyqW92/RFJLQ48/E87KfDE6mQY
   bBpuKnXdGj1/dtO3r0F2zNmDEhoYAjwYnLG4q4+UDNh5YH79qs0T9rwpH
   gb8gM+e6NvO8088jsLnkHOmQfFQgq+TgxlFC2S09TKLlXpep8YSsm2cNI
   LNnnWifYVaixKOmCAm22XDHA3RHhHYaEocJq+7zH5zZKrOuTIIXbUN6pH
   DtrJA7FGX5klsMcvO7GzhrqpcU7nnTxqxdFb7JQ2472KK0ptLVWTxMDT+
   5AjrC+HWmoiR6QpQWyULkd99nvqljoQmKSR9DxDe7EeJMynrjsiNMConT
   g==;
X-CSE-ConnectionGUID: Ep1otddwRPCYNbsLLtcaXQ==
X-CSE-MsgGUID: ZRBOkqqcR8GlVRQRYyssAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24267735"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24267735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 12:23:25 -0700
X-CSE-ConnectionGUID: 8z0OKbeuS9K+48qhtfWp+w==
X-CSE-MsgGUID: KCcSKXYtTNivB2u+QPFQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="66244282"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Sep 2024 12:23:22 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn11k-000Ctp-0t;
	Sat, 07 Sep 2024 19:23:20 +0000
Date: Sun, 8 Sep 2024 03:22:59 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, robh@kernel.org,
	saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: Re: [PATCH v2 2/2] of/irq: Use helper to define resources
Message-ID: <202409080202.QLS8E1DK-lkp@intel.com>
References: <20240904160239.121301-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904160239.121301-3-vassilisamir@gmail.com>

Hi Vasileios,

kernel test robot noticed the following build errors:

[auto build test ERROR on ecc768a84f0b8e631986f9ade3118fa37852fef0]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/of-irq-Make-use-of-irq_get_trigger_type/20240905-000607
base:   ecc768a84f0b8e631986f9ade3118fa37852fef0
patch link:    https://lore.kernel.org/r/20240904160239.121301-3-vassilisamir%40gmail.com
patch subject: [PATCH v2 2/2] of/irq: Use helper to define resources
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240908/202409080202.QLS8E1DK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080202.QLS8E1DK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080202.QLS8E1DK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/of/irq.c: In function 'of_irq_to_resource':
>> drivers/of/irq.c:433:17: error: expected ';' before 'r'
     433 |                 r->flags |= irq_get_trigger_type(irq);
         |                 ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [y]:
   - TI_K3_M4_REMOTEPROC [=y] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +433 drivers/of/irq.c

   405	
   406	/**
   407	 * of_irq_to_resource - Decode a node's IRQ and return it as a resource
   408	 * @dev: pointer to device tree node
   409	 * @index: zero-based index of the irq
   410	 * @r: pointer to resource structure to return result into.
   411	 */
   412	int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
   413	{
   414		int irq = of_irq_get(dev, index);
   415	
   416		if (irq < 0)
   417			return irq;
   418	
   419		/* Only dereference the resource if both the
   420		 * resource and the irq are valid. */
   421		if (r && irq) {
   422			const char *name = NULL;
   423	
   424			memset(r, 0, sizeof(*r));
   425			/*
   426			 * Get optional "interrupt-names" property to add a name
   427			 * to the resource.
   428			 */
   429			of_property_read_string_index(dev, "interrupt-names", index,
   430						      &name);
   431	
   432			*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev))
 > 433			r->flags |= irq_get_trigger_type(irq);
   434		}
   435	
   436		return irq;
   437	}
   438	EXPORT_SYMBOL_GPL(of_irq_to_resource);
   439	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

