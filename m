Return-Path: <linux-kernel+bounces-195319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789D8D4B05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689581C22D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C8176FA3;
	Thu, 30 May 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvM7Pt49"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85816F905
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069913; cv=none; b=XnIz5hE8bA0dOApzmh61XovOfDJj5b2O3AlWOcvKnbTkcc4rOHovKUjv3PUm9GN67MejRWFt/EuZBjk8TfIY0tZUU61CRleA5tw9FVf58EsYoG1piLQzJncSZEb9Bg+0+UdPQA2btAyEU0TCFMukhbjhEnlB3WKpuSGm/GWxAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069913; c=relaxed/simple;
	bh=Xf00JtTukfYuk6YB5lzmC2FJS7ekf+MVggvwZ5U5ZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3VK2BfxiZVcXWRE1jaWBWzLAz0jbJOnpMx6/KKCqs+YYooZvFtSm3ipal4iCOKx86554kO+NPqzSWdFOUke30INUjucPSEzuBmuSv8Zq8r9ke5O7VerZRMLVp7DfTs3D5Y5JN/GHc+xuQAXE6UKy82ACIKITl/jROhUcAcukE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvM7Pt49; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717069911; x=1748605911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xf00JtTukfYuk6YB5lzmC2FJS7ekf+MVggvwZ5U5ZQU=;
  b=PvM7Pt49BrAqEccSwLC22ObOZWKJfbhZYOXaszWslGa3knlsSbnLPlj/
   XK9Jn52/+bC4qKKV56Z1Vf/YH91/u4/T7VBM/rUxmKMXdwFb5uw6aKOrT
   VAMNI+6uXo4rds+O1ba2EcjUj238VNcgT34FB6NRzU7MuDPf64wtJxZxx
   Do4QGCerg9eAl95Hc+PDe+Ig/SEroPFbc5v98DjOEyPuboZgWuvSld3no
   y3urbnQMg1kTIKT+O7lJoN47DXn/qKhm1aEUCzvsIQKEOnGWDC6Iis1IT
   hkHHdgCK9khYbfHWwMPDpcO+KYpfAfRrKAyMunWTfbpdmy3jtLsoY4Cgu
   Q==;
X-CSE-ConnectionGUID: pf9CwNCFTgKVsVk2imfA4A==
X-CSE-MsgGUID: n720tiu7R56lRd9Rsv9u4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17383934"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="17383934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:51:51 -0700
X-CSE-ConnectionGUID: KrcYbzeiT1qRVq6R5/D8yA==
X-CSE-MsgGUID: qghW+MTgQgWBD7l4PMSPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40257244"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 30 May 2024 04:51:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D779E2A4; Thu, 30 May 2024 14:51:48 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: core: Make use of device_set_node()
Date: Thu, 30 May 2024 14:51:47 +0300
Message-ID: <20240530115147.1112498-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use device_set_node() instead of assigning pdev->dev.of_node
directly because it also sets the firmware node.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6ad5c93027af..7ea9a875d8f3 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -87,7 +87,7 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 		}
 	}
 
-	ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
+	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
@@ -131,8 +131,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	of_entry->np = np;
 	list_add_tail(&of_entry->list, &mfd_of_node_list);
 
-	pdev->dev.of_node = np;
-	pdev->dev.fwnode = &np->fwnode;
+	device_set_node(&pdev->dev, of_fwnode_handle(np));
 #endif
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


