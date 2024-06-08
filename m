Return-Path: <linux-kernel+bounces-207039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75142901199
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E55B2186F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFC178389;
	Sat,  8 Jun 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijSK0Ay2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD06178384;
	Sat,  8 Jun 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851585; cv=none; b=dPTIzUDLj9xuOlJjBtwBJ8aXlutCh7H5DtS/qD4g2/dcnZO+UfPaBQpOH6dcgfLgzOdhwq2thuVKXUmEyBj3XlEtpKJ6Y2ek+VKrA4ULWpoIOfjt0ySyWn2ywKZlObiKWqHltF600K3IYY1OoguFvkqt1CHRxPwLqk9N1YGQ4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851585; c=relaxed/simple;
	bh=qemSKm0bQGXNBIJuxbRrXSISGezk0/wXaPTNyjCTnIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkVVobZBn9MxyoMX1J3cTYeDoCCe/fVWmqoFNdta5LHQ7bk3zsfS+pJsGmCTlhni1a+zwKvQX/Y1QEJ743VdtbxQbwNeShB7InPn9Qmlwyj7ccL9SSuZzQXgJL/qxHR2mtn7ixas1+oVZfVmcDEP2XH11e9aQhG3cOaQk7zCXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijSK0Ay2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717851584; x=1749387584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qemSKm0bQGXNBIJuxbRrXSISGezk0/wXaPTNyjCTnIo=;
  b=ijSK0Ay2ZJq0jhFhbRADM3/xxsXmMuDsLLL2VQvkBzsGRjJZXCCz56on
   MeoXAQbd3qGAOpSz0D16V4Fgj7yuntgh8vsYkrrx+odHHSLR7UcTMFA6I
   T1V5PpIo+br72QgPFbp8TCCyjnZ/GL4FfrRDX59FT2LMFZuAlFeKXmUV6
   VhoMCJgdsDV1h/M4Al71AchGpw/HfSvJ0GbJMSomcN15BXSOU9mbAi7b3
   Qh/m2FJLpiQ9p9kaNViEg/hkBJUTNNPTu1kzih0vBuC68lIbtwq3u4z01
   /484tATM6X1DeLGIHlWOve2LLKpSw4diEKBfq36wq2J9uNlUAlNay4Ewz
   Q==;
X-CSE-ConnectionGUID: nfCLOBuySpad4ryP9Ul6Dg==
X-CSE-MsgGUID: Ae18N+yrQdygm3dfUUt1DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="39969790"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="39969790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 05:59:43 -0700
X-CSE-ConnectionGUID: OzhhLxVxS3O6GFqgx72Yxw==
X-CSE-MsgGUID: PzzqGc5gRbucDTsFrZ+92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="43523218"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2024 05:59:40 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFvfV-0001ba-38;
	Sat, 08 Jun 2024 12:59:38 +0000
Date: Sat, 8 Jun 2024 20:59:30 +0800
From: kernel test robot <lkp@intel.com>
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: oe-kbuild-all@lists.linux.dev, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaishnav.a@ti.com, j-choudhary@ti.com,
	u-kumar1@ti.com
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor
 nodes
Message-ID: <202406082029.cp7GBkgY-lkp@intel.com>
References: <20240607090433.488454-2-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607090433.488454-2-b-padhi@ti.com>

Hi Beleswar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Beleswar-Padhi/arm64-dts-ti-Add-R5F-and-C7x-remote-processor-nodes/20240607-170843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240607090433.488454-2-b-padhi%40ti.com
patch subject: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor nodes
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce: (https://download.01.org/0day-ci/archive/20240608/202406082029.cp7GBkgY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406082029.cp7GBkgY-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg: [[0, 2113929216, 0, 2097152]] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg-names: ['l2sram'] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg: [[0, 2116026368, 0, 2097152]] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg-names: ['l2sram'] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

