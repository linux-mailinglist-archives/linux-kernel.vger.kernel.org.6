Return-Path: <linux-kernel+bounces-433527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036079E598E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12EF1883E42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA321C180;
	Thu,  5 Dec 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Odw6A6I9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF941DFD8B;
	Thu,  5 Dec 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411801; cv=none; b=Wa+dI7RK6E9gH+1J55XlIjlEtK5kmZMJE2MdPMQrDbyM4mrFRW0Unv4sg930R96+/aZe3OUXy9seS5YzEXKYO5DuolrtytLtsfmCswDvcRKRWZfrxFdRPKb3aYOhAki4dab+iLQrWwSj5CRaMwQgc7TU629MpIYEAFEBUB0mgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411801; c=relaxed/simple;
	bh=HMHcEDj1u4GqWG3hL1RI/WKaNLDp5HE83xY8eaa6M1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3ld6kZoczcxvX2jnRgQFXF81px0BCbNKfxMFLxXMgmsazPSEYNm5wMVdAouZQZBr+LIShOwHv9bauOhfUD4PDYY2Ryl/11bi1FuIUW0/t4JfXZAJYBySUBYWI9nGZMxe8FOIl8mggMWd1PQPKXag/tjxQQtZLV0Lvo/3GAtVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Odw6A6I9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733411800; x=1764947800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HMHcEDj1u4GqWG3hL1RI/WKaNLDp5HE83xY8eaa6M1k=;
  b=Odw6A6I9KyDl4gHdf88pBoFxVwkjaJsunlcFA/PPLYCQira2HTOeHpTH
   wrljz12I7LmsybkNLM06rcjwI498uLmEA7To+8npZlXJXwBtHhTQc8hae
   SLoTl5llLqUpIdsBYnpr7ie2xPkXFZdcsCW3I/vhT8xWz8TtAg5hc+waY
   7Hdo0ViH7mCgTkPhDh36xudfADS3sTVXs/MWCXysCd8xD/mFKsojWdkwB
   axAauEZAFlI2SWBAIdfZdGaSR2CKRuaI9LlHJxTJGzElGlyc9KUcUNfQP
   ly0DNV/JqvISRi4qgtJVbLckRlOppo0JAcS8Kbmw5A89R0B2cJkQBvjpl
   g==;
X-CSE-ConnectionGUID: FIGg4d5QRnyV9EuNIjIMCw==
X-CSE-MsgGUID: gQ1XIVvaQeOWWImi5rlj3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44204033"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="44204033"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 07:16:39 -0800
X-CSE-ConnectionGUID: qM0wgrqgS0m4GFVf3rwMDw==
X-CSE-MsgGUID: n8kyKvbxR1SYEXvK1hJoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94201590"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 07:16:35 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJDah-00006p-2h;
	Thu, 05 Dec 2024 15:16:31 +0000
Date: Thu, 5 Dec 2024 23:15:38 +0800
From: kernel test robot <lkp@intel.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, frank.li@nxp.com,
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com,
	silvano.dininno@nxp.com, V.Sethi@nxp.com,
	meenakshi.aggarwal@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: Re: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS
 secvio and tamper via SCFW
Message-ID: <202412052340.ub9tlWcC-lkp@intel.com>
References: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>

Hi Vabhav,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Vabhav-Sharma/dt-bindings-firmware-imx-add-nvmem-phandle/20241205-125909
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241205-secvio-v4-4-5c37cdc39573%40nxp.com
patch subject: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241205/202412052340.ub9tlWcC-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412052340.ub9tlWcC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412052340.ub9tlWcC-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/firmware/imx/imx-scu-secvio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/imx/imx-scu-secvio.o
ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko] undefined!
>> ERROR: modpost: "imx_secvio_sc_debugfs" [drivers/firmware/imx/imx-scu-secvio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

