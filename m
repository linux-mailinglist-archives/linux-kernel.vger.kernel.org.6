Return-Path: <linux-kernel+bounces-234896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9391CC27
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FEB2207A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D906BB58;
	Sat, 29 Jun 2024 10:39:53 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E4548FD;
	Sat, 29 Jun 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719657593; cv=none; b=BS5ozXRfGw2DHyTOWcFqSvnoFqjFHVfVqTPonzpHnksbxdQVKafFeZPEJIrEVp3tIvCssob+Qq7oPPIGmaPzKNlAZ1nC6+DiKuQIR2ijOyS5IMmdXh4WMMW6VGtDG5rKXgq3E/1of3+EYHO8aIct1YHZIJ78g7Sb3P1wSQIHMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719657593; c=relaxed/simple;
	bh=uZ2YnKUN1+47QeDnb1e0FnFLPlZBFZXdCO5qwChC5CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvyIV1bSk4eRjH5zwAZ3QKueQN+BFoi9zIG01RXwf3Vh1WXqqD57oVYj8ApOvYXTcWrw21Ajco1Uvn8Im5iw7jD88SeQQk5lyyfYAvRVqgPTADfX4UPxGhyjGCIL+KuWsW51phLYLfM5r5aVAwqF8rrBqhiEJwkMJLGHEdKvZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WB82410BczMQLy;
	Sat, 29 Jun 2024 10:39:39 +0000 (UTC)
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
Subject: [PATCH v2 4/4] Add Macronix SPI-NOR mx25l12833f with OTP.
Date: Sat, 29 Jun 2024 12:39:13 +0200
Message-Id: <20240629103914.161530-5-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240629103914.161530-1-erezgeva@nwtime.org>
References: <20240629103914.161530-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

mx25l12833f uses the same JEDEC ID as mx25l12805d.

The 2 chips have the same flash size.
So user can use mx25l12805d setting with mx25l12833f chip.

mx25l12833f support SFDP and have a bigger symmetric OTP.

Macronix annonce the end of life of mx25l12805d in 2010.

See:
  "https://www.macronix.com/Lists/TechDoc/Attachments/9861/PCN31_2009 PCN_MX25L6405D and MX25L12805D.pdf"

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/core.c     | 1 +
 drivers/mtd/spi-nor/macronix.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0f267da339a4..6a5caa199978 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3799,6 +3799,7 @@ static const struct spi_device_id spi_nor_dev_ids[] = {
 	 */
 	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
 	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
+	{"mx25l12833f"}, /* Uses the same JEDEC ID of mx25l12805d */
 	{"mx25l25635e"},{"mx66l51235l"},
 	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
 	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index f210231468a6..28ae6041fe8c 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -247,6 +247,11 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
 		.no_sfdp_flags = SECT_4K,
+	}, {	/* Yes, Same JEDEC ID as mx25l12805d */
+		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.name = "mx25l12833f",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.otp = SNOR_OTP(512, 2, 0x000, 0x200),
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x19),
 		.name = "mx25l25635e",
-- 
2.39.2


