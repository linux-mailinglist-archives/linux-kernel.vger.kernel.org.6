Return-Path: <linux-kernel+bounces-319667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BE5970051
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3AE1F23A5D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35D487BE;
	Sat,  7 Sep 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q4NVVpwi"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C315AF6
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725690734; cv=none; b=rzXyLiYe+laiBKIxgCnyx8taeTsGlQzjmpzJ2dOrcddL1HhpO5TDtMuv8H0V9Oulh/hhxK1ULslKswS8fDRO4WiznvDzxa857VpyMoCb/py/Gm7X3QQoKMbbCb3NiCPzOBNYz3GFNjzJlgTXKQYgNCvkd+cEhBL6BzyJE/4R1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725690734; c=relaxed/simple;
	bh=//rEAAajgGkfjdlph2WILH56vhXos1lJMkl8VjW75Ns=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=izE7EHXGLPJ6wUiKBEQWNTKbLUiB//03EgkOhkicRp3xLqI+K6ng23SHhaeqvaP9eePqfgzdjnL+PIniwXTjwMACA3pHnbg9RhyUbUL9k0a4uEkiwbfbFIictZaoe0G/FrkghSgo7dBtqx4HExJewHc7jJaKRrYAaj34LfgugQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q4NVVpwi; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725690722;
	bh=6PCxOPhH4pc5zWqAmBT2Y6vNrLexjd5OGQB7tCEPWPI=;
	h=From:To:Cc:Subject:Date;
	b=Q4NVVpwizTjgIUQ8i1s7yZnB+Py4TCvHpaP5ayo/bl3DJlumVBPlu9KlhpNUUYBUT
	 +pxigOJqPJoVW0TuGNXjBczxrxAZdTo8UGnrapsbFFhuUfPP5Ruvb3AH/ZJoHERx5s
	 F81RuRGdz2ndHUcRhiwrdsKHO5wHn0VPumgN1SeE=
Received: from localhost.localdomain ([171.223.88.74])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 7FB19A96; Sat, 07 Sep 2024 14:31:59 +0800
X-QQ-mid: xmsmtpt1725690719t11a4eqc4
Message-ID: <tencent_E68F624B67F256EA24115857B3DEB5E84907@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjIMeIJKLpiTQNDy6iX/T1YBneIZWcd/EK1ZCjdRoe+ZBf3EG6U1
	 7r2kxiPMEzMqbFfDaurB1lRYGIVSFDS6qfX424/Ei1KJ9ZGuPU/K7INTFHDbaugvOZDaVpNVQTtn
	 5C8Pzsf5k2OL4kq5BypDJLWfOuBCF6nni3Nl438FpBKvg6wf8Rcpm+w7fzch3l1jdappwDw+6zad
	 LkeNt8s9Fy7+rRXl2N4NKnDEh8Uaq8SwIqbHn+9lMIqKFO46LBXYdmaWz4CAfbUHYnIEetZK9zf8
	 A3BiwKqUSwAfwyMpLj6AMx0tRJinTd0fL+xY9gw6rh2IoGCCLmFp0EC2iJigwvodhac74C+fv72p
	 qYBnpN6SjTm3UHqj2QA2xCV/2ldKlqAND+XjrWnDiR9hMheKIvAm2PtkWb9325D5NV/uRzXjZkJh
	 QI16/CK7vvfBSn5hJ80rpgoTc/5Zg8cTqM4ryxvEezkIGvMt55c37lrwWr9XXfZaaQ2fCCBw4TlF
	 b8EdoloQCVWc4T564Txjnr0JStrZdEtrarnisd7tu7NQjKRzdLW3bzygqfw1BOpKqP+agcqh6Yj1
	 8jKk38xRDQxN1VXR9LK0Gl9uuq1AZuzivmYE1DaM0BvgaI5u9QG33srF6fDOTC59LJ0140YQmBzN
	 JLdXeLHlahOd1SG6YFaTxV2segVBJ6pXylGCa3k4c2XGfF0JMSDPpqpaEn371bMpsnXVVM9XuXf1
	 uJFS/jKlh5VnfFJiGAITt/z5pANCJnvIHQorYbqJDdXUhKMkFwsB0URgk2CVxfgyJ8vEIGH8ImPt
	 vlUlmVWmlBpfnzmVKzKyhtRpT4R0pLTeOArU86p0P6Kw4nbsJCcKBz+4F+e455x3XhQlBJH7x0Z/
	 Spsw3Ahd/dVFP3/nGmU6wgPVY4F145Oam/tmQZhXcOB7scEUeqMbgJKxmUKkRyFvYPe811RlcNf0
	 +rvBialJk9R4Ce65lvPkX8zD4HtW4c10RRtY9kVTUnkc7VnbrV9BPl2Gw80pst1OiJVf+4gmaBED
	 QHyrWEKIU458FGdIzhHdX1m86huEL8C7Yp9zA/4M2mMWJwc+5K
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Renjun Wang <renjunw0@foxmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Renjun Wang <renjunw0@foxmail.com>
Subject: [PATCH] mtd: spi-nor: Add support for XM25Q series chips.
Date: Sat,  7 Sep 2024 14:31:36 +0800
X-OQ-MSGID: <20240907063136.387184-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for XM25QH32A, XM25QH64C, XM25QU64C, XM25QH128B, XM25QH128C,
XM25QU128C, XM25QH256C. These series chips are already tested on Orange
Pi boards[1].

[1]https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.1-rk35xx/drivers/mtd/spi-nor/xmc.c

Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
---
 drivers/mtd/spi-nor/xmc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index d5a06054b0dd..0532d2e2f193 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -10,15 +10,49 @@
 
 static const struct flash_info xmc_nor_parts[] = {
 	{
+		.id = SNOR_ID(0x20, 0x70, 0x16),
+		.name = "XM25QH32A",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
 		.id = SNOR_ID(0x20, 0x70, 0x17),
 		.name = "XM25QH64A",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x17),
+		.name = "XM25QH64C",
+		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0x20, 0x41, 0x17),
+		.name = "XM25QU64C",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0x20, 0x70, 0x18),
 		.name = "XM25QH128A",
 		.size = SZ_16M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x60, 0x18),
+		.name = "XM25QH128B",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x18),
+		.name = "XM25QH128C",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x41, 0x18),
+		.name = "XM25QU128C",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x19),
+		.name = "XM25QH256C",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
 
-- 
2.39.2


