Return-Path: <linux-kernel+bounces-181743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B04F8C8089
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F3B20CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25BDDCB;
	Fri, 17 May 2024 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFluO/0F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC254DDCD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922383; cv=none; b=MeQSncm35F/tBXYQZZZ7BN5bFbj2skyQ3YlybVguniURuFX8UNlqjxwxxUD1IBd6elcl84p50+iedxNbnRy3k/Q0hBmFh+ORKsVALhjrSka573bdnX8Vt9e1fArMLOp6PnFhag9Zk1iEkw1EK82/u7vNR4IhijIIQaat/6942Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922383; c=relaxed/simple;
	bh=X65547yC+gjIEWCBBGeUT8y2lrwOCFGBDeGKhjtEZ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nN3w2YZXOdAVLNFWdW0cwwFWzHtZRxpU9qtV1ZcdtZp8N12E1BK6Ygep6ViRXaJo447k3esHVr5EQk3s5amALizvKixbOto9o1L/5BnF7Up79qIBn3Bb9qZe7WPyHBiSvKBjJcca750TuVzmm8G74cwZzTX8AGJ4jTaHyR6ptTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFluO/0F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715922381; x=1747458381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X65547yC+gjIEWCBBGeUT8y2lrwOCFGBDeGKhjtEZ0I=;
  b=jFluO/0F7sQ/Q/PHFGmkpTNEwGZ1AozfHI5EbUV9kMlv1XI+cC45OzWC
   mRBqsoeBJhiZe3hF7tM6StmnK2B903IGnj9Omkro8KPAyT6u0Y2X3FOP6
   4P2TA1HySlXiVXmjq/8HTVVyMDPGLZ4r9gAngrAJyRlM8PNZf4Ag+dTx1
   mCWbD2ERisqsIsSFvEzF2sme18jPJL67muvna5mCoyT15ENmgRhlURN3y
   H/Kno9D/kYi4ZEkY9BiV6pnBAMsSGoYmEOb3Rdmup0rjFNbaKW5n0RPW3
   goaUQKFivDJ2TDO2WZx+9MJmjDtLRmLHhQrIRRBQaDus4AE7rpy35d01p
   Q==;
X-CSE-ConnectionGUID: UXpWMR1XSjmrmmCqkRI1Gg==
X-CSE-MsgGUID: ZrV4VDjkRUqkwXtWTzaVGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23217513"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="23217513"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 22:06:20 -0700
X-CSE-ConnectionGUID: ZyiHM67ZSk6bw2XCpyqnhQ==
X-CSE-MsgGUID: us3R7kliTOaP+RiI+h4+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="36575684"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 May 2024 22:06:19 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7pnM-0000Es-04;
	Fri, 17 May 2024 05:06:16 +0000
Date: Fri, 17 May 2024 12:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x6e): relocation R_RISCV_PCREL_HI20 out of
 range: -524440 is not in [-524288, 524287]; references
 kallsyms_seqs_of_names
Message-ID: <202405171222.JQUW7NxR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea5f6ad9ad9645733b72ab53a98e719b460d36a6
commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
date:   1 year, 6 months ago
config: riscv-randconfig-r063-20240515 (https://download.01.org/0day-ci/archive/20240517/202405171222.JQUW7NxR-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405171222.JQUW7NxR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171222.JQUW7NxR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x6e): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_seqs_of_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

