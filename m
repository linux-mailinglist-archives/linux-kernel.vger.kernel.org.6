Return-Path: <linux-kernel+bounces-370140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6C9A285A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543C2285532
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8E1DEFFD;
	Thu, 17 Oct 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVwuBxWL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512461DEFC9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181799; cv=none; b=YKlMKCC0ac9x3Ns5GUoqTpVQZrUpKWmzM0JjzZuAzcMbuhG++OPUw+UCZrAoAUD5Un0dKIAcQneOQWb7FWDYhqq1W7W2FeNPe5VB5wHx4v6ebTJ7RluwOJSxrcJuDpJJjNdctVE2Mm1/g9/iqJoPHDQqdkX2PXY6F8d3f0zO038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181799; c=relaxed/simple;
	bh=HD75xGXTJsjGbgGGvfF8PuaL+fWVavu1u4+WgeEAtjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G/oxRp6f0adgYWu2+Rmcp9jcNYAl1Eb4xEOsa3G6StF92q3E0eDlb2B81D7uCK7AG3BqTd+BCZNn00XSOFSTQFqSehIV+85q5h4kaUm6+ecWKMljL9W3VLOyeKUlHSqGZdB67B04caxU/ML7ZtYWsayhcNhFeqkLkjUJyn17NGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVwuBxWL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729181793; x=1760717793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HD75xGXTJsjGbgGGvfF8PuaL+fWVavu1u4+WgeEAtjA=;
  b=NVwuBxWLMQ47F1T4dsHM6ohfsUpK1vNXQgbJKabcT0iIQtuVXjUX4KcF
   ooVZY7PHgZGkXs6sIUCnuYl06r3IMjSRu2W18VEIK01YAFddx0otOptgT
   wd75fWnNg+m5PR0pDkcaF6/0/Jw56rJeBw4eP+IUXFDAk7/QiFIFq1hPd
   NLMWUI5GXvtvh6hr8Sm80nah0j6P5VMJOGABfcd9dSi7YnhjsNQIiLjOd
   ryMKJfdNyLkmvivHraxhohgd2GIOEt2Bknt1eaXC7gQlY3BUlmN0vOjAD
   U7Ib04nMCQdl2ygBEQBXtP+vI4HSXZZS2xRpuoKeAa0sTR2qUKLo+PHld
   A==;
X-CSE-ConnectionGUID: eHxSsHeHQ5COpck6F5I1Kg==
X-CSE-MsgGUID: ZkYOdeNrTEKgfkLcB2Pe2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32364603"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32364603"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:16:33 -0700
X-CSE-ConnectionGUID: nkHz18hDRqGVcBkdFvGFDA==
X-CSE-MsgGUID: g34SwJKLS8eGNt2gW4L1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109406345"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 09:16:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1TAr-000MZJ-2L;
	Thu, 17 Oct 2024 16:16:29 +0000
Date: Fri, 18 Oct 2024 00:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202410180049.E04dChry-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c964ced7726294d40913f2127c3f185a92cb4a41
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   1 year ago
config: m68k-randconfig-r123-20241017 (https://download.01.org/0day-ci/archive/20241018/202410180049.E04dChry-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241018/202410180049.E04dChry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180049.E04dChry-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/m68k/sun3/sun3ints.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

