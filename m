Return-Path: <linux-kernel+bounces-249238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED692E8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BE1B288B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285915F301;
	Thu, 11 Jul 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0R5/4YvH"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49F16D4CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702851; cv=none; b=kZ/2UPImIEfGPYGXXbrT4I5kEfUaSoWy1Qd4gtv3RIifzWNm+78SpITWaZs1eBQbLPtedPMwLLtia3Xb/9+c4LhDQ/7MW+NMRcogDBx0H0B4aDAv0LYwiyOEcB0RViQrl186lQh8yxC8klLfa45Fv87B+Aqhomole8/txoNEzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702851; c=relaxed/simple;
	bh=32WUeUrKPTK1On8oYr52pGY8kKKsIcbyD/ktcMgTl0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCPlRkzFK4HFPpAZnNgPuOiacCH4ghjgPKHTgAVsbQNQdnDH58SGDs5a/umkaqzKYGWZGSlFCiJK0GTXSi/ByWX8txq7hFT+mps2yaD3nQ6Twsz7gpuH2wCGm8Xon04INBNpZcQyXL+/q76GpVVCXLTvDRquhbee1LaMvmdsfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0R5/4YvH; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/x3Xwhy/zD+b8/iFmghy0uZLwRTAG0iaB95lyFsIrSY=; b=0R5/4YvH1GzTT+eLqA1zYwGrfo
	DHt9Ex2kTaC1MkaMxG62DZghwUbzo3kanJQeIIxBrzxb2L5+dHn0jZJit/QJnWqAjHJ0kYF+5V3cE
	x2SumkbwFgM33pGdjIqHg7INNR206RI9h8tPryTgQUQWbMUiHtZrlIyAHf39asq2x/InRnBucqs57
	RlvZb5thdESwRGcEal4g5o3oHIHpdpO0doNPulnfdfd9dQ8HU3mRgeX5vj386JwFAWITYpKBCSlsh
	ZniLxpsvHXN8UgxBwSPbMEnx4ezxzw5goP6nGI5HrxLCR1y/5O2h8Yi0Vboj2v0dyOxn2Xri5IrNP
	4b345A3Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPd-000BXZ-EN; Thu, 11 Jul 2024 15:00:41 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPY-0005XX-0j;
	Thu, 11 Jul 2024 15:00:35 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:15 +0200
Subject: [PATCH v3 15/15] mtd: spi-nor: spansion: Drop redundant
 SPI_NOR_SKIP_SFDP flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-15-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=2782;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=32WUeUrKPTK1On8oYr52pGY8kKKsIcbyD/ktcMgTl0I=;
 b=kv2cu/A4E4HA+a4EuZNTqqPIMM+PoYEAWa3H1GKwKtiJ/oVRh7A0CWiRoFQt8GBkr8psS8Pbl
 WfhMZzwLWsNAHxwdFNHKEg4bHEN1i00QOJnEkQduDBUG3+bN44oIiZC
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

With the implementation of SPI_NOR_TRY_SFDP flag, the removal of the
deprecated mechanism for trying SFDP parsing, and the alignment of
->default_init() hooks handling, the SPI_NOR_SKIP_SFDP flag has become a
no-op, so it can safely be removed.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/core.c     | 2 +-
 drivers/mtd/spi-nor/core.h     | 5 +----
 drivers/mtd/spi-nor/spansion.c | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d58f107f62ec..518b2707ce80 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3024,7 +3024,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	if (spi_nor_needs_sfdp(nor)) {
 		ret = spi_nor_parse_sfdp(nor);
 		if (ret) {
-			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP or SPI_NOR_TRY_SFDP when declaring the flash\n");
+			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_TRY_SFDP when declaring the flash\n");
 			return ret;
 		}
 	} else {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index f4a76f42051a..ae10e12e9078 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -485,9 +485,7 @@ struct spi_nor_id {
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
- *                  flags are used together with the SPI_NOR_SKIP_SFDP or
- *                  SPI_NOR_TRY_SFDP flag.
- *   SPI_NOR_SKIP_SFDP:       skip parsing of SFDP tables.
+ *                  flags are used together with the SPI_NOR_TRY_SFDP flag.
  *   SECT_4K:                 SPINOR_OP_BE_4K works uniformly.
  *   SPI_NOR_TRY_SFDP:        try parsing SFDP tables before using the
  *                            parameters specified in this struct.
@@ -536,7 +534,6 @@ struct flash_info {
 #define SPI_NOR_RWW			BIT(9)
 
 	u8 no_sfdp_flags;
-#define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
 #define SPI_NOR_TRY_SFDP		BIT(2)
 #define SPI_NOR_DUAL_READ		BIT(3)
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index a58c0229003d..afcb684ffe4d 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -793,7 +793,7 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s25fl256s0",
 		.size = SZ_32M,
 		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x81),

-- 
2.45.2


