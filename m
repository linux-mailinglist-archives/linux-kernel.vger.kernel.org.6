Return-Path: <linux-kernel+bounces-408764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E249C8345
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38CCB22D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F31EABB8;
	Thu, 14 Nov 2024 06:40:04 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 572BD1CCEE0;
	Thu, 14 Nov 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566403; cv=none; b=jpqe7xclzOD+GvJ+y/EeHVWg+gvC5sjud7Lr39AY91D3xD4Kx8cDq8Uh+DhhBKgXlIcu10tbsj/aGMmOfuKG1X9/NDHSLCIaEQzdfPNTkfZATFULBEQacj58eHprCg6w86G9GdjvNDzbDqAkQjxA4MoHEcmDQZftx6Wozt0GaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566403; c=relaxed/simple;
	bh=hpBO1M0VcIImyLo4FrA1nKJzLz/Xz+zv3f5mi+3OoIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f3KzIm+fz17wExEhHWojPIQiX15muVr93Ubz06MOtS7rwMMDUBvtQWfLIsIiHIAYAeiJsKCVrkNMonRFPwDvpKiVOJLB0EovSw9HlTgTJNufY4KW7/0WtwAzhjkdFqQ9LHLn0xgyzKo1FCtYzqzg25rYCuxMJQ54oTOkHWckUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id E0C01610C36C1;
	Thu, 14 Nov 2024 14:39:47 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	matthew.brost@intel.com,
	francois.dugast@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe/hw_engine_group: Fix bad free in xe_hw_engine_setup_groups()
Date: Thu, 14 Nov 2024 14:39:43 +0800
Message-Id: <20241114063942.3448607-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning：
drivers/gpu/drm/xe/xe_hw_engine_group.c: line 134, column 2
Argument to kfree() is a constant address (18446744073709551604), which
is not memory allocated by malloc().

There are some problems in hw_engine_group_alloc() and
xe_hw_engine_setup_groups(). First, kfree() can only handle NULL
pointers instead of negitave error codes. When hw_engine_group_alloc()
failed, there is a bad kfree call for negitave error codes in
xe_hw_engine_setup_groups(). Second, when drmm_add_action_or_reset()
failed, destroy_workqueue() should be called to free 'group->resume_wq'.

Free 'group' and destroy 'group->resume_wq' when hw_engine_group_alloc()
failed to fix these problems.

Fixes: d16ef1a18e39 ("drm/xe/exec: Switch hw engine group execution mode upon job submission")
Fixes: f784750c670f ("drm/xe/hw_engine_group: Introduce xe_hw_engine_group")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 31 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index 82750520a90a..ee2cb32817fa 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -51,7 +51,7 @@ static struct xe_hw_engine_group *
 hw_engine_group_alloc(struct xe_device *xe)
 {
 	struct xe_hw_engine_group *group;
-	int err;
+	int err = -ENOMEM;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
@@ -59,7 +59,7 @@ hw_engine_group_alloc(struct xe_device *xe)
 
 	group->resume_wq = alloc_workqueue("xe-resume-lr-jobs-wq", 0, 0);
 	if (!group->resume_wq)
-		return ERR_PTR(-ENOMEM);
+		goto free_group;
 
 	init_rwsem(&group->mode_sem);
 	INIT_WORK(&group->resume_work, hw_engine_group_resume_lr_jobs_func);
@@ -67,9 +67,15 @@ hw_engine_group_alloc(struct xe_device *xe)
 
 	err = drmm_add_action_or_reset(&xe->drm, hw_engine_group_free, group);
 	if (err)
-		return ERR_PTR(err);
+		goto destroy_wq;
 
 	return group;
+
+destroy_wq:
+	destroy_workqueue(group->resume_wq);
+free_group:
+	kfree(group);
+	return ERR_PTR(err);
 }
 
 /**
@@ -87,21 +93,19 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 	int err;
 
 	group_rcs_ccs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_rcs_ccs)) {
-		err = PTR_ERR(group_rcs_ccs);
-		goto err_group_rcs_ccs;
-	}
+	if (IS_ERR(group_rcs_ccs))
+		return PTR_ERR(group_rcs_ccs);
 
 	group_bcs = hw_engine_group_alloc(xe);
 	if (IS_ERR(group_bcs)) {
 		err = PTR_ERR(group_bcs);
-		goto err_group_bcs;
+		goto free_group_rcs_ccs;
 	}
 
 	group_vcs_vecs = hw_engine_group_alloc(xe);
 	if (IS_ERR(group_vcs_vecs)) {
 		err = PTR_ERR(group_vcs_vecs);
-		goto err_group_vcs_vecs;
+		goto free_group_bcs;
 	}
 
 	for_each_hw_engine(hwe, gt, id) {
@@ -126,13 +130,12 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 
 	return 0;
 
-err_group_vcs_vecs:
-	kfree(group_vcs_vecs);
-err_group_bcs:
+free_group_bcs:
+	destroy_workqueue(group_bcs->resume_wq);
 	kfree(group_bcs);
-err_group_rcs_ccs:
+free_group_rcs_ccs:
+	destroy_workqueue(group_rcs_ccs->resume_wq);
 	kfree(group_rcs_ccs);
-
 	return err;
 }
 
-- 
2.30.2


