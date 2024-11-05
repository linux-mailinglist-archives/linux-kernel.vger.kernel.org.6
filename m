Return-Path: <linux-kernel+bounces-396605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395879BCF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A01C22DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935C1D6DB5;
	Tue,  5 Nov 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQwrj2ir"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473614A91
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817123; cv=none; b=F76VD8zdJTOYO27oKXh1JkD7kAqdgJwsWYnmYWVUXBFNl/1lxiPqu/TPYE7XSmnKEyMVdB34VjWGDBMCWTs0QMLCDEfs4sdj4UpB0C1+IC5uOStBwYsrOsWjrl3hOBYeg4WjaO0F9esk6eeHaxZ0cYLDGLK0ymbQXMj1lmGLeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817123; c=relaxed/simple;
	bh=MmmJGGdoZfZMmTC+NwI4RkrzJm2+QhovMPS1H3mI61s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdLlhGVVxU6fXzwFnLWPfwB/JPqxZQk5LQ7O3wdir5eWPeXwaMqy1nejF0txxBrsAlmqitTmtEFvs9tdMZgcnDkKcbH+Yimh5lpAoGwtEGy9hQTpAopWn4ES99XDcGPoYxUjGJzwx4OmKlUU9b5XjQ2tHs8y781j5Jh6lWLMpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQwrj2ir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730817121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dg9BO0Q1/nEs6vwNdPbv/d00ohV0KHxJ+ggBYEXN+fc=;
	b=BQwrj2irSADcLQSHvk1iL8OL7ljRx4PzhrPu3YSk/5Ik44R1XGJMTq5HVnIMfeWBpRqI08
	VU9Rym6S+Q/vEr7p6kmRUbGBNvfDHpwQU0EzfZiXiyxfbAfP6pbc+8BH37YOCVxlbvFmir
	/eLmglx/y0SXgkEyM13pg4+WfYwn1KA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-4ctQJSUSNnqo3qPSosICWw-1; Tue, 05 Nov 2024 09:31:59 -0500
X-MC-Unique: 4ctQJSUSNnqo3qPSosICWw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b154948b29so899868285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817118; x=1731421918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dg9BO0Q1/nEs6vwNdPbv/d00ohV0KHxJ+ggBYEXN+fc=;
        b=OSbdNGwY7ob8Jwz/r6S2RAnxr/LGgjIcPLOM1hJ2bjiIowa6KndAhgMDAhxHeIIx9v
         w1AzIDwm+RAExKy6vccgn4/2TqjOCyuUbwfJrGVYQ+ws4Xp44PyhqKsoPiXMdtt5UnKt
         hAPOSYftxwhNhCJfT6NT/8mlv8EBvaDQJKpcfW/D7vs1YU4TknoNk0ALycJKqnTCzkgd
         dlKuflISs/vXfKPmglowMX3TOm8Q3Sifvuu5LtivJJDPcKIsbkgv9gsBrKw7s2DPHfC9
         B+BwU6AXRwPUKQqfnSjOi1Fp1SJgFM4wf8pEDnSYqknag/qrUw8ynX9yxtu1Vlbuy4cE
         F3Og==
X-Gm-Message-State: AOJu0YxF5QnhqmU2x0NxK7BWGr3kQS69A0sFuwLYFwu1/zsEZkldMuaN
	CBId/tT4dApTbLLVa3J1kBXVNdsOuh4XZHT2jAa29iq4HNfDpomUezpYXLR3RMYUFdZZ+5F5QH9
	lMIOy+/kQhosr0kiGwznvQ5kwbzxMw4wqH/sm5Jywnut1DpkNJKdzB6MI2Zx8dA==
X-Received: by 2002:a05:620a:2444:b0:7b1:440a:fdf2 with SMTP id af79cd13be357-7b2f24dd30bmr3019845885a.20.1730817117952;
        Tue, 05 Nov 2024 06:31:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEHOkartUQ0kZG50rozwCxh7PXfh3AA+n6uCFPIpb+yp8pRTKY9/YC6WDS0pWDiPw7O6nJyA==
X-Received: by 2002:a05:620a:2444:b0:7b1:440a:fdf2 with SMTP id af79cd13be357-7b2f24dd30bmr3019843085a.20.1730817117550;
        Tue, 05 Nov 2024 06:31:57 -0800 (PST)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f8fffsm524903685a.29.2024.11.05.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:31:56 -0800 (PST)
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
	Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/sched: Improve teardown documentation
Date: Tue,  5 Nov 2024 15:31:38 +0100
Message-ID: <20241105143137.71893-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If jobs are still enqueued in struct drm_gpu_scheduler.pending_list
when drm_sched_fini() gets called, those jobs will be leaked since that
function stops both job-submission and (automatic) job-cleanup. It is,
thus, up to the driver to take care of preventing leaks.

The related function drm_sched_wqueue_stop() also prevents automatic job
cleanup.

Those pitfals are not reflected in the documentation, currently.

Explicitly inform about the leak problem in the docstring of
drm_sched_fini().

Additionally, detail the purpose of drm_sched_wqueue_{start,stop} and
hint at the consequences for automatic cleanup.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi,

in our discussion about my proposed waitque-cleanup for this problem
Sima suggested [1] that we document the problems first and by doing so get
to a consenus what the problems actually are and how we could solve
them.

This is my proposal for documenting the leaks on teardown. Feedback very
welcome.

P.

[1] https://lore.kernel.org/dri-devel/ZtidJ8S9THvzkQ-6@phenom.ffwll.local/
---
 drivers/gpu/drm/scheduler/sched_main.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index e97c6c60bc96..3dfa9db89484 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1333,6 +1333,19 @@ EXPORT_SYMBOL(drm_sched_init);
  * @sched: scheduler instance
  *
  * Tears down and cleans up the scheduler.
+ *
+ * This stops submission of new jobs to the hardware through
+ * drm_sched_backend_ops.run_job(). Consequently, drm_sched_backend_ops.free_job()
+ * will not be called for all jobs still in drm_gpu_scheduler.pending_list.
+ * There is no solution for this currently. Thus, it is up to the driver to make
+ * sure that
+ *  a) drm_sched_fini() is only called after for all submitted jobs
+ *     drm_sched_backend_ops.free_job() has been called or that
+ *  b) the jobs for which drm_sched_backend_ops.free_job() has not been called
+ *     after drm_sched_fini() ran are freed manually.
+ *
+ * FIXME: Take care of the above problem and prevent this function from leaking
+ * the jobs in drm_gpu_scheduler.pending_list under any circumstances.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
@@ -1428,8 +1441,10 @@ EXPORT_SYMBOL(drm_sched_wqueue_ready);
 
 /**
  * drm_sched_wqueue_stop - stop scheduler submission
- *
  * @sched: scheduler instance
+ *
+ * Stops the scheduler from pulling new jobs from entities. It also stops
+ * freeing jobs automatically through drm_sched_backend_ops.free_job().
  */
 void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
 {
@@ -1441,8 +1456,12 @@ EXPORT_SYMBOL(drm_sched_wqueue_stop);
 
 /**
  * drm_sched_wqueue_start - start scheduler submission
- *
  * @sched: scheduler instance
+ *
+ * Restarts the scheduler after drm_sched_wqueue_stop() has stopped it.
+ *
+ * This function is not necessary for 'conventional' startup. The scheduler is
+ * fully operational after drm_sched_init() succeeded.
  */
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
 {
-- 
2.47.0


