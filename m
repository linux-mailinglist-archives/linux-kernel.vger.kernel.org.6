Return-Path: <linux-kernel+bounces-551345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711CA56B54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C557AADF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904622154B;
	Fri,  7 Mar 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MykI7SpL"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2721E0AA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360129; cv=none; b=RT/vx7jPU61Qf5I9OkjmKNWbVe3GXnu3rtfX2D+ZdMuXEZdOLQsKEpqRLEJXXXTpfH4NwsEBKmPUk/5/8N2SLE1OrT+J3cRUW6bqEQJOxZ0jnI4g9Y3T1y43VI6gIC8AJDxHrJxZJatRZk4yl5/2daaamSP2Ijo03ezsD+kh4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360129; c=relaxed/simple;
	bh=dJzT+OHWADFORZgsnmhtg1kIPIdWapHq8eHlbKwNLZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SktCTXX7m55Ob9NRwTn+3DEEwCBN4JWoQuHBVWDOjYoD+DkEHu7/x7jHYMcfdLzwm5uWO75sunB5ZjUd1n+Y5A5MWteGxEo82rJWP69S34x4XYXZyvqAxk8TQ9zmDrD5mwSlrCXd9rxC1AbCt8oKSceRn2v+luxfTMl4E/gXMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MykI7SpL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C50CA4431F;
	Fri,  7 Mar 2025 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmDtNBVOlxiAdEh+WPWHo1fjT54mB4Y7r1inMtSFB1c=;
	b=MykI7SpL/O3yrKr3oYZAvyFCRXfD3krSn2/c2s0sOBYTwOtdNZICWryncg/D3iYV2T0H4f
	fRe3IRCUlUepTiUit6SHymQ5y4x5F3QeVhxQ0ByBB2rLKCSJfaPxlQSapq6FarrcW/KEcD
	29/R7XROBqCCyeKnqP5XEaxJSqCwr5rAhIHWp5PEnduC9dwSepnatlNVyETeN6042Wr2KF
	cQESEL7kqdEnKsNpSYbfNxqVRicGtHzI4LjWOVdp8InwpQ4LGg+Yeb3ufM1kP2b1sPCUCC
	6iL2AzzM0u1khi8fKzyfVIa1ado0Tma5W9JrHLDHd5ItRKsg6tUXa+bOJjwGHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:30 +0100
Subject: [PATCH 11/21] mtd: spinand: Use more specific naming for the (quad
 IO) read from cache ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-11-45c1e074ad74@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgepuddtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtlhhin
 hdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

SPI operations have been initially described through macros implicitly
implying the use of a single SPI SDR bus. Macros for supporting dual and
quad I/O transfers have been added on top, generally inspired by vendor
naming, followed by DTR operations. Soon we might see octal
and even octal DTR operations as well (including the opcode byte).

Let's clarify what the macro really mean by describing the expected bus
topology in the (quad IO) read from cache macro names.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c | 2 +-
 drivers/mtd/nand/spi/gigadevice.c     | 8 ++++----
 drivers/mtd/nand/spi/micron.c         | 2 +-
 drivers/mtd/nand/spi/paragon.c        | 2 +-
 drivers/mtd/nand/spi/skyhigh.c        | 2 +-
 drivers/mtd/nand/spi/winbond.c        | 6 +++---
 drivers/mtd/nand/spi/xtx.c            | 2 +-
 include/linux/mtd/spinand.h           | 6 +++---
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index 66df707c8370bdf7b2583f021076d1d277010de4..0f9522009843bc11750de87be000d209cbf1ca5c 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -17,7 +17,7 @@
 #define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index f808a14d26e6ecb223a4b185b34fb03b876f5576..2e87c89a86d61944c6b18653c3ab3b5b49d29529 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -24,7 +24,7 @@
 #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
@@ -32,7 +32,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0),
@@ -40,7 +40,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
@@ -48,7 +48,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 79c5dcba5fa6923c6cf2aacbf8be7ba84cb14bb6..5af50c13bd372a86d8883e2f15dbbb0fc5e0799c 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -29,7 +29,7 @@
 #define MICRON_SELECT_DIE(x)	((x) << 6)
 
 static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index dc84e70bb132381992859b3379c1afd38f1a161c..b5ea248618036d2b4d5758ec752e29c2088a6750 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -22,7 +22,7 @@
 
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index c179a067db809a5f92ec21d69ac6e030bd0dcd1a..ac73f43e9365c7922cb531e8edb95f763480d50e 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -17,7 +17,7 @@
 #define SKYHIGH_CONFIG_PROTECT_EN		BIT(1)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 2b9bba6931887bf549f12d55fe84578edb81dbcf..dd0bc95a723e4f4d67d0247cbb3f869f823b9001 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -24,9 +24,9 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
@@ -37,7 +37,7 @@ static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 4e38b2e0ca7323e5d2ffe5292e8f67f6318b7f7b..abbbcd594c2c1fcaf68ca5244ed89508348244a3 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -23,7 +23,7 @@
 #define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 49083dadfbec7b951aadf4a245b59014122407fc..fe3194c97411d1b7d42ff4a28a831ffc60e570b0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -151,19 +151,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP_3A(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_4S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(addr, ndummy, buf, len, freq) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xed, 1),				\
 		   SPI_MEM_DTR_OP_ADDR(2, addr, 4),			\
 		   SPI_MEM_DTR_OP_DUMMY(ndummy, 4),			\

-- 
2.48.1


