Return-Path: <linux-kernel+bounces-249227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1792E8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448551F23798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7315FA8B;
	Thu, 11 Jul 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZRhYbAib"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D21E504
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702831; cv=none; b=OR63z8O32uhHUkEBolu3fcvtvnpYIvXUuetZzOwRLQfXIjdS68woOB07JDgmgpbyK9XW8LX3AKEvdo1PpQr+OmeWxZxObEV2+kLun8hErnHAhveYlI/9BC+WmcorrXTi2e+bQCW5mEw/LKnU27NgI/5tj0+03/+uudZ3vtKWEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702831; c=relaxed/simple;
	bh=6MX4eIXlY3UWuzb6ohIZb1wVqVRypjimxT99p/j9DBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOqZ96uk2vq3JXbZExdQZDfpUKUSJfyoCxuXPXCazfSquOZ3vkbBmYKn2FCrLa+IYEtk+8gvK2BCSDTpTt+4Glm07MVOseObnj/qteO/LytVIs22oaAzN2Z4k6WK3f+812osS8Y1jIlDlm4Zn1tsGaX3rd3A6uExiEv/HwBEnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZRhYbAib; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ppLgZmwRM8c0ykYORNd+WlBtKewamkLLMhiNg/fbsuE=; b=ZRhYbAib1qUkcon8Opsf/ifyr/
	YdGWlMHigua8wC8qvfybG2XIK5K2am7oUnyVNX0jBu7XR7hQPCnM8ld8pEtsSM4abBmzs8yr75FIB
	2sfRkehEg2qPOG1t6xB9SgzSn0ZTO5ITCc9lRozXl39V4VUZhoGBIdJVM5r+mWHGzzyVorsIMixdh
	2rpq4F7U2X/TFHiHJpR9rCViec66pnDSRsSqkg6YpB/xnw3yiK2nB8i3ovo4/71Zq5Y2+QL6ci/M0
	b+SQbfFtVlWYLbR1UG1rdZBviYe0b4DPPI8jb407BdwM3ZuQKu0gzLK3lL09NdQbOwcd2xaEqXH3l
	qyDL+aMQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPI-000BTD-Q2; Thu, 11 Jul 2024 15:00:20 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPI-0003XS-21;
	Thu, 11 Jul 2024 15:00:20 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:06 +0200
Subject: [PATCH v3 06/15] mtd: spi-nor: gigadevice: Use new
 SPI_NOR_TRY_SFDP flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-6-99353461dd2d@geanix.com>
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 linux-arm-kernel@lists.infradead.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=3015;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=6MX4eIXlY3UWuzb6ohIZb1wVqVRypjimxT99p/j9DBc=;
 b=R+4tYMKNX3qUqddrsczMwsqlbiLfxg1IA2r7g6QcfsfYTa9tNVQ2bA2iIUTf1VjKNPrYf7Kp+
 kEIMgmxqmCHDmqOOHNh6hffL5zJ0rRETZ/VdCnZ2naWjYDH3MvRJlCn
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index ef1edd0add70..c0f2d74ede01 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -39,29 +39,29 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.name = "gd25q16",
 		.size = SZ_2M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x16),
 		.name = "gd25q32",
 		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x17),
 		.name = "gd25q64",
 		.size = SZ_8M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x18),
 		.name = "gd25q128",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_TRY_SFDP,
 		.fixups = &gd25q256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
@@ -69,19 +69,19 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.name = "gd25lq32",
 		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x17),
 		.name = "gd25lq64c",
 		.size = SZ_8M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x18),
 		.name = "gd25lq128d",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	},
 };
 

-- 
2.45.2


