Return-Path: <linux-kernel+bounces-297595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618D95BB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B85280F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3411CCEC2;
	Thu, 22 Aug 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN8hZQW2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18201CB33A;
	Thu, 22 Aug 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342324; cv=none; b=MK78Rfpi6RLPe8Bk32/w05MvUdVUzpxFZl6Am/o1yidyq4iZyYXPL6JEfUDwCkv9SM/6zZDHqvzoNhfXAjbGW8GZ6Ehou1YXCxa6vJn7vDiafEVQI4W4+lQolalyF7L/tzaaNWmtYXgGS7KwjGTnfYkQh1WQstqnhRuzwEHeW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342324; c=relaxed/simple;
	bh=WQeqMR1nA+QhuWis7uFOdmZRQYMQ6lH4jsf9Q8orpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZ4jFAWw/My3e78sl63qjDvP0IWFK+pQhvutn7siGNH4UEzjy4aF7nilANfUF564SXNfxvRSWlBL0aaZOPQ7P++r8YD/s/IMybFNFkdnv/27okezHyL5HtUyAHCvH1BFB+PxIcgi5RgCXO06pOXx0E8ROY++N7gvnYTDoRBmMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN8hZQW2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724342323; x=1755878323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WQeqMR1nA+QhuWis7uFOdmZRQYMQ6lH4jsf9Q8orpA0=;
  b=CN8hZQW26jCBkg9YP2xP5augKNQHo1NOzM8kjQW86SkR670IvQTz1Aqa
   KZzHW0sisvu1l8jN3xLNrsgNfeOI3zDNMV7cKWobISnz+T7j6fhosfizb
   A+I8bSHMxJKk7QOYbqbFqJZDm4zeiPnAoa5z4eBDwr1q4X3H9lHGRkWhQ
   QXDUg57ulVooJoMB+3+rZRZN6bROTYFyV/S6kt6iLXcFVVecZqJPm7okp
   yg9+Pr2XDqgRQihDnNiwKCDCtFJklchpxJm4++ibDRTTphKNvgm3H3mRl
   CPyE0z0GQaedTewqd/KToqc7FrkVz1wBarItK0BPwv8pd8pXqyV2+uTut
   g==;
X-CSE-ConnectionGUID: CW0QPoIbQuSR1TaGdpV6sw==
X-CSE-MsgGUID: i0zutfBWTW2lPdIBod382g==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26638212"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26638212"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:58:41 -0700
X-CSE-ConnectionGUID: xyVyt5TwSCeE/hd87EWaVw==
X-CSE-MsgGUID: vjYRAmVoRwCGkL69TAWPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="84667717"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 22 Aug 2024 08:58:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 85DED2B3; Thu, 22 Aug 2024 18:58:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 1/1] clk: devres: Simplify devres handling functions
Date: Thu, 22 Aug 2024 18:58:22 +0300
Message-ID: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk-devres.c | 130 ++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 90e6078fb6e1..f03d60706a85 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -1,15 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/types.h>
 
 struct devm_clk_state {
 	struct clk *clk;
 	void (*exit)(struct clk *clk);
 };
 
