Return-Path: <linux-kernel+bounces-324268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B478974A74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9D91F26364
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A1770ED;
	Wed, 11 Sep 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DadZcGix"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5057CB6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036488; cv=none; b=ahwzeUhzlkZ6fqkkBrhKJ3K9w8UCaQBIYRkpsqmxJ0TJkxLZPaNt/O4NDyLbjZzGV9VVXmgsCn3e08sWsCu5uSX38JF/rJu/5CPyf8fvVgUp64DFrVaC0UpQ+yGec+WxtpxZF/pB8ojzSykMWUEZIZL7y6ja4UT03b0XMfBSn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036488; c=relaxed/simple;
	bh=sT5eyXboXZg+xIE27KznIQJRMPL6IiO/nGVWqOw+9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uM03LWcMo7qkEt5kwczUASp9clXtdsL3C0MO2AKIJTif5cKSDwzfb9rZJ2PchIgFrrO6IDato6S01i6fWxTcfyKrxSJb7wA4qHbxof+1Do9a8PTLTzGctPvZ/T/UjPlX8DilMXnE3JeMexALsyJh88dr25JIEDuikqRfib6bH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DadZcGix; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726036487; x=1757572487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sT5eyXboXZg+xIE27KznIQJRMPL6IiO/nGVWqOw+9T0=;
  b=DadZcGix7wLN3ueBQavIj0ZjEsf+RUJoSQdh2kv8Ecl3AlqUdITjiVuC
   6w9r0/g0W9Dy0bkRR8a8JDNr82whQGPGJU+NgcHhR/1YlJCZH282s/Wgn
   b/8pJ5CdbEkv23p5a5UX8vRizBVg45otXBLVFVqwIjo0xLDt73rn22OJU
   CCUxADi1sCi+iT6j0jVF3kyfEaK4jZavnF5hcLZ9LMpRuwJvK4fH5guw+
   2NdFKBThLcTr/iH2PtPhAweDKg7MD+Kdi7EeVN9Aqtx/LXqjnQBv04Gvq
   SDV418OLfgdPrwkIaQDd9dYi04J3S4ceVEf5eNV1uwAu7JS7dU+MO/h26
   w==;
X-CSE-ConnectionGUID: gIyJMdJYRI+IbrRs70y/KA==
X-CSE-MsgGUID: q3q/4uObTeyug37f8RNUDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35387241"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35387241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:34:35 -0700
X-CSE-ConnectionGUID: GpWB5Bj6TnOew1SjPnyDGg==
X-CSE-MsgGUID: zha2c3k7T+mBf6LaasCxcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67550107"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 23:34:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soGvv-000380-00;
	Wed, 11 Sep 2024 06:34:31 +0000
