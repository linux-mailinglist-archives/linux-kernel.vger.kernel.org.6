Return-Path: <linux-kernel+bounces-350386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3942990476
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60952814B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFC2139B0;
	Fri,  4 Oct 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XEsh+hwC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42659212EF3;
	Fri,  4 Oct 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048720; cv=none; b=oGf2cl0A8ZOTbRXgw2G4/+P2M0eNTDlJjBr3boqfWv5Ytba0vD6s1IISK6YokkZvqeh5PEeQLuSwGG6H88H1q5GcUK7xt2fTK0yR5B3xy8cI1+T9ESrGbwoCPDfwlowgAAS6FOMVkNKzAKBV1XuE2h8pRBpcvCvdFhkkzFGWFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048720; c=relaxed/simple;
	bh=roY4AjfacH5tSaPZZt5a+dPVVs9QIen07yXvNWzgQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhVBHuZM8nDOPQTlnguxoNBY2HjMdBLaY37AiYC/LK0z031gBZXeuc8QtRMipPNIy28MXbTDVuCqwdeJ6Ed9nGJlw2x0lLDUr1J1aaSYOG/clD2h0jkRQnqNR6U90lY5N7T8ZlDBBRVRIeY5UNiAJJj8BV4AIgUNLRFzWpGCZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XEsh+hwC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728048716;
	bh=roY4AjfacH5tSaPZZt5a+dPVVs9QIen07yXvNWzgQ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEsh+hwCRYd8VH6oU6OfQGzwANaLnFLYD0j2w/vYjM900YEGzZaSYb92I+WGT2CkW
	 IVQ/8XJVM38UM4MnaBUxjGTGiDWIVf8H9R5r5yhYCSNegXxmeOspTJc1ZJPsY5XSx6
	 yMiSFgC22PxDMHT2ZRANzwL8Z7Z1HVys6l9YHmACgXcXtJL1zl+EQ67GMiL6Ucdexp
	 GuygQGXHYfQyTts3gzMR8gJEkD2E9pFuVpm9JZCIKWqoCShjBCXAspAhMlDVN5/RMU
	 nW0Jysz0lcB3pVeFGJyJo/B6+Fgv4PZrG80khgri94o4xmZHIH4IS5GZu9h2J511sM
	 WLgv9IxpgXMBA==
