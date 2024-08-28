Return-Path: <linux-kernel+bounces-304793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A29624F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494361C2339B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D01169397;
	Wed, 28 Aug 2024 10:30:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02B15ADA1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841014; cv=none; b=qyLs5x5uMeSPejMbH4utQL0eupuuJXWMCmLHDb+1mlZJcc209dauN9ekjGxvzjfndvd9BAD/Sj9szY09G10EuZU9oydNuLH6PM6YxTSHPxJR+//MgnNTZ32v8MxoIFA+YVHkWxxAB02mQqJ154GIgx8uIYQsOaO2e7aq0mK1swM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841014; c=relaxed/simple;
	bh=tl4bXxrneorO7LPMu5Pj4U4/ClB3wn/tN7BCbTp5m/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB5dJG3EU7hxSU6H48vf1mTExKrQ+k052NFVHPZMZYpSyGEXcCSRo7UjnV12DiMUg8m1BZ3i0klYWorfUbVhyVbhje7R5MHgtl67yvnKCYhwSnmUM79FaIeZkY0xOZDiIRzx1zfc+9+UjoZM9r+Q6+dEKQzKcvsaTvxLVys35TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wv0zB45Dcz1j7cl;
	Wed, 28 Aug 2024 18:29:58 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id AA80A1A016C;
	Wed, 28 Aug 2024 18:30:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 18:30:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <fbarrat@linux.ibm.com>, <ajd@linux.ibm.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] cxl: Remove unused cxl_pci_to_cfg_record()
Date: Wed, 28 Aug 2024 18:38:07 +0800
Message-ID: <20240828103807.3683308-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

cxl_pci_to_cfg_record() is not used anywhere, and its function can be
replacd with PCI_DEVID(), so remove it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/misc/cxl/vphb.c | 12 +-----------
 include/misc/cxl.h      |  4 ----
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 6332db8044bd..1cf614bf104d 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -72,11 +72,6 @@ static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
 	/* Should we do an AFU reset here ? */
 }
 
-static int cxl_pcie_cfg_record(u8 bus, u8 devfn)
-{
-	return (bus << 8) + devfn;
-}
-
 static inline struct cxl_afu *pci_bus_to_afu(struct pci_bus *bus)
 {
 	struct pci_controller *phb = bus ? pci_bus_to_host(bus) : NULL;
@@ -99,7 +94,7 @@ static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 {
 	int record;
 
-	record = cxl_pcie_cfg_record(bus->number, devfn);
+	record = PCI_DEVID(bus->number, devfn);
 	if (record > afu->crs_num)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -302,8 +297,3 @@ struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
 
-unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev)
-{
-	return cxl_pcie_cfg_record(dev->bus->number, dev->devfn);
-}
-EXPORT_SYMBOL_GPL(cxl_pci_to_cfg_record);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index d8044299d654..5ffa6e02bb07 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -23,10 +23,6 @@
 /* Get the AFU associated with a pci_dev */
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
 
-/* Get the AFU conf record number associated with a pci_dev */
-unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev);
-
-
 /*
  * Context lifetime overview:
  *
-- 
2.34.1


