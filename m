Return-Path: <linux-kernel+bounces-193037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528018D25D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9A1F244D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFA174EC2;
	Tue, 28 May 2024 20:30:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B0F4EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928216; cv=none; b=u7AGkprtvL0D66gHpb5u1qRy9gj7Y7DN3rSbwcFkohafEJVpAUEENwN34va+n9V+JAyTp+HNyYUULHRsTUG4Vqmbk/0osWhDHmR0jqwQUzvV5f6vX6pNJ8mbHaH3dfWU5lFHUm2mjJ0GywfdB7lZe0RgvPnVcP30ZGG7nmuay2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928216; c=relaxed/simple;
	bh=VPSKgjjYli5gLV+KUcp9LcQNDc1487vyy1pMwmdGU3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0VradLLpczBcQBe8TvBOtEdY9AMNnTOq4wMg0dyUidy1xZ2fmNWHu9vUiTgLoq759hoqSfq+XtW2P0ChZRXlrRsPmz7V49k8ic6rlr9eSp41D2mR5FH4mwlrsZbp3+4sTDC5+VuOLLgOKNKn/03EPtM6lsuOtf8RnmRO/MNWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sC3SW-0007Mg-AK; Tue, 28 May 2024 22:30:12 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sC3SU-003N9K-TD; Tue, 28 May 2024 22:30:10 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sC3SU-006Cok-2X;
	Tue, 28 May 2024 22:30:10 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mtd: nand: mxc_nand: always copy_spare() for page write
Date: Tue, 28 May 2024 22:30:06 +0200
Message-Id: <20240528203006.1479230-1-s.hauer@pengutronix.de>
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

When doing a page write we always have to copy the OOB data in place,
as the controller will always write it. Not copying it means we write
random data to the OOB area.

Fixes: 3df54960b63cc ("mtd: nand: mxc_nand: implement exec_op")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Miquel, feel free to fixup the original patch with this.
---
 drivers/mtd/nand/raw/mxc_nand.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 9d50f41b3d5a1..e90c6047e82a5 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -806,8 +806,7 @@ static int mxc_nand_write_page_ecc(struct nand_chip *chip, const uint8_t *buf,
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int ret;
 
-	if (oob_required)
-		copy_spare(mtd, false, chip->oob_poi);
+	copy_spare(mtd, false, chip->oob_poi);
 
 	host->devtype_data->enable_hwecc(chip, true);
 
@@ -823,8 +822,7 @@ static int mxc_nand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	if (oob_required)
-		copy_spare(mtd, false, chip->oob_poi);
+	copy_spare(mtd, false, chip->oob_poi);
 
 	return nand_prog_page_op(chip, page, 0, buf, mtd->writesize);
 }
-- 
2.39.2


