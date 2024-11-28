Return-Path: <linux-kernel+bounces-424252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F539DB21B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7314B21B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D613B2A4;
	Thu, 28 Nov 2024 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RTTRAiOd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611B61FF2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767689; cv=none; b=hkmPTMVaiLzfwpri4PMmYXgJcUb/g6q0szdPWFzM5MWv34nIXIx+/ESr6IuSPumTxw5zc2oaqD5buye8bT6XJsVkjyX0BWRA69ucOetlwzDkX/uya58EQPmUH3HXpY41Bj93rG4BSKRmmVPG5Qd2qvfjC4uGdwUkYGXNKJIveF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767689; c=relaxed/simple;
	bh=w6NNYJJEI4GFa1+p0INndAv3F3rk7vgSJBCr7EF30eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCnlXxyVvoqE45SekBD2CxJhb7MgUScWlAyFV7IVHB4pPVSdlp53N/9JAnNb0OtPlmGaDU3UXF/dS3G7SHYAREzpch1hGPcd4Bl6t1gVQ7Aj/xsD1dFjWrg/0hf3rTSH3TXPiZJDUl++VTuvrl2cspzNs66mb89AZPhevJVeV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RTTRAiOd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732767685;
	bh=w6NNYJJEI4GFa1+p0INndAv3F3rk7vgSJBCr7EF30eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTTRAiOdXeuRk2wCg6VRpUDmH8qICJDyx33tOkrQpyxkIYKWjKXocptMY+C//1yN5
	 otDQQ6Mp7VVeMa3N1sAdqDhsVG9+2cKBGd2Yc8kHtDTZ42pz/A10ZwOoX3bUMXK6dt
	 vIV/dMJn3BGU513DwGjLu6Fd7b/Z8HovFG4KtpXbsEcP8NnE7dPTf2VQjfUXF8v+Fu
	 h1WKfFskMG7ghEVCsJ/PTfK50F5EZmiFgc5d5oyqRc3a3tE+QAXvp5EhfwrINgGVfG
	 fUztcDMeCaMahMdlYF+FQZD9zTdZe4iSgM2S5DrUuHGYDXgHTFu/QWQh/ZJPP6y4zA
	 foPYNTDp3VZHw==
