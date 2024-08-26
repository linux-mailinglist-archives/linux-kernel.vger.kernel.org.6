Return-Path: <linux-kernel+bounces-301697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537CB95F43C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13C6B20CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DF191F74;
	Mon, 26 Aug 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llRkg/UW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADC186298
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683499; cv=none; b=YBM91l7LetukuC/xuBR2PXmX/joe0ctaUEXl0haVYCsL8XZX9VFZdrqDISUeXMCKgcKFX7Et3tmgU9rqPDtFn+KUzlzHFEAF0FeeHgSK1Jkmbit5VHOvz+zRk04ZncN4VJxfIvMhkZ03hWN5aF+XGC7Qjk5H5lVj5fGQMgZcZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683499; c=relaxed/simple;
	bh=5atMg448e2EGeYdg2+Te67O/wq4PwN7quv95XWt3Jfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5p9uD+0DMJtSatJ7Bf0XcAPspjFBNfpTozEfObS5fJzC5MKxX9nCxE46P0YUBRZTdE3BOs6dvnvKa4hfbcf3d3olt8zYqE83pcH7L9V+xdcvjU2Yck4zQKmasaOxP/LFz3slM+Ae5Knev/N5Wske+6ygqSSkPDDgPqiTESFtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llRkg/UW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714187df604so3117319b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724683497; x=1725288297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yUACQCvV96K8SrB4TqRyd+0MwkmzrdW10K/Vq/2NiM=;
        b=llRkg/UWqMlEBHSlA6Og3JT7INcGClpP4fRTpM8nvqAlg5SyR/LhiupZZGcwbLtKcG
         G6QPe8tRiVCnc0Nh7MIb0L4UEPcQZ1XhyC26mTl5HBiU1hB/CHYJ3E235OVvorXYOUwZ
         +nKnoRqiEijOB+QE27t7MFUdeMGgaJ4WV2RSPHd1KdO36uoBO/Gv1noSOmHKf9zxCC7a
         8ehH5vnhKjs8CHEskXl8mcnpHWo91d3BbkTO54jy7geGaYN1OsLT+DfRNTEfDKtPYJm9
         ZwMCyruVVueDRy9zt4OsGkKs09ErRfI/TnN/214emWMCHlPt3vzS02X9IRQ870c5m/fA
         NAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683497; x=1725288297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yUACQCvV96K8SrB4TqRyd+0MwkmzrdW10K/Vq/2NiM=;
        b=tZA9tdZo/2WNdnVamy3T9YXOViBx1h6BBNaedpqAlTtD5wZxmNyteBUHZSzWl7QJ9X
         0r1UboLaq3tVAcjq3NBhtUDpIzZoRBG+ZAG6JQMivSlnFohAhJn8T3pqTZbf5Aalxrjc
         68MhxIHJ9nXSKYQl1CgL0itmKUx1o1evB/1an1BYwTPzjshcXidWkEQ5P3oJJnSUNS7W
         Jve0YCUoDypJHxH6P+2C9+5TsQYMPdEr7BPiMrf0Fsv/vD1O7OUrVE30iMCTknJm/WlU
         pwlco2oTEFWO5jKK32ppUPSdxYKg+IIA1AWYewB4ai/rL74Bw9568tJGUHW4mETHqCgN
         N0zg==
X-Gm-Message-State: AOJu0YyCTW0VhG/tGObk9UWYz5o/79LQ1oTEBJrW9WETGAMhc4XsJHk9
	tIJUUrMxaSRzAzlwoWz2VzGtWmZZEzA5vvNDni0M3WPvcJJ5XKEU
X-Google-Smtp-Source: AGHT+IED3w24Otal8KliDAIHPfYfSjFwab0AXqK51rsAXHujqmca71cIDpP7dNu8Z5W1U7N+2pR9Uw==
X-Received: by 2002:a17:903:2343:b0:1fd:8f4d:2392 with SMTP id d9443c01a7336-2037ee063b5mr220812825ad.1.1724683497039;
        Mon, 26 Aug 2024 07:44:57 -0700 (PDT)
Received: from fedora.. ([122.180.189.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dc28bsm68385415ad.133.2024.08.26.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:44:56 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: Remove unnecessary type casting and data type of geoid to u32
Date: Mon, 26 Aug 2024 20:14:30 +0530
Message-ID: <20240826144430.50488-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed unncessesary typecasting to int.
Changed geoid data type to u32 because it will always going to be positive.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c   | 4 ++--
 drivers/staging/vme_user/vme_tsi148.c | 6 +++---
 drivers/staging/vme_user/vme_user.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..8d4129c11e73 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -79,7 +79,7 @@ struct fake_driver {
 };
 
 /* Module parameter */
-static int geoid;
+static u32 geoid;
 
 static const char driver_name[] = "vme_fake";
 
@@ -1283,7 +1283,7 @@ static void __exit fake_exit(void)
 }
 
 MODULE_PARM_DESC(geoid, "Set geographical addressing");
-module_param(geoid, int, 0);
+module_param(geoid, uint, 0);
 
 MODULE_DESCRIPTION("Fake VME bridge driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d81be8e4ceba..231eb17b6aa1 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -36,7 +36,7 @@ static void tsi148_remove(struct pci_dev *);
 
 /* Module parameter */
 static bool err_chk;
-static int geoid;
+static u32 geoid;
 
 static const char driver_name[] = "vme_tsi148";
 
@@ -2123,7 +2123,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 		slot = geoid;
 	}
 
-	return (int)slot;
+	return slot;
 }
 
 static void *tsi148_alloc_consistent(struct device *parent, size_t size,
@@ -2625,7 +2625,7 @@ MODULE_PARM_DESC(err_chk, "Check for VME errors on reads and writes");
 module_param(err_chk, bool, 0);
 
 MODULE_PARM_DESC(geoid, "Override geographical addressing");
-module_param(geoid, int, 0);
+module_param(geoid, uint, 0);
 
 MODULE_DESCRIPTION("VME driver for the Tundra Tempe VME bridge");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 5829a4141561..fe261eef9153 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -130,7 +130,7 @@ static ssize_t resource_to_user(int minor, char __user *buf, size_t count,
 	copied = vme_master_read(image[minor].resource, image[minor].kern_buf,
 				 count, *ppos);
 	if (copied < 0)
-		return (int)copied;
+		return copied;
 
 	if (copy_to_user(buf, image[minor].kern_buf, (unsigned long)copied))
 		return -EFAULT;
-- 
2.46.0


