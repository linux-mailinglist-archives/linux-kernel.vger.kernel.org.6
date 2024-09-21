Return-Path: <linux-kernel+bounces-334991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C702F97DF76
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDFE2822C0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE98152196;
	Sat, 21 Sep 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghLEZ40X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAF14A60E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958293; cv=none; b=UDtnVjU5fN59TBko8h9i33FPt00k+YtFZnQbbkoB75poj7erITla+kGhfhAMMUcUTU1GmT8WmgXERlrTSzfM9s/Lgh5gV9QoI5j+dqUxxFeSpHW4N4/Ui+85nr05vknPPm7tvXTqfsEKlS4K4iAOnj3IlRCA1FI1CO88CRNJ8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958293; c=relaxed/simple;
	bh=Vd9W86HAyKPkzX08pxjXleoqEzUZleZgUjoPTCqC0WU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eMMgZSar4HiMEnptibKlaVofYO652YImwMLesIqSERx696rn33RCh7/AGQ6bOgG4hY948vFiMekZ6O4zx8nXfIKW23rpi4/k7jez3oMTeyGCmLkjb11qbFUxlfpGHJQtC4DcHo6Bca/93wDT3oQAaDRkghz8ZbhvO5GupnJx/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghLEZ40X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726958290; x=1758494290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vd9W86HAyKPkzX08pxjXleoqEzUZleZgUjoPTCqC0WU=;
  b=ghLEZ40XDd1xm+pZxX4XgqB/3n2qgLxnzfAuYN4IizWWwcWjITLRtYHu
   OTgJrRMpA8zi1AYIdRyGvlK2Gq+kuOFYLLWYyGP5R6y3sNvrhu1gfIltr
   fH7FCDm6em9+pFrKPCXFj90VIqG/xjnEoJcLtBj+ZqZh7pJrDMvwLXPV6
   +ONuL1rMeYfEP2QzVMyIxKYiUUVw7V1zbpFIyeDt/Ib4UBu8MCc1V32Ay
   pH4imyTxFvb6UohLjT3c+isEgZycmqQIoPAPpqDHh4EGH9OC0e15nE1Gf
   PhaIIS0XyHUEx5+38W9ERwA85AQqoYjS6SW/sV5bUEde1lluElRcYMuMl
   g==;
X-CSE-ConnectionGUID: A42z87L9QJWYlNceoLbxhA==
X-CSE-MsgGUID: 8r04xZ5pTBySXH2Zc6q6uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36600719"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="36600719"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 15:38:10 -0700
X-CSE-ConnectionGUID: T4UUHxQpTuWOMO7wpBQIKw==
X-CSE-MsgGUID: IzK7xcMjQLqYLfp81naI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70262283"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2024 15:38:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss8ju-000FqW-0U;
	Sat, 21 Sep 2024 22:38:06 +0000
Date: Sun, 22 Sep 2024 06:37:23 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:278:59: warning:
 '%u' directive output may be truncated writing between 1 and 10 bytes into a
 region of size 6
