Return-Path: <linux-kernel+bounces-281017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFA94D1F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329991F222B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D9196DA4;
	Fri,  9 Aug 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="S0u+U4+c"
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5C198A0D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212863; cv=none; b=q/ipIjojqXfhiyToHdCVX2ct0/ldxaPZYpOFXUVtWUZI9YS0EtsEUwu7/T9J8gY2gAfNrckml4paO0h1dA3lXDAfWGoqmol+M44qUKyAdiQgaHeIoqbFQdRUO/EjzvVPcMsc+00MguW0FrDnbLaztU1yNN7+4mCE0lCxwXTXTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212863; c=relaxed/simple;
	bh=k0lXxdUujEHbSE4su7DMaLb+8ejwBxpqdvYGku1UOu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdW8HhDY444lK6u09SaDg5W64wZG2DcvdZCY2nSrmey+NbGCraSqrnj/4TzVV+uZjciJwYtzSx/FFt0Op7YdKq7RglvDkprs9lAs18cZiDY6jaNARwnzrJasxfMvMPi7hQoutUyllgBiYajdmlrqYfbTp4WSaRshw1lsToiTbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=S0u+U4+c; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479C4eFv004134;
	Fri, 9 Aug 2024 13:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=email; bh=IXuzo+k1Fuz
	U2qFtsu2QEn/iOLlKK50tpT2YpCc7BLo=; b=S0u+U4+c20+I+JaBO+MRF9CNY79
	hed6TRlrsljcIvzAgKkwXfp2BcYoIQ9UEe3nYm8QYtlsiLzGjImFkoClf1sInEsP
	n8yEtbSDbURC6KFACcH3Ys1zSg+Kh9QAFsCDLQhnTB/eXEJV7zGEl3kREAEM3Ehd
	hhZOUDND9YrT44KQ5b77GTRVxqNEyU9KIkA0vw/vySoo6+0Invbw3O7PHCTEMOPf
	FhWa+ZmEfr3hVLl1u4dg8m4VClUKv1G45mqJF0gfRUmOUhkfYklFkfdHGbCIwPce
	N95Is2d/wBfKOuAcyKIthkvHnxBJgL/JbWldfRCdmfqtpfyRhjaycD0ElcA==
Received: from usgdcecpmsgae03.extemr.org ([144.191.128.204])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 40wjsk1bta-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 13:24:55 +0000 (GMT)
Received: from usgdcecpmsgap05.emrsn.org (10.16.75.137) by mail.emerson.com
 (10.16.11.129) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 13:25:28 +0000
Received: from usgdcecpmsgap05.emrsn.org (10.16.75.137) by
 usgdcecpmsgap05.emrsn.org (10.16.75.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 13:24:40 +0000
Received: from localhost.localdomain (10.19.249.15) by Inetmail.emrsn.net
 (10.16.75.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11 via Frontend
 Transport; Fri, 9 Aug 2024 13:24:38 +0000
From: Claus Fabig <claus.fabig@emerson.com>
To: <claus.fabig@emerson.com>, <mwalle@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mtd: spi-nor: add support for MRAM Everspin EM008LX
Date: Fri, 9 Aug 2024 15:21:58 +0200
Message-ID: <20240809132246.3395-1-claus.fabig@emerson.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RFcVTwCqkTrzuRZrgTpuLLKXg_H3yzgQ
X-Proofpoint-ORIG-GUID: RFcVTwCqkTrzuRZrgTpuLLKXg_H3yzgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_10,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090097

The Everspin EM008LX MRAM has 8Mb and is populated on a custom board
using Microchip's PCI12000 spi host controller running on low 30MHz clock.
According to Everspin Read Fast (0xb) command below 60MHz is neither
specified and nor tested. Test shows that using Read Fast (0xb) will
result in reading inconsistent data in this setup but writing is fine, so
only supporting Read (0x3) command should be acceptable for the moment.
The device is JEDEC compatible (JESD251 and JESD251-1) but not able to
provide SFDP information.

For spec v3.2 refer to Link: https://www.everspin.com/file/158315/download.

Successfully tested according to
Link: https://www.kernel.org/doc/html/latest/driver-api/mtd/spi-nor.html.

Signed-off-by: Claus Fabig <claus.fabig@emerson.com>
---
Changes in V2:
 - add id for probing instead of name
 - change sector size from 1MB to 64k

test em008lxb MRAM
cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/partname
em008lx
cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/jedec_id
6bbb14
cat /sys/bus/spi/devices/spi-EMR5555\:00/spi-nor/manufacturer
everspin
cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode	0x03
  mode cycles	0
  dummy cycles	0

Supported page program modes by the flash
 1S-1S-1S
  opcode	0x02
cat /sys/kernel/debug/spi-nor/spi-EMR5555\:00/params
name		em008lx
id		6b bb 14 10 48 5f
size		1.00 MiB
write size	1
page size	256
address nbytes	3
flags		HAS_SR_TB | HAS_16BIT_SR | HAS_4BIT_BP | HAS_SR_BP3_BIT6

opcodes
 read		0x03
  dummy cycles	0
 erase		0xd8
 program	0x02
 8D extension	none

protocols
 read		1S-1S-1S
 write		1S-1S-1S
 register	1S-1S-1S

erase commands
 d8 (64.0 KiB) [0]
 c7 (1.00 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+----------
 00000000-000fffff |     [0   ] | no
cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00020000 00020000 "spi-EMR1010:00"
mtd1: 00100000 00010000 "spi-EMR5555:00"
mtd_debug info /dev/mtd1
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 1048576 (1M)
mtd.erasesize = 65536 (64K)
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
8b73cb3cf9a032236fc3f41c974fced7b8dd43262628c5425f178c84ad619965  spi_read
8b73cb3cf9a032236fc3f41c974fced7b8dd43262628c5425f178c84ad619965  spi_test

 drivers/mtd/spi-nor/everspin.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index add37104d673..178529ed0a28 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -31,6 +31,12 @@ static const struct flash_info everspin_nor_parts[] = {
 		.size = SZ_512K,
 		.sector_size = SZ_512K,
 		.flags = SPI_NOR_NO_ERASE,
+	}, {
+		.id = SNOR_ID(0x6b, 0xbb, 0x14),
+		.name = "em008lx",
+		.size = SZ_1M,
+		.sector_size = SZ_64K,
+		.flags = SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
 	}
 };
 
-- 
2.43.0


