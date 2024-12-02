Return-Path: <linux-kernel+bounces-428136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96309E0A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C1163AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD01DD9A6;
	Mon,  2 Dec 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWOD/Smp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AA1DD0F8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162349; cv=none; b=h0pdNIE84EuU1dSTGeaHKEdg2+3S3mH6ZLkdIuqKCZmhdYcQgS72+lLswPTHlV88aerlSEZj7PLRSewat7hG1feQLtwDdQrqdWu5TLm3gAmPgwbbkalKia0CR2SvNtu4cjEQett0KP9SeDjeHVV3U0fEBhsqJBzOe02/+WWWc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162349; c=relaxed/simple;
	bh=pmnArA//bkpdhkHU/fQej/A6gmLmA9azQ3MuefzXl5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZZEXkaR/ul4n33TdmrhDwb6jqzIByK5QTTqZDGt54E4WpsiGVxlKQm8YYwPVwh84aUMIIIQOu7YyAlWrBRqjOUKdOEgvo3LYvoKLAHF4OF2ANCYwoLekf3pl1uJ5HKXEiUa/lXmi2EU4fZI3cP6eZB73Jk34fZShHMRIIaz2zNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWOD/Smp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733162347; x=1764698347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pmnArA//bkpdhkHU/fQej/A6gmLmA9azQ3MuefzXl5U=;
  b=dWOD/SmpXG8Lf3swCPcmUTQaVR8wGCUB6WAttmp1A/BBLfJgtl30wfRj
   UwSPecQz3Xqu79+WhrV4+NYzeRDYYW906qsCX3kZigujoPbW3qmdA49yv
   04mDOytCxeYFSvkM8m89HDn/f8uC8qW6lM9I5/XQNggpe8wSxjh8fg6Ri
   NN8z2IgSrUQPB54iSjEvN/suGJUSFJubk0kFz8fGdyfNw4TlBJ/ehAugU
   8P3xYk8eKwo85aOIiIRovNP7evV9M0l6NDLMTA5fyzNGyXb8DERYcpGCf
   KfMuJYtn2IuMdyEdEZ2tmwa4IZB2FfZ4vinhMc5+6uMEjRkAaRX3FhHQy
   A==;
X-CSE-ConnectionGUID: MA7jdpwXRySRL+sbMpgFsw==
X-CSE-MsgGUID: lkvkg4h0Qem1vnxd0sxH3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50868448"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="50868448"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:59:06 -0800
X-CSE-ConnectionGUID: LMwZfNzTRnegJqXWq83g+A==
X-CSE-MsgGUID: p6cFK7QMRsq7FR0lwHnivg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="97612437"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2024 09:59:05 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIAhL-0002hR-0V;
	Mon, 02 Dec 2024 17:59:03 +0000
Date: Tue, 3 Dec 2024 01:58:13 +0800
From: kernel test robot <lkp@intel.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@synopsys.com>
Subject: arch/arc/plat-hsdk/platform.c:16:5: sparse: sparse: symbol
 'arc_hsdk_axi_dmac_coherent' was not declared. Should it be static?
Message-ID: <202412030106.M5RMPcBO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
commit: ce0eff0d9b4d37702df48a39e3fddb5e39b2c25b ARC: [plat-hsdk]: allow to switch between AXI DMAC port configurations
date:   5 years ago
config: arc-randconfig-r123-20241118 (https://download.01.org/0day-ci/archive/20241203/202412030106.M5RMPcBO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241203/202412030106.M5RMPcBO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030106.M5RMPcBO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arc/plat-hsdk/platform.c:16:5: sparse: sparse: symbol 'arc_hsdk_axi_dmac_coherent' was not declared. Should it be static?
   arch/arc/plat-hsdk/platform.c:27:17: sparse: sparse: undefined identifier '__builtin_arc_sr'
   arch/arc/plat-hsdk/platform.c:34:17: sparse: sparse: undefined identifier '__builtin_arc_sr'

vim +/arc_hsdk_axi_dmac_coherent +16 arch/arc/plat-hsdk/platform.c

    15	
  > 16	int arc_hsdk_axi_dmac_coherent __section(.data) = 0;
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

