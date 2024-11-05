Return-Path: <linux-kernel+bounces-396299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B439BCB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CDC1F23BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713871D3181;
	Tue,  5 Nov 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/gMbzQZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5202B9B7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804360; cv=none; b=PJavGlVPKixHIA5K0Ni7KN74PpTCrlnewRftGGeEF1ZVEs5a2caKZ5Je2NQR/UkY9wEXDtaNZEVA58K8irGGjOyCWZ3vRzDLDVzJnzqw+W9ZYVYwbCEs/yHmw78AvXQw9sDTCE23VtMQC2mGKQ3km5ITW/mgLmbdvkdy5lAWXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804360; c=relaxed/simple;
	bh=clf/ny0YoQUu926bpzdu3PvW1p9GIfTxcfU5pkicftI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc89RAv/JGsAuVk+fd8gDOOrvOqSwFOBSwhywPuaEOFZ+yy6ccdV2OqotRwVYro/JJMcWrG7yywzgrTajSdSpaTxaF0Nf5LDefxa9z/V3f1AiYESZEyC3mwmoK25wgz/ZjxIC6/+dF5LMJUtrTx/CjscXZs4BptLFDyJwysJeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/gMbzQZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so62942375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804357; x=1731409157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNdr11hGVrcXD6Kt/ak9C3q/RmQsxEhFNmU01xZcnvs=;
        b=e/gMbzQZ7bhvtNszjp1ebky7OWxpLmug74kWm+8tZjaRhkyBr6cP0MYbJJe6wJM8Mp
         bhkXtODA3uf5/BExAFSi1jfGM81lK57b0dhWy/xSo3t8FrE7WzRUlGUFyOW5JK9Z7hMp
         cgIJDBa3dKZjw/iH9yp0tDU+w8WgK+ZGNhNpG+tFmMcFrUGC3ePqMgJByvi68HFbqBLt
         FCxiz6CY019Ld9WGr3IendHyMNwxJRXB+yN5TF/CfqSoMBUTq/qnuLG7MMke5nI/kTGi
         J00d6cWlz9iMtGodXVCFreYhrdbsXLN+F2jSfzEq65MSXKhmyxjoBT2paw2l03Lq6WMj
         iKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804357; x=1731409157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNdr11hGVrcXD6Kt/ak9C3q/RmQsxEhFNmU01xZcnvs=;
        b=deCaZq5pp4T7TD00eLWC39I3F+c/chr7xFcugWS84HxVES8luvqraYbZgglOTPqbVv
         LOvOeGV351ohpqY7+SiIxbcd+qHkwLbcqEshZTf1fkhmu8gO4m8XXt1zLVnKWq1V9I6Q
         3lz9LTvTlLthdR6XpV3J+GKKtteHWbxrbH/HaNxDghgZyKbduFuoDSREXEPXa9EgWlpr
         f4a0855dBTW9Pa4dS/RPsaNwmbcbGOozX4sqTz+dFOgBclQukuVfLLfsNbUMh5cz4Ro2
         mCpHm7IquPnFJir8saza9AHdVVqgP1z95UzHnfhbDWB7xXSkK0jR28YPs63Z/c2yHV6v
         V9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyTUarbi6Uxi9KNSphB081aL0NxcfAP8QUMiaMbrZzYNaIiTPdMEUd4VI6qbJUE/LpSGbFrxX3TnPRAHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqfZ73WMxZrtM4mLuqrv0OYvQTaS/2rGUTeB88XzanR6mYJOM
	Dauf04wZkfM6jipcneRb6gBGpw8gsYlXUgTSCoy0RNyQolWl+LUe
X-Google-Smtp-Source: AGHT+IHRjx4s+ZF8EEdKlpdzEHOla4kk+SpHNiqx1PefCH83gU1CHVZAtoYj/tiPyFvzDPnTQAow0Q==
X-Received: by 2002:a05:600c:22d3:b0:431:b264:bad9 with SMTP id 5b1f17b1804b1-432849fa045mr166642935e9.14.1730804356961;
        Tue, 05 Nov 2024 02:59:16 -0800 (PST)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa611sm214315245e9.34.2024.11.05.02.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:59:16 -0800 (PST)
From: Parth Pancholi <parth105105@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: macronix: remove mx25u25635f from parts list to enable SFDP
Date: Tue,  5 Nov 2024 11:58:44 +0100
Message-Id: <20241105105844.257676-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

