Return-Path: <linux-kernel+bounces-535543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD1A4744E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65423A2645
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525941A38E3;
	Thu, 27 Feb 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ljzXj/Ud"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F611C5F2E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630081; cv=none; b=tDgdtDOZum3en4OGPIJ3uWNJJ5z+0JqIDu/XTqLnKrQZoNlgoRlCq7sFFdJkjEmfAA4IfEXQ9SGKQ53VgrnPW5uq32SpVHp3nIfric/0QnfFFrlfLJzbCSiYXtfHzd9Tb7Tes9mP3CIjzCg1GKSB2/JIAqnOgghZ2GWXw8AMZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630081; c=relaxed/simple;
	bh=vONQTVATfku8ju91m9tx3SK1gEvdjGryS6+VyLtnkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9QEm4bbOZHC4Hg8KqQ9zJWZDYwMTYzRHCo5RaydtUIymo5nUjc2ahWTPB2e2b3ItPBjXQxlvAj47rsPscG7VDJS+vdB3tggYEpIWku5ow9VgXYeL4yX/iUAUSlE13hqqqMhDMqnnZWgnf7MXGOq9nXiBJX4ceT3hdH6w84AWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ljzXj/Ud; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740630077;
	bh=vONQTVATfku8ju91m9tx3SK1gEvdjGryS6+VyLtnkQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ljzXj/UdYyFhtlnHrB38EzCKO+xZZy2C7oBAePqx8BFjAED+5bt0nqLWwunR6Ux1X
	 Yl5H54bGw9S+Gye4j5vWNNNiApgvC6DX6S6KqzcfVqM0Hvk5916owiCfJ9XaZO7fBH
	 zLSyetMpwEMSWTT76kXSTMstytifzyme9VYdp3gc+4TsCByTuB/OYHLitGZRGJn/VX
	 rx5PO23dLnmUAZDfIqEw2jza+hu6THGk/9GbQWb/M8s1UI8ZyGQdKWKF/QZ5t3EHcz
	 fTEh7kaPymzUiFFdM7HRAnTEt4Yk9j6+5UePk/iliZ1uxgWmMue42PZlfw11zMSTAo
	 IuTMW675SVskg==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E896717E05EA;
	Thu, 27 Feb 2025 05:21:13 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	dmitry.baryshkov@linaro.org,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/ci: fix merge request rules
Date: Thu, 27 Feb 2025 09:50:50 +0530
Message-ID: <20250227042058.409003-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge request pipelines were only created when changes
were made to drivers/gpu/drm/ci/, causing MRs that
didn't touch this path to break. Fix MR pipeline rules
to trigger jobs for all changes.

Run jobs automatically for marge-bot and scheduled
pipelines, but in all other cases run manually. Also
remove CI_PROJECT_NAMESPACE checks specific to mesa.

Fixes: df54f04f2020 ("drm/ci: update gitlab rules")
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Run jobs automatically for marge-bot and scheduled
    pipelines, but in all other cases run manually. Also
    remove CI_PROJECT_NAMESPACE checks specific to mesa.

---
 drivers/gpu/drm/ci/gitlab-ci.yml | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f04aabe8327c..f4e324e156db 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -143,11 +143,11 @@ stages:
     # Pre-merge pipeline
     - if: &is-pre-merge $CI_PIPELINE_SOURCE == "merge_request_event"
     # Push to a branch on a fork
-    - if: &is-fork-push $CI_PROJECT_NAMESPACE != "mesa" && $CI_PIPELINE_SOURCE == "push"
+    - if: &is-fork-push $CI_PIPELINE_SOURCE == "push"
     # nightly pipeline
     - if: &is-scheduled-pipeline $CI_PIPELINE_SOURCE == "schedule"
     # pipeline for direct pushes that bypassed the CI
-    - if: &is-direct-push $CI_PROJECT_NAMESPACE == "mesa" && $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
+    - if: &is-direct-push $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
 
 
 # Rules applied to every job in the pipeline
@@ -170,26 +170,15 @@ stages:
     - !reference [.disable-farm-mr-rules, rules]
     # Never run immediately after merging, as we just ran everything
     - !reference [.never-post-merge-rules, rules]
-    # Build everything in merge pipelines, if any files affecting the pipeline
-    # were changed
+    # Build everything in merge pipelines
     - if: *is-merge-attempt
-      changes: &all_paths
-      - drivers/gpu/drm/ci/**/*
       when: on_success
     # Same as above, but for pre-merge pipelines
     - if: *is-pre-merge
-      changes:
-        *all_paths
-      when: manual
-    # Skip everything for pre-merge and merge pipelines which don't change
-    # anything in the build
-    - if: *is-merge-attempt
-      when: never
-    - if: *is-pre-merge
-      when: never
+    - when: manual
     # Build everything after someone bypassed the CI
     - if: *is-direct-push
-      when: on_success
+    - when: manual
     # Build everything in scheduled pipelines
     - if: *is-scheduled-pipeline
       when: on_success
-- 
2.47.2


