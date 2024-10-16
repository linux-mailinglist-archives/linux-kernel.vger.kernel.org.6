Return-Path: <linux-kernel+bounces-367950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6859A08B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545921F25031
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563D208964;
	Wed, 16 Oct 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APiEVBuf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB2207A1E;
	Wed, 16 Oct 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079442; cv=none; b=oB7n/gzPrBYdyvUz7blxNrV3k9/9PbW/jdybJQTyyt7uqwwnuqc/enc3noWKF+DXW8T1kAixkNK0nI4dVwOdnaJM/KKsO/gIFQeXaAS2I7MXQa2rnk5jfbaFSjgJOw9Tf2JD3C7kwChD2RM1k3tRB2LC3KCS9NSIJBiR1gkfv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079442; c=relaxed/simple;
	bh=0u2TnzL2XRFhwUYIzbKAOkJS2xr/yU0W8afUZRGNPaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoU5AFTMLyNtEktjlkZSLVNymB5xIp8odnpKWUutoX8az+1BspX2a/is7z6d8AIlN2uEJz8bBMXAIJ/34amx8a/kRtSdDfAhaEp+a+81oVaTgUjDDuVPwoZ6FN1q3yuyzLlsDamLh2DEJcxMTwDjUda/Xj74r7gRXGfgejnKV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APiEVBuf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729079441; x=1760615441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0u2TnzL2XRFhwUYIzbKAOkJS2xr/yU0W8afUZRGNPaE=;
  b=APiEVBufGwnyTWDS4VHCPk3B4tS88INovbDQm2g07rerbPS3AcJ2OPGq
   3Uw6Xkb4ttPk2X4GsqPcBHgy/kP+U+AozM/ZZOpeEFSl96i0zB9//9cH2
   vxPFB5J9Wdo/jAyR6u6JuMpmSEM5nM5qgdEO+46IXPfLEjCzkcmW75MO8
   JiGU0ILTKuaQJj3tSvkMwnR4WT1upOF6hkgq8/PagiOvXPDzcYMyHRX/b
   K1icanqJ+gdWJfk+XAJRPsX5DsGMHFwMhulywYUilaHsQnhutSRKPq5wV
   yFuE9wxJT1S1zZLntyHmGPeAJwwnrLb7Q8RRHa5a6hpoMX7BvEsQ7TVJP
   w==;
X-CSE-ConnectionGUID: xrOqo2lzTrCqDZ6+RzczqQ==
X-CSE-MsgGUID: qm6H+QmBQEeud9u3Ir+mlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39069928"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39069928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:50:38 -0700
X-CSE-ConnectionGUID: tzkZgP1QT3qv7viCmFrrcw==
X-CSE-MsgGUID: VxbUQNe0T56sbYSGfKY7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82974933"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 16 Oct 2024 04:50:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D20C01C4; Wed, 16 Oct 2024 14:50:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 3/3] platform/x86: intel_scu_ipc: Save a copy of the entire struct intel_scu_ipc_data
Date: Wed, 16 Oct 2024 14:48:26 +0300
Message-ID: <20241016115033.858574-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save a copy of the entire struct intel_scu_ipc_data for easier
maintenance in case of expanding (adding new members become simpler).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 33 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index ffb0a2524388..e86a255f70ba 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -57,11 +57,11 @@
 
 struct intel_scu_ipc_dev {
 	struct device dev;
-	struct resource mem;
 	struct module *owner;
-	int irq;
 	void __iomem *ipc_base;
 	struct completion cmd_complete;
+
+	struct intel_scu_ipc_data data;
 };
 
 #define IPC_STATUS		0x04
@@ -256,7 +256,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 
 static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 {
-	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
+	return scu->data.irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
 static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
@@ -536,13 +536,13 @@ static irqreturn_t ioc(int irq, void *dev_id)
 
 static void intel_scu_ipc_release(struct device *dev)
 {
-	struct intel_scu_ipc_dev *scu;
+	struct intel_scu_ipc_dev *scu = container_of(dev, struct intel_scu_ipc_dev, dev);
+	struct intel_scu_ipc_data *data = &scu->data;
 
-	scu = container_of(dev, struct intel_scu_ipc_dev, dev);
-	if (scu->irq > 0)
-		free_irq(scu->irq, scu);
+	if (data->irq > 0)
+		free_irq(data->irq, scu);
 	iounmap(scu->ipc_base);
-	release_mem_region(scu->mem.start, resource_size(&scu->mem));
+	release_mem_region(data->mem.start, resource_size(&data->mem));
 	kfree(scu);
 }
 
@@ -563,6 +563,7 @@ __intel_scu_ipc_register(struct device *parent,
 			 struct module *owner)
 {
 	int err;
+	struct intel_scu_ipc_data *data;
 	struct intel_scu_ipc_dev *scu;
 	void __iomem *ipc_base;
 
@@ -581,25 +582,25 @@ __intel_scu_ipc_register(struct device *parent,
 	scu->dev.class = &intel_scu_ipc_class;
 	scu->dev.release = intel_scu_ipc_release;
 
-	if (!request_mem_region(scu_data->mem.start, resource_size(&scu_data->mem),
-				"intel_scu_ipc")) {
+	memcpy(&scu->data, scu_data, sizeof(scu->data));
+	data = &scu->data;
+
+	if (!request_mem_region(data->mem.start, resource_size(&data->mem), "intel_scu_ipc")) {
 		err = -EBUSY;
 		goto err_free;
 	}
 
-	ipc_base = ioremap(scu_data->mem.start, resource_size(&scu_data->mem));
+	ipc_base = ioremap(data->mem.start, resource_size(&data->mem));
 	if (!ipc_base) {
 		err = -ENOMEM;
 		goto err_release;
 	}
 
 	scu->ipc_base = ipc_base;
-	scu->mem = scu_data->mem;
-	scu->irq = scu_data->irq;
 	init_completion(&scu->cmd_complete);
 
-	if (scu->irq > 0) {
-		err = request_irq(scu->irq, ioc, 0, "intel_scu_ipc", scu);
+	if (data->irq > 0) {
+		err = request_irq(data->irq, ioc, 0, "intel_scu_ipc", scu);
 		if (err)
 			goto err_unmap;
 	}
@@ -622,7 +623,7 @@ __intel_scu_ipc_register(struct device *parent,
 err_unmap:
 	iounmap(ipc_base);
 err_release:
-	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
+	release_mem_region(data->mem.start, resource_size(&data->mem));
 err_free:
 	kfree(scu);
 	return ERR_PTR(err);
-- 
2.43.0.rc1.1336.g36b5255a03ac


