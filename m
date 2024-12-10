Return-Path: <linux-kernel+bounces-440156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D969EB989
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EED92837D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBCB198A02;
	Tue, 10 Dec 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIG3BqeE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120335967;
	Tue, 10 Dec 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856326; cv=none; b=embBU4D1cmcsxM/MNMiiFEMSEyrWWjlx+W5ESo/Jdt+TK9SxIB+MTYGTRWGDPdP8/0KchgN5NTFZjX0HQawAHB1WRri8H/Ll31NAwNYFgODclMVPmUX2hQCLDBS0aABP5eQT4x+307aChViXN7syxAyKPuXH9M36ypP0t/Itc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856326; c=relaxed/simple;
	bh=olsdmyoTmIU3QYXVIY/p+lmELkDwTdQFw0IaChjqdS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBPpyql54fHhhFWlDSR1WEVXU87/tYy6zbSrn1qhFjX7JF2ix2qHivmfLrfycKMLN3GvOjORGrqkjpjJvlAPcIwJ6c1DTzLpGKO+76SqyUwrIyHZ/7ZrZ5vgCBcCzCMDBtwA2Cr5bpd4/Pf1Rnu1dJ+wguuWvWx2udozVGl8G4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIG3BqeE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733856325; x=1765392325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=olsdmyoTmIU3QYXVIY/p+lmELkDwTdQFw0IaChjqdS0=;
  b=JIG3BqeEPMOxGizDSBuXd6Dt+N6HED9eTfY9x+KgJ0387yox9r65SWhx
   NqGHT+zlm5cSAhrnA1UbobIwV5UVgGY3z4zwxLyp3br9HTC75p0+y2MXo
   HkrPa5dZLq6rTXGvcud0W0+OaGuj3ph/dESdt0s6mOdbYDXGi+AHJn3qt
   SdBlba2NI8INgrRwTPZKIWlMqDJbMiqfiSb8B4ZG+B3UuURQsFxcbvC7X
   ZdLz5nLJ52KJTMfLo08ZdyGU/cL4X0qze6XNuBDAgOnGFKA//MbopXhjh
   d8NEWqclY5ZURik5iIWbaCyzmVKXioHcHu0Ghofbgqej32M+w5AmWZ3UC
   w==;
X-CSE-ConnectionGUID: hskI4jBGQseqacAluzCs9Q==
X-CSE-MsgGUID: YxC+SbUoTNiFQ5PJMx37TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37998036"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="37998036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 10:45:25 -0800
X-CSE-ConnectionGUID: xwJAx2YfSxGQy3OsTuV+mg==
X-CSE-MsgGUID: UVkc0sTeTx61geoqNG5FMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="100537468"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Dec 2024 10:45:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tL5ES-0005rl-2p;
	Tue, 10 Dec 2024 18:45:16 +0000
Date: Wed, 11 Dec 2024 02:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu, arnd@arndb.de, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
Message-ID: <202412110221.35ohPaia-lkp@intel.com>
References: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-interrupt-controller-Add-Sophgo-SG2042-MSI/20241209-151429
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang%40outlook.com
patch subject: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt controller
config: alpha-randconfig-r063-20241211 (https://download.01.org/0day-ci/archive/20241211/202412110221.35ohPaia-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412110221.35ohPaia-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412110221.35ohPaia-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-sg2042-msi.c:273:34: warning: 'sg2042_msi_of_match' defined but not used [-Wunused-const-variable=]
     273 | static const struct of_device_id sg2042_msi_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/sg2042_msi_of_match +273 drivers/irqchip/irq-sg2042-msi.c

   272	
 > 273	static const struct of_device_id sg2042_msi_of_match[] = {
   274		{ .compatible	= "sophgo,sg2042-msi" },
   275		{}
   276	};
   277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

