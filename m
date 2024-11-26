Return-Path: <linux-kernel+bounces-422888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0FB9D9F52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC320284535
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CF1DFDAD;
	Tue, 26 Nov 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xTLgQNyt"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CE198A0F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732661761; cv=none; b=sE+Dp32WVsT/cP97Qm4YSRWEwrIQt7XNT4GHg/PiRWUkoH1aq3kQhezE44g8JOFoLIz0vS09B1Pgk0wAddQu03yJoIO9X6/XIak6iVYe1Q0/qJfMSlyiot3PWXaTn0HNPLd8qI1OAxDwCUEVfcgxCXbCs1gQ5T7lii+W4sl1nUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732661761; c=relaxed/simple;
	bh=GhHOMs+vxxT1jwOnRTELheLJ+8Xm9jD0w46GgQlryrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dErGHUCwjs+oDypfdv9GZGK5iSS6tb9cHBOh7zxbWSQGW2PUuMJp0l8dm/mzXabvKa6NGfxtmbugEcjNmxeBb+dGOmJf/JdOnXfkuja621b362BJ4NBYEhO+fb6AjgFnVXN3EYWOA0UhP0t7lYLtkXARMbQtJ2D7yVjp5blQNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xTLgQNyt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea050e557dso7074138a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732661760; x=1733266560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B2U2QnHeL4PqqmXpoerOaG+5IxjA5hUVst4AVcSIjV4=;
        b=xTLgQNytuC6yG5fdYprQajJ1uJPhfgwIyDHl2TqjG5lBwr3PI5MHY9ayc+zGVsE9Ia
         VVGKPYjb1r53g3cSO7ff6pgugT9gNKRTtNP5Ez4G4puvicT0QKU2C30I1RpAGICVZFM2
         IRGH3/A8PQFiRkXVneKrqPlTsqa90ZDmyoDEabYyw/B0JUszVlAvbUNLSuYBAOEsvOph
         2ghNHuUyzQnD+0Dbk270gkBJL/ozeQeUr7ByBJROEeaaA0Vex9g5SWFG1I3vzCj2RIlk
         rAaBU2tTHLtoOedCe3mlmjY5t+F58p/EGH1y7mU5ZgTWb7rLz5ZDnqUV5LvSMncscIcv
         3P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732661760; x=1733266560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2U2QnHeL4PqqmXpoerOaG+5IxjA5hUVst4AVcSIjV4=;
        b=h4f4IGa/zFQpUsr1IzQc3F4kGVPF4ufWhrUezsuY1JcbxLZY8XsdsjYF/utF16iBm+
         l+WWK5xrgg/l97Y5ZK/n8v6P0/W+vqwSIfYfKvT1/g2mghpOwQRhXSxm05ORNWguZSv1
         qPH+lSPB74Hlwwd7yK/LBKEKkhwenpgzx2K+rCkzWu5kdt3QbRIh1TOpAxz7WIuzl7ma
         tL59+1n23RK6z6keRF7rPcBvzDmI7MZ0UnH3Kh+nPhK+t3DSfJzDo3cbrIPlz6LnP0Q7
         rD7KGZ1Wh1iGWMLnMmPDfmyrVhaWFCj+SCo5EmMYrRpFzU6LNubgC6FIPki71lE6qGBY
         4i7A==
X-Forwarded-Encrypted: i=1; AJvYcCVdg42N975+g2YZPetEJx9pPz8xy/sqGLur1ydfTQVuUy5NNu+GPFf/CIH5Kv5h0fvOpyFNnXaZXp3wpag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHg8XR+ZzLgE7+1iEU2G1CzFTTXpH9lmsMbjR38J/qrYzdCrAX
	V7F58VyA4M/+Uypu3+jhWn502gPpRiHnjBKfPaudDcbU0joiCLyHCKfZlNmT/EF/vI7dnkh/JEl
	vsqOX6UYrRgFe96oqqHRCjg==
