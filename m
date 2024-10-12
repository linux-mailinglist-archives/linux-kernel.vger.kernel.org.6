Return-Path: <linux-kernel+bounces-362202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A599B20B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DF8B222EA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5914601C;
	Sat, 12 Oct 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGhD2UdA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D1143723;
	Sat, 12 Oct 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721204; cv=none; b=jLN+5CQW31YLdalpYC1+L2vGZTzijS/oSrMKTvZ9mCdAn9LEqlICP0cJpG/Nj4OWbjqBhTZPKdI3oFu2hrDxTwo5DeM5Rvmm38nlDYYnX2+6ulXS86EO4wIbpouSvJsP8f10af63N0a0SydYgV6+S5MX0uDXuJlFFT17zkn/9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721204; c=relaxed/simple;
	bh=qiNaSkFLsiZlpmEX7fbpzHz/timLHlWrozlUIAzDUaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlUUdv1GDl1UDJMLOLr0rC9pZY0T7kRJ7y01nij7xHbuZR7dGE1iJPVb8whRZ3sL+XtbjX+/KLmqvX9IA2tWQM9N434emq2pTVG3fQGg6FuRY/L9Ees+s/4MTSzYYSuMHtdclsUfuIqIdJIQOuv2cNX8reBC0vxLdqAyUChFtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGhD2UdA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728721202; x=1760257202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qiNaSkFLsiZlpmEX7fbpzHz/timLHlWrozlUIAzDUaI=;
  b=mGhD2UdAkVIuvXy/RWHm6Ft/hUlH4cI8ZbamGoFXlHvVpG8yv2b1LSYA
   AhBJBEXxo5GHevGvWgdqHC8wvjErHanYyvlaTX5hVvwjawD94RGhjusRs
   Je20m5MEymyr61LWv8T9WxIVN6plu/ZHzu+AS0JbRtNPJJMUN61PRC/tS
   1H51+MPZWkZOHg9ZFCS+gKqLC/+YTkdRwSW877YFRU2piSr+wsKBY4R7v
   NHe1iqCsb9Dbg1bfe1mfF3QX5+MUBXNsPz5hHnxg+vhcTICfnbG8xFouK
   I4GtniJR5eQpuqQ3gUI/LlmbSNJByliXIYrfpy4FNcU3jFA1KkwotKPO6
   A==;
X-CSE-ConnectionGUID: EdBdsoeHTfSqHTwGsVbMpA==
X-CSE-MsgGUID: Hltc1LNCQi6W1dOg/Egvyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53546795"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="53546795"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 01:20:01 -0700
X-CSE-ConnectionGUID: viBG/oxRREOEnhV0oyHeAA==
X-CSE-MsgGUID: 81gwA3J1Sg+6tqid8/OKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77428329"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Oct 2024 01:19:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szXLv-000DCD-0Y;
	Sat, 12 Oct 2024 08:19:55 +0000
Date: Sat, 12 Oct 2024 16:19:41 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH v3 1/3] mailbox: Introduce support for T-head TH1520
 Mailbox driver
Message-ID: <202410121547.KF1WUbP1-lkp@intel.com>
References: <20241008174852.222374-2-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008174852.222374-2-m.wilczynski@samsung.com>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.12-rc2]
[cannot apply to next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/mailbox-Introduce-support-for-T-head-TH1520-Mailbox-driver/20241009-015033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241008174852.222374-2-m.wilczynski%40samsung.com
patch subject: [PATCH v3 1/3] mailbox: Introduce support for T-head TH1520 Mailbox driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241012/202410121547.KF1WUbP1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410121547.KF1WUbP1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410121547.KF1WUbP1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mailbox/mailbox-th1520.c: In function 'th1520_mbox_chan_id_to_mapbit':
>> drivers/mailbox/mailbox-th1520.c:196:34: warning: unused variable 'priv' [-Wunused-variable]
     196 |         struct th1520_mbox_priv *priv = to_th1520_mbox_priv(cp->chan->mbox);
         |                                  ^~~~
   drivers/mailbox/mailbox-th1520.c: In function 'th1520_mbox_xlate':
   drivers/mailbox/mailbox-th1520.c:381:34: warning: unused variable 'priv' [-Wunused-variable]
     381 |         struct th1520_mbox_priv *priv = to_th1520_mbox_priv(mbox);
         |                                  ^~~~
   drivers/mailbox/mailbox-th1520.c: In function 'th1520_mbox_probe':
>> drivers/mailbox/mailbox-th1520.c:441:26: warning: unused variable 'res' [-Wunused-variable]
     441 |         struct resource *res;
         |                          ^~~
>> drivers/mailbox/mailbox-th1520.c:439:29: warning: unused variable 'np' [-Wunused-variable]
     439 |         struct device_node *np = dev->of_node;
         |                             ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/priv +196 drivers/mailbox/mailbox-th1520.c

   193	
   194	static int th1520_mbox_chan_id_to_mapbit(struct th1520_mbox_con_priv *cp)
   195	{
 > 196		struct th1520_mbox_priv *priv = to_th1520_mbox_priv(cp->chan->mbox);
   197		int mapbit = 0;
   198		int i;
   199	
   200		for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
   201			if (i == cp->idx)
   202				return mapbit;
   203	
   204			if (i != TH_1520_MBOX_ICU_KERNEL_CPU0)
   205				mapbit++;
   206		}
   207	
   208		if (i == TH_1520_MBOX_CHANS)
   209			dev_err(cp->chan->mbox->dev, "convert to mapbit failed\n");
   210	
   211		return 0;
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

