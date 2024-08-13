Return-Path: <linux-kernel+bounces-285510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F0950E56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748141C2361A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C91A76C6;
	Tue, 13 Aug 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XsZZGtBk"
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316E1A706A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583204; cv=pass; b=saeaAYw1KRzRV/Feq2upXnMbfjC8WXkLD1Gps4yVf1DJkY/7Os0jjYv8W1pUEhxweUWDdPcV8yAflFwyMA39OEdzOZs3O7aMNn6Gc6WfIf25H+7laxZi8nKv9fhbYJ9G9oZVS3kMOeZQ7l5cAvlAO+u329BdrhCoO5FJP1dCEGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583204; c=relaxed/simple;
	bh=qWm9n3PWuVmoE8n2Sr5A4kKFFF3A9ezgPCzJ9GxbUkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKu5iyvRfHaNcMOsxi/WJB+1HZHvYu6y/kAPSeC/RsAQSLb7US65iJwrzimMq8/wC8gS5S0DWvBeuqdQCA/CJeruEBkgyWgkm9oIjkeyp8EeMVCYOKLqfvHOeHPBkWw1xywSe1+ha6webCVw7aBSXwivTDsNAb8s3GjgPJ5huxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XsZZGtBk; arc=pass smtp.client-ip=136.143.184.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723583197; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Uyv7JoKnVTonV0l0r6qUk1rA/ISqtejv45gbXePpgjG2fM3ds232gQ7ghq3nGs6bThk8icp7EkA4Id+DJyhCjItrztSLrcii/pHd+1NYhxf/+Gy+MXtTZ9Ju2UyPNvpjO39vW/SV1RD6gylc11WAHsGWVow195cZT/C4RsEAiRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723583197; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X7hMMm58w0Lxs4euGai67p0IMEstJ81Np3QDMu1KXrY=; 
	b=KtS1a0RqVWHdrmkrNMSNopO7chSBxJPNuNKJ9/Po5/H3fb0EbMftqhLBRYRhrNENmmx4OmV/06COzoOMjszYMWe/Lb8k/OiA3jclChJwnj9JyvhnMNh2vFT3EAfP9kWodaDVB57/UzSVuJb5I2A46Z+cBD6KNpRbYH/fyUB9a9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723583197;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X7hMMm58w0Lxs4euGai67p0IMEstJ81Np3QDMu1KXrY=;
	b=XsZZGtBkaSY1+nwNu4JEU+SDIrOZDK0nJMW6l0Uu35orrncQr9Qab8FrItQRxlZJ
	BMTXd0c91nq1CNVsP203S86myYqOCR2w2q+2LbYeE81tHaDqj8bEEkfZm0dW0WLi+cr
	yNHdHcpkAQMs8s4ie6flS0mhX1RacUpmYGZOFAfU=
Received: by mx.zohomail.com with SMTPS id 1723583196586939.8017438652769;
	Tue, 13 Aug 2024 14:06:36 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] drm: panthor: add debugfs support in panthor_sched
Date: Tue, 13 Aug 2024 18:05:46 -0300
Message-ID: <20240813210555.607641-5-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813210555.607641-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240813210555.607641-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In preparation for future patches, add support for debugfs in
panthor_sched.c.

Follow-up patches will make use of debugfs files to control aspects of
the dumping process.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 1 +
 drivers/gpu/drm/panthor/panthor_sched.c | 9 +++++++++
 drivers/gpu/drm/panthor/panthor_sched.h | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index fb30e119d9bf..bb759baa98bd 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1374,6 +1374,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 static void panthor_debugfs_init(struct drm_minor *minor)
 {
 	panthor_mmu_debugfs_init(minor);
+	panthor_sched_debugfs_init(minor);
 }
 #endif
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 59c30b311ee9..afd644c7d9f1 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3602,3 +3602,12 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	ptdev->scheduler = sched;
 	return 0;
 }
+
+#ifdef CONFIG_DEBUG_FS
+void panthor_sched_debugfs_init(struct drm_minor *minor)
+{
+	struct panthor_device *ptdev =
+		container_of(minor->dev, struct panthor_device, base);
+	struct panthor_scheduler *sched = ptdev->scheduler;
+}
+#endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 9a5b53498dcc..88871f38c1ab 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -8,6 +8,7 @@ struct drm_exec;
 struct dma_fence;
 struct drm_file;
 struct drm_gem_object;
+struct drm_minor;
 struct drm_sched_job;
 struct drm_panthor_group_create;
 struct drm_panthor_queue_create;
@@ -57,4 +58,10 @@ void panthor_sched_resume(struct panthor_device *ptdev);
 void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
+#ifdef CONFIG_DEBUG_FS
+void panthor_sched_debugfs_init(struct drm_minor *minor);
+#else
+static inline void panthor_sched_debugfs_init(struct drm_minor *minor) {}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif
-- 
2.45.2


