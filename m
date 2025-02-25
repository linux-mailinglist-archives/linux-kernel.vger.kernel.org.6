Return-Path: <linux-kernel+bounces-530906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F37A43A04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112227A77C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8726739D;
	Tue, 25 Feb 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g80bBMzR"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256E26738F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476493; cv=none; b=a9NTlzUGvAmArlC3RGEJiCwwgw9efhDQFKqEEnnDdXhrD0wzovlNrSLkLTlsryiT1Ex5Zz1UWx0lW7uvRzg6bgs+MgtQyDWCTGAIyLyzfxruOL6K+wKVY7cL5eBjuKBgBE74om4OCYlhT2wD0y7Y0yIDolU/F5bVXAmf2qIoGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476493; c=relaxed/simple;
	bh=umBuQl2QuBFeO9IxtwbPuUMLEtLD5ox0Hz4hVd/Q4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1j4jJAWyBMHp8bBiTfZs6g3/9MSXN07Do+IxdBUk8Xzh3ousCDcYx070lxmPODSOp0+FNu/pNOkUh2ZplLe+rLqWcAjYVwCDHR/4nBcZe6cmBH9KMV44FCrTewOJ0s0Tbo+pjwKxQXLMGHinL4OaYPLQlnS1iHTl3EBgFhJfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g80bBMzR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740476488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FSnRdmhAXCNG5wX/lQk1babI2j58rDjAV131IDGWdyI=;
	b=g80bBMzRzAMxcAYS974A5/dRA0qkOeAEES2zpvFW3TWPKX2tuTB/O01ifs7pzhaVMsJM0L
	+x9/N3ZwZI/rgXAbH8007GRDKmq/oVmWyJn3dyrMnZhpU8t3ggnf6iaxV+2YJCkpy1IeZi
	262j01ErZq73lXdNqbGprfCvTZdZUkI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] scsi: hpsa: Use str_enabled_disabled() helper function
Date: Tue, 25 Feb 2025 10:41:08 +0100
Message-ID: <20250211102643.614133-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 84d8de07b7ae..ff49e93df4ed 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -36,6 +36,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/moduleparam.h>
+#include <linux/string_choices.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -469,7 +470,7 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
 	h->acciopath_status = !!status;
 	dev_warn(&h->pdev->dev,
 		"hpsa: HP SSD Smart Path %s via sysfs update.\n",
-		h->acciopath_status ? "enabled" : "disabled");
+		str_enabled_disabled(h->acciopath_status));
 	return count;
 }
 
@@ -560,7 +561,7 @@ static ssize_t host_show_hp_ssd_smart_path_status(struct device *dev,
 
 	h = shost_to_hba(shost);
 	return snprintf(buf, 30, "HP SSD Smart Path %s\n",
-		(h->acciopath_status == 1) ?  "enabled" : "disabled");
+		str_enabled_disabled(h->acciopath_status == 1));
 }
 
 /* List of controllers which cannot be hard reset on kexec with reset_devices */
-- 
2.48.1


