Return-Path: <linux-kernel+bounces-276415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23EF949357
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E3287AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B0205E37;
	Tue,  6 Aug 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMpuilDq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C01C37AA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955149; cv=none; b=Fv1iR5HdB2oF1xYlY79U6leOdQRkYxTfDWTx6Q+5WjjgQGYHy6OeOkVACPJd7Y67bg9PhHGaebR5N12AELzzYi7ANAPrVRZctbwBBylvicTav6cByOeVmY2DyC1Dy9P+lJ58UgVItO6NRTK5FR6HyAjE5bEQJ+IBZ3rMpq4lwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955149; c=relaxed/simple;
	bh=L2cQII8RgMnxAHjGK6G4z6NQdU2kB46BPMBysUDgraE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBg9t55e112npImzull1t0R+g4Cr6A9FeA+QQ8eek+iot1BILXzbMfjRZtPQJi7lSo1MkqHzGBCD8R9sbvUaXFuAggcg/sCTQUyyyDzHBSpaUA2GB/Zl5WGEs14fknqpE+A38X2P48L5GukWgRd+Fg0wU/c9sI9aJ5YXjDNsvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMpuilDq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722955146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lulMY4n2fPx2dahXNVvaLbYmQNJeQbtHnB6R7KxHAis=;
	b=bMpuilDqC189h5SYprlxLKISnJ+nfsFXrInyoKebtTYSWZK8e+/oqAq4JxgEhGBL2d76kU
	zoT+/pCHVLiaDwyJbH/B2+bHAnHsIYxx5y8rOBAX6gsnAey1CUelp9GGrPWpW3o8kM728o
	3vtPDof7SOeScRGNtgtnISSOLMPVFIU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ad8r7EDSNcSSNi5VHOvY4g-1; Tue, 06 Aug 2024 10:39:05 -0400
X-MC-Unique: ad8r7EDSNcSSNi5VHOvY4g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef2c1db4abso676011fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955143; x=1723559943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lulMY4n2fPx2dahXNVvaLbYmQNJeQbtHnB6R7KxHAis=;
        b=Zaper5ofDqY/cM9YVVRyzVJU8HMWct5tIjr1g4b5j/tMJQ5Nvf7QLXR1QAOz40DccE
         eV2/uftf2Q1cyYkjbw5/rTvmA9MxWG0J6SJ3IebY8BBMQBTrhp6yCA+dcdXIgpUMm2dx
         OdWgCWDy0bqh7r7vMCgxzJ04MQxnXg+z3fPpR+TQEs0EwpcCKYsiMQ0ux+s1SuCkC+nF
         rhO2qfDl7wTUSxe/n4dHfJgUIaY2EMlW96FFuZslYVwCfZNILdrTEPh0Uxtv3pLSSHBP
         aLct1CWbuF8pUuggiwwqLOGjM8p+OG4KK0AR+E1vJhWP8TITL0Lh/XkD0tFr1E+7C2WU
         +CuA==
X-Forwarded-Encrypted: i=1; AJvYcCVKz+n7rPbuGAr8/+sqnXaV7bzoXf9/mc6bxCHdiV8D3fSVo4Rfar+Q+3TE4taexN33en67/58Ax1qtJWrFxUDoKi+niS+l4Lfa0r3a
X-Gm-Message-State: AOJu0YzcG89YWpSpq8fNh4Qm+tsnE53NbAKQ+CrfM/vOtpm1k+/eIHv3
	B/DE9jpahI7YzIAymJge2+i0b6H/QZlkw9y2T2S0uCHxNHjJiG949yIsOsUMu6oAUVlnTafMJqt
	kfOq3Hk3pI2vWj+fAIghJdUMMukQIg8b4L4YqleLz5QS4FM5TnUPSOHf2s/1UiQ==
X-Received: by 2002:a2e:87d3:0:b0:2f0:1a95:7102 with SMTP id 38308e7fff4ca-2f15ab1c215mr55822311fa.6.1722955143370;
        Tue, 06 Aug 2024 07:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6nTV8TMdweugbmRIe2xn+r+NkGNern8stYSFF2V2rA6O68KoNSruXVS5LUUDKeNLhZZguPg==
X-Received: by 2002:a2e:87d3:0:b0:2f0:1a95:7102 with SMTP id 38308e7fff4ca-2f15ab1c215mr55822181fa.6.1722955142966;
        Tue, 06 Aug 2024 07:39:02 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d165b009a97301f486032f8.dip.versatel-1u1.de. [2001:16b8:2d16:5b00:9a97:301f:4860:32f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e08012d7sm214285905e9.22.2024.08.06.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:39:02 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/sched: warn about drm_sched_job_init()'s partial init
Date: Tue,  6 Aug 2024 16:38:56 +0200
Message-ID: <20240806143855.29789-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806143855.29789-2-pstanner@redhat.com>
References: <20240806143855.29789-2-pstanner@redhat.com>
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
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
 include/drm/gpu_scheduler.h            | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1498ee3cbf39..2adb13745500 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -911,6 +911,10 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
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
index ce15c50d8a10..7df81a07f1f9 100644
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
+	 * callback "free_job()" is  called.
+	 */
 	struct drm_gpu_scheduler	*sched;
 	struct drm_sched_fence		*s_fence;
 
-- 
2.45.2


