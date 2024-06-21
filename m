Return-Path: <linux-kernel+bounces-224838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7C912774
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8B3288767
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E281CFB5;
	Fri, 21 Jun 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnfNXfsO"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73942232B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979585; cv=none; b=aJSebMHzDrlx4p9JsiFBKGpEG/Zzonmr2EuLgMOJqxMtms1CkJUkzvVn5/FNoVDJw8W6gOrkCFAYSiDREwoQl4QfEWi+Zd2CBwsSawOv+jQks1Je+N/SzkHCC823xQudtL2bAvEaaahqSnAEs3fmD9nMTKEz2y0qk8j7s3loJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979585; c=relaxed/simple;
	bh=D50591tD9KZmpST455/ngN91ZX3oSPtsdZ4VgWYEV8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQzfEsXUa0V+64EPlLXcINqkMovJe/w531AEV9fujcM52ccZp9jkh0KlBq70BBjc1jsPsbCBY0Lj1n2cD9L6XqWxy56DqQilQLYPgvx/imDaOk/XF7RYWfqPmf/kGK5/a2lYKXZcgtD3jhPlL6KOWlyJRZ0MU7gPymsSjtMFDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnfNXfsO; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b970a97e8eso1137068eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718979583; x=1719584383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXKpEaOa9jwO4Fcxwahx5bh3MDEOAXS39GoWJwMNWKo=;
        b=KnfNXfsOBghQknYtwXCp6U4BiZxlYubXWpTtnHeag02Jis/A98WOitvJsQVy2UOjL5
         tt+W2+C0/HxNizHfE8UEo4x4iyVLr9R9B9rr/r+Xif9bIiIhgn5FNLQ5xXYDb9nStinx
         qRv9cteZVf8ko+tZ3HRHHYeH7Whg8VFRSyvF6OrRn5MzvBqK1jQVtG/vR7Cx8DUrrXaT
         BUT4iPITpDBt2AulyVxwnxBmr2QE8m3nfK/hd5lTpdGge/WIPD39UtJPViWJE9Cog+W+
         gqHVka5/YMJpUwkJYV+JGmj4m7GXwYStNZvIAD7SXGjoKxJDF26J2URq6zSXIGYkjb64
         hq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979583; x=1719584383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXKpEaOa9jwO4Fcxwahx5bh3MDEOAXS39GoWJwMNWKo=;
        b=QoKWAgh5+k2Cwe6fGWjQL6yrAoNlwDi3uoIeb9rIzqNa6aTfOCW7K92JUxFTFQRKgM
         PZRJpjaOJnzCTI1dEvu+M9yX5XJxTg8jaYt9eoO4umYE+UdssagMOQ4NoBn/b4LnJ+1l
         vkjtRUOW1TdngNWRL121qV+41H9nHcuTNf/bcAtgNsplutgXUIHIWpFAWg64yNfdFzft
         tWqj37ewqAKsYyk5vA3ka5wKsMVWBm/9Vuz2EaiC0GdotPRa1JqntXF283pCWV9R4MeM
         ABIcqP9jWiXk68+uUH6In8TRCVMS1uOHirYuzwgL0rBx8TV63KqRTZrwzbh5PJAJPbCd
         yt9w==
X-Forwarded-Encrypted: i=1; AJvYcCVeYKlIzhris+3k44Gze1D9QRdGd1zxU+DUAWcmuTejc5fkZjC4ErMd3RYJ+9Fd1x+kVlEfbr9StsXQWfyCyXPnx2kAcVlH/kTeXXJW
X-Gm-Message-State: AOJu0Yx2wV938f7O9Yzc3A6jR7kltlDwb5Dbp31BsYsKMKWvHRk4GOxB
	k66OWy3LOL53NlPLcG67yAZfiK88Bj8vfQRFWd4ZYJyw1djV/a0+
