Return-Path: <linux-kernel+bounces-366651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5B99F844
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F4F1F213F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E491F8186;
	Tue, 15 Oct 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqo+bFd9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F191B6CF3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025214; cv=none; b=Y4fUCKR9Z9FA5BtemrNkG2FjCd5JC6w6Whr1AW4gJp6HWvf16sfcvAfIJPDHg11jmArcZhO3EcGdmHSgIUTnqcpMjNzZI0eEDiK92d2aYEFUgE+RGq9RxAx4XwMKlYf39q66Buhb9KsBSt+TxKlnrcs9J0jRusK7l3XjX7529vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025214; c=relaxed/simple;
	bh=j3GtmwhKFyJfeeyHi+++6iBfpxuD/xvW8TWBFyVPnsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfVypB2N+w/Opz3cXmKswLUH/2rwfWdB3Vp83y24y/hrvsR07TS+8JMo+otCrWVr+05G13uZ5ChXd7Dgti4oS43jAgD4DCGhZuAEwC3bg+8EtDMJfRChAAxa+NWFE2+dnhKio1Z0KsmhepJ/NsBBfPUB5d2GkD41Oo/skksH6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqo+bFd9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729025213; x=1760561213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j3GtmwhKFyJfeeyHi+++6iBfpxuD/xvW8TWBFyVPnsk=;
  b=aqo+bFd9/jhdPghTj9pAFT3NDK4p79BAi0BwVBEMBOEwi6kATjfvixNj
   mgdyIn0Cax47e7xyiaq3vLJmFxL1neRdx+SDot/8pA0e10gKeZuLfgCuq
   vRbxX3YYkI4c5kKGVvXCSx7nJzIA9F95izpYI9/bv3IIsVFMQO423LPVW
   JQiCB5NXcrGVTxb0Z7Dohhd8iar0o/duu9a+IE3RoTQlaSCCudVsTVdFL
   OQ9Om5Uyufrudvfbz2GA/zno1zOQxuNFCsgoWnPRA2gWanqT/SNAwPCfU
   XBG4EuEC/EfrjAQgwMcXJCWjcKI6ImeXcOHf7SznvQek1OO0ql/YLXDGL
   w==;
X-CSE-ConnectionGUID: C8NxEH09Ra27XZuH7an1tg==
X-CSE-MsgGUID: DBjoZMnCR0iIpktpaoqu7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39078686"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39078686"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 13:46:52 -0700
X-CSE-ConnectionGUID: WDAobR3nTzqwxv22AgNFzw==
X-CSE-MsgGUID: vgqutLJFRCuptDVHZpbwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82814929"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 13:46:50 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0oRL-000JvP-1H;
	Tue, 15 Oct 2024 20:46:47 +0000
Date: Wed, 16 Oct 2024 04:46:32 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Martyn Welch <martyn.welch@collabora.com>,
	Hari Nagalla <hnagalla@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
Message-ID: <202410160435.WzzQa1p5-lkp@intel.com>
References: <20241014144821.15094-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014144821.15094-3-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/mailbox-ti-msgmgr-Remove-use-of-of_match_ptr-helper/20241014-225353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241014144821.15094-3-afd%40ti.com
patch subject: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
config: hexagon-randconfig-r131-20241015 (https://download.01.org/0day-ci/archive/20241016/202410160435.WzzQa1p5-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce: (https://download.01.org/0day-ci/archive/20241016/202410160435.WzzQa1p5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160435.WzzQa1p5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/ti_sci.c:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/firmware/ti_sci.c:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/firmware/ti_sci.c:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   drivers/firmware/ti_sci.c:200:20: warning: unused function 'ti_sci_debugfs_destroy' [-Wunused-function]
     200 | static inline void ti_sci_debugfs_destroy(struct platform_device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/ti_sci.c:3285:34: warning: unused variable 'ti_sci_of_match' [-Wunused-const-variable]
    3285 | static const struct of_device_id ti_sci_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~
   8 warnings generated.


vim +/ti_sci_of_match +3285 drivers/firmware/ti_sci.c

aa276781a64a5f Nishanth Menon 2016-10-18  3284  
aa276781a64a5f Nishanth Menon 2016-10-18 @3285  static const struct of_device_id ti_sci_of_match[] = {
aa276781a64a5f Nishanth Menon 2016-10-18  3286  	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
754c9477ae7872 Peter Ujfalusi 2019-04-30  3287  	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
aa276781a64a5f Nishanth Menon 2016-10-18  3288  	{ /* Sentinel */ },
aa276781a64a5f Nishanth Menon 2016-10-18  3289  };
aa276781a64a5f Nishanth Menon 2016-10-18  3290  MODULE_DEVICE_TABLE(of, ti_sci_of_match);
aa276781a64a5f Nishanth Menon 2016-10-18  3291  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

