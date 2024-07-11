Return-Path: <linux-kernel+bounces-249233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3F92E8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173F01F2398C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899C16C858;
	Thu, 11 Jul 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CSxwaAAb"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D816B751
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702838; cv=none; b=KiCtcMiNA/6oAhidhzMcYIwOmJ/6Easy85ab3wpzbcph7TJ5JoJRyerDb3z/5S+pk3DO0FD3ygCV9N1bypOHXI2JqOvrmsA0JFMcJ1yQQyN+l2cFwbWUCZuT4S7/rGxG7GHofLdNfbSOpavvaxLhHFiGLEAvD5decFdj7/Bj7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702838; c=relaxed/simple;
	bh=fAIpiW/bdt8BU9xFIQGA8empyKumWS0/y9ClBynUg70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhsyU19O349kIAA0Jt89Q+hwfoM4FMPVs662BYv2mObig8enoImEZPUa0wbTJyPCsM2avV+lcQm3BF7XQwV7W3ie1ItlzhPvVl1cT4r1jknEUodqBDvuhHD6WZjIxNUwWGhzMQuJT30TjkwBVK+6EmybDDkByRxcNjgn5PQKdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CSxwaAAb; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7IfeIKnf8bb4+3ONceR0JYXiJvxgBdavyiSexx2x3/E=; b=CSxwaAAbj32Y+GsD6BG2MpjGGS
	HKL/j4+VK7/NNfUXdhBMzMtl5w3nBpZE6p75ciCERwR8ojpGE7z+Ou4X8g+gJKqfmoeW8/InYzImg
	0dbWiv3ZUut2ZXmmJtb1lExRSN33VmBxkTY85W6By/ba7UcxGDTyg3fDoA8dghBtHeWQjQN4UoUpM
	KzresWG90ll7T2O/MYx1fkrp/W862j5CrUrrDRswGHsZh10jcYPTI3GYDK6Up8hfygZ9uIc67YNci
	k86bQUhXNK4cU33YWxbFCJxGa3t2inuuBoiiAxy8JKzv79eXWJ+1OnYXOPfpANNRFRzUc4p60NYhi
	Wir3vFjQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPQ-000BVR-CG; Thu, 11 Jul 2024 15:00:28 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPQ-0004aF-0S;
	Thu, 11 Jul 2024 15:00:27 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:10 +0200
Subject: [PATCH v3 10/15] mtd: spi-nor: spansion: Use new SPI_NOR_TRY_SFDP
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-10-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=7219;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=fAIpiW/bdt8BU9xFIQGA8empyKumWS0/y9ClBynUg70=;
 b=exjvJVt+ssM+J2waBaGaAT5g6AHzwq1ZKSYzDh24d228YMqcvW2cBp2EXGuNOYNE5fE+xMngx
 a01LEHK3myxALe3mDmFZEU1A47TdR0DLlyCgPMygU8SSgOlah5EJqat
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/spansion.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6cc237c24e07..a58c0229003d 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -774,7 +774,7 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x01, 0x02, 0x15, 0x4d, 0x00),
 		.name = "s25sl032p",
 		.size = SZ_4M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x15),
 		.name = "s25sl032a",
@@ -783,7 +783,7 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x01, 0x02, 0x16, 0x4d, 0x00),
 		.name = "s25sl064p",
 		.size = SZ_8M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x16),
 		.name = "s25sl064a",
@@ -800,19 +800,19 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s25fs256s0",
 		.size = SZ_32M,
 		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x80),
 		.name = "s25fl256s1",
 		.size = SZ_32M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x81),
 		.name = "s25fs256s1",
 		.size = SZ_32M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x80),
@@ -820,14 +820,14 @@ static const struct flash_info spansion_nor_parts[] = {
 		.size = SZ_64M,
 		.sector_size = SZ_256K,
 		.flags = SPI_NOR_HAS_LOCK,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x81),
 		.name = "s25fs512s",
 		.size = SZ_64M,
 		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 		.fixups = &s25fs_s_nor_fixups,
 	}, {
@@ -844,49 +844,49 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s25fl128s0",
 		.size = SZ_16M,
 		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00),
 		.name = "s25fl129p0",
 		.size = SZ_16M,
 		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x80),
 		.name = "s25fl128s1",
 		.size = SZ_16M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x81),
 		.name = "s25fs128s1",
 		.size = SZ_16M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 		.fixups = &s25fs_s_nor_fixups,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01),
 		.name = "s25fl129p1",
 		.size = SZ_16M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x40, 0x13),
 		.name = "s25fl204k",
 		.size = SZ_512K,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x01, 0x40, 0x14),
 		.name = "s25fl208k",
 		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x01, 0x40, 0x15),
 		.name = "s25fl116k",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x01, 0x40, 0x16),
 		.name = "s25fl132k",
@@ -901,19 +901,19 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x01, 0x60, 0x17),
 		.name = "s25fl064l",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0x01, 0x60, 0x18),
 		.name = "s25fl128l",
 		.size = SZ_16M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0x01, 0x60, 0x19),
 		.name = "s25fl256l",
 		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0x04, 0x2c, 0xc2, 0x7f, 0x7f, 0x7f),
@@ -985,22 +985,22 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x40, 0x13),
 		.name = "s25fl004k",
 		.size = SZ_512K,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x14),
 		.name = "s25fl008k",
 		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x15),
 		.name = "s25fl016k",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x17),
 		.name = "s25fl064k",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}
 };
 

-- 
2.45.2


