Return-Path: <linux-kernel+bounces-215596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9539094C2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2615288056
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560F148306;
	Fri, 14 Jun 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBjTU8jv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821912FB2D;
	Fri, 14 Jun 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407653; cv=none; b=XSD7uOWPtu1CwQJRgy4vwDKLgzEQoN2Wma5vd1fGznCx30U+dLMJH1QZoCKrkrn72JydXCtoCFQ2syiAQ5oMFwkK0ylHuil4bBc8frVokqvGsFhhGPwT/aIuQbpUeculctqiwfKRjtFwwJEq5QfYAkwA/fLhoOfUE/TbGt64Vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407653; c=relaxed/simple;
	bh=A7eXOSdNmaIjl5CGYcbjc04snYieZJPfKAn2snstOjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XujUIl9BW64K2FLDMT6AEDfoT36ztyx3nzjUPdptuCZRp9aXz48DI+WtTbsrZf1i3hs0HTgia9OV7szIJnutTTd1bHqjuLlkwPf2B+S1R6KDEhAk03/5dbO86p3PXQcE65XpV/WSa1Z3YWZG9RTNFAnQedXBmpfYfjSmQWDg3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBjTU8jv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718407651; x=1749943651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7eXOSdNmaIjl5CGYcbjc04snYieZJPfKAn2snstOjQ=;
  b=DBjTU8jv9VtbhXBzyqOqZuCRfkkP943w4cXoMiPfVboIzRYfYqk9Cwy3
   G7uOUT0IFogXfNVpMkoYHsbLivENPqKSHyB7ZFGbUXR7h14j0UgMl778z
   h+3aGcW9zmcnNTMK9tat0vqBN/Rf26UvjdsbfyU1+I31yypScpQo4LnK4
   iVT10RyfQckxPBXlczVnnfHa9j2yPo0RUkIii/ly59BdMz81scVyPeoqu
   ZYQDTxxMaSFQAW4bQMvbCiqkO9mkcYveZVnlZjfp26PuZIkLQ55O44FPB
   2shYKOqmM4X7v+niLoja0t3SsrPJ38moqNn4VA+SJSeinrddF30ZMrxoX
   Q==;
X-CSE-ConnectionGUID: 71FSudZRTQ6XYb3BpXGiPg==
X-CSE-MsgGUID: md2SEWUtQh2rC3nAtVoNLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15439266"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="15439266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 16:27:30 -0700
X-CSE-ConnectionGUID: G3bAMsY4SIazPF/IH5/LwA==
X-CSE-MsgGUID: VWE5NyhMQ/e/YlSc0CnXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="45058145"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Jun 2024 16:27:27 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIGKK-0001tr-34;
	Fri, 14 Jun 2024 23:27:24 +0000
Date: Sat, 15 Jun 2024 07:27:08 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:QORIQ DPAA2 FSL-MC BUS DRIVER" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml
 format
Message-ID: <202406150719.nmv1rQAS-lkp@intel.com>
References: <20240614213109.2518797-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614213109.2518797-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-misc-fsl-qoriq-mc-convert-to-yaml-format/20240615-053243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240614213109.2518797-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml format
reproduce: (https://download.01.org/0day-ci/archive/20240615/202406150719.nmv1rQAS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150719.nmv1rQAS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt*
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

