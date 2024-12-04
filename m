Return-Path: <linux-kernel+bounces-431330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D065A9E3C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5592B39B31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416871F8AC0;
	Wed,  4 Dec 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jS83zOJb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1C1F668A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321041; cv=none; b=k8xNSXFu5B9U7UZ81cirTvmOmMW8gS376nVSKYreHF8MIQrB+LUy5/ZAX2UavT6bDch7Rz5//YFDi+l2/+MwxpjSwYBCe4fEruGiI7WornivlAgldZgWZIaWvk83BV5c2yRE/8Zk8XJzuxb3/05PUA7hPVkffwKYnBoRgz0sSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321041; c=relaxed/simple;
	bh=MhiQkr0HjTqtkm+UreCdHu8O4JeAK81l4RKQDElTZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r2wEHw+G0XHjrEbJIztIGNSpew90lU9qOsRg95XmSmrp3wl9GdNNAZmIPgB7ChYg22ucWJImW1IrgHZlUKX+a81WXLBHM93++gRqJ50o/FE2PZ9/grix+izm439d9jqhn/zLrSFtBgcj43BFTlWFQ4ou9X5CX9A2w7VKAa2FFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS83zOJb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321039; x=1764857039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MhiQkr0HjTqtkm+UreCdHu8O4JeAK81l4RKQDElTZM8=;
  b=jS83zOJbK+n14z7lMZAWEZWCL8bBs98WPZKHL6askaXZzcMSPX5XsqDq
   oAftzXa1Nv0RcSpUc05XgQV5axbiGaiOcrIJDgg1vemoR3gvPCBx5/OrE
   qKxcVduACae8746X3bV0D9ZeddaNHRXBW1TQe0dAWV+GR04pk3R2LvvlR
   gN8B0LvFGqtbP4zYlLI+FiSe+PRC3cu+58ejtBJZ58HDYnJa+rCTpJwr/
   3hL81RJFV6IZWqdc+5BUZqz6W3mrDIGCYPDFOzaXWE0BNUvXGnGcEwvNV
   Tr1bFHSklGGiMcSyI4G/KCqHPm/dX9d5JeXvhjl7vL0+wfPS1NBU/ckox
   w==;
X-CSE-ConnectionGUID: N+aihJG7S/auxsKOnFMs3w==
X-CSE-MsgGUID: cikcrJsOTUa/uLdVpfq9wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44617547"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44617547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:03:58 -0800
X-CSE-ConnectionGUID: R4i/M82mQBK+dDcehN2TYw==
X-CSE-MsgGUID: hPx3zU8uQlqMYwuSBg5mvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94600325"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Dec 2024 06:03:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIpys-00035H-2J;
	Wed, 04 Dec 2024 14:03:54 +0000
Date: Wed, 4 Dec 2024 22:03:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Alex Maftei (amaftei)" <amaftei@solarflare.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/sfc/ethtool_common.c:170:32: warning: '%-24s'
 directive output may be truncated writing between 24 and 31 bytes into a
 region of size between 0 and 25
