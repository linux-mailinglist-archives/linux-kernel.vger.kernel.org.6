Return-Path: <linux-kernel+bounces-285508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B245950E54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE50284681
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9761A76AB;
	Tue, 13 Aug 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aVxi57OV"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504F1A7072
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583197; cv=pass; b=jhdd5DJVC2gSvJp4BQ5tWM4z41eK+CUFdBp3fAf1GDsFOuK/fxG1eexBtmCQhsAe/YtmQlY1asH9Uq57ItIaCCkvL091y4O9qHsRNfh8CYCnoeH8LRyVYtHQqYySi4CUjpHFwooqqmRcqzJXaikRpUy/dAzqfhXCPX2jSjayIKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583197; c=relaxed/simple;
	bh=zdjBsAr4gMxdC5HW/ZwOouh4ea8rth+C468BcIC9+b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZYIpsAaG9/LNndkmJVEqYxc+W/u1sh6wEN+gysp15FHyjVlPzvcMYX2WJSuTwJ2hmUCmBB1PUn+QQkzS+R4fC68MB1o+s6MayZawB19GYj6lb9KqmGfyVvDJhqlrbs85CdO0U/tZFgv+rr+40rFVmLKdXdfov0mVQmLUH/CV8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aVxi57OV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723583191; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DcX1Pyuhfk9dXPS4rK9VeKblu6L3/jmS9rNcwVo+ufKL24LfwD382rDrFugP/ZwYsgTrvQFxZp3CnKd89Ig87WGY0WFx5/4YRNNsm5YSSgpbaQsR5vQUKsm12QxNh/jO03FsMoVxdm6mYJiXifkH2BJHje5A20V5ntiqx3jKwAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723583191; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rD+SnsdX/sylSEfyI7jJsNyloIr864MAV90HZjGumtc=; 
	b=Dz9xgmjUrD2lQhf2+vMNu2WssTa7wR/nWtqsTnGpDS8Cm4YRhvtyH1nKUEvQc/keBPsHSLmx1AvpijisHDvYneMFYmD0OMdOrzOMbCkp8M0CsNbC+HqrU81YfcZwTyQFxkrBMQdQaKBxUDd4vDR4cAMB0rscLzgWpSKu0700lcs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723583191;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rD+SnsdX/sylSEfyI7jJsNyloIr864MAV90HZjGumtc=;
	b=aVxi57OVrGFIAL17GDPLiHlFn7hyEjVyEY26IvzQP4FakMVnpuN2/m4GKB38EmPe
	WMIaqxLvLXVyZXp45YgplpHkkJtFnG6KgzdMa8E5SqtgDin3bCGX1+rtUPaS3TFa8K+
	9HnRggWVYqkRhMkLAUCvbFncTOlusnFD6Bunpc2Y=
Received: by mx.zohomail.com with SMTPS id 1723583190644813.7539044857064;
	Tue, 13 Aug 2024 14:06:30 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm: panthor: expose some fw information through the query ioctl
Date: Tue, 13 Aug 2024 18:05:44 -0300
Message-ID: <20240813210555.607641-3-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813210555.607641-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240813210555.607641-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This is of interest to userspace, and similar in nature to the GPU
and CSIF information we already return in the query ioctl.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_sched.c  |  5 +++++
 include/uapi/drm/panthor_drm.h           | 19 +++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index e388c0472ba7..224c53dcfe6d 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -100,6 +100,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @fw_info: Firmware info for the global interface */
+	struct drm_panthor_fw_info fw_info;
+
 	/** @gpu: GPU management data. */
 	struct panthor_gpu *gpu;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b8a84f26b3ef..fb30e119d9bf 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -164,6 +164,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 	_Generic(_obj_name, \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_fw_info, instr_features), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
@@ -765,6 +766,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->csif_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_FW_INFO:
+			args->size = sizeof(ptdev->fw_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -777,6 +782,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
+	case DRM_PANTHOR_DEV_QUERY_FW_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->fw_info);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 79ffcbc41d78..e0ecc8bcfaae 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3495,6 +3495,11 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	ptdev->csif_info.cs_slot_count = sched->cs_slot_count;
 	ptdev->csif_info.scoreboard_slot_count = sched->sb_slot_count;
 
+	ptdev->fw_info.version = glb_iface->control->version;
+	ptdev->fw_info.features = glb_iface->control->features;
+	ptdev->fw_info.group_num = glb_iface->control->group_num;
+	ptdev->fw_info.instr_features = glb_iface->control->instr_features;
+
 	sched->last_tick = 0;
 	sched->resched_target = U64_MAX;
 	sched->tick_period = msecs_to_jiffies(10);
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index aaed8e12ad0b..e235cf452460 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -260,6 +260,9 @@ enum drm_panthor_dev_query_type {
 
 	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
 	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_FW_INFO: Query firmware information */
+	DRM_PANTHOR_DEV_QUERY_FW_INFO,
 };
 
 /**
@@ -377,6 +380,22 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/** struct drm_panthor_fw_info - FW information
+ *
+ * Structure grouping all queryable information relating to the global FW interface.
+ */
+
+struct drm_panthor_fw_info {
+	/** @version: Global interface version */
+	__u32 version;
+	/** @features: Global interface features */
+	__u32 features;
+	/** @group_num: Number of CSG interfaces */
+	__u32 group_num;
+	/** @instr_features: Instrumentation features */
+	__u32 instr_features;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
-- 
2.45.2


