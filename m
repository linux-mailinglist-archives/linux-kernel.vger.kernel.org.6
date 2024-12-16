Return-Path: <linux-kernel+bounces-447255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD49F2F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406D31883C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48431204F84;
	Mon, 16 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Q8zsUSw4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188F204568
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348894; cv=none; b=NvxYCOs/5k4GoztfvxvAebC399tCKkZ0hLfjAEMcNN6c7ftIfhF0qpRmMCSdUe5p/aclal9RaTJx18CaS7CPMzjVAirwNQ6EMTTGSvOe5+4ijKYRLB1TVUP9Xe3arT0xMIjDTilAwK17ZFS/JnO7aKNWhJ8lc30bMJvPZ85Mm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348894; c=relaxed/simple;
	bh=zuT+LJN8yyZdjBUYgx4LeWWwlVkL7wdTwqvya297jls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0CpWKl79PMSu/RvOm+RdhaAiaS/fqFE3U8E/1brX4Ie8OtqlsTMDQAaeLLhdLn4cP94VCkKIUrRasBf8519H330ziwO5PMseSV4ikuc5UcRC4qneENDNgN7OZmMvNt153leh97IF8NErg/Rt62IEZbFmLaKS6Uo9P8vMnKJwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Q8zsUSw4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=zuT+LJN8yyZdjBUYgx4LeWWwlVkL7wdTwqvya297jls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q8zsUSw45BtgARRdWi3boy4K+6THyxtcF4oUO/jPWdN8pAVOI3rQJkUz2GF14htdS
	 EJ2du0p7474uP0KSCM97/l/z1co3lKUSAc74rJf5fgoR6CzcZ1LWTHAsGnO8OtsJ4V
	 Ns1bKYa8fvFqN9jvTm/aHo3VwdBTsiFTm1imSxpw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:34:50 +0100
Subject: [PATCH 4/5] drm/amdgpu: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-4-210f2b36b9bf@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=5717;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zuT+LJN8yyZdjBUYgx4LeWWwlVkL7wdTwqvya297jls=;
 b=t/e4NpjzaihOxUQhxM9fCFKwdSbBN4HpYBXnVQDcuR8p8/tYTm7wlNTElz/kh4GFe2sa+7MPl
 RfSBcyst2hbDjIWe0ng8erI2054SsD6gVbtFvLfTdtHkotBHapZ8aeM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 13 ++++++-------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d272d95dd5b2f5eb83be279281d55af323f7f508..88459de2cd2e47390d33e5939875c3322b740b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -223,7 +223,7 @@ static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
 static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
-					  struct bin_attribute *attr, char *buf,
+					  const struct bin_attribute *attr, char *buf,
 					  loff_t ppos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -259,8 +259,8 @@ static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
 	return bytes_read;
 }
 
-BIN_ATTR(reg_state, 0444, amdgpu_sysfs_reg_state_get, NULL,
-	 AMDGPU_SYS_REG_STATE_END);
+static const BIN_ATTR(reg_state, 0444, amdgpu_sysfs_reg_state_get, NULL,
+		      AMDGPU_SYS_REG_STATE_END);
 
 int amdgpu_reg_state_sysfs_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 448f9e742983f3ef0c5fccc18d85f0c2449aa08e..cda25174730a6852bcb6e01aeec858faad172b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3969,7 +3969,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin)
 }
 
 static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
-					struct bin_attribute *bin_attr,
+					const struct bin_attribute *bin_attr,
 					char *buffer, loff_t pos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -4005,7 +4005,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
-				       struct bin_attribute *bin_attr, char *buffer,
+				       const struct bin_attribute *bin_attr, char *buffer,
 				       loff_t pos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -4057,11 +4057,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
  * Writing to this file will stage an IFWI for update. Reading from this file
  * will trigger the update process.
  */
-static struct bin_attribute psp_vbflash_bin_attr = {
+static const struct bin_attribute psp_vbflash_bin_attr = {
 	.attr = {.name = "psp_vbflash", .mode = 0660},
 	.size = 0,
-	.write = amdgpu_psp_vbflash_write,
-	.read = amdgpu_psp_vbflash_read,
+	.write_new = amdgpu_psp_vbflash_write,
+	.read_new = amdgpu_psp_vbflash_read,
 };
 
 /**
@@ -4088,7 +4088,7 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 }
 static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
-static struct bin_attribute *bin_flash_attrs[] = {
+static const struct bin_attribute *const bin_flash_attrs[] = {
 	&psp_vbflash_bin_attr,
 	NULL
 };
@@ -4124,7 +4124,7 @@ static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
 
 const struct attribute_group amdgpu_flash_attr_group = {
 	.attrs = flash_attrs,
-	.bin_attrs = bin_flash_attrs,
+	.bin_attrs_new = bin_flash_attrs,
 	.is_bin_visible = amdgpu_bin_flash_attr_is_visible,
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4c9fa24dd9726a405935907524ed7bf7862779d1..2991e0967b5bfc848328aaa59ddfb9a8f202bae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1732,7 +1732,7 @@ static char *amdgpu_ras_badpage_flags_str(unsigned int flags)
  */
 
 static ssize_t amdgpu_ras_sysfs_badpages_read(struct file *f,
-		struct kobject *kobj, struct bin_attribute *attr,
+		struct kobject *kobj, const struct bin_attribute *attr,
 		char *buf, loff_t ppos, size_t count)
 {
 	struct amdgpu_ras *con =
@@ -2063,8 +2063,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 /* debugfs end */
 
 /* ras fs */
-static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
-		amdgpu_ras_sysfs_badpages_read, NULL, 0);
+static const BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
+		      amdgpu_ras_sysfs_badpages_read, NULL, 0);
 static DEVICE_ATTR(features, S_IRUGO,
 		amdgpu_ras_sysfs_features_read, NULL);
 static DEVICE_ATTR(version, 0444,
@@ -2086,7 +2086,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 		&con->event_state_attr.attr,
 		NULL
 	};
-	struct bin_attribute *bin_attrs[] = {
+	const struct bin_attribute *bin_attrs[] = {
 		NULL,
 		NULL,
 	};
@@ -2112,11 +2112,10 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 
 	if (amdgpu_bad_page_threshold != 0) {
 		/* add bad_page_features entry */
-		bin_attr_gpu_vram_bad_pages.private = NULL;
 		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
+		sysfs_bin_attr_init(&con->badpages_attr);
 		bin_attrs[0] = &con->badpages_attr;
-		group.bin_attrs = bin_attrs;
-		sysfs_bin_attr_init(bin_attrs[0]);
+		group.bin_attrs_new = bin_attrs;
 	}
 
 	r = sysfs_create_group(&adev->dev->kobj, &group);

-- 
2.47.1


