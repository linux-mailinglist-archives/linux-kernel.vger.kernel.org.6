Return-Path: <linux-kernel+bounces-304708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2F9623C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460ED1F22229
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5F166311;
	Wed, 28 Aug 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERtxB95T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51D15ECD7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838110; cv=none; b=gBNDNvcLYTF1oxkip8xagMHRgq3k0F62EIjSWLwSfzZbkadIv1JaRCfFNRYVy2PzQb/7Uksl2qkqM+hCblYNbII4YG8MV2bnAcwc8cMLnZMgI/Zca6AxvRAwngrZX4Z1BFVNnBELRJ6cCU8harnWP4JuP49HJP9c15fRD0hqKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838110; c=relaxed/simple;
	bh=ijW9HK0AX+zSVQ05woUWipxVFsvGYGmBgdCJ3SpVx8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdDzoi442URF0aUgiHx5qYDnGcVb46hu94QUsVSCYwKLVSD6S4YGHNLg/ezHkMgU+T8Y+UDFnpUxxpXtYCziseel45pJbdA/zHBWGs6uXj/V7qvNYTyKwaWhA9MLAqAQrFzzOBmqvcfZkBkCpY9xq6GK5dC/M7ymnEIFXVbqXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERtxB95T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBYc7EE/zONAzLlymWb0hmVq6yfD+J/1DdujpaQCA4s=;
	b=ERtxB95TKxsQUZ247WKqmi4cZ9O49R7GMYvevhWjJmChkBpjlvqUvGLYzHACMxeFOcBnXO
	H85p/HMB5alXi4Bv3tvc9VLr3pgYxRn0MaMqzSClFFNGoQnR3eXvqRqAL3aYF5tSx3tQGH
	fqHbH0Fm8GzVDGbx8TR/dnOeq3rzOT4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ak6nz5vCNkmwH2WCj1e79w-1; Wed, 28 Aug 2024 05:41:46 -0400
X-MC-Unique: ak6nz5vCNkmwH2WCj1e79w-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6b41e02c255so138238447b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838106; x=1725442906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBYc7EE/zONAzLlymWb0hmVq6yfD+J/1DdujpaQCA4s=;
        b=e/4waVvwtShpkeafEVIGIO6RuAn2E1Kq0G3B6yipuk3qzyKUf1TLKw5qTCQjtDCOOz
         KwyyPyAVH2/8BRMJ0Avc/7R/MUlp9IXElPaa0OjZ6UWGuVrDW/qDtbZmrW4SLUyue/S5
         nR/XyG47ZYGGcKXoMaMRp6WQBHe7wWd+UGL2CflXhMIRqNnMi/31fIq78hGutiN20kIF
         p0yJdrFxVGRdOVPwqrzfyU5F70ZW/cAQHel9WD3XB1/G+pQLWoYKV03znM7LMF/IbYJb
         VQwAkZstZWjK5tihHiiPHwLGUhQyGwi0Y95UsLL5+HK8aNpIaS4eYt2nYvS7xxcuNcfs
         DeEw==
X-Forwarded-Encrypted: i=1; AJvYcCXKR0QL2x8SdKzUg5htsbXqvGE99AHtIzTWk/nYT+JZZPC+rgJN7qlLxQGi60zvtvz2WXaJ/mO1YILoW/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUE9Q9qhCR14Oa5GkR0kOvvq28kfar4CNwztfxH0FodmoT77g
	OM1j+87eSUtSRmbYCM5A3Jlw7On88Mqfk6yCgSuLCly0LZ+7Rbc1BpICdhUG4YyKQmf/z/Gzli6
	qP0+/oHKthmJv2S33nMVyHI1txrazTLwEQgGnAPVpDJhSbxrixCxGtadr/rleig==
X-Received: by 2002:a05:6902:18cd:b0:e0b:d622:7586 with SMTP id 3f1490d57ef6-e17a8c1f785mr20922791276.40.1724838105960;
        Wed, 28 Aug 2024 02:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUtII/J0HGM1CH1sN1ODHa9rrXP87mYcjb70QmCWucp301KDKoN1ciQoJLegsU5I774A88iA==
X-Received: by 2002:a05:6902:18cd:b0:e0b:d622:7586 with SMTP id 3f1490d57ef6-e17a8c1f785mr20922764276.40.1724838105582;
        Wed, 28 Aug 2024 02:41:45 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d6548csm63220746d6.68.2024.08.28.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:41:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 2/2] drm/sched: warn about drm_sched_job_init()'s partial init
Date: Wed, 28 Aug 2024 11:41:35 +0200
Message-ID: <20240828094133.17402-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828094133.17402-2-pstanner@redhat.com>
References: <20240828094133.17402-2-pstanner@redhat.com>
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
index b0c8ad10b419..721373938c1e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -781,6 +781,10 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
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
index 5acc64954a88..04a268cd22f1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -337,6 +337,13 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
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
2.46.0


