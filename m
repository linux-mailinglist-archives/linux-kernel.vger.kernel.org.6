Return-Path: <linux-kernel+bounces-442446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C77E9EDCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDAC282E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BF22611;
	Thu, 12 Dec 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4hHxJwo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2A4A29;
	Thu, 12 Dec 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965574; cv=none; b=TH6hLP0N3xQiMwNzqMwwuUyiM/oLhutw0dKfjmnQLI3E9NgLR1PnTc3WvyJWGhEGQljRj9cHH86bO8wuzSL106kqAyhzxYBAdJSwXXSAEtfl/Y2YxSez21/THAKh0VF36O6MDK45q7f/6c6CVHzvjopMgcl0avXCcW8GneD5r24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965574; c=relaxed/simple;
	bh=Yl648KHfxYWRCrRS9pqwRnJA4UQcE6R5/Ilt+h7VHJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toadSyx9C6q23hISQSy6U25IYvmEDSM7n+PCcOBlzBNdA+DqQY4JzrAqmXWGjsquEH0JUlfLbeXIulcNmDsgzW4rW1zbpKJyY2MYocCjMlq61yTkMBfRPyZsWUWafbusQsLSi+hU+1SQDpRW2gCIGLHWc7EtPgHHRuPfxLwWxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4hHxJwo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733965573; x=1765501573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yl648KHfxYWRCrRS9pqwRnJA4UQcE6R5/Ilt+h7VHJ0=;
  b=X4hHxJwoST8e/Sv6HUq00cxGgfguNziA0j0ibjSN1XnOFXl9ZT/g3xnX
   4nQKxbliUYGvfs4Gm7n+jcMDP14TXicpahBEJrAEpUXL8uRPmUGZo6+m/
   AGpNJ8QjYjyUoMuZ+yN3xqaELAHL19n4iYFohUFHmAJAzl8NQ816gUSMV
   McIyyr41bnBmasNKgPopJoGuR7FhYeEUO8TNRYgFW1XV8POgofYnLo6XI
   BBbNIY9TNjabDDAwvXCMnAXvtCxAM6keainlxBzr5WNskiGcy8bWjN/Us
   2ML5IaBt3FKNbMC+OnD93e4vtbLKT1rA+DYytYt/2veZ5FzJMH4Shggev
   A==;
X-CSE-ConnectionGUID: IHTq6V5lQWeaYJosxrOAog==
X-CSE-MsgGUID: jaBqR3JNSDW3qKPexFYRsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33697512"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="33697512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 17:06:12 -0800
X-CSE-ConnectionGUID: BneZOs//QjCf+Tq5AcwdVA==
X-CSE-MsgGUID: 7snD8UFhT4Ornm4unWxTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96446682"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Dec 2024 17:06:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLXeY-0007HB-0E;
	Thu, 12 Dec 2024 01:06:06 +0000
Date: Thu, 12 Dec 2024 09:05:54 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 7/7] of: unittest: Add tests for export symbols
Message-ID: <202412120806.IiuXJ0WZ-lkp@intel.com>
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
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[cannot apply to char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/dt-bindings-Add-support-for-export-symbols-node/20241209-232324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241209151830.95723-8-herve.codina%40bootlin.com
patch subject: [PATCH 7/7] of: unittest: Add tests for export symbols
config: arc-randconfig-001-20241210 (https://download.01.org/0day-ci/archive/20241212/202412120806.IiuXJ0WZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120806.IiuXJ0WZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120806.IiuXJ0WZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/of/unittest.c: In function 'of_unittest':
>> drivers/of/unittest.c:4347:9: error: implicit declaration of function 'of_unittest_overlay_export_symbols'; did you mean 'of_unittest_overlay_high_level'? [-Werror=implicit-function-declaration]
    4347 |         of_unittest_overlay_export_symbols();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         of_unittest_overlay_high_level
   cc1: some warnings being treated as errors


vim +4347 drivers/of/unittest.c

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

