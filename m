Return-Path: <linux-kernel+bounces-551344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9EA56B52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545F43A62DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B62206AF;
	Fri,  7 Mar 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qnz3uOGI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452721D5AA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360128; cv=none; b=r046MY27iel45lLq/Ypu6/X2l0Morng0ItoLpnzUDNM01fc740FWeCjq2lGyH59l4lcHGjy74mUXRGNmQ93rLHe8WFb/HV4kFGRBvfpJa5usy90zZrv7AK3rM0hoBVsl3nuRxK8KWwMxUsdhf6rJHwTl6dshH0LdnUaEkI0VFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360128; c=relaxed/simple;
	bh=p3hoVevvr+M1ZJq68A0n3KK/1x6mrAUJJyGTOwJj1fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOO8DgrRLtYegCT0gKCkMhbEdA+vVwDLi4SuWMnXYZtE/abg0OL5gzQnIsLqHxJZMYvHaLy+tb8q0l2CAC6QpEWFbT7weuTBAP7cLD9hqHv06TLmfJ2r87iiOzABupl5YVB9NiNB/6WLGCXNt8W5m9aKyQrIcx24aDiW4BMZas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qnz3uOGI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C5FB4432D;
	Fri,  7 Mar 2025 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60Al8NDiuqmzAnZ6PuM+6HD9YlNaGYKn3XnKTUDtU3Y=;
	b=Qnz3uOGILETACWqdUJTuvyhO6mAyEq0R++o+XcOuGJ72Te/3vIPCs8BzR9tWbvSqxlKCFq
	aJJx2AO7tUKKLtMWF0IR4kDrr2RJiFA90S5s+Y4GaqF7aOprv69ciHeVG8rSVJOgmfyaQf
	EqXmWhGaYsnbEMpPh3xd+HyBpdCimocshcSsN57D9Wi0c4dWHlPSqeyBVChNjJd1eRMpC1
	AGYHrGzrt5pg5F+wxIua5JgZ5XPlcu5F1cPXtm+AjTeruZ6Pbab3hCA/TkPCbYw7uy/O+7
	CDdgAJHPJC0wfzskTj1jvx5Q6YxNvAzwbcrUY3/RWVn70/Vgtu31T7MhXT+nfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:29 +0100
Subject: [PATCH 10/21] mtd: spinand: Use more specific naming for the (quad
 output) read from cache ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-10-45c1e074ad74@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddujeeipdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthhlihhnv
 desfihinhgsohhnugdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

SPI operations have been initially described through macros implicitly
implying the use of a single SPI SDR bus. Macros for supporting dual and
quad I/O transfers have been added on top, generally inspired by vendor
naming, followed by DTR operations. Soon we might see octal
and even octal DTR operations as well (including the opcode byte).

Let's clarify what the macro really mean by describing the expected bus
topology in the (quad output) read from cache macro names.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c | 2 +-
 drivers/mtd/nand/spi/ato.c            | 2 +-
 drivers/mtd/nand/spi/esmt.c           | 2 +-
 drivers/mtd/nand/spi/foresee.c        | 2 +-
 drivers/mtd/nand/spi/gigadevice.c     | 8 ++++----
 drivers/mtd/nand/spi/macronix.c       | 2 +-
 drivers/mtd/nand/spi/micron.c         | 4 ++--
 drivers/mtd/nand/spi/paragon.c        | 2 +-
 drivers/mtd/nand/spi/skyhigh.c        | 2 +-
 drivers/mtd/nand/spi/toshiba.c        | 2 +-
 drivers/mtd/nand/spi/winbond.c        | 6 +++---
 drivers/mtd/nand/spi/xtx.c            | 2 +-
 include/linux/mtd/spinand.h           | 6 +++---
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index c83e83d85d5b2703df90b0fc2ebc84056c45ab11..66df707c8370bdf7b2583f021076d1d277010de4 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -18,7 +18,7 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index 9026a14aca07ce011af151eb6dfe56797e0e70c0..88dc51308e1b84dd8abb3fd32297c9fd43a131f5 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -14,7 +14,7 @@
 
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 41fb4173af34429265c8db60851747e147c5a36c..8b409a418b1c16914cfd6ba1c588f58d76388d59 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -13,7 +13,7 @@
 #define SPINAND_MFR_ESMT_C8			0xc8
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 729dfde4292108fe588b317dbe8731b4f6535246..21ad44032286ffb7c98f1944624fe9ecb507d6ce 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -12,7 +12,7 @@
 #define SPINAND_MFR_FORESEE		0xCD
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 13fdb44b945ff4d4ee5b614c7b50112ed69bcc24..f808a14d26e6ecb223a4b185b34fb03b876f5576 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -25,7 +25,7 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
@@ -33,7 +33,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0),
@@ -41,7 +41,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
@@ -49,7 +49,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 4d7820e8952871df2ccd9b17610fa403d347574f..aaee30b64abe6061c0a83525ff3de1307278581c 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -26,7 +26,7 @@ struct macronix_priv {
 };
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 9cdaf2fed92b8cca4d02c85bd1ff8b80da3eb318..79c5dcba5fa6923c6cf2aacbf8be7ba84cb14bb6 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -30,7 +30,7 @@
 
 static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
@@ -46,7 +46,7 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 
 /* Micron  MT29F2G01AAAED Device */
 static SPINAND_OP_VARIANTS(x4_read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index f3545b28124b341ebd030895eba06c35604b500c..dc84e70bb132381992859b3379c1afd38f1a161c 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -23,7 +23,7 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index 2f414815a035e3ea479dfa58a19457eb239ee348..c179a067db809a5f92ec21d69ac6e030bd0dcd1a 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -18,7 +18,7 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index a497de9241b65f9fa6e8ae43f629b4a35977d375..8bba0d4011ce239c8fa6f1fc453bc0b610c76f9c 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -15,7 +15,7 @@
 #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 90db8216722d59e3d1fc8c9568e72b59f0baaada..2b9bba6931887bf549f12d55fe84578edb81dbcf 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -25,9 +25,9 @@
 
 static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
@@ -38,7 +38,7 @@ static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index d4c7cbd4c9851c0f4763ccaf3cdb7bce5fdd37ff..4e38b2e0ca7323e5d2ffe5292e8f67f6318b7f7b 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -24,7 +24,7 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index a147e39ee8836335546f83a5e02d025e28865782..49083dadfbec7b951aadf4a245b59014122407fc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -132,19 +132,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(addr, ndummy, buf, len)	\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X4_DTR_OP(addr, ndummy, buf, len, freq) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6d, 1),				\
 		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
 		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\

-- 
2.48.1


