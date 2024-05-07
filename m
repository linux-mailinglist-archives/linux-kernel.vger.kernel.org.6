Return-Path: <linux-kernel+bounces-171048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90F8BDF29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E771F22415
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1914F118;
	Tue,  7 May 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDypvoz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453A14D45A;
	Tue,  7 May 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075868; cv=none; b=o9CEFHI/n84O+6Tdi4hmSJW6j4AXZ+lvlNd4kk1jeT5U/cnpspumTQ5pH03+wcN1tL6IpZep2nlA9TGgnaCMFXj1bFt4Kp2XZkvfe4Pq4UzxoGBbDQkUbn6E0xCqwINs9xmgvK2jqHAV5WqoT3GlxzV97PhCPX+/F5Fw6JqtgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075868; c=relaxed/simple;
	bh=9Q7FX+bi2hsHAUuIvpT+48xO8EBaKLzZBmZKdjo3YBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTwF05EI31cPNk2jUlYzr0YAExfQRl+lN1X4hHdXZ6faL8wDLG2b4X1qBTEIOayJwtwGsOSGBrbKKBuzQVGV2H3+XLP1xq3/o6qEFwsmuVsvSXRgUK8DJqqIvvQhaMT4OvVcniTTEZ1zheYvWOVQ7rKfBVILvDllQrY4cBLnIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDypvoz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB58DC4AF68;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715075868;
	bh=9Q7FX+bi2hsHAUuIvpT+48xO8EBaKLzZBmZKdjo3YBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mDypvoz7p3P2oKLfxvM6cC3ZqJxlF4RlGfpI7a3GG9RVN6+3kGT2vTnqQRqBw0Jk4
	 aZAGLI64jnQAFgEBd7ovNtvjqKjjLmKkjoFP5JgRErrlw3icjzI+r7vfaZEcXRzV+n
	 ReuhOQYX75rzexvYZisnAoCuzT8r5I9r+sBpaOh1Y20NL09NQkvxWqINQikdnBr7eI
	 b5GrbcBuFfv6BsE14D2lwQDRJervpqlBYHC3wi0KQWzKBLu48opp8E1ap02wF3S+qp
	 IlEP2YLxCs9dW0J282nUT7CYYFzN+wsuDtHYCenAGypPw435Bzi+euKvbagXCWCf1K
	 oiNUBUW5kC38g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327CC25B76;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 07 May 2024 11:57:27 +0200
Subject: [PATCH 2/5] drm/mipi-dbi: Remove mipi_dbi_machine_little_endian()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-panel-mipi-dbi-rgb666-v1-2-6799234afa3e@tronnes.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075866; l=4005;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=o8822dmDCmIZ+eXgpabob1UA7CmuRC6Tz8lk2h5f5EE=;
 b=lmr4tphmyNtLKC7K87R63vysFyre98c/QZxZ85gUYXuOO6Mt6cMhyVvDVoCC6pr0ou4qFXeV5
 Eh7YmOfHCHCAgzJzyD8OsBCZt+qo1/GMZxreUsyPDZwS9mg84XNztDB
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

mipi_dbi_machine_little_endian() should really have been called
mipi_dbi_framebuffer_little_endian() because that's the function it
performs. When I added support for these SPI displays I thought that the
framebuffers on big endian machines were also big endian, but I have
later learned that this is not the case. There's a bit in the fourcc code
that controls this: DRM_FORMAT_BIG_ENDIAN.

Just remove the function to avoid confusion. We can add big endian support
later should the need arise and we have hardware to test on.

Instead of just amending the docs, expand it to explain the endianness
handling.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index daac649aabdb..fa8aba6dc81c 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -824,15 +824,6 @@ u32 mipi_dbi_spi_cmd_max_speed(struct spi_device *spi, size_t len)
 }
 EXPORT_SYMBOL(mipi_dbi_spi_cmd_max_speed);
 
-static bool mipi_dbi_machine_little_endian(void)
-{
-#if defined(__LITTLE_ENDIAN)
-	return true;
-#else
-	return false;
-#endif
-}
-
 /*
  * MIPI DBI Type C Option 1
  *
@@ -855,7 +846,7 @@ static int mipi_dbi_spi1e_transfer(struct mipi_dbi *dbi, int dc,
 				   const void *buf, size_t len,
 				   unsigned int bpw)
 {
-	bool swap_bytes = (bpw == 16 && mipi_dbi_machine_little_endian());
+	bool swap_bytes = (bpw == 16);
 	size_t chunk, max_chunk = dbi->tx_buf9_len;
 	struct spi_device *spi = dbi->spi;
 	struct spi_transfer tr = {
@@ -1004,7 +995,7 @@ static int mipi_dbi_spi1_transfer(struct mipi_dbi *dbi, int dc,
 		size_t chunk = min(len, max_chunk);
 		unsigned int i;
 
-		if (bpw == 16 && mipi_dbi_machine_little_endian()) {
+		if (bpw == 16) {
 			for (i = 0; i < (chunk * 2); i += 2) {
 				dst16[i]     = *src16 >> 8;
 				dst16[i + 1] = *src16++ & 0xFF;
@@ -1218,11 +1209,23 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *dbi, u8 *cmd,
  * If @dc is set, a Type C Option 3 interface is assumed, if not
  * Type C Option 1.
  *
- * If the SPI master driver doesn't support the necessary bits per word,
- * the following transformation is used:
+ * If the command is %MIPI_DCS_WRITE_MEMORY_START and the pixel format is RGB565, endianness has
+ * to be taken into account. The MIPI DBI serial interface is big endian and framebuffers are
+ * assumed stored in memory as little endian (%DRM_FORMAT_BIG_ENDIAN is not supported).
  *
- * - 9-bit: reorder buffer as 9x 8-bit words, padded with no-op command.
- * - 16-bit: if big endian send as 8-bit, if little endian swap bytes
+ * This is how endianness is handled:
+ *
+ * Option 1 (D/C as a bit): The buffer is sent on the wire byte by byte so the 16-bit buffer is
+ *                          byteswapped before transfer.
+ *
+ * Option 3 (D/C as a gpio): If the SPI controller supports 16 bits per word the buffer can be
+ *                           sent as-is. If not the caller is responsible for swapping the bytes
+ *                           before calling mipi_dbi_command_buf() and the buffer is sent 8 bpw.
+ *
+ * This handling is optimised for %DRM_FORMAT_RGB565 framebuffers.
+ *
+ * If the interface is Option 1 and the SPI controller doesn't support 9 bits per word,
+ * the buffer is sent as 9x 8-bit words, padded with MIPI DCS no-op commands if necessary.
  *
  * Returns:
  * Zero on success, negative error code on failure.
@@ -1257,7 +1260,7 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
 	if (dc) {
 		dbi->command = mipi_dbi_typec3_command;
 		dbi->dc = dc;
-		if (mipi_dbi_machine_little_endian() && !spi_is_bpw_supported(spi, 16))
+		if (!spi_is_bpw_supported(spi, 16))
 			dbi->swap_bytes = true;
 	} else {
 		dbi->command = mipi_dbi_typec1_command;

-- 
2.45.0



