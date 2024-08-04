Return-Path: <linux-kernel+bounces-274027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A65947129
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C6D1F210C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F012137750;
	Sun,  4 Aug 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZThOapIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5CAD59
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722809752; cv=none; b=awBbHERh8dV7C8R9zij0kEVuGiVLjdurQ4wjyLUKeeG4oJi5XPKBQKAycpvaLXUR0ZrZFcOum9lkLylT0/7N6gkX7YLBoAawgXtTKjQIHVcp22Kw2ICbg3ZQg+CAQt+8wl7/JFf+Yfote9U3gQZsd4Sp0M64+snAod00uyfvojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722809752; c=relaxed/simple;
	bh=1oqBZkcUEQ5WhhiwYcCFSLchEbm56fpcYEkTVNO0njk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ucWpgXfEfSbNd044zbGltY5fCpsCTrFX2o/QyxPsrp9GXRwh+Or0JH2ewsXWKz3G2ynE85H0VWV2iMgjZOPQ69uFgvEA0uNW0XAkg79a8dXKH3XkFFcWHQ8SdhHSwg9SBsFSRXLskV3cOEWpGfXeyzSmkL9VGehY8vizLJkdKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZThOapIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31A1C32786;
	Sun,  4 Aug 2024 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722809751;
	bh=1oqBZkcUEQ5WhhiwYcCFSLchEbm56fpcYEkTVNO0njk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZThOapIBT6ysrJlvawL9S3SQCMkW0eIBREoUOcPxTWdCwi1iGMj76dmbT9m86J6vm
	 aFEgu+w1Flwdy47l7NmEK16QkqxIPEoc4oSWCdNxC9DNDt715FRRqsQ2tlc25sw00p
	 DKYPYkE5W6A03EdSPQ2Tsd0QJ8XG75nRgVvTDBMTtkW/6Ppx82EzueUNwoPMrE/aCe
	 1jib62FmmekImw27rTaIMWpZz7eRVMBf+XtPX0Pi8oTT2gu1YoRYEIRULKvZvNRq90
	 DIGSgwNRJP2NYx+JlO5vWaX2fRGrfTOc9nTDseYmOjymsrjBEoUN/aR/IrPbw+1XgU
	 k0jpC4qJR8hyA==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: winbond: add Zetta ZD25Q128C support
Date: Mon,  5 Aug 2024 00:15:35 +0200
Message-Id: <20240804221535.291923-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zetta normally uses BAh as its vendor ID. But for the ZD25Q128C they
took the one from Winbond and messed up the size parameters in SFDP.
Most functions seem compatible with the W25Q128, we just have to fix up
the size.

Link: http://www.zettadevice.com/upload/file/20150821/DS_Zetta_25Q128_RevA.pdf
Link: https://www.lcsc.com/datasheet/lcsc_datasheet_2312081757_Zetta-ZD25Q128CSIGT_C19626875.pdf
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
$ cat /sys/class/spi_master/spi0/spi0.0/spi-nor/jedec_id
ef4018

$ md5sum /sys/class/spi_master/spi0/spi0.0/spi-nor/sfdp
f19e214c6709a259511bac4bd9c87407  /sys/class/spi_master/spi0/spi0.0/spi-nor/sfdp

$ xxd -p /sys/class/spi_master/spi0/spi0.0/spi-nor/sfdp
53464450000101ff00000109300000ffb3000103600000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0044eb086b
083b80bbeeffffffffff00ffffff00ff0c200f5210d80881ffffffffffff
ffffffffffff003600279ff97764fccbffff

$ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode	0x03
  mode cycles	0
  dummy cycles	0
 1S-1S-1S (fast read)
  opcode	0x0b
  mode cycles	0
  dummy cycles	8
 1S-1S-2S
  opcode	0x3b
  mode cycles	0
  dummy cycles	8
 1S-2S-2S
  opcode	0xbb
  mode cycles	4
  dummy cycles	0
 1S-1S-4S
  opcode	0x6b
  mode cycles	0
  dummy cycles	8
 1S-4S-4S
  opcode	0xeb
  mode cycles	2
  dummy cycles	4

Supported page program modes by the flash
 1S-1S-1S
  opcode	0x02

$ cat /sys/kernel/debug/spi-nor/spi0.0/params
name		w25q128
id		ef 40 18 ef 40 18
size		16.0 MiB
write size	1
page size	256
address nbytes	3
flags		HAS_SR_TB | HAS_LOCK | HAS_16BIT_SR

opcodes
 read		0x0b
  dummy cycles	8
 erase		0x20
 program	0x02
 8D extension	none

protocols
 read		1S-1S-1S
 write		1S-1S-1S
 register	1S-1S-1S

erase commands
 81 (256 B) [0]
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (16.0 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-00ffffff |     [ 1  ] | no

$ dd if=/dev/urandom of=spi_test bs=1M count=2
2+0 records in
2+0 records out
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
$ sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
$ mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
90145978caa36e84ecc07734d193c97a54ae601884a5ff4e0b90ff8c1f540a03  spi_read
90145978caa36e84ecc07734d193c97a54ae601884a5ff4e0b90ff8c1f540a03  spi_test
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
90145978caa36e84ecc07734d193c97a54ae601884a5ff4e0b90ff8c1f540a03  spi_test

$ mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 16777216 (16M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0
---
 drivers/mtd/spi-nor/winbond.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e065e4fd42a3..9f7ce5763e71 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -17,6 +17,31 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
 
+static int
+w25q128_post_bfpt_fixups(struct spi_nor *nor,
+			 const struct sfdp_parameter_header *bfpt_header,
+			 const struct sfdp_bfpt *bfpt)
+{
+	/*
+	 * Zetta ZD25Q128C is a clone of the Winbond device. But the encoded
+	 * size is really wrong. It seems that they confused Mbit with MiB.
+	 * Thus the flash is discovered as a 2MiB device.
+	 */
+	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
+	    bfpt_header->minor == SFDP_JESD216_MINOR &&
+	    nor->params->size == SZ_2M &&
+	    nor->params->erase_map.regions[0].size == SZ_2M) {
+		nor->params->size = SZ_16M;
+		nor->params->erase_map.regions[0].size = SZ_16M;
+	}
+
+	return 0;
+}
+
+static const struct spi_nor_fixups w25q128_fixups = {
+	.post_bfpt = w25q128_post_bfpt_fixups,
+};
+
 static int
 w25q256_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
@@ -108,6 +133,7 @@ static const struct flash_info winbond_nor_parts[] = {
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixups = &w25q128_fixups,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x19),
 		.name = "w25q256",
-- 
2.39.2


