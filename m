Return-Path: <linux-kernel+bounces-290964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4219955BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89E1B213B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F117996;
	Sun, 18 Aug 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cwHiehL/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031311CBD;
	Sun, 18 Aug 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964289; cv=none; b=tTSiY5Uezs4iwxpLhzIanHg7BzCdt/HML5mZRapKTw+CUiS/uX69LY74DHvRImpI0KPhKTiPYBbkZmBs4C2aqwSpJgvK7Kt96FpDo7Jw5X1WQQ0kRGKcbfZYSX34X6apm/YVkHvg0vZBIFkUapRmutEU1Z6l5pKtH1dPk6y/jJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964289; c=relaxed/simple;
	bh=4S0TPLVOMYGbY7siR+2P78e35RR7DBhUXZTnksv5KXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUPwbIJh3MtKsey7hNA8jU9Mb1kdnpQDUB5bnghT58RlmFiE3s143OFB2C1TBbN8GjWwLQnY+nqFxKOKC6Ws+l+kjC7RVx5i0DJKjDK89wCDAZ4FTy86734XdrMOl9Q7nwuu2s2nzrdRtkdQgPsV5KMUELd5RfAh781TwKapTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cwHiehL/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723964282;
	bh=4S0TPLVOMYGbY7siR+2P78e35RR7DBhUXZTnksv5KXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cwHiehL/7AQgm7UAoSQAfhllGd9TkEVVDz2Nasn6BKiJ/Xptjx0bom1tkn+UPIgGr
	 ZxP+ye/679/WND4rrsWPa2RRkVcJuQCML3QEFHdqB/b+o6f2hPGZMpkEVQwme9GAGg
	 OHJbaL3NcGru8vz4Gi2bVs0KsD3UciwF+6XchGk8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 08:56:39 +0200
Subject: [PATCH v5 3/4] drm: panel-backlight-quirks: Add Framework 13 matte
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-min-backlight-quirk-v5-3-b6c0ead0c73d@weissschuh.net>
References: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
In-Reply-To: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723964281; l=1422;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4S0TPLVOMYGbY7siR+2P78e35RR7DBhUXZTnksv5KXs=;
 b=zutQtmcjZW5BMqqXG8ne3r1BkODFHwoSzIJ/zXhO2G/scjL52V+F4LsoEwNpET6/EZDnVqiAJ
 QCH9QE5TkGND4lI6LRd5pMNTCbSR/xlulMYBjvvTzVzzQEzphJYsGrB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Add a quirk to override that the minimum backlight PWM to "0" which
leads to a much lower minimum brightness, which is still visible.

Tested on a Framework AMD 13 BIOS 3.05 with the matte panel.

Link: https://community.frame.work/t/25711/9
Link: https://community.frame.work/t/47036
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 6b8bbed77c7f..f2aefff618dd 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -17,6 +17,14 @@ struct drm_panel_min_backlight_quirk {
 };
 
 static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks[] = {
+	/* 13 inch matte panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0bca),
+		.ident.name = "NE135FBM-N41",
+		.min_brightness = 0,
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,

-- 
2.46.0


