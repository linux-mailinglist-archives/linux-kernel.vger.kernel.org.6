Return-Path: <linux-kernel+bounces-223342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEE911192
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A582EB2D538
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B41BA87D;
	Thu, 20 Jun 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVFpxnuY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA31BA094;
	Thu, 20 Jun 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909364; cv=none; b=hvZWC2L1Kttc8cnMrzRq0j6Fbjz3SzSy0zHiw96aUmozxEQsJlZq4XB4PGbxgVeLCiUk3BdTYiijbbw6VL+I7zhlbT2O+OcAPOSpUIjIrblY1IdcfCnhtJMh8Cy7/3tZsIEm9i1CfHsuQlvD0f7kLRE2qdscVHbXzy1Wn+RYRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909364; c=relaxed/simple;
	bh=QJZpOt1LOMceNB+eu4dXjCRhvIJzEQIZT+qwmbq+i78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVbYUoMvSyGOfQo8uXtfQgk0phC193PHOwM7ENZuS4jUDIGEQP/tPPmETcN+MyITcAQjOYFKpmPcky3Mg9nMbTodSQNzmf2BcnVAnGa+JlAE4w03Lj7jh0qkCp+LOKgCESTml/zyjXv8P1S830LkKfQGVX68jT7nDaxeyrqsmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVFpxnuY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718909361; x=1750445361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJZpOt1LOMceNB+eu4dXjCRhvIJzEQIZT+qwmbq+i78=;
  b=MVFpxnuYYuLl0+zk4+obi4UJH8690PhA46OgIIUoW/0/B5KoXfLqhITI
   mQfsqHTwBc6075vnN9j3yR9HWdvemPymqCxJr2LElaw31p/T2es1Mssu8
   OR6W+IGAcrwGVwsolRFDoawiSfrhNZYdllyP/EYeQVHwNeG9R/xxfualh
   I9kZwEBK3KgsauxZVX/ji69XMGVgj9HpN5suBcP/krvAcmViG5RQ4aNlb
   FqJFz0vQiOfwJHqIKFfILZTrGyLvBA4VqkS78hnLj++FU8r4yeiMXf0sQ
   dxwNjafywcTypJeUAMm11WEDLUE1pCfKzdFS80k3CHMQLxgOoIZJymC8t
   Q==;
X-CSE-ConnectionGUID: e+z9d97ESPGaEq4L65jwzQ==
X-CSE-MsgGUID: EbEbZcDVQViQVhl2zamkFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15620470"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15620470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 11:49:20 -0700
X-CSE-ConnectionGUID: PKCHph8YRaCCUr9ccXCaPQ==
X-CSE-MsgGUID: fgMPy6ybS9GH7Oj6y/eFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42197407"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Jun 2024 11:49:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKMqQ-0007qP-1Q;
	Thu, 20 Jun 2024 18:49:14 +0000
Date: Fri, 21 Jun 2024 02:48:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pascal Paillet <p.paillet@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, p.paillet@foss.st.com,
	Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 4/4] arm64: stm32: enable scmi regulator for stm32
Message-ID: <202406210259.JQqO3vyI-lkp@intel.com>
References: <20240619083602.33007-5-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619083602.33007-5-p.paillet@foss.st.com>

Hi Pascal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on atorgue-stm32/stm32-next robh/for-next linus/master v6.10-rc4 next-20240620]
[cannot apply to arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pascal-Paillet/dt-bindings-add-STM32MP25-regulator-bindings/20240619-163908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240619083602.33007-5-p.paillet%40foss.st.com
patch subject: [PATCH 4/4] arm64: stm32: enable scmi regulator for stm32
config: arm64-kismet-CONFIG_REGULATOR_ARM_SCMI-CONFIG_ARCH_STM32-0-0 (https://download.01.org/0day-ci/archive/20240621/202406210259.JQqO3vyI-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240621/202406210259.JQqO3vyI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210259.JQqO3vyI-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for REGULATOR_ARM_SCMI when selected by ARCH_STM32
   WARNING: unmet direct dependencies detected for REGULATOR_ARM_SCMI
     Depends on [n]: REGULATOR [=n] && ARM_SCMI_PROTOCOL [=y] && OF [=y]
     Selected by [y]:
     - ARCH_STM32 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

