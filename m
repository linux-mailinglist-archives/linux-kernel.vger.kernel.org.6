Return-Path: <linux-kernel+bounces-442961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573379EE4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C193C18845FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE5210F47;
	Thu, 12 Dec 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pfjgu2/m"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA11EC4D2;
	Thu, 12 Dec 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001362; cv=none; b=XVg0ZbYda1otwE7jtrvK/6bgc6BoXcjjFIqjg1ar0rHHM4eRbv7FmkFl3ilqdOE04vqLEozLEiRpwycbVz/Yo6a6ULtH3USl0pTiKfIo1DmjVjJ3eBiGzZC65kW3eIO0REPmG0rQkDGkhYxNQTZHggmEJHHB1REJzF7usNCWmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001362; c=relaxed/simple;
	bh=L6fYlSa0pWcWtejpf6QX6Y/+ZaZXu2ZEOObJx1BoVKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOgqjq3wt5Nf+hL0LDHWK5hM678vA2T2mRruAe9cWoCb4VioqRUmiyeZhin4IU8BzxUSVed30Jv/GV30PU9RxFfclwKlHc/CpKFzfkiA5fDEHNzz2sbiLkKA+iqioAT/S7VWZFGnLMnhhC/pQyrkTfhzYP+WuylkP4RWILTJ2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pfjgu2/m; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5LAc7019383;
	Thu, 12 Dec 2024 05:02:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=g8zyB4C4ilx5HyG9
	sMBfAEz2Jle8HIXNcBSrgsEN9/E=; b=pfjgu2/mrUWU9UUUXuT08Js11DM8KElI
	bIzn/byQ4eRk3ilDLmnyGG6IalpLy4nF2DgVYL0wRkjaVhbjuzNLLx8XNNGGJu7v
	8C3WaNkVDGhu+RfMfMuNNFkm2PLV4siOQo3CBG2v8xtW8ChX55iVrXbSsy7WgX2M
	z7BG4MQYbcZuDFO6ntcmtC1/dYa0jxa9kqiJbxfHMHz+yZ5dvdI7kywHhBjsTXu4
	dR38HH2p7w2Rwnns4CCZKSY+P//V9N8D2uZ7LqlNBMB3Sbs/BhYZMBKjXy1xl1ie
	R0xIBEXLcQSMUem7Yk+4Qz2XU29iXErgyvqjC82PjoN/Jbq9uNTYRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkep8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 05:02:23 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 11:02:21 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 11:02:21 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8F73F822548;
	Thu, 12 Dec 2024 11:02:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] soundwire: intel_auxdevice: Don't disable IRQs before removing children
Date: Thu, 12 Dec 2024 11:02:21 +0000
Message-ID: <20241212110221.1509163-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rh8HDNArKBzX-BhhXBgB880wG-QzCIPA
X-Proofpoint-GUID: rh8HDNArKBzX-BhhXBgB880wG-QzCIPA
X-Proofpoint-Spam-Reason: safe

Currently the auxiliary device for the link disables IRQs before it
calls sdw_bus_master_delete(). This has the side effect that
none of the devices on the link can access their own registers whilst
their remove functions run, because the IRQs are required for bus
transactions to function. Obviously, devices should be able to access
their own registers during disable to park the device suitably.

It would appear the reason for the disabling of the IRQs is that the IRQ
handler iterates through a linked list of all the links, once a link is
removed the memory pointed at by this linked list is freed, but not
removed from the linked_list itself. Add a list_del() for the linked
list item, note whilst the list itself is contained in the intel_init
portion of the code, the list remove needs to be attached to the
auxiliary device for the link, since that owns the memory that the list
points at. Locking is also required to ensure the IRQ handler runs
before or after any additions/removals from the list.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/intel.h           |  1 +
 drivers/soundwire/intel_auxdevice.c |  5 ++++-
 drivers/soundwire/intel_init.c      | 16 ++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index dddd293814418..4df582ceaed1a 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -45,6 +45,7 @@ struct sdw_intel_link_res {
 	u32 link_mask;
 	struct sdw_cdns *cdns;
 	struct list_head list;
+	struct mutex *link_lock; /* lock protecting list */
 	struct hdac_bus *hbus;
 };
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 599954d927529..5b2bbafef1ac0 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -498,9 +498,12 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	if (!bus->prop.hw_disabled) {
 		sdw_intel_debugfs_exit(sdw);
 		cancel_delayed_work_sync(&cdns->attach_dwork);
-		sdw_cdns_enable_interrupt(cdns, false);
 	}
+
 	sdw_bus_master_delete(bus);
+
+	if (!bus->prop.hw_disabled)
+		sdw_cdns_enable_interrupt(cdns, false);
 }
 
 int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 12e7a98f319f8..db49ee3808151 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -28,6 +28,15 @@ static void intel_link_dev_release(struct device *dev)
 	kfree(ldev);
 }
 
+static void intel_link_list_del(void *data)
+{
+	struct sdw_intel_link_res *link = data;
+
+	mutex_lock(link->link_lock);
+	list_del(&link->list);
+	mutex_unlock(link->link_lock);
+}
+
 /* alloc, init and add link devices */
 static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *res,
 							  struct sdw_intel_ctx *ctx,
@@ -78,6 +87,7 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 		link->shim_vs = res->mmio_base + SDW_SHIM2_VS_BASE(link_id);
 		link->shim_lock = res->eml_lock;
 	}
+	link->link_lock = &ctx->link_lock;
 
 	link->ops = res->ops;
 	link->dev = res->dev;
@@ -144,8 +154,10 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id)
 	struct sdw_intel_ctx *ctx = dev_id;
 	struct sdw_intel_link_res *link;
 
+	mutex_lock(&ctx->link_lock);
 	list_for_each_entry(link, &ctx->link_list, list)
 		sdw_cdns_irq(irq, link->cdns);
+	mutex_unlock(&ctx->link_lock);
 
 	return IRQ_HANDLED;
 }
@@ -209,6 +221,7 @@ static struct sdw_intel_ctx
 	ctx->link_mask = res->link_mask;
 	ctx->handle = res->handle;
 	mutex_init(&ctx->shim_lock);
+	mutex_init(&ctx->link_lock);
 
 	link_mask = ctx->link_mask;
 
@@ -245,7 +258,10 @@ static struct sdw_intel_ctx
 			i++;
 			goto err;
 		}
+		mutex_lock(&ctx->link_lock);
 		list_add_tail(&link->list, &ctx->link_list);
+		mutex_unlock(&ctx->link_lock);
+		devm_add_action_or_reset(&ldev->auxdev.dev, intel_link_list_del, link);
 		bus = &link->cdns->bus;
 		/* Calculate number of slaves */
 		list_for_each(node, &bus->slaves)
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 580086417e4b0..4444c99aead5f 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -304,6 +304,7 @@ struct sdw_intel_ctx {
 	acpi_handle handle;
 	struct sdw_intel_link_dev **ldev;
 	struct list_head link_list;
+	struct mutex link_lock; /* lock protecting link_list */
 	struct mutex shim_lock; /* lock for access to shared SHIM registers */
 	u32 shim_mask;
 	u32 shim_base;
-- 
2.39.5


