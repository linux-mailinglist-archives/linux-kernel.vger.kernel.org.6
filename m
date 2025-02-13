Return-Path: <linux-kernel+bounces-513606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05270A34C57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A039B3A3A37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1E221571;
	Thu, 13 Feb 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c04prD7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4182227EAA;
	Thu, 13 Feb 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468833; cv=none; b=mno4DB5eZpGobkOkQ3su4ZBGZ8a2Fe43DyhB5VjzNa7CcymYKe+yoloKH5kVuEeFVkSK5SvQ0h0knDQHlVXFj/Z52BvGJv4R6jr+VUg+I6Ctv9UnpN9y1NfOM7kU0m7/zKS1bo/gTaCTxG7aj94hdWR0OEttXDaPZhrmJZiJPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468833; c=relaxed/simple;
	bh=0n2xkIX3tn4U74+lds4CI7iyq/SEXk8zBZ4yxyJEmPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqUx6h1/eP2dx9bIrP3YETfsOHt8f4UdBGDUyedmc3IygKQNUvIKzEWjCt053RGzZSypjzK2jood9tSCrxJH3TAi7LdlpriGaysHF17GRl4+SVqkgzKzdWTQhuEcEf3HVFmeKFoTqianu8VMiu4sSF0ZDXaEqd2L9enJ9w5DdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c04prD7u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739468832; x=1771004832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0n2xkIX3tn4U74+lds4CI7iyq/SEXk8zBZ4yxyJEmPk=;
  b=c04prD7u7BKG1UqUunmRYmuRvIfUWd97nAuqg5FYaB97cHrEbQMJexM4
   +8E4Y/Yh56HeMdSxF25hypu1YgFynD3FaFRRwBp/j2+S0IZwU4ZBnw1/E
   cRauAKRIjjq10ed6ldt4HbvsZillTom5RCl61tTrUXI2xypM5xbZLwbNZ
   d71w544k0/be66T/6w8tKunbe0h21IPKJ3YOJmcUQVglyqfhCuuepeLPw
   FDcVf9nIvxRTIgFuPL03e+gnA/Las5m+FLES8Nv63n8jHx4oDRsWW+Y1P
   QcnDcWIo25PEWV4iSCCs/dHmrypG73u2uzYKxgDpfBAYcNM+C6MJzNNET
   Q==;
X-CSE-ConnectionGUID: y57JhBKEQiWdVxbetaA7xw==
X-CSE-MsgGUID: PYhst29qQbKI1UVPSgVGug==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40340379"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40340379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:47:10 -0800
X-CSE-ConnectionGUID: wVN/mQHaSzmrKUghG+YfwA==
X-CSE-MsgGUID: 08WsRijWQPajU2TskSoknQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113094129"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Feb 2025 09:47:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tidIm-0018WV-3B;
	Thu, 13 Feb 2025 17:47:04 +0000
Date: Fri, 14 Feb 2025 01:46:06 +0800
From: kernel test robot <lkp@intel.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com, Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <202502140107.5TZoA3GU-lkp@intel.com>
References: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>

Hi Aman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aman-Kumar-Pandey/drivers-i3c-Add-driver-for-NXP-P3H2x4x-i3c-hub-device/20250212-213659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250212132227.1348374-2-aman.kumarpandey%40nxp.com
patch subject: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub device
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250214/202502140107.5TZoA3GU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140107.5TZoA3GU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140107.5TZoA3GU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c:7:
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:351:37: warning: 'io_strength_settings' defined but not used [-Wunused-const-variable=]
     351 | static const struct p3h2x4x_setting io_strength_settings[] = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:345:37: warning: 'tp_pullup_settings' defined but not used [-Wunused-const-variable=]
     345 | static const struct p3h2x4x_setting tp_pullup_settings[] = {
         |                                     ^~~~~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:337:37: warning: 'tp_mode_settings' defined but not used [-Wunused-const-variable=]
     337 | static const struct p3h2x4x_setting tp_mode_settings[] = {
         |                                     ^~~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:329:37: warning: 'pullup_settings' defined but not used [-Wunused-const-variable=]
     329 | static const struct p3h2x4x_setting pullup_settings[] = {
         |                                     ^~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:321:37: warning: 'ldo_volt_settings' defined but not used [-Wunused-const-variable=]
     321 | static const struct p3h2x4x_setting ldo_volt_settings[] = {
         |                                     ^~~~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:315:37: warning: 'ldo_en_settings' defined but not used [-Wunused-const-variable=]
     315 | static const struct p3h2x4x_setting ldo_en_settings[] = {
         |                                     ^~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:309:37: warning: 'ibi_en_settings' defined but not used [-Wunused-const-variable=]
     309 | static const struct p3h2x4x_setting ibi_en_settings[] = {
         |                                     ^~~~~~~~~~~~~~~


vim +/io_strength_settings +351 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h

   307	
   308	/* IBI enable/disable settings */
 > 309	static const struct p3h2x4x_setting ibi_en_settings[] = {
   310		{ "disabled",	P3H2x4x_IBI_DISABLED },
   311		{ "enabled",	P3H2x4x_IBI_ENABLED },
   312	};
   313	
   314	/* LDO enable/disable settings */
 > 315	static const struct p3h2x4x_setting ldo_en_settings[] = {
   316		{ "disabled",	P3H2x4x_LDO_DISABLED },
   317		{ "enabled",	P3H2x4x_LDO_ENABLED },
   318	};
   319	
   320	/* LDO voltage settings */
 > 321	static const struct p3h2x4x_setting ldo_volt_settings[] = {
   322		{ "1.0V",	P3H2x4x_LDO_VOLT_1_0V },
   323		{ "1.1V",	P3H2x4x_LDO_VOLT_1_1V },
   324		{ "1.2V",	P3H2x4x_LDO_VOLT_1_2V },
   325		{ "1.8V",	P3H2x4x_LDO_VOLT_1_8V },
   326	};
   327	
   328	/* target port pull-up settings */
 > 329	static const struct p3h2x4x_setting pullup_settings[] = {
   330		{ "250R",		P3H2x4x_TP_PULLUP_250R },
   331		{ "500R",		P3H2x4x_TP_PULLUP_500R },
   332		{ "1000R",		P3H2x4x_TP_PULLUP_1000R },
   333		{ "2000R",		P3H2x4x_TP_PULLUP_2000R },
   334	};
   335	
   336	/* target port mode settings */
 > 337	static const struct p3h2x4x_setting tp_mode_settings[] = {
   338		{ "i3c",		P3H2x4x_TP_MODE_I3C },
   339		{ "smbus",		P3H2x4x_TP_MODE_SMBUS },
   340		{ "gpio",		P3H2x4x_TP_MODE_GPIO },
   341		{ "i2c",		P3H2x4x_TP_MODE_I2C },
   342	};
   343	
   344	/* pull-up enable/disable settings */
 > 345	static const struct p3h2x4x_setting tp_pullup_settings[] = {
   346		{ "disabled",	P3H2x4x_TP_PULLUP_DISABLED },
   347		{ "enabled",	P3H2x4x_TP_PULLUP_ENABLED },
   348	};
   349	
   350	/*  IO strenght settings */
 > 351	static const struct p3h2x4x_setting io_strength_settings[] = {
   352		{ "20Ohms",		P3H2x4x_IO_STRENGTH_20_OHM },
   353		{ "30Ohms",		P3H2x4x_IO_STRENGTH_30_OHM },
   354		{ "40Ohms",		P3H2x4x_IO_STRENGTH_40_OHM },
   355		{ "50Ohms",		P3H2x4x_IO_STRENGTH_50_OHM },
   356	};
   357	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

