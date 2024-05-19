Return-Path: <linux-kernel+bounces-183079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A98C943A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643B71C20B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4E25779;
	Sun, 19 May 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfQ7MtLq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD72748F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716111437; cv=none; b=VolOFUoBY3Kw0jDa/AtGsMhNlPcJfcTHaTXtnxEjpoIwzSXMVvWImpmnJVK7H7Qi89n3IJ/uKEJlVLfOv3h0VWUwTUt6kAPB5CcmB31BikOLEcvUkyd4v4FL96mEy88kspHhZWfTqbFAx4cF7UXLv8ryD6RacFHLO5RNzQW2zL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716111437; c=relaxed/simple;
	bh=FfshlQOvtmMuOFZ63uE2BLu7iCOeVHmxWdo760FUxwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q0ukCjEQP0H+lyU5Sy91W2tfzs7QNlsO0nQ1nUasR7SZF6u6SuuXwAWTFnyw6EPQo5KuSQ2cYkXVi52hzawUt+X5zOacrOWHbLipfqQr0Tr9zzL0lulHrKODPHYrPD9gInjDFTx2Xx+9W50SPoXKU7GCWOvzOf3Yv/P55UXxjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfQ7MtLq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716111433; x=1747647433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FfshlQOvtmMuOFZ63uE2BLu7iCOeVHmxWdo760FUxwo=;
  b=EfQ7MtLqW+n4+xOlYZHETG/Pol4c4r1buH8qiOPylDwWvkaMr7P59bYC
   F4QICtQNNPcN36FxIQODMIh3WrItBaZy7VEtyZgV5UmLfvdkClrMegIAB
   koth9e83UF50YCreByE882WdEbXhsEocyi5IqSkVHq4OkHH5mTccsTReE
   dGEshej4rvCnzvD+a4JIfsLE9AOo/g8vY3qlzOU1zWysAklFz8O/HvO4L
   SIrIlP58aCvg6n4pACKg/33aDBgQnOkB6v4evY+jb8PSM5fG20qwhzXu4
   UiwVTX8McR2VcJ3UG/pMt8PwxK4enx6BLB/D/nPi7JhajZfzvaNEsQV2X
   A==;
X-CSE-ConnectionGUID: yEG9OnIJRN6kBAFZqJzieg==
X-CSE-MsgGUID: nXiYSAhZS52gEyZS9MQ4Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12467041"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="12467041"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 02:37:13 -0700
X-CSE-ConnectionGUID: EwVv7yGZQ9aFlathT5DI2A==
X-CSE-MsgGUID: /3LAntKPR9WqSeA7zGBPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="32259452"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2024 02:37:10 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8cvo-0003KZ-0J;
	Sun, 19 May 2024 09:35:11 +0000
Date: Sun, 19 May 2024 17:28:13 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x15e0):
 dangerous relocation: windowed longcall crosses 1GB boundary; return may
 fail: trace_hardirqs_off
