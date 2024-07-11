Return-Path: <linux-kernel+bounces-249226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C956492E8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746AC1F22AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A015FA68;
	Thu, 11 Jul 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qm2cgKsc"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6415ECF8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702831; cv=none; b=HO13riYfJisi/y74tM+073K061fZtG5cTz9SBeQvg5ZiA5a1dr8HS7rWa9VFClSWrsQyAAriRTnoRD41h3/n+SxGuGdjAj4lfuLSixkWw3/vUmw7KDzayHDAjyOAvXb6KhNzXsIBXB9FETr69xSmOi6VkkCoKjAQx90DA6g7rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702831; c=relaxed/simple;
	bh=JrPkztMV1oVuJInQdJCGTwXrnR2sny7JLQNFMwZiGqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iggZw0Bpuis6XRDsH4DXe6u1aEaJc9rkyweb0duwNx7mifMANVyQ0Y8J1z9N1SS2uf4wc1ijueEQuSzpe+/H775vnP0MacjQryNX2LgJ4eTEPZvbLWIhjwUP5snT7WDXZWWHShBeltvIZmJ7BaRwEVCiZH8o5VNLoMByzmPkFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qm2cgKsc; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yWPnlogaHh1JsL53cSK4pYNGOrysHKRUndRnVu5uc+I=; b=qm2cgKsc04djIe+T+t/T4PrZAl
	XA/YTkOz03/j7brnLnj3eP3aKCF/Fy4OSk57EPv4HG5kUILHcftrj0UMK1SEqeJQvaNzWgNmuUlV1
	q6cfglywoU/xSvwDT46pNPyIKwp0w4WhuXNZpzvcl6EhQJ/8oJsZ+wtJEpJab173wAqmGksEWr+W9
	b97sMRyZgrWWkM+Q2ubkWgo8mwik7vG7GagS6Evq/b3p7L3mzHzIrvRnkeeiIkD/uqVIlUih2Tyjf
	5fjHqOhDxVZ2vZcKw9GwU/LIxA4n/PBgeLAa/P4DVQgdtHszJj44GwSSFmKdXFc/QtHZ9i3kZEeHB
	mhtMMISg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPF-000BS8-Rl; Thu, 11 Jul 2024 15:00:17 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPF-00037C-2D;
	Thu, 11 Jul 2024 15:00:17 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:02 +0200
Subject: [PATCH v3 02/15] mtd: spi-nor: macronix: enable quad/dual speed
 for mx25l3205d chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-2-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=2314;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=JrPkztMV1oVuJInQdJCGTwXrnR2sny7JLQNFMwZiGqI=;
 b=jO03AmXp0U1Nh+VMBJv8f0MdVICx6OYPq8mRIR1HA6jgera3Lq58jHoP+eLaFtWBiMdB0nVmp
 bD+RRvKAFi1AidmK2ckr/aV7iqu0vDFS3tumjbHR/Qdy2gHt5QBTW92
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

Macronix engineers apparantly do not understand the purpose of having
an ID actually identify the chip and its capabilities. Sigh.

The original Macronix SPI NOR flash that identifies itself as 0xC22016
with RDID was MX25L3205D. This chip does not support SFDP, but does
support the 2READ command (1-2-2).

When Macronix announced EoL for MX25L3205D, the recommended
replacement part was MX25L3206E, which conveniently also identifies
itself as 0xC22016. It does not support 2READ, but supports DREAD
(1-1-2) instead, and supports SFDP for discovering this.

When Macronix announced EoL for MX25L3206E, the recommended
replacement part was MX25L3233F, which also identifies itself as
0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
and 4READ (1-4-4). This also support SFDP.

So far, all of these chips have been handled the same way by the Linux
driver. The SFDP information have not been read, and no dual and quad
read modes have been enabled.

The trouble begins when we want to enable the faster read modes. The
RDID command only return the same 3 bytes for all 3 chips, so that
doesn't really help.

Instead, we can use the SPI_NOR_TRY_SFDP flag, which forces the spi-nor
system to try using SFDP, but fallback to the parameters specified in
struct flash_info.

This way, boards using MX25L3205D will continue as before this change.
That is without taking advantage of the 1-2-2 that it supports.

For MX25L3206E and MX25L3233F, the SFDP parameters are used, and they will
therefore be using the optimal dual or quad mode supported by the flash
and the SPI controller it is attached to.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..090f28e05a5d 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -61,7 +61,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x20, 0x16),
 		.name = "mx25l3205d",
 		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x17),
 		.name = "mx25l6405d",

-- 
2.45.2


