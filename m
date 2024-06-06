Return-Path: <linux-kernel+bounces-203832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF98FE106
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C03A286E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA313C839;
	Thu,  6 Jun 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chnOKPJp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF016328A0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662873; cv=none; b=crNpvXeNQsVC2bQZX8OoNAhOVxWrY9lYjZhUpURrXE9sJm30RoCYUmoOcgDtF3HYSks6rCuBDZo/DDVpzVo9ZwzFbWQlwupsP5b/2Sqa9eB4UNU0roUkOamwpbHiLFbZ/GzeQg28I9kzXg7KYvZst0YLAU5HYc67xV44AUFXzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662873; c=relaxed/simple;
	bh=RdwFWD65OoKPQfprbh1lzHRMyDWlpC3QIEpyfqP5jsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mACpjQFODZcZXKUxdqLA8PDcNjtkZYsjatplZFVenfW8o3v9tThj88ca/esNWrqJeTKCPV8d69T/DvaF6Y1kfK/e27xYKEKtvbCwQg+FomkHt74ZWkPjnMY+ATlwH/Ptqn8bSlzywgYJYzurewnNDetZU2uaFVgOBQLFmk7PMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chnOKPJp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717662870; x=1749198870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RdwFWD65OoKPQfprbh1lzHRMyDWlpC3QIEpyfqP5jsI=;
  b=chnOKPJpNV+mxDIeCyMgNdX+0Zskpp0PuhwoYDDwHrOo/3UFaBYIIMwu
   dDwBvpheghlDIU6Y5VvYVTBKwwSuxEY2Ml5Rp394lRb+/E1IyPj6PE5iT
   JnMae2VN6dAIMRTWIZ88lX/apMcpuILO7z6CITVDPv5Iokq8K4G50/GI7
   sA3PndAIVF42wzw+YkHGRnN9pooPQ6Age/SXE3/RlqSUpO/q1rNz0vNcG
   /U3cPwqgjmvU/hogXf45gbrPiK/+LmzU8oa4f8SIr0PB+ssJUlV/rnGRn
   KZ4oiVhYAK7IviIBFv4UCXK2MyEWvX00oYiJCsGtA4pzdkNYZcYg3GOZQ
   A==;
X-CSE-ConnectionGUID: 1vX+oiS7R1COZXb+OQlynQ==
X-CSE-MsgGUID: gdJdzDmCStqY+HX14+edwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24883571"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24883571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 01:34:30 -0700
X-CSE-ConnectionGUID: zPqwUyncRdO0ZowaL0NjEg==
X-CSE-MsgGUID: XIokBcxAQ6auO+r6RPbZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38001259"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2024 01:34:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sF8Zl-0002rE-0K;
	Thu, 06 Jun 2024 08:34:25 +0000
Date: Thu, 6 Jun 2024 16:33:35 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: include/linux/mtd/map.h:381:(.xiptext+0x17af): dangerous relocation:
 windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