Message-ID: <202412042129.kPNOwHP4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: 3653954da498fc80c5da3642ae3f8d8168d7f820 sfc: move some ethtool code
date:   4 years, 11 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20241204/202412042129.kPNOwHP4-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412042129.kPNOwHP4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042129.kPNOwHP4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/sfc/ethtool_common.c:150:6: warning: no previous prototype for 'efx_fill_test' [-Wmissing-prototypes]
     150 | void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
         |      ^~~~~~~~~~~~~
   drivers/net/ethernet/sfc/ethtool_common.c:192:5: warning: no previous prototype for 'efx_fill_loopback_test' [-Wmissing-prototypes]
     192 | int efx_fill_loopback_test(struct efx_nic *efx,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/ethtool_common.c:296:8: warning: no previous prototype for 'efx_describe_per_queue_stats' [-Wmissing-prototypes]
     296 | size_t efx_describe_per_queue_stats(struct efx_nic *efx, u8 *strings)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/ethtool_common.c: In function 'efx_fill_test':
>> drivers/net/ethernet/sfc/ethtool_common.c:170:32: warning: '%-24s' directive output may be truncated writing between 24 and 31 bytes into a region of size between 0 and 25 [-Wformat-truncation=]
     170 |                          "%-6s %-24s", unit_str, test_str);
         |                                ^~~~~             ~~~~~~~~
   drivers/net/ethernet/sfc/ethtool_common.c:168:17: note: 'snprintf' output between 32 and 64 bytes into a destination of size 32
     168 |                 snprintf(strings + test_index * ETH_GSTRING_LEN,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     169 |                          ETH_GSTRING_LEN,
         |                          ~~~~~~~~~~~~~~~~
     170 |                          "%-6s %-24s", unit_str, test_str);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +170 drivers/net/ethernet/sfc/ethtool_common.c

   136	
   137	/**
   138	 * efx_fill_test - fill in an individual self-test entry
   139	 * @test_index:		Index of the test
   140	 * @strings:		Ethtool strings, or %NULL
   141	 * @data:		Ethtool test results, or %NULL
   142	 * @test:		Pointer to test result (used only if data != %NULL)
   143	 * @unit_format:	Unit name format (e.g. "chan\%d")
   144	 * @unit_id:		Unit id (e.g. 0 for "chan0")
   145	 * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
   146	 * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
   147	 *
   148	 * Fill in an individual self-test entry.
   149	 */
   150	void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
   151			   int *test, const char *unit_format, int unit_id,
   152			   const char *test_format, const char *test_id)
   153	{
   154		char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
   155	
   156		/* Fill data value, if applicable */
   157		if (data)
   158			data[test_index] = *test;
   159	
   160		/* Fill string, if applicable */
   161		if (strings) {
   162			if (strchr(unit_format, '%'))
   163				snprintf(unit_str, sizeof(unit_str),
   164					 unit_format, unit_id);
   165			else
   166				strcpy(unit_str, unit_format);
   167			snprintf(test_str, sizeof(test_str), test_format, test_id);
   168			snprintf(strings + test_index * ETH_GSTRING_LEN,
   169				 ETH_GSTRING_LEN,
 > 170				 "%-6s %-24s", unit_str, test_str);
   171		}
   172	}
   173	
   174	#define EFX_CHANNEL_NAME(_channel) "chan%d", _channel->channel
   175	#define EFX_TX_QUEUE_NAME(_tx_queue) "txq%d", _tx_queue->queue
   176	#define EFX_RX_QUEUE_NAME(_rx_queue) "rxq%d", _rx_queue->queue
   177	#define EFX_LOOPBACK_NAME(_mode, _counter)			\
   178		"loopback.%s." _counter, STRING_TABLE_LOOKUP(_mode, efx_loopback_mode)
   179	
   180	/**
   181	 * efx_fill_loopback_test - fill in a block of loopback self-test entries
   182	 * @efx:		Efx NIC
   183	 * @lb_tests:		Efx loopback self-test results structure
   184	 * @mode:		Loopback test mode
   185	 * @test_index:		Starting index of the test
   186	 * @strings:		Ethtool strings, or %NULL
   187	 * @data:		Ethtool test results, or %NULL
   188	 *
   189	 * Fill in a block of loopback self-test entries.  Return new test
   190	 * index.
   191	 */
 > 192	int efx_fill_loopback_test(struct efx_nic *efx,
   193				   struct efx_loopback_self_tests *lb_tests,
   194				   enum efx_loopback_mode mode,
   195				   unsigned int test_index, u8 *strings, u64 *data)
   196	{
   197		struct efx_channel *channel =
   198			efx_get_channel(efx, efx->tx_channel_offset);
   199		struct efx_tx_queue *tx_queue;
   200	
   201		efx_for_each_channel_tx_queue(tx_queue, channel) {
   202			efx_fill_test(test_index++, strings, data,
   203				      &lb_tests->tx_sent[tx_queue->queue],
   204				      EFX_TX_QUEUE_NAME(tx_queue),
   205				      EFX_LOOPBACK_NAME(mode, "tx_sent"));
   206			efx_fill_test(test_index++, strings, data,
   207				      &lb_tests->tx_done[tx_queue->queue],
   208				      EFX_TX_QUEUE_NAME(tx_queue),
   209				      EFX_LOOPBACK_NAME(mode, "tx_done"));
   210		}
   211		efx_fill_test(test_index++, strings, data,
   212			      &lb_tests->rx_good,
   213			      "rx", 0,
   214			      EFX_LOOPBACK_NAME(mode, "rx_good"));
   215		efx_fill_test(test_index++, strings, data,
   216			      &lb_tests->rx_bad,
   217			      "rx", 0,
   218			      EFX_LOOPBACK_NAME(mode, "rx_bad"));
   219	
   220		return test_index;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

