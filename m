Return-Path: <linux-kernel+bounces-364853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7E99DA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66C9B21D79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09A1DF261;
	Mon, 14 Oct 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JGOsdkGK"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356471DDA1C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949127; cv=pass; b=hx6/qEqemig5NXVTEFzMwZ9RE0LHd2eTa3Sgvrs7AuCs8EWODtAZfvHqswdpmYVLX0gVUtNgv9AlprDtxAU6eb4NVE7dPoye57oFRTlpz2yVAYcc4CAZVh2ADOIYhvLwiVuwvHNioB/om8tRukE6OwKDNG2/4ctyfHxFJYBqWh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949127; c=relaxed/simple;
	bh=DDZFNOEujpWDfietBByUa8rc4z6mazgw8XwW5c7GnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQQezp5UQsgOs4ILtV6ehl0zpyW47rjzgHLqPApomPfcEOl73McIjX/rURIpSpmpvlL39vrH+hK41plcHaY8MaIjY0Olr5JI7aT93fAe5HWXD1bqNxLympdIGk4W3A5obr92UtZT0X5DkKXi28NqR7VX0+j2d4QX5Dtd81Yu6ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=JGOsdkGK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728949112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j3TnNgjMzCi3i7Vkr9uI0OEUrpJJRQmCEL+EpgO/3HFrt/I0wg4c2cEY16ldhhQ3K94vf2ink41+VRGuGG9mbH98u5OHU5exEPsB6g0KPuIgaQMmMXlZ9LVESHD4Ti5uJ7MJM75ZsxfSkP5fkjqcgr5EtQqZpW2pPS4iJ5ybXlk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728949112; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H2CqaRMBISBckrbzBXtGVLvMuaRdqI4wF/P5QJdqlvE=; 
	b=P0V9yEP1vDp1HHGLwoglGu+QJbeZ6kcopJXrGvk9rWYvBZ0Zx43mpOA8le6hv8F8RtRC8/kK1tCovcFcI1zgkwiC2QkNmzWpyBbgv08bm1WsPRjEe24hZvaGhZnBFvdicyg08vWOVG/lT/33AlZnla5gBdWVhA7DOZsgHAs8sys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728949112;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=H2CqaRMBISBckrbzBXtGVLvMuaRdqI4wF/P5QJdqlvE=;
	b=JGOsdkGKU/gKb2zXrbTUKFRCn85CSjUAQp4TCDdE5yQz5NSu/uS7qsNJhRc7Dhz4
	Wn2cHW/9WshAH2nPTow9SxHKX9M5uOxKrxwXikHHqB9FDmE3SjfM5SVck2kTysFI96K
	yC6WSNxgkOLAov/Y7wNwd/ntP9FyrFHyp57P8w5M=
Received: by mx.zohomail.com with SMTPS id 1728949111609135.42347120219074;
	Mon, 14 Oct 2024 16:38:31 -0700 (PDT)
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
Subject: [PATCH 6/9] drm/panfrost: Avoid re-enabling job interrupts in the reset path
Date: Tue, 15 Oct 2024 00:31:41 +0100
Message-ID: <20241014233758.994861-6-adrian.larumbe@collabora.com>
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

Rather than remasking interrupts after a device reset in the main reset
path, allow selecting whether to do this with an additional bool parameter.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  6 +++---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 14 +++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h    |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 4fe29286bbe3..a2a58501cbd9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -395,20 +395,20 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 	return false;
 }
 
-void panfrost_device_reset(struct panfrost_device *pfdev)
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-	panfrost_job_enable_interrupts(pfdev);
+	panfrost_job_enable_interrupts(pfdev, enable_job_int);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	panfrost_device_reset(pfdev);
+	panfrost_device_reset(pfdev, true);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index d9aea2c2cbe5..fc83d5e104a3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -205,7 +205,7 @@ int panfrost_unstable_ioctl_check(void);
 
 int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
-void panfrost_device_reset(struct panfrost_device *pfdev);
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
 extern const struct dev_pm_ops panfrost_pm_ops;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 52ec9dc2397c..68be555c6c52 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -414,7 +414,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
-void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
+void panfrost_job_enable_interrupts(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	int j;
 	u32 irq_mask = 0;
@@ -426,7 +426,8 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 	}
 
 	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
-	job_write(pfdev, JOB_INT_MASK, irq_mask);
+	if (enable_job_int)
+		job_write(pfdev, JOB_INT_MASK, irq_mask);
 }
 
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
@@ -718,12 +719,7 @@ panfrost_reset(struct panfrost_device *pfdev,
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
@@ -898,7 +894,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		}
 	}
 
-	panfrost_job_enable_interrupts(pfdev);
+	panfrost_job_enable_interrupts(pfdev, true);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index ec581b97852b..3b8b712c1722 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -46,7 +46,7 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
-void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
+void panfrost_job_enable_interrupts(struct panfrost_device *pfdev, bool enable_job_int);
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
 int panfrost_job_is_idle(struct panfrost_device *pfdev);
 
-- 
2.46.2


