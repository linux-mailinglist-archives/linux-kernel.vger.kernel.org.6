Return-Path: <linux-kernel+bounces-517013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9EA37AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0016E1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59118B492;
	Mon, 17 Feb 2025 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oM1pziku"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769BA137750
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770681; cv=none; b=J9ub43q0QwvJumAIatSB7arKyKGopPdhXjRY/ItUGysAGJ3JxdKkoHAeEuTHlfGzAZB/EayW/+ipYIqVcEB+wkdJ6HiKZS1ZEZSNdsOwIQ2xuGElr0cm513MOwHj90BP4mtnu7B0UYsaNzd0b9e957n34KJacYW4cgzP/jt0iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770681; c=relaxed/simple;
	bh=rCzCYxlLVkTl3XI+BB3+bFMYsq3g9fdk/lOCxvptPSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZLygTIa2xbWoVDFAMs9F1OorqzRS+TRgddYTYBwdFzdgloB3Tq5FpggKgMOzpq8LCLbDabN35sOgdgIsiBh+em63e8hE0vnkVLIaTfCa2/iml81bBVYcxZILHOiQKkVaXrw7s387tFY39sghj3e32tsxK9DoDl0d5gYItRYpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oM1pziku; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739770677;
	bh=rCzCYxlLVkTl3XI+BB3+bFMYsq3g9fdk/lOCxvptPSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oM1pzikumaW+7OWkYMi36tm4rhEDEIZid9o0TmpqVFa2n52o/Dq+ATukew7JwMSEc
	 bqKgWD6gSPxz4swGU81EP8dYZ4qhyOvhkaF1yHoomG22TNLpaeS+qv1kynGxbxGQeZ
	 Z7NQbQiZNU0OEep9TLX1mQYx7M/rv8iQZzVpgvkyz/dPz3C4ooMFOO3FSxb0TxY4dg
	 lHFjJAxReuG/R1g6PuGbMqWCazsOKiugRwDQ37/gH+pLdLd6aGxR/dOr+8fZlXqpkm
	 om8IRiA30j/M0SfU0zzFSOafWhgfFYKqjf+b9dDEy4fuKcE5UYWdGcRdT/eh5UYj8G
	 10y07cItwMczQ==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 188EC17E0B59;
	Mon, 17 Feb 2025 06:37:51 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	jani.nikula@linux.intel.com,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/ci: enable lockdep detection
Date: Mon, 17 Feb 2025 11:07:12 +0530
Message-ID: <20250217053719.442644-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217053719.442644-1-vignesh.raman@collabora.com>
References: <20250217053719.442644-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
This will output warnings when kernel locking errors are encountered
and will continue executing tests. To detect if lockdep has been
triggered, check the debug_locks value in /proc/lockdep_stats after
the tests have run. When debug_locks is 0, it indicates that lockdep
has detected issues and turned itself off. Check this value, and if
lockdep is detected, exit with an error and configure it as a warning
in GitLab CI.

GitLab CI ignores exit codes other than 1 by default. Pass the correct
exit code with variable FF_USE_NEW_BASH_EVAL_STRATEGY set to true or
exit on failure.

Also update the documentation.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Lockdep failures are reported as pipeline warnings,
    and the documentation is updated.

v3:
  - Add a common job for exit code handling and extend it in other jobs.

---
 Documentation/gpu/automated_testing.rst |  4 ++++
 drivers/gpu/drm/ci/igt_runner.sh        | 11 +++++++++++
 drivers/gpu/drm/ci/test.yml             | 17 ++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
index 6d7c6086034d..62aa3ede02a5 100644
--- a/Documentation/gpu/automated_testing.rst
+++ b/Documentation/gpu/automated_testing.rst
@@ -115,6 +115,10 @@ created (eg. https://gitlab.freedesktop.org/janedoe/linux/-/pipelines)
 5. The various jobs will be run and when the pipeline is finished, all jobs
 should be green unless a regression has been found.
 
+6. Warnings in the pipeline indicate that lockdep
+(see Documentation/locking/lockdep-design.rst) issues have been detected
+during the tests.
+
 
 How to update test expectations
 ===============================
diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 68b042e43b7f..2a0599f12c58 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -85,5 +85,16 @@ deqp-runner junit \
    --limit 50 \
    --template "See $ARTIFACTS_BASE_URL/results/{{testcase}}.xml"
 
+# Check if /proc/lockdep_stats exists
+if [ -f /proc/lockdep_stats ]; then
+    # If debug_locks is 0, it indicates lockdep is detected and it turns itself off.
+    debug_locks=$(grep 'debug_locks:' /proc/lockdep_stats | awk '{print $2}')
+    if [ "$debug_locks" -eq 0 ] && [ "$ret" -eq 0 ]; then
+        echo "Warning: LOCKDEP issue detected. Please check dmesg logs for more information."
+        cat /proc/lockdep_stats
+        ret=101
+    fi
+fi
+
 cd $oldpath
 exit $ret
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 0eab020a33b9..dbc4ff50d8ff 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -1,6 +1,14 @@
+.allow_failure_lockdep:
+  variables:
+    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
+  allow_failure:
+    exit_codes:
+      - 101
+
 .lava-test:
   extends:
     - .container+build-rules
+    - .allow_failure_lockdep
   timeout: "1h30m"
   rules:
     - !reference [.scheduled_pipeline-rules, rules]
@@ -69,6 +77,7 @@
   extends:
     - .baremetal-test-arm64
     - .use-debian/baremetal_arm64_test
+    - .allow_failure_lockdep
   timeout: "1h30m"
   rules:
     - !reference [.scheduled_pipeline-rules, rules]
@@ -91,6 +100,8 @@
 
 .software-driver:
   stage: software-driver
+  extends:
+    - .allow_failure_lockdep
   timeout: "1h30m"
   rules:
     - !reference [.scheduled_pipeline-rules, rules]
@@ -153,7 +164,7 @@ msm:apq8016:
     BM_KERNEL_EXTRA_ARGS: clk_ignore_unused
     RUNNER_TAG: google-freedreno-db410c
   script:
-    - ./install/bare-metal/fastboot.sh
+    - ./install/bare-metal/fastboot.sh || exit $?
 
 msm:apq8096:
   extends:
@@ -167,7 +178,7 @@ msm:apq8096:
     GPU_VERSION: apq8096
     RUNNER_TAG: google-freedreno-db820c
   script:
-    - ./install/bare-metal/fastboot.sh
+    - ./install/bare-metal/fastboot.sh || exit $?
 
 msm:sdm845:
   extends:
@@ -181,7 +192,7 @@ msm:sdm845:
     GPU_VERSION: sdm845
     RUNNER_TAG: google-freedreno-cheza
   script:
-    - ./install/bare-metal/cros-servo.sh
+    - ./install/bare-metal/cros-servo.sh || exit $?
 
 msm:sm8350-hdk:
   extends:
-- 
2.43.0


