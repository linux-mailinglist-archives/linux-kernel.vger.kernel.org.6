Return-Path: <linux-kernel+bounces-331557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913FC97AE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50755281046
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8016DC2D;
	Tue, 17 Sep 2024 09:50:59 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110115B10C;
	Tue, 17 Sep 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566658; cv=none; b=mDXds6uFJKxX2g5iHUfPGFz5Kn1utNaxF1Pmhh66sbfuJcPWGf7HhEzw8k7ybiILtatUa/Nt4fssFLKhHKJwIm1tGbJlldqrrrBTZXM6kYHz4cZGfuuTjlXsfaPj2QpnVj4uhnAiNF/3jb5dnui8CyPcgerAeZNb1I4DGnFIj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566658; c=relaxed/simple;
	bh=eWv8FFAF66yZo1Jtx2qsOXeX9rjacOvpnZok8MaHeE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCwJ/4RfnMM9E3H+PmG5fDUZp5GIfZaQZr8cl6vkMSUcy3tJjC1xgS1jeXF3okAnrQzqMn7psMSFAERkUiyPlHesANs/d2bY85qF+Yb8nQ4N9ckjZ/WXbt2np+3PnQ1nGZijMz0jUCDGqxS58L4sPo7pXkmXFBVh3baYUPFoZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X7H8h2QgLzMR67;
	Tue, 17 Sep 2024 09:50:44 +0000 (UTC)
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
Subject: [PATCH v4 5/5] mtd: spi-nor: macronix: add manufacturer flags
Date: Tue, 17 Sep 2024 11:49:56 +0200
Message-Id: <20240917094956.437078-6-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240917094956.437078-1-erezgeva@nwtime.org>
References: <20240917094956.437078-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add flag for always trying reading SFDP:
All new chips from Macronix support SFDP.
All old chips in the IDs table were reused by new chips.

Add flag for reading OTP parameters from device tree.
As Macronix reuse JEDEC IDs, there is no way to determine OTP parameters.
Allow users to define the OTP parameters in device tree.

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
    
    $ git diff -U1
    diff --git a/arch/arm/boot/dts/ti/omap/BB-SPINOR-00A0.dtso b/arch/arm/boot/dts/ti/omap/BB-SPINOR-00A0.dtso
    index 333a6b9556ed..adaddfaa8091 100644
    --- a/arch/arm/boot/dts/ti/omap/BB-SPINOR-00A0.dtso
    +++ b/arch/arm/boot/dts/ti/omap/BB-SPINOR-00A0.dtso
    @@ -63,6 +63,8 @@ channel@0 {
                    compatible = "jedec,spi-nor";
    +               otp_len = <512>;
    +               opt_n_regions = <1>;
    
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
    
    * Test that mimic old Macronix chip lack SFDP.
    * In order to check how will the driver cope with an old Macronix chip.
    * As we do not posses such an old chip, we will change RDSFDP to an unused opcode.
    
    $ git diff -U0
    diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
    index 4ebc527aadc1..784cba9b2d0d 100644
    --- a/include/linux/mtd/spi-nor.h
    +++ b/include/linux/mtd/spi-nor.h
    @@ -47 +47 @@
    -#define SPINOR_OP_RDSFDP       0x5a    /* Read SFDP */
    +#define SPINOR_OP_RDSFDP       0x57    /* Read SFDP */
    
    # dmesg | grep spi
    [   42.436974] spi-nor spi0.0: mx25l3205d (4096 Kbytes)
    
    * No error in kernel log!
    
    # ls /sys/bus/spi/devices/spi0.0/spi-nor/
    jedec_id  manufacturer  partname
    
    * No SFDP, as expected!
    
    $ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
    Supported read modes by the flash
     1S-1S-1S
      opcode        0x03
      mode cycles   0
      dummy cycles  0
    
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
     20 (4.00 KiB) [0]
     d8 (64.0 KiB) [1]
     c7 (4.00 MiB)
    
    sector map
     region (in hex)   | erase mask | flags
     ------------------+------------+----------
     00000000-003fffff |     [01  ] |

 drivers/mtd/spi-nor/macronix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 02aa844d641b..f79033e9efa5 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -375,4 +375,5 @@ const struct spi_nor_manufacturer spi_nor_macronix = {
 	.parts = macronix_nor_parts,
 	.nparts = ARRAY_SIZE(macronix_nor_parts),
 	.fixups = &macronix_nor_fixups,
+	.flags = SPI_NOR_MANUFACT_TRY_SFDP | SPI_NOR_MANUFACT_DT_OTP,
 };
-- 
2.39.5


