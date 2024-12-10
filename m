Return-Path: <linux-kernel+bounces-439986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110279EB723
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61DB166988
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935582343C8;
	Tue, 10 Dec 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YArZUg0v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399672343AA;
	Tue, 10 Dec 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849533; cv=none; b=gOkPGN5o6U3HQ0Mj5/Z+nxfPHN3G3hFaEF2+tIMei4qN8LQaDWZUqtsUm9jou3gjV9t6WPZt2iDiOq2gqOdmWXo5gQGzehzUU9XNgMHQ1yJ6VsBnWlArFJYi43ZcnITtsGWZdNePx0hwislIPtqEtkxipyzsaB4EOUn6bnrsCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849533; c=relaxed/simple;
	bh=ktVrGTmpt3/F/GW41gzk3PL3sv/yG1zugRTt+gti1gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw3kz5lEgFfTcOet4warQ2UliLkgjTLpS68PPQMfACu9Id66ZuSlNcnZwTmk6/KSTYZeYcEeCbpYbav0YdXkwMnos67k4vgKd9QJb9snKaDFvoLpTXqnMEO3Mtg7UIxEdyaCUMyO9QFLG+vIgkshKo5kaD4nsQmQb10jDKfq7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YArZUg0v; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733849533; x=1765385533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktVrGTmpt3/F/GW41gzk3PL3sv/yG1zugRTt+gti1gU=;
  b=YArZUg0vDZaTJIZ5eK6qPo4VWg2CnSMWE5hBxcz5Z3C9PAoy88CBRQze
   j4yKsWt5Gjy2bLV8LfeTEocCx+NCXnggfgjM41cU5jgu2NlBvbw7Yb+ri
   5KZkvbIIQrYvHjiC7Ovs19vnMF/E5pwSXChAijeVqTA2JbK78DSjT/IW1
   QQTEqRvBHZBUgOwvVv5u4utEGYy6J1Crx1BZhUBS78fGxThzcEGjlXUoV
   QqYSXK+bjHOLT354GQcZSnOjT01yBoQ3IXw4b6lJ5emlKC9dcvd22JKLc
   iLS1eKyqufqhTXt6vAvgqFO/RiTOmR8eSfSknVVjtqynUTwlFrmk8Hipq
   Q==;
X-CSE-ConnectionGUID: La1y43AtR9qXhyLtiLNAjA==
X-CSE-MsgGUID: 1FrBPPYJSZ2AsgWmrt1Zsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37888690"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="37888690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 08:52:12 -0800
X-CSE-ConnectionGUID: 9LmtNp1cSwyu+lAo7cXK1g==
X-CSE-MsgGUID: 7+Zp40k0RIeDtWdqUlzVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95918226"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 08:52:07 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tL3Sv-0005mn-0p;
	Tue, 10 Dec 2024 16:52:05 +0000
Date: Wed, 11 Dec 2024 00:51:17 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 7/7] of: unittest: Add tests for export symbols
Message-ID: <202412110002.61YacCza-lkp@intel.com>
References: <20241209151830.95723-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209151830.95723-8-herve.codina@bootlin.com>

Hi Herve,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241210]
[cannot apply to char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/dt-bindings-Add-support-for-export-symbols-node/20241209-232324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241209151830.95723-8-herve.codina%40bootlin.com
patch subject: [PATCH 7/7] of: unittest: Add tests for export symbols
config: i386-buildonly-randconfig-004-20241210 (https://download.01.org/0day-ci/archive/20241211/202412110002.61YacCza-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412110002.61YacCza-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412110002.61YacCza-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/of/unittest.c:8:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/of/unittest.c:4347:2: error: call to undeclared function 'of_unittest_overlay_export_symbols'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4347 |         of_unittest_overlay_export_symbols();
         |         ^
   1 warning and 1 error generated.


vim +/of_unittest_overlay_export_symbols +4347 drivers/of/unittest.c

  4297	
  4298	static int __init of_unittest(void)
  4299	{
  4300		struct device_node *np;
  4301		int res;
  4302	
  4303		pr_info("start of unittest - you will see error messages\n");
  4304	
  4305		/* Taint the kernel so we know we've run tests. */
  4306		add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
  4307	
  4308		/* adding data for unittest */
  4309		res = unittest_data_add();
  4310		if (res)
  4311			return res;
  4312		if (!of_aliases)
  4313			of_aliases = of_find_node_by_path("/aliases");
  4314	
  4315		np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
  4316		if (!np) {
  4317			pr_info("No testcase data in device tree; not running tests\n");
  4318			return 0;
  4319		}
  4320		of_node_put(np);
  4321	
  4322		of_unittest_check_tree_linkage();
  4323		of_unittest_check_phandles();
  4324		of_unittest_find_node_by_name();
  4325		of_unittest_dynamic();
  4326		of_unittest_parse_phandle_with_args();
  4327		of_unittest_parse_phandle_with_args_map();
  4328		of_unittest_printf();
  4329		of_unittest_property_string();
  4330		of_unittest_property_copy();
  4331		of_unittest_changeset();
  4332		of_unittest_changeset_prop();
  4333		of_unittest_parse_interrupts();
  4334		of_unittest_parse_interrupts_extended();
  4335		of_unittest_dma_get_max_cpu_address();
  4336		of_unittest_parse_dma_ranges();
  4337		of_unittest_pci_dma_ranges();
  4338		of_unittest_bus_ranges();
  4339		of_unittest_bus_3cell_ranges();
  4340		of_unittest_reg();
  4341		of_unittest_translate_addr();
  4342		of_unittest_match_node();
  4343		of_unittest_platform_populate();
  4344		of_unittest_overlay();
  4345		of_unittest_lifecycle();
  4346		of_unittest_pci_node();
> 4347		of_unittest_overlay_export_symbols();

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

