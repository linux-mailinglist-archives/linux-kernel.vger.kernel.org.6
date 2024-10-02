Return-Path: <linux-kernel+bounces-348169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461098E3A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6738B1C234E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7B215F7A;
	Wed,  2 Oct 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPQkc2ru"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F1215F6D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898098; cv=none; b=mfkPhOwBSbzym7H8Y8/6m8DuToEyi7/0fj29wfIEMfHkzqIk6Tg8R3FOJFFm2GDSex5qq4L3aXbTdgxpWFoNTcCnN0wGKjTb/rOxMDCUuPStntfyJKPTZurznM5Dvzs+KaVZK9yk+Vcy68/RtGXynQyY2Yu4sCRoKKizdSJgj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898098; c=relaxed/simple;
	bh=Kvq0X+mEDoKKpX/gap383bTY310Optun1Ax942YRR2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DtgGQQIsMCs/qIqcouuhnpipC//L0u7A0VRhBFt4xm9oVoCoPjfKig2c9TUKQNHTLQHVxqYO4qjv1mYul0vsAa5L1UxkgShSSsb6SRYFiIapB9gzCOf8PWmRvK/Zf1MqV9YGNoBxbfJ+qFyF+9ISSs8SRHHJcVz1Q/bEmBWmqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPQkc2ru; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727898096; x=1759434096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kvq0X+mEDoKKpX/gap383bTY310Optun1Ax942YRR2c=;
  b=OPQkc2ru+/oczgfe49GCDk80zvQ3AGtFapvkxU6M1fYKfn1Y7OBis9Fs
   NvnIPlMjnwzuatPl988RisaA8/VIH47CzRRRVGebUaH0bO7X2lwh5cwUV
   AzXParcljOxnjHmcw8nip3n6HJ5x+/6Jkh97tLiLyI6OCOvScIGWLArm6
   5Lp71ZsC7D26LwNNHdX53G6i8F1Su5VKEDb2LfGPKnDkS/p1843R1HhT4
   KEyvgiWlvmv7uz13UFQ6sZjx9JoW7j/75YwDKYil92xirt1fHOrl9WEQ2
   N8+c6HohGj5CpOkUZJ9g1EqYfCPbfGtbkFnZhaH8BxARL8M2bKv95VmR0
   A==;
X-CSE-ConnectionGUID: tfIl1VUGQCCpWGr8tOowWA==
X-CSE-MsgGUID: oD73X0v9RWahaftJFOz8VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26881391"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26881391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:41:35 -0700
X-CSE-ConnectionGUID: AJ1Y2BqLRMKjveT7VgtXXg==
X-CSE-MsgGUID: wbHdWhU3RG+8zC3Kb2fFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="74347047"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Oct 2024 12:41:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw5E3-000UUp-2G;
	Wed, 02 Oct 2024 19:41:31 +0000
Date: Thu, 3 Oct 2024 03:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: {standard input}:5164: Error: opcode not supported on this
 processor: mips32r5 (mips32r5) `dmfgc0 $6,$9,7'
Message-ID: <202410030355.CqMgGzk5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: a640d6762a7d404644201ebf6d2a078e8dc84f97 MIPS: mipsregs: Set proper ISA level for virt extensions
date:   7 months ago
config: mips-randconfig-r036-20221007 (https://download.01.org/0day-ci/archive/20241003/202410030355.CqMgGzk5-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410030355.CqMgGzk5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410030355.CqMgGzk5-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:5164: Error: opcode not supported on this processor: mips32r5 (mips32r5) `dmfgc0 $6,$9,7'
>> {standard input}:5176: Error: opcode not supported on this processor: mips32r5 (mips32r5) `dmtgc0 $2,$9,7'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

