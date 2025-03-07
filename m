Return-Path: <linux-kernel+bounces-550173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFF4A55C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4923AB005
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519F3D984;
	Fri,  7 Mar 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UUqHVjyM"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858B13A86C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308465; cv=none; b=JHxrU5l5eANm7KO3Vo6/bLkEYz8xEVL0NO9arWgVAtpd1Q14PW8eHTsmkeKToi2xmypin0oltt3sJVZLo/t1gHIN5bw2xCjDHOr/R5YCKs0we0pnPQ87NVJ6cP0ZBPay8xe6G7B00XpJtxlq4cjJnEx/GU+9ikv3SR4vI6KH98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308465; c=relaxed/simple;
	bh=1WfFY7Y76qjA0qk8n517Y13yeqgmZkG35LDBzqImrsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP95p3LGg6thKCFH7bgZ6knuPJwoflwpQq0ni+bHWKlhzCCaSlykltlDBbIlDGvh48XzZLHBhNWeIFD5tG3qFBexK85bBBB5txORh9uTzmeyzuCcsnk3S4DlpSIIWZybWH6YiBw3hMF8lVwfpbCTnTpHXIlpwp5aDqEVrDIHXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UUqHVjyM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=YCYD+T9+FjJKiym2zwCOFkdlpqOZMAK+Qe99zxgMH6s=; b=UUqHVjyMM8WUReiU
	A4ca7U+tiC0+qNH8lB6X5qSexXMCQClFL2J2nTEE19AVd1QoC0fB+z8NClnd2OwKELQY/Vph8Vwsk
	vvm6xprdC2RUCe29yvcMXr9q5/owfpwSLZjUJ1nghsSDF/YXrKOOmhCCt8soHPttjnkMqBrSameBH
	l+eFOl3scc/GHQkcJosyJ2yUDLJ0t5C9Ml/wo65DLqL4xIug3CNYhYgBwhXEjy78cXYVwkZWeRJTx
	AYTIxFF6BMVoeR0K/OAOF31LZHOTiSb9eHLN21eCTWf6hcKy5ijymaxrNgvMKjsvgRYxSI9J0DaGw
	k0q45Pc2MWKspgBivg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqLsH-003H7O-1H;
	Fri, 07 Mar 2025 00:47:37 +0000
From: linux@treblig.org
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] xen/pciback: Remove unused pcistub_get_pci_dev
Date: Fri,  7 Mar 2025 00:47:36 +0000
Message-ID: <20250307004736.291229-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pcistub_get_pci_dev() was added in 2009 as part of:
commit 30edc14bf39a ("xen/pciback: xen pci backend driver.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/xen/xen-pciback/pci_stub.c | 20 --------------------
 drivers/xen/xen-pciback/pciback.h  |  2 --
 2 files changed, 22 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index b616b7768c3b..5c2f829d5b0b 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -262,26 +262,6 @@ struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
 	return found_dev;
 }
 
-struct pci_dev *pcistub_get_pci_dev(struct xen_pcibk_device *pdev,
-				    struct pci_dev *dev)
-{
-	struct pcistub_device *psdev;
-	struct pci_dev *found_dev = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pcistub_devices_lock, flags);
-
-	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
-		if (psdev->dev == dev) {
-			found_dev = pcistub_device_get_pci_dev(pdev, psdev);
-			break;
-		}
-	}
-
-	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
-	return found_dev;
-}
-
 /*
  * Called when:
  *  - XenBus state has been reconfigure (pci unplug). See xen_pcibk_remove_device
diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index f9599ed2f2e2..b786c1f74f85 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -67,8 +67,6 @@ extern struct list_head xen_pcibk_quirks;
 struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
 					    int domain, int bus,
 					    int slot, int func);
-struct pci_dev *pcistub_get_pci_dev(struct xen_pcibk_device *pdev,
-				    struct pci_dev *dev);
 void pcistub_put_pci_dev(struct pci_dev *dev);
 
 static inline bool xen_pcibk_pv_support(void)
-- 
2.48.1


