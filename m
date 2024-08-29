Return-Path: <linux-kernel+bounces-306029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38A963838
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B559BB23381
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB42AF03;
	Thu, 29 Aug 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfJABDni"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCEB45979
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898772; cv=none; b=GmqjAmo4t6V6EqxHMQHjfjIBQZ2lfdZOIKisRQ4ufYZHWTrkMmulBL0Qf87Y149S/FK6I5jcUMKGn5ObgLHKHGq/n/DedB2Bvx9IbOHfG+HpIOyePK2AjdKLU+AD0vrxIj7v/eW/AlRfyrFPutEIO7/W8ATFhVaoqrCtCGC4eLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898772; c=relaxed/simple;
	bh=g/5LbmHnotvHEXV060QbcaR3Wonxgh91kA8cNdJCcnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWWposK8pQ5ABtQ+jwTlC9FO1LTr/Ik+/jCD68vQxZ/WuNWwhcoBOB6LixGmgvs59jrpLK1b/PLqWv+tyGq6Qc8h/FkB2vKmRSqHa1UOObdpjEMHfCNODbNMQbilGcIeX87n++/64ayhk5aDmE0n/F1D2wCYAF+HROyQMFSYwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfJABDni; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201eb53ddbeso68575ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724898770; x=1725503570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rGIMaZIlS+uYoamxpeB6aDyElxjZF63C2u5eChs7sA=;
        b=YfJABDnizsC3Rv2QPvisRAjydJOi3QeI1Z2PkPVJamJcsKOgpvpFZ0izk9yDgZX+Wm
         1jBmizocR7l8Btq3fee9mD427K8WDhS22IbHkr/aVnV7M88+LEKWY3aCMI4CJo7fuKG3
         0cDOZJ435yENGhoT65tD5v7h7XGTlF/Zw3MJ3dcp5k8uVoR1zLEthbs11lMw7ervGm16
         oNtoaW4AiJl0NMG8/o0wPacVCvGFvt++WJ74ySYuwp4dHvKiYIfpDBqjJK5cRuNoG0Gr
         +34pHRic5TZL4BVw4EwresLOkpIGCSTIRjjBIckjcFYOiOy1KdyOQJsdM+LcNAuUjthn
         +9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724898770; x=1725503570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rGIMaZIlS+uYoamxpeB6aDyElxjZF63C2u5eChs7sA=;
        b=o5MHtt8GMK9mH8M/YwXDMH/BLDTHQNci9gUEMV+b55N/CSFzQewVCx8K5W8nkozxkw
         yC9um6++z+PlT27SFAeZjczV+FtBmZ9667lGlfWqJDVv8dnXvK653Fuuqs3b8nUJMKe1
         OOI2q4XbSUB6kE+Sw/8NfzNDAReu1RK39WbW7GF1dxjvb/OG/oezaVEdMKSAQ7HAY6DR
         /H7/CrBzCzxmmsxwTqF24n1YUBbjvkF4lcrHQoYrtc/6EKnHrDA+hMLa+Ar31eXrOlsL
         BXx9gRvAMpDnPJcPQWpi2o7hmnTfCgWhAQtH/erpyGuHV/aX2uo2yvLTSdYUAr6A6qX0
         L4kA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Q9/Zj/snd97kKv1MxNB2nKYZsyvqMx4e3PdPKeX6KaNd5htYU5Bi4/5oHBxMT3uiu3ANFuJDXXi/tm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZHlvU9NCSICMJQjlwJCQn4yBf4tDIvg7jyvy2Mr1Q7V11MEM
	VasaSooN6yXMPyfVi7GnCXlFeTtkB3281ItgkQz1VvtUr/5lHdsZ
X-Google-Smtp-Source: AGHT+IGQHvu+cnPJ6a1QdizBA5u3ZH/efwyfT1xu4ykAr0DVKpuVEGiBrjP8b9EGaukHWAc8sFm0Ug==
X-Received: by 2002:a17:90b:1e12:b0:2cb:4382:99f1 with SMTP id 98e67ed59e1d1-2d8565339c6mr771970a91.6.1724898769543;
        Wed, 28 Aug 2024 19:32:49 -0700 (PDT)
Received: from localhost.localdomain ([182.148.12.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462aec5sm2693131a91.32.2024.08.28.19.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:32:49 -0700 (PDT)
From: qianyi liu <liuqianyi125@gmail.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com
Subject: [PATCH] drm/sched: coding style fixes: miscellaneous
Date: Thu, 29 Aug 2024 10:32:40 +0800
Message-Id: <20240829023240.1871078-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following checkpatch:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Missing a blank line after declarations
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 2 +-
 drivers/gpu/drm/scheduler/sched_fence.c         | 3 ++-
 drivers/gpu/drm/scheduler/sched_main.c          | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index c75302ca3427..ea7059886d2a 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -90,7 +90,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 			     __field(uint64_t, id)
 			     __field(struct dma_fence *, fence)
 			     __field(uint64_t, ctx)
-			     __field(unsigned, seqno)
+			     __field(unsigned int, seqno)
 			     ),
 
 	    TP_fast_assign(
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 0f35f009b9d3..0d60d585dabf 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -90,6 +90,7 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
+
 	return (const char *)fence->sched->name;
 }
 
@@ -221,7 +222,7 @@ struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *entity,
 void drm_sched_fence_init(struct drm_sched_fence *fence,
 			  struct drm_sched_entity *entity)
 {
-	unsigned seq;
+	unsigned int seq;
 
 	fence->sched = entity->rq->sched;
 	seq = atomic_inc_return(&entity->fence_seq);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..ceddac09829c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -667,7 +667,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 */
 	cancel_delayed_work(&sched->work_tdr);
 }
-
 EXPORT_SYMBOL(drm_sched_stop);
 
 /**
-- 
2.25.1


