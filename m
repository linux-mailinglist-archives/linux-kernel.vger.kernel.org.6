Return-Path: <linux-kernel+bounces-517011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ADAA37AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A35716D6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F0187FEC;
	Mon, 17 Feb 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EYfwkZ7T"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73E15F306
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770668; cv=none; b=gmvZkJlXNiiMPpbqSCyw4gCw3uOG1AqjbFo1mZMyfpmN9t12/CP81mpmbXx7QPKpgUfm/LZBEuu1+ntv5bPs1FY6ErXe5KIAAZcPdR74eMeZjud7n1xqanOvX5GOkbGIF8v0bwSJ0d5U8K1cDqBRq8ENbGrOz+UrRpMJHo0hgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770668; c=relaxed/simple;
	bh=iG4R8KXF/3Kpb+nBroyLd+zG/D7FL/wGqoOUVHGAz0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EykpkeUnCb5mueA69LY+3Ztc3mFAeoj38x3GbzXpwgrk9SsG1aHOtirTfEmqJCm7uz8OYlVyFV184Z3G4ye+Pxp8imY9qUQY8Ox7j9FI2/1eaN0BgHJmUjN6l1PCxHNY+ZsIV2m1hW7gzP4Eq01ZFSgBNYeFpTkpMEpDBnHEMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EYfwkZ7T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739770664;
	bh=iG4R8KXF/3Kpb+nBroyLd+zG/D7FL/wGqoOUVHGAz0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYfwkZ7Ts9/ctEYoWsHYCxLQ5v1b0T7m3h+nXecOzPwnI1AGZyWecCseAZOjf1WI3
	 qQC0IkPrIXY32kAZO5eVg5xpHv6ehiJ2TIIiIQZcTWSe3h0djNwEGQSefVPTR3b/Ge
	 Rea+bmVzCqc16lCfWH8Uztz9Ka4BqbzXZi4LANhZ3UKl/kYsTRN+IBLnFqZTl6uXnD
	 7PXv+wf5m5j2wd92dlqFHw+j9uPo8nBxw0Ru4Ub7SSR1fdf/ubmGHa4PvAXN0Zd/vr
	 V7x/djSgBMWCgPg9e6pAIZW8cRHdSg6p5BXaIDc6Hl5LzNr3KiDmAKRytvQxDL99O/
	 L3W44TBnHeJjg==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65BD817E14E7;
	Mon, 17 Feb 2025 06:37:39 +0100 (CET)
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
Subject: [PATCH v3 1/3] drm/ci: refactor software-driver stage jobs
Date: Mon, 17 Feb 2025 11:07:10 +0530
Message-ID: <20250217053719.442644-2-vignesh.raman@collabora.com>
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

Move common job configuration for software-driver
stage jobs to separate job.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - New patch in the series.

v3:
  - No changes.

---
 drivers/gpu/drm/ci/test.yml | 59 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 6a1e059858e5..0eab020a33b9 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -89,6 +89,26 @@
   tags:
     - $RUNNER_TAG
 
+.software-driver:
+  stage: software-driver
+  timeout: "1h30m"
+  rules:
+    - !reference [.scheduled_pipeline-rules, rules]
+    - when: on_success
+  extends:
+    - .test-gl
+  tags:
+    - kvm
+  script:
+    - ln -sf $CI_PROJECT_DIR/install /install
+    - mv install/bzImage /lava-files/bzImage
+    - mkdir -p /lib/modules
+    - install/crosvm-runner.sh install/igt_runner.sh
+  needs:
+    - debian/x86_64_test-gl
+    - testing:x86_64
+    - igt:x86_64
+
 .msm-sc7180:
   extends:
     - .lava-igt:arm64
@@ -440,47 +460,16 @@ panfrost:g12b:
     - .panfrost-gpu
 
 virtio_gpu:none:
-  stage: software-driver
-  timeout: "1h30m"
-  rules:
-    - !reference [.scheduled_pipeline-rules, rules]
-    - when: on_success
+  extends:
+    - .software-driver
   variables:
     CROSVM_GALLIUM_DRIVER: llvmpipe
     DRIVER_NAME: virtio_gpu
     GPU_VERSION: none
-  extends:
-    - .test-gl
-  tags:
-    - kvm
-  script:
-    - ln -sf $CI_PROJECT_DIR/install /install
-    - mv install/bzImage /lava-files/bzImage
-    - install/crosvm-runner.sh install/igt_runner.sh
-  needs:
-    - debian/x86_64_test-gl
-    - testing:x86_64
-    - igt:x86_64
 
 vkms:none:
-  stage: software-driver
-  timeout: "1h30m"
-  rules:
-    - !reference [.scheduled_pipeline-rules, rules]
-    - when: on_success
+  extends:
+    - .software-driver
   variables:
     DRIVER_NAME: vkms
     GPU_VERSION: none
-  extends:
-    - .test-gl
-  tags:
-    - kvm
-  script:
-    - ln -sf $CI_PROJECT_DIR/install /install
-    - mv install/bzImage /lava-files/bzImage
-    - mkdir -p /lib/modules
-    - ./install/crosvm-runner.sh ./install/igt_runner.sh
-  needs:
-    - debian/x86_64_test-gl
-    - testing:x86_64
-    - igt:x86_64
-- 
2.43.0


