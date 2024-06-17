Return-Path: <linux-kernel+bounces-217579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CEA90B1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7473283DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D871A38CC;
	Mon, 17 Jun 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AmHPfDiT"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33331A2FC2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631333; cv=none; b=Q6faom7USboPclUUkD9VnwbvN4fdUhPM4p1WxOY57zDNLUX7AQLh7omvjVlMlbLztYFJo7YYXsul0MaRdsVbX3gjJQR9rHUNRfKHwlCZGT36hFbfMeNIMhpIHuer74lvGuni6sYLJ4oaYoseJhs+fCeITRW/FKrk0Rg3dnYhqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631333; c=relaxed/simple;
	bh=35WKRlgt95dlXzrYED3ZuLd2zlL2yZUiX9zfMTO7aB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYanKtN6IzZkr4VDTnpvZI7aMYM/xn4x8mpmtnr7bOw5wrlNXlKxhcf2BivgxhM8lg5j5hO8+BHD2nBCm7gjOdZVBJBVNUm14ntplYqutG9PX6HHjywh4IgZQriV6q6SVBba/jKvMG+3a61fvz+gcKGFBLRXFcNUjRwa0MzhjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AmHPfDiT; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1D6CB100009;
	Mon, 17 Jun 2024 16:35:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D6CB100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718631323;
	bh=s3IdEpoU8Idriuk8g63QAeoI/TR/7zBrB1N7H/17w8U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AmHPfDiTxt1A03tynXh9e4ElOYSFwA3pboSyYhjiSNG8gKbnaYEZAZZMOSy6rwT1x
	 y4WyLGydxdIAhK7mFXjCMFz0gCGChrXigonvXRyRzMmsCTESZyRjUc1uU40TgPhgxQ
	 7Rii47N1O2fy7bzmaP7fvLDGk3fcUpd/C1Pd2vLou5cx0GljRkqT7nvOXaKQQFfbUb
	 dUGzzHs7Ot/Noyca2lt8U1joca4VAqTw5Z287f85cphupiZRAxk101WBU4vBUhRX2x
	 QLs88HsEufe8DnBR+MWI7Vn1WnvCH/t8vuGlocrP4f98uhd2L2KJ7CPjcUM3ZTVw3F
	 traq7Z2IKwx1g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 17 Jun 2024 16:35:22 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 17 Jun 2024 16:35:22 +0300
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
Subject: [PATCH v1 3/5] mtd: spinand: make spinand_wait() global
Date: Mon, 17 Jun 2024 16:34:55 +0300
Message-ID: <20240617133504.179705-4-mmkurbanov@salutedevices.com>
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

Change the function spinand_wait() from static to global so that SPI
NAND flash drivers don't duplicate it.

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 drivers/mtd/nand/spi/core.c | 18 ++++++++++++++----
 include/linux/mtd/spinand.h |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2cb825edd49d0..c3e3d1e9599f1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -496,10 +496,20 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
 						      spinand->scratchbuf);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index a0d42a9be333f..3b9e7ed32c81d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -567,6 +567,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
+
 int spinand_read_page(struct spinand_device *spinand,
 		      const struct nand_page_io_req *req);
 
-- 
2.43.2


