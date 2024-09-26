Return-Path: <linux-kernel+bounces-340714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C29876F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2B41C21DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495D815B552;
	Thu, 26 Sep 2024 15:52:12 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038315B0EB;
	Thu, 26 Sep 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365931; cv=none; b=ZICoWXhPWtrWBfIqDCqpdII5/ELH60fHx5MnHjGRuXZUc2rY2hdY5o3UUrv+M7mjX4fQP7IBShSYSlhWLbZmj/WcRlkfQ+cQ4qbV/hD9micVRHLAffVx8loFvMqRSUpRnS9unQJji3WfYjdBarQQU6+zOx4+MvN2fXrX+O5zN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365931; c=relaxed/simple;
	bh=BClKuSrVJ/0jBjhwm01n2LfswUZWSekAFNWx/+cezTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxUGhztamHOoGo5hriw8pDnm6bOMADRpVnzjTShJqTYSqxFNXJOaVT2t4jN6Pu+l5ztK7MbJns7dEN8itJNak7pdA2vW8e2AbbeQVYk0KL4ISf7qzyLRcJycRkp2lEk4uCeXXVdOGl8oIajD78mD3KEsGGeoeePxUiHYvK2AZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4XDylJ03KGzMRC4;
	Thu, 26 Sep 2024 15:51:55 +0000 (UTC)
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
	Esben Haabendal <esben@geanix.com>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v6 3/3] mtd: spi-nor: macronix: add support for OTP
Date: Thu, 26 Sep 2024 17:51:27 +0200
Message-Id: <20240926155127.2450246-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240926155127.2450246-1-erezgeva@nwtime.org>
References: <20240926155127.2450246-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Macronix SPI-NOR support OTP.
Add callbacks to read, write and lock the OTP.

Notice Macronix OTP do not support erase.
Every bit written with '0', can not be changed further.

Notice Macronix OTP do not support single region lock!
The locking includes all regions at once!

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---

