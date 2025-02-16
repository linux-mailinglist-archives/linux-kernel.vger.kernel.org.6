Return-Path: <linux-kernel+bounces-516456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BFA371F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 04:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09560188726D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBFA433A0;
	Sun, 16 Feb 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYw80VzE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDE1401C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739675955; cv=none; b=kxQErqTQdD8t63d2VJWnn+D1y1Rgujtxlh8eoqD/73r6iBxggDJQDBjP39OaDtNG4HWviQIauanqDXwQgtT3qjVq408slLXz1FsC832at8kXQEHyr3PkEptYvSYkJRx1E0FO8Y1FgriuMouWX9mQ4YEGywRrTB85fVDL8CGEsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739675955; c=relaxed/simple;
	bh=CsCnn3iYvhf1M5IjX/gTVsMy7hQwe8lPL9/SaVYEwBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IS79J1K6hyyzbpSet7ita6XI7qWVXmWNc1yTdsijyFH5IhBReYU0B45Kcteeak1mHh4ax1+385dl77V3Adt7WAqcjj5beXAqDo7yjbeSj94T7EvSzjY72frFmrp440qORidb6wx2I6kHMmK6vbsXGtJPRfiNncFe3PyXLx8Ctzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYw80VzE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739675954; x=1771211954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CsCnn3iYvhf1M5IjX/gTVsMy7hQwe8lPL9/SaVYEwBM=;
  b=cYw80VzEE3WzZ9UPGdc13COREO0NqtdPQ+N3tlZPFfWJUelrq1JofvwC
   IyGTOCyLpOD/6DbPxs3EpLfmJm8ITjlNjMecqERYKjgf+NHLXAIciFh2Z
   NKZJi1+uZk5Mudb68atk28TXaZLOJSM2Ej8uNSxyW9worurcFr/tYxxgn
   fyL8mnCNxgIVRdJ3oOwVVsPuwh9t+LwcstmmAx1UHm0K0rYADnVvhJgwm
   UQf6nTwetlCVdOi8u7tRd48WNdMK/YeciutALltseIv+rZQpO2485V0kp
   JSzWm+/cdQRIfT9k2s4L/RygQo3XgTufzQX5rCKXB0Mzid/7LNSof7lZC
   Q==;
X-CSE-ConnectionGUID: RQhAWNEVT7m2L6e6Rzxy9g==
X-CSE-MsgGUID: D+aGpj9wTY6A0XLOrhQ9jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="39622265"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="39622265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:19:13 -0800
X-CSE-ConnectionGUID: SvVGbEXARU+0n1nSymd4Qg==
X-CSE-MsgGUID: k4btaVhrTZ2QABLXX8hbBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="144663474"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa002.jf.intel.com with ESMTP; 15 Feb 2025 19:19:09 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	nirav.rabara@altera.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH mtd/fixes] mtd: rawnand: cadence: fix unchecked dereference
Date: Sun, 16 Feb 2025 11:15:36 +0800
Message-Id: <20250216031536.3366360-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add NULL check before variable dereference to fix static checker warning.

Fixes: d76d22b5096c ("mtd: rawnand: cadence: use dma_map_resource for sdma address")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/e448a22c-bada-448d-9167-7af71305130d@stanley.mountain/
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 0b2db4173e72..6667eea95597 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2972,8 +2972,10 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	cadence_nand_chips_cleanup(cdns_ctrl);
-	dma_unmap_resource(cdns_ctrl->dmac->device->dev, cdns_ctrl->io.iova_dma,
-			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+	if (cdns_ctrl->dmac)
+		dma_unmap_resource(cdns_ctrl->dmac->device->dev,
+				   cdns_ctrl->io.iova_dma, cdns_ctrl->io.size,
+				   DMA_BIDIRECTIONAL, 0);
 	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
 	kfree(cdns_ctrl->buf);
 	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
-- 
2.25.1


