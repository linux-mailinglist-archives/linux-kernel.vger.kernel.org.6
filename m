Return-Path: <linux-kernel+bounces-576558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C01A71107
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E6B3B9694
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB16197A76;
	Wed, 26 Mar 2025 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmBQwGOT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1F19597F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972716; cv=none; b=mq/PHggEHGR0qwbgFFfrHBE/FzKznTF9Z/TsaGvKWB6wxZyRIG2a18vibVeeejqO8hSJQoW9G8k1dEkd4JmOr0w6dQBEQ8IFyyb9m/pSiScnFhkKRKM5GBek25p7FVVNodArcltPA9IffiXpmOuZxxbvxLrXByJNrRe2kO0vEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972716; c=relaxed/simple;
	bh=2WLUTCYOQF1rf4u3l0DB20z6JBwEjZtBoLWLQO24+wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFwHN4f60DVJOFg6a76i2Y59f7ouxiODgSYX6Ejok2hCiZRbF8X4qaLaUIxd8/Cfdn3te4oyXftPI3KqeFZUlzhGGSufV7hPXPTssFOj2PmtpuXPpGvKknV8fYsDe9BwqZGTP2Z2QxosclCRkIdr4K/Qf/8Nk2v1Spex9ofKYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmBQwGOT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264aefc3b5so15556845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742972714; x=1743577514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5M1dmQ51OWKbmNdrtMEljTJB1EZHsX1ujWaE7KOrUU=;
        b=nmBQwGOT58X+SJ9iALoI4L4ye9QJmn5WyrxgqVR5/ZEWO8crlC3OeiBGLmN1Ts0N0e
         Wx/prBpAdLu1HbGqbmUK6/7r6pG8d7ak9St7BMjPdVCPKnPNLoASI8pENFeQr4q5YW46
         1els66suDvTpHKT6x2nx5jCw8ah8xZuOs/GNX9Wc4WhvyAEJpSc8YgyCG/WV9rk2cEZI
         ZJrhiyqwSsKk17SMLI/eFo+NDavEHO4vob51RLYFD8P0WWMRIB0yQUTqgLr4AyCYq9zq
         ldwsmgSoRxoVOPaVATAa6RZl7rJjzHVpQiP/oL1Ie4CurKf5PEGZbNWArlep7tqkkaRH
         bRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972714; x=1743577514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5M1dmQ51OWKbmNdrtMEljTJB1EZHsX1ujWaE7KOrUU=;
        b=vdbEzHMEHW0BUU5vsU2omMgg6hHzAD16qyHWN7cRB5ycxcqhkUhZOMSul5MLwYK8DM
         jeXD5OuJxdne77/OLKpTKd5bnFADQuN+YNE0ZKr5GZUrqi/J95n4GSZp4ndpYGI0DB78
         yLYLAhorgMWa/eORnssrKoZFJizSC1oSevbCO/UA6rlUC40tsNnsdGiRYvhIlwp45yn8
         2TwTHP622LF7CL95fgarpBv7Ipe6BXWJYX0PbN8x2J2RsLEmzEkKs6wtek6GFRgmmn2A
         RhMxSCeFG/L495LyVeE0frXWKTee9EYQj3UKYTC4aka4lB7MRkxV+qXfg1TorL9yNlNn
         QLFA==
X-Forwarded-Encrypted: i=1; AJvYcCVPlqkZaxm2JXDCQKmDWZ6Plp7g0F2x3M6VyZnF+LmxuYmmxELQCSYv/dd5I+QSbPK3dV43DC3yyXTZ0PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBd0/6P23/VJF24v2QqYNRF1MgYj8jwf0iwDtHonBKi6a1aDc
	f/n/nBSptidf82bfKaV3zvzNk0uxMBsJF7BB1THnEZw1YNwBMHIWiuckXA==
X-Gm-Gg: ASbGncusFC07nSrj0spghMdeqqeu9+1L8M90+QpptKSYYWjfUs0Gw8eEtlrC7mS5mPc
	b3BbRLE5dz3W9DGVkBWwqJONVxmvkI+2Iy5ljs8fCsXzER1gcXgbMpwYN4wUSEsvwkzBskwfTms
	g6KYTVNT4tVvsDrgm7igGlnZNSaHLkst6OCENi750a3cXdYTzGUoxLMtNj1H0M9vL6n8Y7FGFMr
	rM3rObxSdm24pcsr7v1ulilOr0Wvhtr4+t7OA2pgT++WdiFdcaxoaY9MY4dTy8T2UXK/Rby/lE3
	vyOE6CTxArRYleull1+sIN0XG0WGTQVUnCaE9bFh3kUQea23/MkFGNrEhXgZWxkHc5aHO9q36qe
	JwCFdUNrgiB+orOJWO/3fDQ==
X-Google-Smtp-Source: AGHT+IGpzx6/Khs0/BUqQJij9lRr0pXhV1cXF3zLYPm7lfJcElBkqaLch5KGQ0T2Kt93pE8sp5FCrw==
X-Received: by 2002:a05:6a20:2d26:b0:1ee:cab3:4287 with SMTP id adf61e73a8af0-1fe4300f32bmr11293700637.7.1742972714237;
        Wed, 26 Mar 2025 00:05:14 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-171.hinet-ip.hinet.net. [210.61.187.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576c65sm15709455a91.10.2025.03.26.00.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:05:13 -0700 (PDT)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org,
	airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com
Subject: [PATCH] drm/sched: Add return value for drm_sched_entity_push_job
Date: Wed, 26 Mar 2025 15:04:41 +0800
Message-Id: <20250326070441.1515428-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently drm_sched_entity_push_job() has no return value to indicate
operation status. This makes it difficult for callers to handle error
conditions properly.

Add a int return value to drm_sched_entity_push_job() that returns 0 on
success or a negative error code (e.g., -EINVAL) on failure. This allows
callers to:

1. Detect when job submission fails
2. Perform proper cleanup (e.g., release job and fence allocations)
3. Avoid potential memory leaks in error paths

Signed-off-by: Qianyi Liu <liuqianyi125@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
 include/drm/gpu_scheduler.h              | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index bd39db7bb240..f31964e76062 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -579,8 +579,10 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
  * fence sequence number this function should be called with drm_sched_job_arm()
  * under common lock for the struct drm_sched_entity that was set up for
  * @sched_job in drm_sched_job_init().
+ *
+ * Returns 0 on success or a negative error code on failure.
  */
-void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
+int drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
 	bool first;
@@ -609,7 +611,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 			spin_unlock(&entity->lock);
 
 			DRM_ERROR("Trying to push to a killed entity\n");
-			return;
+			return -EINVAL;
 		}
 
 		rq = entity->rq;
@@ -626,5 +628,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		drm_sched_wakeup(sched);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 50928a7ae98e..48a263571bab 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -589,7 +589,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		       struct drm_sched_entity *entity,
 		       u32 credits, void *owner);
 void drm_sched_job_arm(struct drm_sched_job *job);
-void drm_sched_entity_push_job(struct drm_sched_job *sched_job);
+int drm_sched_entity_push_job(struct drm_sched_job *sched_job);
 int drm_sched_job_add_dependency(struct drm_sched_job *job,
 				 struct dma_fence *fence);
 int drm_sched_job_add_syncobj_dependency(struct drm_sched_job *job,
-- 
2.25.1


