Return-Path: <linux-kernel+bounces-249234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FFD92E8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038A1B280DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB29E16C861;
	Thu, 11 Jul 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lNMTe/g+"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927516C68C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702839; cv=none; b=sdiihpfNTJHuuCSDlbr1YaUM7FdiZ5OYqiI2MbQsCyBbC2Z9M33ap/Sp8dR1ji8GpJCPDgVuM2lzKlrPRoz2TA39gp+v6XxMDuwG3QDm6drQy5Kf8s0b7oHizwEDOQpNmJumHz34Mg7mxUn/s6yytFMQFu/t2SIdau7uXcPjdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702839; c=relaxed/simple;
	bh=ljG3r26u3NWW/rRWWrTsFxrJ5qKb4+lQAH18feZYI74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBmt2SzMixAJxp9erqso733PrNXWS3QMtzcfuqZdmcYb9mep8TkDWfVOv4+F3Vdu3FqPGs07bPffcF3j8QeGREvg4IJoFoTs//9vb/mp7cPtguuAtgUaI9LZ0u0UE3pFG8SvfhXXJ1kSLqwIgOXmLT3gx6mPFiNgEXPkRtR/1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lNMTe/g+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Iaiuq01WZqY1WjmLd9MSC9VUF3H2g1ho967hHMq1cSs=; b=lNMTe/g+MPV27Y9bXCVzRVwFyy
	Pk7fyTn3D8N6rxdGkyx4xsUU0c426emWxGcBgJThXWQf9wd0KqBw3kfZq3f4Fc+bLlTh6hQdmcojX
	nd2C8wiK02xcBn90n1LwfgXXKBTx6T2/e/okYN80vytpdG0Pb0DgNnKeqTAA3M5y5sDN6mQ+Obt1H
	PlqeINYoX+kuS586+pTkugm/DrTe7lJQ2mX3PEK2OVOOJ41d7N7uxxu5gG4pNHjnYFYxLK3g4D1Fq
	bQDpI+w8U54BEcdqARDg2jFby0lP5Vy4l78jCY8DvTPNAcfm5guQ/ADYp9feglW2H31jK6UpSvj3c
	XIT7sLbQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPQ-000BVs-U8; Thu, 11 Jul 2024 15:00:28 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPQ-0004e5-2M;
	Thu, 11 Jul 2024 15:00:28 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:11 +0200
Subject: [PATCH v3 11/15] mtd: spi-nor: sst: Use new SPI_NOR_TRY_SFDP flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-11-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=1495;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ljG3r26u3NWW/rRWWrTsFxrJ5qKb4+lQAH18feZYI74=;
 b=kuHOxZiK5BJO4gpOctj5rGZOrOg18d08fVjYk3yinG0AKzGrCIgyMRc89GYjVMEljgg4zK3eE
 Yc+x6CYl0FhC38EMd56YnQrydnA7l9yLh0sblAlMTAAolHceQo45Pl0
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This converts from the old (deprecated) implicit way of triggering an
optional SFDP parse with fallback to the static configuration in the
matching struct flash_info entry.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/sst.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 180b7390690c..bfebef62dd36 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -146,7 +146,7 @@ static const struct flash_info sst_nor_parts[] = {
 		.id = SNOR_ID(0xbf, 0x26, 0x41),
 		.name = "sst26vf016b",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_TRY_SFDP,
 	}, {
 		.id = SNOR_ID(0xbf, 0x26, 0x42),
 		.name = "sst26vf032b",
@@ -157,13 +157,13 @@ static const struct flash_info sst_nor_parts[] = {
 		.name = "sst26vf064b",
 		.size = SZ_8M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 		.fixups = &sst26vf_nor_fixups,
 	}, {
 		.id = SNOR_ID(0xbf, 0x26, 0x51),
 		.name = "sst26wf016b",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_TRY_SFDP,
 	}
 };
 

-- 
2.45.2


