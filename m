Return-Path: <linux-kernel+bounces-428558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68F9E1096
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5326C280F17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A0E1EA84;
	Tue,  3 Dec 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7io3Y33"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30C2500BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187777; cv=none; b=X/IA82f22RBEliDPOz49K7gX6rH2UFn1Dv0DEHiVIdfPOsr5zPu5eMb41gLe2LdE/PyzWhbFh/0/RvXCQQsmyPJz6u7FUMok5aNX727KVsdACijlvGGJGg0ZWPHwKEMGPTijxjvDASOihQjyukhTGuKbr5F43y32Xx6oCiQYB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187777; c=relaxed/simple;
	bh=RRZ06k3xf/DjZDjcKtLF27mvVXG8q2fEhu2aYIitcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDu+N+Ynk8e4cp083JoBENkXnoUqlTmqC/3qNMoRgNWr8cdsVMUTe5LzhllIBI0W+aCwjavxks7l2vJhdppJbJOjCQ3FMEDkSkB5NOXownFBn9jWpKwptHPtvRikNHmKYm+v9yfje4I1xSEWwAzevVfl9BVILK6bt/q7hiP3Ciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7io3Y33; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733187776; x=1764723776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRZ06k3xf/DjZDjcKtLF27mvVXG8q2fEhu2aYIitcoI=;
  b=X7io3Y3313PmEXTC2lGMM43SBRoJK97j6G8zRJLT/si17EjirztOFvaj
   Pzr92aAo7usNttKgyxc7gEntfxA4nXZwmTTFm9t/i+UdkRr3BSyB7WBVg
   aOXHBY1+00bEb5AN1pQu5OVxoK4k8D3GO/qI4nYjvT7Xth+S9w1ZnCYnr
   IKdk5pN6DO907P7kbt2nm9Zdp+RLPgm85qoV0Hj6d9cikQYgZCLdU4NSp
   z4E22UWS7eOi5V0wGyOIHLzDvkBsJucqX7znXMafFfNmGXf+B1aj17nH3
   IeIw/geKwIdwEt2OmC/uDlDxelNdEhhlrLWgM/M7JRGzdB2xfXtdfefkr
   g==;
X-CSE-ConnectionGUID: BcljcqVOSDSeE/r2KzcOvA==
X-CSE-MsgGUID: lXIhYTVyRP+JbeIA0hE51Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="55871243"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="55871243"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 17:02:55 -0800
X-CSE-ConnectionGUID: so1D1V53SGy36G3A3KnCKQ==
X-CSE-MsgGUID: RTbc51zATQW9HyBV+Zeknw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93680023"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 17:02:51 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIHJR-000365-1E;
	Tue, 03 Dec 2024 01:02:49 +0000
Date: Tue, 3 Dec 2024 09:02:14 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Schmidt <mschmidt@redhat.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Uwe =?unknown-8bit?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] pps: embed "dev" in the pps_device
Message-ID: <202412030824.tmsDhCFT-lkp@intel.com>
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
config: arm-randconfig-002-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030824.tmsDhCFT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030824.tmsDhCFT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030824.tmsDhCFT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/cdev.h:8,
                    from include/linux/pps_kernel.h:12,
                    from drivers/pps/clients/pps-ktimer.c:15:
   drivers/pps/clients/pps-ktimer.c: In function 'pps_ktimer_exit':
>> drivers/pps/clients/pps-ktimer.c:59:21: error: incompatible type for argument 1 of '_dev_info'
      59 |         dev_info(pps->dev, "ktimer PPS source unregistered\n");
         |                  ~~~^~~~~
         |                     |
         |                     struct device
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/pps/clients/pps-ktimer.c:59:9: note: in expansion of macro 'dev_info'
      59 |         dev_info(pps->dev, "ktimer PPS source unregistered\n");
         |         ^~~~~~~~
   include/linux/dev_printk.h:95:37: note: expected 'const struct device *' but argument is of type 'struct device'
      95 | void _dev_info(const struct device *dev, const char *fmt, ...)
         |                ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/pps/clients/pps-ktimer.c: In function 'pps_ktimer_init':
   drivers/pps/clients/pps-ktimer.c:77:21: error: incompatible type for argument 1 of '_dev_info'
      77 |         dev_info(pps->dev, "ktimer PPS source registered\n");
         |                  ~~~^~~~~
         |                     |
         |                     struct device
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/pps/clients/pps-ktimer.c:77:9: note: in expansion of macro 'dev_info'
      77 |         dev_info(pps->dev, "ktimer PPS source registered\n");
         |         ^~~~~~~~
   include/linux/dev_printk.h:95:37: note: expected 'const struct device *' but argument is of type 'struct device'
      95 | void _dev_info(const struct device *dev, const char *fmt, ...)
         |                ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_info +59 drivers/pps/clients/pps-ktimer.c

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

