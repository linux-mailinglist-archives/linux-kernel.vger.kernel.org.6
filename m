Return-Path: <linux-kernel+bounces-213257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BF907335
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA7B21EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108291442EF;
	Thu, 13 Jun 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfN7y2mF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A599142E80;
	Thu, 13 Jun 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284385; cv=none; b=FQDTi+ISaPh+6a5ldJqiqb6U0P6+g0N14FHFUnySRP7MSmxil3cm4Hf+gaooxAKQmkJUbBj+IsXu3KvyXPpyeFeCl76iwc9Hfg+FZs/NSmjKfmESIBBZwucea+ImkG6htZpeza4d+C81ceQs4DbF1agOxl9v2saspJ4AjDywCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284385; c=relaxed/simple;
	bh=d0oHMSIHTigU1gymeFoZhBou2wsOGGK4qOlfl5NdwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT89C4IFKXKJem4YgkR9++evtmvBeDLknsKKvlAvgrjLiSf7aEPepwVMLfaaBxjS5V7/kEP8qNGJPWrXDYZ6Ub9axzWY4ssH7hcAj6MDrKAseU8Cb6fy+dsPF0AeyqsAqs/XSbaCYmxGyn3R8kPXxk2iHv1KEeq+HauJ+1k3PIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfN7y2mF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718284382; x=1749820382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0oHMSIHTigU1gymeFoZhBou2wsOGGK4qOlfl5NdwQ0=;
  b=MfN7y2mFHC0u/9DXM27K53GJZZbK5aFG9td17I5TOzRLdKIBKRSEPdug
   xehcFK68ukeyyY+ihCkFg0rgXXg97N+QobY1giymAL0GJdvhMZUZLkTMQ
   AwiCVRF4Y4A5DjwYhN0s/so6SIjovoLU2Qk7AuyTIGOKPa7Px7td9OvAF
   zssyHYJ144VJAjpQJBHov8c94IR/D1Uts5emOYqNM8lpb+d62/Ta/c7Gv
   mjEfXVSciALt9c1ArLBdykR/lFAWFB4dQNgMADlAmAjYzc5fdiI9HUPn0
   xIz2JetC23NNjtvaWl0vBZ6tjXW0Yicp0VbK+mH8BU3uPnKaQ5S/pI/8S
   Q==;
X-CSE-ConnectionGUID: DhdBztgUS7ezQPfXgzC1Zw==
X-CSE-MsgGUID: QYgUa9mKSV2hDCxZRtuzGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="37620715"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="37620715"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 06:13:02 -0700
X-CSE-ConnectionGUID: Xb9U0ZUkSD2pTT/lHGI2rg==
X-CSE-MsgGUID: wOuoz4gJTdyA/AV8K3+DpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40212758"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Jun 2024 06:12:59 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHkG8-00003S-1P;
	Thu, 13 Jun 2024 13:12:56 +0000
Date: Thu, 13 Jun 2024 21:12:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Ene <sebastianene@google.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com,
	Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v2 2/2] misc: Register a PPI for the vcpu stall detection
 virtual device
Message-ID: <202406132132.FBKSWFav-lkp@intel.com>
References: <20240611110136.2003137-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611110136.2003137-4-sebastianene@google.com>

Hi Sebastian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on soc/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/dt-bindings-vcpu_stall_detector-Add-a-PPI-interrupt-to-the-virtual-device/20240611-190759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240611110136.2003137-4-sebastianene%40google.com
patch subject: [PATCH v2 2/2] misc: Register a PPI for the vcpu stall detection virtual device
config: s390-randconfig-r112-20240613 (https://download.01.org/0day-ci/archive/20240613/202406132132.FBKSWFav-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240613/202406132132.FBKSWFav-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406132132.FBKSWFav-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/misc/vcpu_stall_detector.c:8:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/misc/vcpu_stall_detector.c:8:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/misc/vcpu_stall_detector.c:8:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/misc/vcpu_stall_detector.c:184:17: error: call to undeclared function 'irq_is_percpu_devid'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (irq > 0 && irq_is_percpu_devid(irq)) {
                          ^
   12 warnings and 1 error generated.


vim +/irq_is_percpu_devid +184 drivers/misc/vcpu_stall_detector.c

   139	
   140	static int vcpu_stall_detect_probe(struct platform_device *pdev)
   141	{
   142		int ret, irq;
   143		struct resource *r;
   144		void __iomem *membase;
   145		u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
   146		u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
   147		struct device_node *np = pdev->dev.of_node;
   148	
   149		vcpu_stall_detectors = devm_alloc_percpu(&pdev->dev,
   150							 typeof(struct vcpu_stall_priv));
   151		if (!vcpu_stall_detectors)
   152			return -ENOMEM;
   153	
   154		membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
   155		if (IS_ERR(membase)) {
   156			dev_err(&pdev->dev, "Failed to get memory resource\n");
   157			return PTR_ERR(membase);
   158		}
   159	
   160		if (!of_property_read_u32(np, "clock-frequency", &clock_freq_hz)) {
   161			if (!(clock_freq_hz > 0 &&
   162			      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
   163				dev_warn(&pdev->dev, "clk out of range\n");
   164				clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
   165			}
   166		}
   167	
   168		if (!of_property_read_u32(np, "timeout-sec", &stall_timeout_sec)) {
   169			if (!(stall_timeout_sec > 0 &&
   170			      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
   171				dev_warn(&pdev->dev, "stall timeout out of range\n");
   172				stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
   173			}
   174		}
   175	
   176		vcpu_stall_config = (struct vcpu_stall_detect_config) {
   177			.membase		= membase,
   178			.clock_freq_hz		= clock_freq_hz,
   179			.stall_timeout_sec	= stall_timeout_sec,
   180			.ppi_irq		= -1,
   181		};
   182	
   183		irq = platform_get_irq_optional(pdev, 0);
 > 184		if (irq > 0 && irq_is_percpu_devid(irq)) {
   185			ret = request_percpu_irq(irq,
   186						 vcpu_stall_detector_irq,
   187						 "vcpu_stall_detector",
   188						 vcpu_stall_detectors);
   189			if (ret)
   190				goto err;
   191	
   192			vcpu_stall_config.ppi_irq = irq;
   193		}
   194	
   195		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
   196					"virt/vcpu_stall_detector:online",
   197					start_stall_detector_cpu,
   198					stop_stall_detector_cpu);
   199		if (ret < 0) {
   200			dev_err(&pdev->dev, "failed to install cpu hotplug");
   201			goto err;
   202		}
   203	
   204		vcpu_stall_config.hp_online = ret;
   205		return 0;
   206	err:
   207		if (vcpu_stall_config.ppi_irq > 0)
   208			free_percpu_irq(vcpu_stall_config.ppi_irq,
   209					vcpu_stall_detectors);
   210		return ret;
   211	}
   212	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

