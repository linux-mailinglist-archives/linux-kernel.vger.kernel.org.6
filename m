Return-Path: <linux-kernel+bounces-302653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712396017C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25D0281D27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D433999;
	Tue, 27 Aug 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWY2ZMWE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8417344C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739781; cv=none; b=Os/RZ8dwk/gYrTqY3/eqoV/+8hYdiXFT9yGH0PJlIqKgsBVZ6LD06ju3+Xd+79kFCtDdicfa8FqJ/FT79NETa7J5adiZ1eL04w1wY7ZIPqngo++CNHZ/5DU4PFM2SajycZ3BLDu2pXo51Ie0QSEWK/+HMmMGsw46Q467eMP/cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739781; c=relaxed/simple;
	bh=crLZWaA9tZqOl38BcFty53sZrr+x1AvDPHZt3AoUpsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlmG0pIjEw3tLRTnKzOf2WhJnca5r973O56SYhoxIiOc4e6zRh1MYKLaUteZ/76wWwfg/r16RjBHdQW6X8bwTJKYuEN2aB2MbU1DJIx1EwxR7OtYLCqQuEWw1GSFEsO1THyf6hsVlAHEXKb9+N/EnO5LBVaG0oA2EKLkfTsCXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWY2ZMWE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724739780; x=1756275780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crLZWaA9tZqOl38BcFty53sZrr+x1AvDPHZt3AoUpsQ=;
  b=IWY2ZMWE7cfzW+GSPsWpbHf+0ASM1jQWVtbiP7ztWPOQWt1mGBfoFBAU
   heS5pnBfvkUVZIJkdNc8NlpIpSyuNsFJv6AFUI5M0b6s3Bj/OGwegrlAI
   J5i93fL4rLO6hjKkPLgYPA9i7b8c0sZDbTRNL4bzIHcWj/t+jO/LRpxru
   xO3nrXBPdjTXzQKCEpIl0RpSCUU+fTLTINCKhau/z7MB8C5g7f9tqL/PW
   JOCRZp+Pmb8ptt/Capw0IZthxIPfzhuqb2eLVzdNfBIEvGzu6QA/p3l+r
   mDjhH68oUPzrLtrDIfO/t+ETLkKvUdzJi3uY0ZdqbZOlmNeFAejqDZRzp
   A==;
X-CSE-ConnectionGUID: 0xTyklW/Rp2XcaKk595+cg==
X-CSE-MsgGUID: miCvyTU+Q7WGgv6wlxTPTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33821571"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33821571"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:22:59 -0700
X-CSE-ConnectionGUID: a/B4SlHAT02wldopP2ouyg==
X-CSE-MsgGUID: dLnN+ZzRR1OiuSHPdBSuFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62589118"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Aug 2024 23:22:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sipbT-000I8E-2K;
	Tue, 27 Aug 2024 06:22:55 +0000
Date: Tue, 27 Aug 2024 14:22:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Xie <jeff.xie@linux.dev>, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com, Jeff Xie <jeff.xie@linux.dev>
Subject: Re: [PATCH v2] genirq: procfs: Make smp_affinity read-only for
 interrupts that userspace can't set
Message-ID: <202408271311.szIyk0et-lkp@intel.com>
References: <20240825131911.107119-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825131911.107119-1-jeff.xie@linux.dev>

Hi Jeff,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/genirq-procfs-Make-smp_affinity-read-only-for-interrupts-that-userspace-can-t-set/20240826-153926
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240825131911.107119-1-jeff.xie%40linux.dev
patch subject: [PATCH v2] genirq: procfs: Make smp_affinity read-only for interrupts that userspace can't set
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240827/202408271311.szIyk0et-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271311.szIyk0et-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271311.szIyk0et-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/proc.c: In function 'register_irq_proc':
>> kernel/irq/proc.c:343:17: warning: unused variable 'umode' [-Wunused-variable]
     343 |         umode_t umode = S_IRUGO;
         |                 ^~~~~


vim +/umode +343 kernel/irq/proc.c

   337	
   338	void register_irq_proc(unsigned int irq, struct irq_desc *desc)
   339	{
   340		static DEFINE_MUTEX(register_lock);
   341		void __maybe_unused *irqp = (void *)(unsigned long) irq;
   342		char name [MAX_NAMELEN];
 > 343		umode_t umode = S_IRUGO;
   344	
   345		if (!root_irq_dir || (desc->irq_data.chip == &no_irq_chip))
   346			return;
   347	
   348		/*
   349		 * irq directories are registered only when a handler is
   350		 * added, not when the descriptor is created, so multiple
   351		 * tasks might try to register at the same time.
   352		 */
   353		mutex_lock(&register_lock);
   354	
   355		if (desc->dir)
   356			goto out_unlock;
   357	
   358		sprintf(name, "%d", irq);
   359	
   360		/* create /proc/irq/1234 */
   361		desc->dir = proc_mkdir(name, root_irq_dir);
   362		if (!desc->dir)
   363			goto out_unlock;
   364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

