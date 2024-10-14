Return-Path: <linux-kernel+bounces-364851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4199DA38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC380B21ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD071DC04C;
	Mon, 14 Oct 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="J/Xd1DZB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752291D9A6E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949122; cv=pass; b=j+UU6jXAotcBPewzT2olGdLIZPOYNb5LgnXe5E2hqyq/QjsScQs2MT7NnhbAErn1nZwnwzxsSlo2WcveEmzHJWHiFswPliayo4hETTCvSxfvis7FiBT9gMi+qEMfWrE7tTyn/YsItc9bN+jM/MK3a2CNeOTIzM+2e13Ld7k+SHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949122; c=relaxed/simple;
	bh=5LkdZqV6q66N3NQQU/ZMwAjV1L0kO1P1rFTxfKW+eZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6D52c+lcJoEcSfEZGcbO9mpiEG3vTR2LAPHRJ0jK7iyYQphay7L8o0VcB3szp6rkQEGIeH5wSoGZWb4n5rC1YREXphKmACk7Krt8We7/ENjbqPPzgXJjPhz/mqJve/p4MrDSZBK4MmaBA79WZn3RuMGLoy0WGvMnLIbB0DXU20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=J/Xd1DZB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728949106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NdHleGPP/3aH6TaokRS57XKaMOX5n/O2/9ayKaHrXivLSpQYmM57/B4CwMI6dZdhOnSkDeqyC4QZzvLhuWOqIlhHwDqF+IgvCBR2OFrbV7L3WGmprhqwh07c2Yb++2U9d15bArQ/t0hXPmJgmsV2CO/QK/vS0n/yJP0KJlBUni0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728949106; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K6mqrWVCp9EX7x05p2w9FQ+Z72iiZ5X89MMIiXuI/fk=; 
	b=Fj3AHeeom4KNQ+SlHHPIz2torFnM0N4mQfGlsreI/+GV3ykUHa28Wnp1NkSRgTfs9VXv9cJ/0w/f+0hfOt/IcLMbZ4aBlJ0/DGIzPR+ICh0eRVK1L6+PXePyuRRe/T5P6fly1F2tWyHzCMKOVThcuS3NP1RvqUDYFC18WeCMzwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728949106;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K6mqrWVCp9EX7x05p2w9FQ+Z72iiZ5X89MMIiXuI/fk=;
	b=J/Xd1DZBo50Sq7e7lL5RX0wLZ4tLh9ZV0cmvWNWa/gzreV5x5GBktju/0hP4oNCc
	jI5FRDVAZ7y7DZMfvJMLLwfuHlzoXIBN1wmgG2GoMBgt6w4NQsUnOl3+3+7bm8a2fDa
	N0bvY7zEnWOpYxa7EzI/ohXK5KktICu/VFFldMlc=
Received: by mx.zohomail.com with SMTPS id 1728949105800317.8456998376339;
	Mon, 14 Oct 2024 16:38:25 -0700 (PDT)
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
Subject: [PATCH 4/9] drm/panfrost: handle job hw submit errors
Date: Tue, 15 Oct 2024 00:31:39 +0100
Message-ID: <20241014233758.994861-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014233758.994861-1-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid waiting for the DRM scheduler job timeout handler and let the DRM
scheduler core signal the error fence immediately instead when HW job
submission fails.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index f0a4690bcdf9..52ec9dc2397c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -195,7 +195,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	unsigned int subslot;
@@ -207,15 +207,15 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
-		return;
+		return ret;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		return -EINVAL;
 	}
 
 	ret = panfrost_mmu_as_get(pfdev, job->mmu, &cfg);
 	if (ret)
-		return;
+		return ret;
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
@@ -263,6 +263,8 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
 	spin_unlock(&pfdev->js->job_lock);
+
+	return 0;
 }
 
 static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -384,6 +386,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
@@ -402,7 +405,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	panfrost_job_hw_submit(job, slot);
+	ret = panfrost_job_hw_submit(job, slot);
+	if (ret) {
+		dma_fence_put(job->done_fence);
+		return ERR_PTR(ret);
+	}
 
 	return fence;
 }
-- 
2.46.2


