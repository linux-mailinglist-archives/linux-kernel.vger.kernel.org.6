Return-Path: <linux-kernel+bounces-180137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCF8C6A87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516D61C2130F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575215665B;
	Wed, 15 May 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0xWtMbM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290E156253
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790236; cv=none; b=BVDIzj3RWRWXFE4rUtDkMYKCNYAUf95un14TANO3btmCmdOGAbif1qUhJ0HRjKMnWyp04IjSH6offHl2BLXYj0yBEpkIKQy7f81noMpRw3bYjzzRj70VqxaRsi0nKT62Q6N+j1m0t1c+MgPe3OdCBuUx+R+e4SNk9jz4TIKR/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790236; c=relaxed/simple;
	bh=M6QeqY90ekCGj04tP9Rr+hqPCOKOBKDnlrz8leHVcek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CfDLMsawo8J/UbMJ+YoKozOmnWCmA1jPw90O8tjhws6CUFVVBaWqNvccxCcze7s6F7v4RuM+QYvDAdwQf22qnzkNfw2PHpJVNH8Bx1Ufozzxpj3pxXJ9n1foh3SJ0zqDlB65ySzqCvSbySjWnGHxfV2zOz3ImBUzJpp1NDqSn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0xWtMbM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715790235; x=1747326235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M6QeqY90ekCGj04tP9Rr+hqPCOKOBKDnlrz8leHVcek=;
  b=P0xWtMbMZXXRo9uJwb6XkCHsRIAoY439ef/ssexBAWE92LOJ+umEEfk5
   cxAr5YqiWzsOFmd/uYyuD4kw+qlEfOb+D2CNPRoOJ43HPsd/cGUJj7/Uf
   iMEbU+4GeiAo89sNanIusscvgec9sn/ibb9BKdoq//VNAAm0WFDebzUkc
   cVrcNhVcpH1xGGPLU8WKsTotPhGGOdc3tfs1r80Qk9XPu4XEdnRlxVn0v
   t48OKEqfgBE2A9ToPwSlKcig6mD47rZNVW0SiieJPwV4scoanWikLIc3k
   uBhPxEMDsCb8mEjasp0QsGXZzvxhsMT7NzPvx2QzMNEx/5UK7KjS6MV9Z
   Q==;
X-CSE-ConnectionGUID: yktfmKhhRw+3V1Mj70iyuA==
X-CSE-MsgGUID: netRBuzvStGuTJWME7GAlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11683826"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11683826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:23:54 -0700
X-CSE-ConnectionGUID: +qG7XS3iRGCX0Xx0TjjyRA==
X-CSE-MsgGUID: NHMwl6rtTGSkdkJBtbVi1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35990937"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2024 09:23:53 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7HPy-000D1H-2C;
	Wed, 15 May 2024 16:23:50 +0000
Date: Thu, 16 May 2024 00:23:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>
Subject: powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data47'
 from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data47'
Message-ID: <202405160004.lba9xhLN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b294a1f35616977caddaddf3e9d28e576a1adbc
commit: 5d211c7090590033581175d6405ae40917ca3a06 cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH
date:   2 weeks ago
config: powerpc64-randconfig-r022-20220409 (https://download.01.org/0day-ci/archive/20240516/202405160004.lba9xhLN-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405160004.lba9xhLN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405160004.lba9xhLN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data32'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data47' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data47'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data32'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data31' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data31'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data32'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data47' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data47'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data32'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data31' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data31'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data32'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data47' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data47'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data32' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data32'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data31' from `drivers/cxl/core/hdm.o' being placed in section `.bss..Lubsan_data31'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

