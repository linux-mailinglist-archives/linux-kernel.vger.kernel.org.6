Return-Path: <linux-kernel+bounces-319670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B297005A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E151F23A1C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EBC145323;
	Sat,  7 Sep 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="O66wITbc"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88ED381A4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691429; cv=none; b=MlJ69K+N3u6OIQkECiger/bUf4ingEMcai4Lq8JABmCOvD1o0qGs7A49brQajzrOMN3BT8q7iuTUhPUkdPpIa3lReDqKtkcOgH6695Bn4+c788CVNjNXF8Ae3mFJazeZW+SpcvAq1bVfETXXSa7ChIhjR0866o7lt11aRm7wMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691429; c=relaxed/simple;
	bh=6od8ddP3uRcwaizSSA9CraAzYiRmA8yzgWtGt4u8yMI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BQYRXZAGco9/3+Y22EFx43a2X9E/d2QRYaU7l0qMd03FlEBu6n2sNq0p4nnmKSzZRNQBHETHSb8N31WuiDOi5/9BAbf0V3F0Zz2fM3304OO4j6P0gEJWksJ95HphM8g/b6TK+8BFdo20DwfXOyqaQJGv8DNOAjhESVve2r0WE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=O66wITbc; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725691120;
	bh=2+NoZb8HY05rj6hzt63kWk/NKYFBBygQXfpEjmIYg0w=;
	h=From:To:Cc:Subject:Date;
	b=O66wITbcx+o0TiIrcnh7efdA1GN7ClqOdQAy4MqrCPfkM/MFPzm4WcMuBNvIX7pjX
	 vDDuSy2hYaY0XE4GuyNMTw1oz8s+xd49sB3LtFdmlA5A9kk0xsHLA17wUKy5bQ/V2L
	 FJIsDpv/gS44aBrPUPJQy/mZ1PFA9GmD17/L1KOA=
Received: from localhost.localdomain ([171.223.88.74])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 8199523B; Sat, 07 Sep 2024 14:32:25 +0800
X-QQ-mid: xmsmtpt1725690745tmnhxwdgq
Message-ID: <tencent_983A0FB4662661C03E98E1AC214E32179F0A@qq.com>
X-QQ-XMAILINFO: NIg715EJm9p9pWMynSbLFDeumTZtNfn1AbnDHe650i/GQdybJA9qRMxnB7C8xG
	 Hj0IEwS1aQUYxTzu47jVPkM4v0cGJeIZRqRse/SAAdJAGTbjU0eb8xn8su/QOYK8JNtbCKABvHZA
	 NduilOU9j1aRNouLZIjW5wL3F5h7yMLK6q03oYwBiqQVIcfTivlQLxyu9EVQ+COWyfTEYQYiKVMO
	 aSlBN0gbVyBaDfhxw342dU+kvRSmQhxXthrip2NobVYFoiq8tRw6HndX3REWcL+QNJd8bdEAAZVh
	 hskdBiv1EaXhHPpbidu4XGO+aW1FyAKrK/ekR1Kffi+C9HTKZzbqakKfXoPzLULI7UurUldFWWz3
	 tPu7I+5MBf1ZHCusuUglCF8c5vYYBJf2cqRIkDh993rKrbTnfn/w6HPbggh2ORQk/SbHVW0ahW1v
	 NnYBkK9l/AF0oJTAz/6aTxRojYoIjo4D/wyeJkQdgm6lBQY/4SqIT9YNSKUIDDmlImsAc8z/zfyT
	 K1zQd1GAt4XnFxZhZoDrsz81+WWKfpAvtYMZEINDNNwP+dpwysSl3h5TgP4kMUR0pEo08BdYwC1p
	 VsyUzMZClwXvAyeCWVTuF0Wf08IBSCa9DFscB3++UkvRsGS4PeQcGgsUd981XzToG9j8dxEr9yXa
	 mpQyxfWvwKZWZckPhHDXIzsTyR20yzQ/c74vgQZ/VneB8OIoNAkbYxgV0C1qh79B+GHBkXslEvz7
	 jeMVVaoQb8p/8Fp50vV4iAR6FBt20lFNefwQlU4y7jwgbFOtHUJH3Pk/4mM3kQYfcStGzJagYKG7
	 seugme97Wtyp/ebBjdKEIKYL5/3NafQYP5Co9c9s1eqN6M6BdAL20K6OeWkSGkSY2El0RzyUXBKB
	 l7jSfDFnWQVGawr3jGIGVie1MlKSVFpG6lSLg8wm+TC0539YejKnEZ5qnIaNuJqNRZ+9Ys2CXh+n
	 iKsdMJxMbDukygwDKU9cJEAl8HI4uXuHHhw1X29s068j7DKYNLhNqYJ0gniPCT/y6lV4BuZuf4Zo
	 9JZgppeehi3728PGX4M+n2fp9ebgkPsivIVKcFZiCvQEO4HE4RzgkmxQmG79Q=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Subject: [PATCH] mtd: spi-nor: Add support for gd25 and gd55 series chips.
Date: Sat,  7 Sep 2024 14:32:13 +0800
X-OQ-MSGID: <20240907063213.387211-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for gd25lq255, gd25lb256, gd25lb512m, gd25b512m, gd55b01ge
and gd55lb01ge. All these chips are tested on Rockchip boards[1].

[1]https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/mtd/spi-nor/gigadevice.c

Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index ef1edd0add70..f0069a4adbbf 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -61,6 +61,7 @@ static const struct flash_info gigadevice_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
+		.size = SZ_32M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
 		.fixups = &gd25q256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
@@ -82,6 +83,48 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc8, 0x60, 0x19),
+		.name = "gd25lq255",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc8, 0x67, 0x19),
+		.name = "gd25lb256",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc8, 0x67, 0x1a),
+		.name = "gd25lb512m",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1a),
+		.name = "gd25b512m",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1b),
+		.name = "gd55b01ge",
+		.size = SZ_128M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc8, 0x67, 0x1b),
+		.name = "gd55lb01ge",
+		.size = SZ_128M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	},
 };
 
-- 
2.39.2


