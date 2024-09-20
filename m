Return-Path: <linux-kernel+bounces-334526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6B97D857
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6114C1F218E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1417E013;
	Fri, 20 Sep 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjL+uv8c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6717E003;
	Fri, 20 Sep 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849748; cv=none; b=cc6exVFMOnqp7A5eKDeqXQ6zAtL/ywpn+68ETQze8CGN++yP4dhXd3I52+kzT0HSnuyJ+WQeHkJHxvpZON1RuL+7B4NNSpVHN2pFmWnti41EY++B2l/kwnC464R/Njpe1pWlD2l/0+4D3Dc5xrw7mZFvstqZAjcRbOaRzZ82IHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849748; c=relaxed/simple;
	bh=pFPYaI/XdQ1Bj4BHzWEfHaVrsBjq8q50diIMZ+usCgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/nd7io5GWmqXBxHMiv3/JOgpvcWJpuJORN08eOqT4XnEsRfS2N37Sn8EIrIx9grvv2H4m1hdfXd4RU223hH+n5CodvkL+xpHJ029+LJeVLL18+lOY+0apT5kttrTszLpqaXcU47mlchO0uypfDd7oQtw55fWr/hJrcraMwOMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjL+uv8c; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726849745; x=1758385745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pFPYaI/XdQ1Bj4BHzWEfHaVrsBjq8q50diIMZ+usCgI=;
  b=GjL+uv8cVLyeYr439/YnUYmPzAZ0EGS8krBvan/IuVLF441PEKGq2gvW
   jA6i8C9gk+6Wo9HcFL7cP0srY6CaVQgp46cJp1pqxvhHKhld78qjRVHHU
   91PfKwapb9naZvQykKeBpMjPuNRSJPZtfix1nPP8EicJnOu1uOqeYS1Up
   1h8jRzORkm1KGgfzLjY2rE6fVcasK7nbzTYIaqLrY/q10xmyXS7x5I9Z2
   vPp9ex+JQklZ6DjA2AEz5cfbdgmazfOnqNrVf0R6ibDFUZBignpga1uwF
   HAbpA8ly45a9ALG/Y77QE0lVv0OaqYvHXcQCHdvoNLCcYnx8ZuQHol8cO
   A==;
X-CSE-ConnectionGUID: RqzdWA7mRZq3fDnECgz1Bg==
X-CSE-MsgGUID: X97ujOp/QyeWmlmhzjJgfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25960069"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25960069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 09:29:05 -0700
X-CSE-ConnectionGUID: 1gKe9TqIRha65q7OrF9/kw==
X-CSE-MsgGUID: qBJjM+pdRyGxjUyYldg0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70358100"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Sep 2024 09:29:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srgV9-000Eex-1t;
	Fri, 20 Sep 2024 16:28:59 +0000
Date: Sat, 21 Sep 2024 00:28:58 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
Message-ID: <202409210200.Nl6uKIgj-lkp@intel.com>
References: <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7083504315d64199a329de322fce989e1e10f4f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/dt-bindings-regulator-add-max20339-binding/20240917-005024
base:   7083504315d64199a329de322fce989e1e10f4f7
patch link:    https://lore.kernel.org/r/20240916-max20339-v1-2-b04ce8e8c471%40linaro.org
patch subject: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240921/202409210200.Nl6uKIgj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210200.Nl6uKIgj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210200.Nl6uKIgj-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/regulator/max20339-regulator.o: in function `max20339_lsw_set_ovp':
>> max20339-regulator.c:(.text+0x406): undefined reference to `__ffsdi2'
   ld: drivers/regulator/max20339-regulator.o: in function `max20339_lsw_set_ocp':
   max20339-regulator.c:(.text+0x1041): undefined reference to `__ffsdi2'
   ld: drivers/regulator/max20339-regulator.o: in function `max20339_lsw_set_ocp.cold':
>> max20339-regulator.c:(.text.unlikely+0x5e): undefined reference to `__ffsdi2'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [y]:
   - TI_K3_M4_REMOTEPROC [=y] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

