Return-Path: <linux-kernel+bounces-436760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877299E8A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C48018826B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5C176240;
	Mon,  9 Dec 2024 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br+QTHK5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81814F126
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718925; cv=none; b=LSZdzjoTNBw8Dzc1cJJCPUrM8j8pqxMRqsUdIKen2v2RwLepZl/ReMaeaJEGY4PKFYMN0pMg9T3pper6jKlUX5ugAlccmjuoIEJvDqHF3PGN8EN/GXMBWrsKirxP3SHsnbx+FgmmkHIm86No5g/QLNtJvN4wIC/Rn1N8c9VMEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718925; c=relaxed/simple;
	bh=wtk34DsJsEPg4AU4HiI1XhttKN8Gx8zKAx8rXiahXhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TckAY1W17Hg7DREkfQnbgDOvzMOpy6RfDrlbrfGxClJN9OHx8sd9Rwj9gw7tpbUouiyAOIeaLAgIBeAa+tlxGft3LoUqIz6oagoZn2/qPLfd85e9qVTCwlYzoaMNDdpdPKsn0KXcLcfZ22iPRVBQPjbMK2kfJz5RTfEd5ZvKq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br+QTHK5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718924; x=1765254924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wtk34DsJsEPg4AU4HiI1XhttKN8Gx8zKAx8rXiahXhY=;
  b=Br+QTHK5ULIui8XiiiSOxZdjCRjoTUanhOSB9eLWNmuDaObZ83FoCXL2
   v+VKKvUlij6gHfSXlwORheoVAAlzuM3jQR6gvwMSJm8EqhvPN/1dzf8Su
   viPlsmHWtdH8geatNsOX2VA1ZKU+svM/F+8u6x5lryfQBKnHpwhPhsDZU
   5sdwTwfceYP5WT7aoXUhnwHvbdFAG8vXpUb42JJrC8ejRzLQ5YCLL3lzF
   EzJBCe0heYDhZIPC3Tdc9OkjOLdKdeaYoobzEAIZ02CHhQppltQOEu9F0
   r4BoqdeuFKyVjyvqfnLNg80TjJ5Y2A1x4p68m0sMI5T7IhT/2ZE7MEok1
   Q==;
X-CSE-ConnectionGUID: ees5oRW1STe1SvExxbS9WA==
X-CSE-MsgGUID: 79K88J3aQ8CRCb2LKE90ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33916664"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33916664"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:35:23 -0800
X-CSE-ConnectionGUID: GjVKYLuvQzaRMYZduNTAdQ==
X-CSE-MsgGUID: lqehsLmKQYy5OOebLzy91Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="118204014"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Dec 2024 20:35:22 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVUO-0003sk-1g;
	Mon, 09 Dec 2024 04:35:20 +0000
Date: Mon, 9 Dec 2024 12:34:21 +0800
From: kernel test robot <lkp@intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/pseries/lparcfg.c:189:15: sparse: sparse:
 symbol 'boot_pool_idle_time' was not declared. Should it be static?
Message-ID: <202412080850.3VU4Q6kb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 9c74ecfd0fc46e2eaf92c1b6169cc0c8a87f1dc2 powerpc/pseries: Add pool idle time at LPAR boot
date:   7 months ago
config: powerpc64-randconfig-r112-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080850.3VU4Q6kb-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce: (https://download.01.org/0day-ci/archive/20241208/202412080850.3VU4Q6kb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080850.3VU4Q6kb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/pseries/lparcfg.c:189:15: sparse: sparse: symbol 'boot_pool_idle_time' was not declared. Should it be static?

vim +/boot_pool_idle_time +189 arch/powerpc/platforms/pseries/lparcfg.c

   188	
 > 189	unsigned long boot_pool_idle_time;
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

