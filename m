Return-Path: <linux-kernel+bounces-374456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E29A6A84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8635D1C241D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216E1F9434;
	Mon, 21 Oct 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9Xg79HQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9C1F81BA;
	Mon, 21 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517837; cv=none; b=CgKKq0pQSPMwbyTyL4zLUmxo0YcCuWWgROc7ULIfjS3Sfn9B+oZGLyknOlzm9AqIcmi6sjGTlUAnVAXu+pk9g2B5D3GL/h+DndgRQ0c6+8woNTQB4Eh4ifxtBb+f3sloLW7DsC51t2KypePgk0w9EkhypMHXS2tyUk+Z6fO0LA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517837; c=relaxed/simple;
	bh=wo7aF5ZvUXZQ0PELU9vp3n7/5nCTYh0tRuOckfMDusQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKwos7CK0uIR/6fC3yLAKRrzyzVTkdddTMRxGfZchBMXZin/UK5/YVkv8SNqXAgSTy/eFdCi7R2Va4Q4u6IImTqNLPbQXACPoO1xV890GXm/MNQ55IX3FxoJXLX6EuWHY7nEZKS5nM/jKSVJqcE2j3jx6llcPYvBewbcetXMcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9Xg79HQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517834; x=1761053834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wo7aF5ZvUXZQ0PELU9vp3n7/5nCTYh0tRuOckfMDusQ=;
  b=l9Xg79HQia0ly/SPmz3vUU129Jsu1Gckisbj8nc+4g/Ve2bYAZHSj2WZ
   ZMDuUpD7MELGovi0d2yfxaagjBwUj0MH6oY1+zrdvmPZ+pnGgsMpg+zX1
   qZzMJCFe9TjBU9e9yeDHeVxyg2QkKN5ElO6iKmvlzjZNn5oYfmsmDuIRR
   t265wZHxUhEyzSHN9Xc+tNXpgDBwLHRH3J81UBQYQ9nk+t/DbyB3s+XuL
   r/4nFsh0OBG/T7i1DdGTguUGmL/dUNXc+zBoyPZeKO+Ddl8628SBCsW6g
   2hWi/0/uH2ylVoi2pAgj+1ObRm4rMWrjDhCwnyB9sCA/sFa9Nkld3b5k+
   Q==;
X-CSE-ConnectionGUID: dKQzLTUCSUGen+IO16lSKA==
X-CSE-MsgGUID: V1vrB/dDQ/ONMXWS7vM13w==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29210975"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29210975"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:13 -0700
X-CSE-ConnectionGUID: D6WEVOM3RuyaFstWGXlQIg==
X-CSE-MsgGUID: yh6mnUuiQMeTFwoSqLUhsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="83544909"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2024 06:37:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7693C299; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 5/5] platform/x86: intel_scu_ipc: Save a copy of the entire struct intel_scu_ipc_data
Date: Mon, 21 Oct 2024 16:34:33 +0300
Message-ID: <20241021133705.2933464-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
References: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
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
index 2d25a0a86143..3acf6149a9ec 100644
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


