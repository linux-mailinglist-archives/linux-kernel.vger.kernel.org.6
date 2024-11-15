Return-Path: <linux-kernel+bounces-410165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101549CD59F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E87CB22B37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B380154444;
	Fri, 15 Nov 2024 02:50:14 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6571655897;
	Fri, 15 Nov 2024 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639013; cv=none; b=SqWrp2MCLyhifrBfGmQ3w/ycpW3W2o0XMwOTbBhn/Jd8pe/T5ASd6GWuuIJ+QCHYAy9tAb3XZ5HjktONDpt5mYsEYCORXFowxXV3+LVQ4+oexihFEyI1KVgTSYF4iWm5gnEiCo4A+f3i55r3iY3w4AKFojlHpmvq8EkHQUwAK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639013; c=relaxed/simple;
	bh=J+kK0EscKE/RMs4i2k0kiL7kph9cJtUwkK/leOUA5ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sGvT8bouhDykGpVY6SZujCywhRm8n6CXyczwakDrFokhmaZizj/tXOWXTJrWbm/iyqfBHGHQvYrJc475lFugWgI6R0Tt3090+5kzA5s4EycrocoaeZuMy0XJOVl5inaljne2rjag5OELeQWrB4f66+YLuGTN67nWJAqYx8vk0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id BA7A061A027B0;
	Fri, 15 Nov 2024 10:50:02 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: balasubramani.vivekanandan@intel.com,
	lucas.demarchi@intel.com,
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
Subject: [PATCH v2] drm/xe/hw_engine_group: Fix bad free in xe_hw_engine_setup_groups()
Date: Fri, 15 Nov 2024 10:49:42 +0800
Message-Id: <20241115024941.3737042-1-suhui@nfschina.com>
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

kfree() can only handle NULL pointers instead of negitave error codes.
When hw_engine_group_alloc() failed, there is a bad kfree call for
negitave error codes in xe_hw_engine_setup_groups().

Free 'group' when alloc_workqueue() failed in hw_engine_group_alloc(), and
remove wrong kfree() in xe_hw_engine_setup_groups() to fix this problem.
It's safe to remove these kfree() because drmm_add_action_or_reset()
can free these by calling hw_engine_group_free().

Fixes: d16ef1a18e39 ("drm/xe/exec: Switch hw engine group execution mode upon job submission")
Fixes: f784750c670f ("drm/xe/hw_engine_group: Introduce xe_hw_engine_group")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - remove wrong destroy_workqueue() and kfree() in v1 patch
v1:
 - https://lore.kernel.org/all/20241114063942.3448607-1-suhui@nfschina.com/

 drivers/gpu/drm/xe/xe_hw_engine_group.c | 32 +++++++------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index 82750520a90a..3bfa002734ad 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -58,8 +58,10 @@ hw_engine_group_alloc(struct xe_device *xe)
 		return ERR_PTR(-ENOMEM);
 
 	group->resume_wq = alloc_workqueue("xe-resume-lr-jobs-wq", 0, 0);
-	if (!group->resume_wq)
+	if (!group->resume_wq) {
+		kfree(group);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	init_rwsem(&group->mode_sem);
 	INIT_WORK(&group->resume_work, hw_engine_group_resume_lr_jobs_func);
@@ -84,25 +86,18 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 	enum xe_hw_engine_id id;
 	struct xe_hw_engine_group *group_rcs_ccs, *group_bcs, *group_vcs_vecs;
 	struct xe_device *xe = gt_to_xe(gt);
-	int err;
 
 	group_rcs_ccs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_rcs_ccs)) {
-		err = PTR_ERR(group_rcs_ccs);
-		goto err_group_rcs_ccs;
-	}
+	if (IS_ERR(group_rcs_ccs))
+		return PTR_ERR(group_rcs_ccs);
 
 	group_bcs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_bcs)) {
-		err = PTR_ERR(group_bcs);
-		goto err_group_bcs;
-	}
+	if (IS_ERR(group_bcs))
+		return PTR_ERR(group_bcs);
 
 	group_vcs_vecs = hw_engine_group_alloc(xe);
-	if (IS_ERR(group_vcs_vecs)) {
-		err = PTR_ERR(group_vcs_vecs);
-		goto err_group_vcs_vecs;
-	}
+	if (IS_ERR(group_vcs_vecs))
+		return PTR_ERR(group_vcs_vecs);
 
 	for_each_hw_engine(hwe, gt, id) {
 		switch (hwe->class) {
@@ -125,15 +120,6 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 	}
 
 	return 0;
-
-err_group_vcs_vecs:
-	kfree(group_vcs_vecs);
-err_group_bcs:
-	kfree(group_bcs);
-err_group_rcs_ccs:
-	kfree(group_rcs_ccs);
-
-	return err;
 }
 
 /**
-- 
2.30.2


