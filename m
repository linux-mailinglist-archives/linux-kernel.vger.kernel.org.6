Return-Path: <linux-kernel+bounces-254400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B159332C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802F2283B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779B1A0B09;
	Tue, 16 Jul 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2jXTb4+i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80E1A08BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160799; cv=none; b=CzRa7YYx7Q2gZl1e5YZG5dAaEctDgajPSPdlFMAikHWI6gL0WYMgG2/JFueiCw97WG6x5MjQfBpz69Xz2Lbbb/eWvz95IflNvceFAMMO7hfKxs9130DLZKBdG5VBV2o/wxwhq6+PLO9fmZQmKaVttaxU7fUjUkQ7ud0VMgmIA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160799; c=relaxed/simple;
	bh=s1e1liijcI0BA0WHUrIX5x42YrT4y2A9s4r6eSHLK1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsBuXHgdWA/+xIuTWvU8EdowSGjM+S9D/Kf3lYXORvRhZXd81Ptw50vJ5ZnlZHi5Uby5mKlzbNqoEuzPDKVYX6YRngMbs6tamDmU7h0TAxEAyMzUfAXmFuJ81hyVTXDxECAoWMjAelURyIujkEYWsHdkyA+qRjolyojXi1mOJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2jXTb4+i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721160796;
	bh=s1e1liijcI0BA0WHUrIX5x42YrT4y2A9s4r6eSHLK1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2jXTb4+iBXZlu4uvByJmc6fdvrMPqWHbIk3JA0Kj2Pdt9JDdwHo0/kOJGxtyMjmqe
	 8cm8eJbTKTpDAoQD2Bf/WxckVmkqCEws8SdR8uYT9FJ8SmWMgCA8yKlXzh0tbS4ytA
	 sZzY1qq9Whae8mAyA+Vo1lfwrilfxDGdBdVcJqZdo1H0Remu0+S0LAQO+p7IUHydeU
	 xloDYFJrSFTIpBBcUyVSWx3qm6lzwb4SFL4M2r5M5khnuI4hOB35GHWXRckpEUX8M3
	 XrgZ36u+uVZ3oXgoDgzIQy5AGaoP7A3MY8QP6UwJTkGT0CQ0g9KEdGrKveW8c+OXXt
	 9RwF13EOhWBTg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 02FD437821E0;
	Tue, 16 Jul 2024 20:13:15 +0000 (UTC)
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
Subject: [PATCH v4 4/4] drm/panthor: add sysfs knob for enabling job profiling
Date: Tue, 16 Jul 2024 21:11:43 +0100
Message-ID: <20240716201302.2939894-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit introduces a DRM device sysfs attribute that lets UM control
the job accounting status in the device. The knob variable had been brought
in as part of a previous commit, but now we're able to fix it manually.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 6a0c1a06a709..a2876310856f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1448,6 +1448,41 @@ static void panthor_remove(struct platform_device *pdev)
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
@@ -1467,6 +1502,7 @@ static struct platform_driver panthor_driver = {
 		.name = "panthor",
 		.pm = pm_ptr(&panthor_pm_ops),
 		.of_match_table = dt_match,
+		.dev_groups = panthor_groups,
 	},
 };
 
-- 
2.45.1


