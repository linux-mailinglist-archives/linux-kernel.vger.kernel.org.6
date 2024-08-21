Return-Path: <linux-kernel+bounces-295692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8695A025
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D340B23FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9C1B2539;
	Wed, 21 Aug 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AmOoqp++"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AD1B2515
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251163; cv=pass; b=o8hnBb+kGAvOS111i8g4ozmeV1FYUaQjyAe8/WkD4I/DIQB2NOCiqZUTsMmhEHs8w+5JmqYgltfYajtwECSAHL7jZbH6Sn4/YQfGCK+l0deHLrLKqpWkG7S3fkJZZuiihE6v69uVSxgQ+/LJzxuvnl4T5z21BJBFFy/pN3zkTzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251163; c=relaxed/simple;
	bh=qWm9n3PWuVmoE8n2Sr5A4kKFFF3A9ezgPCzJ9GxbUkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwfS9gcuS/eAQqjAEcrNngTBSROLW44kH1fxRHUkTgdmawrTB2z48bWAyitbBZdPhnRFki8pu21bKscZMQQDB2PQuBZ85zQcwavqje7rz+YT5YxD2LlxjIGcY9KKoptkMiT+ZqlmHrHjbWDIqZd6jeoLvcEvZejlNIGYCHc/M+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AmOoqp++; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724251152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lSouNbSOWHtGAFYRRSFtnTS/+7lpmLnYYW6awc3BJzWlaRvlKLCvYrkRIApfiYq8u6SIFlMvaln11y72tjaxPCYBqmo56l50zlrOdALmu5PzF1p+PxJuPXa2uBusMqFCsYneIbJc+OB0qb9wbaxzDwZA2uXHdEUyTC9P10TNhWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724251152; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X7hMMm58w0Lxs4euGai67p0IMEstJ81Np3QDMu1KXrY=; 
	b=TRPwru0cbS/15fagKBO2xyvTEPMlm8LAw+X82/Qk9f+dr+GNiIqtm+7ZYItHHyVglLt9NCCmrDr5ukMTGG2xhFGpEmtQLABWMXA1JsgHSQy/Cpy5NsO7X6OYJ8PpikRQyCUmCDs1czch/iKhUl+2kF0oLqEm5g+7lNuXg9ifvdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724251152;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X7hMMm58w0Lxs4euGai67p0IMEstJ81Np3QDMu1KXrY=;
	b=AmOoqp++hKAhKeYl/NxwBsjC7h40p5qFxeHjEjDaAoTD2z1AlKdg5H5/xusTCnyS
	FrgJoXODvqhiMwwGOnpgH466FWSAE3EuR3ci63EhrXeozHCNvXQ9KsExUfo0x/JTET/
	KbcmdLtAXwNF8S5gbsAeYO66HXW5D2A4rNNEzX2Y=
Received: by mx.zohomail.com with SMTPS id 1724251150579437.46131050444615;
	Wed, 21 Aug 2024 07:39:10 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 RESEND 3/5] drm: panthor: add debugfs support in panthor_sched
Date: Wed, 21 Aug 2024 11:37:29 -0300
Message-ID: <20240821143826.3720-4-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821143826.3720-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240821143826.3720-1-daniel.almeida@collabora.com>
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


