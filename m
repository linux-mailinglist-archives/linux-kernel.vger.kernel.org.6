Return-Path: <linux-kernel+bounces-560650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F7A607B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C0D3BF657
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5303A8F7;
	Fri, 14 Mar 2025 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z15e7nmM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420715223;
	Fri, 14 Mar 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922438; cv=none; b=SVNbBU1nz93WV9mATiNQPgmpGLCjI2DgQw2iYFvRcUF4ksR3+96Nrsw4UjPOrQVXC5GDNAsoSP7ZyI/MdvI4z7Z6nOhXckrrh16n6knJ8yTezuBjKGMP3h+1+lzYadYM8ilsU6+tVzaObHOoiIjcpebM7Nd041LKPgexVc2dWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922438; c=relaxed/simple;
	bh=OcG9u49WrKu3JlX28UJO1gB2f62enMW3n6sc0munZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXnCAWAhRWM1+G8CiY83ZNEkn8O1b5NdiiQ8d6++gbif/DBEKM1yP2xkIWoi91GXo9Z29AL2vWJ3/yd4LisE0IpEJJyaqViqmh3uBkLtGEJ2Ry4zvmoxvV7QCNznslRLN3FHI5Kqt6NLqZXyZCoAk75aIqcdhizsirBP05eovSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z15e7nmM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741922437; x=1773458437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OcG9u49WrKu3JlX28UJO1gB2f62enMW3n6sc0munZoE=;
  b=Z15e7nmMLfnB6Tu9Xr3vqvLV0QEzCLmaQqnhxQmuNJPvk9rA66Sg/nSv
   F4pQS//JKsUhRq7SKsA/VIjHaEkL0oipqA+Qqdteh2JOjHNWrjUWxfy8X
   XQxKcZBU1mbs+Ryvb01YwIaxWHk68+JaalSyZw9vTcF1f+opauEOUQ4YD
   JSyx0rAI8p77vjRXsgUsUfGMHkfEZLvnpb/yvcTY3E61nEy4KSCGgDAMD
   o3YCwCqTBdcyMmzITxlPgOp4sevGGHYn2nyQ8EWN3D0AbjeLKzTLaT/LR
   wFydZun4s/1Q9EMso/lJm2gj5xHNoieGrDfvQN+WHNJ/qCBk5XuiZvpNS
   w==;
X-CSE-ConnectionGUID: 9h++I4T9SCq0ca7Yz0g+Gw==
X-CSE-MsgGUID: t+g1lpg5Rfyhpukr7KH99g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53718421"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53718421"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 20:20:35 -0700
X-CSE-ConnectionGUID: e2cBkMs/RJKiQnEtDpUZ4A==
X-CSE-MsgGUID: z/YrGz/2Q5e85hZjXd2VEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126184273"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 20:20:33 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsvb4-000A5o-21;
	Fri, 14 Mar 2025 03:20:30 +0000
Date: Fri, 14 Mar 2025 11:19:30 +0800
From: kernel test robot <lkp@intel.com>
To: Subu Dwevedi <messigoatcr7nop@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
Message-ID: <202503141052.v7b9psFM-lkp@intel.com>
References: <20250312123055.1735-2-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312123055.1735-2-messigoatcr7nop@gmail.com>

