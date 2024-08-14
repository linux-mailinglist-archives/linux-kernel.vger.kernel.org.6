Return-Path: <linux-kernel+bounces-286464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE613951B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F912B23936
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72F1B1421;
	Wed, 14 Aug 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn3JPS5+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C931B0124;
	Wed, 14 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640120; cv=none; b=UJBsCsJ6J5b1hbSlA5buOH3HJ9EC3Z+OYn+wJh5COlfv8n8sCggf3rfxsF+cEB8CmdgGRAdMNc8SIIrKwndOezhf5OLiVPU+BD2HB4VKfWFdzAujBI5MCRI/aB1eg2ZXYvwFX+DkS81xZYKeKqaSNjHFrThVFU9X8OJ9lZCptvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640120; c=relaxed/simple;
	bh=APdEsDB4uRUfTA63O96E6T6zEAl1Dq01I03zQVCsNlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyarU71VGveYY6zWM5GMuLYic0GfS5rlgJmanX8x7ESoZWJAIbfUFY0g4tl1DAPj3E+mVYaSxDAdyu/2+BydlW20VXH3bqHtzYyen9RF/w77ClHRgTwCRb4c+G7x8iDJfPQXi0mce9ydBYHZoUgMW3OJ+jEUAUuNyeoUilyYEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn3JPS5+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723640119; x=1755176119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APdEsDB4uRUfTA63O96E6T6zEAl1Dq01I03zQVCsNlk=;
  b=bn3JPS5+xBWAuD5lmSujE/dFbOxKXLmWPeSVCpNqQWq9aEIqeocOxcuj
   c2xYFVfaEiUKqzHCXB9HhvFD52m+PK24MYoCKqPG0CXh4hkmwUQZM+ZEz
   otfXfqII7i/kvWTIbAYexLrlYIF3VY+uAohYEqFYX8i+9604YMUapEcCU
   HjQHKB5vY+5sxF6goluuKjn9ZdIjtqJN+mFlk4HHpblq2zufKMO6FBw/d
   cqJTvXC4JLjkvsFPuvWXhwfYNKyBA0SP7r/CDibazi7DRXYm1vWdJJbv2
   cKzkoBT0jFRAxtF6VNwYE+1bcio6v857XW8KMLV9OZrVDXEfM/9IaocgO
   g==;
X-CSE-ConnectionGUID: bL3J6qLXSXaNuDhosYILDA==
X-CSE-MsgGUID: OJ9dsxevTKei3n4wjSK/Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22010671"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="22010671"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:55:17 -0700
X-CSE-ConnectionGUID: tYGueyiRSOmWo/oRDpCZoQ==
X-CSE-MsgGUID: WpwGN25MQM+gY6nt7vThPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="89804224"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2024 05:55:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E0C012FB; Wed, 14 Aug 2024 15:55:13 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 2/2] clk: visconti: Switch to use kmemdup_array()
Date: Wed, 14 Aug 2024 15:54:08 +0300
Message-ID: <20240814125513.2637955-3-andriy.shevchenko@linux.intel.com>
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
 drivers/clk/visconti/pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index e9cd80e085dc..3f929cf8dd2f 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -262,9 +262,9 @@ static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,
 	for (len = 0; rate_table[len].rate != 0; )
 		len++;
 	pll->rate_count = len;
-	pll->rate_table = kmemdup(rate_table,
-				  pll->rate_count * sizeof(struct visconti_pll_rate_table),
-				  GFP_KERNEL);
+	pll->rate_table = kmemdup_array(rate_table,
+					pll->rate_count, sizeof(*pll->rate_table),
+					GFP_KERNEL);
 	WARN(!pll->rate_table, "%s: could not allocate rate table for %s\n", __func__, name);
 
 	init.ops = &visconti_pll_ops;
-- 
2.43.0.rc1.1336.g36b5255a03ac