X-Google-Smtp-Source: AGHT+IEy9RbOOr+nDVt72s/Y6H53mHrVN1XRKMPVMEBBgpfg6jX30ZJ4EaTDh5qg4aXKlqJvNLibAoR7+TQYCM14Eg==
X-Received: from pjtd9.prod.google.com ([2002:a17:90b:49:b0:2ea:958a:96d7])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b41:b0:2ea:5c01:c1ba with SMTP id 98e67ed59e1d1-2ee097bd261mr1114765a91.23.1732661759768;
 Tue, 26 Nov 2024 14:55:59 -0800 (PST)
Date: Tue, 26 Nov 2024 22:55:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126225546.975441-1-salomondush@google.com>
Subject: [PATCH] scsi: pm80xx: Improve debugging for aborted commands
From: Salomon Dushimirimana <salomondush@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishakha Channapattan <vishakhavc@google.com>, Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vishakha Channapattan <vishakhavc@google.com>

This patch improves the debugging capabilities of the driver by adding
more context to debug messages

1. Introduces a new function to show pending commands
2. Include the tag number in NCQ EH path debug messages
3. Adds logging for ata_tag along with pm80xx tag to map IOs aborted
   with ata logs.

Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
Signed-off-by: Vishakha Channapattan <vishakhavc@google.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c |  5 +--
 drivers/scsi/pm8001/pm8001_sas.c | 57 ++++++++++++++++++++++++++++++++
 drivers/scsi/pm8001/pm8001_sas.h |  2 ++
 drivers/scsi/pm8001/pm80xx_hwi.c | 22 ++++++++----
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index dec1e2d380f1..42a4eeac24c9 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3472,12 +3472,13 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			   status, tag, scp);
 	switch (status) {
 	case IO_SUCCESS:
-		pm8001_dbg(pm8001_ha, EH, "IO_SUCCESS\n");
+		pm8001_dbg(pm8001_ha, FAIL, "ABORT IO_SUCCESS for tag %#x\n",
+			   tag);
 		ts->resp = SAS_TASK_COMPLETE;
 		ts->stat = SAS_SAM_STAT_GOOD;
 		break;
 	case IO_NOT_VALID:
-		pm8001_dbg(pm8001_ha, EH, "IO_NOT_VALID\n");
+		pm8001_dbg(pm8001_ha, FAIL, "IO_NOT_VALID for tag %#x\n", tag);
 		ts->resp = TMF_RESP_FUNC_FAILED;
 		break;
 	}
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ee2da8e49d4c..b81191656c26 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -101,6 +101,63 @@ int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 	return 0;
 }
 
