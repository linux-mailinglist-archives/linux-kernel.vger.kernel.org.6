Return-Path: <linux-kernel+bounces-426735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C396D9DF71C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205BEB21401
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA81D88AD;
	Sun,  1 Dec 2024 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0Jg1UA0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E01C242C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733086427; cv=none; b=kmxcVxEi94Vy0cVxAfQH2OIlcvQLRsdiHsMfE9U7q04X5FWL9+151H3Xen2JwXMEhhW/FThkUHjjn1h5WN1KdEKt4QVlfc8NafwwyMQFU+UGw5Q3D9V7u6Gqpw2EXiQQKC2HUewISj3ktpSeze5nNBfTk1fFOBSZliDd/Wz4qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733086427; c=relaxed/simple;
	bh=3mOK85SzVvaLvKw8xT+53DBumJvcItTDzXlknll3WBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTgbkuMBklALdotSlzTp3OCW5pDayRbEncqIOWOz4F+GfJCl4kv9RFBUWwxHCsxRH1ea4Ys5ePz2gU8wrcXMmUPNkrcHTkaK+orO5mE9H0TQ4DBsxMtyn5Pbh3VEV1J1anlgQwTst2xXUXb7+umlP+LBm0wkyfuAG6i+1qg7ueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0Jg1UA0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733086425; x=1764622425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3mOK85SzVvaLvKw8xT+53DBumJvcItTDzXlknll3WBs=;
  b=j0Jg1UA0cUc5Xxq++XZUPqNJc9p09KvbmiKlzXgH6RHM9rv+bWD8BRGw
   s8Ve6DrjMCVJN+KfzsobXANSvGVgR8TEHPZvNXUQeivx+lZPLdK7K0Tra
   c/3YrPffsWTBZDmTnmOJm9ZuQWEKcFUnY8m5hoKRJITcW0Pk3XO9+gwij
   BFqCqsNNt3uO84R/zg2O5TPP97CIrx7DgUVuoRgkMJmFIXNbAwNjsdZcA
   S8sjYdrY9N0QDkiBbIQJT01Yethw2eC4Oh5QzttPSIruaNBQV0c2JRXkx
   vIqvbrsEH9n0TwEL0rIKXS5U9XvBf4DuhXh40IBJbqpki3zpk6Cd2vngJ
   g==;
X-CSE-ConnectionGUID: s5QhbFq0SlSKI0jxM0WAaQ==
X-CSE-MsgGUID: eYWnUdn0QXKajzRKUIm6eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="50660550"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="50660550"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 12:53:44 -0800
X-CSE-ConnectionGUID: XNychnwCTdOFVA+Q4b0XuA==
X-CSE-MsgGUID: XDCNzDWfQAGhW2frlJEy1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93760679"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 01 Dec 2024 12:53:43 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHqwm-0001qD-1f;
	Sun, 01 Dec 2024 20:53:40 +0000
Date: Mon, 2 Dec 2024 04:53:39 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/callthunks.c:332:35: warning: '%lu' directive
 writing between 1 and 10 bytes into a region of size 7
Message-ID: <202412020442.t7EqpHvu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
commit: f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4 x86/calldepth: Add ret/call counting for debug
date:   2 years, 2 months ago
config: x86_64-randconfig-103-20241116 (https://download.01.org/0day-ci/archive/20241202/202412020442.t7EqpHvu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412020442.t7EqpHvu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412020442.t7EqpHvu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/callthunks.c: In function 'callthunks_debugfs_init':
>> arch/x86/kernel/callthunks.c:332:35: warning: '%lu' directive writing between 1 and 10 bytes into a region of size 7 [-Wformat-overflow=]
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                                   ^~~
   arch/x86/kernel/callthunks.c:332:31: note: directive argument in the range [0, 4294967294]
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                               ^~~~~~~~
   arch/x86/kernel/callthunks.c:332:17: note: 'sprintf' output between 5 and 14 bytes into a destination of size 10
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +332 arch/x86/kernel/callthunks.c

   321	
   322	static int __init callthunks_debugfs_init(void)
   323	{
   324		struct dentry *dir;
   325		unsigned long cpu;
   326	
   327		dir = debugfs_create_dir("callthunks", NULL);
   328		for_each_possible_cpu(cpu) {
   329			void *arg = (void *)cpu;
   330			char name [10];
   331	
 > 332			sprintf(name, "cpu%lu", cpu);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

