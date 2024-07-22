Return-Path: <linux-kernel+bounces-258677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E5938B82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BC8281A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1923161924;
	Mon, 22 Jul 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kom+WFSk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C58F66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638272; cv=none; b=fQOXH6R+nztxIbPKS4qb9sbdwC81B+BDOCy84iVkf1//aBB1r/gHa8sKs6w1enQfDVKa5bqkyPtnZ1BCpq5sjNT3SC1A+Ynb1pgBIqK6ldh419RoXm54feK3TFZWn2ltdMMVAlGfQcj8d0e9uqzIbJTOrdbPHkwRDuw+HoeCdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638272; c=relaxed/simple;
	bh=m56gr4OA5J01Y+YnUXt+ynbCjsXwh8zf9oFWBuMz5yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NToHiwkqWEaqm/2F+WJQAaCmjnSGNglLExEKvBw3y3YzjRKiAMGDnbc64HBwC9mptKZHvv6GtIlFkLv2v8RF56MoMbDgDRZuwnl1rpZUXuBMn+fLYfH03X4n9y7/t0UuNevS6oNdDTHcYQN3bx7FJpahD0Dv4wlbZNpvxJpjsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kom+WFSk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4fccdd78so19877255ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721638269; x=1722243069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxNiJ7wIiKjtvnc9wwX6TLuO6qWJsPU7G3qlk/ncD28=;
        b=kom+WFSksivdJ0Hdhw4tzrWrh9A4nM+aqV4lnKQCtJZiZijvoCPLO153ylNjl4A7HG
         4mQBajO6S/PB3eYGxtJQ8oFOc7Q1SMJJruuQXWZ46cRcbPYTQPxVp0Q/hjsooFT4sJa2
         Blc4lXdadRk851m5IfmpJrUgYP/yPdrqOiwNUW4ar+IJLkY1yeO6nxJVS6yzxdVL+AQG
         RWksKJwz3iYTyAb5WP/4JVQqKLT5UG9z9L5MANtBY7rUW2NdjdRY4wdjcLpj+FzMAQkx
         wlJNs4N/7sa3Kv387uyNAcDg9/olmvthqNDn9sQdYtsr9INoTqs7aBgLznAOSRlEsXtK
         R01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638269; x=1722243069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxNiJ7wIiKjtvnc9wwX6TLuO6qWJsPU7G3qlk/ncD28=;
        b=phBAB+Up5E83h+Pd2prnQneOSHN0MgWQ5n2yK5+jxcp7CZMDrZbBMRJ4FBVLdfu4mY
         xb11U+7tKXrdmiJqBBu0CNpAd2vUSkqvGrp3CB1J25mSas/D4r1EL8WNIVU0moQx+5/X
         NhYpyNGGi/TIjyRziKc2vi69ucZPn/gJOaBLuE1YsGMdZYIzdWLijhApuAeRyRUNnxhm
         omg++SYKrFWsReOQp8yXFK67ysyFSn4MNbKsJ+8+gc3qJAJkjge7OMsnL4iGmRO17BKT
         2Ag5bf5szDd1Mwu2ZUA3hvjdfjIuYheWYmWjeW0ZbyijXcbS3z5moUK7+CSBupQukpcH
         H0qg==
X-Forwarded-Encrypted: i=1; AJvYcCXRHqU6QpA9QK2t9bifTyk6fk3rD7rl7BD94dbCWchgKRCsRYcP8cd9wuyz8O+vu+cEogx+lae1FbenQ5rX+EeQJm0Dlzd3PHLhiKF8
X-Gm-Message-State: AOJu0Yw5ExiTJIjp/EduTWsw7Rua7Yf/qrIodnKDHHFhJ3MB1kFIR4dq
	6NVv4nLR6GYN4K1d194fR9HTdlCZgXKgAwLJL77e0tYvm4lBY1yk
X-Google-Smtp-Source: AGHT+IGKgNP7LZLV8Nh4qEhVssgvvhPdOq1y1eJcYk/0NCSYIznF+emvZE8rAuEoJgc+yEYtJiP+bg==
X-Received: by 2002:a17:903:1d0:b0:1fd:a264:9433 with SMTP id d9443c01a7336-1fda26497f6mr10504635ad.29.1721638269015;
        Mon, 22 Jul 2024 01:51:09 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2abbffsm49366185ad.116.2024.07.22.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:51:08 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 6B8F0805EC;
	Mon, 22 Jul 2024 17:00:49 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: leoyu@mxic.com.tw,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2] mtd: spi-nor: macronix: Add support for serial NOR flash
Date: Mon, 22 Jul 2024 16:49:52 +0800
Message-Id: <20240722084952.608770-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

MX66U1G45G and MX66L2G45G are Macronix serial NOR flash.