Notes:
    * My initial Macronix OTP code was tested with MX25l12833F.
    * As I no longer have that hardware.
    
    * I now testing with MX25L3233F connected to my BeagleBone Black
    *  through an 8-PIN SOP (200mil).
    * The BeagleBone Black runs with Debian GNU/Linux 12.
    * And use Kernel 6.6.32-ti-arm32-r5 build with
    *  arm-linux-gnueabihf-gcc gcc version 12.2.0 (Debian 12.2.0-14).
    
    * With current kernel, the driver do not read the SFDP of MX25L3233F.
    * The patch to read the SFDP is NOT part of this patch seria
    
    $ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
    c22016
    $ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
    macronix
    $ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
    mx25l3205d
    $ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
    53464450000101ff00000109300000ffc2000104600000ffffffffffffff
    ffffffffffffffffffffffffffffffffffffe520f1ffffffff0144eb086b
    083b04bbeeffffffffff00ffffff00ff0c200f5210d800ffffffffffffff
    ffffffffffff003650269ef97764fecfffffffffffff
    $ sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
    22d5d34af77c3628300056a0fc4bfbeafa027f544998852cf27f7cebf7881196  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
    
    $ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
    Supported read modes by the flash
     1S-1S-1S
      opcode        0x03
      mode cycles   0
      dummy cycles  0
     1S-1S-2S
      opcode        0x3b
      mode cycles   0
      dummy cycles  8
     1S-2S-2S
      opcode        0xbb
      mode cycles   0
      dummy cycles  4
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
    
    $ cat /sys/kernel/debug/spi-nor/spi0.0/params
    name            mx25l3205d
    id              c2 20 16 c2 20 16
    size            4.00 MiB
    write size      1
    page size       256
    address nbytes  3
    flags           HAS_16BIT_SR
    
    opcodes
     read           0x03
      dummy cycles  0
     erase          0x20
     program        0x02
     8D extension   none
    
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
    
    # mtd_debug info /dev/mtd0
    mtd.type = MTD_NORFLASH
    mtd.flags = MTD_CAP_NORFLASH
    mtd.size = 4194304 (4M)
    mtd.erasesize = 4096 (4K)
    mtd.writesize = 1
    mtd.oobsize = 0
    regions = 0
    
    * The BeagleBone Black SPI is very slow, Tests are slow.
    
    # dd if=/dev/urandom of=./spi_test bs=1M count=2
    2+0 records in
    2+0 records out
    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0682607 s, 30.7 MB/s
    
    # time mtd_debug erase /dev/mtd0 0 2097152
    Erased 2097152 bytes from address 0x00000000 in flash
    
    real    0m12.703s
    user    0m0.000s
    sys     0m12.692s
    
    # time mtd_debug read /dev/mtd0 0 2097152 spi_read
    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
    
    real    0m1.942s
    user    0m0.000s
    sys     0m0.053s
    
    # hexdump spi_read
    0000000 ffff ffff ffff ffff ffff ffff ffff ffff
    *
    0200000
    
    # sha256sum spi_read
    4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
    
    # time mtd_debug write /dev/mtd0 0 2097152 spi_test
    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
    
    real    0m5.883s
    user    0m0.006s
    sys     0m3.970s
    
    # time mtd_debug read /dev/mtd0 0 2097152 spi_read
    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
    
    real    0m2.208s
    user    0m0.003s
    sys     0m0.063s
    
    # sha256sum spi*
    f4f5d1d0a4fef487037cdb3f1be0f9aab68ca32f2dbe8782c927f03adf623ec3  spi_read
    f4f5d1d0a4fef487037cdb3f1be0f9aab68ca32f2dbe8782c927f03adf623ec3  spi_test
    
    # time mtd_debug erase /dev/mtd0 0 2097152
    Erased 2097152 bytes from address 0x00000000 in flash
    
    real    0m12.126s
    user    0m0.001s
    sys     0m12.115s
    
    # time mtd_debug read /dev/mtd0 0 2097152 spi_read
    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
    
    real    0m2.611s
    user    0m0.000s
    sys     0m0.064s
    
    # sha256sum spi*
    4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
    f4f5d1d0a4fef487037cdb3f1be0f9aab68ca32f2dbe8782c927f03adf623ec3  spi_test
    
    * MX25L3233F OTP uses 1 region of size of 4096 bits
    
    * I configure 1 OTP region with 512 bytes length.
    * The OTP configure is NOT part of this patch seria
    
    # flash_otp_info -u /dev/mtd0
    Number of OTP user blocks on /dev/mtd0: 1
    block  0:  offset = 0x0000  size = 512 bytes  [unlocked]
    
    # flash_otp_dump -u /dev/mtd0
    OTP user data for /dev/mtd0
    0x0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x00f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x0190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    0x01f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    
    * Macronix OTP does not support erase!
    * flash_otp_erase
    
    # printf '\xde\xad%.0s' {1..256} | flash_otp_write -u /dev/mtd0 0
    Writing OTP user data on /dev/mtd0 at offset 0x0
    Wrote 512 bytes of OTP user data
    
    # flash_otp_dump -u /dev/mtd0
    OTP user data for /dev/mtd0
    0x0000: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0010: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0020: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0030: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0040: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0050: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0060: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0070: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0080: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0090: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00f0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0100: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0110: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0120: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0130: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0140: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0150: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0160: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0170: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0180: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0190: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01f0: de ad de ad de ad de ad de ad de ad de ad de ad
    
    # flash_otp_info -u /dev/mtd0
    Number of OTP user blocks on /dev/mtd0: 1
    block  0:  offset = 0x0000  size = 512 bytes  [unlocked]
    
    # printf '\xff\xff%.0s' {1..256} | flash_otp_write -u /dev/mtd0 0
    Writing OTP user data on /dev/mtd0 at offset 0x0
    Wrote 512 bytes of OTP user data
    
    # We cannot overwrite '0' with '1'!
    
    # flash_otp_dump -u /dev/mtd0
    OTP user data for /dev/mtd0
    0x0000: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0010: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0020: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0030: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0040: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0050: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0060: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0070: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0080: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0090: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00f0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0100: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0110: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0120: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0130: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0140: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0150: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0160: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0170: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0180: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0190: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01f0: de ad de ad de ad de ad de ad de ad de ad de ad
    
    # flash_otp_lock -u /dev/mtd0 0 512
    About to lock OTP user data on /dev/mtd0 from 0x0 to 0x200
    flash_otp_lock: Are you sure? (y/N) y
    Done.
    
    # flash_otp_info -u /dev/mtd0
    Number of OTP user blocks on /dev/mtd0: 1
    block  0:  offset = 0x0000  size = 512 bytes  [locked]
    
    # printf '\x00\x00%.0s' {1..256} | flash_otp_write -u /dev/mtd0 0
    Writing OTP user data on /dev/mtd0 at offset 0x0
    write(): Read-only file system
    
    # flash_otp_dump -u /dev/mtd0
    OTP user data for /dev/mtd0
    0x0000: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0010: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0020: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0030: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0040: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0050: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0060: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0070: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0080: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0090: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x00f0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0100: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0110: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0120: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0130: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0140: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0150: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0160: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0170: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0180: de ad de ad de ad de ad de ad de ad de ad de ad
    0x0190: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01a0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01b0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01c0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01d0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01e0: de ad de ad de ad de ad de ad de ad de ad de ad
    0x01f0: de ad de ad de ad de ad de ad de ad de ad de ad

 drivers/mtd/spi-nor/macronix.c | 167 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   9 ++
 2 files changed, 176 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..bee62e9051d6 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,162 @@
 
 #include "core.h"
 
