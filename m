Return-Path: <linux-kernel+bounces-378149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65F9ACC10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D2DB21B73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A21BFE10;
	Wed, 23 Oct 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ/ytqQX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571861AD9F9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692974; cv=none; b=Zi7KxBgtxI5TXQlrkjf07bOKFj/nWyetdvg5vpfHfsRNBByglbxgJH1NNCN29MN7c0WaWdsbEP3AbAa0qtQ+s+JCCM/izX6qYxJSDULzylMxlmmIHnUb975hz428IMBiEAVL1vMkbSGwnt78iCnDpYEGQtNb4q/U8aask/2+ehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692974; c=relaxed/simple;
	bh=CepiOc19ez41i2iehC3hHQFCdGSM2/GTcn0537vWK14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeR7JmlMW0b3aQ1LE/kVIrVpB5FkWlPrMpYxpRMnLdiG6D/zFAqbpS9cBId98RXmluuBBjUcKoh5XI2TlIsGkBkIeJi2pNp9C2iEBUuEIyoAEXsgJ7Yqs7P9Hb0BssPMKZ7QPmUaBMkasFvnKdXG//oneGTS5Mz1FImunwb+KCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJ/ytqQX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729692972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lu+U1UtLeYKuG7KvpNGTP1vzTWevM8/vvCGog3NAbpM=;
	b=hJ/ytqQX73QvsdkhlqdyGeKm3NtyeHzc2TqPMBikUCYE4DNFLgJuzxQWv9KOefoNLLanM7
	ohQfBvW9JMkRYRQ7uXJIGfbr84yxHwBG5xmuZsbtWHL84/hWYl0mbWBnxTw9IYeiHm+a6K
	0a1VbSiKJg6jM0FmH+8aJy2TEzp6zwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-tJ_vYtCEOLaedzolbmYUwA-1; Wed, 23 Oct 2024 10:16:11 -0400
X-MC-Unique: tJ_vYtCEOLaedzolbmYUwA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso50637515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692969; x=1730297769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu+U1UtLeYKuG7KvpNGTP1vzTWevM8/vvCGog3NAbpM=;
        b=LuntRjiS9djyMw8mVaajcL6EJrhg5ynnNAstReYb/YDtfRYbNVHk4ToHAX1fmCvYVB
         JchSkzY+07CJuuubT/FOHFHpDgR5w+YDRK3CG4ApOdV20yxQGGl0exanzRe5pbhHndbQ
         tMJR8NDamvVl5CcvM7ujLxFkfAfuxczTHdPmhHnvZkX6FqUSmgBXqfbpHQgDek/EUwn5
         0Fu8OPqufv6cO8RG+NKhncfCT3gYcR7sCKSSl0x1shL/vI4rtrqk44R9cNuNv/N/1eMS
         AoyVRSNrltbE78wzd0UDrtI9Hsq8Iw8BaPOKru8201levp6cRT9hJPYyQRxfVD5PrGDi
         EcEw==
X-Forwarded-Encrypted: i=1; AJvYcCWEmdSDzLOhbG8RVgprMiPBAS0yrcQvOJCG+gCGHDnz+upaZhJLHn+DUI32qgHKRpBr2LztFu57BSHgkZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7lIEACmtk17YKFfoT/gferAEUDnK4WmbSpC8rCASPmn5vuQS
	ycCF5hy8h7GnxCpUe75yYBHdL2bi9qjFw8fId2FjvgOOz4w/hDUUDBVekX+FvyqWZalwaApLfZ2
	c6kQACnjzjZatLLkuVu2HiMRnQoNwtlcaDZByoAUKzjoe9OjgqUTgeImPLKKO9w==
X-Received: by 2002:a05:600c:1d27:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-43184189bf9mr24037965e9.26.1729692969153;
        Wed, 23 Oct 2024 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHar1p9asUu+YXdAKrBOIOL/4ioKmiQlOhE0COxng/W6LCWD1YB5yXLgKgHAXBJX00kApY/Ag==
X-Received: by 2002:a05:600c:1d27:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-43184189bf9mr24037725e9.26.1729692968775;
        Wed, 23 Oct 2024 07:16:08 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dac:2f00:8834:dd3a:39b8:e43b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48d51sm8961432f8f.38.2024.10.23.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:16:08 -0700 (PDT)
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
Subject: [PATCH] drm/sched: warn about drm_sched_job_init()'s partial init
Date: Wed, 23 Oct 2024 16:15:31 +0200
Message-ID: <20241023141530.113370-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_init()'s name suggests that after the function succeeded,
parameter "job" will be fully initialized. This is not the case; some
members are only later set, notably drm_sched_job.sched by
drm_sched_job_arm().

Document that drm_sched_job_init() does not set all struct members.

Document the lifetime of drm_sched_job.sched.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
 include/drm/gpu_scheduler.h            | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index dab8cca79eb7..8c1c4739f36d 100644
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
index ab161289d1bf..95e17504e46a 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -340,6 +340,14 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
 struct drm_sched_job {
 	struct spsc_node		queue_node;
 	struct list_head		list;
+
+	/**
+	 * @sched:
+	 *
+	 * The scheduler this job is or will be scheduled on. Gets set by
+	 * drm_sched_job_arm(). Valid until drm_sched_backend_ops.free_job()
+	 * has finished.
+	 */
 	struct drm_gpu_scheduler	*sched;
 	struct drm_sched_fence		*s_fence;
 
-- 
2.47.0


