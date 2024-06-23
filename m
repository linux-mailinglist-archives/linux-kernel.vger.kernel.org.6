Return-Path: <linux-kernel+bounces-226015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE9913919
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1417B2108C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0967442F;
	Sun, 23 Jun 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p88ZX1vK"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B702C6B7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133163; cv=none; b=d/AKU/9QAEuj+ocNlG1coGfM+7CHTWxUQYM68yCR9RrkgK93ufeALafXm5AX19eoYyazLMeGfcek8Ekccio1N0kb10IRgXWWzzNjhclKeu0bKsVoZDvqunfh6zX8anarUXagXw48BfTQrE8N5bdYmvevRa+WyH68X1L93Rytqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133163; c=relaxed/simple;
	bh=w+SrR5E2JH9+hXfgQFtUFlkQAtNtXTw/JtvQbmbDgI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBgFueVin2Dj8bt+34+uxPesfgw3Fj1Ngqd359C2UDj/B4DnZnJ3jqoD8IrrJ0hRJXztnTDQl0kRqsLarzrqbX+09MtTffoCS1De6GS+JH+fMbn+M+0T5vVNM8kXX2whriz5++pShCZh29LxNFzcWFVq7R80/JDLGDCoEn+WOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p88ZX1vK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719132689;
	bh=w+SrR5E2JH9+hXfgQFtUFlkQAtNtXTw/JtvQbmbDgI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p88ZX1vK0LXjzMv9Cuf3tt6aYObE6RfqxXtI4UUCWNhDlS/8pUHs6gt6TGIhBRyII
	 piUqw4EzgSC5SJzS2SVOXyf+0NvY93HZQ7oeEaMX7hbKY4XRz8tJQPU3qihyA660ls
	 KnFOZBO4EQlpluBZmv5c9qrXmxOo6WA4YYudn7+s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 23 Jun 2024 10:51:28 +0200
Subject: [PATCH v2 2/3] drm: panel-backlight-quirks: Add Framework 13 matte
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240623-amdgpu-min-backlight-quirk-v2-2-cecf7f49da9b@weissschuh.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719132688; l=1413;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=w+SrR5E2JH9+hXfgQFtUFlkQAtNtXTw/JtvQbmbDgI4=;
 b=kObTJ0lXuxpRUDitaTT79l1LZGQynamMmqQkggT8nuu6Lxxyrp77H8ph0Vgw7YJBGZJoCCeqI
 HXJSPX3GUlCBx1Sh4goeIhsBO9tJ0ZcrMWYhTazIoelLw/0UaJwaF/U
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
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index a89b5fd1940e..e7671b1ba885 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -17,6 +17,15 @@ struct drm_panel_backlight_entry {
 };
 
 static const struct drm_panel_backlight_entry drm_panel_backlight_entries[] = {
+	/* 13 inch matte panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0bca),
+		.ident.name = "NE135FBM-N41",
+		.quirk.overrides.pwm_min_brightness = true,
+		.quirk.pwm_min_brightness = 0,
+	},
 };
 
 static bool drm_panel_backlight_entry_matches(const struct drm_panel_backlight_entry *entry,

-- 
2.45.2


