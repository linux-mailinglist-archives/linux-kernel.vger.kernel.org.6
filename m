Return-Path: <linux-kernel+bounces-249237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE992E8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D071F22A08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D616D30C;
	Thu, 11 Jul 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aCUl1B0v"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A16CD31
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702845; cv=none; b=UzZUSurUghKHEc9LYusYe6p26oGVHO/9YFagTw/tOz2+UIZxm3FDkNDajRjhnABlWbvaGmOAg79ampI8FAdJvcWKNopxo28QqSu6pczsV2ZfImUvWHLqlmfFBbtqw8IQhQaNKMDkOgbIPmquj5HZ0bwUuVwmFfKov1AFasxvWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702845; c=relaxed/simple;
	bh=lx0qh4MEN+MdnHMi3c/iFde5nWg07mHVMzlT3b+knLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/shqqIicol9GHnjmRVVQyCni21z7MiUZPRSGr/NT+EtZLBYw8bLph8n2Ib4zyvojQMRUleR6IxMrxX7f8t2f45zsixO88ikQm0jorio/iPnPpqcbSE2XLE7za7FWDM+wWy08Hyp9kNxCQTcyr61QvOT5keFwnTsXgjZrLnRbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aCUl1B0v; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7xyZ8HHn0IZWh6egUhr+Bg7rKb1uk2wj2zFy5v+GCaQ=; b=aCUl1B0v47gN1/uvq5rteboPaf
	apgKX4cWeUJ1cYM32MyHLdlDJESJUuiLLgMW4S1RyGVoSDXgk4wZft8hih4YdXBh3BOsLzDh4eIuh
	f2K2mVj1rLvmlZMhgo+RGeU9qpIvexglBb8udkC4tbdWbUWnM9rXMfTrcAMTXyTsp6sWSJ0CmKKSf
	3ZSPh2ll6k3Jn6C0fJOxtsAsLTKWcoJxtMyEOhR43GLLA7n1srtlYjwYOauHX2i0dgybu9gptBMiQ
	4xLdfBq5M+CBTc+C+orAi5NifFulIJ1qcqctB+5lp67LgmWUnHlU4smsdxG0J2QQPhs5ziEzKakGy
	s2RjH2bA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPX-000BXO-QP; Thu, 11 Jul 2024 15:00:35 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPX-0005Sd-21;
	Thu, 11 Jul 2024 15:00:35 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:14 +0200
Subject: [PATCH v3 14/15] mtd: spi-nor: Drop deprecated mechanism for
 optional SFDP parsing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=1575;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=lx0qh4MEN+MdnHMi3c/iFde5nWg07mHVMzlT3b+knLE=;
 b=a22i1tAFizJHUc1rtMZlDS3qeje8OHPMmoxGx1U79ayOl1Y1paFDvuxTl14XxgibUqAhjI2GE
 3QVO/Fqm3/vDgMHVi2ms0gY4AJahWN7z2IuAAJ364aL4LqcjxyC/tvc
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

With all drivers converted to the new SPI_NOR_TRY_SFDP flag, we can remove
the old deprecated mechanism for triggering optional SFDP parsing.

New flashes must use SPI_NOR_TRY_SFDP to get this behavior. Hopefully, all
new drivers will be fore pure SFDP flashes, so no or at least very few new
users of this flag is expected.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/core.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index dfc81716e068..f4a76f42051a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -719,24 +719,7 @@ static inline bool spi_nor_needs_sfdp(const struct spi_nor *nor)
  */
 static inline bool spi_nor_try_sfdp(const struct spi_nor *nor)
 {
-	if (nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP)
-		return false;
-	if (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
-		return true;
-
-	/* Deprecated/legacy way for triggering optional SFDP parsing.
-	 * If one of the no_sfdp_flags indicating dual, quad or octal read is
-	 * set, SFDP parsing will be tried.
-	 * When all drivers have been converted to set SPI_NOR_TRY_SFDP where
-	 * needed, this deprecated mechanism can be removed.
-	 */
-	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
-					SPI_NOR_QUAD_READ |
-					SPI_NOR_OCTAL_READ |
-					SPI_NOR_OCTAL_DTR_READ))
-		return true;
-
-	return false;
+	return (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
 }
 
 #ifdef CONFIG_DEBUG_FS

-- 
2.45.2