-static void devm_clk_release(struct device *dev, void *res)
+static void devm_clk_release(void *res)
 {
 	struct devm_clk_state *state = res;
 
@@ -28,15 +30,13 @@ static struct clk *__devm_clk_get(struct device *dev, const char *id,
 	struct clk *clk;
 	int ret;
 
-	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
 	clk = get(dev, id);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto err_clk_get;
-	}
+	if (IS_ERR(clk))
+		return clk;
 
 	if (init) {
 		ret = init(clk);
@@ -47,16 +47,14 @@ static struct clk *__devm_clk_get(struct device *dev, const char *id,
 	state->clk = clk;
 	state->exit = exit;
 
-	devres_add(dev, state);
+	ret = devm_add_action_or_reset(dev, devm_clk_release, state);
+	if (ret)
+		goto err_clk_init;
 
 	return clk;
 
 err_clk_init:
-
 	clk_put(clk);
-err_clk_get:
-
-	devres_free(state);
 	return ERR_PTR(ret);
 }
 
@@ -104,7 +102,7 @@ struct clk_bulk_devres {
 	int num_clks;
 };
 
-static void devm_clk_bulk_release(struct device *dev, void *res)
+static void devm_clk_bulk_release(void *res)
 {
 	struct clk_bulk_devres *devres = res;
 
@@ -117,8 +115,7 @@ static int __devm_clk_bulk_get(struct device *dev, int num_clks,
 	struct clk_bulk_devres *devres;
 	int ret;
 
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
+	devres = devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
 	if (!devres)
 		return -ENOMEM;
 
@@ -126,15 +123,13 @@ static int __devm_clk_bulk_get(struct device *dev, int num_clks,
 		ret = clk_bulk_get_optional(dev, num_clks, clks);
 	else
 		ret = clk_bulk_get(dev, num_clks, clks);
-	if (!ret) {
-		devres->clks = clks;
-		devres->num_clks = num_clks;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	devres->clks = clks;
+	devres->num_clks = num_clks;
+
+	return devm_add_action_or_reset(dev, devm_clk_bulk_release, devres);
 }
 
 int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
@@ -151,7 +146,7 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional);
 
-static void devm_clk_bulk_release_all(struct device *dev, void *res)
+static void devm_clk_bulk_release_all(void *res)
 {
 	struct clk_bulk_devres *devres = res;
 
@@ -164,25 +159,24 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 	struct clk_bulk_devres *devres;
 	int ret;
 
-	devres = devres_alloc(devm_clk_bulk_release_all,
-			      sizeof(*devres), GFP_KERNEL);
+	devres = devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
 	if (!devres)
 		return -ENOMEM;
 
-	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+	devres->num_clks = clk_bulk_get_all(dev, &devres->clks);
+	if (devres->num_clks <= 0)
+		return devres->num_clks;
 
-	return ret;
+	ret = devm_add_action_or_reset(dev, devm_clk_bulk_release_all, devres);
+	if (ret)
+		return ret;
+
+	*clks = devres->clks;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
-static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
+static void devm_clk_bulk_release_all_enable(void *res)
 {
 	struct clk_bulk_devres *devres = res;
 
@@ -196,49 +190,33 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
 	struct clk_bulk_devres *devres;
 	int ret;
 
-	devres = devres_alloc(devm_clk_bulk_release_all_enable,
-			      sizeof(*devres), GFP_KERNEL);
+	devres = devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
 	if (!devres)
 		return -ENOMEM;
 
-	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-	} else {
-		devres_free(devres);
+	devres->num_clks = clk_bulk_get_all(dev, &devres->clks);
+	if (devres->num_clks <= 0)
+		return devres->num_clks;
+
+	ret = clk_bulk_prepare_enable(devres->num_clks, devres->clks);
+	if (ret) {
+		clk_bulk_put_all(devres->num_clks, devres->clks);
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
-	if (!ret) {
-		devres_add(dev, devres);
-	} else {
-		clk_bulk_put_all(devres->num_clks, devres->clks);
-		devres_free(devres);
-	}
+	ret = devm_add_action_or_reset(dev, devm_clk_bulk_release_all_enable, devres);
+	if (ret)
+		return ret;
+
+	*clks = devres->clks;
+	return 0;
 
-	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
 
-static int devm_clk_match(struct device *dev, void *res, void *data)
-{
-	struct clk **c = res;
-	if (!c || !*c) {
-		WARN_ON(!c || !*c);
-		return 0;
-	}
-	return *c == data;
-}
-
 void devm_clk_put(struct device *dev, struct clk *clk)
 {
-	int ret;
-
-	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
-
-	WARN_ON(ret);
+	devm_release_action(dev, devm_clk_release, clk);
 }
 EXPORT_SYMBOL(devm_clk_put);
 
@@ -246,20 +224,20 @@ struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
 	struct devm_clk_state *state;
-	struct clk *clk;
+	int ret;
 
-	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	clk = of_clk_get_by_name(np, con_id);
-	if (!IS_ERR(clk)) {
-		state->clk = clk;
-		devres_add(dev, state);
-	} else {
-		devres_free(state);
-	}
+	state->clk = of_clk_get_by_name(np, con_id);
+	if (IS_ERR(state->clk))
+		return state->clk;
 
-	return clk;
+	ret = devm_add_action_or_reset(dev, devm_clk_release, state);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return state->clk;
 }
 EXPORT_SYMBOL(devm_get_clk_from_child);
-- 
2.43.0.rc1.1336.g36b5255a03ac


