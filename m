Return-Path: <linux-kernel+bounces-567672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5317FA688E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE71E887848
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC34253F07;
	Wed, 19 Mar 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJy7yxrU"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9B259C8C;
	Wed, 19 Mar 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377694; cv=none; b=pUli7sOvZFlBJmUKcOJ/6ZhH7xn41+U0z+m+05qdc2VNkgfomQS+J/3laK0MW8g2ZBC39mjSKELXtaQ5nVqNxhLfsh4A4/GgtbUWvJ5zC73t2wvSv07gJm79e+KAVMhB3lWAvqNFY38UZOA2d0s3/fc1orAjz7hwyaKJwndo7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377694; c=relaxed/simple;
	bh=oC9jr2u9u9kL8fmEU1SCe11rMhVquUDrj9AQX+3QGZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQ3MGS6PAnKxL0r4EvqDmpecM8v5dVKttmrVaOH56404yKDd/SA9Ahs/yli6+VKHn0X0SPWzDb+erKptM5Qdir1q3wNQm+hPd+BZdwbyK1+7uneD6dg2PIeFyh+w6a6prtdlB6xjehYxlvSvVx/wlc0BAaOaHJN4uMi0OKIbdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJy7yxrU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so8983558a91.3;
        Wed, 19 Mar 2025 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742377692; x=1742982492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiTUzGwvFyFv761R//GGBbXNIZo/DnycRt14EYeHTgo=;
        b=SJy7yxrU/M1FyMxUiWCVLsd48I4guklUwqa/AJ2u/o7yP+lhuw3a3JS/UB1sR5wlmH
         nyEl2v69d8nVJw4ANdO5cs51hoj2cJXtxs47OMAyDlOZhhVoWp+bpu1IOFSpjp3D+jAh
         Q4PCx07pB8SRcn48LdsbvuEwKeWj6Ov2d589QuCG45rFDNy56iaG/qgZ12bSo7gaeHj4
         RfXgQjJ9klUv6EWKqakSlB8152ZAI9cOb0XgMKdDav5Qa5xUIlLiPCMMpgs/gjib1Erg
         TNy1oSfgI7YsIKtffTBzL/XYFzBqcPvOKrkSIPSY/CfBIPmNaq7DeRuHKYaK20vnVzhP
         l6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377692; x=1742982492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiTUzGwvFyFv761R//GGBbXNIZo/DnycRt14EYeHTgo=;
        b=a6FuaNHxTHOz1CX6ndVp/i7U6H9P4FYG96crn+11XbswrcLzdhvdJm/A0h0Ej887kf
         dA0hPY8l8Lcb+ZkghgJ65KWC2v2PfJ+7M4RogVDl5iFP0TAFyFPnFUSaFoP74TIsS3dp
         RO0ywPFcoE5kP65GV6KutUe+LDLoGhqMcl0zerE4Je9GEUqIqmu9fFuC8xJ83s7/wWHA
         GXgmEQ5bldLh57iD2JvxczlRzZJL/Dj4BD5HPoeus2XZZXRg+A7MykLHJdWKL5dyB45r
         joG9YSShOYj/dGroMwCBrkPvPwo7fRNnNl2zeHCn5RpzpflUH7rylMm2Ri8pAsru0J0j
         GEYA==
X-Forwarded-Encrypted: i=1; AJvYcCW5KF6jaXxgxLl87JM1BhnGtBBUsc8NAzIu+sq89vxyzMMV3GFlAo8MktHFbBV3X1RekrKSd9GbRsSV@vger.kernel.org, AJvYcCWaOdTYahrU41Fr1h23fV3MbxdgAsimfduCHulpkQpmG/ziljVSQ2DzvEvEJmeVT0LK2UHoeD+VrdD8Otp+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q0PkzHwkr0LrF3LMbtQDCkHWTkkPAaZhj+TCDeWCd+dwE/XE
	ceHkXmn3mETaWH91xuZMX6HHWDoZ2Z6J78F8GEcQIRRI2kyc+eo2Ze3W/w==
X-Gm-Gg: ASbGnctU8/wAth0r4PAiLtMmP0MTQyF3Jf2HFaFpNBo57Mt/ky1k//d2xT8DVDsahJc
	TnCWXPCgFGJ9nV9mq2whXIw3/6B72mb/qqLEhT23k+LO3mEkculTIvVxZJ6i+UtoLF27exVf6FI
	A3yJSbyJYJZTK032/Jzx91/GhetqCVVVs+dmeN62WORWM4RO1eHvjV/0PRzSvwOF/fsstlSrosi
	mwDXW4IzLgMWG2QoKq0ZeYwtBtOoJisxOKq8mezHDGDMMifW1pWAacRrG7NTD6ThvcQRMxzzNXS
	2HtHnv3/m/nCfAgec29xZrnowJ8bojRVJ6k25YWT0eTYpm/+VFzp0WYscBfSdAt15Svn3Ontwzr
	yrY+q4bT99rKt8GWU8MeRho8gNuxHQSOf+9cMxA==
X-Google-Smtp-Source: AGHT+IEin/jt2ASBEcMtODVnqqCgSCoRtBaLeGh0U/3tk7TLTthhHL8kXoEEhL0k2uSwLyJovIffMw==
X-Received: by 2002:a17:90b:4a11:b0:2fe:b174:31fe with SMTP id 98e67ed59e1d1-301bde51a32mr3019875a91.2.1742377692348;
        Wed, 19 Mar 2025 02:48:12 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589bccsm1103483a91.11.2025.03.19.02.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:48:12 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 19 Mar 2025 18:47:45 +0900
