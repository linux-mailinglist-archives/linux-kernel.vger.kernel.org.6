Return-Path: <linux-kernel+bounces-303383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34413960B62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2701F22395
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F321C462C;
	Tue, 27 Aug 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFMT2v55"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06751BDAB4;
	Tue, 27 Aug 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764101; cv=none; b=OKSHEw9IrwuS+BWSYWKfv5BpjKXdwSFbAT8va3oro+5viGdu87S90yBW9JFMfLYp6UXu4UGo/rF8Ur4zy6x4BXGdGCpWLpCzUNR7zxmQN7bwEcWefa315+QrHw2WY1l/EPnlJxns5GwSkgrbxgJSvqmtDTLxd6VZJ/nyAKOaY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764101; c=relaxed/simple;
	bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbxVKZdvtHeEGGqZU7hKROsZujnIWSgI2naTUNG7RIOR/8CW/ftXU5kJa8/7wMD1OwfhMmdjoU4cXAewWzULHPIgODb3ya1oMWut2BBZL1Q1KflBv/62v0JHIB4khzVePOiRoFaCh14J9DNnM8BuBmMk/PNLSKK8kz9jkYjnT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFMT2v55; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764099; x=1756300099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
  b=UFMT2v551uOdkwOP01IqwMYwkQwQ1olcz68auaew8Y8FSAnwJQCOa21/
   mPS/pPwoFfSyV5+U10zz0UarS4lKPpfeDhgL9LQGLMFGKd6SKgw0RBZN6
   Oa+lxGEx5DXt0wAu24pBUpH2hCVO+ca7TniahJYpEu1vQ8HKtBi4ka6WW
   lKbqD17mbb+fTOaj1z7gokZwCSXsTrtmKP6k/XZMJnJ1rrbqj4QVBFdqz
   0ec+t307IzV0lucomJUxXxvRmXgtYSCxFVqR+1uJ3b3v9zT5RKafCLS+u
   /IvH8J1FBbEw0o9SmAELqVNNDPcygvS1Ai45KGRYkHoh1Dm6Jy3gCxqzk
   g==;
X-CSE-ConnectionGUID: PRqqBoHbS4ivLmhLCtEdvg==
X-CSE-MsgGUID: S/kbFTKdSZqNXXyP225YVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400627"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:19 -0700
X-CSE-ConnectionGUID: st6Lk8SZTOqEHnCR/rtsRg==
X-CSE-MsgGUID: Qbgw2UrPSlW2EAB1GJnTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552084"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:18 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 10/14] soundwire: mipi_disco: add support for clock-scales property
Date: Tue, 27 Aug 2024 21:07:03 +0800
Message-ID: <20240827130707.298477-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The DisCo for SoundWire 2.0 spec adds support for the
'mipi-sdw-supported-clock-scales' property, which is just a
rename. Add in a backwards-compatible manner.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 99253f4c9a38..5f42d23bbc85 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -51,6 +51,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
 	struct fwnode_handle *link;
+	const char *scales_prop;
 	char name[32];
 	int nval;
 	int ret;
@@ -112,7 +113,12 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		}
 	}
 
-	nval = fwnode_property_count_u32(link, "mipi-sdw-supported-clock-gears");
+	scales_prop = "mipi-sdw-supported-clock-scales";
+	nval = fwnode_property_count_u32(link, scales_prop);
+	if (nval == 0) {
+		scales_prop = "mipi-sdw-supported-clock-gears";
+		nval = fwnode_property_count_u32(link, scales_prop);
+	}
 	if (nval > 0) {
 		prop->num_clk_gears = nval;
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
@@ -124,7 +130,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		}
 
 		ret = fwnode_property_read_u32_array(link,
-					       "mipi-sdw-supported-clock-gears",
+					       scales_prop,
 					       prop->clk_gears,
 					       prop->num_clk_gears);
 		if (ret < 0)
-- 
2.43.0


