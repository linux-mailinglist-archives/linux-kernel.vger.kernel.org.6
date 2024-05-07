Return-Path: <linux-kernel+bounces-171047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CD8BDF28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C872A2815AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5014F10D;
	Tue,  7 May 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFxWPZ2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E914D43A;
	Tue,  7 May 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075868; cv=none; b=dID759tLvdO1xS6vxigF4Yf31xxzRD1akmJ3KE9Z3+5wCeTEQo2wbWQ7R2RLYTdXODEEJ1qlcLDxkxkMtFrCMICYrtkn/2fukfQMo/fk4fRkFiui0ZwTf4Q3TV9vChmBqqk86edUmU2DvMryrt+8XtzmYmjuxgAsMV7Zl/EqNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075868; c=relaxed/simple;
	bh=pzTBdFsY2vgyd0djOYwWeG/Np5eTTYFhGJ8Nr6OdFJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYVhhgTrTRT49GPq36pjB6TOLV1Z/I1WBm9IxBshzsdz06wD8p3sYJeQ7o+XcUo4cOF9TZwdPkMtE93EDeKbcGd9em4G30cyP23s96lUNcX7Lx2vk3awplwO3KSgLp8qAXf/WVHAFbci76zlZL2jbWWu0gL2zjS0a29dL++xWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFxWPZ2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E187CC4AF66;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715075867;
	bh=pzTBdFsY2vgyd0djOYwWeG/Np5eTTYFhGJ8Nr6OdFJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AFxWPZ2fp+Z6sTgKBaiBUWV68awA9EUHBXENPp+wFaGbg5RPD6GqYC2J1KgLkvplZ
	 K0pgBKiOCBnbXrOoFAFSiFeiT/KMTa+f38RvUf+o5Fv+Z0/WnhKI4hy6U7OfWOGHsK
	 RyOXwlsSHidf8bEoLeAUjNeyuMQ2yUQjzVSdyyf5S6m580rbKy3xDKIPbcFbMiLCqP
	 DYQu06TyYp1l+W5CrNCgk1AOxFI2wDSB8O8YD++R9Ywpru6Nbe2pSaavmU6AyYbBnW
	 +qnQkVyf5A4F5jwhAKqAMqGhdvQK/UpM3Nz3pEnaKl2l5i33t9EKrlpbnkK2TsER8U
	 0Ne06co0sEGuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED6EC25B75;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 07 May 2024 11:57:28 +0200
Subject: [PATCH 3/5] drm/mipi-dbi: Make bits per word configurable for
 pixel transfers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-panel-mipi-dbi-rgb666-v1-3-6799234afa3e@tronnes.org>
References: <20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org>
In-Reply-To: <20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075866; l=2428;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=AmIGEMAdFZS+jdfkVlUhkfNHhhJJe5S4I+SgbI8FWNw=;
 b=dH2Eq2uELApFf98ZDX+iNqOc1vXH63r1yF/PM5SgZ9A4UUy52uTb7G+iciJqmjPJoZ1VV5FF7
 bfunytxnw6EAELcMaL3m4i+n4SaEqgYHMtk6BOWva5Tnb1HwdY/nkrA
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

This prepares for supporting other pixel formats than RGB565.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 14 ++++++++++----
 include/drm/drm_mipi_dbi.h     |  5 +++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index fa8aba6dc81c..77f8a828d6e0 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1079,7 +1079,7 @@ static int mipi_dbi_typec1_command_read(struct mipi_dbi *dbi, u8 *cmd,
 static int mipi_dbi_typec1_command(struct mipi_dbi *dbi, u8 *cmd,
 				   u8 *parameters, size_t num)
 {
-	unsigned int bpw = (*cmd == MIPI_DCS_WRITE_MEMORY_START) ? 16 : 8;
+	unsigned int bpw = 8;
 	int ret;
 
 	if (mipi_dbi_command_is_read(dbi, *cmd))
@@ -1091,6 +1091,9 @@ static int mipi_dbi_typec1_command(struct mipi_dbi *dbi, u8 *cmd,
 	if (ret || !num)
 		return ret;
 
+	if (*cmd == MIPI_DCS_WRITE_MEMORY_START)
+		bpw = dbi->write_memory_bpw;
+
 	return mipi_dbi_spi1_transfer(dbi, 1, parameters, num, bpw);
 }
 
@@ -1184,8 +1187,8 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *dbi, u8 *cmd,
 	if (ret || !num)
 		return ret;
 
-	if (*cmd == MIPI_DCS_WRITE_MEMORY_START && !dbi->swap_bytes)
-		bpw = 16;
+	if (*cmd == MIPI_DCS_WRITE_MEMORY_START)
+		bpw = dbi->write_memory_bpw;
 
 	spi_bus_lock(spi->controller);
 	gpiod_set_value_cansleep(dbi->dc, 1);
@@ -1256,12 +1259,15 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
 
 	dbi->spi = spi;
 	dbi->read_commands = mipi_dbi_dcs_read_commands;
+	dbi->write_memory_bpw = 16;
 
 	if (dc) {
 		dbi->command = mipi_dbi_typec3_command;
 		dbi->dc = dc;
-		if (!spi_is_bpw_supported(spi, 16))
+		if (!spi_is_bpw_supported(spi, 16)) {
+			dbi->write_memory_bpw = 8;
 			dbi->swap_bytes = true;
+		}
 	} else {
 		dbi->command = mipi_dbi_typec1_command;
 		dbi->tx_buf9_len = SZ_16K;
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index e8e0f8d39f3a..b36596efdcc3 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -56,6 +56,11 @@ struct mipi_dbi {
 	 */
 	struct spi_device *spi;
 
+	/**
+	 * @write_memory_bpw: Bits per word used on a MIPI_DCS_WRITE_MEMORY_START transfer
+	 */
+	unsigned int write_memory_bpw;
+
 	/**
 	 * @dc: Optional D/C gpio.
 	 */

-- 
2.45.0



