Return-Path: <linux-kernel+bounces-312179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A47969317
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B51F22D11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AE1CE708;
	Tue,  3 Sep 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJSC58g+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914701CB535;
	Tue,  3 Sep 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340126; cv=none; b=XLSO5PPUssBXVtsdc/aIWchOsDG66NwRooitXQm8nkodv3fQRqM+pqL8ZZkf4rM/GokICNPuq0MUhcqw1UJh1ebeTBNS0ANapeZKqmV9TjhQu31udwXoAyta2Hoj7QOGlmza74bDKokjEuRuxI68RbymiI4BWlsmWS0Ba+9z1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340126; c=relaxed/simple;
	bh=Vsrxa+Wgp74CsoCKJKvMqvaXDmm78q0OfzNYeXpH4TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJEcG/aYw3SrYpQ3AajO7y1/J2DJnZ02/Sg2IPy9xK0q5W450GkO45jq74xxCVVmKByRBMEORhugFybSEVjgas3/PQ43o9imNBQNHNIkbsXKX8W6NblZxX3qQ8cq3kUryEDscvZCOvCduQV5jiY/6G09fnolClMejuW1cZeEP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJSC58g+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725340125; x=1756876125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vsrxa+Wgp74CsoCKJKvMqvaXDmm78q0OfzNYeXpH4TM=;
  b=DJSC58g+6ke0uvTUV8tixFYOPNjLaBausljnAuUrGJfDqiMdguTyYZ8f
   N3gWlCqlBf5yY+4PxrDiGahRVwHIwtIaAI/6GXqEKK83Tu12pXMDXuOQ0
   IFKjYKJPPVEKQip13PCzIDepFU1IVTBjuE8o6XKxwVv3M3hYslJiDM2i2
   BpBZ294lzWaoHQsPZy4Q4ko4NMI9jC47csEYlH2xo1rvEr2XtpJHtvvOA
   WiksqqCHRgPUb1O2YA9NgeEA1fGmx09Wxn05hXYdgKbhcafP+16CT6AzW
   ckYPNPWjZFiuc7joaqYvpE1+7Iy6KKF6nhq8VwyIjIliVpC5xAO3MytpU
   A==;
X-CSE-ConnectionGUID: HuqhXRdNTymaeOSsFtrp0w==
X-CSE-MsgGUID: 2BahVE6tRaq+Cev/ZT21Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23724405"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="23724405"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 22:08:45 -0700
X-CSE-ConnectionGUID: /NSWoUbyQ9ayraynBz0/sw==
X-CSE-MsgGUID: JVGmcwkFQQ6c4EuCKZbSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="65140104"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Sep 2024 22:08:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slLmQ-0006EW-2k;
	Tue, 03 Sep 2024 05:08:38 +0000
Date: Tue, 3 Sep 2024 13:08:25 +0800
From: kernel test robot <lkp@intel.com>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	knoxchiou@google.com, hsinyi@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: mediatek: Add MT8186 Ponyta
 Chromebooks
Message-ID: <202409031236.7k1tHBdG-lkp@intel.com>
References: <20240902125502.1844374-3-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902125502.1844374-3-cengjianeng@huaqin.corp-partner.google.com>

Hi Jianeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc6 next-20240902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianeng-Ceng/dt-bindings-arm-mediatek-Add-MT8186-Ponyta-Chromebook/20240902-210651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240902125502.1844374-3-cengjianeng%40huaqin.corp-partner.google.com
patch subject: [PATCH v1 2/2] arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
config: arm64-randconfig-001-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031236.7k1tHBdG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031236.7k1tHBdG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409031236.7k1tHBdG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-rev2-sku0.dtb', needed by 'arch/arm64/boot/dts/mediatek/'.
>> make[4]: *** No rule to make target 'arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-rev2-sku1.dtb', needed by 'arch/arm64/boot/dts/mediatek/'.
   make[4]: Target 'arch/arm64/boot/dts/mediatek/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