Subject: [PATCH 3/3] mtd: spi-nor: spansion: add support for CYRS17B512
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-snor-rdid-dummy-ncycles-v1-3-fbf64e4c226a@infineon.com>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
In-Reply-To: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bacem Daassi <Bacem.Daassi@infineon.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742377674; l=6571;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=oC9jr2u9u9kL8fmEU1SCe11rMhVquUDrj9AQX+3QGZI=;
 b=TVoDc7eh8RNj9bGWHNK0BXFWDvjHKkJETkqaH5rgr0BVxciS9BHCm8k6P8cnic04UzhJhw96c
 a84edkoKF/RAekTKOMVe2JIygSpOc0Q3j3yPei1yRrjT1d/HL00S4W/
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

Add device ID info and fixups to support Infineon CYRS17B512 flash.

Although this flash has untypical features such as dummy cycles in RDID,
inverted erase polarity, larger program page size with automatic page
erase, and larger sector size, it supports basic flash commands
including SFDP.

Link: https://www.infineon.com/dgdl/Infineon-CYRS17B512_512_MB_64_MB_SERIAL_NOR_FLASH_SPI_QSPI_3-DataSheet-v07_00-EN.pdf?fileId=8ac78c8c8fc2dd9c01900eee733d45f3
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Tested on Xilinx Zynq-7000 board and Infineon internal SPI controller.

zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c1601a

zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
spansion

zynq> xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450080102ff00080114000300ff84080102500300ff8700011c5803
00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffffff7ffe2ffffffff1f48eb086b
fffffffffeffffffffffffffffff48eb142017d800ff00ffa028fdffb73f
84a2e0fb1fc4ffff7a75f7ffffff22f65dfff050f8a10000000000002c00
00000000f6fffffff30600fe21dcffff0000800000000000c0ffc3ebc0ff
c3eb00650090066500b1006501950065019671650494716504d000000000
b02e000088a489aa71650393716503930000000000000000000000000000
0000000000000000000000000000000000000000000000000000716503d4
716503d400002020

zynq> md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
a2fec0f47c5aa119e21c3d50a173e2ba  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 1S-1S-1S (fast read)
  opcode        0x0c
  mode cycles   8
  dummy cycles  8
 1S-1S-4S
  opcode        0x6c
  mode cycles   0
  dummy cycles  8
 1S-4S-4S
  opcode        0xec
  mode cycles   2
  dummy cycles  8
 4S-4S-4S
  opcode        0xec
  mode cycles   2
  dummy cycles  8

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 1S-1S-4S
  opcode        0x34

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c1 60 1a 00 00 00
size            64.0 MiB
write size      1
page size       2048
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | SOFT_RESET

opcodes
 read           0xec
  dummy cycles  10
 erase          0xdc
 program        0x34
 8D extension   repeat

protocols
 read           1S-4S-4S
 write          1S-1S-4S
 register       1S-1S-1S

erase commands
 21 (1.00 MiB) [2]
 dc (8.00 MiB) [3]
 c7 (64.0 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-03ffffff |     [   3] | no

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 67108864 (64M)
mtd.erasesize = 8388608 (8M)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> ./test_spi_cyrs17b512.sh
8+0 records in
8+0 records out
8388608 bytes (8.0MB) copied, 0.308282 seconds, 26.0MB/s
Erased 8388608 bytes from address 0x00000000 in flash
Copied 8388608 bytes from address 0x00000000 in flash to spi_read
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0800000
2daeb1f36095b44b318410b3f4e8b5d989dcc7bb023d1426c492dab0a3053e74  spi_read
Copied 8388608 bytes from spi_test to address 0x00000000 in flash
Copied 8388608 bytes from address 0x00000000 in flash to spi_read
8f8842585053d5200d7d80bc766dcf8bbe9f4fea08499c576f67ed631050b6c3  spi_read
8f8842585053d5200d7d80bc766dcf8bbe9f4fea08499c576f67ed631050b6c3  spi_test
Erased 8388608 bytes from address 0x00000000 in flash
Copied 8388608 bytes from address 0x00000000 in flash to spi_read
2daeb1f36095b44b318410b3f4e8b5d989dcc7bb023d1426c492dab0a3053e74  spi_read
8f8842585053d5200d7d80bc766dcf8bbe9f4fea08499c576f67ed631050b6c3  spi_test
---
 drivers/mtd/spi-nor/spansion.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index bf08dbf5e7421f8725a9931e36acaf3f7348db42..5c9588b02b7e61f1b64e5dc61e5c1f976ac58508 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -758,6 +758,18 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
 };
 
+static int cyrs17b_late_init(struct spi_nor *nor)
+{
+	/* Fast Read requires mode cycles */
+	nor->params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
+
+	return 0;
+}
+
+static const struct spi_nor_fixups cyrs17b_fixups = {
+	.late_init = cyrs17b_late_init,
+};
+
 static const struct flash_info spansion_nor_parts[] = {
 	{
 		.id = SNOR_ID(0x01, 0x02, 0x12),
@@ -996,6 +1008,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s28hs02gt",
 		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
+	}, {
+		/* cyrs17b512 */
+		.id = SNOR_ID(0xc1, 0x60, 0x1a),
+		.mfr_flags = USE_CLSR,
+		.fixups = &cyrs17b_fixups
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x13),
 		.name = "s25fl004k",

-- 
2.34.1