+/**
+ * macronix_nor_otp_enter() - Send Enter Secured OTP instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_enter(struct spi_nor *nor)
+{
+	int error;
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_ENSO);
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix Enter Secured OTP\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_exit() - Send Exit Secured OTP instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_exit(struct spi_nor *nor)
+{
+	int error;
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_EXSO);
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix Exit Secured OTP\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_read() - read OTP data
+ * @nor:	pointer to 'struct spi_nor'
+ * @addr:       offset to read from
+ * @len:        number of bytes to read
+ * @buf:        pointer to dst buffer
+ *
+ * Return: number of bytes read successfully, -errno otherwise
+ */
+static int macronix_nor_otp_read(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
+{
+	int ret, error;
+
+	error = macronix_nor_otp_enter(nor);
+	if (error)
+		return error;
+
+	ret = spi_nor_read_data(nor, addr, len, buf);
+
+	error = macronix_nor_otp_exit(nor);
+
+	if (ret < 0)
+		dev_dbg(nor->dev, "error %d on Macronix read OTP data\n", ret);
+	else if (error)
+		return error;
+
+	return ret;
+}
+
+/**
+ * macronix_nor_otp_write() - write data to OTP
+ * @nor:        pointer to 'struct spi_nor'
+ * @addr:       offset to write to
+ * @len:        number of bytes to write
+ * @buf:        pointer to src buffer
+ *
+ * Return: number of bytes written successfully, -errno otherwise
+ */
+static int macronix_nor_otp_write(struct spi_nor *nor, loff_t addr, size_t len, const u8 *buf)
+{
+	int error, ret = 0;
+
+	error = macronix_nor_otp_enter(nor);
+	if (error)
+		return error;
+
+	error = spi_nor_write_enable(nor);
+	if (error)
+		goto otp_write_err;
+
+	ret = spi_nor_write_data(nor, addr, len, buf);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d on Macronix write OTP data\n", ret);
+		goto otp_write_err;
+	}
+
+	error = spi_nor_wait_till_ready(nor);
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix waiting write OTP finish\n", error);
+
+otp_write_err:
+
+	error = macronix_nor_otp_exit(nor);
+
+	return ret;
+}
+
+/**
+ * macronix_nor_otp_lock() - lock the OTP
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_lock(struct spi_nor *nor, unsigned int region)
+{
+	int error;
+	u8 *rdscur = nor->bouncebuf;
+
+	error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on read security register\n", error);
+		return error;
+	}
+
+	if (rdscur[0] & SEC_REG_LDSO)
+		return 0;
+
+	error = spi_nor_write_enable(nor);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on enable write before update security register\n",
+			error);
+		return error;
+	}
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_WRSCUR);
+	if (error)
+		dev_dbg(nor->dev, "error %d on update security register\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_is_locked() - get the OTP lock status
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Return: 1 on lock, 0 on not locked, -errno otherwise.
+ */
+static int macronix_nor_otp_is_locked(struct spi_nor *nor, unsigned int region)
+{
+	int error;
+	u8 *rdscur = nor->bouncebuf;
+
+	error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on read security register\n", error);
+		return error;
+	}
+	return rdscur[0] & SEC_REG_LDSO ? 1 : 0;
+}
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -190,8 +346,19 @@ static void macronix_nor_default_init(struct spi_nor *nor)
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
+static const struct spi_nor_otp_ops macronix_nor_otp_ops = {
+	.read = macronix_nor_otp_read,
+	.write = macronix_nor_otp_write,
+	/* .erase = Macronix OTP do not support erase, */
+	.lock = macronix_nor_otp_lock,
+	.is_locked = macronix_nor_otp_is_locked,
+};
+
 static int macronix_nor_late_init(struct spi_nor *nor)
 {
+	if (nor->params->otp.org.n_regions)
+		nor->params->otp.ops = &macronix_nor_otp_ops;
+
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..ef834e7fc0ac 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -81,6 +81,15 @@
 #define SPINOR_OP_BP		0x02	/* Byte program */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
+/* Macronix OTP registers. */
+#define SPINOR_OP_RDSCUR	0x2b	/* read security register */
+#define SPINOR_OP_WRSCUR	0x2f	/* write security register */
+#define SPINOR_OP_ENSO		0xb1	/* enter secured OTP */
+#define SPINOR_OP_EXSO		0xc1	/* exit secured OTP */
+
+/* Macronix security register values */
+#define SEC_REG_LDSO		BIT(1)  /* Lock-down Secured OTP */
+
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-- 
2.39.5


