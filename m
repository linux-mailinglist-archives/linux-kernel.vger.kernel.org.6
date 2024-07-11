Return-Path: <linux-kernel+bounces-249228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7692E8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138B1285AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459D168C20;
	Thu, 11 Jul 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="z23R1L0o"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C615ECE6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702832; cv=none; b=ZYj7bsvBdyv1GPH1yamSZdVHgpVOsLGfTuth/3tkkQ2As6Nl+i2w+wkWfogEpTHH/DNLtMOX6SMGI9xdZ4YChs9B94VnCqMEBCcJbt78/a3Y1c4+H0pjEr6+OMF8OuQSfHkcQn7cUFBov3GVc32kNx88S3thRbba7k6CptnLmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702832; c=relaxed/simple;
	bh=Ob5pJLtErmzw/PEIKu46fWtb7DMNCAxcd8QknAftFds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJ3uAQjop6MWygR7C4mBaAbQswJE6VW+1I/bh+ax1b76QCeti5bXL+AI0/1yRALrafGfGsAqtPIEjpr0uoDI5UUUvi3Sz7Cz+eqaI4up82WMqVvGO2owu4kxvSkf1EfbLNO/eTlYlsq/1s0TjoqFaY1Vy9oM6XbDAfTQkIniXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=z23R1L0o; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9ZrZJLS1DLB4jv/UMX2sL8nP6E/alEgCBVlU2XvWCHA=; b=z23R1L0o1zjmTbzlPIwov0PFJE
	lhi3iMgGLOiRExSNJDqSnTD3PDgq1PBhKeUKBvBvBmdCtPkWha60fArzZMVYNhoCeYponQcAQwnjJ
	lSEPGEtqRLnRVt2NZ6cxC9bCzl5DWPfv0ynlguI9P4SZcly/4e6xxRbw4VB0Gu8KI78eeeTpnIHV3
	25Q9oreBwE0Ty/EF4Oob+TBLqJET/GWsoy/U5NSeOStw1PuGinvO8HIb5nNYbEnaTroeIUdt6gDX1
	To60aVZIm7yM/zj7Qdzc5R2nHuGTrxde+R/MDNwgVYEawc7USc4PAn9cLgVtJy1/szkH1zUREV6gu
	J3Kke4uQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPH-000BSd-6S; Thu, 11 Jul 2024 15:00:19 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPH-0003Iu-06;
	Thu, 11 Jul 2024 15:00:18 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:04 +0200
Subject: [PATCH v3 04/15] mtd: spi-nor: atmel: Use new SPI_NOR_TRY_SFDP
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-4-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=904;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Ob5pJLtErmzw/PEIKu46fWtb7DMNCAxcd8QknAftFds=;
 b=6fpJfGaww/bYkfwhAzRE1TJ6E/AkqJ+9CFbDEezK6EgmHnXqdB0LfnfLFFgSoNyg5MTiHE6oh
 j3/VXzy6xVECOYw4rWOFcavu67K0J/sHILjlLRXjVwzy/w0zqWAFybe
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a0..cfd6a406b33a 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -175,7 +175,7 @@ static const struct flash_info atmel_nor_parts[] = {
 		.id = SNOR_ID(0x1f, 0x42, 0x16),
 		.name = "at25sl321",
 		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x1f, 0x44, 0x01),
 		.name = "at25df041a",

-- 
2.45.2


