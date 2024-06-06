Return-Path: <linux-kernel+bounces-203474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4288FDBBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F009B24179
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D271373;
	Thu,  6 Jun 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R3j1oXjk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F60D272
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635280; cv=none; b=KcryTuS4JNVL1uKbTLtGXYEnVEsfK7hlwt1fzyMzDHcq7J9/zhina9NyhLlvd8n9VkA1WDppktUBvnLIhSoq3HxLp0+2LkpqAw4l3LgwBDogexvtFMAKyp4FQ+FVPgVcHn+ZvjqjtW5YABPvaV1afGFQLzHG6wxIHUjkQXZ23Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635280; c=relaxed/simple;
	bh=fFUvXAwwdWE8ka12wmELA/sfizV8ZmztfmF18ScI4Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKOzK033zk/S5ycTkyBHrd+Uu2+TYBw7xCBeJgAoaS8Qlor+8+KVREYckxMMZ2DoNSpae2c3q76zTiH1bJqKuXatfZWSsj6b4n/Grq/PYtt7tRb7gDZr8xj6E2eIKCMWxRmt78/z6blOzMSC/H2pElNLZz9wvyaZ8GDmG1v2SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R3j1oXjk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717635277;
	bh=fFUvXAwwdWE8ka12wmELA/sfizV8ZmztfmF18ScI4Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3j1oXjkA6PbKNZK9mh+85vJi4FRQGNSUR/qUkKU3IhEOB2ToemMa09zgFCuxW2Bf
	 81GhtpMISg7occeiOmv9nGrGDGVXwqZc79skt48m6QDB4Y/JD2kaQAyGPvrQMYva5o
	 keLcFxqaj5M/gdBBMhqrG5OJEfTQcsJX7B7m7l9KFxPmEY447PHYSbQGsvwvRfpuIg
	 SC3lLCMn9LuxC5+JnNtPHpIvCP1TQtq3TcsiIbWrn2VX5cfN9J3Kj7DrqLTAp8DjNM
	 FwAC1zJezR7NXJ6atUnunnTZjjS+2bo6SgacNCtueiAe7yyCFlcLsXWbbX77PxO3+k
	 50kuvhwy+V1SA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A2EAF37821D2;
	Thu,  6 Jun 2024 00:54:36 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] drm/panthor: add sysfs knob for enabling job profiling
Date: Thu,  6 Jun 2024 01:49:56 +0100
Message-ID: <20240606005416.1172431-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just like it is already present in Panfrost, this commit introduces a DRM
device sysfs file that lets UM control the job accounting status in the
device.

The present commit only brings in the sysfs knob and also hides the cycles
and engine fdinfo tags when it's disabled, but leveraging it for job
accounting will be the matter of a later commit.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h |  1 +
 drivers/gpu/drm/panthor/panthor_drv.c    | 46 +++++++++++++++++++++---
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 8a0260a7b90a..c3ec1e31f8b7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -163,6 +163,7 @@ struct panthor_device {
 		struct page *dummy_latest_flush;
 	} pm;
 
+	bool profile_mode;
 	unsigned long current_frequency;
 	unsigned long fast_rate;
 };
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 6d25385e02a1..a2876310856f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1360,12 +1360,14 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 				    struct panthor_file *pfile,
 				    struct drm_printer *p)
 {
+	if (ptdev->profile_mode) {
 #ifdef CONFIG_ARM_ARCH_TIMER
-	drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
-		   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
-				    arch_timer_get_cntfrq()));
+		drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
+			   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
+					    arch_timer_get_cntfrq()));
 #endif
-	drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
+		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
+	}
 	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
 	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_frequency);
 }
@@ -1446,6 +1448,41 @@ static void panthor_remove(struct platform_device *pdev)
 	panthor_device_unplug(ptdev);
 }
 
+static ssize_t profiling_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", ptdev->profile_mode);
+}
+
+static ssize_t profiling_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	err = kstrtobool(buf, &value);
+	if (err)
+		return err;
+
+	ptdev->profile_mode = value;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(profiling);
+
+static struct attribute *panthor_attrs[] = {
+	&dev_attr_profiling.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(panthor);
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
@@ -1465,6 +1502,7 @@ static struct platform_driver panthor_driver = {
 		.name = "panthor",
 		.pm = pm_ptr(&panthor_pm_ops),
 		.of_match_table = dt_match,
+		.dev_groups = panthor_groups,
 	},
 };
 
-- 
2.45.1


