Return-Path: <linux-kernel+bounces-400402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE49C0CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061351C2350D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BE216A0B;
	Thu,  7 Nov 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRcWTz16"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C619146E;
	Thu,  7 Nov 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000933; cv=none; b=ubNMIIJfNcXdbfIqC1C/sNTwSFsTTr/5TNydc2/kFqhVnwfmJMsp3TLV+QoaVcRvBcgUOov65g6U8Lw7VJMW290bPKWzJjhV202Ii3uqNPvRvHK4oft4jSla1pHgH3DiRdxRAaf6SRwIMp3VO86qny8vJHIwqtRYjlPnsLRE+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000933; c=relaxed/simple;
	bh=Fh7b2FLtKZz1fA4g8oA+3ghKoAEai4NjPZV7Xf1oozk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b96Xt12KrN3pK6p69PwKwxr5X5kfjnFKCuPlacwFbL74bed5lAZtr7BjeE+o5dapd4dnDFt21YNXOPOdWU1svbE+H1LDVFhWjy4e0N97R/X0FBxuqr4Y1awF/BjuZlWy+EYqAQpuGPfbtucosjMOdf0j0qEKnnxeQEWXem6Fjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRcWTz16; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731000932; x=1762536932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fh7b2FLtKZz1fA4g8oA+3ghKoAEai4NjPZV7Xf1oozk=;
  b=aRcWTz16TUHgBzLWg7iZNieF6DjCw66a2RX85jQE0dCPCXEJlXrBH+tv
   a/0w4fNlNKDcftFLXUpLJJDxIzLVSgT4G3gnZvIvUpiiCe5LGJEi9spI8
   oG9SonGjWDL7Yd3poXDH1MImoz41g81PSyqrUzX2Gid1KvRA17ETXzFgh
   jyRjNTrUcwubLtx1QnbWVeazfQXLqhLwAI33z17Acaxz17Y3gApvhab8U
   Yt+Q4Uqtnoso3hsOFOPCfdSO6+yX8vaikvzoxLhukADI2A7aXsMVfh9EG
   9KCHvla1eDL/o3m41ca45xYAPZ3zIal8RHx58n/XeQTHHK7greuw1NDej
   g==;
X-CSE-ConnectionGUID: v25X8baQRfipD62DFZq4ZQ==
X-CSE-MsgGUID: h2QtzfW+S/SaEuT1iiQYGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30281676"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="30281676"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 09:35:31 -0800
X-CSE-ConnectionGUID: sRYe6437RISlO9BLWn+mog==
X-CSE-MsgGUID: Hd+P5H2JSPSX7Ag2FJXLJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="84786005"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Nov 2024 09:35:27 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t96Pk-000qY8-39;
	Thu, 07 Nov 2024 17:35:24 +0000
Date: Fri, 8 Nov 2024 01:35:20 +0800
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
Message-ID: <202411080130.F3kATjgU-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Vabhav-Sharma/dt-bindings-firmware-imx-add-nvmem-phandle/20241107-134504
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241107-secvio-v3-4-ea27f1e9ced4%40nxp.com
patch subject: [PATCH v3 4/4] firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW
config: nios2-randconfig-r131-20241107 (https://download.01.org/0day-ci/archive/20241108/202411080130.F3kATjgU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241108/202411080130.F3kATjgU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080130.F3kATjgU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/imx/imx-scu-secvio.c:59:15: sparse: sparse: symbol 'scdev' was not declared. Should it be static?
>> drivers/firmware/imx/imx-scu-secvio.c:387:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/firmware/imx/imx-scu-secvio.c:387:37: sparse:     expected void [noderef] __user *to
   drivers/firmware/imx/imx-scu-secvio.c:387:37: sparse:     got void *
>> drivers/firmware/imx/imx-scu-secvio.c:399:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/firmware/imx/imx-scu-secvio.c:399:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/imx/imx-scu-secvio.c:399:46: sparse:     got void *

vim +/scdev +59 drivers/firmware/imx/imx-scu-secvio.c

    56	
    57	static struct platform_driver imx_secvio_sc_driver;
  > 58	struct platform_device *pdev;
  > 59	struct device *scdev;
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