These flashes have been tested on Xilinx Zynq-picozed board
using MXIC SPI controller.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c2201c
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
macronix
zynq> hexdump -Cv /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
00000000  53 46 44 50 06 01 02 ff  00 06 01 10 30 00 00 ff  |SFDP........0...|
00000010  c2 00 01 04 10 01 00 ff  84 00 01 02 c0 00 00 ff  |................|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000030  e5 20 fb ff ff ff ff 7f  44 eb 08 6b 08 3b 04 bb  |. ......D..k.;..|
00000040  fe ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  |..........D.. .R|
00000050  10 d8 00 ff 87 49 bd 00  84 d2 04 e2 44 03 67 38  |.....I......D.g8|
00000060  30 b0 30 b0 f7 bd ff 5c  4a 9e 29 ff f0 50 f9 85  |0.0....\J.)..P..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000090  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000c0  7f 8f ff ff 21 5c dc ff  ff ff ff ff ff ff ff ff  |....!\..........|
000000d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000100  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000110  00 36 00 27 9d f9 c0 64  85 cb ff ff ff ff ff ff  |.6.'...d........|
00000120
zynq> sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
9af233495e5cffd2f38e9e2b8334a0d51c01fa93e9a17a991f674c8d6a350358  /sys/bus/spi/devices/spi0.0/p
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
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
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 20 1c c2 20 1c
size            256 MiB
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
 c7 (256 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-0fffffff |     [ 1  ] | no
zynq> dd if=/dev/urandom of=/tmp/spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.083620 seconds, 23.9MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> hexdump /tmp/spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum /tmp/spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  /tmp/spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 /tmp/spi_test
Copied 2097152 bytes from /tmp/spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> sha256sum /tmp/spi*
2c63296c93c97967e87279c3a4d4a9a5af4e7c2b9d2bc58579c3f01a6c522dfa  /tmp/spi_read
2c63296c93c97967e87279c3a4d4a9a5af4e7c2b9d2bc58579c3f01a6c522dfa  /tmp/spi_test
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> sha256sum /tmp/spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  /tmp/spi_read
2c63296c93c97967e87279c3a4d4a9a5af4e7c2b9d2bc58579c3f01a6c522dfa  /tmp/spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 268435456 (256M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c2253b
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c2253b
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
macronix
zynq> hexdump -Cv /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
00000000  53 46 44 50 06 01 02 ff  00 06 01 10 30 00 00 ff  |SFDP........0...|
00000010  c2 00 01 04 10 01 00 ff  84 00 01 02 c0 00 00 ff  |................|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000030  e5 20 fb ff ff ff ff 3f  44 eb 08 6b 08 3b 04 bb  |. .....?D..k.;..|
00000040  fe ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  |..........D.. .R|
00000050  10 d8 00 ff 89 49 bd 00  8d 12 00 e2 44 03 67 44  |.....I......D.gD|
00000060  30 b0 30 b0 f7 bd d5 5c  4a 9e 29 ff f0 50 f9 85  |0.0....\J.)..P..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000090  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000c0  7f 8f ff ff 21 5c dc ff  ff ff ff ff ff ff ff ff  |....!\..........|
000000d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000100  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000110  00 20 00 17 9d f9 c0 64  85 cb ff ff ff ff ff ff  |. .....d........|
00000120
zynq> sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
ef47525560aa30ca7eb4634eb2eb15a0aa618d3b61f774933f9935d05fb475f6  /sys/bus/spi/devices/spi0.0/p
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
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
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 25 3b c2 25 3b
size            128 MiB
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
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-07ffffff |     [ 1  ] | no
zynq> dd if=/dev/urandom of=/tmp/spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.083028 seconds, 24.1MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> hexdump /tmp/spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum /tmp/spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  /tmp/spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 /tmp/spi_test
Copied 2097152 bytes from /tmp/spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> sha256sum /tmp/spi*
45b3b6898c7dccd9bdc3cabd42d25ce6a875f4bdebe0b2a5d51632c67ecdc4a2  /tmp/spi_read
45b3b6898c7dccd9bdc3cabd42d25ce6a875f4bdebe0b2a5d51632c67ecdc4a2  /tmp/spi_test
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 /tmp/spi_read
Copied 2097152 bytes from address 0x00000000 in flash to /tmp/spi_read
zynq> sha256sum /tmp/spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  /tmp/spi_read
45b3b6898c7dccd9bdc3cabd42d25ce6a875f4bdebe0b2a5d51632c67ecdc4a2  /tmp/spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

 drivers/mtd/spi-nor/macronix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..387836b27605 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -90,6 +90,10 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx66l1g45g",
 		.size = SZ_128M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x1c),
+		.size = SZ_256M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc2, 0x23, 0x14),
 		.name = "mx25v8035f",
@@ -143,6 +147,11 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x3b),
+		.size = SZ_128M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3c),
 		.name = "mx66u2g45g",
-- 
2.25.1


