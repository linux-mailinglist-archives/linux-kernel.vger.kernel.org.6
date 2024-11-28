Return-Path: <linux-kernel+bounces-425077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E849DBD38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E29F281BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F71C3F39;
	Thu, 28 Nov 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jb0PwZfB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA1C1F06
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828383; cv=pass; b=Y7Gb5lWfU7JGhcTSJz1VhbmLXuZ8AoNcU1BS/I4S+lH3QqPmS02Ik957hhIOtSPy9XZzuSx6y8R+6202UlLtsOuGF9/NDRbWAq/ytkAPNVb75xEapWiIvyf9313c2Qy7zvQ5vVBp8i7E5CcRDgl265gTiAzoXlEEZJ7tVb3ACy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828383; c=relaxed/simple;
	bh=kUxM+2O+TZmAkHjbl9h032v8GfApBUMEE9n4bgMX/No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onbF61HcTIcc9iJ2OxN0SyGANpXRI76soPys+k1j5hK8sprcZ7V2hHREHcOmMm2mmKSjSjp6wY441XmHf0tAHjKbfUg+5MCQNxBh+iDNaQKJiw6tIFx2fQmBqThgayaE5TaND3uiSNNtYMRh5B0yUd/SKwdw9/F3Pa46mD46nzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=jb0PwZfB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732828364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VSVNqtj3oY8LwO1rViJju56vYlvGlgKjy59dyZktTBV3+fQxzluFa6v57640HnpiIJzyy6WHIsW5Ej3DbiRVbpdWMd1M+RvJK9NfaGiQFbOgdJ7UE+62dnpNivYGw+uL0FRXOevo9Nno1fmlg3CkoM0i1gNXNgZGTm77ZfObGRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732828364; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=htgxecyDu4cViAvkQlpShzB4N7SVqiV2cFyANiNtDwc=; 
	b=IAgbA0Cr89HnCiFhK8bglCbRBaup1lU7RHRCNmBCX6HoKBZ7ILwqfyrJClOvO8FgGsIS33GvJO0QeqGtAg0ZDq7zB1bZbxCcxKhW+9vBsz0e8hD4uCe419kuSntZG651cxW3KZM3DKJsNAglBpv3r55eSm9kBAOEf3PnnftGogk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732828364;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=htgxecyDu4cViAvkQlpShzB4N7SVqiV2cFyANiNtDwc=;
	b=jb0PwZfBjiQE4pbS4PRM8QRosZAG9/bHcy9EVfeH0UZYhExu/VIWAxcR/mpO6zGW
	XcMT2VHfAbcvLndl7wRqtAVgHWPOYOM3NLY7zR7fyPwqUss4pCX+bhA42i+gDT/sZkA
	SvL6gPkEDjlltcKqfwUcG8evuAurRI2E/u6W2N2o=
Received: by mx.zohomail.com with SMTPS id 1732828364259603.1116847144285;
	Thu, 28 Nov 2024 13:12:44 -0800 (PST)
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
Subject: [PATCH v2 3/8] drm/panfrost: Handle job HW submit errors
Date: Thu, 28 Nov 2024 21:06:18 +0000
Message-ID: <20241128211223.1805830-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid waiting for the DRM scheduler job timedout handler, and instead, let
the DRM scheduler core signal the error fence immediately when HW job
submission fails.

That means we must also decrement the runtime-PM refcnt for the device,
because the job will never be enqueued or inflight.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index f640d211cc3a..3f4f0682d69d 100644
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
@@ -207,10 +207,11 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
-		return;
+		goto err_hwsubmit;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		ret = -EINVAL;
+		goto err_hwsubmit;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
@@ -261,6 +262,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
 	spin_unlock(&pfdev->js->job_lock);
+
+	return 0;
+
+err_hwsubmit:
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+	return ret;
 }
 
 static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -382,6 +389,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
@@ -400,7 +408,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
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
2.47.0


