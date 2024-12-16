Return-Path: <linux-kernel+bounces-447257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E59F2F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0392D7A11C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836D204F93;
	Mon, 16 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="syJzmf0d"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B5204599
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348894; cv=none; b=TByvbjig6YSfzsjhvLruh7H1RKSCj9UtxdM+xcaEVtCm+icXBbgpo1BUu0xzuLfoHnV2yBX3PQ30gphbNuolRS8IaNUMagFmon6H6dh92Ul8fMRttKs/WHyeSpYoF38thH4sP0+voVxxCHqIjggH2lPFBVpwZ8yKlYoJZCHbkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348894; c=relaxed/simple;
	bh=UcFNLmnvsYaQOHcmZvcmxzeMoweYVAEm2PgsTyadgkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dxxmco0mJmK9d7B5WsnQe91ckTzMQMXHf5vGxOMqqSUedoEJ8D6oPEsi7yPy6g7TGo+71qwxsxDZJrfth6pKnE2T/DbGljT2jZE/BUqhiKvFszbumU5B++iwrJYPsG8kbZR4ptbnCr1AtgR+8gP23ot9C8uqms8ct+Xoc7MwUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=syJzmf0d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=UcFNLmnvsYaQOHcmZvcmxzeMoweYVAEm2PgsTyadgkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=syJzmf0d4MfCocdBz4SdwRhaTCrA7uJxy2KQkCR7vFDUozn+OrKnjr+sCP5846KEM
	 pOb1SZsB+JL7/uyO0moALDM8wWobbJx88Pq57EmLv/sD7CAT4zYI681gHjAcS6phLE
	 1xB6vfUEiLUnjkBkMiiTLyZs6ozj1ORaZReYlWv0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:34:49 +0100
Subject: [PATCH 3/5] drm/i915: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-3-210f2b36b9bf@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=3431;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UcFNLmnvsYaQOHcmZvcmxzeMoweYVAEm2PgsTyadgkI=;
 b=Cf8bG3lKy+H2AAGHpNlU9pJX+g0endqvP6W/4Y7M0B1o4fSNb6WQQ2Ir7gmA0kMgrqUn11+go
 eYMtY4tn9ibBNp7Y4fsPYQsbC+bjLvJlQU2xTEStr9ySkNZJezQ0n2x
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/i915/i915_gpu_error.c |  8 ++++----
 drivers/gpu/drm/i915/i915_sysfs.c     | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 71c0daef19962660086b37fe55ca2d6b01f2bb9a..a4cb4e731bdd72201c91541fb86e827e96214a8b 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -2491,7 +2491,7 @@ void i915_gpu_error_debugfs_register(struct drm_i915_private *i915)
 }
 
 static ssize_t error_state_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr, char *buf,
+				const struct bin_attribute *attr, char *buf,
 				loff_t off, size_t count)
 {
 
@@ -2527,7 +2527,7 @@ static ssize_t error_state_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t error_state_write(struct file *file, struct kobject *kobj,
-				 struct bin_attribute *attr, char *buf,
+				 const struct bin_attribute *attr, char *buf,
 				 loff_t off, size_t count)
 {
 	struct device *kdev = kobj_to_dev(kobj);
@@ -2543,8 +2543,8 @@ static const struct bin_attribute error_state_attr = {
 	.attr.name = "error",
 	.attr.mode = S_IRUSR | S_IWUSR,
 	.size = 0,
-	.read = error_state_read,
-	.write = error_state_write,
+	.read_new = error_state_read,
+	.write_new = error_state_write,
 };
 
 void i915_gpu_error_sysfs_setup(struct drm_i915_private *i915)
diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i915_sysfs.c
index 8775beab9cb8438c2e8abb0f9d8104dcba7c0df3..f936e8f1f12942287a5a7d6aa7db6ed3a4c28281 100644
--- a/drivers/gpu/drm/i915/i915_sysfs.c
+++ b/drivers/gpu/drm/i915/i915_sysfs.c
@@ -60,7 +60,7 @@ static int l3_access_valid(struct drm_i915_private *i915, loff_t offset)
 
 static ssize_t
 i915_l3_read(struct file *filp, struct kobject *kobj,
-	     struct bin_attribute *attr, char *buf,
+	     const struct bin_attribute *attr, char *buf,
 	     loff_t offset, size_t count)
 {
 	struct device *kdev = kobj_to_dev(kobj);
@@ -88,7 +88,7 @@ i915_l3_read(struct file *filp, struct kobject *kobj,
 
 static ssize_t
 i915_l3_write(struct file *filp, struct kobject *kobj,
-	      struct bin_attribute *attr, char *buf,
+	      const struct bin_attribute *attr, char *buf,
 	      loff_t offset, size_t count)
 {
 	struct device *kdev = kobj_to_dev(kobj);
@@ -140,8 +140,8 @@ i915_l3_write(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute dpf_attrs = {
 	.attr = {.name = "l3_parity", .mode = (S_IRUSR | S_IWUSR)},
 	.size = GEN7_L3LOG_SIZE,
-	.read = i915_l3_read,
-	.write = i915_l3_write,
+	.read_new = i915_l3_read,
+	.write_new = i915_l3_write,
 	.mmap = NULL,
 	.private = (void *)0
 };
@@ -149,8 +149,8 @@ static const struct bin_attribute dpf_attrs = {
 static const struct bin_attribute dpf_attrs_1 = {
 	.attr = {.name = "l3_parity_slice_1", .mode = (S_IRUSR | S_IWUSR)},
 	.size = GEN7_L3LOG_SIZE,
-	.read = i915_l3_read,
-	.write = i915_l3_write,
+	.read_new = i915_l3_read,
+	.write_new = i915_l3_write,
 	.mmap = NULL,
 	.private = (void *)1
 };

-- 
2.47.1


