Return-Path: <linux-kernel+bounces-256249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30D934B66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B835B2861D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA812DD90;
	Thu, 18 Jul 2024 09:59:03 +0000 (UTC)
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661E12C473
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296743; cv=none; b=DsoxefscJzNa3ANDDQ3t9EQ5TRXGub5J5qFNdEHJm4pBt1yVVl4yLJEuYGVL1lo7BbRyAwTjXFFR48msZd2iToY6Zme4zVbX0FlrIpQniG4AX1lYUGxKrmO++svFDtralZrtqbZ3STSRvrzKuqG36DDztwktE4qC/7G9pSt4bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296743; c=relaxed/simple;
	bh=v4by6bgnQXiKjVYmoSPRJuBhtlsRBc1VrfHgzzBhkjo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DcnCcPEoN/G7iZWyihrRWDxysNhoTrEipy0QOMi28+Zi+/kAT56H/xrc9dpXfQce0IqMctI99ZNlfLhgwzymNtcnllHCTy09Q+aMGiLFEiNat5UoQe2/MIoJbE6obvH8JNJnsRdMp7264fHttjHe1+XMCmQNs5J8pMubqLbBtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8XTKk009511;
	Thu, 18 Jul 2024 08:57:53 GMT
Received: from usgdcecpmsgae02.extemr.org ([144.191.128.198])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 40exwq18mr-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:57:53 +0000 (GMT)
Received: from usgdcecpmsgap04.emrsn.org (10.16.75.145) by mail.emerson.com
 (10.16.11.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Jul
 2024 08:58:50 +0000
Received: from usgdcecpmsgap03.emrsn.org (10.16.75.148) by
 usgdcecpmsgap04.emrsn.org (10.16.75.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Jul 2024 08:57:27 +0000
Received: from 5QFXWL3.emrsn.org (10.19.249.15) by Inetmail.emrsn.net
 (10.16.75.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11 via Frontend
 Transport; Thu, 18 Jul 2024 08:57:26 +0000
Date: Thu, 18 Jul 2024 10:57:24 +0200
From: <claus.fabig@emerson.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB
Message-ID: <ZpjY9APb+VdiFO0q@5QFXWL3.emrsn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: v-0U3i_2ByPejOrGBivh_emSo_R_hcd-
X-Proofpoint-GUID: v-0U3i_2ByPejOrGBivh_emSo_R_hcd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180056

From: Claus Fabig <claus.fabig@emerson.com>
Date: Thu, 18 Jul 2024 09:53:36 +0200
Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB

The Everspin EM008LXB MRAM has 8Mb and is populated on a custom board
using Microchip's PCI12000 spi host controller running on low 30MHz clock.
According to Everspin Read Fast (0xb) command below 60MHz is neither
specified and nor tested. Test shows that using Read Fast (0xb) will
result in reading inconsistent data in this setup but writing is fine, so
only supporting Read (0x3) command should be acceptable for the moment.
The device is JEDEC compatible (JESD251 and JESD251-1) but not able to
provide SFDP information.

For spec v3.2 refer to www.everspin.com/file/158315/download.

Successfully tested according to
www.kernel.org/doc/html/latest/driver-api/mtd/spi-nor.html:

cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/partname
em008lxb

cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/manufacturer
everspin

cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x03
  mode cycles   0
  dummy cycles  0

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x02

cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/params
name            em008lxb
id              (null)
size            1.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_SR_TB | HAS_16BIT_SR | HAS_4BIT_BP | HAS_SR_BP3_BIT6

opcodes
 read           0x03
  dummy cycles  0
 erase          0xd8
 program        0x02
 8D extension   none

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 d8 (1.00 MiB) [0]
 c7 (1.00 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-000fffff |     [0   ] | no

cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00020000 00020000 "spi-EMR1010:00"
mtd1: 00100000 00100000 "spi-EMR5555:00"

mtd_debug info /dev/mtd1
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 1048576 (1M)
mtd.erasesize = 1048576 (1M)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

dd if=/dev/urandom of=spi_test bs=1M count=1
mtd_debug erase /dev/mtd1 0 1048576
mtd_debug read /dev/mtd1 0 1048576 spi_read
Copied 1048576 bytes from address 0x00000000 in flash to spi_read
hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0100000
sha256sum spi_read
f5fb04aa5b882706b9309e885f19477261336ef76a150c3b4d3489dfac3953ec  spi_read
mtd_debug write /dev/mtd1 0 1048576 spi_test
Copied 1048576 bytes from spi_test to address 0x00000000 in flash
mtd_debug read /dev/mtd1 0 1048576 spi_read
Copied 1048576 bytes from address 0x00000000 in flash to spi_read
sha256sum spi*
cf9a1f3f4089602d194d67d1a918a574a5ca1d9aa71d391a661818c1f0ee1aab  spi_read
cf9a1f3f4089602d194d67d1a918a574a5ca1d9aa71d391a661818c1f0ee1aab  spi_test

Signed-off-by: claus.fabig@emerson.com
---
 drivers/mtd/spi-nor/core.c     | 2 +-
 drivers/mtd/spi-nor/everspin.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e0c4efc424f4..95267d9e8b65 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3713,7 +3713,7 @@ static const struct spi_device_id spi_nor_dev_ids[] = {
 	{ "mr25h256" }, /* 256 Kib, 40 MHz */
 	{ "mr25h10" },  /*   1 Mib, 40 MHz */
 	{ "mr25h40" },  /*   4 Mib, 40 MHz */
-
+	{ "em008lxb" }, /*   8 Mib, 133 MHz */
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, spi_nor_dev_ids);
diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index add37104d673..c1f004c39c1c 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -31,6 +31,11 @@ static const struct flash_info everspin_nor_parts[] = {
 		.size = SZ_512K,
 		.sector_size = SZ_512K,
 		.flags = SPI_NOR_NO_ERASE,
+	}, {
+		.name = "em008lxb",
+		.size = SZ_1M,
+		.sector_size = SZ_1M,
+		.flags = SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
 	}
 };
 
-- 
2.45.2