X-Google-Smtp-Source: AGHT+IE14ZnBd+JuKtUJiIG3Li8rO6Wykbn8CMy/R8LDpxSAjIofrdKaZGVIahfooY40E8zQhbV5Ng==
X-Received: by 2002:a05:6358:5e0e:b0:19f:4476:3cc0 with SMTP id e5c5f4694b2df-1a1fd396a52mr1110125055d.12.1718979582692;
        Fri, 21 Jun 2024 07:19:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon4859w-grc-48-142-198-217-108.dsl.bell.ca. [142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bd711418dsm20484285a.4.2024.06.21.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:19:42 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 3
Date: Fri, 21 Jun 2024 10:19:22 -0400
Message-ID: <20240621141924.20033-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please see Patch v2 1/7 for details.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/r600_hdmi.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_acpi.c     | 10 +++++-----
 drivers/gpu/drm/radeon/radeon_agp.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c |  2 +-
 drivers/gpu/drm/radeon/radeon_audio.c    |  4 ++--
 drivers/gpu/drm/radeon/radeon_combios.c  | 12 ++++++------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_hdmi.c b/drivers/gpu/drm/radeon/r600_hdmi.c
index f3551ebaa2f0..661f374f5f27 100644
--- a/drivers/gpu/drm/radeon/r600_hdmi.c
+++ b/drivers/gpu/drm/radeon/r600_hdmi.c
@@ -116,7 +116,7 @@ void r600_audio_update_hdmi(struct work_struct *work)
 {
 	struct radeon_device *rdev = container_of(work, struct radeon_device,
 						  audio_work);
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct r600_audio_pin audio_status = r600_audio_status(rdev);
 	struct drm_encoder *encoder;
 	bool changed = false;
diff --git a/drivers/gpu/drm/radeon/radeon_acpi.c b/drivers/gpu/drm/radeon/radeon_acpi.c
index 603a78e41ba5..22ce61bdfc06 100644
--- a/drivers/gpu/drm/radeon/radeon_acpi.c
+++ b/drivers/gpu/drm/radeon/radeon_acpi.c
@@ -405,11 +405,11 @@ static int radeon_atif_handler(struct radeon_device *rdev,
 	if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
 		if ((rdev->flags & RADEON_IS_PX) &&
 		    radeon_atpx_dgpu_req_power_for_displays()) {
-			pm_runtime_get_sync(rdev->ddev->dev);
+			pm_runtime_get_sync(rdev_to_drm(rdev)->dev);
 			/* Just fire off a uevent and let userspace tell us what to do */
-			drm_helper_hpd_irq_event(rdev->ddev);
-			pm_runtime_mark_last_busy(rdev->ddev->dev);
-			pm_runtime_put_autosuspend(rdev->ddev->dev);
+			drm_helper_hpd_irq_event(rdev_to_drm(rdev));
+			pm_runtime_mark_last_busy(rdev_to_drm(rdev)->dev);
+			pm_runtime_put_autosuspend(rdev_to_drm(rdev)->dev);
 		}
 	}
 	/* TODO: check other events */
@@ -736,7 +736,7 @@ int radeon_acpi_init(struct radeon_device *rdev)
 		struct radeon_encoder *target = NULL;
 
 		/* Find the encoder controlling the brightness */
-		list_for_each_entry(tmp, &rdev->ddev->mode_config.encoder_list,
+		list_for_each_entry(tmp, &rdev_to_drm(rdev)->mode_config.encoder_list,
 				head) {
 			struct radeon_encoder *enc = to_radeon_encoder(tmp);
 
diff --git a/drivers/gpu/drm/radeon/radeon_agp.c b/drivers/gpu/drm/radeon/radeon_agp.c
index a3d749e350f9..89d7b0e9e79f 100644
--- a/drivers/gpu/drm/radeon/radeon_agp.c
+++ b/drivers/gpu/drm/radeon/radeon_agp.c
@@ -161,7 +161,7 @@ struct radeon_agp_head *radeon_agp_head_init(struct drm_device *dev)
 
 static int radeon_agp_head_acquire(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (!rdev->agp)
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 10793a433bf5..97c4e10d0550 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -187,7 +187,7 @@ void radeon_atombios_i2c_init(struct radeon_device *rdev)
 
 			if (i2c.valid) {
 				sprintf(stmp, "0x%x", i2c.i2c_id);
-				rdev->i2c_bus[i] = radeon_i2c_create(rdev->ddev, &i2c, stmp);
+				rdev->i2c_bus[i] = radeon_i2c_create(rdev_to_drm(rdev), &i2c, stmp);
 			}
 			gpio = (ATOM_GPIO_I2C_ASSIGMENT *)
 				((u8 *)gpio + sizeof(ATOM_GPIO_I2C_ASSIGMENT));
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 0bcd767b9f47..47aa06a9a942 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -196,7 +196,7 @@ static void radeon_audio_enable(struct radeon_device *rdev,
 		return;
 
 	if (rdev->mode_info.mode_config_initialized) {
-		list_for_each_entry(encoder, &rdev->ddev->mode_config.encoder_list, head) {
+		list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.encoder_list, head) {
 			if (radeon_encoder_is_digital(encoder)) {
 				radeon_encoder = to_radeon_encoder(encoder);
 				dig = radeon_encoder->enc_priv;
@@ -760,7 +760,7 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 	if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
 		return 0;
 
-	list_for_each_entry(encoder, &rdev->ddev->mode_config.encoder_list, head) {
+	list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.encoder_list, head) {
 		if (!radeon_encoder_is_digital(encoder))
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index 6952b1273b0f..41ddc576f8f8 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -372,7 +372,7 @@ bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev)
 	int edid_info, size;
 	struct edid *edid;
 	unsigned char *raw;
-	edid_info = combios_get_table_offset(rdev->ddev, COMBIOS_HARDCODED_EDID_TABLE);
+	edid_info = combios_get_table_offset(rdev_to_drm(rdev), COMBIOS_HARDCODED_EDID_TABLE);
 	if (!edid_info)
 		return false;
 
@@ -642,7 +642,7 @@ static struct radeon_i2c_bus_rec combios_setup_i2c_bus(struct radeon_device *rde
 
 static struct radeon_i2c_bus_rec radeon_combios_get_i2c_info_from_table(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct radeon_i2c_bus_rec i2c;
 	u16 offset;
 	u8 id, blocks, clk, data;
@@ -670,7 +670,7 @@ static struct radeon_i2c_bus_rec radeon_combios_get_i2c_info_from_table(struct r
 
 void radeon_combios_i2c_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct radeon_i2c_bus_rec i2c;
 
 	/* actual hw pads
@@ -812,7 +812,7 @@ bool radeon_combios_get_clock_info(struct drm_device *dev)
 
 bool radeon_combios_sideport_present(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	u16 igp_info;
 
 	/* sideport is AMD only */
@@ -915,7 +915,7 @@ struct radeon_encoder_primary_dac *radeon_combios_get_primary_dac_info(struct
 enum radeon_tv_std
 radeon_combios_get_tv_info(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	uint16_t tv_info;
 	enum radeon_tv_std tv_std = TV_STD_NTSC;
 
@@ -2637,7 +2637,7 @@ static const char *thermal_controller_names[] = {
 
 void radeon_combios_get_power_modes(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	u16 offset, misc, misc2 = 0;
 	u8 rev, tmp;
 	int state_index = 0;
-- 
2.45.2


