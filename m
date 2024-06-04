Return-Path: <linux-kernel+bounces-200692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1F8FB36F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA81F2198A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CBC146D5F;
	Tue,  4 Jun 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl/BmPMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3E1459E9;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507239; cv=none; b=XM99wAwKpohaZDdqaw0IQ32CQO2MKZmP5AAxpPsIVL44uWqQMRjdwHKTaBj7EJz5gTT4ymKwtolbgp8eu19ToeUyDsDDFYaOSW9xwJ6B+5x+GbLcA8mtEN7morpjuM9DfXDtQZEfDZG7uHW5+4GocEhBQ3ze+tqCn63rDmFqlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507239; c=relaxed/simple;
	bh=MOWZAwgoq9deQWVd/HKA2U6UFAXJnTWhKChG7nX2LNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qP0Wh8ONzJP2kLCvIM+VW1s78LIWfKp6SzturCWLUVOTMEmkmvng6IErSvCuq9r9cxl+ED62PlkPWiwiveMy9FBK8oNCzR/yzdTsfWyca6hbpWk82WvvMlHDbvi8GBjitgssOJsWbwrki8v3aXbVwAqVgx3yo8yHJHHrvsTj+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl/BmPMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AACDC4AF08;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717507239;
	bh=MOWZAwgoq9deQWVd/HKA2U6UFAXJnTWhKChG7nX2LNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dl/BmPMIUQxsH17b3Fsp/u59iHP/n1454A/Z7j8xe6dxIHusodNS70vZoYbYwUSkC
	 IqtgTDWYcdcb3nqa8ETSlrGqL2hMvz9bZDPwLtuWQtUkW5uAd597f0WGbBdunJ2Lb1
	 ycoSoUbORL3dY9YnstuSHOVEIjjtWyJUmdawbfD+UgMl9uN8DpElvEDO4w6d5TLtRn
	 tXv6jy6wvNd/B28PRrjx5VsclYorhPqLKR/WsFvBn5rz9ZpiIUmtuyA4a9rAUnQQNF
	 6fdMpTFGlwF2yngiYlvbeH8DvuciZ7v0Aev3tTL3Y9mGT1Sg4KrjChTT03RakABTZi
	 DqYaIC7He/KQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DBC27C5E;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 04 Jun 2024 15:20:30 +0200
Subject: [PATCH v4 3/5] drm/mipi-dbi: Make bits per word configurable for
 pixel transfers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-panel-mipi-dbi-rgb666-v4-3-d7c2bcb9b78d@tronnes.org>
References: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
In-Reply-To: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717507238; l=3211;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=rVzHuDjtn7Xw6fi36k+F3W4cyneNuZNHvALA/j7EnHQ=;
 b=5nLeRwMyrPxLtwlCGeWGNzmg1KQ7Y/QYi8B+PZGKSkc3S8X28UXh2jCdm0E2Ie+Tk9XQtDmHL
 4bjsy1k9XQtAmh7aGbcncI/9pvSw4VKyUtf7o2Ru4TJ3HngqRqMKwHH
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

MIPI DCS write/set commands have 8 bit parameters except for the
write_memory commands where it depends on the pixel format.
drm_mipi_dbi does currently only support RGB565 which is 16-bit and it
has to make sure that the pixels enters the SPI bus in big endian format
since the MIPI DBI spec doesn't have support for little endian.

drm_mipi_dbi is optimized for DBI interface option 3 which means that the
16-bit bytes are swapped by the upper layer if the SPI bus does not
support 16 bits per word, signified by the swap_bytes member.

In order to support both 16-bit and 24-bit pixel transfers we need a way
to tell the DBI command layer the format of the buffer. Add a
write_memory_bpw member that the upper layer can use to tell how many
bits per word to use for the SPI transfer.

v4:
- Expand the commit message (Dmitry)

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
2.45.1



