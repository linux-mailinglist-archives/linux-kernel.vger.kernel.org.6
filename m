Return-Path: <linux-kernel+bounces-221921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8890FA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513BE282FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31516FCC;
	Thu, 20 Jun 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxcGXUPQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8D4C99
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844905; cv=none; b=UCQNevVoDUtlFvzfC5ZBaJ0TN+Sd6JrosP8w94VDgcA9cyOGSpZiM4xcOGmHl7+VoeuyREIj5gwFJZ9iVvdLiFcQqYMNE2gZbaeAeH+Cvkk4LTjEpTRI3Jfd3Iy98YpwrgqiEmDHDX3j1834FY/wm10ydfqW9iULPD5qlUDykkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844905; c=relaxed/simple;
	bh=FOp+5M3DdRsTnxinZIbth3E/K5tdTSD25lai0gtZokk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fq5qgrQu0JQCI9LSeNK6haApxjvXuEaJd8FV5cfJ7EWQP+O8uoWaGzzt3HdBBVmScAODDHhakVp62YAoAig/b2OpNwV1qEupoXkBD+QsZuLWGWf9/QbEqGyTrTtRjAHMGZaHZe52MylMH+SyegOEjRdgV/XCRQfht+EyxvYciEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxcGXUPQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718844904; x=1750380904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FOp+5M3DdRsTnxinZIbth3E/K5tdTSD25lai0gtZokk=;
  b=OxcGXUPQN6aPdzw8DYBAtOB5FzKGkWAfhWfJURsk4qhROiVVMFj4O2Hi
   RRmzCB+pWIgd/G8O1gk0YXmHG+7rV44FwvQnvDiJSqK+mlsql9nnUE3lx
   OBYgWYH+g8T6xRq6xKvA14Hyt9+2pJLT3ktch6Tx5a5Iw8AjBd3jDzyNw
   cW55M2K+yOfgNa7s3jg1pKTcmFG8fj6tM+D6nfX9kttxHBKruMjPP8y7+
   EBfTPOEnvMC8+xIbodQVtqn+iLC4gLpfR2RwuJX/yTN/uVD+NYbKznKAj
   li51FETDtaUAf8qfFPZ65SR4eO7eq3r/4OUxBvSkN83x/9L+r3X1ltfyg
   A==;
X-CSE-ConnectionGUID: ZZ1HlsW9S8euuRiUHFlJ4w==
X-CSE-MsgGUID: Zft533xgQcSMuLJp932gIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15632287"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15632287"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 17:55:03 -0700
X-CSE-ConnectionGUID: BOAUnFWJRU+yGUpyujOm3w==
X-CSE-MsgGUID: PXhyBvZMQviAV13n6q6f7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47026524"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jun 2024 17:55:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK64p-00079Q-24;
	Thu, 20 Jun 2024 00:54:59 +0000
Date: Thu, 20 Jun 2024 08:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
Message-ID: <202406200829.IytwLyQJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
date:   3 months ago
config: um-randconfig-r123-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200829.IytwLyQJ-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x10b (section: .text) -> sg_mask (section: .init.rodata)
>> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x68 (section: .text) -> sg_mask (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x119 (section: .text) -> sg_mask (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

