Return-Path: <linux-kernel+bounces-410568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB419CDD63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA319283937
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F11B4F0D;
	Fri, 15 Nov 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5mAH0Wt"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEE1ABEDF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669707; cv=none; b=oADLBrJQboIRNcbUP5QRX7xYxBnV7hkB+hs6ARWOjctbMfyC8z1TSoqQ0/77Fyrria310IZpYm8O3SuuoVntsZkT7xk0YDnY/rHC8PGsApZXwoIE8fU+LvFw1iWN6rAP8jHYqjK5bInhszEBfh82ZHf7jQPFB0MZbJvuTZ2PlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669707; c=relaxed/simple;
	bh=tThtjTxdYs9vJVKFOy+4jb+6O5TsVYutmbrI2Y84p4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XW+NVw0r3lNaH7YO7R28SM3eT/BInPD5w11NAe6VGmB5fjtrgi2mq/uhVIVA2WI/zjfsNRFrXbxskbKvpiMtcz2uxmHcmSgEuHAgzZqtwtQj40nYSyWov66hcbF3pH8nCQkEVsWJ8xAr6w+2Sqn9C6fSzoeMlCqFpwjfLiUs7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5mAH0Wt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53da2140769so1781819e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731669703; x=1732274503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zO3noysIfMN1J6IY+uuFQEwLmggKDAy7JsEEfwk6lds=;
        b=a5mAH0WtDEMfSmEtqVfBFT+7jam+MqA8f6dViB5A97nXPZwkSC7E6t10Zos1U/TJQs
         Wwds5cQYLRVm7efhg/szCQCrWXAM84AbYarYKcPB4CvFOcTSn7modIHRqRxsBA6EEcuV
         Xbu9DZyC4xObS/LKNs1PVIxRR2vN909OJ37QUiE5BVvHqvHJoosjdcyI2U9X+Eqkp2yQ
         BTeNpXbTVYLOJmiA4FozLYKSUwCmYCnwY1cPPU5SCXXkk5ImbQRkwcDiVSu/2CD4QAat
         4Kk8HVz2gfL8x5sEcQiboYPaANkJrO1SW9breuzUTBtzsDezfhhqw13L0JjSlbgYPLwW
         XR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731669703; x=1732274503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO3noysIfMN1J6IY+uuFQEwLmggKDAy7JsEEfwk6lds=;
        b=IfTSKwLVgyHSAt5XDr7rdwKeVYsTvHv4HOFta+FtJ8cjji8K1sSy9mXd30cX3j6swG
         KJWWRUbK2QAAPS6N1UXNKBQOqBGqrTnyJIHLjF3D/F9AljLPTQ2jSDwUK5jYP6CR5Hjx
         P3iKPJHCMPK9lGDwZzUJyAHTAEQpf20LjorUkXTp/vq3oH6y4AZ4rruEaMwk9BihNWxy
         tOPoLq7STae9xWiBb0VPBKPa3E9N564iMA8c754sPvtWbSZnFo0KbxCy1wTEKSsWiIYA
         F7npa3TBOzLtaGRQ4dpXDrov5r20pp+FQ075hcM1O31UhWrImZBdyzA5NzHwUGGmWdOK
         ljkA==
X-Forwarded-Encrypted: i=1; AJvYcCVaMAi+Yo9B4tolroGt7r+yBdCyvZZa4IcEZtPKZpTjznHJgRfZNbrfjGxEyzuXgd6MFcNQ+k24sL/l5QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiAkG7VqWgeXeLdLD8nIU4IVwS6RkLMHO6RwqmjGVaTDTGK8s
	t5rXIRoHNHdGjcTHqZzyZOB3XIa/E7kdHkGoaqTPAReedrYNPLx2up/nQ604
X-Google-Smtp-Source: AGHT+IG2Nv/kAUebbnR8w53YV5AaYSUtDKzgxW0PKar/3L6rGbdcRnHc//D5S5zbsm0cxaAwDAGPMA==
X-Received: by 2002:a05:6512:3c9d:b0:536:55a8:6f78 with SMTP id 2adb3069b0e04-53dab29abecmr1233640e87.17.1731669702860;
        Fri, 15 Nov 2024 03:21:42 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f2aecsm524610e87.18.2024.11.15.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:21:41 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 15 Nov 2024 12:21:28 +0100
Subject: [PATCH v3] mtd: spi-nor: atmel: add at25sf321 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-spi-nor-v3-1-93ec584177cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIALcuN2cC/2WMQQ6CMBBFr0K6tqYzKFBW3sO4gHaASYSS1jQaw
 t0tbCRx+X7+e4sI5JmCqLNFeIoc2E0J8lMmzNBMPUm2iQUqvICCSoaZ5eS8tAZ1oStLjepEes+
 eOn7vpfsj8cDh5fxnD0fY1v9GBAnSlnhtu7ZUQObWjw0/z8aNYmtEPHiofx4mj6AoTK6VItBHb
 13XL28BqtbWAAAA
