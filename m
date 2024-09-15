Return-Path: <linux-kernel+bounces-329807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA3979641
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AB282B51
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77A1B85D7;
	Sun, 15 Sep 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceF77t0/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852643AD9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726394442; cv=none; b=lkDUICHW14S1T1ZD1CAbXlb9dcQP/0AYTCWqW+Yht8o2yDMD7rUFXlkKzSoBEn3QN5pWJpCHWiRfl7iRlTq/eNi8XJY0cy/R9jPdsyyHNLtOQVY/Eh5nwlh28WoKPa4u0hgJPkagvHwU60sAUsFp2TpY1K5/BZUX++z+xV5s4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726394442; c=relaxed/simple;
	bh=iFzJJ4Ek30AQN2LxHHHvScB7pn3YC0jc0GfCZSR1Ds4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uGrVP7bdgJ58qHmqp5iAwvbLCiPCOuH8Ew1tlNUm6l9h3ZWY8px76ez3UMh5W+7pQx5SOTxojNHLBfKl4Bh7S0Vx/Prf/Ci1B6nDYTEWrf55AC0mHJXXNrTrzduiJ+rU7D288xbuin7wUWPR5CsaLlZDTHu4Erkq4OxNjhsOpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceF77t0/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726394441; x=1757930441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iFzJJ4Ek30AQN2LxHHHvScB7pn3YC0jc0GfCZSR1Ds4=;
  b=ceF77t0/T3D+924SdSFMmhYbyMpwYQ0cC8BR/GPki5FKRZANZHM68z1a
   OKm9AL3vrh1kB7WymcfSTvUY33TohXVJ9c6mXsiMjRpJYnRR4cfaf6Waw
   HkpkDCWK4FwKDUs0Qb4eJ28cnBE2NE26c/Boybl//7+86wI8CO7xXGF2C
   T+dKcjtxRE0afbB6NFbDxwj3wEnDxb7gta1jL2edgS/SCmkZ9B1TmXb97
   7yFauwObk63+pAl63Cv7ZiDu8cOC7dkPvd/KIUPKIjOgt9NfjavnXtGtZ
   k54xzyDdkhxzJ31HHcs7ZUq3GiIWJ8nyFcGfxAS4X1DcWtT2smvBvudzu
   Q==;
X-CSE-ConnectionGUID: caYZ/WHZRmCsoYETC5sBEw==
X-CSE-MsgGUID: hJ6aAKuoTpuwlkWlQDsoHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="13532556"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="13532556"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 03:00:41 -0700
X-CSE-ConnectionGUID: Eb/KDcJkSEeMawOlj/IVnQ==
X-CSE-MsgGUID: IpNW3ezjR6+EtRgdbK16ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68464772"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2024 03:00:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spm3Y-0008b4-30;
	Sun, 15 Sep 2024 10:00:36 +0000
Date: Sun, 15 Sep 2024 17:59:55 +0800
From: kernel test robot <lkp@intel.com>
To: David Arinzon <darinzon@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>
Subject: drivers/net/ethernet/amazon/ena/ena_netdev.c:77 ena_tx_timeout()
 warn: inconsistent indenting
Message-ID: <202409152000.h6g4SVzs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 071271f39ce833a3534d1fbd47174d1bed6d9326 net: ena: Add more information on TX timeouts
date:   8 months ago
config: csky-randconfig-r073-20240915 (https://download.01.org/0day-ci/archive/20240915/202409152000.h6g4SVzs-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409152000.h6g4SVzs-lkp@intel.com/

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

