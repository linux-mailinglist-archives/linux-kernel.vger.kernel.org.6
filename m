Return-Path: <linux-kernel+bounces-374146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEA9A6576
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388162830F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632D1F9A83;
	Mon, 21 Oct 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+W+GfnB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532B1F471C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507872; cv=none; b=qCEU1NQq0zXoLYhS4W99GrfhZBYdQWEBo2mlewLbFGiafmaUlro/AwfOrvZ4SFdujeJEdBtFLGQjcS5VI/emI7lYkO52f0MUj3lBMYb0oRN2SAqtfgGK0hCLH5X7Eed9yFmZ3NKEC2hH2bM57skYg5H9So8tmif9LxiUz+kR0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507872; c=relaxed/simple;
	bh=Msafcb2tP/edIPwNmjG2Miztz+GL6rtQNa67WgSFId0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5mW0l0mrB7ZD8mtu7RjGIwR2QMxYmgb7IVT9riS1PWWtz84BPq1tkLgGkK0mzOZo6hCkq5sbAKnMTbNZKVPpsvvvhYSIhTtNd78BO2374mTewps4egACQaNeIFIwqPqHVmV6fnSA0QKVQCLBX0CrpGwgwpPjn0EdbQoO1q3nR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+W+GfnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uERVLrzhOKhLyLR6uH7ER1kb2hRnG0ld4wlyovWxQbk=;
	b=a+W+GfnBEmUNQoPX1OTDrQlJgUUZRUK87ZgprM8tH7y/OzFeIZkFZCP2dKNGI+AJK/3dT2
	EGqLtFJuUK9xCshsqW+0hf508CH5qenr19IEIrxPAs6SaPXToKItGcSxmdvGbZqrqm5OGP
	ztI67xj2O9VvqlVS7rurjW8dKg5x8Ms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-ig2d9y1ENOiRrUisxYErMg-1; Mon, 21 Oct 2024 06:51:08 -0400
X-MC-Unique: ig2d9y1ENOiRrUisxYErMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43152cd2843so32185705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507867; x=1730112667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uERVLrzhOKhLyLR6uH7ER1kb2hRnG0ld4wlyovWxQbk=;
        b=JZ2+mwx6Gy7fm1BcfBN2AnKl8w3FPnDG+Fmc2V1j42mGdsNXdgRiLae4uToieyrHLQ
         D8d4w+Ca1OFjR37EL13CjWLKHUve+kOwbiVAVUBNuBrqW5brREp0kqkQD0FWFKThfz+5
         DEOPaeFWlMlB2GlT9nyWuls3qZmYK3H7kcNDOx81IBfWmCFE1s+1Agw11y9YhlrPICFC
         DvPwXEHYCCPIsfcBMLPQYqw6NKfeGw4qgGa/LVT1TYoQ2b76rVrqNwmy/7184biDcbXo
         V+15Rn0JcKF1R75ZOavaqy+urVcwilwqYPXVCS5x8j3SEegYhYE/W9csvNale/++8vRO
         mgPA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVE3OrZe9UuRkhYxdNsQ1cRhNkEipe/S2emGJnOm843afhox02AOzQEuNkpJHteGOxIF2rkUCPeNnz/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6ppznZxjyEmoNuDGVQ7Mfkqxx3qYe95J6AWpwb2BaM81LjV6
	bPQ6WEoDt3OxD6IKdnPS2QQ30Tad8SqqvkvzTE3+6oSwrW3h+ogHfjdXO8orCfBeCwg2NROdDc+
	S44JJWArvHGTh1Z/F2SR8wRbWAsqHUJaXxrer78HEssQ3WR68aqta3q3gBdyAAQ==
X-Received: by 2002:a05:600c:4f92:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-4316168f5c5mr89908245e9.23.1729507867299;
        Mon, 21 Oct 2024 03:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmPGAC/TJn/N01rVgAYAftWJLh4CDyx+85d5RAJFtI4za1CbAHsmGjBAZD5WWq6terZNiEg==
X-Received: by 2002:a05:600c:4f92:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-4316168f5c5mr89907975e9.23.1729507866946;
        Mon, 21 Oct 2024 03:51:06 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d449800aee93296d73e68da.dip.versatel-1u1.de. [2001:16b8:2d44:9800:aee9:3296:d73e:68da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fdb2sm53065615e9.20.2024.10.21.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:51:06 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/sched: warn about drm_sched_job_init()'s partial init
Date: Mon, 21 Oct 2024 12:50:29 +0200
Message-ID: <20241021105028.19794-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021105028.19794-2-pstanner@redhat.com>
References: <20241021105028.19794-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_init()'s name suggests that after the function succeeded,
parameter "job" will be fully initialized. This is not the case; some
members are only later set, notably "job->sched" by drm_sched_job_arm().

Document that drm_sched_job_init() does not set all struct members.

Document that job->sched in particular is uninitialized before
drm_sched_job_arm().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
  - Change grammar in the new comments a bit.
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
 include/drm/gpu_scheduler.h            | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 2e0e5a9577d1..2f1b514ff4cf 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -771,6 +771,10 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
  * Drivers must make sure drm_sched_job_cleanup() if this function returns
  * successfully, even when @job is aborted before drm_sched_job_arm() is called.
  *
+ * Note that this function does not assign a valid value to each struct member
+ * of struct drm_sched_job. Take a look at that struct's documentation to see
+ * who sets which struct member with what lifetime.
+ *
  * WARNING: amdgpu abuses &drm_sched.ready to signal when the hardware
  * has died, which can mean that there's no valid runqueue for a @entity.
  * This function returns -ENOENT in this case (which probably should be -EIO as
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index ab161289d1bf..f7d9bdd0fb6b 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -340,6 +340,13 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
 struct drm_sched_job {
 	struct spsc_node		queue_node;
 	struct list_head		list;
+
+	/*
+	 * The scheduler this job is or will be scheduled on.
+	 *
+	 * Gets set by drm_sched_arm(). Valid until the scheduler's backend_ops
+	 * callback "free_job()" has been called.
+	 */
 	struct drm_gpu_scheduler	*sched;
 	struct drm_sched_fence		*s_fence;
 
-- 
2.47.0