Message-ID: <202406061616.NSqhiIhR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2df0193e62cf887f373995fb8a91068562784adc
commit: 2416a2e7be9b27157f173268f5c7f769bd72a8dc mtd: chips: remove redundant assignment to variable timeo
date:   3 months ago
config: xtensa-randconfig-s041-20230103 (https://download.01.org/0day-ci/archive/20240606/202406061616.NSqhiIhR-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406061616.NSqhiIhR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406061616.NSqhiIhR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0x1287): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0x1293): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1742:(.xiptext+0x129f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1742:(.xiptext+0x12ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0x12c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1744:(.xiptext+0x12d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1746:(.xiptext+0x12e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0x12f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1304): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2f80)
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x130e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1316): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1321): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x132a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1338): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1340): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1350): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x135e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1368): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_start':
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x1375): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0x137e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1725:(.xiptext+0x13c1): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1729:(.xiptext+0x13cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1730:(.xiptext+0x13dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_enter':
   drivers/mtd/chips/cfi_cmdset_0002.c:1278:(.xiptext+0x13e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x13fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x1406): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x1414): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x141e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x1434): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x143c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x144a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x1454): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x146c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x1474): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x1482): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x148c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x14a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x14ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x14ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_start':
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x14c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1733:(.xiptext+0x14da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1733:(.xiptext+0x14e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x14f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x14fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x1510): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x151b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1798:(.xiptext+0x1527): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:1803:(.xiptext+0x153c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1807:(.xiptext+0x1547): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1807:(.xiptext+0x1552): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1809:(.xiptext+0x1560): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x1580): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x158f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x1597): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x15fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1604): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x160c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1618): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1620): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x162f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1641): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1656): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1662): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1724)
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1670): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x167e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x168c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16a5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x16f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1708): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1713): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1720): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x172a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2cf4)
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1732): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0x1738): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0x173e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0x174f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x1772): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2416:(.xiptext+0x178f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:2416:(.xiptext+0x1795): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x179e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
>> include/linux/mtd/map.h:381:(.xiptext+0x17af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2421:(.xiptext+0x17cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2423:(.xiptext+0x17da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2424:(.xiptext+0x17e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2426:(.xiptext+0x17f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x180c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x1814): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x181f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x1832): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0x1840): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2f80)
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0x184a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0x1852): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x185d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1866): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1870): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x1880): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x188e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x1898): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2450:(.xiptext+0x18a5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2438:(.xiptext+0x18ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x1904): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x1910): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x191e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x1928): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x1940): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x1948): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x1956): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x1960): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x1976): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x197e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x198c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x1997): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x19ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x19b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x19c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x19cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x19e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x19ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x19fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2445:(.xiptext+0x1a06): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2446:(.xiptext+0x1a1c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2447:(.xiptext+0x1a26): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2448:(.xiptext+0x1a3b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2448:(.xiptext+0x1a47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:2450:(.xiptext+0x1a5c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2454:(.xiptext+0x1a67): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2454:(.xiptext+0x1a76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x1a96): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x1aa3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2459:(.xiptext+0x1aab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2460:(.xiptext+0x1ab6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2461:(.xiptext+0x1ac6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2463:(.xiptext+0x1ad4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2465:(.xiptext+0x1aea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2467:(.xiptext+0x1af2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2467:(.xiptext+0x1af8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2470:(.xiptext+0x1b04): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2471:(.xiptext+0x1b0e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2471:(.xiptext+0x1b18): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2471:(.xiptext+0x1b20): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2474:(.xiptext+0x1b2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2474:(.xiptext+0x1b34): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2475:(.xiptext+0x1b43): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:2475:(.xiptext+0x1b55): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2480:(.xiptext+0x1b6a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2488:(.xiptext+0x1b76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1724)
   drivers/mtd/chips/cfi_cmdset_0002.c:2488:(.xiptext+0x1b84): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1b92): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1ba0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1bb8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1bc0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2502:(.xiptext+0x1bd0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2502:(.xiptext+0x1bda): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2504:(.xiptext+0x1bf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2504:(.xiptext+0x1c00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2505:(.xiptext+0x1c14): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2506:(.xiptext+0x1c1f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2cf4)
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c4a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1c5b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1da2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1db7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1dbd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1dc8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1dd6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2514:(.xiptext+0x1df0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1dff): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2f80)
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1e0b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `current_thread_info':
   arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x1e14): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1e1d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x1e2b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1e36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1e3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x1e4d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0x1e56): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:381:(.xiptext+0x1e62): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2521:(.xiptext+0x1e78): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2523:(.xiptext+0x1e84): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2523:(.xiptext+0x1e8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2527:(.xiptext+0x1eb2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2533:(.xiptext+0x1ebb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2533:(.xiptext+0x1ec7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2534:(.xiptext+0x1ed8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2534:(.xiptext+0x1ee6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2534:(.xiptext+0x1ef2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1f01): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1f0a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x1f22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x1f30): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2550:(.xiptext+0x1f44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x1f5f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x1f6a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x1f78): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x1f84): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x1f9e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x1fab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x1fbb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x1fd3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2540:(.xiptext+0x1fdf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2540:(.xiptext+0x1fee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2540:(.xiptext+0x1ffe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x200f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x2025): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x202e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x2036): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x2042): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x204b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x2056): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x206d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x2076): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2543:(.xiptext+0x2082): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2546:(.xiptext+0x20a9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2546:(.xiptext+0x20b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: panic
   drivers/mtd/chips/cfi_cmdset_0002.c:2547:(.xiptext+0x20b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2548:(.xiptext+0x20c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2550:(.xiptext+0x20d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2554:(.xiptext+0x20f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2557:(.xiptext+0x2104): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2557:(.xiptext+0x210c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
>> arch/xtensa/include/asm/current.h:24:(.xiptext+0x211c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x2130): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2560:(.xiptext+0x213f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2563:(.xiptext+0x2160): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2567:(.xiptext+0x2170): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2570:(.xiptext+0x2187): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2571:(.xiptext+0x2192): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2571:(.xiptext+0x219c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2571:(.xiptext+0x21a9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2574:(.xiptext+0x21b3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2cf4)
   drivers/mtd/chips/cfi_cmdset_0002.c:2574:(.xiptext+0x21bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2575:(.xiptext+0x21c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2575:(.xiptext+0x21c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/maps/map_funcs.o:drivers/mtd/maps/map_funcs.c:29:(.xiptext+0xe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_to':
   drivers/mtd/maps/map_funcs.c:29:(.xiptext+0x23): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/maps/map_funcs.c:29:(.xiptext+0x29): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:29:(.xiptext+0x32): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.o: in function `inline_map_copy_to':
   include/linux/mtd/map.h:440:(.xiptext+0x42): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   include/linux/mtd/map.h:440:(.xiptext+0x48): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_to':
   drivers/mtd/maps/map_funcs.c:31:(.xiptext+0x62): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x77): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x7d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x92): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_from':
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x9c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0xaa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0xb4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:25:(.xiptext+0xc2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   drivers/mtd/maps/map_funcs.c:25:(.xiptext+0xc8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:25:(.xiptext+0xce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/maps/map_funcs.o: in function `memcpy_fromio':
   include/asm-generic/io.h:1184:(.xiptext+0xfa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_from':
   include/asm-generic/io.h:1184:(.xiptext+0x10f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_from':
   drivers/mtd/maps/map_funcs.c:26:(.xiptext+0x115): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:26:(.xiptext+0x11e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x12a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x136): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x143): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write1
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x151): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x15a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x167): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write2
   drivers/mtd/maps/map_funcs.o: in function `simple_map_write':
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x175): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x17e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:19:(.xiptext+0x188): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/maps/map_funcs.c:20:(.xiptext+0x195): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:20:(.xiptext+0x19e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: panic
   drivers/mtd/maps/map_funcs.c:20:(.xiptext+0x1a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:20:(.xiptext+0x1ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_atomic_signal_fence
   drivers/mtd/maps/map_funcs.o: in function `inline_map_write':
   include/linux/mtd/map.h:414:(.xiptext+0x1b5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   include/linux/mtd/map.h:426:(.xiptext+0x216): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   include/linux/mtd/map.h:427:(.xiptext+0x22b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/maps/map_funcs.o: in function `simple_map_write':
   include/linux/mtd/map.h:427:(.xiptext+0x231): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.o: in function `simple_map_write':
   drivers/mtd/maps/map_funcs.c:21:(.xiptext+0x23a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.c:21:(.xiptext+0x246): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x252): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x25e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x26d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x276): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x282): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   drivers/mtd/maps/map_funcs.o: in function `simple_map_read':
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x291): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x29a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:14:(.xiptext+0x2a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/maps/map_funcs.c:15:(.xiptext+0x2b1): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:15:(.xiptext+0x2ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: panic
   drivers/mtd/maps/map_funcs.c:15:(.xiptext+0x2c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/maps/map_funcs.c:15:(.xiptext+0x2c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit


vim +381 include/linux/mtd/map.h

3a3ab48c68de65 Thomas Gleixner 2005-05-24  372  
^1da177e4c3f41 Linus Torvalds  2005-04-16  373  static inline map_word map_word_ff(struct map_info *map)
^1da177e4c3f41 Linus Torvalds  2005-04-16  374  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  375  	map_word r;
^1da177e4c3f41 Linus Torvalds  2005-04-16  376  	int i;
^1da177e4c3f41 Linus Torvalds  2005-04-16  377  
b0435695cb3b3e Thomas Gleixner 2005-05-25  378  	if (map_bankwidth(map) < MAP_FF_LIMIT) {
a8aff8ab981cc8 Thomas Gleixner 2005-05-25  379  		int bw = 8 * map_bankwidth(map);
7234bea69de200 Arnd Bergmann   2015-03-10  380  
a4d62babf988fe Wang Haitao     2013-08-22 @381  		r.x[0] = (1UL << bw) - 1;
3a3ab48c68de65 Thomas Gleixner 2005-05-24  382  	} else {
3a3ab48c68de65 Thomas Gleixner 2005-05-24  383  		for (i = 0; i < map_words(map); i++)
^1da177e4c3f41 Linus Torvalds  2005-04-16  384  			r.x[i] = ~0UL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  385  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  386  	return r;
^1da177e4c3f41 Linus Torvalds  2005-04-16  387  }
f77814dd5728ed Nicolas Pitre   2005-02-08  388  

:::::: The code at line 381 was first introduced by commit
:::::: a4d62babf988fe5dfde24437fa135ef147bc7aa0 mtd: map: fixed bug in 64-bit systems

:::::: TO: Wang Haitao <wang.haitao1@zte.com.cn>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

