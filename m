Return-Path: <linux-kernel+bounces-227471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52C89151B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CA2861F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A819CCE8;
	Mon, 24 Jun 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXud1m54"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7219D896
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241985; cv=none; b=cvT75fvCB9WyDikxvr86FIvoStenPR6c18k+Ca4yeJ10o/u5qhYmYtHc2nabkDXXz41tfYTk2KeUQ0+QhYHdqFLVfRFbZ67CDAZKa8HhRl4WXw3agZCQu9IrNc8jtXj4JFHFW86zrHXsD+uGSlVW92tFE0kDXWjX8OJOuR8uxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241985; c=relaxed/simple;
	bh=OG1hBreneSn/u6FO8pFukOgS6LFZEChaIJCu1zPnDwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukrUdruxDf3RltA3GvYxQDgYMtjSid+vomCQWwpQ0fhDF1j0WdXMiNil3l8GLgfLJv0iCdEEqQqWYI9OMBmLzcpU4ZJRhaZgNawR2NQS3Ws4NCHd+ZLU81B/CXwBRL2w0lY5CVaklGsibfAVAx9AF/h6CEOr9bgTshFHELUUL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXud1m54; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b50aeb2424so21771166d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241983; x=1719846783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMpMM3VMXw3Pt2FtK4Aaxt1tlk2OfNvq+GBMyg4jRHU=;
        b=SXud1m54Z39PRmt+QCHFbbVzSy5Q2ws87JtSdX4+bxOlsFEMoD/rT9JwbiNWTjhpHG
         xN4gxnbeEu4+RGu5tAYgHwfiYzllnrt5mF/s1MEWEyvJXxdNL3Cak/6WQrsHytadi0dq
         thDIYuQ+4sfsy9Ub/aHea9lDe70xaYd/v3BzbP6AJHKpp7ULAsKVdpFlREyGqq6x5jcD
         zUuz3j+q0KtRrYIjAq6geQpW+4I7yh4QlQK4zmXTCEp5rF7K59ruPbdNgGFueiu4PG2B
         6OB2z9bKrOXTRI9u4EPcwjny9pitoe5CbWJofEW0dnpBZP3n13dA1to/g9TVMkISHxSc
         Q7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241983; x=1719846783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMpMM3VMXw3Pt2FtK4Aaxt1tlk2OfNvq+GBMyg4jRHU=;
        b=QrTpk9OkdkQPFF4A6cvHGXp11VxCrpp+/xKFHF6oPeI9nd3CUjZP/MhOylepkxyEjf
         cU8sE2TtrPoVSznIfqibgtnlMF7P5I/PcUC3WDlWntqaYwhTLzReyEcTM2FPaCrfI8hQ
         cSv5hFehdlGFrN2kJ7wynda2PSnhAhI2AKaL65fG7UY/SCOISrjgJCqq7ObOoBQhXXpw
         7m0LNQq6jdMfC8uR56IwCX6RT+rmP8x/J/B92DmWIQbEKMDccho4OwE9aR3rQfwbXeGQ
         P5k3tvAST1zxm7svGl6hC6/IW/tyIzf65rGhfYOz57V2bpJUmglBwkCritP+JTtr3gFH
         Bl1w==
X-Forwarded-Encrypted: i=1; AJvYcCUGuR0DsCXCWHHPuVjOkVorlGeWVrF21x6/HLW5pJDV424/G58hmBSR7DSEwnHvs0DSBeSKzNIDzQuLH2O4meH4E39qgyFUUpvFDo4d
X-Gm-Message-State: AOJu0Ywa7EzaGUfA+GKUE/f9HuLjFB0SyKzjsbV5EKnsHaTgb/JQwBXH
	5W+NGp3RQiYGrqYFgcArRvHRY+ifTc2NmYIztkHuF6UJsvlitzGR2Cirhbx5
X-Google-Smtp-Source: AGHT+IFMVmdeX14jN4dWDHaBXFZ14U2ROwwMKJgHg1KAQgkmU+44jh2hW2HjmSWq5/Aio0upbqp3qg==
X-Received: by 2002:a0c:f013:0:b0:6b5:4fbc:4c4a with SMTP id 6a1803df08f44-6b54fbc4edfmr32286396d6.2.1719241982809;
        Mon, 24 Jun 2024 08:13:02 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:13:02 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 3
Date: Mon, 24 Jun 2024 11:10:48 -0400
Message-ID: <20240624151122.23724-5-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624151122.23724-1-wuhoipok@gmail.com>
References: <20240624151122.23724-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please refer to patch 1.

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


