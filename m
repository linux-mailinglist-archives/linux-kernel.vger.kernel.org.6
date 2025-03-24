Return-Path: <linux-kernel+bounces-574272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F71A6E2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3902A171C36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15E2676CD;
	Mon, 24 Mar 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1/vRZKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84107266EFC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842782; cv=none; b=oQesrUon9E7SfyqYtYeKcaiXMRj/SqH6o3m7zuR9DXDAxMAjFLQrTfoYGniScw3YxrVdKWsvX+tNQ2sBZfNhmNgK4UBA9IcmAGOewCREBgozPr8x3Hmv98IpjLpsBdCE94uLyDPfgFT+JUEK3vvZaJxuhYeDk8AWxbiAIHKTjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842782; c=relaxed/simple;
	bh=NCVkBBLqtGEdnEQtLmXeFUs5qUUJkAaPVyk19HzOsBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSZj6yEak93yFHFCSwrU0kaIcKNGox8ooFM1Eh0KIFkn+vfgw4dzMew3VxMg592nP7Lz9DlGRmUyvRqm26NiuwEazxlh5tW6iPu0DTQc/FwDCLlNHZib+gHQMaeV4TOuZGlWDBaXHfbVKQ2Roh+dOKJUWpAYUz0AElbLmNZ7iQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1/vRZKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB2C4CEDD;
	Mon, 24 Mar 2025 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742842782;
	bh=NCVkBBLqtGEdnEQtLmXeFUs5qUUJkAaPVyk19HzOsBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1/vRZKZ6irTIbINb2G8xvj5JvwxePGTa1IwANcWLuMQZSbp+VZk4sXBX2rpKtiHf
	 jgueHIlr7xWMCCxp/L8Q4b2bR+ozy/Cx9atJwCnG2RknbUJ0UpRA/h5W64NWshr3gH
	 B1stRIOEmM4x307ks17UFSNgJhkBwJluNve8dtevb2U28RMcT3/ljMsMYQeOI7iawV
	 FGEpKtRUOAzBCQFT5LacXnrNmVn66zdnZtuo2rfau0sqoUgy4tfJXT0wywRYsS3sNq
	 IMBMOYlNSPu0yYuGXR8m/a9uZ2CwTcwjeODNVpT2bFYm/HQ/DDSoQO5o9mTGQdXRpo
	 oo4UcmTl7DLXw==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] drm/nouveau: Add new callback for scheduler teardown
Date: Mon, 24 Mar 2025 19:57:28 +0100
Message-ID: <20250324185728.45857-6-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324185728.45857-2-phasta@kernel.org>
References: <20250324185728.45857-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a new callback for always tearing the scheduler down in a
leak-free, deadlock-free manner.

Port Nouveau as its first user by providing the scheduler with a
callback that ensures the fence context gets killed in drm_sched_fini().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c | 19 +++++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_sched.h |  3 +++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 2a0617e5fe2a..53b8a85a8adb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -415,8 +415,8 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 	 * The client lock is already acquired by nouveau_abi16_get().
 	 */
 	if (nouveau_cli_uvmm(cli)) {
-		ret = nouveau_sched_create(&chan->sched, drm, drm->sched_wq,
-					   chan->chan->dma.ib_max);
+		ret = nouveau_sched_create(&chan->sched, drm, chan->chan,
+					   drm->sched_wq, chan->chan->dma.ib_max);
 		if (ret)
 			goto done;
 	}
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e154d08857c5..95d677f6eae9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -313,7 +313,7 @@ nouveau_cli_init(struct nouveau_drm *drm, const char *sname,
 	 * locks which indirectly or directly are held for allocations
 	 * elsewhere.
 	 */
-	ret = nouveau_sched_create(&cli->sched, drm, NULL, 1);
+	ret = nouveau_sched_create(&cli->sched, drm, NULL, NULL, 1);
 	if (ret)
 		goto done;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index d326e55d2d24..3659ac78bb3e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -11,6 +11,7 @@
 #include "nouveau_exec.h"
 #include "nouveau_abi16.h"
 #include "nouveau_sched.h"
+#include "nouveau_chan.h"
 
 #define NOUVEAU_SCHED_JOB_TIMEOUT_MS		10000
 
@@ -392,10 +393,22 @@ nouveau_sched_free_job(struct drm_sched_job *sched_job)
 	nouveau_job_fini(job);
 }
 
+static void
+nouveau_sched_fence_context_kill(struct drm_gpu_scheduler *sched)
+{
+	struct nouveau_sched *nsched;
+
+	nsched = container_of(sched, struct nouveau_sched, base);
+
+	if (nsched->chan)
+		nouveau_channel_kill(nsched->chan);
+}
+
 static const struct drm_sched_backend_ops nouveau_sched_ops = {
 	.run_job = nouveau_sched_run_job,
 	.timedout_job = nouveau_sched_timedout_job,
 	.free_job = nouveau_sched_free_job,
+	.kill_fence_context = nouveau_sched_fence_context_kill,
 };
 
 static int
@@ -461,7 +474,8 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 
 int
 nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
-		     struct workqueue_struct *wq, u32 credit_limit)
+		     struct nouveau_channel *chan, struct workqueue_struct *wq,
+		     u32 credit_limit)
 {
 	struct nouveau_sched *sched;
 	int ret;
@@ -470,6 +484,8 @@ nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
 	if (!sched)
 		return -ENOMEM;
 
+	sched->chan = chan;
+
 	ret = nouveau_sched_init(sched, drm, wq, credit_limit);
 	if (ret) {
 		kfree(sched);
@@ -481,7 +497,6 @@ nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
 	return 0;
 }
 
-
 static void
 nouveau_sched_fini(struct nouveau_sched *sched)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 20cd1da8db73..e6e2016a3569 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -9,6 +9,7 @@
 #include <drm/gpu_scheduler.h>
 
 #include "nouveau_drv.h"
+#include "nouveau_chan.h"
 
 #define to_nouveau_job(sched_job)		\
 		container_of((sched_job), struct nouveau_job, base)
@@ -101,6 +102,7 @@ struct nouveau_sched {
 	struct drm_sched_entity entity;
 	struct workqueue_struct *wq;
 	struct mutex mutex;
+	struct nouveau_channel *chan;
 
 	struct {
 		struct {
@@ -112,6 +114,7 @@ struct nouveau_sched {
 };
 
 int nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
+			 struct nouveau_channel *chan,
 			 struct workqueue_struct *wq, u32 credit_limit);
 void nouveau_sched_destroy(struct nouveau_sched **psched);
 
-- 
2.48.1


