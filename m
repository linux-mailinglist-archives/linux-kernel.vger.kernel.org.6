Return-Path: <linux-kernel+bounces-424642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D49DB769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA85A162756
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54819CC39;
	Thu, 28 Nov 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjnI6COi"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEB4F20C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796147; cv=none; b=eLuFBIkJW7B5exUnuft+WOyVYJ46N5joPRWl3kvV+PvsYtPz9fXB+CM6Z3SAXKvdPBSx1UouZ8GPU+qLjiP+d2E/R7Lx3Gj2d3C1czdQVuqzJXAuhnw64OGngl2aBdlshcd9bQ2SyV33BHbLaJcMs6mZUX1y+z4UcdQqcmyN020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796147; c=relaxed/simple;
	bh=t1nGlTIct6zsPdc6fJd7dxzkoT4UG182yVm/235RE70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ae1e5O8PO+3wyRr5noiRlIQkG9eHPVRurnLXZivga6ST+Lovhfml79vFafP3v3ZmpczamW9KWGx5OGT0p0NMaCAjyYCy4er7NkFNVy+52A2mV8XO1sdP321Bv+OSHuhZzXsEE4tyZjosYi3sV6dBmDm34QWp8KZJZm5iWYtOkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjnI6COi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df6322ea7so1083073e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732796144; x=1733400944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo7/3gUT+IQw+k2qVNpV0TR7aOCWRkGfGTG2g3pxuLw=;
        b=AjnI6COi/P4RkNijGGrQnqPubRcrj18ZlfgM/S/ULr5kl3HrircPThi3c+yK+BtYD7
         s7XY2FSmiz7Wlt46wfmqbIMPC9UsiH++TonSaBerkd0tAcgugmaJUq/A1t3rCEuYC3d4
         9Kre7Mgl+G0X8O/e5YVuHfcSoD/N9a9un52n6y6DAHq5gnvn6d0+6h+udh/abK4SN3cs
         DS8PUUO7Yi6+s4CmzpRI/DgJK/zDEVwdG2xkQiZlatPIneHOhk6L1uMpzX8jVBQyCYzk
         312ksqqqReW60GDfrshS1VKxpGiGbvZOKKtujsfgR5NiOO4FSBjFmErlOf4qfFzpFm/c
         sctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796144; x=1733400944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo7/3gUT+IQw+k2qVNpV0TR7aOCWRkGfGTG2g3pxuLw=;
        b=kZpRnY8EgDQHVjLUpkEhKiKV6ohd0M5EuUL2q0BbaEU1cuAzx23naz1DRuIl1j41xQ
         4iuTC9sAcf7v9IS4Z2mHzYFI0H0Wxqp38mrsbvVQTxYuUr4wAqmwc/HARiMiM0dcUGe0
         8wnjFZqLpwltAihXTn31s2xxTymtfOVt4TyBRKn9PnSg1FYaQIIDzQcwLKZreXYhXZf2
         4ynRgudwVZnnGFthZvbIx1DJXbrdU5S5sBgrcP82wtIlYUB6Ut34NYvLW3uJl1Jr19ug
         UnowWt5/tXXyaiK8mfv01BZc1M/4S4vGtT7fjRFXs6qWmdwMSnTw4SvRNP6hmqtiCdXj
         R5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEKet7FZj0bUpv5UKaq5SOdVPaK0zu0bSmrSRbXYzzAwgNHTlaedLBjVfiB+KVRPDVD1Yfe4tAuGVlbFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabtIH20gojGqTLw1go2wIOLAsd2QAqgy6idm1Voeblhj/PxH9
	Qr1j8u//qcd+7xdfxtdtNjv24BV7khmxlfw7asJo/68U6TZTnGjh/73Ef4XbsHM=
X-Gm-Gg: ASbGncvKUCGFHAJX1js2fDon4DXgw2dH2v22eNC6Kuwprhlz3TqDzNNa+CFItrouhj3
	67y86A0pgIavkkrPNAHmY81GWrV1IBqotLQpXCgq0hqAp2ZhcpD+lsmLYSM1710/kF+M0KgqUmS
	oDqmsryNaCzEPhCyy8eC5lAYHxxy6cVhYIPB1uWfgp/jux5HkqJX8CqWhZFkPrAJSFzgLhsBtkb
	G+d7erObM4oCBqQBfBKBaZVG2x2Mi4P/UKZ5WGW+YRwAwCP/Q==
