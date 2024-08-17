Return-Path: <linux-kernel+bounces-290836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E7955956
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57ED1C20CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E215534D;
	Sat, 17 Aug 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b="oJtzX1ay"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7322334
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723921173; cv=none; b=YRgm2Hen3NGCuGqrzPb0+G1aK5XzKFFl+amuL1ZB5gcyxwKGucZSizvVyMQCNl8xjUy6jQqqSa5QiqnGaMOzh+QkzAbgG54RyZlolTtQ6ngmpQs8jYZSvedmYcgGF1ZR7QWD5SIMqxzEaQOaTH1hl3GejuuhbS8M/GsPMBB8Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723921173; c=relaxed/simple;
	bh=clckoixbjNZipfiFJmBFFo4F0E14Wh2dU+hMp/lw/8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bl9qdJdgsso00IEOXTv0QCUvoinC2xc7II4yfn5U+AgqpSicEaJKSul0tE71oZSzazWqWKsKLwnVnRh10cbvV7XgLPlAscGh9r8yfpNPyKu+dsDBxnBEI2b5FRMRVX+gPvEP/t6/GCXZZgpwjvXTBGq4KTePbAtnX8PvWuZrr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b=oJtzX1ay; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-69483a97848so29807507b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett.net; s=google; t=1723921170; x=1724525970; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOEb9DjC8C4gSnq0R9sZfb7HwCNzSDtTyyJEre0G9ys=;
        b=oJtzX1ay8UXUf9ir9A3h+PWnpwxBoQYw21J3XgHof5wQ3Ikdm65LQcOMCsDaIHCxsx
         JkYJKuEeVEUEc62Xz6oFBkbeF/NRX9oI9kWDOaSD3BxHWtgNW2KAPbLTt4HlN8JBiteh
         6TaH3fWAIoJ9XPwU5MgXXaUMRLmshdHpMXXgZ7g7oCS5ysbKbU9IgZhe69tlB6pAttYK
         qKs9BiA6j38gar3UpgUG2MrDJGfE0mBwXC2O7a+8y1NE2f4IcJ8cudw1wlyigzypsZWv
         FvzuSgqpfJV7SIEEr/WvRKJ4GE1e/CQJ9gdBwi3zb6Ya+72vmArkfvFRCp8GmX5kcSzS
         MWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723921170; x=1724525970;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOEb9DjC8C4gSnq0R9sZfb7HwCNzSDtTyyJEre0G9ys=;
        b=VD3F/OGFx86PMDSpYErUashnbQ/GMlTKFFCUaSlX7cGqfEkI9RftcLIz74yFDlFU7D
         s6xVtScl2HtEMN4Guc07cFgQ5IAo39mOVeaI3QzLQKx3LxD3DVngMOK13sSRTuawmJsg
         rsRvxID5PwTfBppah/jU1j2Ht9CauNMaVfhvKpra98BtniBpOzsa02nkApQxF6llp3XD
         BwrmmO7Z/wY0gUbIUtdYru0QAg7Q7RMUROGg9vqfE6oU95ymRLT28IHabimUWtRCY0ur
         eohT4wuGvKh6e7TVtXo5oUvc8v5Pq+pS9lEn8Phbf0e3/qmiAN6wQkJ29z4GOKl3WsC7
         YY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVrI344J1GgYoir3DCKTkDjvpPOJ4qadZij1nPcQ2PqJ9ZGQ4BS0Q1QRfj7XfBg+GL8h39tvcTlIiEHm8MZbTm+bVKbxrlAOALQpZsZ
X-Gm-Message-State: AOJu0YxFHHFZkQkFyTzCpTbNuP0ud6P8arqKx8HSROMn85nLDXIWXgRO
	qdw0zCuev8zkFqXySlHluxiL4pYvXSBk5LTANqz00yQPmaJHedzUW/4ISZaKEQ==
X-Google-Smtp-Source: AGHT+IGvCA4SK5nWxPmS0rUPAyrPIHZQr5OiOhI6qqSuz0rFCaAb5EwzTE5YASkeqSTp/+Nz95ZK5w==
X-Received: by 2002:a05:690c:f09:b0:632:c442:2316 with SMTP id 00721157ae682-6b1b75975f5mr80541077b3.3.1723921169847;
        Sat, 17 Aug 2024 11:59:29 -0700 (PDT)
Received: from [127.0.0.1] ([2600:1702:5e30:4f11::6f8])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6af9ce76217sm10699037b3.92.2024.08.17.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 11:59:29 -0700 (PDT)
From: "Dustin L. Howett" <dustin@howett.net>
Date: Sat, 17 Aug 2024 13:59:26 -0500
Subject: [PATCH] drm: panel-backlight-quirks: Add Framework 13 glossy and
 2.8k panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-drm-add-additional-framework-laptop-displays-to-panel-backlight-quirks-v1-1-cfdd5dbbffc8@howett.net>
X-B4-Tracking: v=1; b=H4sIAA3zwGYC/x2OywrCMBBFf6Vk7UBfaPVXxMWYTNohaZNO4ovSf
 ze6OIsDB+7dVCJhSupSbUroyYnDUqQ5VEpPuIwEbIqrtm77emhOYGQGNOYH5xKjBys40yuIA48
 xhwiGU/T4SZADRFzIwx218zxOGdYHi0sw1L1uOnPszmRVGYtClt//I9fbvn8Bu/361pgAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Dustin L. Howett" <dustin@howett.net>
X-Mailer: b4 0.14.1

This patch depends on
20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net

I have tested these panels on the Framework Laptop 13 AMD with firmware
revision 3.05 (latest at time of submission).

---
Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index c58344cdbb6e..348cf68729f9 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -24,6 +24,24 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135FBM-N41",
 		.min_brightness = 0,
 	},
+	/* 13 inch glossy panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x095f),
+		.ident.name = "NE135FBM-N41",
+		.quirk.overrides.pwm_min_brightness = true,
+		.quirk.pwm_min_brightness = 0,
+	},
+	/* 13 inch 2.8k panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
+		.ident.name = "NE135A1M-NY1",
+		.quirk.overrides.pwm_min_brightness = true,
+		.quirk.pwm_min_brightness = 0,
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,

---
base-commit: da62c6801838309f5c64cd0520f7bd758edb7d4b
change-id: 20240817-drm-add-additional-framework-laptop-displays-to-panel-backlight-quirks-804c13d639ef

Best regards,
-- 
Dustin L. Howett <dustin@howett.net>


