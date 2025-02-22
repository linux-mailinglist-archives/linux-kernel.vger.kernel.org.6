Return-Path: <linux-kernel+bounces-527335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD17A409D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E33189BBC0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD0190468;
	Sat, 22 Feb 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+dcY7gP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061C11CAF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241123; cv=none; b=qgGA7Zuu6omAZsrtANGhhFSe0BvGoyfdkKYrBaK467RsaovEzhK0etk9qNNkI4nMzxtTa4peEvN9xkoyCcP9vUaP5trqLk083JWM6xhsvqpo4w9c/LBrAtiVgYeXCqEeMArGNyGUqpHbz6R/hMX5QUfkaTa2NP9B1KByX6xwzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241123; c=relaxed/simple;
	bh=Bqm+1bktPRMG2h6RktV6hW9ZUKR0RlFbE8gXvmEOUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hf7YPSIXdwPg9BJq4yhNtS5eV2EXKRbXHKmQHRQJk9rNWurU0ULWKkk1j3LdLA9w4vOF00C1RecK7BlX6AYNpaoeTvy68soK3M5a7O1qL9ljn21riuqen7N0U6b1lAZIM2w9rSaS8VsHkPtZbsgvdK8+0+L43IYGqhVZCd8VDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+dcY7gP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740241121; x=1771777121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bqm+1bktPRMG2h6RktV6hW9ZUKR0RlFbE8gXvmEOUBQ=;
  b=L+dcY7gP1k8Vorc31BCseLil6BatP66dL1Inbf2h8fxJuEZq1qAN/MAF
   hzSFXtTVrJv93+SCgcCPfnnx7RYe4MBhK1jMwe64HqBS5QTKRxPU+fccQ
   UdBvJMMmEzOjAcIMQJwpESEOiG8RxseIwjhE6TpfB8TQ/rdjyXtLSR6Md
   /tpe+gFn00A144X1TLZzv9xZyCokHbVKmmqy1jUW69XAJUmtwVrB8JS/h
   IOSoEaHDE7FB1iwzdlBwhWYFLQc25kiKcvtYca6ZzrBa7S7NUWN4NSbJl
   1pP4ATpRinrq4AuoMiwcSMyjF96cvcPjm/2ZPLs+9cudlteb4t15hS6gu
   g==;
X-CSE-ConnectionGUID: oyRjyZTSTDemfIAIwUn8HA==
X-CSE-MsgGUID: fToUYeWFTAqZdVc65dHnDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="51672086"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="51672086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 08:18:40 -0800
X-CSE-ConnectionGUID: xxvwIezFS+SueIyk9k3Lbg==
X-CSE-MsgGUID: T2lD4t/qQPy2ueZKyY7AIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="146486192"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Feb 2025 08:18:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlsD6-0006hY-2l;
	Sat, 22 Feb 2025 16:18:36 +0000
Date: Sun, 23 Feb 2025 00:18:23 +0800
From: kernel test robot <lkp@intel.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match'
 defined but not used
Message-ID: <202502230042.owPXHbB7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nava,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff202c5028a195c07b16e1a2fbb8ca6b7ba11a1c
commit: 01c54e628932c655e4cd2c6ed0cc688ec6e6f96b fpga: versal-fpga: Add versal fpga manager driver
date:   3 years, 7 months ago
config: sh-randconfig-r023-20230105 (https://download.01.org/0day-ci/archive/20250223/202502230042.owPXHbB7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502230042.owPXHbB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502230042.owPXHbB7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match' defined but not used [-Wunused-const-variable=]
      78 | static const struct of_device_id versal_fpga_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~


vim +/versal_fpga_of_match +78 drivers/fpga/versal-fpga.c

    77	
  > 78	static const struct of_device_id versal_fpga_of_match[] = {
    79		{ .compatible = "xlnx,versal-fpga", },
    80		{},
    81	};
    82	MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