X-Change-ID: 20241018-spi-nor-dc29698dea0f
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4667;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=tThtjTxdYs9vJVKFOy+4jb+6O5TsVYutmbrI2Y84p4Y=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnNy6+7Dw3gwoC8g4enE2DHNSdR7jdje+GjxOV1
 EtNjuxYFqCJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZzcuvgAKCRCIgE5vWV1S
 MrkrD/wI3mCeQtkhRtJ6mCoSSU0mYisrVX+ROff4OWkft4RXhYzNbsKfihxZIgVIzDdGJ/mXZKp
 np969s/Tio8WYbnAVWb4RLvDYjXFYs5aFCWQW95K92jPcYFjX0HBzC5uvXs67613rPyQWzUCZ/O
 EShb7a72rkcw7hmgplQkMv71vJcXnu4BcLbDZP+Glla+NW47IlhSnQ05Unb8wThdMAgN2FaZuwt
 gkqjR9BUdvw+EFG48MuFcT2B1OhdTU31R+xvTp3utbitDRqDT4xMqlnO9nS0a9Q+5kkt8XyFxPW
 wF09F72H+HVu1dWZeGJtkXGk5vqqaqebXMDhW0irB8gR8nq0rzj64DF5uQO8pEUjN9PxoXWHX8K
 F6Oy84u/cg7nm46Fi/yw3tEhoR7Suo4JJzNNFeh+Aj9UfeUfSWYEpNHc/Ooz3SIu3NfO7oBP8me
 w9yQiVEn3lvJz4AbrLRxhSTRDTHyNRhIb+u0PBHg6nESl/NLVfBRaOWFlXBpj+i+sORGKOsVodW
 oaql41Vswfh1QF7szdK1KeSa/NYXznCu8+JnSHhcpncr2YkxoZNn47O8b1TsKHKhv4B3srFindQ
 rJG18sG64mMGNfuRjy8+oZGby8/xLEvq63Lp36AZHIa3Tv3VC50AO735fnl0kMoz+TZDZkj4nDy
 10zQG88cpCI9ogQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add entry for the at25sf321 32Mbit SPI flash.

This flash is populated on a custom board and was tested at
10MHz frequency using the "ti,da830-spi" SPI controller.

Link:
https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/partname
at25sf321

root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/jedec_id
1f8701

root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/manufacturer
atmel

root# cat /sys/kernel/debug/spi-nor/spi1.1/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x03
  mode cycles   0
  dummy cycles  0
 1S-1S-1S (fast read)
  opcode        0x0b
  mode cycles   0
  dummy cycles  8
 1S-1S-2S
  opcode        0x3b
  mode cycles   0
  dummy cycles  8
 1S-2S-2S
  opcode        0xbb
  mode cycles   4
  dummy cycles  0
 1S-1S-4S
  opcode        0x6b
  mode cycles   0
  dummy cycles  8
 1S-4S-4S
  opcode        0xeb
  mode cycles   2
  dummy cycles  4

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x02

root# mtd_debug  info /dev/mtd6
mtd.type = MTD_NORFLASH
mtd.flags = MTD_BIT_WRITEABLE
mtd.size = 65536 (64K)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1 
mtd.oobsize = 0 
regions = 0

SINGLE
======
spi-rx-bus-width = <1>;
spi-tx-bus-width = <1>;

root# cat /sys/kernel/debug/spi-nor/spi1.1/params
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   none

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [0]
 d8 (64.0 KiB) [1]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [01  ] |

DUAL
======
spi-rx-bus-width = <2>;
spi-tx-bus-width = <2>;

root# cat /sys/kernel/debug/spi-nor/spi1.1/params 
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR | SOFT_RESET

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   repeat

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [ 123] | 

QUAD
======
spi-rx-bus-width = <4>;
spi-tx-bus-width = <4>;

root# cat /sys/kernel/debug/spi-nor/spi1.1/params
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR | SOFT_RESET

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   repeat

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [ 123] |
---
Changes in v3:
- Add SPI_NOR_DUAL_READ and SPI_NOR_QUAD_READ flags
- Link to v2: https://lore.kernel.org/r/20241029-spi-nor-v2-1-e166c3900e19@gmail.com

Changes in v2:
- Change from at25sf321b to at25sf321
- Link to v1: https://lore.kernel.org/r/20241018-spi-nor-v1-1-d725bfb701ec@gmail.com
---
 drivers/mtd/spi-nor/atmel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a07b7c61f46b117311b24ab695038f..ff9462d9b8ed83f44ee99a7f3b70b99b4d455e9b 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x87, 0x01),
+		.name = "at25sf321",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
 

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241018-spi-nor-dc29698dea0f

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


