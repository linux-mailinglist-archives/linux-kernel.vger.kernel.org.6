Return-Path: <linux-kernel+bounces-233767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611991BCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49981C22097
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3A1553AA;
	Fri, 28 Jun 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0aefskv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7F1553A0;
	Fri, 28 Jun 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571798; cv=none; b=p4NdLg8CcpThry8/VIsgNEmlBJ8TWRqOnjyesAgGc2Oksg1isJX+6giTMjSNAEC2MftzKsbPV2c2ase7Vh1Mo60lPfncNbIcOLAa2ER+hJ3XAUnOwcw68+oKhVt3lKuwhd0KBq4LlweWVskiO2nAdHYAy7EduzfFX91xjfPIrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571798; c=relaxed/simple;
	bh=4yLS4SO15+GZgSV9YAquPD11MCf9dm2ee3l4KGzL7uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btRDDEYwpZKtch/MxanGeNgyrIo87sOrM51TxEPmrNXt4i1Li1dyYA19VQ6Fc+rNk3wVgC119ydNxkY1YqYfeMQiVQOIuemWLmsZJycaWGJtQcAxpesi3y3LyAONsHYH3lAZU3HN9ZGI7oGAmD8z04qPHHGxw1+He9Z6oLJ9ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0aefskv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719571797; x=1751107797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yLS4SO15+GZgSV9YAquPD11MCf9dm2ee3l4KGzL7uk=;
  b=N0aefskv9SNxsP9IwAuM/D3VYfms1bupr/1/PbnylIAB8HFCzxOIbErE
   4zW2YZ8/BxRfUH2i4jfD1TKmVUnzNXmOFb1eLEBOAsHmVxQSv8w1BWcOv
   +E7mxtkr1Xauq2ish41oqExWlh1h2PjNOkksMTu3boBkcP4HICVyaEhTZ
   RDLWQCHQIT8CZFTh7fmhzn2cF5DAdlwZ5oIXopjr5ku+moFAk7WnIQcsd
   YtaaMqlIsSQMH5AusZM4ClJenRWSwr2CoKzVsvsAepIZ0J1HYp0e/eoab
   vmUsYJoSZXutbU9Wzl8yBdKcQq6aojp0pG8q2R6+WG+qsaNoAniokur4h
   g==;
X-CSE-ConnectionGUID: pQLa4ZS7Qq6mc1dnNm6Viw==
X-CSE-MsgGUID: FzMvkoNIT86TKchcRU43UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16583413"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16583413"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 03:49:36 -0700
X-CSE-ConnectionGUID: bnRvln6hT6a4BNTMtrWfNA==
X-CSE-MsgGUID: B+Rix3d/R7OrlEn3C8UPfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44759393"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 Jun 2024 03:49:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN9AZ-000H1Z-1p;
	Fri, 28 Jun 2024 10:49:31 +0000
Date: Fri, 28 Jun 2024 18:49:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
Message-ID: <202406281834.nNnojcHy-lkp@intel.com>
References: <20240626230319.1425316-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230319.1425316-3-jonas@kwiboo.se>

Hi Jonas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on robh/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Karlman/dt-bindings-arm-rockchip-Add-Xunlong-Orange-Pi-3B/20240627-175050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240626230319.1425316-3-jonas%40kwiboo.se
patch subject: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281834.nNnojcHy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281834.nNnojcHy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281834.nNnojcHy-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
--
>> arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