Message-ID: <202405191713.IFLymYla-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0450d2083be6bdcd18c9535ac50c55266499b2df
commit: 2416a2e7be9b27157f173268f5c7f769bd72a8dc mtd: chips: remove redundant assignment to variable timeo
date:   3 months ago
config: xtensa-randconfig-r011-20230429 (https://download.01.org/0day-ci/archive/20240519/202405191713.IFLymYla-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240519/202405191713.IFLymYla-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405191713.IFLymYla-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:1782:(.xiptext+0xfdc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1790:(.xiptext+0xfee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1790:(.xiptext+0xff7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: panic
   drivers/mtd/chips/cfi_cmdset_0002.c:1790:(.xiptext+0xffd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:1804:(.xiptext+0x1023): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:1807:(.xiptext+0x1039): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1809:(.xiptext+0x1046): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1811:(.xiptext+0x1054): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x1088): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x1090): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16c4)
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x10dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x110f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x1143): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2023:(.xiptext+0x1154): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2029:(.xiptext+0x115c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2033:(.xiptext+0x1174): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x1182): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1810)
   drivers/mtd/chips/cfi_cmdset_0002.c:2034:(.xiptext+0x118e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2035:(.xiptext+0x1198): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2036:(.xiptext+0x11a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2039:(.xiptext+0x11ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_load':
   include/linux/mtd/map.h:325:(.xiptext+0x11b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:326:(.xiptext+0x11c5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:327:(.xiptext+0x11cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:328:(.xiptext+0x11dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:329:(.xiptext+0x11fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   include/linux/mtd/map.h:329:(.xiptext+0x1202): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:330:(.xiptext+0x1208): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_off
   include/linux/mtd/map.h:330:(.xiptext+0x120e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:330:(.xiptext+0x1220): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x1238): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2045:(.xiptext+0x1250): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1268): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1026:(.xiptext+0x1280): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2048:(.xiptext+0x1296): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2057:(.xiptext+0x12e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2058:(.xiptext+0x12ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2058:(.xiptext+0x12fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x130b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_load':
   include/linux/mtd/map.h:325:(.xiptext+0x131b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   include/linux/mtd/map.h:325:(.xiptext+0x132b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   include/linux/mtd/map.h:326:(.xiptext+0x1331): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:328:(.xiptext+0x1356): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   include/linux/mtd/map.h:328:(.xiptext+0x135e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   include/linux/mtd/map.h:329:(.xiptext+0x1364): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   include/linux/mtd/map.h:329:(.xiptext+0x1370): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   include/linux/mtd/map.h:330:(.xiptext+0x137a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   include/linux/mtd/map.h:330:(.xiptext+0x1383): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:330:(.xiptext+0x1396): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp1
   include/linux/mtd/map.h:330:(.xiptext+0x139f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   include/linux/mtd/map.h:338:(.xiptext+0x13b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2063:(.xiptext+0x13d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x13d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x13e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x920)
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x13f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x1400): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2073:(.xiptext+0x1412): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2073:(.xiptext+0x141b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2073:(.xiptext+0x1427): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2074:(.xiptext+0x1430): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2081:(.xiptext+0x1448): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2082:(.xiptext+0x1457): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2086:(.xiptext+0x1470): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2087:(.xiptext+0x1480): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2089:(.xiptext+0x1498): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2091:(.xiptext+0x14a5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x14af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16c4)
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x14b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x14bd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x14ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x151b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x152c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x1535): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x154a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x1558): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1810)
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x1564): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x156e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x1576): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x1581): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x158b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x159c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x15a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2092:(.xiptext+0x15b4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x15d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2516:(.xiptext+0x15da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `current_thread_info':
>> arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x15e0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2514:(.xiptext+0x15e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0x15fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   include/linux/mtd/map.h:381:(.xiptext+0x1612): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2523:(.xiptext+0x1627): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2524:(.xiptext+0x163c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2526:(.xiptext+0x1650): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2533:(.xiptext+0x1666): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `arch_local_irq_save':
   arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0x16ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1026:(.xiptext+0x16b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:1026:(.xiptext+0x16c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2548:(.xiptext+0x16d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x16e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x16f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x16f9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2540:(.xiptext+0x171e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x1726): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x172c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x1738): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x1742): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2542:(.xiptext+0x174c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2543:(.xiptext+0x175e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp1
   drivers/mtd/chips/cfi_cmdset_0002.c:2546:(.xiptext+0x1766): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2547:(.xiptext+0x1784): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2557:(.xiptext+0x179c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2557:(.xiptext+0x17a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2557:(.xiptext+0x17b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x920)
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x17be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x17cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x17e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x17eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2559:(.xiptext+0x17f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
>> arch/xtensa/include/asm/current.h:24:(.xiptext+0x1800): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2561:(.xiptext+0x1818): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2563:(.xiptext+0x1827): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2567:(.xiptext+0x1840): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0002.c:2567:(.xiptext+0x1850): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2570:(.xiptext+0x186b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2574:(.xiptext+0x1878): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0002.c:2574:(.xiptext+0x1882): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16c4)
   drivers/mtd/chips/cfi_cmdset_0002.c:2574:(.xiptext+0x188a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2575:(.xiptext+0x1890): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `fixup_convert_atmel_pri':
   drivers/mtd/chips/cfi_cmdset_0001.c:210:(.text+0xa9b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_setup':
   drivers/mtd/chips/cfi_cmdset_0001.c:695:(.text+0x2dfe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xacc)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_cmdset_0001':
   drivers/mtd/chips/cfi_cmdset_0001.c:533:(.text+0x2f00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xacc)
   drivers/mtd/chips/cfi_cmdset_0001.c:587:(.text+0x309a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xacc)
   drivers/mtd/chips/cfi_cmdset_0001.c:610:(.text+0x31eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xacc)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_sync':
   drivers/mtd/chips/cfi_cmdset_0001.c:2082:(.text+0x3324): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xacc)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_read':
   drivers/mtd/chips/cfi_cmdset_0001.c:1550:(.text+0x3462): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xe0c)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_point_onechip':
   drivers/mtd/chips/cfi_cmdset_0001.c:1390:(.text+0x382e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x15e0)
   drivers/mtd/chips/cfi_cmdset_0001.o:(.xiptext+0x3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.o:(.xiptext+0xf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.o:(.xiptext+0x1a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1136:(.xiptext+0x24): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1136:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1136:(.xiptext+0x3c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1135:(.xiptext+0x50): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1137:(.xiptext+0x60): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_on
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x9a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xb0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xbf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xcd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xe2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xeb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0xf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x106): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x10f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x13c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x147): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x153): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x167): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x170): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x17f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x188): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x197): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x1a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x1af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x1c7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x1de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x1f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_wait_for_operation':
   drivers/mtd/chips/cfi_cmdset_0001.c:1162:(.xiptext+0x202): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1164:(.xiptext+0x21b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1170:(.xiptext+0x224): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1171:(.xiptext+0x233): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x23c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x246): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x24c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x25a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x267): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x274): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1177:(.xiptext+0x27e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1177:(.xiptext+0x284): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1177:(.xiptext+0x292): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1177:(.xiptext+0x29f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1177:(.xiptext+0x2ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1178:(.xiptext+0x2c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1178:(.xiptext+0x2d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1178:(.xiptext+0x2e0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1179:(.xiptext+0x2fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1191:(.xiptext+0x30f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1192:(.xiptext+0x328): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_on
   drivers/mtd/chips/cfi_cmdset_0001.c:1192:(.xiptext+0x33a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1195:(.xiptext+0x348): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0001.c:1195:(.xiptext+0x34e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0001.c:1195:(.xiptext+0x358): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1195:(.xiptext+0x368): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1204:(.xiptext+0x373): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1205:(.xiptext+0x386): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_const_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1208:(.xiptext+0x392): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x3b5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x3d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0001.c:1210:(.xiptext+0x3e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0001.c:1210:(.xiptext+0x3f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0001.c:1210:(.xiptext+0x3fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1213:(.xiptext+0x418): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.c:1213:(.xiptext+0x420): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1213:(.xiptext+0x426): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x432): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x43c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1218:(.xiptext+0x44a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_cmp4
   drivers/mtd/chips/cfi_cmdset_0001.c:1220:(.xiptext+0x463): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1220:(.xiptext+0x469): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_off
   drivers/mtd/chips/cfi_cmdset_0001.c:1220:(.xiptext+0x46f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_cmdset_0001.c:1221:(.xiptext+0x47e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd


vim +97 arch/xtensa/include/asm/thread_info.h

9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   92  
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   93  /* how to get the thread information struct from C */
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   94  static inline struct thread_info *current_thread_info(void)
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   95  {
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   96  	struct thread_info *ti;
f4431396be5b26 arch/xtensa/include/asm/thread_info.h Max Filippov 2017-12-04  @97  	 __asm__("extui %0, a1, 0, "__stringify(CURRENT_SHIFT)"\n\t"
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   98  	         "xor %0, a1, %0" : "=&r" (ti) : );
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   99  	return ti;
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23  100  }
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23  101  

:::::: The code at line 97 was first introduced by commit
:::::: f4431396be5b26a9960daf502d129b1b5d126f5e xtensa: consolidate kernel stack size related definitions

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Max Filippov <jcmvbkbc@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

