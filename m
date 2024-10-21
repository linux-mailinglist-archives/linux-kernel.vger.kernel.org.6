Return-Path: <linux-kernel+bounces-375098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22249A90E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFA1C2201B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774BA1FBF56;
	Mon, 21 Oct 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRzObLMc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8C19EEC4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541921; cv=none; b=JzFj+tAAbdu1WFX7kuMdIf8oow3aIzGpmRTtG+uv/r3vfj2Dpz9ESxNzIZbWEw+w//in8w7DCYgKGINJHMqtn+6pYXleZEYvvAkSpXuFuHF7tOslfQVzzCCiiUEWyDF60+vW28uLKRLPpdK55EznjbrfE/1dG4H4rysB7XvimVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541921; c=relaxed/simple;
	bh=9Gj/jW1MB+dyTX+ZFqtjWJywSQcP6u5NAgXUWiH8RL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nDjSMtUrTpkMpuqAmlqEMCIlRRvG0X8nX/m9d32U7U4msv1BmJO/U7eNhC2APt6xZWBLF/kKdaXnt3JEONDOI0gr8trUaWM4y0kQbhqiXs+v6oLd2eUL36AegNViH6156d8ARR18DuKetrBFOHBW8TFkMHuzSifqAyhONXtDOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRzObLMc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370d76c15so90946347b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729541919; x=1730146719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnh2nzSdhlx2y3A9xhxtGt0QYxcm3xF/mRsViTfWQlQ=;
        b=FRzObLMcAW6FWC/jVk7RHEru50/ziu5/naMH4VG4PTVyI4V251+CM0lFs0WlZp4GcC
         s+D4x+RRj2v5U7DwZ9iNH4TtkDw9fqWmfsEfJsW2XhB4FWBTQLuYsFHCKXS34GA3jX90
         owKWZMeGNe0Q4SAnE8xGJOaLgEJ2l7BgpubOluywEWsGGXaB3BizFhLYMu4Bhw0vgZ+x
         Xao1m6KGAwIh3OkjL4xXwKtdpwYbiHzQMSuo2nyEAkLKWYBU76oM+eqLsTd+6FPTs1NJ
         pM4qu5qpSvOHCl+17KJXBii8dEGsbi52xPtQrwoTZAVziyopJTZtdjlLP5QLZocedxyt
         ng4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541919; x=1730146719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnh2nzSdhlx2y3A9xhxtGt0QYxcm3xF/mRsViTfWQlQ=;
        b=iggs/BKsMCBFCes9tzNhZWTw/wj0/sYX2YG7z4en1FvV+yT2eksnkSzON/BPUbwJC6
         w2ns3PvxZSV0HtKz3uhrnvC6kRrZiSTk7z47MXDWWvnox0dsPgzedN4KF3aR3raUGuzW
         /7NVxT1c5ZkWPICiO+bDeXqWdNfehbdpySsATYPWvCgmzDAaLp8b4Q7raj67mAj4Ff53
         sFP6HYOn1K+nYEY3NuhidqQa4nLAkRNvyXHz16AKOhATYF2XMh8AgJY+A/bYha7SXYNw
         xs8ln+upkqhyZD6CGcTeWyvRiocyjtxD7Y5eI32Vg3ymKRb6N3s3NMpEiZdNvwLs6jor
         9+bA==
X-Forwarded-Encrypted: i=1; AJvYcCVSw1naVyBSvktl+sN7LjR3sqmfePQmz1gQQd2a4yu+vxy8nZ22xGWa3T79Yj1IXnTigMMlAL1Dfhn9XqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSD42bkC716wLTR2HE3FEtd1gmYfgafAzlZxQzffmtdxX4oJL
	i7Bpnn7/I3Ojxps1Vvunh42Kj6//aLYr+Cb1xuhRPoFOnOPIlGfkE4jkJ0tttvaKrjdKo4/tLRb
	0PbNKWGoy0w==
X-Google-Smtp-Source: AGHT+IF066Si3BOFxjLkWn+rMxHThsNuEv9DNgP2bpLiRq/sQMSkJEEP7mYtUIpakSK7wQYaE+awk/7RByL2KQ==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:13f:f798:ac1c:499f])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:6902:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6e5bfb868e1mr3110627b3.2.1729541919388; Mon, 21 Oct 2024
 13:18:39 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:18:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021201828.1378858-1-tadamsjr@google.com>
Subject: [PATCH] scsi: pm8001: Initialize devices in pm8001_alloc_dev()
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

Devices can be allocated and freed at runtime. For example during
a soft reset all devices are freed and reallocated upon discovery.

Currently driver fully initializes devices once in pm8001_alloc().
This commit allows initialization steps to happen during runtime,
avoiding any leftover states from the device being freed.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm8001_init.c |  3 ---
 drivers/scsi/pm8001/pm8001_sas.c  | 17 ++++++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca1..ab961ab3224a 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -447,9 +447,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	}
 	for (i = 0; i < PM8001_MAX_DEVICES; i++) {
 		pm8001_ha->devices[i].dev_type = SAS_PHY_UNUSED;
-		pm8001_ha->devices[i].id = i;
-		pm8001_ha->devices[i].device_id = PM8001_MAX_DEVICES;
-		atomic_set(&pm8001_ha->devices[i].running_req, 0);
 	}
 	pm8001_ha->flags = PM8001F_INIT_TIME;
 	return 0;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ee2da8e49d4c..d80cffd25a6e 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -572,6 +572,13 @@ void pm8001_ccb_task_free(struct pm8001_hba_info *pm8001_ha,
 	pm8001_ccb_free(pm8001_ha, ccb);
 }
 
+static void pm8001_init_dev(struct pm8001_device *pm8001_dev, int id)
+{
+	pm8001_dev->id = id;
+	pm8001_dev->device_id = PM8001_MAX_DEVICES;
+	atomic_set(&pm8001_dev->running_req, 0);
+}
+
 /**
  * pm8001_alloc_dev - find a empty pm8001_device
  * @pm8001_ha: our hba card information
@@ -580,9 +587,11 @@ static struct pm8001_device *pm8001_alloc_dev(struct pm8001_hba_info *pm8001_ha)
 {
 	u32 dev;
 	for (dev = 0; dev < PM8001_MAX_DEVICES; dev++) {
-		if (pm8001_ha->devices[dev].dev_type == SAS_PHY_UNUSED) {
-			pm8001_ha->devices[dev].id = dev;
-			return &pm8001_ha->devices[dev];
+		struct pm8001_device *pm8001_dev = &pm8001_ha->devices[dev];
+
+		if (pm8001_dev->dev_type == SAS_PHY_UNUSED) {
+			pm8001_init_dev(pm8001_dev, dev);
+			return pm8001_dev;
 		}
 	}
 	if (dev == PM8001_MAX_DEVICES) {
@@ -613,9 +622,7 @@ struct pm8001_device *pm8001_find_dev(struct pm8001_hba_info *pm8001_ha,
 
 void pm8001_free_dev(struct pm8001_device *pm8001_dev)
 {
-	u32 id = pm8001_dev->id;
 	memset(pm8001_dev, 0, sizeof(*pm8001_dev));
-	pm8001_dev->id = id;
 	pm8001_dev->dev_type = SAS_PHY_UNUSED;
 	pm8001_dev->device_id = PM8001_MAX_DEVICES;
 	pm8001_dev->sas_device = NULL;
-- 
2.47.0.105.g07ac214952-goog


