Return-Path: <linux-kernel+bounces-215198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79A908FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702431C22F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A416E888;
	Fri, 14 Jun 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mfApwInj"
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E36FCB;
	Fri, 14 Jun 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381328; cv=none; b=J9Jb3b1+zzNgCnr3dGQfmhGsdYA9tiTZaBwbUgCZIj8BjrTc4lmXp7Sb3VGWjy4/gpFTvcUzMr4k4qkXqvX8SWvEdp9vMSw+RNzwcNBaqz0Z7lETF0dB/NZQtcjPak3ePMHHemtayGMO7vbjw9aKJb6EGLcyLG9Eht+B8epT93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381328; c=relaxed/simple;
	bh=R8H8MXJyPb1YM2V92M76ao7oPk/gsYPlvbPUU2JSefY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8a5pf1y9rmuisSYnqYc2TSWyDXuTZuwqOBT89iD0Gj4sQwVkGYLroHrEHWvEsqJfFngi+EaV2AwmcOkVyEEHbBme2ATyWeNE1vtUsXsDMLrkeFy+AerbiQD33ji9hXpYGzOYspTvj1iHIlLJQjsAiVRuJGAU19+4QucueYzQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mfApwInj; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id I9TgsKvp3tf3yI9TgsiObM; Fri, 14 Jun 2024 18:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718381317;
	bh=iew86RGc22LJ+Q/8TMphmmkcMzmxkXz0kaXfqIW+KKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mfApwInjnFPbwpLRxOXdkb6DU8ITDBwhgC7xAdU65yUWLf8jt/8jrF4FFTIDcY2th
	 iEaahGn2BBaAUi/aQs9YoQcdVURdTzssWNlwOQsZ+ipTuXHMZYiNHEb5C5tkqoaWaI
	 Kp0acai4IiMym0K99Bb3/Zv/wzE0Bfy2lMIZQDHfms6thq48feafrfAdrW6X97VQRS
	 U/ax0jsUoBKM34bKWSzTa59xi8UwuCHepVD8jIWgHGUwv1mevIKc2Q44ByIpls246K
	 ZV9sqMX5tPORVxcb5p50B94POU8T37Dr+8N5tzNd3sf3ouUswuh6JahE3M891WLWus
	 dcnOmDTWS+flA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Jun 2024 18:08:37 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: Constify struct nouveau_job_ops
Date: Fri, 14 Jun 2024 18:08:30 +0200
Message-ID: <860e9753d7867aa46b003bb3d0497f1b04065b24.1718381285.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct nouveau_job_ops" is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, "struct nouveau_job" and "struct nouveau_job_args" also
need to be adjusted to this new const qualifier.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   5570	    152	      0	   5722	   165a	drivers/gpu/drm/nouveau/nouveau_exec.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5630	    112	      0	   5742	   166e	drivers/gpu/drm/nouveau/nouveau_exec.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/nouveau/nouveau_exec.c  | 2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h | 4 ++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index e65c0ef23bc7..a0b5f1b16e8b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -188,7 +188,7 @@ nouveau_exec_job_timeout(struct nouveau_job *job)
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-static struct nouveau_job_ops nouveau_exec_job_ops = {
+static const struct nouveau_job_ops nouveau_exec_job_ops = {
 	.submit = nouveau_exec_job_submit,
 	.armed_submit = nouveau_exec_job_armed_submit,
 	.run = nouveau_exec_job_run,
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index e1f01a23e6f6..20cd1da8db73 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -42,7 +42,7 @@ struct nouveau_job_args {
 		u32 count;
 	} out_sync;
 
-	struct nouveau_job_ops *ops;
+	const struct nouveau_job_ops *ops;
 };
 
 struct nouveau_job {
@@ -73,7 +73,7 @@ struct nouveau_job {
 		u32 count;
 	} out_sync;
 
-	struct nouveau_job_ops {
+	const struct nouveau_job_ops {
 		/* If .submit() returns without any error, it is guaranteed that
 		 * armed_submit() is called.
 		 */
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index ee02cd833c5e..9402fa320a7e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1534,7 +1534,7 @@ nouveau_uvmm_bind_job_cleanup(struct nouveau_job *job)
 	nouveau_uvmm_bind_job_put(bind_job);
 }
 
-static struct nouveau_job_ops nouveau_bind_job_ops = {
+static const struct nouveau_job_ops nouveau_bind_job_ops = {
 	.submit = nouveau_uvmm_bind_job_submit,
 	.armed_submit = nouveau_uvmm_bind_job_armed_submit,
 	.run = nouveau_uvmm_bind_job_run,
-- 
2.45.2


