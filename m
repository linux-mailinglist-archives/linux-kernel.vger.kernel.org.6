Return-Path: <linux-kernel+bounces-178761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693D8C5749
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142471C21902
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327091448C5;
	Tue, 14 May 2024 13:41:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67D13E030
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694114; cv=none; b=KUVnhN6zF4rkiN+8FLxp2eeOiPIP3C1iq3nnL+wmzsN9wD48E2BxpbfgjPuaIPeZO8khbYNMH5Oeh0IuF+Ekd8nhO135qKNRVqTSyJsb83RcW3u4pILHa07vnpTKyUOVc/0owrWi/mnI5zTjFWtoT1l4kqdQBnXU5McMi95YwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694114; c=relaxed/simple;
	bh=AG+Ue9kB0biuaCxRpv5D3JyapkxKk0KbbofClJQTYiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNywS8TOraJJ222DT0EfCbnPdaEfb4J1sr+1yqSyMbRBYyUl1GYH0BKNBWiQGu5Adm5ZfnfJfNx1M3K6Sfo0t0enJ/ILZGx+QA+BKcSGpYVgcJVTCcZL3gsHoM2eeeoZxK+34oJT/r3jj+NlkmHOgL6ayTb1oAq5osEfWP3AMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6sPX-0002ov-DC; Tue, 14 May 2024 15:41:43 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6sPW-001MiW-1J; Tue, 14 May 2024 15:41:42 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6sPV-004PBy-2w;
	Tue, 14 May 2024 15:41:41 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mtd: rawnand: onfi: read parameter pages in one go
Date: Tue, 14 May 2024 15:41:40 +0200
Message-Id: <20240514134140.1050141-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

nand_read_data_op() is not supported by all NAND controllers.
nand_change_read_column_op() is not supported or at least is hard to
support by NAND controllers that use a different page layout than
expected by the NAND core. Instead of relying on these functions
just read the three parameter pages in one go.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/nand_onfi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index 861975e44b552..df1750692404d 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -148,7 +148,6 @@ int nand_onfi_detect(struct nand_chip *chip)
 	struct nand_memory_organization *memorg;
 	struct nand_onfi_params *p = NULL, *pbuf;
 	struct onfi_params *onfi;
-	bool use_datain = false;
 	int onfi_version = 0;
 	char id[4];
 	int i, ret, val;
@@ -166,25 +165,11 @@ int nand_onfi_detect(struct nand_chip *chip)
 	if (!pbuf)
 		return -ENOMEM;
 
-	if (!nand_has_exec_op(chip) || chip->controller->supported_op.data_only_read)
-		use_datain = true;
+	ret = nand_read_param_page_op(chip, 0, pbuf, sizeof(*pbuf) * ONFI_PARAM_PAGES);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < ONFI_PARAM_PAGES; i++) {
-		if (!i)
-			ret = nand_read_param_page_op(chip, 0, &pbuf[i],
-						      sizeof(*pbuf));
-		else if (use_datain)
-			ret = nand_read_data_op(chip, &pbuf[i], sizeof(*pbuf),
-						true, false);
-		else
-			ret = nand_change_read_column_op(chip, sizeof(*pbuf) * i,
-							 &pbuf[i], sizeof(*pbuf),
-							 true);
-		if (ret) {
-			ret = 0;
-			goto free_onfi_param_page;
-		}
-
 		crc = onfi_crc16(ONFI_CRC_BASE, (u8 *)&pbuf[i], 254);
 		if (crc == le16_to_cpu(pbuf[i].crc)) {
 			p = &pbuf[i];
-- 
2.39.2


