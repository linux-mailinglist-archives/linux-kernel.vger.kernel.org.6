Return-Path: <linux-kernel+bounces-217582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B890B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EA428A844
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA81A38F2;
	Mon, 17 Jun 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gaPSf/+c"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90B1A2FCC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631334; cv=none; b=S0GNkFkBRzV4Z3JKRxQ775uvo5RwWgauV3FgIw5GKp/USCyJ6yESa09UIROuK4/EuMehQcrR7MDT1H+vOXjhoVarQCL2nLdr++lA1xKLIDDeqJpRrPgfBtnog9AXvNAu8ddv5Xxl19ULYCSVIIv+3uzZ+OuhyiE3x1nYgsWwUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631334; c=relaxed/simple;
	bh=iTnMFZlI5mMPKNFaQJ/LO1hJGYd7hSpURWHy+1PTo5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPPAxXK9SWJdmrwPTHzG+rl53MF+vUFFRkE2q2az0k82BoZZqcK7/WeyjS+MPIGLs6pTXwu1yCRgKIBs/Jg/RaVobzHAHLYRhfRxyJQVadzNNjztD+o+LYoi4GuaMDlf3z+uGMbkrUPzqT+OboUs+ff+AnqLhiHhQVU8UxG/xgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gaPSf/+c; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 65F13100007;
	Mon, 17 Jun 2024 16:35:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65F13100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718631322;
	bh=6/RL8IVZXxsdzvdm9UvKBkh1bDI5itnPbUoDhIDETh4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gaPSf/+cuRtm7oF3DuCWDQfBXa7rxFiBrGu1l85VOZhzHH0ScMfuL4FEikFv3fcHw
	 tMTb4dW70EgkcQ5FBobWGQaH2i0jmQaX6e8CZyvIdWBgyISK0e6rZSFXrgArUlgClA
	 sQlFISL7D1f+2BW2Wg9/0Mk8cTAOIPZiaJJjArdPA6NkOwjWHcuMTLLmNfPWFUqFA4
	 KMVPQq+6GSXLaxpCMAFpPCdGVepbfIXkfA87U8uVg96c1PSNN/74FXxhTrTkzmRjzW
	 JReLwX7FiAZcS1ghc0auFpDvkXMW8hKwCMKUe5ZmvNNcoJj7SCrC4lTwUPtLokkHJB
	 F4f6gdinvp/iw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 17 Jun 2024 16:35:22 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 17 Jun 2024 16:35:21 +0300
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
Subject: [PATCH v1 1/5] mtd: spinand: make spinand_{read,write}_page global
Date: Mon, 17 Jun 2024 16:34:53 +0300
Message-ID: <20240617133504.179705-2-mmkurbanov@salutedevices.com>
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

Change these functions from static to global so that to use them later
in OTP operations. Since reading OTP pages is no different from reading
pages from the main area.

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 drivers/mtd/nand/spi/core.c | 24 ++++++++++++++++++++----
 include/linux/mtd/spinand.h |  6 ++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfed..807c24b0c7c4f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -566,8 +566,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req)
+/**
+ * spinand_read_page() - Read the page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -597,8 +605,16 @@ static int spinand_read_page(struct spinand_device *spinand,
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_write_page(struct spinand_device *spinand,
-			      const struct nand_page_io_req *req)
+/**
+ * spinand_write_page() - Write the page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead604996..555846517faf6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -519,4 +519,10 @@ int spinand_match_and_init(struct spinand_device *spinand,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req);
+
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.43.2


