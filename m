Return-Path: <linux-kernel+bounces-328335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3753978231
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF47285513
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848F1DCB24;
	Fri, 13 Sep 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL+2S0C2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2F1DCB0A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236241; cv=none; b=utXhB6JWqneCXUw85U5n1+qY95wg9GpeDPxEXzqnls2sf8N4IuXFloO5GKUCua0/SNOzgTXCVacIDeObiH+7un9ZOhfmddFKHLK8RmOm4TUpYyZM4z2dZvw7Kych0R/z52GsFxKgpAzy7TQMDiP4QuMc/hSYZgD/JSJjldvwQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236241; c=relaxed/simple;
	bh=oAWsuUUJ5Y00qoIELcyG3wd1465N2OzwrLCkJX2zUZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+IHMUxAj8rc1iidbUsfAbbtRwlgjkV6rIwbs9zLvsGr+4528swBHqUQ0rRXXw+O7Tm7nw89bdlEmt5/ANUu1ycP33kuhidivOZLA2WvFKQMLdIJpoewU2aIjWKirRFlWHK6/UWH1ZvOykGjxLUkrLQcDy+eKKu7muOmu1YJ5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL+2S0C2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726236240; x=1757772240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAWsuUUJ5Y00qoIELcyG3wd1465N2OzwrLCkJX2zUZM=;
  b=XL+2S0C2+Ta67d6f1KQTdI6P2M7FRbwACSpTnW16S8zn3OR2sm0O6mMU
   LVsIpI8W7EUfhpOcnCGhO5HXzH24Q2VCRs92vo9JIrXUuy9hgOI7hXGVd
   JpCoCaR1Ntx+XrE5IwM3s4x2TdyIdYa7zuNKQYK/vSyBX6SuQHKRbhkrF
   mEJ8jTpH2VqmlUgveKC4R+8KMpzvyg2fY1nY56AG7nemVc8YQwTHLqWkj
   oXmR7YFxl23i876jNGG1LCKu2t4hOfDIwUIJX3KWelyUER2zIIOtfDXEt
   43IhBMqcqHf7MTA2m+U2WpfmOqVQRlFw8ra0H1TINB3Ubk9S2cGhjHMNI
   w==;
X-CSE-ConnectionGUID: rg3SNjQ1TESIVvZ8Kar8Nw==
X-CSE-MsgGUID: pl69AoG3RjydCr5v1DMK6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28883005"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28883005"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:03:59 -0700
X-CSE-ConnectionGUID: WpRz/hMYTBSRPLwLcDW24w==
X-CSE-MsgGUID: XewqBxMuTReB0mac/EYPoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68567380"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 07:03:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp6tv-0006YU-1F;
	Fri, 13 Sep 2024 14:03:55 +0000
Date: Fri, 13 Sep 2024 22:03:02 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Use new initialization api for tasklet
Message-ID: <202409132123.Kfncs3AN-lkp@intel.com>
References: <20240912172231.369566-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912172231.369566-1-abhishektamboli9@gmail.com>

Hi Abhishek,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Tamboli/staging-octeon-Use-new-initialization-api-for-tasklet/20240913-012448
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240912172231.369566-1-abhishektamboli9%40gmail.com
patch subject: [PATCH] staging: octeon: Use new initialization api for tasklet
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240913/202409132123.Kfncs3AN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409132123.Kfncs3AN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409132123.Kfncs3AN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel_stat.h:8,
                    from include/linux/cgroup.h:25,
                    from include/net/netprio_cgroup.h:11,
                    from include/linux/netdevice.h:42,
                    from drivers/staging/octeon/ethernet-tx.c:10:
>> drivers/staging/octeon/ethernet-tx.c:44:52: error: initialization of 'void (*)(struct tasklet_struct *)' from incompatible pointer type 'void (*)(struct tasklet_struct)' [-Wincompatible-pointer-types]
      44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/interrupt.h:665:21: note: in definition of macro 'DECLARE_TASKLET'
     665 |         .callback = _callback,                          \
         |                     ^~~~~~~~~
   drivers/staging/octeon/ethernet-tx.c:44:52: note: (near initialization for 'cvm_oct_tx_cleanup_tasklet.<anonymous>.callback')
      44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/interrupt.h:665:21: note: in definition of macro 'DECLARE_TASKLET'
     665 |         .callback = _callback,                          \
         |                     ^~~~~~~~~


vim +44 drivers/staging/octeon/ethernet-tx.c

  > 10	#include <linux/netdevice.h>
    11	#include <linux/etherdevice.h>
    12	#include <linux/ip.h>
    13	#include <linux/ratelimit.h>
    14	#include <linux/string.h>
    15	#include <linux/interrupt.h>
    16	#include <net/dst.h>
    17	#ifdef CONFIG_XFRM
    18	#include <linux/xfrm.h>
    19	#include <net/xfrm.h>
    20	#endif /* CONFIG_XFRM */
    21	
    22	#include <linux/atomic.h>
    23	#include <net/sch_generic.h>
    24	
    25	#include "octeon-ethernet.h"
    26	#include "ethernet-defines.h"
    27	#include "ethernet-tx.h"
    28	#include "ethernet-util.h"
    29	
    30	#define CVM_OCT_SKB_CB(skb)	((u64 *)((skb)->cb))
    31	
    32	/*
    33	 * You can define GET_SKBUFF_QOS() to override how the skbuff output
    34	 * function determines which output queue is used. The default
    35	 * implementation always uses the base queue for the port. If, for
    36	 * example, you wanted to use the skb->priority field, define
    37	 * GET_SKBUFF_QOS as: #define GET_SKBUFF_QOS(skb) ((skb)->priority)
    38	 */
    39	#ifndef GET_SKBUFF_QOS
    40	#define GET_SKBUFF_QOS(skb) 0
    41	#endif
    42	
    43	static void cvm_oct_tx_do_cleanup(struct tasklet_struct clean);
  > 44	static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

