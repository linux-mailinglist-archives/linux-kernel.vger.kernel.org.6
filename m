Return-Path: <linux-kernel+bounces-316912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07396D6D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4791C22DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549E19938D;
	Thu,  5 Sep 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="PVnatLhI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463414F10E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534855; cv=pass; b=Jihl7zjeVhQOe+reX/cG/TZu6Mgq15bwmZKmm5b+RNlNbKoZsbjANlRB+RFmGwgLLvUIqr23QVCxxJB6Ov98lufoGeEMFzGtk1skp9Bw7zfs+6m5YN5OxMlk1HJtciMqkFx1xNR3i1jnYzfzdImyXk5Jta5A+fwD/4+ZKH/5Q0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534855; c=relaxed/simple;
	bh=tXKeO1zYbhM3Ya5OVBkkOcLWffQ4EVZVDoCwip/w7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8s6ap4IJN4XcCuerVerk54gA2RyoDruz7RBPA81zqL1HEHzxyiZSC57PcBsDp2SzWKElR4z17uvBVWYfn65sbyVhq1xKA9EhX8YCSftzWKccg6evvh+z/CJ1WqgvVExZq7pe8I0XTrELQOjXvrFccJGdcQQmmfAQidgsE3oEyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=PVnatLhI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725534839; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eIzhycMEQOmscNcCZglYss8rWse+93Nc7XlnhVK/VGWbU71YOc4oR/tD7lZMyUen/VhXqK4U9Xh1HE0vOduNUdJ1TR+x6gCYB2Jt9aU6IIkRA0U82/YpKbx52ED10dT4YHig0oZuAQctovSOauWoUE8FSHN8CC0TV4JjaOuSjbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725534839; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+1shYGf4ZtDj9QHPRod0uklI3TkdqK73XIf3/9V5EeE=; 
	b=ng7LRDidjR457oGQZesHMjObx5gFn+71UZ6g6zdFwenu2yRhpieJTXHmNTwFoUhfnEq8XYDRT4ZbaVCGR+xZgPaNzxEt4D49+kK3ETjE8b4QQO65XnYPMkIjttqOtWGKxgDvvsEjYKI9I2fkeh0N3a3eYYVx1QQfH9NCZE/fLbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725534839;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+1shYGf4ZtDj9QHPRod0uklI3TkdqK73XIf3/9V5EeE=;
	b=PVnatLhI8Quz+SPp5mW7cC8TUbhcSqNJUdr8SOl2cUFy9iaTl0zJzyx9xzh7j57f
	0oakJapGPlrxi12FYn5GeDqpCqqDdL9OBBaWJMpyeKsp2yVvARoq/9mcqLwYD7QGoT4
	4m8Gzhi2L66G8pjpb2wTn6n9kZaVPRka/29Qd6kY=
Received: by mx.zohomail.com with SMTPS id 17255348370753.769146788604644;
	Thu, 5 Sep 2024 04:13:57 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/2] drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
Date: Thu,  5 Sep 2024 13:13:37 +0200
Message-ID: <20240905111338.95714-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905111338.95714-1-mary.guillemard@collabora.com>
References: <20240905111338.95714-1-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a new value to drm_panthor_group_priority exposing the
realtime priority to userspace.

This is required to implement NV_context_priority_realtime in Mesa.

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 2 +-
 drivers/gpu/drm/panthor/panthor_sched.c | 2 --
 include/uapi/drm/panthor_drm.h          | 7 +++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 0caf9e9a8c45..7b1db2adcb4c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1041,7 +1041,7 @@ static int group_priority_permit(struct drm_file *file,
 				 u8 priority)
 {
 	/* Ensure that priority is valid */
-	if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
+	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
 		return -EINVAL;
 
 	/* Medium priority and below are always allowed */
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 91a31b70c037..86908ada7335 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -137,8 +137,6 @@ enum panthor_csg_priority {
 	 * non-real-time groups. When such a group becomes executable,
 	 * it will evict the group with the lowest non-rt priority if
 	 * there's no free group slot available.
-	 *
-	 * Currently not exposed to userspace.
 	 */
 	PANTHOR_CSG_PRIORITY_RT,
 
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 1fd8473548ac..011a555e4674 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -720,6 +720,13 @@ enum drm_panthor_group_priority {
 	 * Requires CAP_SYS_NICE or DRM_MASTER.
 	 */
 	PANTHOR_GROUP_PRIORITY_HIGH,
+
+	/**
+	 * @PANTHOR_GROUP_PRIORITY_REALTIME: Realtime priority group.
+	 *
+	 * Requires CAP_SYS_NICE or DRM_MASTER.
+	 */
+	PANTHOR_GROUP_PRIORITY_REALTIME,
 };
 
 /**
-- 
2.46.0


