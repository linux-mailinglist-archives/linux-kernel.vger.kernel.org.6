Return-Path: <linux-kernel+bounces-551350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38ECA56B59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E35C3A9127
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEB21CC63;
	Fri,  7 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y+LyupY0"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D92221733
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360136; cv=none; b=ZwKLuWpvbOTDHiALTrwu5/zE+gBRbVSxtHpiAJzP1UO0+j2kIeZZE3qxfdaR6xcUwl2MwTZb7QOJWdSu3ZjImVFPGua0x4KbZd9kkUlLPqnB7DhmbxHZipKA6OQt5J6artbk4K4GS6tx3r6Aa07H7LTGNElLU3fZdqnrkFQiThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360136; c=relaxed/simple;
	bh=0dxQZKyLWXgX9sUs7Vck/7lSYSeqm50cIuKcOtXH9to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZNZgH3S4PHa91EdGuOjpnli9aOVNAjTzvNi+JU+nm24QljP7WysFBkiEYouwoMraZQF4NUs1ErGQXOIG06gStkWVlh6krMQRchSVtiOA8rxWjnQfqQpc+6rCa35oBxTcJLw3KW4PkmAx8df4PbysrZzlWcpwErih4EBYyU/TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y+LyupY0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9348A4432D;
	Fri,  7 Mar 2025 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLzyeQGBoeCiADv9YwfF6f7YBSSdhS4NCnAXU0WWAcU=;
	b=Y+LyupY0NqOj0ZFXKKgpF4IhwrS0p711uBdlZY/YhBlmoLmWjTBjdHbSLhsQV+up+I84Fx
	jR5XpDGT1pvXuBokWR/6dFxBfULC/hJUHbsapQ0cI6Hjbn4fYOGvzqWi3Po+Y3bEa9sA6C
	IZgM8/i9K4FQkh40qGHhgsDpg7rby3xEOCk3jfD1WaMb31TdDtR+8kOnwKvKUJyAr9Z5mK
	QlAG3P6zwDXavSZyPl27P3xJ0LsZTbTvPmUjM1nLT8D0mEEw8wCjsQ7dqukDLaz+cswDZG
	zUzDUCmA8SkRcHZDdONypxyTcbrC4o5YCVnLAq8btAy/QVmQxZ7vbxgD6vlQ8w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:35 +0100
Subject: [PATCH 16/21] mtd: spinand: winbond: Add support for W35N01JW in
 single mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-16-45c1e074ad74@bootlin.com>
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtlhhin
 hdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Add support for the W35N series by describing the smaller (single die)
chip. It has 1b/512B ECC support and its own OOB layout.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 99b9f333eb3142999d8f73d43537f1ed9789c975..9b0369a077efadac8bd6be632f15b822d42a7227 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -23,6 +23,16 @@
  * "X4" in the core is equivalent to "quad output" in the datasheets.
  */
 
+static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_octal_variants,
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_octal_variants,
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
 static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
@@ -141,6 +151,41 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.free = w25n02kv_ooblayout_free,
 };
 
+static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = 16 * section;
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
+	.ecc = w35n01jw_ooblayout_ecc,
+	.free = w35n01jw_ooblayout_free,
+};
+
 static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -227,6 +272,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n01kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N01JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),

-- 
2.48.1


