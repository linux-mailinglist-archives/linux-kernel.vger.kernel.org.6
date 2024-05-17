Return-Path: <linux-kernel+bounces-181889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012B8C82DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143181F211D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8221C69E;
	Fri, 17 May 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V85PeP3h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB691DDC9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936362; cv=none; b=fd8Xi2gH08MdbzmuptslFJkhsOLIkXQtRfWJjPrNzctsTWZqEWpveVcAqMhnM+dJMTMMNpvN5DUhuTjlavLswW/5vzdnLis7o73HkCyHe+Al2DFdZAQDTg1o328zxKJqJ8VOKJN0GLHhz+RuZHWrZWZ+PiI3VVGTupliWkc+cYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936362; c=relaxed/simple;
	bh=lw2YM73uV4pxb1rCLnOwSpJITikfz/PrwQdE9eVB05s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPJs9jwuj50cQE4Ivbepy1dLQXoL3uG3c35d+erhEpQbqlrgQj+1UGySGRmSV6DxgH0Y1QTc9h+79AoCHLbqGahVu33ZF5RFRDDkMZT7ee2hQF76iBQ3tGzdqSGKEO1ifpuc/r6HJU2syuHTAa02eAKNGyEBknmhlEMLeQO4G3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V85PeP3h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715936362; x=1747472362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lw2YM73uV4pxb1rCLnOwSpJITikfz/PrwQdE9eVB05s=;
  b=V85PeP3h/BPwU78FnPog9ZX5aElrINkAAOv40vm1tspR72m6XLTulqgF
   L0Z+YLjqFdfbAQZoeugAJnaIvHs/zLABx4cXnQimpZQw7NQmkNI5J29Lc
   LQvX83D2z4HJLOm9woRpTtdfkhmozFhVoVoQn94VA6FVJkXwRmGD1z85U
   EQgTLkmYdH2+pO1NWhoLeYbPCJC0fZb0ZvLCnekFEwpnJLInjkb3EnRqG
   0HT7DmeVnyGljYKH6kQzCKLTWLggv+8OwsFSiXXiJ5op/bv9aVvbo+rXX
   tEm5Q7GrKyzHp7eI8Sj+XdT5IKHT1b9O20mq45ZEWeHt7XxyOsMiKKlY9
   Q==;
X-CSE-ConnectionGUID: rP8HkexwRiuR86KpNron1Q==
X-CSE-MsgGUID: IYmEhEBJQ8eL9OPV5+IUaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11972567"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11972567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 01:59:21 -0700
X-CSE-ConnectionGUID: vdRPa5+vQQeEYS7RuqrBGQ==
X-CSE-MsgGUID: Ur0iTOcVSq2xou8CBAXdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31823546"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 May 2024 01:59:20 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7tQq-0000Uq-1Q;
	Fri, 17 May 2024 08:59:16 +0000
Date: Fri, 17 May 2024 16:58:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH] genirq/chip: Fix the warn for non-SMP system
Message-ID: <202405171655.T2VuGylp-lkp@intel.com>
References: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/genirq-chip-Fix-the-warn-for-non-SMP-system/20240517-033251
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/1715887825-1031-1-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH] genirq/chip: Fix the warn for non-SMP system
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240517/202405171655.T2VuGylp-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405171655.T2VuGylp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171655.T2VuGylp-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: kernel/irq/chip.o: in function `irq_startup':
>> chip.c:(.text+0x14d8): undefined reference to `irq_do_set_affinity'
>> chip.c:(.text+0x14d8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `irq_do_set_affinity'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

