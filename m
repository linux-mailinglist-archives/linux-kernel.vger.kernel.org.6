Return-Path: <linux-kernel+bounces-515762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C7A368A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D06A3B4AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5CA1FDA73;
	Fri, 14 Feb 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chMmCTnn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF621FCFDB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573009; cv=none; b=JZqRks/GkB59d//5zrs0mv3YcL6EdMEyVurXcdETma1sfiYNlyu/raTqqwK5r2Ai3IQUjIJhB5XAulEPbp80Qid1Bl8AzXMjBeiqhqGedGm1ek25OQt40VILwqQBCvHGKJ+oCDeZ6WWMSd2P7Gw4kAES9mqpTWq4krFuGBxH3vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573009; c=relaxed/simple;
	bh=j4leWUwUUI6z+xPyf91YeQQwCQmtFoGzjCOXiinbHI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rSfG+ckCrdt0cqwxy5TvGs0aweg6hnG8/XBLU9PbWXpldMpU6lig5P4s4frEDFiuhP1B7LFjGFJoI2mglva3ZrXBMc8SBrUnX5V3vvsqo1ZncPTd6U7/obEn3qiU6i+x6bRRbu6m0t139yA0ce9RUmOd/1McBPeWWEnFajLzdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chMmCTnn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739573008; x=1771109008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j4leWUwUUI6z+xPyf91YeQQwCQmtFoGzjCOXiinbHI0=;
  b=chMmCTnnlq1ZndFa7wKE04P6eiBsnU4YMYCYEdfV5B0n5Vwz1HIbLWWh
   3njrp5KrYTn2KO09I2hEn8Wb+7oSF9ace0Rsg0dycS+n5b8n8M7Ep31IR
   IofYwKeAXH9FekkZ477tpyLaBDRQEPq/zuokQ2VdxbQ2KCVAnvI1kmr/g
   czdE6LpGKBpiBR6G8s9Spv3FfLSVCYi7oJWJ0Eh90Q+nuifJraoMsvlQt
   Hl1lBD6GaJILExUfXMoo37+wOcqnZYIPMbXbYwPmh8DNBDTaU4rR0wfpj
   7Xippk4zPLdif8wG+0AF6FMSCCuvvPFsIHDczMYhkUosVQPqoCaOeQndq
   g==;
X-CSE-ConnectionGUID: f1IuQN7NRkqoAOYBS6gVCQ==
X-CSE-MsgGUID: dRjldbViRdmi95+79jiQqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40476351"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40476351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:43:27 -0800
X-CSE-ConnectionGUID: 2iK8Xjg9RLa0Sky8gwf8kg==
X-CSE-MsgGUID: ceQjlkXBRx+6YcfvvRJZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114065853"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Feb 2025 14:43:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj4P5-001AFT-01;
	Fri, 14 Feb 2025 22:43:23 +0000
Date: Sat, 15 Feb 2025 06:42:36 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: ERROR: modpost: "kmsan_handle_dma" [drivers/virtio/virtio_ring.ko]
 undefined!
Message-ID: <202502150634.qjxwSeJR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04f41cbf03ec7221ab0b179e336f4c805ee55520
commit: 35772d627b55cc7fb4f33bae57c564a25b3121a9 sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
date:   3 months ago
config: x86_64-buildonly-randconfig-005-20250215 (https://download.01.org/0day-ci/archive/20250215/202502150634.qjxwSeJR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502150634.qjxwSeJR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from arch/x86/kvm/cpuid.c:13:
In file included from include/linux/kvm_host.h:16:
In file included from include/linux/mm.h:2213:
include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
|                               ~~~~~~~~~~~ ^ ~~~
1 warning generated.
>> arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefined stack state
--
>> ERROR: modpost: "kmsan_handle_dma" [drivers/virtio/virtio_ring.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

