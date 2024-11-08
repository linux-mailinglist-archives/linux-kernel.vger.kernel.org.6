Return-Path: <linux-kernel+bounces-400857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F69C1343
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8490C1F23620
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7A4414;
	Fri,  8 Nov 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQqXjnQ/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030F1C36;
	Fri,  8 Nov 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026510; cv=none; b=blpImbhX/AboNXwev5lrhWrGS7WtGWu7h7Ogc1VjAGX9jR+jN1tFf2HekDUixyaHyEYMDXyw5ziYLeO1zpfumUcwjRK8BsRNDqhWOuti659Sv1ygKeWrnZfPUgAzIO1dvKHUjkC6FK3lyCULt3wxQQU5FgLPRSxEw1bnQnkDFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026510; c=relaxed/simple;
	bh=CmUZRygZ4UPlGvskAJ81DD3Jq3d1Dpg5a2sXaVTWYtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLh0hE7DSgE+sKcVByVlyNT86g/2iTZ4JnyWtjkSLnLRdmE49bNtlKwCIo8VtxKimigy4RNHt9YxuO792HACe+UFNNxxiLTIMK4u+43YUNNYomQ8Fdf/TsKhrVE2tSyYKt1rsoytKVbMEv46lg6JpE8efbAqPZsZxy/lG7z8IM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQqXjnQ/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731026509; x=1762562509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmUZRygZ4UPlGvskAJ81DD3Jq3d1Dpg5a2sXaVTWYtw=;
  b=GQqXjnQ/ozPO1Tw/py/fPwYY5edUNhld4zHpKV4LFhSxtCu9Kohr8E76
   KhHUExmL1yJvgbmzvw8d+X9k5yrpKlhau99Wl2dQIy1sk4JeXRA5JJxvs
   2QBPYkbpJFlitcIkqi0P9KsHmZc8yHqKeeG2hsPQfKotAsukc1zBFIRuK
   cSPeXlrakL1KmugJXYDtDkFWlhAlVQkgoEoJOi3+kz6JsbLiAOVoOuwMv
   9+U9RNkdVx6T5nxXxhcsry02lK1m/j9hLtPv+SxaBvE+vuNifrQ0q/JLA
   YDv28q92UAzvG3Yt0+JX/04zDsKM9XYqP2a9WRFMdtBN/Stk7sPoLQWAk
   w==;
X-CSE-ConnectionGUID: lGkX7tuUQhqX/jKZeldH0w==
X-CSE-MsgGUID: CFOV/hD2R+W1LBjnlJaqdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30856144"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30856144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 16:41:48 -0800
X-CSE-ConnectionGUID: VyAfSg8xRomwEzapJ8OcTQ==
X-CSE-MsgGUID: kE2IlYXWRomBOPH8xMoSuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89943431"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2024 16:41:39 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9D4C-000qpW-2d;
	Fri, 08 Nov 2024 00:41:36 +0000
Date: Fri, 8 Nov 2024 08:41:02 +0800
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
Subject: Re: [PATCH v3 4/4] firmware: imx: secvio: Add support for SNVS
 secvio and tamper via SCFW
Message-ID: <202411080826.ovlSnU8b-lkp@intel.com>
References: <20241107-secvio-v3-4-ea27f1e9ced4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-secvio-v3-4-ea27f1e9ced4@nxp.com>

Hi Vabhav,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Vabhav-Sharma/dt-bindings-firmware-imx-add-nvmem-phandle/20241107-134504
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241107-secvio-v3-4-ea27f1e9ced4%40nxp.com
patch subject: [PATCH v3 4/4] firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW
config: csky-randconfig-001-20241108 (https://download.01.org/0day-ci/archive/20241108/202411080826.ovlSnU8b-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080826.ovlSnU8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080826.ovlSnU8b-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/firmware/imx/imx-scu.o: in function `imx_scu_probe':
>> imx-scu.c:(.text+0x3dc): undefined reference to `imx_scu_secvio_init'
>> csky-linux-ld: imx-scu.c:(.text+0x460): undefined reference to `imx_scu_secvio_init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

