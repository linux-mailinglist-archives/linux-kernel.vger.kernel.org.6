Return-Path: <linux-kernel+bounces-551355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055FA56B61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1AC171EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA9223311;
	Fri,  7 Mar 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="otO+QxzS"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6622256D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360143; cv=none; b=O3j/qYCE+cnTQfcUjgFM0tmITWzkr3Qek9r72HhY24UeYjw4GUK+qy7uaKYledn3d7TbQUNmyhw49CDVtC9YVsV9CfHzN84HsHk2XZI6uTQDvMeSoYEnoxigbJDp34uiYS0+gPoSiAWZ5gDVn8UemhBwoiyPbR4BdDXopGpE4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360143; c=relaxed/simple;
	bh=4qmaXF1vQefZEq8YQpiKf1nCEZZb4kJhkuJ7GpilqoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pE4KavJvNybGvwrKItFReBPeuWEgxkGo5v6NFoj5PUw9GNuCgq39KgdMGKRmwFYlUeWH+/UuqbryPLL1RfVSCwTFweHORI0EkV2PtJhi7aWL1NKtDE/1To2aAr5UBsWmXTDusq0M4hdObRdJ/vy8IW0W4lHJrtKgJnQ6ebUujMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=otO+QxzS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 877FD4431F;
	Fri,  7 Mar 2025 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRq/J0J0kWNRhBfkmjSa/MJFjpBfiDwMbuRJa0R5Bk0=;
	b=otO+QxzS57FwqwOqLKJXamUPv+BWAov+j+v+id5uKqRUw6eeaGFX79Aa2/1eA9FmKTMZYf
	aZEMNrWwCpOdUmEQw97aBsRe9oA1xYZ3gf0HegkWqMCB6SGl1z0h/0gd4CR8v1tIUtQ1oj
	DOwPjkG7yq5ZK1Ib1JcQT3fSFFfWDJlDWy7FEAF5+Oql58qXoDdsuzvydXcxygB1mYiw1A
	vaSiXcLUOQ6U8PHzMojAZy2Cd8Z1kZV4Phz6hXBr4u9wrz5MwuaH2tPPX3wyxuzQf3IX0u
	bIla3Mx2RA0krLIp4UQ2Qij/BiT5s6RD2x8KQRKzzB9fZKEEgnzc52ylBa7t9Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:40 +0100
Subject: [PATCH 21/21] mtd: spinand: winbond: Add support for W35N02JW and
 W35N02JW chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-21-45c1e074ad74@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgepudelnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtlhhin
 hdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

These chips support single SPI, octal SPI and octal DDR SPI.

For now, only the SDR protocols are supported.

Tested with the W35N02JW variant, but the 04 one just has twice more
dies and is described in the same datasheet, so we can reasonably expect
that it will behave identically.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c263c9b5affe79a14466bc0e2ef2da53ecfd48cf..19f8dd4a63707e6599068a43fd80dabcd9dd3a57 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -287,6 +287,24 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_octal_variants),
 		     0,
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+	SPINAND_INFO("W35N02JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 2, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+	SPINAND_INFO("W35N04JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 4, 1, 1),
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