Hi Subu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Subu-Dwevedi/hwmon-applesmc-add-MMIO-for-newer-macs/20250312-203248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250312123055.1735-2-messigoatcr7nop%40gmail.com
patch subject: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
config: x86_64-randconfig-122-20250313 (https://download.01.org/0day-ci/archive/20250314/202503141052.v7b9psFM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141052.v7b9psFM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141052.v7b9psFM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/applesmc.c:257:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:257:31: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:257:31: sparse:     got unsigned char [usertype] *
>> drivers/hwmon/applesmc.c:258:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:258:46: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:258:46: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:269:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:269:44: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:269:44: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:281:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:281:44: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:281:44: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:282:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:282:34: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:282:34: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:283:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:283:33: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:283:33: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:288:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:288:31: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:288:31: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:292:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:292:39: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:292:39: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:299:71: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:299:71: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:299:71: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:302:81: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:302:81: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:302:81: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:306:73: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:306:73: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:306:73: sparse:     got unsigned char [usertype] *
>> drivers/hwmon/applesmc.c:311:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:311:49: sparse:     expected void const volatile [noderef] __iomem *
   drivers/hwmon/applesmc.c:311:49: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:320:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:320:44: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:320:44: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:324:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:324:63: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:324:63: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:327:73: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:327:73: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:327:73: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:331:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:331:65: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:331:65: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:335:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:335:33: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:335:33: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:336:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:336:34: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:336:34: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:337:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:337:33: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:337:33: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:341:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:341:31: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:341:31: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:510:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:510:52: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:510:52: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:511:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:511:39: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:511:39: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:512:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:512:63: sparse:     expected void [noderef] __iomem *
   drivers/hwmon/applesmc.c:512:63: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:517:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:517:41: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:517:41: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:521:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:521:58: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:521:58: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:522:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:522:48: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:522:48: sparse:     got unsigned char [usertype] *
   drivers/hwmon/applesmc.c:523:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:523:50: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:523:50: sparse:     got unsigned char [usertype] *
>> drivers/hwmon/applesmc.c:740:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base @@     got void [noderef] __iomem * @@
   drivers/hwmon/applesmc.c:740:19: sparse:     expected unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base
   drivers/hwmon/applesmc.c:740:19: sparse:     got void [noderef] __iomem *
   drivers/hwmon/applesmc.c:745:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
   drivers/hwmon/applesmc.c:745:31: sparse:     expected void const [noderef] __iomem *
   drivers/hwmon/applesmc.c:745:31: sparse:     got unsigned char [usertype] *
>> drivers/hwmon/applesmc.c:757:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base @@
   drivers/hwmon/applesmc.c:757:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/applesmc.c:757:17: sparse:     got unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base
   drivers/hwmon/applesmc.c:1611:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base @@
   drivers/hwmon/applesmc.c:1611:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/applesmc.c:1611:25: sparse:     got unsigned char [usertype] *static [noderef] [toplevel] __iomem mmio_base
>> drivers/hwmon/applesmc.c:257:21: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:258:36: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:269:34: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:281:34: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:282:24: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:283:23: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:288:21: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:299:61: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:302:71: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:306:63: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:311:39: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:320:34: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:324:53: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:327:63: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:331:55: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:335:23: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:336:24: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:337:23: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:341:21: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:510:42: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:511:29: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:512:53: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:517:31: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:521:48: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:522:38: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:523:40: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:742:14: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:745:21: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:757:17: sparse: sparse: dereference of noderef expression
   drivers/hwmon/applesmc.c:1611:25: sparse: sparse: dereference of noderef expression

vim +257 drivers/hwmon/applesmc.c

   250	
   251	/*
   252	 * MMIO Impliementation
   253	 */
   254	
   255	static void clearArbitration(void)
   256	{
 > 257		if (ioread8(mmio_base + 0x4005))
 > 258			return iowrite8(0, mmio_base + 0x4005);
   259	}
   260	static int waitForKeyDone(void)
   261	{
   262		int i = 1000; //millisecounds
   263		u8 status;
   264	
   265		while (i) {
   266			msleep(1);
   267			i--;
   268	
   269			status = ioread8(mmio_base + 0x4005);
   270			if (status & 0x20)
   271				return 0;
   272		}
   273	
   274		return -EIO;
   275	}
   276	static int mmio_read_smc(u8 cmd, const char *key, u8 *buffer, u64 len)
   277	{
   278		u8 i, u = 0;
   279	
   280		clearArbitration();
   281		iowrite32(*((u32 *)key), mmio_base + 0x78);
   282		iowrite8(0x15, mmio_base + 0x7E);
   283		iowrite8(cmd, mmio_base + 0x7F);
   284	
   285		if (waitForKeyDone())
   286			return -EIO;
   287	
   288		i = ioread8(mmio_base + 0x7F);
   289		if (i)
   290			return -EIO;
   291		if (cmd == APPLESMC_READ_CMD) {
   292			i = ioread8(mmio_base + 0x7D);
   293			if (i > len || !i)
   294				return -EIO;
   295	
   296			while (u < i) {
   297				if ((i - u) < 4) {
   298					if ((i - u) < 2) {
   299						buffer[u] = ioread8(mmio_base + u);
   300						u += 1;
   301					} else {
   302						*(u16 *)&buffer[u] = ioread16(mmio_base + u);
   303						u += 2;
   304					}
   305				} else {
   306					*(u32 *)&buffer[u] = ioread32(mmio_base + u);
   307					u += 4;
   308				}
   309			}
   310		} else
 > 311			memcpy_fromio(buffer, mmio_base + 0x0, len);
   312	
   313		return 0;
   314	}
   315	static int mmio_write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
   316	{
   317		u8 i = 0;
   318	
   319		clearArbitration();
   320		iowrite32(*((u32 *)key), mmio_base + 0x78);
   321		while (i < len) {
   322			if (len - i < 4) {
   323				if (len - i < 2) {
   324					iowrite8(buffer[i], mmio_base + i);
   325					i += 1;
   326				} else {
   327					iowrite16(*(u16 *)&buffer[i], mmio_base + i);
   328					i += 2;
   329				}
   330			} else {
   331				iowrite32(*(u32 *)&buffer[i], mmio_base + i);
   332				i += 4;
   333			}
   334		}
   335		iowrite8(len, mmio_base + 0x7D);
   336		iowrite8(0x15, mmio_base + 0x7E);
   337		iowrite8(cmd, mmio_base + 0x7F);
   338		if (waitForKeyDone())
   339			return -EIO;
   340	
   341		i = ioread8(mmio_base + 0x7F);
   342		if (i)
   343			return -EIO;
   344	
   345		return 0;
   346	}
   347	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

