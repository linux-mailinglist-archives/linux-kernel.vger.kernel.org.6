Return-Path: <linux-kernel+bounces-197139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B018D66B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531551C245EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396815623B;
	Fri, 31 May 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R3yoT+pG"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1ED158D78
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172527; cv=none; b=cQrzwZrpMWbtpPKHYvGr0+Y1RHaOl3L0b7g13/YTsYUHoh/BVJLRtMPHCXJ6Jwjl24efyO9tm5eaB8iCa1g+vKXBZ68mvd6A+17Qqzivj/SaRBBHTt4QGgM+4zG9rg5c/BqkEItWioRyFz+FxGu8OxNnEmjxQsDfeQ+UIRGkXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172527; c=relaxed/simple;
	bh=mkb/nVcUv3NFAWt/4Kf8HdacRVGvAVCG1SNRZH1Zy8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZkPH+AVTfQ1r6OldoEDODdL5nxPQoZXfXr4FeuKyyKV2XyrejjMHuJOdARSabYRs8D6sh/VjbhD6zuclF4C5Tcb2Sw+RGGZN/sL+JsSsX/Q+zSbVyGhdUQomEsd3HeT2TWd0odZaPyWhGZtRSXlTnMtYc+u+sIba345jezT1bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R3yoT+pG; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717172527; x=1748708527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kkjdm7vLzgsvxwTIl6a+cQaY/194/UYr9RfyTUcw400=;
  b=R3yoT+pGSPNzWSY1vjdBBl53E0gvZbg+mXEUSHk0WUUEPVF67rc00LqG
   S7MFf987nH1K/u5ZOns6T9Ve1fEyWWQCcYR97JIlt8yuQjOXBPQFUsE6h
   Aripyz56m2lkpD7zYM8An15I7TdJji1WpSAXZ5/zKGF6uk5snXyQkVcsB
   0=;
X-IronPort-AV: E=Sophos;i="6.08,204,1712620800"; 
   d="scan'208";a="657753334"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 16:22:04 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:27507]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.93:2525] with esmtp (Farcaster)
 id 61aea3b8-f33e-485c-8066-25d0973a7946; Fri, 31 May 2024 16:22:02 +0000 (UTC)
X-Farcaster-Flow-ID: 61aea3b8-f33e-485c-8066-25d0973a7946
Received: from EX19D002EUA001.ant.amazon.com (10.252.50.66) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 16:22:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002EUA001.ant.amazon.com (10.252.50.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 16:22:01 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 16:22:01
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id EA07320BED; Fri, 31 May 2024 16:22:00 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Hemdan <hagarhem@amazon.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()
Date: Fri, 31 May 2024 16:21:44 +0000
Message-ID: <20240531162144.28650-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

its_vlpi_prop_update() calls lpi_write_config() which obtains the
mapping information for a VLPI without lock held. So it could race
with its_vlpi_unmap().
Since all calls from its_irq_set_vcpu_affinity() require the same
lock to be held. So instead of peppering the locking all over the
place, we hoist the locking into its_irq_set_vcpu_affinity().

This bug was discovered using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
v4: modified the commit msg.
Only compile-tested, no access to HW.
---
 drivers/irqchip/irq-gic-v3-its.c | 65 +++++++++++++-------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf1726393..f9e824ad1523 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1846,28 +1846,22 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
 	if (!info->map)
 		return -EINVAL;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
 	if (!its_dev->event_map.vm) {
 		struct its_vlpi_map *maps;
 
 		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
 			       GFP_ATOMIC);
-		if (!maps) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!maps)
+			return -ENOMEM;
 
 		its_dev->event_map.vm = info->map->vm;
 		its_dev->event_map.vlpi_maps = maps;
 	} else if (its_dev->event_map.vm != info->map->vm) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get our private copy of the mapping information */
@@ -1899,46 +1893,32 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 		its_dev->event_map.nr_vlpis++;
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_vlpi_map *map;
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
-	if (!its_dev->event_map.vm || !map) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !map)
+		return -EINVAL;
 
 	/* Copy our mapping information to the incoming request */
 	*info->map = *map;
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_unmap(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
-	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
+		return -EINVAL;
 
 	/* Drop the virtual mapping */
 	its_send_discard(its_dev, event);
@@ -1962,9 +1942,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 		kfree(its_dev->event_map.vlpi_maps);
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
@@ -1987,29 +1965,40 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_cmd_info *info = vcpu_info;
+	int ret;
 
 	/* Need a v4 ITS */
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
+
 	/* Unmap request? */
-	if (!info)
-		return its_vlpi_unmap(d);
+	if (!info) {
+		ret = its_vlpi_unmap(d);
+		goto out;
+	}
 
 	switch (info->cmd_type) {
 	case MAP_VLPI:
-		return its_vlpi_map(d, info);
+		ret = its_vlpi_map(d, info);
+		break;
 
 	case GET_VLPI:
-		return its_vlpi_get(d, info);
+		ret = its_vlpi_get(d, info);
+		break;
 
 	case PROP_UPDATE_VLPI:
 	case PROP_UPDATE_AND_INV_VLPI:
-		return its_vlpi_prop_update(d, info);
+		ret = its_vlpi_prop_update(d, info);
+		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+out:
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
+	return ret;
 }
 
 static struct irq_chip its_irq_chip = {
-- 
2.40.1


