Return-Path: <linux-kernel+bounces-426629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F859DF5D5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2E2819EB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395F1D0E2B;
	Sun,  1 Dec 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBaEc9ng"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3391D0E07
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060583; cv=none; b=RyF0isVf/oB6XH68nJrlg9AVgXZtyYwvYW8Ukg8Rh8sTjjd+186PeadxaiXirXmnmybGkrwfj6fSO55JSoU4pWyLa6ZNjOxxa0YcsCHPMYd3oFJjeB8Mdv1QrrtaqfnRUcRMlMlLifEMDbFu79mcgtWy2l8N69Mfg8OcAcr7y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060583; c=relaxed/simple;
	bh=7XwjufTVus8fTmZaFPT5haYymTR1/z6hSUXrnhPZ2Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MPN5IvU7o3Rmhb7dkFS7gHSg1exhhiLTcGd69ThaIBGG0iOFHub9/2/kH5eFjqHX0hHAAQ+YCITZ8Y4+9DGpx0bU6ARK5tiCB5b/y9ovp7mPNdxJlcCO7EvTmXbju8NhALn0++JiLdQaaum+vkY/c3eSet+lmNhsF4ViDOS9OYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBaEc9ng; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733060582; x=1764596582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7XwjufTVus8fTmZaFPT5haYymTR1/z6hSUXrnhPZ2Lw=;
  b=ZBaEc9ngLosfBxR3wPK5QwQ8Gk9PDGa3XPPVKJkX5jQdbtcHuRM8lmHl
   m5xepiALW2YzuJMjzjs/o4zReEqV8yN1NW4uHv+vgWyaSwDILf9MfgAs9
   3afxy3jsHd41mXY2AlUskvMUq9WwjGejQVZPeJyZuX79wIwWU2uviRffL
   Zr2c4fSK6fjwZmu8SjWzD4yJaPo3i4HXPCIgzV8o+dHpFCWXITjVpCuzx
   oV39V0tizswysrRqG213w0MHoI0SvPhPsQkn430Gnb8bSYhRmgtdGw714
   Hdo10q9ssA4IBazVV86peEzjGLn471mxqVEbsUstQBGeZi0Fw5ds0Vres
   Q==;
X-CSE-ConnectionGUID: 8NS47z+6TzmA+DFjJpLGmg==
X-CSE-MsgGUID: 1dfEAHSZSCyMeTbt0CTX8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33285509"
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="33285509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 05:43:01 -0800
X-CSE-ConnectionGUID: vX3wXqKxSCK9AZF1K/tL7Q==
X-CSE-MsgGUID: nJrGzh/CQVe8qJMt5sZPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="92972507"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 01 Dec 2024 05:42:59 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHkDx-0001Z3-1C;
	Sun, 01 Dec 2024 13:42:57 +0000
Date: Sun, 1 Dec 2024 21:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: David Arinzon <darinzon@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>
Subject: drivers/net/ethernet/amazon/ena/ena_netdev.c:77 ena_tx_timeout()
 warn: inconsistent indenting
Message-ID: <202412012100.tEFoTQaX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
commit: 071271f39ce833a3534d1fbd47174d1bed6d9326 net: ena: Add more information on TX timeouts
date:   10 months ago
config: x86_64-randconfig-161-20241122 (https://download.01.org/0day-ci/archive/20241201/202412012100.tEFoTQaX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412012100.tEFoTQaX-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/amazon/ena/ena_netdev.c:77 ena_tx_timeout() warn: inconsistent indenting

vim +77 drivers/net/ethernet/amazon/ena/ena_netdev.c

    47	
    48	static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
    49	{
    50		enum ena_regs_reset_reason_types reset_reason = ENA_REGS_RESET_OS_NETDEV_WD;
    51		struct ena_adapter *adapter = netdev_priv(dev);
    52		unsigned int time_since_last_napi, threshold;
    53		struct ena_ring *tx_ring;
    54		int napi_scheduled;
    55	
    56		if (txqueue >= adapter->num_io_queues) {
    57			netdev_err(dev, "TX timeout on invalid queue %u\n", txqueue);
    58			goto schedule_reset;
    59		}
    60	
    61		threshold = jiffies_to_usecs(dev->watchdog_timeo);
    62		tx_ring = &adapter->tx_ring[txqueue];
    63	
    64		time_since_last_napi = jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
    65		napi_scheduled = !!(tx_ring->napi->state & NAPIF_STATE_SCHED);
    66	
    67		netdev_err(dev,
    68			   "TX q %d is paused for too long (threshold %u). Time since last napi %u usec. napi scheduled: %d\n",
    69			   txqueue,
    70			   threshold,
    71			   time_since_last_napi,
    72			   napi_scheduled);
    73	
    74		if (threshold < time_since_last_napi && napi_scheduled) {
    75			netdev_err(dev,
    76				   "napi handler hasn't been called for a long time but is scheduled\n");
  > 77				   reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
    78		}
    79	schedule_reset:
    80		/* Change the state of the device to trigger reset
    81		 * Check that we are not in the middle or a trigger already
    82		 */
    83		if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
    84			return;
    85	
    86		ena_reset_device(adapter, reset_reason);
    87		ena_increase_stat(&adapter->dev_stats.tx_timeout, 1, &adapter->syncp);
    88	}
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

