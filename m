Return-Path: <linux-kernel+bounces-425255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892E9DBF70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4BB228C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EC15886D;
	Fri, 29 Nov 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7nt4MMe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001415697B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861101; cv=none; b=FY5c7H3WwEs/S0Xmu2JN1P2Yj4asdhBiG0EkXtmsbWnkMeNlkT3r79fIo5LLH8Z05lZA5ZuZDAAaamVKZxwFntMJLZYyhIq1izGcpC3qfq0icRSJlUKV/qm2/+MVYESr8SvC4hieL3SfnpDrtPVXtfxqcE3i9OvFZiHigyaIv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861101; c=relaxed/simple;
	bh=WxpjQldJxswZJJ2TWRMT8rPTyvm9ml9McBhq7N2L0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HI86Y7zyKjoUFEOUHClTAmWzHVqe2RUf5VtqEJhqAXxjIMxLt7j3Nhwy6kcRUqKBg2w6BfKqiFcMWJt3g+lYRQaqeovDp7ixlQBq6zFej7Q7bLYQJ/j2540qOYv/U8umcdOOzTIUvRwkIuHn8DwwKHtLHXjPILFeszgkSTxHCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7nt4MMe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732861100; x=1764397100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WxpjQldJxswZJJ2TWRMT8rPTyvm9ml9McBhq7N2L0EE=;
  b=D7nt4MMei472dr0Yni3DuQ5xd628w0hFaXuLfDAOJhn8WOS5n5kLwO6X
   bjBbx/UdmjQMyc0CijFJAXyMEC/dfBcAgMhUEvttd1NkUdDoq1jPPzIpr
   2x3CzE9a4K4wAbQ08scibVgkUT5q2IERf3q2WHisXMx4jk4ZbCFoWZ0N9
   0sJirU04eUIXvMFGRT7vZOy48aSC27ONGGjiYCC0+1ZoS1SE5+glr3YuL
   kDf4ehtfci4t4wu308NzR0ibWohg4mWOO0g3LfY51SMCBCYvNpohioY7a
   fMiaNuaYiF9o4YJdMGaoMI2KH3t+57tSTWXqmoW7zNzLn4O6PPqTu+qfG
   g==;
X-CSE-ConnectionGUID: a0VYVFnrTAGCQq2F//Ht8g==
X-CSE-MsgGUID: ZJxEiguoTN2X3qdDMpW8Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33033113"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33033113"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 22:18:18 -0800
X-CSE-ConnectionGUID: XaEfN1cHT2Spap/KeXqXag==
X-CSE-MsgGUID: SnrKxRjESYeVci7bc8mfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="96830664"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Nov 2024 22:18:16 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGuKT-00003n-26;
	Fri, 29 Nov 2024 06:18:13 +0000
Date: Fri, 29 Nov 2024 14:17:47 +0800
From: kernel test robot <lkp@intel.com>
To: David Arinzon <darinzon@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>
Subject: drivers/net/ethernet/amazon/ena/ena_netdev.c:77 ena_tx_timeout()
 warn: inconsistent indenting
Message-ID: <202411291414.wG3ruDV0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08b57bcb9ebf78675c50069c54125c0a8b795
commit: 071271f39ce833a3534d1fbd47174d1bed6d9326 net: ena: Add more information on TX timeouts
date:   10 months ago
config: x86_64-randconfig-161-20241122 (https://download.01.org/0day-ci/archive/20241129/202411291414.wG3ruDV0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291414.wG3ruDV0-lkp@intel.com/

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

