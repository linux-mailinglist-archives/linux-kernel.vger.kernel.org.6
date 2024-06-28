Return-Path: <linux-kernel+bounces-233973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832BB91C04B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414D728270E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055881C006B;
	Fri, 28 Jun 2024 14:04:34 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F71BE843;
	Fri, 28 Jun 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583473; cv=none; b=gmYandhQokEfpz/iDTXWITmybLH/wpkkPLArFxc6U7UOPii79D6Tl+O7nF5eb1ex/1KFfNz4MtrdRmOk78iW22BeeR50bslJoPppGy7otJ1R+iA+a3IEHj3yC6Lhm6jYvo2R35usav0v6nztKVHgvMTDEzT1l7rxHCFUhV9X8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583473; c=relaxed/simple;
	bh=majJpbIEZ5L9h6UbAm35Av5QMsq9MbUrx/XGexo7JsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpNR/7Y8xHJmxKZ+WbVGBt+Lzxa3L4Hzimq/5goYxXls8EZtceVLHJjMS9HDjB6ZFeikTzYkmH8GLmA/EsgEHO/2al5PhL/m61kFEZNvmsx7rLri4IYZ2F/znpNZ2UFH3Gn0bc0VS4hmbId+U4zp3AZRnxvviBxCyGU28Ii9ORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4W9ccY3L1GzMQLT;
	Fri, 28 Jun 2024 14:04:13 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH 4/4] Add Macronix SPI-NOR mx25l12833f with OTP.
Date: Fri, 28 Jun 2024 16:03:28 +0200
Message-Id: <20240628140328.279792-5-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628140328.279792-1-erezgeva@nwtime.org>
References: <20240628140328.279792-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

mx25l12833f uses the same JEDEC-id as mx25l12805d.
The 2 chips have the same flash size.
mx25l12833f support SFDP and
 have a bigger symmetric OTP.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/core.c     | 1 +
 drivers/mtd/spi-nor/macronix.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0f267da339a4..f2a46add2695 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3799,6 +3799,7 @@ static const struct spi_device_id spi_nor_dev_ids[] = {
 	 */
 	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
 	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
+	{"mx25l12833f"}, /* uses the same jedec ID of mx25l12805d */
 	{"mx25l25635e"},{"mx66l51235l"},
 	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
 	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index f210231468a6..fba3fc8e0d49 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -247,6 +247,11 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
 		.no_sfdp_flags = SECT_4K,
+	}, {	/* Yes, Same JEDEC-id as mx25l12805d */
+		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.name = "mx25l12833f",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.otp = SNOR_OTP(512, 2, 0x000, 0x200),
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x19),
 		.name = "mx25l25635e",
-- 
2.39.2


