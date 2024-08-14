Return-Path: <linux-kernel+bounces-286465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06762951B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3B82869A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D901B143C;
	Wed, 14 Aug 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSrAzGyp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F191B1401;
	Wed, 14 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640121; cv=none; b=am5XFtnuIm0FmE9mp6t71zMyhljVNBh5+U3ET+wyAHEsGGM9XWw13mTl3nY+ST2ZlcT7byKkvZVi0Gj9in23tU91F3lcp61/gpQGeoP7A1lMzGYmvoUtcPAvgWfJZf8LpWib0P9VWj/Fn1oYJUwR1O5jzxq15h8CRgVCR6SuJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640121; c=relaxed/simple;
	bh=lUSmyX8AJAgdUi5lPG1EUFhUfIEx7/D0s/i6MthUHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LylnOikGPxDYYLzeSNd4t2vepKPoTpZNEZKI97YamtnmBQZcD9ELoHJ5LYsTbkFG/gRl8lm982/cI2wD9b4ovyX+vMEforCMyX5ROvTN8tQS7VkCCgHSJpat0ZcfOFIbak4r21DF0ey9u1LFecYPT96nTxBJ8La/lPOLkik+VfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSrAzGyp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723640120; x=1755176120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUSmyX8AJAgdUi5lPG1EUFhUfIEx7/D0s/i6MthUHTQ=;
  b=mSrAzGypNX7jcp57wbvRtnhd81hCOXOsKX6L49qQbRd+wkz6/OOKF7gj
   U1E/FrIHICwHoRqMJMX5CkBLVrcqN9DugWDVASpdRicnQ59eLwuRJwCNp
   5n7ADdIE5d+SRdEKTbb564juAOWJ1nkiX4q8insxo8pcMLKAwIGSxOnXe
   kP332u3MA2746s5fFOdjRU/aE+bL24FZIf5oTLbVqP6k5K5c1nJusi/ax
   pFL/M3wOMbNwSPybU/4XbRUUnuxyKj53+RSsOqJNwVHl1D5VivMA82brJ
   N6o3XH7FQF9BP/anq1rMy6VSHAD2iqIvhpetmCYxWheQUtJGtgJ4E/otn
   A==;
X-CSE-ConnectionGUID: LxJJkuUZTVSpBCMPfGrirw==
X-CSE-MsgGUID: RQ1nazfhQ+WxVKf0w2p7KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22010676"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="22010676"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:55:17 -0700
X-CSE-ConnectionGUID: W9vRtWsASGqElq4+BjyMwA==
X-CSE-MsgGUID: 3UUnfxD+SMm86zbkydPOpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="89804225"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2024 05:55:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DB69217F; Wed, 14 Aug 2024 15:55:13 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 1/2] clk: mmp: Switch to use kmemdup_array()
Date: Wed, 14 Aug 2024 15:54:07 +0300
Message-ID: <20240814125513.2637955-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240814125513.2637955-1-andriy.shevchenko@linux.intel.com>
References: <20240814125513.2637955-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the kmemdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/mmp/clk-mix.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index 454d131f475e..07ac9e6937e5 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -447,7 +447,6 @@ struct clk *mmp_clk_register_mix(struct device *dev,
 	struct mmp_clk_mix *mix;
 	struct clk *clk;
 	struct clk_init_data init;
-	size_t table_bytes;
 
 	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (!mix)
@@ -461,8 +460,8 @@ struct clk *mmp_clk_register_mix(struct device *dev,
 
 	memcpy(&mix->reg_info, &config->reg_info, sizeof(config->reg_info));
 	if (config->table) {
-		table_bytes = sizeof(*config->table) * config->table_size;
-		mix->table = kmemdup(config->table, table_bytes, GFP_KERNEL);
+		mix->table = kmemdup_array(config->table, config->table_size,
+					   sizeof(*mix->table), GFP_KERNEL);
 		if (!mix->table)
 			goto free_mix;
 
@@ -470,9 +469,8 @@ struct clk *mmp_clk_register_mix(struct device *dev,
 	}
 
 	if (config->mux_table) {
-		table_bytes = sizeof(u32) * num_parents;
-		mix->mux_table = kmemdup(config->mux_table, table_bytes,
-					 GFP_KERNEL);
+		mix->mux_table = kmemdup_array(config->mux_table, num_parents,
+					       sizeof(*mix->mux_table), GFP_KERNEL);
 		if (!mix->mux_table) {
 			kfree(mix->table);
 			goto free_mix;
-- 
2.43.0.rc1.1336.g36b5255a03ac


