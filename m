Return-Path: <linux-kernel+bounces-249223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F292E8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F8281914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3C15F30D;
	Thu, 11 Jul 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mba9LSHj"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FC15ECE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702831; cv=none; b=jvdH1UN2PB0mssdENhYp6rhHnjE1500eB23iK2prU1PtiuRwc8fVrFl/H9jE1v/lFtHq8nwo24/j83JdaptblFVJkB0glQMgm3AlWBvw5fMRvjBqOlP9dYmcmvwHRFDnPalwhSlmajBHj7wkpCuYcxL4I2lWCenLa9xdrPPGx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702831; c=relaxed/simple;
	bh=yDfyY8snkJSmluAtxiaEP/s2vlNRcQJPO6SAUBJaRIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOu0Qjwe794fuvjA85Q8CrTp7zLjeSwj6VlKeOgRkyx3rUl7JdrC3GQjtagktTiHdyY/C6CaIh/WR71UljnGpNgdqKLcgK2cH1Tg/MFaEOLfKmO4o/UPkscOWXVJa8E4XWpgx0GauYv31SmirQrJ9v3WN63JWQ5nPqXPP8J9aL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mba9LSHj; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d+8V3/rKaunu+zG+Ahpl7K1m4zxvyurqkU+URN+F9Hk=; b=mba9LSHjnOmPPJUiaW2yasyzp0
	44oiDVzH1IhYeGMMPxR95O5L1ZbL0jQtQ/mZ+QHy9DIpvZCnCAUfET2OJdBM3AjnPOlktgB+SzQSA
	iDyqwQTbC45hXNmTv5+Zaq31N7cZuxYgQ5I7wDDz/M0eVt4Ab8DZWHmYC4608ULy0bO+kcFgnOJ2b
	v6PiFp3j0Nsgk0QP+cD3J0ic/uCbP2acI9vUcwuviZ0EM5QbBOn9ODg9UvkIXfG3p4aL2aV+P1p/V
	25NJWrvWQYa5zI8Dv/JAv2joEpij/dbWIaIXhHChWDZmrDEGrSxscW5Vta5P6oveladSfBqjf+WUR
	UuByuKOg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPI-000BT5-3v; Thu, 11 Jul 2024 15:00:20 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPH-0003ON-2S;
	Thu, 11 Jul 2024 15:00:19 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:05 +0200
Subject: [PATCH v3 05/15] mtd: spi-nor: eon: Use new SPI_NOR_TRY_SFDP flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-5-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=1530;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=yDfyY8snkJSmluAtxiaEP/s2vlNRcQJPO6SAUBJaRIQ=;
 b=L3n3Tl5TJSue3j3s7PtAlTmOF8/qAmNf1K3er6bHO/RBI9LcjRtBeEuzJfswXoZFabE+FLt2W
 9D4pUeTqnHpCq/UQX7TQExnpe6Edt4rJ3g2yPZQ+CbidyERSIj+R06D
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/eon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index c1ddf662f782..0200e564f087 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -21,7 +21,7 @@ static const struct flash_info eon_nor_parts[] = {
 		.id = SNOR_ID(0x1c, 0x30, 0x14),
 		.name = "en25q80a",
 		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x1c, 0x30, 0x16),
 		.name = "en25q32b",
@@ -45,7 +45,7 @@ static const struct flash_info eon_nor_parts[] = {
 		.id = SNOR_ID(0x1c, 0x70, 0x15),
 		.name = "en25qh16",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x16),
 		.name = "en25qh32",
@@ -54,7 +54,7 @@ static const struct flash_info eon_nor_parts[] = {
 		.id = SNOR_ID(0x1c, 0x70, 0x17),
 		.name = "en25qh64",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x18),
 		.name = "en25qh128",

-- 
2.45.2


