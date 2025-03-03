Return-Path: <linux-kernel+bounces-541920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D2A4C367
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1256D3A8332
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA22116ED;
	Mon,  3 Mar 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAoz5s06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26081F4C8A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012400; cv=none; b=MOQppCBtdQ5jiPFeytC8eYje1W6aM7COF4HtO+RQzASF4+ufdmvE7N53bMtvG5DYlyfN4EyCLTXWeAofZwG1n4NYJswpgoUB3fqALToyiT6FPxT1VAarcanoX3jrEFjVj1togev3f8O3WnHwLTorx/FqcMBwap1MDSnowQNq1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012400; c=relaxed/simple;
	bh=TLJcdtQW1Rth17BYwR4KsHskPkHEeMJQb+Hqg3Z/4WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYCS152DjCZO5zT6BiuMTToswjksHe1W9Y/o6dfST0mlH6jwFDSw4kLEn62kKTWKmdnpaXIidf7qqdgKG3vaG+04wpjRxa2n2yfe7uZT8HQW9LWuXZll70bP0hHPMCyodm5Ytn2DGIGmj0ypCCsuHhabbbizINmJ0Rhxf4ZHDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAoz5s06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16AAC4CED6;
	Mon,  3 Mar 2025 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741012400;
	bh=TLJcdtQW1Rth17BYwR4KsHskPkHEeMJQb+Hqg3Z/4WU=;
	h=From:To:Cc:Subject:Date:From;
	b=jAoz5s06lNLYzKqFNXp0yF0SGi3lsK5bOjsDsY6Rjs4ghZFmgnzMaHavcEwmqpn6t
	 yL7hBTElXoNj3hIjYFlxC1IO1rNQhXq/wTFKcl4tNpCf+hxDsVe+fQdqs5ZQW6+98z
	 KtjNQVn25R8VNt4OnSEMH8DUwjRPAc2EntNrSxuZaDSDnacnOxndYpYGshDG0F0BU4
	 S/wB004C7Id+EgSa4qH6EcCpve7osNLetV9sjc0At5PSmoB4AlNzSjqhZCZ0K/r1Vh
	 54ozwV89rX9SYwOAMw3KJlKHvCZuESsm1otb+PNG+7aIghV34UGQNkBiWnkQ5L2gSQ
	 r17JMsAfW3hEw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: drm_sched_job_cleanup(): correct false doc
Date: Mon,  3 Mar 2025 15:32:52 +0100
Message-ID: <20250303143251.43793-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_cleanup()'s documentation claims that calling
drm_sched_job_arm() is a "point of no return", implying that afterwards
a job cannot be cancelled anymore.

This is not correct, as proven by the function's code itself, which
takes a previous call to drm_sched_job_arm() into account. In truth, the
decisive factors are whether fences have been shared (e.g., with other
processes) and if the job has been submitted to an entity already.

Correct the wrong docstring.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c634993f1346..db9e08e6e455 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1013,11 +1013,13 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  * Cleans up the resources allocated with drm_sched_job_init().
  *
  * Drivers should call this from their error unwind code if @job is aborted
- * before drm_sched_job_arm() is called.
+ * before it was submitted to an entity with drm_sched_entity_push_job().
  *
- * After that point of no return @job is committed to be executed by the
- * scheduler, and this function should be called from the
- * &drm_sched_backend_ops.free_job callback.
+ * Since calling drm_sched_job_arm() causes the job's fences to be initialized,
+ * it is up to the driver to ensure that fences that were exposed to external
+ * parties get signaled. drm_sched_job_cleanup() does not ensure this.
+ *
+ * This function must also be called in &struct drm_sched_backend_ops.free_job
  */
 void drm_sched_job_cleanup(struct drm_sched_job *job)
 {
-- 
2.48.1


