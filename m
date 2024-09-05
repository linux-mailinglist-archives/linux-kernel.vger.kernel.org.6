Return-Path: <linux-kernel+bounces-317624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48996E132
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A04A28B2D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5911A3A9D;
	Thu,  5 Sep 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="UJRj1ILU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325643AD7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557743; cv=pass; b=DxuO8700dkSltYf+ZHyF+WQQBNIm9wQNn23vckjPE1htg3EmJ4oXl83QSTTFn8nzTNF+G+kn6oV8kvRNc+K+tPDQuuTOGUR1V1qquxgBV0NLz+Gn3NGQTcZEo7TZs7VinTbYa079M246GbJ53TbyVYyP2CxsN88T5j4ZI252wm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557743; c=relaxed/simple;
	bh=TcLtty2RptxKPPI383SkE/ieSchkqfEXGsLzWd7yv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB0ekeFXIsL1pL8/pT+biu9ZbyqT6y2+88Xcjk6rqDqPzUkv8Vd3DMPPHhN1eH+DbonsyYkmULyRqrORhxZWPnRN3UPs1INkESoz1to4qjU/TZs/u8rHK+7P3mMvb/beR4qhAbpdKW6gjpxtxdxMSiwU/ltijjd6Dy/krHUW7hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=UJRj1ILU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725557725; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b156AYO+oZzDEMbMvxvbsSf2F8JpcEeAzdPhVrb+qjP3CDEdm0/UIfNrwGdj9gYJu6HhJg0bwmwCe/7pc9hBr70NK7BnW2fxt+9NvzB8gLVjd8sqUK0dMcPabiQqzd2y62cKdeLpGQYlup2/FL+G/I91hwhv3PohMsbyWpz9ZS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725557725; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HYM5u/fHo7iGGHS/z8VDUzre1NWgiamrEj1KE3b3Iu0=; 
	b=NCX9gSwFD5Mg2OJzeLyxk9fFfNDOpOyrjbmAe4qFEBksO9xeArssvNcDIbLR6Uzy4PdgxE/ytgLkUNQ3yMSbi1wy3Y1mxCYPEJiJvUrlJlteeSTCMc9+SvBpvtt029E8R8oejI9kOBi3ikdCv0G2BfiBJ2tGmgS2FXXt7KcKd6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725557725;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HYM5u/fHo7iGGHS/z8VDUzre1NWgiamrEj1KE3b3Iu0=;
	b=UJRj1ILUCtb34vaBYweH5SIb9C7rMmQy5Y92kTE6xIcaUf0n2Wk+xmwidwipjUG7
	/Kuv81Px5d+uadaxbRQ2BAfVJ4o/JkcowIOfoh1O0YpeExy4DMOH7K/gW6RmA5eBtJx
	aM9Xm6a3iYbp83Uc4IQrHok1rqoci/9+rbUZOQ6U=
Received: by mx.zohomail.com with SMTPS id 1725557724160298.21237444293433;
	Thu, 5 Sep 2024 10:35:24 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
Date: Thu,  5 Sep 2024 19:32:22 +0200
Message-ID: <20240905173222.252641-3-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905173222.252641-2-mary.guillemard@collabora.com>
References: <20240905173222.252641-2-mary.guillemard@collabora.com>
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

v2:
- Add Steven Price r-b

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
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


