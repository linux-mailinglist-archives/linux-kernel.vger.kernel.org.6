Return-Path: <linux-kernel+bounces-395060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119F19BB7ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF7B26301
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09D1B3928;
	Mon,  4 Nov 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7MDwz66"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAB1B6D02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730924; cv=none; b=tRu0O7GpbQJ492JrHK9yZKYkh4xDzYa+QHDXfEye+2Z0QP85hMm3oBTjThPR72HPujYTIHlbCXYY4PS1qXofp7Gb05YaoMJoShM6B58NUgbiGeTasYMoTO67jfoV0t41PTGtLe0+RkaLT9x94538RDxdJKWQJN7ff6zfThsIia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730924; c=relaxed/simple;
	bh=52dzUwWrNteuyWEOyKqFCD7AkweuwycSceX/+/drMCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nqaoWKa7CNpGRS4QQjlipso2XdoQ9M06FmmMGJKMDqbpiBtKQ4fygF7zmq+CCDVO7lsDxwoGqs7hECFBKLo6Pg2BMlEBLRsw3W1n9UIzegwFaLPKnoDR3/nQ56IDOw74tU4GWNi/gxw2Ux7i8RPdBpPibA6+JaUHnAvnno9oQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7MDwz66; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730923; x=1762266923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=52dzUwWrNteuyWEOyKqFCD7AkweuwycSceX/+/drMCw=;
  b=e7MDwz66edpN+QXKdKXUNFM8Xbov2PTqgeb65hx0soAd5N/PQUYjhiDL
   OHOWFRkvsn/r2KMvtFydRj+KC5e2S0RlDoSpBi5OQ80Faba5DGCueaTCZ
   RZW8IQr21zxekKj+Fxxdt2Wrj2Hs0raXKmb8kOAzwqiWFff4i2LywH8IT
   tY18RU+GKXyqUnGs/Fy3kgy04nl9vBCs4PChu0EZGQs1592LjBNKm8ne3
   V5q5vN58iWhSk65feQbEOzdD6QJM9MHqEvIkK24KGfDCPA5UlVJTD75BZ
   aqByLr/SWfhV3xX7SMd9vxWXeyKoGmtqi1wkHywd2PzVHeNZqLwdwosc9
   Q==;
X-CSE-ConnectionGUID: 4xSokE1BQ26zCJs8cNPjCg==
X-CSE-MsgGUID: LYrRKn6FRM26CYyr9A12TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30206268"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30206268"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:35:17 -0800
X-CSE-ConnectionGUID: mnXtu6QKQOW4JUY02e6Ohg==
X-CSE-MsgGUID: ZDcWuvDvQXyRYsZn/d/n4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="121138407"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2024 06:35:16 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7yAj-000kvH-30;
	Mon, 04 Nov 2024 14:35:13 +0000
Date: Mon, 4 Nov 2024 22:34:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028-sa-with-flex 13/26]
 drivers/net/phy/aquantia/aquantia_leds.o: warning: objtool:
 aqr_phy_led_polarity_set+0x118: sibling call from callable instruction with
 modified stack frame
Message-ID: <202411042241.KaXFKg7U-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241028-sa-with-flex
head:   0e7c24c783de39e1f965e8c23e96a7de29dfbfca
commit: b304d4c5cf207285c3820dc9a50bf09c06e46d42 [13/26] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: loongarch-randconfig-001-20241104 (https://download.01.org/0day-ci/archive/20241104/202411042241.KaXFKg7U-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411042241.KaXFKg7U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411042241.KaXFKg7U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/aquantia/aquantia_leds.o: warning: objtool: aqr_phy_led_polarity_set+0x118: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

