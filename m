Return-Path: <linux-kernel+bounces-337428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60377984A00
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B839A1F2259C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656A1AC431;
	Tue, 24 Sep 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6309Luf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D41AC428
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196638; cv=none; b=K71MbNsZbSX0IuGgttOu/1gemYnens3/k8fuBDNGyL237HawMqWk5GH2UKVnW8s4N6J2Xa2sQacA3L0pjqaRm0Gy+9Pd8vyTCRJMGFbTetYKArZMziHpxs5sxOkYWnQnmad/+eWUyyiB3Q6VgwrUsNW7mB96iXvgG//fQaCMh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196638; c=relaxed/simple;
	bh=3w5AXESH6xIZJewtYq5MpPk4X8VvNrZSufuTd7GGFi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOTnPv5VKlOb/DmqGMCw47+q3zETrX0UIipjdU8nWQR1eAlU6occ6Q7PtPBJprtaej5PIiqTVjUysffCBoascZg2eZumF9lu7l2kHKjG5TQP5z88vPlw1/O71ZfgDkZw0xJWChDw+ln/hDXz6fmyFHLynVxOQc9atT0N7rSy9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6309Luf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727196637; x=1758732637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3w5AXESH6xIZJewtYq5MpPk4X8VvNrZSufuTd7GGFi0=;
  b=H6309Luf1K/ZLqcHEZjzYZIH3+mUsmp/mOs0xd4GEP5DBs96cNftrE9D
   jcIbR8/CJAuUMPKE50srxriV2m8Z8dj6+m+sNFgGgj45NFGzWVM5LwPN4
   qu8RiAIGRRLa2k/T/j4fU7+ntOl3Q2mOlRb67gdnhyK6wLWnB/Gjopi/p
   Crj4ckT+Cfe91VC49aZgIEKu1PusyhmtyqZe40VT3IK7k4LYL3ysnL3/U
   brzXwwGQUqRd/yIfeHEN6Xd9AHdW5CeQ8JUT8LHaG/1gvMmqW+nSq54yT
   F2TPbipIrjxu/0QvdAs7wUn8Bg+NLdDVNwiMRty4aCjjNrJEasAoEnmjo
   A==;
X-CSE-ConnectionGUID: i6JC/u+VSEmRAt9r20JAPw==
X-CSE-MsgGUID: /NMCnR1VTReCY2OON+CEhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43726049"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="43726049"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 09:50:34 -0700
X-CSE-ConnectionGUID: GL6BARl6T0azW8KCeXdlPg==
X-CSE-MsgGUID: DBunaQknS52czotfk8RTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71919109"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2024 09:50:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st8k8-000Ick-39;
	Tue, 24 Sep 2024 16:50:28 +0000
Date: Wed, 25 Sep 2024 00:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kletzander <nert.pinx@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <202409250046.1Kk0NXVZ-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20240924 (https://download.01.org/0day-ci/archive/20240925/202409250046.1Kk0NXVZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250046.1Kk0NXVZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250046.1Kk0NXVZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/resctrl/ctrlmondata.c: In function 'bw_validate':
>> arch/x86/kernel/cpu/resctrl/ctrlmondata.c:58:49: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'u32' {aka 'unsigned int'} [-Wformat=]
      58 |                 rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
         |                                               ~~^                          ~~
         |                                                 |                          |
         |                                                 long int                   u32 {aka unsigned int}
         |                                               %d


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

