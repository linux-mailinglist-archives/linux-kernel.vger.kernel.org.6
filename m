Return-Path: <linux-kernel+bounces-249231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC692E8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C132EB20E00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ADE1E504;
	Thu, 11 Jul 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="r9PHbn2i"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003615FA96
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702834; cv=none; b=lbd8nPkriZKBlteZn+gzmieYgtVsLhlZ0Ads7Z6tbwXMsj4pi2Ih8gXCcA85QjAtnPsJROR0FFTgiXcKkTyFO+i6ySEyWgDyNr4xdm4PmQBYOxypirbKOhcMgCEbcs864bnh5iwWxlX3lFkyeQKK6aHqJrwdH+EGoxoRuhO9MAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702834; c=relaxed/simple;
	bh=tSRHJerrgIY/xhP42g5Z+NiohX0lf8pP4THxPt55rtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLw5p+hvCGKlx+XBznlGV8FeFWOHZjfS9WMH9JnMmWIjUzvaMvjI36GWwXOoPgnYjQUtW1Tj5cVRhaF3nEMCjyEWHAMop1k1pL/e/P/SuSnk35uSCf0MoKXu01gUJKuQkEWL1ao2JMwJDCC7/qG1qCdwlPjVcYXP6BIw6IVgjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=r9PHbn2i; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1gViG0Am9XFir/+Rywn/yPhuXM8ueFi7r8F4u7hLGcU=; b=r9PHbn2iadCNsW8/DN/aTa1lh7
	LMiIiCF0E0EEQsWxkvrbf3AEbP5g0qraIE1dPACZc0qk44Yh+uNYvPtnoMA7t1IV3lG7tbhYL6HpM
	LJ4KZLCOvVedSXiU8pqqNfuhP0816lPZ9tXWFfCIW7ZQqXHKU0qBPxZinuXXY0WRt/n/AmaMomeUt
	ZymDUbeobDl+x0ugoMwVx+idnlLcAc0P+FuqFHGZ2SykspPCUiDKQ47DPQ9717M324dPoIbNZP+WP
	MRDPTgbZcA98P5dP3d99y62GUGKseNQi5/a9sl7kwBjm2uqJKgLwsnmkmJ1VOAVaoUy811VsBXokw
	M+B7j2sg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPK-000BTb-4j; Thu, 11 Jul 2024 15:00:22 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPJ-0003hl-2w;
	Thu, 11 Jul 2024 15:00:21 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:08 +0200
Subject: [PATCH v3 08/15] mtd: spi-nor: macronix: Use new SPI_NOR_TRY_SFDP
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-8-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=4335;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tSRHJerrgIY/xhP42g5Z+NiohX0lf8pP4THxPt55rtI=;
 b=POonLqbqEcbbcx3n9p07EI157zH05Ksrj6WAkr7zW1glmn8qp4PctNakp1ER7wxdUQzL5brsR
 ldgQ642NXXAB2a4LC3M2acfCgo7nLhQUi3jOOCFqHE6dT681NYWq9g2
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/macronix.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 090f28e05a5d..d31abdbe916f 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -77,24 +77,24 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x20, 0x19),
 		.name = "mx25l25635e",
 		.size = SZ_32M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixups = &mx25l25635_fixups
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x1a),
 		.name = "mx66l51235f",
 		.size = SZ_64M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x1b),
 		.name = "mx66l1g45g",
 		.size = SZ_128M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x23, 0x14),
 		.name = "mx25v8035f",
 		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x32),
 		.name = "mx25u2033e",
@@ -114,7 +114,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x25, 0x36),
 		.name = "mx25u3235f",
 		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x37),
 		.name = "mx25u6435f",
@@ -124,7 +124,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x25, 0x38),
 		.name = "mx25u12835f",
 		.size = SZ_16M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x39),
 		.name = "mx25u25635f",
@@ -135,19 +135,19 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx25u51245g",
 		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx66u51235f",
 		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3c),
 		.name = "mx66u2g45g",
 		.size = SZ_256M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x26, 0x18),
@@ -161,17 +161,17 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x26, 0x1b),
 		.name = "mx66l1g55g",
 		.size = SZ_128M,
-		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x28, 0x15),
 		.name = "mx25r1635f",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x28, 0x16),
 		.name = "mx25r3235f",
 		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xc2, 0x81, 0x3a),
 		.name = "mx25uw51245g",

-- 
2.45.2


