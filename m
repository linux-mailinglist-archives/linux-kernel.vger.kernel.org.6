Return-Path: <linux-kernel+bounces-432007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74AB9E4582
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D89B669E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5371F03F0;
	Wed,  4 Dec 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="e/CPsla6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA21F03DA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338247; cv=pass; b=c3Ew6kJ+bSsMvV7viWEeBAiBxif6cVjKbeqqqh6mnA1ex9gn6WnXGLCZ3Ip3z/0C1IOkiFA9LCAdLJi00acxYEW1fsNhj4UvW5T9yOcbYERWRHuCRcFBuacEeDxjhHpojRT391lrr6nguZTk7dnDRf6Y/9XkeJ0zZK1pbpPaYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338247; c=relaxed/simple;
	bh=JGqoCNLTTbZXwbaVDqpvrG4edotoEApTfRM+i/clZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuM8CUsmGQOSrGAvMTS+babAJbS13TWh96uF204tOl+UX6rjUQhmsZnMgV6gz9ZcvcAMxo/GeuJDdsSi1AES/HJFOUpmtHInx8Na7Inxe/VS9Tp7neBHWrmML0RR0+45DGhQN6IE4eRnh3dFVSzxRGVOc00eUWNN3+oUPB38trs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=e/CPsla6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kFIjlcbR/X88RRsfL7iG6+XXAxHy/XZi1YnqqWOzPE/ER5ea6k0N1fNd290QHeUoQqLrOMguZWtdWemEcnMTRb+YxWeA5px07vhujdFZ6noCv/zUhaoOsT5b2J9VrBiLXciLRK92IhHPqvwViwLY6P52s3WV/NNLAaDTPtGXGjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tH78IWKyYFFk7AcWXgGVFrk4fXHp9kJonxjpfidTDt4=; 
	b=gQ4dn+YYNHF40P0Ma7owIALzFKfqZbkWtqXfdQQzvqzQl9mw6TOs5b9zNkbwn7dtUiBACc5Hzl+5wBqufGbp/ZWkrDJSmDwW2hYNgyw0McT+5cz8hnzE5crDoXx0g3rHvWfurDT4yPcayfA1hYlz7f0bqPnATB/k6U+k+zsgPWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338224;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tH78IWKyYFFk7AcWXgGVFrk4fXHp9kJonxjpfidTDt4=;
	b=e/CPsla6zuFVjzOEfjTJFMsWPxmCs7WWemQvqvQIUm86f/pWgHBFWq0NnW1JX1uY
	VWfyKoiWgK+88RNnHe7kZDwEqz7SCqG2BQXMyYSFMoOB4aoTf7UobU+8CO+gp4sGxXO
	KHus7+huk4yPeIT7ihRiKTsjDhdNuNh4A0b4yuXo=
Received: by mx.zohomail.com with SMTPS id 173333822341858.21122196726333;
	Wed, 4 Dec 2024 10:50:23 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] drm/panfrost: Don't rework job IRQ enable mask in the enable path
Date: Wed,  4 Dec 2024 18:49:35 +0000
Message-ID: <20241204184945.1477677-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Up until now, panfrost_job_enable_interrupts() would always recalculate the
same job IRQ enablement mask, which is effectively a constant.

Replace it with a compile-time constant value, and also in another couple
places where an equivalent expression was being used.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  4 ++++
 drivers/gpu/drm/panfrost/panfrost_job.c    | 19 ++++---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index d9aea2c2cbe5..8bddc37aee19 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -25,6 +25,10 @@ struct panfrost_perfcnt;
 #define NUM_JOB_SLOTS 3
 #define MAX_PM_DOMAINS 5
 
+#define ALL_JS_INT_MASK					\
+	(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |		\
+	 GENMASK(NUM_JOB_SLOTS - 1, 0))
+
 enum panfrost_drv_comp_bits {
 	PANFROST_COMP_BIT_GPU,
 	PANFROST_COMP_BIT_JOB,
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index d10f66f4cc53..e599a8535511 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -423,17 +423,10 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 {
-	int j;
-	u32 irq_mask = 0;
-
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
 
-	for (j = 0; j < NUM_JOB_SLOTS; j++) {
-		irq_mask |= MK_JS_MASK(j);
-	}
-
-	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
-	job_write(pfdev, JOB_INT_MASK, irq_mask);
+	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
+	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
@@ -752,9 +745,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK,
-		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-		  GENMASK(NUM_JOB_SLOTS - 1, 0));
+	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -827,9 +818,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
 
 	/* Enable interrupts only if we're not about to get suspended */
 	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
-		job_write(pfdev, JOB_INT_MASK,
-			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-			  GENMASK(NUM_JOB_SLOTS - 1, 0));
+		job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 
 	return IRQ_HANDLED;
 }
-- 
2.47.0


