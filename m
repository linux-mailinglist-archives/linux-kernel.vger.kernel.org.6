Return-Path: <linux-kernel+bounces-217581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B490B1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B251F2A064
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8D19A2B2;
	Mon, 17 Jun 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oox7kvXC"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9C19AA59
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631334; cv=none; b=UovkMRdkOzGW1NFkdIHlalqdHE2uo7C1F/ble3Lfn+mueyT1WaSrhJ6rmw9f9PdhR4+MCh/+InT7RLy0e5yPthQyc+uf7aYLgLUO7uwC8VMoyPGBQXUQ3Xrokj5zANsGxoIW6VpMhrKIOB1QetBx3+9zlaGwkkYkU+Z97hQFbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631334; c=relaxed/simple;
	bh=Ejaw2UcHOwsVJe6Dop7ZufRwkMAyG6vDZ5UoXcEF50I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pofyWPvj1my0LCbI+O1ikgn/x3mfSV43o9IdTxgSrFpR+15ydZVXdCNX8qiBLDawXgeUOtD8SoE2phFu5OEg/mJhnH9ME9kTUcE+Pwn74bIa2QWbO/632VvJuH7VGXbqcuesJOc/WHY4b+q7vGP3BFQeEhDF+5zV48zlgSZ17tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oox7kvXC; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A5BDA10000B;
	Mon, 17 Jun 2024 16:35:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A5BDA10000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718631323;
	bh=YcHG6WWlH0ElSTuFNLEX2yBk3OYum4OtJYp6S6fudRY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oox7kvXCIibITAlHTmBPP+PQgiGmN+ytwo7GRD1FAakArfLHnuuCIONgRs7OnI5cb
	 VKlgm6mTm0dfolhKJSvHLPdacW5HP9LsnV2gn3a+BXoIse8ooynrr4Bn6rVhuIlfhT
	 3eVYhBQpky9ptqMS9r8txCdeeoZq/2O2MXxBnpSUoLg8RSiguji0/gK2cYV3/cNtNE
	 mtAK+9xaZH6kdtEFR4JvdOdYc16ikFCAPpw+E6djeq/3cWLaZs3dIdOoIkydH8rhUU
	 rVOX/PYk5QExj5eXwC6vPOYQ+V3om3sq5LgsDaWRoT7Nk5o8ImYhxEfjQ0puNXtUy1
	 DlJNAdGsXuheg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 17 Jun 2024 16:35:23 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 17 Jun 2024 16:35:23 +0300
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, Mark
 Brown <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, Md Sadre
 Alam <quic_mdalam@quicinc.com>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
	<avromanov@salutedevices.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<kernel@salutedevices.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 5/5] mtd: spinand: esmt: OTP access for F50{L,D}1G41LB
Date: Mon, 17 Jun 2024 16:34:57 +0300
Message-ID: <20240617133504.179705-6-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240617133504.179705-1-mmkurbanov@salutedevices.com>
References: <20240617133504.179705-1-mmkurbanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185966 [Jun 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/17 11:22:00 #25639124
X-KSMG-AntiVirus-Status: Clean, skipped

Support for OTP area access on ESMT F50L1G41LB and F50D1G41LB chips.

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 drivers/mtd/nand/spi/esmt.c | 69 +++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 4597a82de23a4..1806e9d48c176 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -12,6 +12,13 @@
 /* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
 #define SPINAND_MFR_ESMT_C8			0xc8
 
+#define ESMT_F50L1G41LB_CFG_OTP_PROTECT		BIT(7)
+#define ESMT_F50L1G41LB_CFG_OTP_LOCK		\
+	(CFG_OTP_ENABLE | ESMT_F50L1G41LB_CFG_OTP_PROTECT)
+
+#define ESMT_F50L1G41LB_PAGE_SIZE		2112
+#define ESMT_F50L1G41LB_OTP_PAGES		28
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
@@ -102,6 +109,60 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 	.free = f50l1g41lb_ooblayout_free,
 };
 
+static int f50l1g41lb_otp_info(struct spinand_device *spinand, size_t len,
+			       struct otp_info *buf, size_t *retlen)
+{
+	if (len < sizeof(*buf))
+		return -EINVAL;
+
+	buf->locked = 0;
+	buf->start = 0;
+	buf->length = ESMT_F50L1G41LB_PAGE_SIZE * ESMT_F50L1G41LB_OTP_PAGES;
+
+	*retlen = sizeof(*buf);
+	return 0;
+}
+
+static int f50l1g41lb_otp_lock(struct spinand_device *spinand, loff_t from,
+			       size_t len)
+{
+	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_OP(true);
+	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_OP(0);
+	int ret;
+
+	ret = spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK,
+			      ESMT_F50L1G41LB_CFG_OTP_LOCK);
+	if (!ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &write_op);
+	if (!ret)
+		goto out;
+
+	ret = spi_mem_exec_op(spinand->spimem, &exec_op);
+	if (!ret)
+		goto out;
+
+	ret = spinand_wait(spinand, 10, 5, NULL);
+	if (!ret)
+		goto out;
+
+out:
+	if (spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK, 0)) {
+		WARN(1, "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static const struct spinand_otp_ops f50l1g41lb_otp_ops = {
+	.info = f50l1g41lb_otp_info,
+	.lock = f50l1g41lb_otp_lock,
+	.read = spinand_otp_read,
+	.write = spinand_otp_write,
+};
+
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
@@ -112,7 +173,9 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
+		     SPINAND_OTP_INFO(ESMT_F50L1G41LB_OTP_PAGES,
+				      &f50l1g41lb_otp_ops)),
 	SPINAND_INFO("F50D1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
 				0x7f, 0x7f),
@@ -122,7 +185,9 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
+		     SPINAND_OTP_INFO(ESMT_F50L1G41LB_OTP_PAGES,
+				      &f50l1g41lb_otp_ops)),
 	SPINAND_INFO("F50D2G41KA",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
 				0x7f, 0x7f),
-- 
2.43.2


