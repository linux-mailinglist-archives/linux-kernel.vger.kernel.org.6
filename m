Return-Path: <linux-kernel+bounces-373917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BA9A5EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679DC1F22144
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0A1E2849;
	Mon, 21 Oct 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh9mRi04"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0B1E2600;
	Mon, 21 Oct 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500064; cv=none; b=eMFv0WE2jR3/yQOAoWufuOrp1134YN9xjLitFIued35nVy+1JmyjZ+fbTxhySMdim3fo0Xk5DYnU8yDvC98SzvIBljq7tYamBjTr8yIkko1flAt39Unr0PWmsc3EyKX3ShHcxLGxUe66MEvu1gYj3rF31qlYIBzms+M7l0ZWmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500064; c=relaxed/simple;
	bh=3vdjcqeukS/8Km0duETYAbLAA9L9ljye3GpgyOjOLRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL6+lG6Q/6IzcaiGV6AkXdESyz8PUZ4XiHc5nDBvV+L4FWpFkeUkTjJkM/ecsuKw2ZXk+m/7EEBDN4uggVOZFwUQ7Im6pqLfWG9f436z14ts7VyQ0L2TwoMEbcAreY8KKHESyHx3DbBY6YHoTe4KYfmChJF1JRItswebv/O+5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh9mRi04; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500063; x=1761036063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vdjcqeukS/8Km0duETYAbLAA9L9ljye3GpgyOjOLRk=;
  b=Fh9mRi04VBOBwqHWtOGUkd6Ogj/sPYyMTqg7TFiKlc34VUy7jG2vnKaS
   +fwS6nKuVq2iTRxf5UxUUx0KLmE69AkezWR9jgzn44gb1Zi+31yr5Ya1U
   01dHtjPkgafK3cZdGhVp8654orU2vfzMnAi9AVQj6zN13XyQCLUQ1ym/g
   aR1DbrgBZ7WKyWgC63X7tzJsvS8IAVdVaUm4RMGa49p6JsZlrghnjJMr0
   JHXNV+tW8/9n+wiO4JgnuJ/rpMKgX0/l2CLdTm0nVuSiE4IJ4Ucld9TOO
   BnptAwj+CF5nDKKKX4VnvRqA6raWAOFIabajSE+bVV/DkK9CcIEpcfArD
   Q==;
X-CSE-ConnectionGUID: srf7yLliQRKVMtiPq5wo6g==
X-CSE-MsgGUID: DHnCcy0UR0GBdgV6V2grEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32778775"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32778775"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:41:01 -0700
X-CSE-ConnectionGUID: 2zCiUT2sT/K/JgfOen6olA==
X-CSE-MsgGUID: KHi4TWIvQICfifSP7huU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84250933"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 21 Oct 2024 01:40:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 32C6935B; Mon, 21 Oct 2024 11:40:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Save a copy of the entire struct intel_scu_ipc_data
Date: Mon, 21 Oct 2024 11:38:53 +0300
Message-ID: <20241021084053.2443545-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save a copy of the entire struct intel_scu_ipc_data for easier
maintenance in case of expanding (adding new members become simpler).

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 33 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 3a1584ed7db8..f7db90a14afd 100644
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
@@ -255,7 +255,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 
 static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 {
-	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
+	return scu->data.irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
 static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
@@ -535,13 +535,13 @@ static irqreturn_t ioc(int irq, void *dev_id)
 
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
 
@@ -562,6 +562,7 @@ __intel_scu_ipc_register(struct device *parent,
 			 struct module *owner)
 {
 	int err;
+	struct intel_scu_ipc_data *data;
 	struct intel_scu_ipc_dev *scu;
 	void __iomem *ipc_base;
 
@@ -580,25 +581,25 @@ __intel_scu_ipc_register(struct device *parent,
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
@@ -621,7 +622,7 @@ __intel_scu_ipc_register(struct device *parent,
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


