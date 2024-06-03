Return-Path: <linux-kernel+bounces-199188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A28D8387
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B81F22549
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917512D1F6;
	Mon,  3 Jun 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UADXYjTb"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3B12C554
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420175; cv=none; b=qOA3AsCS5I27Cjgf2cV3vA3TWRUQqtl0kOjodJzwQCEzGrB8aO0BLx6uZhDOmTxQ7IEw62NHU98D8eC/M8Ev81UHBrcIFghkuBPXctPfPMcbdD+0c2KIBe4uMjOHRVMK6XrTYNjYPPD+DFtIdhnwMFloszACVYaUMaB0CukVOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420175; c=relaxed/simple;
	bh=gu0DnQSfTDhcc8YVz9dQ+rW0Ug+W3gS4CBp0FJUD1eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdIaTBh+Sh1pHKUQ6E72sroEWOkHaBe5zH5ibNxgRIfjanC3otAUTgpJ9JsS8unPvYqFjEpoRNKn3WKnzzlD1RPmgGb7gl9LSxxfdFtVfoH/Nf+x5C787OKCFFdVXuYfQk1UzHC/beTiOItexTRU3OfI+siuTajCmU5DUum9K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UADXYjTb; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SkkYBGLBX5AMS6+4n3/iKbRmqntG4ThN501YL0l9GAg=; b=UADXYjTbQHNq1JlvmXGCNxTpA5
	JRs1fqjmLflVnfrfHddyibyPi9TfLHQO9K+QBVtGGsNuT94oTAfLRQlEmXPCXGEMwXjUXtOMmr20D
	EVle1XOUIRlwz/rlCqiZKZAWppdREx2U/Ex2AMF66Y2Wdr11L+8qtG/QIdawfM4cvCJhZsn/IuKcL
	aQaJ3cTrHmrsxqXOdZbqezPOlWTWLJ1cU2KUD4H+polMfL1zglWwrylRVXMUOcvRT9780ohhG0u8v
	ZEgm1sTHDGbixswNwn3aCRbIG+c62ZA4dQ47G7UMBQ1N0B7f6KzIOMDF9QA4aGe8Sd3prXoi8JAuq
	GQPXV6Ag==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sE7RG-000Jpu-FN; Mon, 03 Jun 2024 15:09:22 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sE7RC-000O95-22;
	Mon, 03 Jun 2024 15:09:22 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Jun 2024 15:09:15 +0200
Subject: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
In-Reply-To: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717420161; l=1626;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=gu0DnQSfTDhcc8YVz9dQ+rW0Ug+W3gS4CBp0FJUD1eY=;
 b=LVq4ZvCQ52/lfDLcEa7wZA3VvHM6rWkJzLZ3AY8vciC8VFmqw8E+MeplwLvc7oLoOcaK8f8IQ
 9AbF3Q3WekaA0tAiWBGugYTEUHOdFyizyN0XbT3nuB0mEca7502OKb4
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27295/Mon Jun  3 10:28:26 2024)

A dedicated flag for triggering call to
spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
and parse, with fallback to legacy flash parameters, without having dual,
quad or octal parameters set in the legacy flash parameters.

With this, spi-nor flash parts without SFDP that is replaced with a
different flash NOR flash part that does have SFDP, but shares the same
manufacturer and device ID is easily handled.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e1f1913536b..1c4d66fc993b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
 
 	spi_nor_manufacturer_init_params(nor);
 
-	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
+	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
+					SPI_NOR_DUAL_READ |
 					SPI_NOR_QUAD_READ |
 					SPI_NOR_OCTAL_READ |
 					SPI_NOR_OCTAL_DTR_READ))
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..77f61a984cb3 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -535,6 +535,7 @@ struct flash_info {
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
+#define SPI_NOR_TRY_SFDP		BIT(2)
 #define SPI_NOR_DUAL_READ		BIT(3)
 #define SPI_NOR_QUAD_READ		BIT(4)
 #define SPI_NOR_OCTAL_READ		BIT(5)

-- 
2.45.2