Message-ID: <202409220629.TsR7ErYk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88264981f2082248e892a706b2c5004650faac54
commit: 5874e0c9f25661c2faefe4809907166defae3d7f net: atlantic: Avoid warning about potential string truncation
date:   4 weeks ago
config: x86_64-randconfig-012-20240922 (https://download.01.org/0day-ci/archive/20240922/202409220629.TsR7ErYk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220629.TsR7ErYk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220629.TsR7ErYk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c: In function 'aq_ethtool_get_strings':
>> drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:278:59: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
     278 |                                 snprintf(tc_string, 8, "TC%u ", tc);
         |                                                           ^~
   drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:278:56: note: directive argument in the range [0, 4294967294]
     278 |                                 snprintf(tc_string, 8, "TC%u ", tc);
         |                                                        ^~~~~~~
   drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:278:33: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
     278 |                                 snprintf(tc_string, 8, "TC%u ", tc);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +278 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c

   261	
   262		cfg = aq_nic_get_cfg(nic);
   263	
   264		switch (stringset) {
   265		case ETH_SS_STATS: {
   266			const int rx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_rx_stat_names);
   267			const int tx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_tx_stat_names);
   268			char tc_string[8];
   269			unsigned int tc;
   270	
   271			memset(tc_string, 0, sizeof(tc_string));
   272			memcpy(p, aq_ethtool_stat_names,
   273			       sizeof(aq_ethtool_stat_names));
   274			p = p + sizeof(aq_ethtool_stat_names);
   275	
   276			for (tc = 0; tc < cfg->tcs; tc++) {
   277				if (cfg->is_qos)
 > 278					snprintf(tc_string, 8, "TC%u ", tc);
   279	
   280				for (i = 0; i < cfg->vecs; i++) {
   281					for (si = 0; si < rx_stat_cnt; si++) {
   282						ethtool_sprintf(&p,
   283						     aq_ethtool_queue_rx_stat_names[si],
   284						     tc_string,
   285						     AQ_NIC_CFG_TCVEC2RING(cfg, tc, i));
   286					}
   287					for (si = 0; si < tx_stat_cnt; si++) {
   288						ethtool_sprintf(&p,
   289						     aq_ethtool_queue_tx_stat_names[si],
   290						     tc_string,
   291						     AQ_NIC_CFG_TCVEC2RING(cfg, tc, i));
   292					}
   293				}
   294			}
   295	#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
   296			if (nic->aq_ptp) {
   297				const int rx_ring_cnt = aq_ptp_get_ring_cnt(nic, ATL_RING_RX);
   298				const int tx_ring_cnt = aq_ptp_get_ring_cnt(nic, ATL_RING_TX);
   299				unsigned int ptp_ring_idx =
   300					aq_ptp_ring_idx(nic->aq_nic_cfg.tc_mode);
   301	
   302				snprintf(tc_string, 8, "PTP ");
   303	
   304				for (i = 0; i < max(rx_ring_cnt, tx_ring_cnt); i++) {
   305					for (si = 0; si < rx_stat_cnt; si++) {
   306						ethtool_sprintf(&p,
   307							 aq_ethtool_queue_rx_stat_names[si],
   308							 tc_string,
   309							 i ? PTP_HWST_RING_IDX : ptp_ring_idx);
   310					}
   311					if (i >= tx_ring_cnt)
   312						continue;
   313					for (si = 0; si < tx_stat_cnt; si++) {
   314						ethtool_sprintf(&p,
   315							 aq_ethtool_queue_tx_stat_names[si],
   316							 tc_string,
   317							 i ? PTP_HWST_RING_IDX : ptp_ring_idx);
   318					}
   319				}
   320			}
   321	#endif
   322	#if IS_ENABLED(CONFIG_MACSEC)
   323			if (!nic->macsec_cfg)
   324				break;
   325	
   326			memcpy(p, aq_macsec_stat_names, sizeof(aq_macsec_stat_names));
   327			p = p + sizeof(aq_macsec_stat_names);
   328			for (i = 0; i < AQ_MACSEC_MAX_SC; i++) {
   329				struct aq_macsec_txsc *aq_txsc;
   330	
   331				if (!(test_bit(i, &nic->macsec_cfg->txsc_idx_busy)))
   332					continue;
   333	
   334				for (si = 0;
   335					si < ARRAY_SIZE(aq_macsec_txsc_stat_names);
   336					si++) {
   337					ethtool_sprintf(&p,
   338						 aq_macsec_txsc_stat_names[si], i);
   339				}
   340				aq_txsc = &nic->macsec_cfg->aq_txsc[i];
   341				for (sa = 0; sa < MACSEC_NUM_AN; sa++) {
   342					if (!(test_bit(sa, &aq_txsc->tx_sa_idx_busy)))
   343						continue;
   344					for (si = 0;
   345					     si < ARRAY_SIZE(aq_macsec_txsa_stat_names);
   346					     si++) {
   347						ethtool_sprintf(&p,
   348							 aq_macsec_txsa_stat_names[si],
   349							 i, sa);
   350					}
   351				}
   352			}
   353			for (i = 0; i < AQ_MACSEC_MAX_SC; i++) {
   354				struct aq_macsec_rxsc *aq_rxsc;
   355	
   356				if (!(test_bit(i, &nic->macsec_cfg->rxsc_idx_busy)))
   357					continue;
   358	
   359				aq_rxsc = &nic->macsec_cfg->aq_rxsc[i];
   360				for (sa = 0; sa < MACSEC_NUM_AN; sa++) {
   361					if (!(test_bit(sa, &aq_rxsc->rx_sa_idx_busy)))
   362						continue;
   363					for (si = 0;
   364					     si < ARRAY_SIZE(aq_macsec_rxsa_stat_names);
   365					     si++) {
   366						ethtool_sprintf(&p,
   367							 aq_macsec_rxsa_stat_names[si],
   368							 i, sa);
   369					}
   370				}
   371			}
   372	#endif
   373			break;
   374		}
   375		case ETH_SS_PRIV_FLAGS:
   376			memcpy(p, aq_ethtool_priv_flag_names,
   377			       sizeof(aq_ethtool_priv_flag_names));
   378			break;
   379		}
   380	}
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

