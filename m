Return-Path: <linux-kernel+bounces-233984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5BD91C067
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D034F2828D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED261BF323;
	Fri, 28 Jun 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMhR/BSG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9F1BF31C;
	Fri, 28 Jun 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583588; cv=none; b=P0+tSyppIYBcKjiXave/RZU+gKYD9jzQLDoxQLWxe70VK2MmbebtmGudgB/uY5ctjk5PvT4+pP7Fg5qLF8esSSG2lhazcN3DMNX8K15/7kHEMK2ncHE8IMyzwm0CMuCStsPqUnvQats8okDyCiJns2n4irkLVuCww/SkCmS+ipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583588; c=relaxed/simple;
	bh=wOnST97FxgzdmpjvSNkj0KjQdFL4Sf4iYe7yyizGLtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5iKn3KnCA0dAtrXSYeGK1bJHVUYEDZpTgZuWco4aATG2sNfpO12NJEMROEXbudmBJPE3wP4aPXowSzLZs3OLk3i6sNDMlJf75ZyHVwfiG+gMMztvG7zf5BxsFdmCoQ+3x+Co7oruRua2M8TXbU51nDFf/HPaDGEleAMcDaH5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMhR/BSG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719583586; x=1751119586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wOnST97FxgzdmpjvSNkj0KjQdFL4Sf4iYe7yyizGLtc=;
  b=hMhR/BSG7pIsxWVKuuvXmAhiBxlTxUeaEm6HPKmW7mR9H23KNb0kMzUG
   hZkVQTWn6zdKPT2/XV/Rnob7MCxOy7oRMCo6aHNsVb4pwBeju5xA3r6IO
   JRJeRxl7QFEnCVleUn8JrGhbS5OChAtmQZ/wEUFJ+nHiq3mXFLGpW1kPw
   UIIQUMq81dmbu2Y8tyocKUfMPJ68LQ63FSdHS5nbFRFisqWbs0ZpQdaqW
   b+vsrAjSDcx+73S1+DucHg7jHf0yqcctIDiMfIVnXBT5n8eHEEZ734gxF
   meD0RIzgYlL381SbPmO+SK9l5aWIoTNr82JOK9RaC5e4X30ZSam4cVZr0
   Q==;
X-CSE-ConnectionGUID: 2xnVoSnTSiqlh/5Eas1TcA==
X-CSE-MsgGUID: ulZ6ZFYDS5ebM/6UncVnVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16898751"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16898751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 07:06:21 -0700
X-CSE-ConnectionGUID: U9vuz4AVTXuk0xm15Y3jZA==
X-CSE-MsgGUID: D+QA0ovYTwGTVNFI8IE75w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44587532"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 07:06:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNCEy-000HBt-21;
	Fri, 28 Jun 2024 14:06:16 +0000
Date: Fri, 28 Jun 2024 22:05:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
Message-ID: <202406282157.SmRgaZOQ-lkp@intel.com>
References: <20240626201502.1384123-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626201502.1384123-3-jonas@kwiboo.se>

Hi Jonas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.10-rc5 next-20240627]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Karlman/dt-bindings-arm-rockchip-Add-Radxa-ROCK-3B/20240627-160354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20240626201502.1384123-3-jonas%40kwiboo.se
patch subject: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406282157.SmRgaZOQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406282157.SmRgaZOQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406282157.SmRgaZOQ-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

