Return-Path: <linux-kernel+bounces-249232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F592E8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22994B28016
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425B16C846;
	Thu, 11 Jul 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NJAPg+nu"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEF16B3B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702838; cv=none; b=B50ggC4t5VEwp5y7SspXgQMGEskA7kKE+ehIapOafyU6o2tB2uyYp0jQTU7sWVFh6Ed439a4TZi6p3KMiWMqwKZfvPfLIaczLs5N8DXAzUUvogSi4eeHd7U5x7bnq7cDLxJgs60tb4OoIWP7yW3zQiKEB8woE9kUhe5HPOp67hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702838; c=relaxed/simple;
	bh=8gRxmjbNJOt6+hI1qXw+SxmSI/YFHve+jCyTXkZDUNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXDHytIyTtk3kfNaf9Qm2DkPIgHOgpVcTE0IZkg1f8C8c/5nfr7Gw3cpJj2nfWZZvEU6UpnFBER1VAEqMCZ+ccDcKymzSw3bQb0BoAB2OOAL39vLVbBSHRhxS799pa3BTJB8l+GgTDkZ4qhjWwsuH82EbQwkgELF38OIUhGsQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NJAPg+nu; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6Udo75OjxMB/GImXQS4AFYjVsw/wVAePEtyqQJPRUb4=; b=NJAPg+nu9OiKm4SUoX2pf7ZF0g
	5QQNBl7mPeyukQ7zWMWyoY/WKkwUBzp/l+SewpZkbAOH60X4S6Dd7GuPpFX2eyQDn5FLwuvYZXOmj
	ChuLz7+vYYeGGfqI6Z86MdlftUNDWfYsfGM/QW8LYXqvzI17oFFdRnYmQFbf1mhOUit3sJtgeIrgX
	3Fxb0eMam7Ecoww4STzELhmr4MS+PpK51po6Y/Fo2Qap2fqpCmzzY9/OaNTulWGmp2fMfk4+aYR2+
	NDEnIupBPOM2ENS66bZVy9i+0AmPI1V1aiTUR2iFkbJGeukGQOIYc9BVx5RTZK6t3W9LMUBOU4Pj/
	WVeaptPg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPP-000BVF-Mo; Thu, 11 Jul 2024 15:00:27 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPP-0003my-1c;
	Thu, 11 Jul 2024 15:00:27 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:09 +0200
Subject: [PATCH v3 09/15] mtd: spi-nor: micron-st: Use new SPI_NOR_TRY_SFDP
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-9-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=6842;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=8gRxmjbNJOt6+hI1qXw+SxmSI/YFHve+jCyTXkZDUNI=;
 b=xaFoGar83fLOcfyMUbhb096+1G1ELXt+OevuCtRGTnEF+V+0NY7avO0ZwWxCcb7qt/1kcl8UG
 zeAl5FRakuYCm30WJ0mfrYOnw/5K5FmAKd9WwFF9Bs5PuC+g5BUIZfJ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/micron-st.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3c6499fdb712..c40e02b4f030 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -166,7 +166,8 @@ static const struct flash_info micron_nor_parts[] = {
 		.sector_size = SZ_128K,
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ |
-				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP,
+				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP |
+				 SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
@@ -175,7 +176,7 @@ static const struct flash_info micron_nor_parts[] = {
 		.name = "mt35xu02g",
 		.sector_size = SZ_128K,
 		.size = SZ_256M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	},
@@ -364,38 +365,38 @@ static const struct flash_info st_nor_parts[] = {
 		.id = SNOR_ID(0x20, 0xba, 0x16),
 		.name = "n25q032",
 		.size = SZ_4M,
-		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x17),
 		.name = "n25q064",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x18),
 		.name = "n25q128a13",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x19, 0x10, 0x44, 0x00),
 		.name = "mt25ql256a",
 		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x19),
 		.name = "n25q256a",
 		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x20, 0x10, 0x44, 0x00),
 		.name = "mt25ql512a",
 		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.mfr_flags = USE_FSR,
 	}, {
@@ -404,7 +405,7 @@ static const struct flash_info st_nor_parts[] = {
 		.size = SZ_64M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x21),
@@ -412,38 +413,38 @@ static const struct flash_info st_nor_parts[] = {
 		.size = SZ_128M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixups = &n25q00_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xba, 0x22),
 		.name = "mt25ql02g",
 		.size = SZ_256M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixups = &mt25q02_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x15),
 		.name = "n25q016a",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x16),
 		.name = "n25q032a",
 		.size = SZ_4M,
-		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x17),
 		.name = "n25q064a",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x18),
 		.name = "n25q128a11",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x19, 0x10, 0x44, 0x00),
@@ -451,14 +452,14 @@ static const struct flash_info st_nor_parts[] = {
 		.size = SZ_32M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x19),
 		.name = "n25q256ax1",
 		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
@@ -473,7 +474,7 @@ static const struct flash_info st_nor_parts[] = {
 		.size = SZ_64M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x21, 0x10, 0x44, 0x00),
@@ -484,14 +485,14 @@ static const struct flash_info st_nor_parts[] = {
 		.id = SNOR_ID(0x20, 0xbb, 0x21),
 		.name = "n25q00a",
 		.size = SZ_128M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixups = &n25q00_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x22),
 		.name = "mt25qu02g",
 		.size = SZ_256M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_FSR,
 		.fixups = &mt25q02_fixups,
 	}

-- 
2.45.2


