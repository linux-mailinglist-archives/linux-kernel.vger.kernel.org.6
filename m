Return-Path: <linux-kernel+bounces-432008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F29E43C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A48C2874DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E921C3BEF;
	Wed,  4 Dec 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IRJrWQwN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45A1F03F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338250; cv=pass; b=DuJwsFO4ZUfFJaK7Y1lMtEJdn1Ilhpa1g9mDgJLDdGFz/2cQlC6hKA+SwDzyuhda/wF8RqNY6gwt05FJdv//Q+m1Blu0fjDDYM7rgz3AmBv7QByAZk11bYA7OM7r+aJ2FYDwiO82lpx1/mJxaAuh81ls5VSKMvzSxc4kongB5R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338250; c=relaxed/simple;
	bh=FeNgi9x7/4cdqFpnrmWJ2bSGpVXCjbSMxtuIeMbFV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8bljF++PneSo+qO8B4eYbOlx+jIdPIqGRAgMyqkP82pkLOAavt+CRURwP2Ze+wyuabWvUJnYLFCckP353nDg/+nfd5rFmfeQwx6n55/loWyOSwE4HP4xOTE6fsnTfBCvcBY9IBiI8NHH+AgurFw9BybgiHrv2uFvyXZiSZRwl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=IRJrWQwN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338228; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IC3H6K4dpyxpiOudZkbMXl2mvkbkTxMhmjHqz04/2q5uxbd6oPd0O3AUJO5z8lnreMWWjKbUAGGzHIWiwce6p1DtZJmFs/kRoXvmfOkyADp6Qpz2VzVWaflvM/kBiXayZnTwFiOj8xPwXkvc+ha5b4L9Fj96uvL5MZZfhtV2b1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338228; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W2svrh7vS6Pni7QoUPS3Qb615NzfHeczA8rly3S+pGU=; 
	b=SLvj3uOGhXk4sUtE4xOIsLJhvmPTfKSdybh4TXwUgGhORcyTApM++xFhmzS9rHmnl0qR7gjP0ryrJOK2PdwBGNi5k01XdYI05Q9ANxtu1K6cgm36z5W42mgrYXkOtpHejyLXxIjWAqrCIzh1Cro1WBW8T+Eeq0tUzrABnav+TH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338228;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W2svrh7vS6Pni7QoUPS3Qb615NzfHeczA8rly3S+pGU=;
	b=IRJrWQwNy/3ljCvenGwzLdP+4X+FA3SrKME4lzJ63W+e/K8dXMNPBERKHQo/HItI
	ucMR7vHxqQGHv3GhQDREIPeQmChAiz/QBuIvdgWHGU2zdL8+zyj+2QriV3bcGX7UBVR
	ZqmPmsN+NJV04fbAMkxpCGrJJB4PcQqnH9jbw/Zc=
Received: by mx.zohomail.com with SMTPS id 1733338225987892.9560656832709;
	Wed, 4 Dec 2024 10:50:25 -0800 (PST)
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
Subject: [PATCH v3 7/9] drm/panfrost: Make re-enabling job interrupts at device reset optional
Date: Wed,  4 Dec 2024 18:49:36 +0000
Message-ID: <20241204184945.1477677-8-adrian.larumbe@collabora.com>
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

Rather than remasking interrupts after a device reset in the main reset
path, allow selecting whether to do this with an additional bool parameter.

To this end, split reenabling job interrupts into two functions, one that
clears the interrupts and another one which unmasks them conditionally.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 17 ++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 4fe29286bbe3..ac067eddd037 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -395,20 +395,23 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 	return false;
 }
 
-void panfrost_device_reset(struct panfrost_device *pfdev)
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-	panfrost_job_enable_interrupts(pfdev);
+
+	panfrost_job_reset_interrupts(pfdev);
+	if (enable_job_int)
+		panfrost_job_enable_interrupts(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	panfrost_device_reset(pfdev);
+	panfrost_device_reset(pfdev, true);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 8bddc37aee19..30ce8cec1aa6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -209,7 +209,7 @@ int panfrost_unstable_ioctl_check(void);
 
 int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
-void panfrost_device_reset(struct panfrost_device *pfdev);
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
 extern const struct dev_pm_ops panfrost_pm_ops;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index e599a8535511..c1cf37e3c4c1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -421,11 +421,14 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
+{
+	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
+}
+
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 {
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
-
-	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
 	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
@@ -718,12 +721,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev);
-
-	/* panfrost_device_reset() unmasks job interrupts, but we want to
-	 * keep them masked a bit longer.
-	 */
-	job_write(pfdev, JOB_INT_MASK, 0);
+	panfrost_device_reset(pfdev, false);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -745,7 +743,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
+	panfrost_job_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -894,6 +892,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		}
 	}
 
+	panfrost_job_reset_interrupts(pfdev);
 	panfrost_job_enable_interrupts(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index ec581b97852b..c9d4b77d5ed1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -46,6 +46,7 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
 int panfrost_job_is_idle(struct panfrost_device *pfdev);
-- 
2.47.0


