Return-Path: <linux-kernel+bounces-392694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1C9B9729
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA5F1F222EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8111CDA35;
	Fri,  1 Nov 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6H1zDNJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E813B7A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484779; cv=none; b=Du72x9FviTMaBrr4ITM0n1DpVKUAbXdWzNOvpt1k8JMhrk4SQJSz3rJSZ2wyA/bMHv9n04/DB0lGA7cZB5V7/0fVO8GWYLb5crtIf6mvR8HSWCqoW/cOq6GkwrlhQ+sGfN22SAtdS1rsBw1qm+nvbxQqFwH+ZO2TSFKiZqOSBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484779; c=relaxed/simple;
	bh=JTIvPX1NvVPfItgnj8kH7ERUhn0by7vrtZ82ymU8O0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9jn7UTaEI5i3AepaIpaUEbT75Ab2YvBvwdaxaowYN3FI+Ef0QmRZomvML6JTpuFh0/E00ptFJpER3I66+plfRz9zDSvC1fCDholwkVjjSmiQ81can/fH/yJFemPBnti949oxW3TNBO36946nj/C5mqCoFkgJMh80Rjg1g6OeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6H1zDNJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730484776; x=1762020776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTIvPX1NvVPfItgnj8kH7ERUhn0by7vrtZ82ymU8O0g=;
  b=O6H1zDNJeXU32V+yPf8m88w45Jdjp/0VSCz99PM5pMMEmmru/XpB54Kn
   c1HQcU0758lcwbEXE8N9LaYGccENnwp9Y9zrFyJfA7AtCBrriL59jqNr9
   XeoW61xQAopMltyNo9V8wlW5/gTpEYAluitkPQHptEBcLKxk14CIjEXBK
   MrQmFtYjHXGmmzXLd67RhwMa2mnVfrskTyzuQnPCybsIFBJ6vwalKB0qd
   P7tlIrwl97YO5+I/yCKQnL9dGNIXsJfm+EahlgvQmPP03HtLxl/0b+S6u
   uPEb7O4lQLa0ikxhFl3SZbpxuj6zi1Tj2oaalubnGw+WCy/jwWVGlTSkp
   Q==;
X-CSE-ConnectionGUID: t8ZKutblQxSPchIELDY9gA==
X-CSE-MsgGUID: Rbq/KmjzTF6LiUq+tWIFWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="40839083"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="40839083"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:12:55 -0700
X-CSE-ConnectionGUID: QLidAFfLSBSu9CkIPxAn5A==
X-CSE-MsgGUID: N0LO0lsDRZKVfrRVPCsi4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82560470"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Nov 2024 11:12:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6w8g-000hrd-2L;
	Fri, 01 Nov 2024 18:12:50 +0000
Date: Sat, 2 Nov 2024 02:11:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH 5/5] mtd: rawnand: davinci: Implement setup_interface()
 operation
Message-ID: <202411020140.3wsKJOSB-lkp@intel.com>
References: <20241030104717.88688-6-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030104717.88688-6-bastien.curutchet@bootlin.com>

Hi Bastien,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk-mem-ctrl/for-next]
[also build test ERROR on linus/master v6.12-rc5]
[cannot apply to mtd/nand/next next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet/memory-ti-aemif-Create-aemif_set_cs_timings/20241030-184949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20241030104717.88688-6-bastien.curutchet%40bootlin.com
patch subject: [PATCH 5/5] mtd: rawnand: davinci: Implement setup_interface() operation
config: arc-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020140.3wsKJOSB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020140.3wsKJOSB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020140.3wsKJOSB-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
>> ERROR: modpost: "aemif_set_cs_timings" [drivers/mtd/nand/raw/davinci_nand.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