X-Google-Smtp-Source: AGHT+IFKE7xqDBi+cZmxYmt7ECXkRTo6VaxF8DAN573/AN6UlZxpeMT1JwaC1egW90HocEjDlccZpg==
X-Received: by 2002:a05:6512:1286:b0:53d:eecf:e25d with SMTP id 2adb3069b0e04-53df010b161mr6061834e87.37.1732796143557;
        Thu, 28 Nov 2024 04:15:43 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d410dsm60981466b.66.2024.11.28.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:15:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	coresight@lists.linaro.org,
	mike.leach@linaro.org,
	yeoreum.yun@arm.com
Cc: James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Drop atomics in connection refcounts
Date: Thu, 28 Nov 2024 12:14:14 +0000
Message-Id: <20241128121414.2425119-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These belong to the device being enabled or disabled and are only ever
used inside the device's spinlock. Remove the atomics to not imply that
there are any other concurrent accesses.

If atomics were necessary I don't think they would have been enough
anyway. There would be nothing to prevent an enable or disable running
concurrently if not for the spinlock.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c     | 6 +++---
 drivers/hwtracing/coresight/coresight-replicator.c | 6 +++---
 drivers/hwtracing/coresight/coresight-tpda.c       | 6 +++---
 include/linux/coresight.h                          | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 5a819c8970fb..bd32f74cbdae 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -86,14 +86,14 @@ static int funnel_enable(struct coresight_device *csdev,
 	bool first_enable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_read(&in->dest_refcnt) == 0) {
+	if (in->dest_refcnt == 0) {
 		if (drvdata->base)
 			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
 		if (!rc)
 			first_enable = true;
 	}
 	if (!rc)
-		atomic_inc(&in->dest_refcnt);
+		in->dest_refcnt++;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
@@ -130,7 +130,7 @@ static void funnel_disable(struct coresight_device *csdev,
 	bool last_disable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&in->dest_refcnt) == 0) {
+	if (--in->dest_refcnt == 0) {
 		if (drvdata->base)
 			dynamic_funnel_disable_hw(drvdata, in->dest_port);
 		last_disable = true;
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3e55be9c8418..31322aea19f2 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -126,7 +126,7 @@ static int replicator_enable(struct coresight_device *csdev,
 	bool first_enable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_read(&out->src_refcnt) == 0) {
+	if (out->src_refcnt == 0) {
 		if (drvdata->base)
 			rc = dynamic_replicator_enable(drvdata, in->dest_port,
 						       out->src_port);
@@ -134,7 +134,7 @@ static int replicator_enable(struct coresight_device *csdev,
 			first_enable = true;
 	}
 	if (!rc)
-		atomic_inc(&out->src_refcnt);
+		out->src_refcnt++;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
@@ -180,7 +180,7 @@ static void replicator_disable(struct coresight_device *csdev,
 	bool last_disable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&out->src_refcnt) == 0) {
+	if (--out->src_refcnt == 0) {
 		if (drvdata->base)
 			dynamic_replicator_disable(drvdata, in->dest_port,
 						   out->src_port);
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index bfca103f9f84..4ec676bea1ce 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -190,10 +190,10 @@ static int tpda_enable(struct coresight_device *csdev,
 	int ret = 0;
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_read(&in->dest_refcnt) == 0) {
+	if (in->dest_refcnt == 0) {
 		ret = __tpda_enable(drvdata, in->dest_port);
 		if (!ret) {
-			atomic_inc(&in->dest_refcnt);
+			in->dest_refcnt++;
 			csdev->refcnt++;
 			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
 		}
@@ -223,7 +223,7 @@ static void tpda_disable(struct coresight_device *csdev,
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_dec_return(&in->dest_refcnt) == 0) {
+	if (--in->dest_refcnt == 0) {
 		__tpda_disable(drvdata, in->dest_port);
 		csdev->refcnt--;
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c13342594278..834029cb9ba2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -200,8 +200,8 @@ struct coresight_connection {
 	struct coresight_device *dest_dev;
 	struct coresight_sysfs_link *link;
 	struct coresight_device *src_dev;
-	atomic_t src_refcnt;
-	atomic_t dest_refcnt;
+	int src_refcnt;
+	int dest_refcnt;
 };
 
 /**
-- 
2.34.1


