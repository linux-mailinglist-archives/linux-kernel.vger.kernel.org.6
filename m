Return-Path: <linux-kernel+bounces-428595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E99E110B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FEB23284
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791513C67C;
	Tue,  3 Dec 2024 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="If0ZBvD7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7180035
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191483; cv=none; b=Wv62cVf/rBrCrBMbblfrGdUhnjsHhgB+dq+X3cyrXmQEJyXJeRyHA73OB7+8o3LgK+0xjMfFi5hLpIFwaecBFALoWW3eyOdYkNmUsjPHtN1j7FduOkKQaWMtEcVNsRbbXhNSlq98WscU2Oun/I6h8pOA/nFn8v/OZ8TmVLJfEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191483; c=relaxed/simple;
	bh=aZrmviilsvEZDeMEz8Oi+rFs521z/1qu21p6tkM0odw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbD2zkRckWoIfOHJ7mqoYBuiLqwViiJAlNOp/6Xv63CGITWM8GzRtcv6mpDVrOu+9Ic+JLWefBdLPOT5ozziX4pCSr+KubUgCnGJmibiRz4/ANYn/eIrMUYeMKWlY0L6wDlLPAsrkHQrTfO+16w4Xm2pBX7ts83i7etpkps4Sm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=If0ZBvD7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733191482; x=1764727482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aZrmviilsvEZDeMEz8Oi+rFs521z/1qu21p6tkM0odw=;
  b=If0ZBvD73QdKI6M22clZN0gMuzXWauZFZbgZibDKhVl00oL+JVIVdeLN
   RWPwH6fdL1vgDPaWL8kPs35XVOUPSXNn7kHjeEsiej6y59CEvzd5AbaJ3
   YWIaFKWbam82WCgV5a+T2uPTMnxUcT7v6LqSOG3wcvNLv2IQfoejqeVxQ
   eXVg0znkwijxPpPiJDWWCmCxuIxqz/vLGym2Dsor2Iwgt+szLwWwiW3Wx
   qZtdnKv/+ycLPsxWPoq0RqSvbcRI3mKdxH/HWRpxYb/2Akdx+ywfgIvEm
   O6DfHxdem0gKQzwAdGBWIjsK1aHkGuAGDt6j3cIEnER7RIbLwc9FoqxhA
   Q==;
X-CSE-ConnectionGUID: XDnjIMNGTCmYK/iYdk2DWg==
X-CSE-MsgGUID: VXGaAw+kRVihyojjubvz+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33535826"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33535826"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:04:41 -0800
X-CSE-ConnectionGUID: +3hlY5ufRvSmYM9wax/eHw==
X-CSE-MsgGUID: BGSUtcLxQzeCBSsdKvD/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97718699"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2024 18:04:37 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIH8-00039j-1o;
	Tue, 03 Dec 2024 02:04:32 +0000
Date: Tue, 3 Dec 2024 10:04:07 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Schmidt <mschmidt@redhat.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Uwe =?unknown-8bit?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] pps: embed "dev" in the pps_device
Message-ID: <202412030942.aHisJx3i-lkp@intel.com>
References: <20241202163451.1442566-6-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202163451.1442566-6-mschmidt@redhat.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7af08b57bcb9ebf78675c50069c54125c0a8b795]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Schmidt/pps-fix-cdev-use-after-free/20241203-025037
base:   7af08b57bcb9ebf78675c50069c54125c0a8b795
patch link:    https://lore.kernel.org/r/20241202163451.1442566-6-mschmidt%40redhat.com
patch subject: [PATCH 5/6] pps: embed "dev" in the pps_device
config: i386-buildonly-randconfig-005-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030942.aHisJx3i-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030942.aHisJx3i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030942.aHisJx3i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pps/clients/pps-ktimer.c:59:11: error: passing 'struct device' to parameter of incompatible type 'const struct device *'; take the address with &
      59 |         dev_info(pps->dev, "ktimer PPS source unregistered\n");
         |                  ^~~~~~~~
         |                  &
   include/linux/dev_printk.h:160:46: note: expanded from macro 'dev_info'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                     ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:56:37: note: passing argument to parameter 'dev' here
      56 | void _dev_info(const struct device *dev, const char *fmt, ...);
         |                                     ^
   drivers/pps/clients/pps-ktimer.c:77:11: error: passing 'struct device' to parameter of incompatible type 'const struct device *'; take the address with &
      77 |         dev_info(pps->dev, "ktimer PPS source registered\n");
         |                  ^~~~~~~~
         |                  &
   include/linux/dev_printk.h:160:46: note: expanded from macro 'dev_info'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                     ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:56:37: note: passing argument to parameter 'dev' here
      56 | void _dev_info(const struct device *dev, const char *fmt, ...);
         |                                     ^
   2 errors generated.


vim +59 drivers/pps/clients/pps-ktimer.c

697fb85fcf21b5 Rodolfo Giometti  2010-03-10  52  
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  53  /*
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  54   * Module staff
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  55   */
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  56  
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  57  static void __exit pps_ktimer_exit(void)
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  58  {
5e196d34a77642 Alexander Gordeev 2011-01-12 @59  	dev_info(pps->dev, "ktimer PPS source unregistered\n");
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  60  
5e196d34a77642 Alexander Gordeev 2011-01-12  61  	del_timer_sync(&ktimer);
5e196d34a77642 Alexander Gordeev 2011-01-12  62  	pps_unregister_source(pps);
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  63  }
697fb85fcf21b5 Rodolfo Giometti  2010-03-10  64  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