+static void pm80xx_get_tag_opcodes(struct sas_task *task, int *ata_op,
+								   int *ata_tag, bool *task_aborted)
+{
+	unsigned long flags;
+	struct ata_queued_cmd *qc = NULL;
+
+	*ata_op = 0;
+	*ata_tag = -1;
+	*task_aborted = false;
+
+	if (!task)
+		return;
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (unlikely((task->task_state_flags & SAS_TASK_STATE_ABORTED)))
+		*task_aborted = true;
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	if (task->task_proto == SAS_PROTOCOL_STP) {
+		// sas_ata_qc_issue path uses SAS_PROTOCOL_STP.
+		// This only works for scsi + libsas + libata users.
+		qc = task->uldd_task;
+		if (qc) {
+			*ata_op = qc->tf.command;
+			*ata_tag = qc->tag;
+		}
+	}
+}
+
+void pm80xx_show_pending_commands(struct pm8001_hba_info *pm8001_ha,
+				  struct pm8001_device *target_pm8001_dev)
+{
+	int i = 0, ata_op = 0, ata_tag = -1;
+	struct pm8001_ccb_info *ccb = NULL;
+	struct sas_task *task = NULL;
+	struct pm8001_device *pm8001_dev = NULL;
+	bool task_aborted;
+
+	for (i = 0; i < pm8001_ha->ccb_count; i++) {
+		ccb = &pm8001_ha->ccb_info[i];
+		if (ccb->ccb_tag == PM8001_INVALID_TAG)
+			continue;
+		pm8001_dev = ccb->device;
+		if (target_pm8001_dev && pm8001_dev &&
+		    target_pm8001_dev != pm8001_dev)
+			continue;
+		task = ccb->task;
+		pm80xx_get_tag_opcodes(task, &ata_op, &ata_tag, &task_aborted);
+		pm8001_dbg(pm8001_ha, FAIL,
+			"tag %#x, device %#x task %p task aborted %d ata opcode %#x ata tag %d\n",
+			ccb->ccb_tag,
+			(pm8001_dev ? pm8001_dev->device_id : 0),
+			task, task_aborted,
+			ata_op, ata_tag);
+	}
+}
+
 /**
  * pm8001_mem_alloc - allocate memory for pm8001.
  * @pdev: pci device.
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ced6721380a8..a73d1382cbc5 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -785,6 +785,8 @@ static inline void pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
 }
 void pm8001_setds_completion(struct domain_device *dev);
 void pm8001_tmf_aborted(struct sas_task *task);
+void pm80xx_show_pending_commands(struct pm8001_hba_info *pm8001_ha,
+				  struct pm8001_device *dev);
 
 #endif
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index a9869cd8c4c0..1b9aaea26148 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2245,7 +2245,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 	u32 param;
 	u32 status;
 	u32 tag;
-	int i, j;
+	int i, j, ata_tag = -1;
 	u8 sata_addr_low[4];
 	u32 temp_sata_addr_low, temp_sata_addr_hi;
 	u8 sata_addr_hi[4];
@@ -2255,6 +2255,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 	u32 *sata_resp;
 	struct pm8001_device *pm8001_dev;
 	unsigned long flags;
+	struct ata_queued_cmd *qc;
 
 	psataPayload = (struct sata_completion_resp *)(piomb + 4);
 	status = le32_to_cpu(psataPayload->status);
@@ -2266,8 +2267,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 	pm8001_dev = ccb->device;
 
 	if (t) {
-		if (t->dev && (t->dev->lldd_dev))
+		if (t->dev && (t->dev->lldd_dev)) {
 			pm8001_dev = t->dev->lldd_dev;
+			qc = t->uldd_task;
+			ata_tag = qc ? qc->tag : -1;
+		}
 	} else {
 		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
 			   ccb->ccb_tag);
@@ -2275,16 +2279,14 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 		return;
 	}
 
-
 	if (pm8001_dev && unlikely(!t->lldd_task || !t->dev))
 		return;
 
 	ts = &t->task_status;
-
 	if (status != IO_SUCCESS) {
 		pm8001_dbg(pm8001_ha, FAIL,
-			"IO failed device_id %u status 0x%x tag %d\n",
-			pm8001_dev->device_id, status, tag);
+			"IO failed status %#x pm80xx tag %#x ata tag %d\n",
+			status, tag, ata_tag);
 	}
 
 	/* Print sas address of IO failed device */
@@ -2666,13 +2668,19 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha,
 
 	/* Check if this is NCQ error */
 	if (event == IO_XFER_ERROR_ABORTED_NCQ_MODE) {
+		/* tag value is invalid with this event */
+		pm8001_dbg(pm8001_ha, FAIL, "NCQ ERROR for device %#x tag %#x\n",
+			dev_id, tag);
+
 		/* find device using device id */
 		pm8001_dev = pm8001_find_dev(pm8001_ha, dev_id);
 		/* send read log extension by aborting the link - libata does what we want */
-		if (pm8001_dev)
+		if (pm8001_dev) {
+			pm80xx_show_pending_commands(pm8001_ha, pm8001_dev);
 			pm8001_handle_event(pm8001_ha,
 				pm8001_dev,
 				IO_XFER_ERROR_ABORTED_NCQ_MODE);
+		}
 		return;
 	}
 
-- 
2.47.0.338.g60cca15819-goog


