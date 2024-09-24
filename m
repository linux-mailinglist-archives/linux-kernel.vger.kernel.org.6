Return-Path: <linux-kernel+bounces-337479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D834984A97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32E81F2499C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12701ABECB;
	Tue, 24 Sep 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPFdftYj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803F31A60
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200975; cv=none; b=XjvF52euqEDS37bXOqSdLQBXamOTETh6Ikg7zUOeYKj0keLiBMHmXUP4TGA/nUPebovbu8FNQ7rHxBrz4pOAe9z1rGQGRMWV2jJKLMm9F1/mIdUasrU7eTbRLtFrgXYaqaaywS6jEJSgvooZ6cxHAnL84uJqMq+PSCQg6IT20ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200975; c=relaxed/simple;
	bh=kWy+Ke9GWwUuSxbHEyUNi946fd7rzWsd6iwJ+rbvrmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij7KLMflEscBXs6iGO6dkIzTdWCTnmelLNS3b6OZZ/yMieuocXSoY6vqFohNgnCrzaFZzbB+DIa5TPaccx0CmDaeWmV7uGD+2VsLAw02lNdfsLdtmSOAp8+6wrRPsy9ALQrrfUZbuYuNmUHwzDXFoH2KCkEJaIj5jdId/ib1szY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPFdftYj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727200974; x=1758736974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWy+Ke9GWwUuSxbHEyUNi946fd7rzWsd6iwJ+rbvrmQ=;
  b=CPFdftYjX93e5PqvpRbA19G/tLEcopr/wids3anO/tI271rXEDS67KRJ
   5+YUsWXZAav3teBBlHKEsmEVqzq4IdhcmH8rWcsWqeGxrW/Vvpj5Y5e8h
   GJRo3vo0P6Jgw+uQeio+zJ/DumB0hZpeFZRPbttKazhkArG7xxvXB7tNi
   eQy8QRnI3l8U+ywnCimIFkJFkdEQH6Ym6UhQXEiHrM3BVHLGt1wZdL1tl
   F8A3AizdMXgDXO6X8eR0+csMf8SFHIm8WxE5sv8V6KW/l4KCEujkOmuOf
   kuY5I89lWx3VOSsGgbMwsOXD0RZIQW04xmd0yk/0V0Y4avt2pEtqm/UoY
   Q==;
X-CSE-ConnectionGUID: Q1TLsjZpQHmnnULEeDZKgw==
X-CSE-MsgGUID: 0LihqjSiSiuSUg8lhDJrCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26087084"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26087084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 11:02:36 -0700
X-CSE-ConnectionGUID: sUEhnzbdRF2hZoAsKKcpGg==
X-CSE-MsgGUID: VIzMWonhSLixVAdSvukQ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71386996"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Sep 2024 11:02:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st9rq-000IfB-1c;
	Tue, 24 Sep 2024 18:02:30 +0000
Date: Wed, 25 Sep 2024 02:01:35 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kletzander <nert.pinx@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <202409250124.D1gI7Lzj-lkp@intel.com>
References: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx@gmail.com>

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kletzander/x86-resctrl-Avoid-overflow-in-MB-settings-in-bw_validate/20240924-165510
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/8d028c5f6f23e92fb83cbf20599366e896abc5b5.1727167989.git.nert.pinx%40gmail.com
patch subject: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in bw_validate()
config: x86_64-buildonly-randconfig-005-20240924 (https://download.01.org/0day-ci/archive/20240925/202409250124.D1gI7Lzj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250124.D1gI7Lzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250124.D1gI7Lzj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/ctrlmondata.c:58:62: warning: format specifies type 'long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
      58 |                 rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
         |                                               ~~~                          ^~
         |                                               %u
   1 warning generated.


vim +58 arch/x86/kernel/cpu/resctrl/ctrlmondata.c

60ec2440c63dea arch/x86/kernel/cpu/intel_rdt_schemata.c    Tony Luck         2016-10-28  25  
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  26  /*
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  27   * Check whether MBA bandwidth percentage value is correct. The value is
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  28   * checked against the minimum and max bandwidth values specified by the
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  29   * hardware. The allocated bandwidth percentage is rounded to the next
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  30   * control step available on the hardware.
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  31   */
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  32  static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  33  {
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  34  	int ret;
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  35  	u32 bw;
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  36  
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  37  	/*
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  38  	 * Only linear delay values is supported for current Intel SKUs.
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  39  	 */
41215b7947f1b1 arch/x86/kernel/cpu/resctrl/ctrlmondata.c   James Morse       2020-07-08  40  	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  41  		rdt_last_cmd_puts("No support for non-linear MB domains\n");
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  42  		return false;
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  43  	}
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  44  
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  45  	ret = kstrtou32(buf, 10, &bw);
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  46  	if (ret) {
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  47  		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  48  		return false;
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  49  	}
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  50  
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  51  	/* Nothing else to do if software controller is enabled. */
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  52  	if (is_mba_sc(r)) {
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  53  		*data = bw;
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  54  		return true;
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  55  	}
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  56  
be99ce3b7dd7ba arch/x86/kernel/cpu/resctrl/ctrlmondata.c   Martin Kletzander 2024-09-24  57  	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25 @58  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  59  				    r->membw.min_bw, r->default_ctrl);
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  60  		return false;
c377dcfbee808e arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c Tony Luck         2017-09-25  61  	}
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  62  
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  63  	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  64  	return true;
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  65  }
64e8ed3d4a6dcd arch/x86/kernel/cpu/intel_rdt_schemata.c    Vikas Shivappa    2017-04-07  66  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

