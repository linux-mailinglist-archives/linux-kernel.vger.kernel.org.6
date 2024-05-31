Return-Path: <linux-kernel+bounces-196652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B0D8D5F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951381F22461
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259E149C76;
	Fri, 31 May 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZMDvBt0G"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01718EB1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150302; cv=none; b=Nr1LxvDObGIuHq3H9j09o2bfWGklwnqy0lX/rw+Q5MWU8RBJZnkDMYFHIq8Ea8jQe8sw4iKb31JjpoqaMTlB70JXWCycF+NnhxhN8cGbgihEdJzd6zIIL1hfdG9tTumGxW924Q9JqE5fY6Xl3nYwb4DWremRpk/T3izIUNKctjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150302; c=relaxed/simple;
	bh=MyxygUsHoTylUkeP5zizwXQJIm9aI+UjzKA9qH5IL28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7pe2KQM3guCds2rqZ/c9IVRxac8ut6q+TnTdKtVazqfAcH9e7+xvOEVuq/maxh8E32/qZNN5qQ95CznqwuM3ttMUxLkzo4l1RtCxTpFn4KlBwbkINFjpWP7nmp5FaCgLtX1TnWgi3f03j+zTBpeyV2eN6rLYZcGDRjYFZWBjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZMDvBt0G; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717150300; x=1748686300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kUh6eiCVMxqDDhVCxUtvDHYES6nckE+MfNknszNpkPQ=;
  b=ZMDvBt0GQ4DHLCadISqIomBUsVUgqepdyEnCNYEyJj29blofYqWNJEGn
   nWm5r4H05tcsMzmZSf6u65Q/lfg+sDgYjAbWdCaMtEzbJEwKB1M/PIYJn
   Q4x971g6JLneHMoNgqvLTk8hDxDbHhHb3IrhW+zTwl14N6Ve9fT7sghQ9
   w=;
X-IronPort-AV: E=Sophos;i="6.08,204,1712620800"; 
   d="scan'208";a="93195519"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:11:38 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:51996]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.62:2525] with esmtp (Farcaster)
 id f8c98574-d089-4841-94c8-b5e136744ffa; Fri, 31 May 2024 10:11:37 +0000 (UTC)
X-Farcaster-Flow-ID: f8c98574-d089-4841-94c8-b5e136744ffa
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 10:11:37 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 10:11:37 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 10:11:36
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 736B720AC2; Fri, 31 May 2024 10:11:36 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Hemdan <hagarhem@amazon.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()
Date: Fri, 31 May 2024 10:11:31 +0000
Message-ID: <20240531101131.26506-1-hagarhem@amazon.com>
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
Suggested-by: Marc Zyngier <maz@kernel.org>
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