Received: from localhost.localdomain (unknown [171.76.80.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFD8F17E35EF;
	Fri,  4 Oct 2024 15:31:53 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	deborah.brouwer@collabora.com,
	dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/ci: add dedede
Date: Fri,  4 Oct 2024 19:01:19 +0530
Message-ID: <20241004133126.2436930-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004133126.2436930-1-vignesh.raman@collabora.com>
References: <20241004133126.2436930-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add job that executes the IGT test suite for acer-cb317-1h-c3z6-dedede.
dedede boards use 64 bit Intel Jasper Lake processors.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml                   |  9 ++++
 drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt  | 51 +++++++++++++++++++
 drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt | 13 +++++
 drivers/gpu/drm/ci/xfails/i915-jsl-skips.txt  | 20 ++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-jsl-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 81472451ccd1..3f50750be1c9 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -306,6 +306,15 @@ i915:tgl:
     GPU_VERSION: tgl
     RUNNER_TAG: mesa-ci-x86-64-lava-acer-cp514-2h-1130g7-volteer
 
+i915:jsl:
+  extends:
+    - .i915
+  parallel: 4
+  variables:
+    DEVICE_TYPE: acer-cb317-1h-c3z6-dedede
+    GPU_VERSION: jsl
+    RUNNER_TAG: mesa-ci-x86-64-lava-acer-cb317-1h-c3z6-dedede
+
 .amdgpu:
   extends:
     - .lava-igt:x86_64
diff --git a/drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt b/drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt
new file mode 100644
index 000000000000..ed9f7b576843
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt
@@ -0,0 +1,51 @@
+core_setmaster@master-drop-set-user,Fail
+i915_module_load@load,Fail
+i915_module_load@reload,Fail
+i915_module_load@reload-no-display,Fail
+i915_module_load@resize-bar,Fail
+i915_pm_rpm@gem-execbuf-stress,Timeout
+i915_pm_rpm@module-reload,Fail
+kms_flip@plain-flip-fb-recreate,Fail
+kms_flip_scaled_crc@flip-32bpp-linear-to-64bpp-linear-downscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-linear-to-64bpp-linear-upscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-xtile-to-64bpp-xtile-downscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-xtile-to-64bpp-xtile-upscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-ytile-to-64bpp-ytile-upscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-ytileccs-to-64bpp-ytile-downscaling,Fail
+kms_flip_scaled_crc@flip-32bpp-ytileccs-to-64bpp-ytile-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-linear-to-16bpp-linear-downscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-linear-to-16bpp-linear-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-linear-to-32bpp-linear-downscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-linear-to-32bpp-linear-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-xtile-to-16bpp-xtile-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-xtile-to-32bpp-xtile-downscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-xtile-to-32bpp-xtile-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-16bpp-ytile-downscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-16bpp-ytile-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-32bpp-ytile-downscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-32bpp-ytile-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-32bpp-ytilegen12rcccs-upscaling,Fail
+kms_flip_scaled_crc@flip-64bpp-ytile-to-32bpp-ytilercccs-downscaling,Fail
+kms_lease@lease-uevent,Fail
+kms_pm_rpm@legacy-planes,Timeout
+kms_pm_rpm@legacy-planes-dpms,Timeout
+kms_pm_rpm@modeset-stress-extra-wait,Timeout
+kms_pm_rpm@universal-planes,Timeout
+kms_pm_rpm@universal-planes-dpms,Timeout
+kms_rotation_crc@multiplane-rotation,Fail
+kms_rotation_crc@multiplane-rotation-cropping-bottom,Fail
+kms_rotation_crc@multiplane-rotation-cropping-top,Fail
+perf@i915-ref-count,Fail
+perf_pmu@busy-accuracy-50,Fail
+perf_pmu@module-unload,Fail
+perf_pmu@most-busy-idle-check-all,Fail
+perf_pmu@rc6,Crash
+sysfs_heartbeat_interval@long,Timeout
+sysfs_heartbeat_interval@off,Timeout
+sysfs_preempt_timeout@off,Timeout
+sysfs_timeslice_duration@off,Timeout
+xe_module_load@force-load,Fail
+xe_module_load@load,Fail
+xe_module_load@many-reload,Fail
+xe_module_load@reload,Fail
+xe_module_load@reload-no-display,Fail
diff --git a/drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt b/drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt
new file mode 100644
index 000000000000..325d23612f5e
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt
@@ -0,0 +1,13 @@
+# Board Name: acer-cb317-1h-c3z6-dedede
+# Bug Report:
+# Failure Rate: 100
+# IGT Version: 1.28-ga73311079
+# Linux Version: 6.12.0-rc1
+kms_flip@flip-vs-panning-interruptible
+
+# Board Name: acer-cb317-1h-c3z6-dedede
+# Bug Report:
+# Failure Rate: 100
+# IGT Version: 1.28-ga73311079
+# Linux Version: 6.12.0-rc1
+kms_universal_plane@cursor-fb-leak
diff --git a/drivers/gpu/drm/ci/xfails/i915-jsl-skips.txt b/drivers/gpu/drm/ci/xfails/i915-jsl-skips.txt
new file mode 100644
index 000000000000..1a3d87c0ca6e
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/i915-jsl-skips.txt
@@ -0,0 +1,20 @@
+# Suspend to RAM seems to be broken on this machine
+.*suspend.*
+
+# Skip driver specific tests
+^amdgpu.*
+^msm.*
+nouveau_.*
+^panfrost.*
+^v3d.*
+^vc4.*
+^vmwgfx*
+
+# GEM tests takes ~1000 hours, so skip it
+gem_.*
+
+# trap_err
+i915_pm_rc6_residency.*
+
+# Hangs the machine and timeout occurs
+i915_pm_rpm@system-hibernate*
-- 
2.43.0


