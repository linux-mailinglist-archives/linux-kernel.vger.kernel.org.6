Return-Path: <linux-kernel+bounces-196421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61E8D5BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1058E28263A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154B74071;
	Fri, 31 May 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P327yaoV"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91225569
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141393; cv=none; b=Pfw4q+ISV1tiozUBEImUUkw697ae7D75XBmU7dK4fJcEaMcRC+DJpgZ5mDyUWzgPScut21iwnc9NSYrsy6y6lVQIjl3S0XPT72ogqrLksxqo6vSQC5vkX3qkSm2YaSDaHbSBKh+RbXuhHnXyL4JJutdE4sPl7JmqqbhxGLvOVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141393; c=relaxed/simple;
	bh=B0fGci5myXdi4dLPi1r9qzO7UZqSVS6IjHMJiUm1a3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfg4u3IWsHmuKcDJS2lXr3pkIaqArZcMQnWvggbPPvdkwJHe3E5vjW9tlXZalnrcf6sQvHYbfRpyJ4xUpX1ElEYY381NK6KWssWQRzxEtmZc3nLNUWFw96Rx9eKftiV0Q651SYJrAV65nHuTloXFBsOd257E+aa4mzp04TLtZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P327yaoV; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717141393; x=1748677393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/9TcEfcmlhOhbQiEqMm/468xXgoXewDL5g4J3m8ERMc=;
  b=P327yaoV+hH8En7p0/HxMaTQEvvG+43nPPtDXpvlvWxJFfgdUHNqaWGY
   6uYtzLuSEUPm7r9TDR6c818YRBqGCUY/TZOHqSHsC4J89q+ARtnEXSiVA
   S/Er3Wow/VHPHf19U54yzEAynWnFgVeHckrax1EH3gv4hvVeFnSgbV5LQ
   s=;
X-IronPort-AV: E=Sophos;i="6.08,203,1712620800"; 
   d="scan'208";a="208722784"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:43:10 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:52673]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.131:2525] with esmtp (Farcaster)
 id dc36c378-df5c-4d05-b391-0f404366b043; Fri, 31 May 2024 07:43:08 +0000 (UTC)
X-Farcaster-Flow-ID: dc36c378-df5c-4d05-b391-0f404366b043
Received: from EX19D008EUA004.ant.amazon.com (10.252.50.158) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 07:43:07 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 07:43:07 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 07:43:07
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 0A2E120BED; Fri, 31 May 2024 07:43:07 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Hemdan <hagarhem@amazon.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()
Date: Fri, 31 May 2024 07:43:02 +0000
Message-ID: <20240531074302.30563-1-hagarhem@amazon.com>
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

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
v2: moved the lock to its_irq_set_vcpu_affinity().
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


