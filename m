Return-Path: <linux-kernel+bounces-199037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FFE8D810D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454B61C21D62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5C84DFB;
	Mon,  3 Jun 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TorMvBC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0301366;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413716; cv=none; b=B9RglZOZD5fI9J+l3Rbnu1TR/Phd01b0nfE3/wcOT9B+deiv+QiPIabApl66tN59yyJhIZq5ibB0t5anrerLMPG2pmwToe+LMCe8cBE7xITr82+6+YS74BcAFmTemmIkJ7cWuzF88xZJdWAxL/NQgxuiqtyTI98zJEJjL+fTiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413716; c=relaxed/simple;
	bh=7UX3J5e5E3yJhVnzO2R0Knd3rHf/1Fq06HVnhnimb4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cb88602NE4NFNkZPOTy5zZ8eHwzOPnciVjs1S7Bb0Ob6+ZtT+PdmvkizThF5XZHUzOsAXc3+FipeZKPkv7kLPPSuDB0hns2Qr1rd/vhjMxJWh28dwXTCpDRZ6fGZDd7rKVW+DYIFqttUuCSBpFItYtEJfAhgOvbkjAsCK73h6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TorMvBC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0391C4AF0C;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717413715;
	bh=7UX3J5e5E3yJhVnzO2R0Knd3rHf/1Fq06HVnhnimb4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TorMvBC/jBXbL5/e/ChgBGUV/j8nhzDH6eDtACzDJu9JJ/WA5Lyz2g5EmUwkcijJM
	 jc6q8aDmdM1cdcTW5XjB8fIItfkmIMh+BOb8yAI/3pvlO+flMsOkgwpUg3NxcAu1yl
	 bqLBKHwPwFHsy0fXUgAPx/NZm1p2kCQAgrIbtWRHJ5mpeBYRhHE/OW2K39pVK7pWuy
	 DGAiq0ybGxW+LMdqoK+NbFEQjeh4CDNW8VrA1028Oi9JB5H4d3FoxfEI3HsAnOj+KD
	 aydUR1Mr0xVw6U05n8+8LsRyHKQZCLsUfKJTdqjyJ5zsDE0qKUF6oLsPypOx2IvqCM
	 FJomMEejG1iJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8051C25B76;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Mon, 03 Jun 2024 13:21:34 +0200
Subject: [PATCH v3 3/5] drm/mipi-dbi: Make bits per word configurable for
 pixel transfers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240603-panel-mipi-dbi-rgb666-v3-3-59ed53ca73da@tronnes.org>
References: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
In-Reply-To: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717413714; l=2428;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=2flwvCUCMIpaCCor65BL4jAzjD5dEqEbPGB1PCkTkDg=;
 b=VmTUnh6jvTrxK39T+su2w9JqEXLPGMzKwnuczuySvYQ05IYdjdUMISTb8ePvGcKRgTcdzTo5f
 R9SwqlY362fA4+XK2eYx1pY7DowaXaK7fjm6x2khLWWcfHFH2jiAbGP
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
2.45.1