The Macronix mx25u25635f flash device supports SFDP initialization.
This commit removes the specific mx25u25635f entry (NOR ID 0xc22539),
along with its size and flags, from the NOR parts list. By removing
this entry, both mx25u25635f and mx25u25645g (which share the same
NOR ID) will utilize the generic flash driver configuration.

This change allows both devices (mx25u25635f and mx25u25645g) to
leverage SFDP-defined parameters, enabling dual and quad read
operations without the need for manual adjustment of no_sfdp_flags.

Link: https://www.macronix.com/Lists/Datasheet/Attachments/8663/MX25U25635F,%201.8V,%20256Mb,%20v1.5.pdf
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
v2: enable SFDP for mx25u25635f(and mx25u25645g) by removing it's entry from parts list

mx25u25645g flash is populated on the Toradex Aquila development carrier
board and was tested at 66 MHz frequency using the "ti,am654-ospi" SPI controller.

root@aquila-am69-02242602:~# cat /sys/bus/spi/devices/spi3.0/spi-nor/partname
spi-nor-generic

root@aquila-am69-02242602:~# cat /sys/bus/spi/devices/spi3.0/spi-nor/jedec_id
c22539c22539

root@aquila-am69-02242602:~# xxd -p /sys/bus/spi/devices/spi3.0/spi-nor/sfdp
53464450060102ff00060110300000ffc2000104100100ff84000102c000
00ffffffffffffffffffffffffffffffffffe520fbffffffff0f44eb086b
083b04bbfeffffffffff00ffffff44eb0c200f5210d800ff8749b50082d2
04d24403673830b030b0f7bdd55c4a9e29fff050f985ffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff7f8fffff215cdcffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffff002050169df9c06485cbffffffffffff

root@aquila-am69-02242602:~# sha256sum /sys/bus/spi/devices/spi3.0/spi-nor/sfdp
cc74a7490301b752a45fa147a860be43ed71a6f1cf598adae7ac38b19fb745f1  /sys/bus/spi/devices/spi3.0/spi-nor/sfdp

root@aquila-am69-02242602:~# cat /sys/kernel/debug/spi-nor/spi3.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 1S-1S-2S
  opcode        0x3c
  mode cycles   0
  dummy cycles  8
 1S-2S-2S
  opcode        0xbc
  mode cycles   0
  dummy cycles  4
 1S-1S-4S
  opcode        0x6c
  mode cycles   0
  dummy cycles  8
 1S-4S-4S
  opcode        0xec
  mode cycles   2
  dummy cycles  4
 4S-4S-4S
  opcode        0xec
  mode cycles   2
  dummy cycles  4

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 1S-4S-4S
  opcode        0x3e

root@aquila-am69-02242602:~# cat /sys/kernel/debug/spi-nor/spi3.0/params
name            spi-nor-generic
id              c2 25 39 c2 25 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | SOFT_RESET

opcodes
 read           0xec
  dummy cycles  6
 erase          0x21
 program        0x3e
 8D extension   none

protocols
 read           1S-4S-4S
 write          1S-4S-4S
 register       1S-1S-1S

erase commands
 21 (4.00 KiB) [1]
 5c (32.0 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (32.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-01ffffff |     [ 123] |

root@aquila-am69-02242602:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0147001 s, 143 MB/s

root@aquila-am69-02242602:~# mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash

root@aquila-am69-02242602:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read

root@aquila-am69-02242602:~# hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000

root@aquila-am69-02242602:~# sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read

root@aquila-am69-02242602:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash

root@aquila-am69-02242602:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read

root@aquila-am69-02242602:~# sha256sum spi*
7156e42306db1fd79e6dfc22320adaa126b394361abde4777a679924cc9fc0fc  spi_read
7156e42306db1fd79e6dfc22320adaa126b394361abde4777a679924cc9fc0fc  spi_test

root@aquila-am69-02242602:~# mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash

root@aquila-am69-02242602:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read

root@aquila-am69-02242602:~# sha256sum spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
7156e42306db1fd79e6dfc22320adaa126b394361abde4777a679924cc9fc0fc  spi_test

root@aquila-am69-02242602:~# mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0
---
 drivers/mtd/spi-nor/macronix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..5a0d1af99afe 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -125,12 +125,6 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25u12835f",
 		.size = SZ_16M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xc2, 0x25, 0x39),
-		.name = "mx25u25635f",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx25u51245g",
-- 
2.34.1


