Return-Path: <linux-kernel+bounces-266600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA3940288
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C140B283325
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686C139D;
	Tue, 30 Jul 2024 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDrS4dDZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73449440C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299895; cv=none; b=k6pctwejh+WQvbf7ttXGu4YUyBlT5QAzZmd2Jz+ARosFbaMOY2KIJNBx83aHduAF9a4t5m77MvRRogVHTLzgReG5ncBZw1atiPWv8nr2unjo1yePe3bgmwnScSDHqWbMwmAgTMxBkTgNT1bd42svQqBdQ114mrxxRRaTPp/VkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299895; c=relaxed/simple;
	bh=3txxOPLyefIXIxbZWtm6IPTzYsqcvTRhG55mc5XZk+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvxUWFIXLnnQu8szo06Ueh5BLRVik+cj1HjitalbvegNmYzhQ7pnO802MhgnuEJ/1C+Srw1y4Lvzuno3CglDy/uXLmuSs4mWmHe0sbeyyVOr6++UcVD3YBQv7UM4Qq9BRps7Qv0lsbBXrzBDB4OXErHaFYD7ecg9qxNU2YSoITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDrS4dDZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722299893; x=1753835893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3txxOPLyefIXIxbZWtm6IPTzYsqcvTRhG55mc5XZk+E=;
  b=IDrS4dDZLwTcxgqq40EO8a0eHSy/fIOHP3btquy2f03Rh++niIIWp43W
   YnYP+0AgxAts3T6T47bbObvtzq7KlidbpS/fqXLSaKRjEA8rF71pqdLCV
   OIKTEMmGfY+V9iW1VvL+edvSEwvRAoxnAb5/qHbHvHrysAThBdGCbuWwf
   ABfQKy+smhNQGZPVk+UTgk9VWhsktZiQjuSKu5BtMy+X2V3r2j088vukg
   hr6BAAGf2kx3hkMVvuLKRG3Y7ghyeJiCLyb8HUFt3PrYbBI3fyvY20UO0
   PpM4VT7Zq+bdcDynuO9Wr3F+8vFSpG1W5lf/b7V/VoLtL6KePn8P/bkYb
   w==;
X-CSE-ConnectionGUID: obp7oMmYQ6ikUPozGHoaiQ==
X-CSE-MsgGUID: d5KcXhOaSBWdAMLG5nMSYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19892147"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="19892147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 17:38:12 -0700
X-CSE-ConnectionGUID: 90D1BFCWRS+VRvXaNk47FQ==
X-CSE-MsgGUID: XolwQ9I6Tx6XSygbE7kX/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54740711"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2024 17:38:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYasS-000sFI-2z;
	Tue, 30 Jul 2024 00:38:08 +0000
Date: Tue, 30 Jul 2024 08:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 23/30] drivers/irqchip/irq-armada-370-xp.c:263:44:
 error: 'd' undeclared
Message-ID: <202407300832.j5i0hRhx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marek,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   e626fcbaa9b67e4488ea437e0e8a5657e707d5f8
commit: f72976cd7f0e16639f29398d5fe5ab1b03789b42 [23/30] irqchip/armada-370-xp: Use consistent name for struct irq_data variables
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240730/202407300832.j5i0hRhx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300832.j5i0hRhx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300832.j5i0hRhx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-armada-370-xp.c: In function 'mpic_msi_set_affinity':
>> drivers/irqchip/irq-armada-370-xp.c:263:44: error: 'd' undeclared (first use in this function)
     263 |         irq_data_update_effective_affinity(d, cpumask_of(cpu));
         |                                            ^
   drivers/irqchip/irq-armada-370-xp.c:263:44: note: each undeclared identifier is reported only once for each function it appears in


vim +/d +263 drivers/irqchip/irq-armada-370-xp.c

   250	
   251	static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
   252	{
   253		unsigned int cpu;
   254	
   255		if (!force)
   256			cpu = cpumask_any_and(mask, cpu_online_mask);
   257		else
   258			cpu = cpumask_first(mask);
   259	
   260		if (cpu >= nr_cpu_ids)
   261			return -EINVAL;
   262	
 > 263		irq_data_update_effective_affinity(d, cpumask_of(cpu));
   264	
   265		return IRQ_SET_MASK_OK;
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