Received: from localhost.localdomain (unknown [171.76.86.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91CFA17E0FCE;
	Thu, 28 Nov 2024 05:21:23 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	jani.nikula@linux.intel.com,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] drm/ci: update gitlab rules
Date: Thu, 28 Nov 2024 09:50:21 +0530
Message-ID: <20241128042025.611659-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128042025.611659-1-vignesh.raman@collabora.com>
References: <20241128042025.611659-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update gitlab rules to include scheduled pipelines.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/build.yml     |   1 -
 drivers/gpu/drm/ci/gitlab-ci.yml | 116 +++++++++++++------------------
 drivers/gpu/drm/ci/test.yml      |  26 +++----
 3 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
index 771ecfc5008d..4ea54aee3dcd 100644
--- a/drivers/gpu/drm/ci/build.yml
+++ b/drivers/gpu/drm/ci/build.yml
@@ -1,6 +1,5 @@
 .build:
   extends:
-    - .build-rules
     - .container+build-rules
   stage: build-only
   artifacts:
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 86d8c5d8ce3b..49d6930ba87f 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -38,6 +38,7 @@ variables:
   # Python scripts for structured logger
   PYTHONPATH: "$PYTHONPATH:$CI_PROJECT_DIR/install"
 
+
 default:
   id_tokens:
     S3_JWT:
@@ -67,6 +68,7 @@ default:
       export S3_JWT="$(<${S3_JWT_FILE})" &&
       rm "${S3_JWT_FILE}"
 
+
 include:
   - project: 'freedesktop/ci-templates'
     ref: 16bc29078de5e0a067ff84a1a199a3760d3b3811
@@ -126,33 +128,27 @@ stages:
   - rockchip
   - software-driver
 
+
 # YAML anchors for rule conditions
 # --------------------------------
 .rules-anchors:
   rules:
-    # Pipeline for forked project branch
-    - if: &is-forked-branch '$CI_COMMIT_BRANCH && $CI_PROJECT_NAMESPACE != "mesa"'
-      when: manual
-    # Forked project branch / pre-merge pipeline not for Marge bot
-    - if: &is-forked-branch-or-pre-merge-not-for-marge '$CI_PROJECT_NAMESPACE != "mesa" || ($GITLAB_USER_LOGIN != "marge-bot" && $CI_PIPELINE_SOURCE == "merge_request_event")'
-      when: manual
-    # Pipeline runs for the main branch of the upstream Mesa project
-    - if: &is-mesa-main '$CI_PROJECT_NAMESPACE == "mesa" && $CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH && $CI_COMMIT_BRANCH'
-      when: always
-    # Post-merge pipeline
-    - if: &is-post-merge '$CI_PROJECT_NAMESPACE == "mesa" && $CI_COMMIT_BRANCH'
-      when: on_success
-    # Post-merge pipeline, not for Marge Bot
-    - if: &is-post-merge-not-for-marge '$CI_PROJECT_NAMESPACE == "mesa" && $GITLAB_USER_LOGIN != "marge-bot" && $CI_COMMIT_BRANCH'
-      when: on_success
+    # do not duplicate pipelines on merge pipelines
+    - if: $CI_COMMIT_BRANCH && $CI_OPEN_MERGE_REQUESTS && $CI_PIPELINE_SOURCE == "push"
+      when: never
+    # merge pipeline
+    - if: &is-merge-attempt $GITLAB_USER_LOGIN == "marge-bot" && $CI_PIPELINE_SOURCE == "merge_request_event"
+    # post-merge pipeline
+    - if: &is-post-merge $GITLAB_USER_LOGIN == "marge-bot" && $CI_PIPELINE_SOURCE == "push"
     # Pre-merge pipeline
-    - if: &is-pre-merge '$CI_PIPELINE_SOURCE == "merge_request_event"'
-      when: on_success
-    # Pre-merge pipeline for Marge Bot
-    - if: &is-pre-merge-for-marge '$GITLAB_USER_LOGIN == "marge-bot" && $CI_PIPELINE_SOURCE == "merge_request_event"'
-      when: on_success
+    - if: &is-pre-merge $CI_PIPELINE_SOURCE == "merge_request_event"
     # Push to a branch on a fork
-    - &is-fork-push '$CI_PROJECT_NAMESPACE != "mesa" && $CI_PIPELINE_SOURCE == "push"'
+    - if: &is-fork-push $CI_PROJECT_NAMESPACE != "mesa" && $CI_PIPELINE_SOURCE == "push"
+    # nightly pipeline
+    - if: &is-scheduled-pipeline $CI_PIPELINE_SOURCE == "schedule"
+    # pipeline for direct pushes that bypassed the CI
+    - if: &is-direct-push $CI_PROJECT_NAMESPACE == "mesa" && $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
+
 
 # Rules applied to every job in the pipeline
 .common-rules:
@@ -160,39 +156,48 @@ stages:
     - if: *is-fork-push
       when: manual
 
+
 .never-post-merge-rules:
   rules:
     - if: *is-post-merge
       when: never
 
-# Rule to filter for only scheduled pipelines.
-.scheduled_pipeline-rules:
-  rules:
-    - if: &is-scheduled-pipeline '$CI_PIPELINE_SOURCE == "schedule"'
-      when: on_success
-
-# Generic rule to not run the job during scheduled pipelines. Jobs that aren't
-# something like a nightly run should include this rule.
-.no_scheduled_pipelines-rules:
-  rules:
-    - if: *is-scheduled-pipeline
-      when: never
 
-# When to automatically run the CI for build jobs
-.build-rules:
-  rules:
-    - !reference [.no_scheduled_pipelines-rules, rules]
-    - !reference [.never-post-merge-rules, rules]
-    # Run automatically once all dependency jobs have passed
-    - when: on_success
-
-# When to automatically run the CI for container jobs
 .container+build-rules:
   rules:
-    - !reference [.no_scheduled_pipelines-rules, rules]
+    - !reference [.common-rules, rules]
+    # Run when re-enabling a disabled farm, but not when disabling it
+    - !reference [.disable-farm-mr-rules, rules]
+    # Never run immediately after merging, as we just ran everything
     - !reference [.never-post-merge-rules, rules]
+    # Build everything in merge pipelines, if any files affecting the pipeline
+    # were changed
+    - if: *is-merge-attempt
+      changes: &all_paths
+      - drivers/gpu/drm/ci/**/*
+      when: on_success
+    # Same as above, but for pre-merge pipelines
+    - if: *is-pre-merge
+      changes:
+        *all_paths
+      when: manual
+    # Skip everything for pre-merge and merge pipelines which don't change
+    # anything in the build
+    - if: *is-merge-attempt
+      when: never
+    - if: *is-pre-merge
+      when: never
+    # Build everything after someone bypassed the CI
+    - if: *is-direct-push
+      when: on_success
+    # Build everything in scheduled pipelines
+    - if: *is-scheduled-pipeline
+      when: on_success
+    # Allow building everything in fork pipelines, but build nothing unless
+    # manually triggered
     - when: manual
 
+
 .ci-deqp-artifacts:
   artifacts:
     name: "mesa_${CI_JOB_NAME}"
@@ -206,31 +211,7 @@ stages:
       - _build/meson-logs/strace
 
 
-.container-rules:
-  rules:
-    - !reference [.no_scheduled_pipelines-rules, rules]
-    - !reference [.never-post-merge-rules, rules]
-    # Run pipeline by default in the main project if any CI pipeline
-    # configuration files were changed, to ensure docker images are up to date
-    - if: *is-post-merge
-      changes:
-      - drivers/gpu/drm/ci/**/*
-      when: on_success
-    # Run pipeline by default if it was triggered by Marge Bot, is for a
-    # merge request, and any files affecting the pipeline were changed
-    - if: *is-pre-merge-for-marge
-      when: on_success
-    # Run pipeline by default in the main project if it was not triggered by
-    # Marge Bot, and any files affecting the pipeline were changed
-    - if: *is-post-merge-not-for-marge
-      when: on_success
-    # Allow triggering jobs manually in other cases
-    - when: manual
-
-
-
 # Git archive
-
 make git archive:
   extends:
     - .fdo.ci-fairy
@@ -313,6 +294,7 @@ mr-label-maker-test:
     - pip install git+https://gitlab.freedesktop.org/freedesktop/mr-label-maker
     - mr-label-maker --dry-run --mr $CI_MERGE_REQUEST_IID
 
+
 # Jobs that need to pass before spending hardware resources on further testing
 .required-for-hardware-jobs:
   needs:
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 42a8e7f93714..6bfcbd4c0350 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -1,16 +1,11 @@
-.test-rules:
-  rules:
-    - !reference [.no_scheduled_pipelines-rules, rules]
-    - !reference [.collabora-farm-rules, rules]
-    - !reference [.google-freedreno-farm-rules, rules]
-    - when: on_success
-
 .lava-test:
   extends:
-    - .test-rules
-    - .build-rules
     - .container+build-rules
   timeout: "1h30m"
+  rules:
+    - !reference [.scheduled_pipeline-rules, rules]
+    - !reference [.collabora-farm-rules, rules]
+    - when: on_success
   script:
     # Note: Build dir (and thus install) may be dirty due to GIT_STRATEGY
     - rm -rf install
@@ -74,8 +69,11 @@
   extends:
     - .baremetal-test-arm64
     - .use-debian/baremetal_arm64_test
-    - .test-rules
   timeout: "1h30m"
+  rules:
+    - !reference [.scheduled_pipeline-rules, rules]
+    - !reference [.google-freedreno-farm-rules, rules]
+    - when: on_success
   variables:
     FDO_CI_CONCURRENT: 10
     HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
@@ -444,13 +442,15 @@ panfrost:g12b:
 virtio_gpu:none:
   stage: software-driver
   timeout: "1h30m"
+  rules:
+    - !reference [.scheduled_pipeline-rules, rules]
+    - when: on_success
   variables:
     CROSVM_GALLIUM_DRIVER: llvmpipe
     DRIVER_NAME: virtio_gpu
     GPU_VERSION: none
   extends:
     - .test-gl
-    - .test-rules
   tags:
     - kvm
   script:
@@ -467,12 +467,14 @@ virtio_gpu:none:
 vkms:none:
   stage: software-driver
   timeout: "1h30m"
+  rules:
+    - !reference [.scheduled_pipeline-rules, rules]
+    - when: on_success
   variables:
     DRIVER_NAME: vkms
     GPU_VERSION: none
   extends:
     - .test-gl
-    - .test-rules
   tags:
     - kvm
   script:
-- 
2.43.0


