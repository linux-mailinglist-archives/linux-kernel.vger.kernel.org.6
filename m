Return-Path: <linux-kernel+bounces-247321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F203B92CE00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B01C21A89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39118D4BB;
	Wed, 10 Jul 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Z50GdAvE"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78284A28
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602911; cv=none; b=HGj76N36fFCC9BrQ2/8b02JGFNXFHY3EikApfjqCA+RfmxP5o55VSW6lYZ4h5VmimnVuLGYLDH7+yvgmMh+zeotRo1IPvQO6LMy5+0hzmfDYbLy5S1etdLnPVJ3tdMyU4YNUdfVa8jwzbcMe2qEQEHxmKo9EE7qNgJtJf+cICrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602911; c=relaxed/simple;
	bh=b2bPxOZ8FtzU9jdf9PzyWfJweVqYxNip8z8TgoZ4jo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNtb2o3BSY0YW376olc4ruVhF4JI4VowzlzNmWrFbnnQZxhW9AHMuAfvUtxWfaPXZFe7WqoHyX/LxhsZYZTFHWDGfCP+xV4QolxHklDG5ade45KY+UKXa4NtuSrqkosfSMp1JaAhc2hQM+DoBlTsw1Vx7l7FIceKIQz+paVjhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Z50GdAvE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A98E2A05EC;
	Wed, 10 Jul 2024 11:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=8i40Vuw+IuYEzl6a9Xr69NauHgXUINvZ77epVTOrtQo=; b=
	Z50GdAvExkv3NnypvITdQM2xmrzqWeMaOm5QMq3OBtRvAAOEifvmwPoXs2UVXu2Q
	oOHxpjo+o0qh1c97Pb+C3szrvmWJ998CE6ysvbQCqSSt8R+yQ8h7hGZAOwfyaPOX
	a/cdZ95LUDQmSabiyUdkciWo49x9vCSqeFn0dBKouMHm1rwqF1Ph31jlj7tLeswy
	NsMj05ng3hv+aNTT4jrE//wqANKKzaVQte/QMhhxzeSHdqvJGA51FKRLOmRlZpq5
	870eCCW6OIMOHk7lbUqpeXMNkIApu+dQ3F+ExLt98g7rDjOwfQCncTZ8kSXkXQl9
	5n/LB2MxqKJHJ+nhYnpmyjCSBFbHxo71KTnUVMQ3fNvjxOyAmP8q8RV3XceCoLuD
	vjfP0y3OU9ZKi6+0qqJ8pQTF8ieDKJ6QA9vw5zO22HvE8IHR+zvec9jD+puNGF8R
	N4snsRXeLjIoLO61wRQsrwWddJocxZQIIf7DrA7IuoWy2y1GTwtqfp7H6TtBfu8U
	cyEsFyNXtamzd1MBgnwPsNUGscF7jQ/+E/NcCmRAXlhz44Q4pEbshGFq4MNwIs6L
	6eI5UB871+ekkT7GfpZ6ilQ6PhVHOL+9Z2ZuaESYmpYIYpAilQ1LY5syRJVgPpN1
	9e2096CcQA9OhUw35rs7Vcf0/AjhnJWkPfiZa1j9DyM=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: sst: Factor out common write operation to `sst_nor_write_data()`
Date: Wed, 10 Jul 2024 11:14:01 +0200
Message-ID: <20240710091401.1282824-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1720602896;VERSION=7975;MC=3621083219;ID=61954;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485464756B

Writing to the Flash in `sst_nor_write()` is a 3-step process:
first an optional one-byte write to get 2-byte-aligned, then the
bulk of the data is written out in vendor-specific 2-byte writes.
Finally, if there's a byte left over, another one-byte write.
This was implemented 3 times in the body of `sst_nor_write()`.
To reduce code duplication, factor out these sub-steps to their
own function.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    RFC: I'm thinking of removing SPINOR_OP_BP in favor of
    SPINOR_OP_PP (they have the same value). SPINOR_OP_PP
    is the "standard" name for the elementary unit-sized
    (1 byte, in the case of NOR) write operation. I find it
    confusing to have two names for the same operation,
    so in a followup I plan to remove the vendor-specific
    name in favor of the standard one.

 drivers/mtd/spi-nor/sst.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 180b7390690c..fec71689e644 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -167,6 +167,21 @@ static const struct flash_info sst_nor_parts[] = {
 	}
 };
 
+static int sst_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
+			const u_char *buf)
+{
+	u8 op = (len == 1) ? SPINOR_OP_BP : SPINOR_OP_AAI_WP;
+	int ret;
+
+	nor->program_opcode = op;
+	ret = spi_nor_write_data(nor, to, 1, buf);
+	if (ret < 0)
+		return ret;
+	WARN(ret != len, "While writing %i byte written %i bytes\n", len, ret);
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			 size_t *retlen, const u_char *buf)
 {
@@ -188,16 +203,10 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
-		nor->program_opcode = SPINOR_OP_BP;
-
 		/* write one byte. */
-		ret = spi_nor_write_data(nor, to, 1, buf);
+		ret = sst_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
 
 		to++;
 		actual++;
@@ -205,16 +214,11 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Write out most of the data here. */
 	for (; actual < len - 1; actual += 2) {
-		nor->program_opcode = SPINOR_OP_AAI_WP;
-
 		/* write two bytes. */
-		ret = spi_nor_write_data(nor, to, 2, buf + actual);
+		ret = sst_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 2, "While writing 2 bytes written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
+
 		to += 2;
 		nor->sst_write_second = true;
 	}
@@ -234,14 +238,9 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto out;
 
-		nor->program_opcode = SPINOR_OP_BP;
-		ret = spi_nor_write_data(nor, to, 1, buf + actual);
+		ret = sst_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
 
 		actual += 1;
 
-- 
2.34.1



