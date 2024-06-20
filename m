Return-Path: <linux-kernel+bounces-222067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63390FC63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C43D1C20F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684438F82;
	Thu, 20 Jun 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxgTjgPY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472B38385;
	Thu, 20 Jun 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863062; cv=none; b=suBiWf2wxmuaAHUnQwf+XOEV5NEoK+umSxfsxO1FGDg5pqJr6bmVzcj7oOwdN1E7TCUdBNu7kM7l6gjivPQUHptg2gTM/FIkefvNUeZU4Zmr1270rM/EqQVpfkRDh2b0uRSzuF7+9eDEAdtR+qCPnQUGrjY4mpTTN145ks9DJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863062; c=relaxed/simple;
	bh=zMCFp8zCllWXZJOLn+ox9s+gLl+0FUepfCkgfmEOmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7wkrGC8De4siOWoE+/SsL/VBg69vhncDvzZm2n/u5N9Fveg3I1KNfd7xDO+/GEG94HUr16A9cfXmRx4ZB25LwjwlazQ2mlgNjWKHD2DBEnRPEMr8pTKf0OxE6LUU7DhdsaJH6sc4mMuzs0SYBBgqQ3xOoc8P3sjqkvxYmzkk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxgTjgPY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718863059; x=1750399059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMCFp8zCllWXZJOLn+ox9s+gLl+0FUepfCkgfmEOmGU=;
  b=RxgTjgPYoVV8iCGOnQ/T7++dSQmB0B6ePTQU6x49nnL8hx0WHAri0mSb
   cXVXrxkYjgO3auOaycLjRO/ZUx+7y3EMoT4pAdziFirqss/N3y3TBWUig
   WOLuwQtycbStOUHjnzNsiM2KZocBBjv1CwVdIyxTjPoWEbqDkUKTbbfUn
   DP7F/zyD/MSL7LphhQ94AN9R7mmZUfChcht9pJvWp3nTQXDlDSP7JNrEt
   1g80rOTLN4dw19xSHR/fXXbx/GfREKPSUMXn0YRs2jRy7oHSEbPKmaLdr
   Bz/NN8uEVCdXwB0c5mmmywBQLURfQ0Jpbp7BzulB+dfY8FH9OdbBT7aKY
   w==;
X-CSE-ConnectionGUID: uQKHA3TpQtaEfeztt55WZw==
X-CSE-MsgGUID: BCuam25yTJmkZlK4g6/moQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15585019"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15585019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 22:57:38 -0700
X-CSE-ConnectionGUID: xNu0A6xbT2qdW0R8iq+V0Q==
X-CSE-MsgGUID: Cca+h7QjQquGw6LR94NR2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42792780"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2024 22:57:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKAnb-0007Mk-34;
	Thu, 20 Jun 2024 05:57:31 +0000
Date: Thu, 20 Jun 2024 13:57:02 +0800
From: kernel test robot <lkp@intel.com>
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v25 2/3] reset: npcm: register npcm8xx clock auxiliary
 bus device
Message-ID: <202406201328.SGrN27to-lkp@intel.com>
References: <20240618185819.2155595-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618185819.2155595-3-tmaimon77@gmail.com>

Hi Tomer,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master pza/reset/next v6.10-rc4 next-20240619]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240619-093532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240618185819.2155595-3-tmaimon77%40gmail.com
patch subject: [PATCH v25 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
config: arm64-randconfig-003-20240620 (https://download.01.org/0day-ci/archive/20240620/202406201328.SGrN27to-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201328.SGrN27to-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201328.SGrN27to-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/reset/reset-npcm.o: in function `npcm_rc_probe':
   reset-npcm.c:(.text+0xce8): undefined reference to `auxiliary_device_init'
>> reset-npcm.c:(.text+0xce8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `auxiliary_device_init'
>> aarch64-linux-ld: reset-npcm.c:(.text+0xd30): undefined reference to `__auxiliary_device_add'
>> reset-npcm.c:(.text+0xd30): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__auxiliary_device_add'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

