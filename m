Return-Path: <linux-kernel+bounces-195278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD68D49F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBEB23AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2F17C7D9;
	Thu, 30 May 2024 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aZcx3la3"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B01078B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066678; cv=none; b=QxMv/RQ9ZE8kV1z08hTFyikZJgxTMaWL3IEel2n7lhJDS7/m2sU2Wxel2nc2bgH8t/+OZ8k5AlsJqbRFQQMjL2rmfRfUNxb8TNiNmZ+wpYKgxrvVgSlyD8CfG179YcryrNo3jeU1ZD63SgI8P7Bn2jwLY+izGCc+mFYo+J2ABK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066678; c=relaxed/simple;
	bh=i+syEPO/mfE9NznXfzWiBqbRQlJzDIO15u7Xl6jZyq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDjQZ4vKh3JVsrmtf9DwZg1t6qznSLgZyBC3jykhF31FvtgeMhRyJfOJhWxtVyvhwn3M4x2cJbThslQzDAiJpGF0O/WBS8vQNqz2IsMByUe1UsQONY0gSKNVfseXOmCC6P+U5AYJNVZbqQQT7SsypeO7fusp4Hnd/u0gLrrUdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aZcx3la3; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717066677; x=1748602677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNAz+Hha0bmN2XUtJxDAuc8OhG7Yy7pJmC4MZGBwtNs=;
  b=aZcx3la3SdhDBEGduXqDe9U01Zhkyu/MvJW1GZeee4qE5PMhntWplNXy
   ZhQR+A6j9yu3TpAKHJ1jnkrVDg6ztW9jvoFwYaeifEN0Tj4Di2EPTMzoD
   OjqZZqz0Ud8Ttve9gSV8R/OVtdgwy2qqxVyNVuziaO3kfEtTo1FWJe2bK
   s=;
X-IronPort-AV: E=Sophos;i="6.08,201,1712620800"; 
   d="scan'208";a="422619734"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:57:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:17304]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.54:2525] with esmtp (Farcaster)
 id 44dc4b34-d413-4333-8c5d-1be55b7bb1ac; Thu, 30 May 2024 10:57:48 +0000 (UTC)
X-Farcaster-Flow-ID: 44dc4b34-d413-4333-8c5d-1be55b7bb1ac
Received: from EX19D002EUA003.ant.amazon.com (10.252.50.18) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 30 May 2024 10:57:47 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 30 May 2024 10:57:47 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 30 May 2024 10:57:47
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id DFCB820C69; Thu, 30 May 2024 10:57:46 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Hemdan <hagarhem@amazon.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()
Date: Thu, 30 May 2024 10:57:13 +0000
Message-ID: <20240530105713.18552-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Similar to commit 046b5054f566 ("irqchip/gic-v3-its: Lock VLPI map array
before translating it"), its_vlpi_prop_update() calls lpi_write_config()
which obtains the mapping information for a VLPI.
This should always be done with vlpi_lock for this device held. Otherwise,
its_vlpi_prop_update() could race with its_vlpi_unmap().

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf1726393..ecaad1786345 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1970,9 +1970,13 @@ static int its_vlpi_unmap(struct irq_data *d)
 static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	int ret = 0;
 
-	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
-		return -EINVAL;
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
+	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (info->cmd_type == PROP_UPDATE_AND_INV_VLPI)
 		lpi_update_config(d, 0xff, info->config);
@@ -1980,7 +1984,9 @@ static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
 		lpi_write_config(d, 0xff, info->config);
 	its_vlpi_set_doorbell(d, !!(info->config & LPI_PROP_ENABLED));
 
-	return 0;
+out:
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
+	return ret;
 }
 
 static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
-- 
2.40.1