Date: Wed, 11 Sep 2024 14:33:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/tty/mips_ejtag_fdc.c:343:32: error: incompatible pointer
 types passing 'const char **' to parameter of type 'const u8 **' (aka 'const
 unsigned char **')
Message-ID: <202409111435.RTzhB8Te-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiri,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d8d276ba2fb5f9ac4984f5c10ae60858090babc
commit: ce7cbd9a6c81b5fc899bbc730072a1bddeae5d0d tty: mips_ejtag_fdc: use u8 for character pointers
date:   9 months ago
config: mips-randconfig-r051-20240911 (https://download.01.org/0day-ci/archive/20240911/202409111435.RTzhB8Te-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409111435.RTzhB8Te-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409111435.RTzhB8Te-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/mips_ejtag_fdc.c:343:32: error: incompatible pointer types passing 'const char **' to parameter of type 'const u8 **' (aka 'const unsigned char **') [-Werror,-Wincompatible-pointer-types]
                   word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
                                                ^~~~~~~~
   drivers/tty/mips_ejtag_fdc.c:216:57: note: passing argument to parameter 'ptrs' here
   static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
                                                           ^
   drivers/tty/mips_ejtag_fdc.c:1224:31: error: incompatible pointer types passing 'const char *[1]' to parameter of type 'const u8 **' (aka 'const unsigned char **') [-Werror,-Wincompatible-pointer-types]
           word = mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, 1);
                                        ^~~~
   drivers/tty/mips_ejtag_fdc.c:216:57: note: passing argument to parameter 'ptrs' here
   static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
                                                           ^
   2 errors generated.


vim +343 drivers/tty/mips_ejtag_fdc.c

4cebec609aea6df James Hogan 2015-01-29  299  
4cebec609aea6df James Hogan 2015-01-29  300  /* Low level console write shared by early console and normal console */
4cebec609aea6df James Hogan 2015-01-29  301  static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
4cebec609aea6df James Hogan 2015-01-29  302  					 unsigned int count)
4cebec609aea6df James Hogan 2015-01-29  303  {
4cebec609aea6df James Hogan 2015-01-29  304  	struct mips_ejtag_fdc_console *cons =
4cebec609aea6df James Hogan 2015-01-29  305  		container_of(c, struct mips_ejtag_fdc_console, cons);
4cebec609aea6df James Hogan 2015-01-29  306  	void __iomem *regs;
4cebec609aea6df James Hogan 2015-01-29  307  	struct fdc_word word;
4cebec609aea6df James Hogan 2015-01-29  308  	unsigned long flags;
4cebec609aea6df James Hogan 2015-01-29  309  	unsigned int i, buf_len, cpu;
4cebec609aea6df James Hogan 2015-01-29  310  	bool done_cr = false;
4cebec609aea6df James Hogan 2015-01-29  311  	char buf[4];
4cebec609aea6df James Hogan 2015-01-29  312  	const char *buf_ptr = buf;
4cebec609aea6df James Hogan 2015-01-29  313  	/* Number of bytes of input data encoded up to each byte in buf */
4cebec609aea6df James Hogan 2015-01-29  314  	u8 inc[4];
4cebec609aea6df James Hogan 2015-01-29  315  
4cebec609aea6df James Hogan 2015-01-29  316  	local_irq_save(flags);
4cebec609aea6df James Hogan 2015-01-29  317  	cpu = smp_processor_id();
4cebec609aea6df James Hogan 2015-01-29  318  	regs = cons->regs[cpu];
4cebec609aea6df James Hogan 2015-01-29  319  	/* First console output on this CPU? */
4cebec609aea6df James Hogan 2015-01-29  320  	if (!regs) {
4cebec609aea6df James Hogan 2015-01-29  321  		regs = mips_cdmm_early_probe(0xfd);
4cebec609aea6df James Hogan 2015-01-29  322  		cons->regs[cpu] = regs;
4cebec609aea6df James Hogan 2015-01-29  323  	}
4cebec609aea6df James Hogan 2015-01-29  324  	/* Already tried and failed to find FDC on this CPU? */
4cebec609aea6df James Hogan 2015-01-29  325  	if (IS_ERR(regs))
4cebec609aea6df James Hogan 2015-01-29  326  		goto out;
4cebec609aea6df James Hogan 2015-01-29  327  	while (count) {
4cebec609aea6df James Hogan 2015-01-29  328  		/*
4cebec609aea6df James Hogan 2015-01-29  329  		 * Copy the next few characters to a buffer so we can inject
4cebec609aea6df James Hogan 2015-01-29  330  		 * carriage returns before newlines.
4cebec609aea6df James Hogan 2015-01-29  331  		 */
4cebec609aea6df James Hogan 2015-01-29  332  		for (buf_len = 0, i = 0; buf_len < 4 && i < count; ++buf_len) {
4cebec609aea6df James Hogan 2015-01-29  333  			if (s[i] == '\n' && !done_cr) {
4cebec609aea6df James Hogan 2015-01-29  334  				buf[buf_len] = '\r';
4cebec609aea6df James Hogan 2015-01-29  335  				done_cr = true;
4cebec609aea6df James Hogan 2015-01-29  336  			} else {
4cebec609aea6df James Hogan 2015-01-29  337  				buf[buf_len] = s[i];
4cebec609aea6df James Hogan 2015-01-29  338  				done_cr = false;
4cebec609aea6df James Hogan 2015-01-29  339  				++i;
4cebec609aea6df James Hogan 2015-01-29  340  			}
4cebec609aea6df James Hogan 2015-01-29  341  			inc[buf_len] = i;
4cebec609aea6df James Hogan 2015-01-29  342  		}
4cebec609aea6df James Hogan 2015-01-29 @343  		word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
4cebec609aea6df James Hogan 2015-01-29  344  		count -= inc[word.bytes - 1];
4cebec609aea6df James Hogan 2015-01-29  345  		s += inc[word.bytes - 1];
4cebec609aea6df James Hogan 2015-01-29  346  
4cebec609aea6df James Hogan 2015-01-29  347  		/* Busy wait until there's space in fifo */
70f041b6e1ff508 James Hogan 2015-04-28  348  		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
4cebec609aea6df James Hogan 2015-01-29  349  			;
70f041b6e1ff508 James Hogan 2015-04-28  350  		__raw_writel(word.word, regs + REG_FDTX(c->index));
4cebec609aea6df James Hogan 2015-01-29  351  	}
4cebec609aea6df James Hogan 2015-01-29  352  out:
4cebec609aea6df James Hogan 2015-01-29  353  	local_irq_restore(flags);
4cebec609aea6df James Hogan 2015-01-29  354  }
4cebec609aea6df James Hogan 2015-01-29  355  

:::::: The code at line 343 was first introduced by commit
:::::: 4cebec609aea6dff23e67a42b6516d852fa87d07 TTY: Add MIPS EJTAG Fast Debug Channel TTY driver

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

