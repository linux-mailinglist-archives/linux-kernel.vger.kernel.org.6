Return-Path: <linux-kernel+bounces-522002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A31A3C4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E925E3B0492
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2AB1FDE02;
	Wed, 19 Feb 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iyc7//9R"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C86748F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981896; cv=none; b=eoYuBYgqpkTIi52A0ckOOODt0pLPqwCJKq9nEFymSTPDe6iUiZ+RsJhhwOiJEXjNwNcqsD74gnapk6veRNWh2kepbJ0zzkf9I06wIQ4tij0PmrEVuppDdv6igQN1FdMTcB6IGtscCiydzGR4UdTE60wHwQrWK1HriEGuRKg/ARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981896; c=relaxed/simple;
	bh=Uhn507R8K/kps72rHsNEWrDzj3Jw8mZmyak4Q3dWwck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSDUhBeX5hQFoymZSeSef6Trluz2Z9wiNGG5S53OcSkiKuypdg6L5+vUabWpb1LJHmGBPr+GdFda5rXiZvuDkLMT399fFLx6uVfslIbee0U3KdBLtZ3TpFzmtVEvUmSNb15S1OyDCSBX34+bwDidIh6klzDyxqQC3N421PtqiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iyc7//9R; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739981879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Gj4AI+bThVGyYDQmC4PfVFErBgnDlOQcTWIIrTFHvs=;
	b=iyc7//9R8jDPQ2AUDVouJvNnSx4XugD+RVzDU0FZddiiUAigSRS2+Wq0TYKqO4QPQkHuSy
	5JLKk7G3RaFSE4zzpPLVkD4togg++q+81IKVi+z04jkdVSHFcMz88SPTgy9cg83MyTd0XY
	oaDdtNBbgeQbfVYqVeaVQ3nO7+M4iE0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vishal Bhakta <vishal.bhakta@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] scsi: vmw_pvscsi: Use str_enabled_disabled() helper in pvscsi_probe()
Date: Wed, 19 Feb 2025 17:17:17 +0100
Message-ID: <20250219161716.24015-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
warning.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/vmw_pvscsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 32242d86cf5b..4927c6a33bd8 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
+#include <linux/string_choices.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
@@ -1508,8 +1509,8 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_reset_adapter;
 
 	adapter->use_req_threshold = pvscsi_setup_req_threshold(adapter, true);
-	printk(KERN_DEBUG "vmw_pvscsi: driver-based request coalescing %sabled\n",
-	       adapter->use_req_threshold ? "en" : "dis");
+	pr_debug("vmw_pvscsi: driver-based request coalescing %s\n",
+		 str_enabled_disabled(adapter->use_req_threshold));
 
 	if (adapter->dev->msix_enabled || adapter->dev->msi_enabled) {
 		printk(KERN_INFO "vmw_pvscsi: using MSI%s\n",
-- 
2.48.1


