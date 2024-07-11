Return-Path: <linux-kernel+bounces-249236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6692E8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC223281691
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EEF15ECFD;
	Thu, 11 Jul 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CJxJgiH3"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931E16CD30
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702845; cv=none; b=aKFuzhUBpvco1LyK+Io8k9TJsDWQsW1UivJAwJgm+RdpoFEl6TKK9RSbJPtGPvvpayz2MizJ3DKZn2oZ023RC/RWqbbqTBINOaapHzWPK8PtE9TXzUHizusqxhF7V0n/l+uc/X7wyJK0p/FP9WYROlntoIXGurQsEPVh6zeyWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702845; c=relaxed/simple;
	bh=6sGOeGBjWQoa+lKaakmKJY3XXQ4BYB11RN1yRi3xMDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ww9vFzTIY8AGnC8ml2LBOeUoIABrcTlu86jT672DqGgHSWm9TPbPH41HilZdLBX3cHsmsVGG/pjAH1weyuSF/2QubSf/JMU7uUEPzRtw1Xlor4R650Z2GsEWxmqgsdGwqft937cMNkUjujQ4C8NkH3hlu1SpTxRr84pJtbZ5/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CJxJgiH3; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VUnP2F/GhNUBOAuGa/ZijGN9c4b7Ttg6SmdiH5XFDG8=; b=CJxJgiH3zo1A5oMh69WWXFdZ/v
	MHVbhtiVYEwh2F/8gqFySyxDCzki0bxQmCXz8egSkMfn7kz/5MppbhqRrj4BqHmZPRbcwQ7lGF9mz
	99xTgU2N1bM/9nees3Ay2zl9rQAJuimmqcYVaZwAIMsA+SIkW16/JjUl0A0Qz2QCRJJApzEUXfs7u
	UN6le3h+E78Ehf6OjSt9PEkS5r4z21jEo0SR1e6WBT6xVVakn+cdAqtchINTDfw7BCH8MafDqk1ZX
	qnSqzCxfDqUT5qeeQ3U9H4u1lAO3XGJCTxE9utcPOjDJrqVbNjrcYZvgDDS3ijkK8Seuq8Zla4Jg8
	E3jnVqPQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPX-000BX9-7W; Thu, 11 Jul 2024 15:00:35 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPX-0005O1-03;
	Thu, 11 Jul 2024 15:00:34 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:13 +0200
Subject: [PATCH v3 13/15] mtd: spi-nor: xmc: Use new SPI_NOR_TRY_SFDP flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-13-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=1089;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=6sGOeGBjWQoa+lKaakmKJY3XXQ4BYB11RN1yRi3xMDA=;
 b=XiAissFDssg6IebkzSvdb8kE/Jn1sGzrKHeFXF4USrd1u6C8YdoJVSrNFcoBI76ElTKk3C5QX
 RduUBlvo78eDFw97VKeV5zHmUzPKWRUgjRQc4xIC9doZbsjXRsCJiFL
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/xmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index d5a06054b0dd..527468630b99 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -13,12 +13,12 @@ static const struct flash_info xmc_nor_parts[] = {
 		.id = SNOR_ID(0x20, 0x70, 0x17),
 		.name = "XM25QH64A",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0x20, 0x70, 0x18),
 		.name = "XM25QH128A",
 		.size = SZ_16M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	},
 };
 

-- 
2.45.2


