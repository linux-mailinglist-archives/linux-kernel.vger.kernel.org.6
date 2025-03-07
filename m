Return-Path: <linux-kernel+bounces-551348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B41A56B57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AF83A8700
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36B221738;
	Fri,  7 Mar 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pdhW0kni"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4422156F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360133; cv=none; b=SjobuziGH+Fo45ma74AhLipgvWIxPP6YKSQa9sWEsrRsnELC8uY8o6lyqsNMEUsbLFVYlwa91lS/QE1Rbeg6bQq6QlylDW8guhuxU6LA8Ox3lLeoKA9WgmVJxXS6CrrV9a5XMMVyfp/j5isG08kB8gDm8kI+lIpjJD1w20l17AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360133; c=relaxed/simple;
	bh=E6toVke4clLdt5vClXKFOwxD2GL28XFrsNP9o2BJpr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOutridd9uAQOmGrMdssrMCBbQXVvPsnPzM9AKJgPwQaPgLULZBGvnpAsNQbES2u1gvo6efgn0n5HPYQBYIb0f+UgGpsaCVti0feavQmNkYd1saacLKGjgbiw3xV9Qzq6NtbPk+3bdKpysQxHi4pS4Hb+j17kXEtNw4nlohAViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pdhW0kni; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B5904433A;
	Fri,  7 Mar 2025 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9a85V77jIkRJeCfPjP3jvnMTHciLHQQ9UgJ3CBoRTQ=;
	b=pdhW0kniI7XRokNjv4LerU51IoPt+A+Ss2ho60gQXwrkFPj88LJUvQopCSLvWUPAPKvC19
	K0/Jvjr4ofTgewU8Xrz+3JpptzDvuyX9ghMM0x2TVgDZu7diacjI5sB2B8S/yUjVwg+b/H
	XD7183KIRDgAe50+zE9A6wSY9+v+CQPa+pT5bTKHwgx01v1rR+LjTezk+Lfp/vCncThjPA
	8/AXd9bhLKFau9IZsGoyF5ZgwPM/5nwNRjzzi8rNNsm/5eyQwTNy+Jg6zsGyLVQBpzJ6zj
	q2hCHCNSz+jsj7P/mswTE2RfjORdzyqFtP+Nm80SkhtjZlWeVtbQUOpnw/iDag==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:33 +0100
Subject: [PATCH 14/21] mtd: spinand: Use more specific naming for the
 (quad) program load op
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-14-45c1e074ad74@bootlin.com>
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

Let's clarify what the macro really means by describing the expected bus
topology in the (quad) program load macro name.

While at modifying it, better add the missing_ OP suffix to align with
all the other macros of the same kind.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c | 4 ++--
 drivers/mtd/nand/spi/ato.c            | 4 ++--
 drivers/mtd/nand/spi/esmt.c           | 4 ++--
 drivers/mtd/nand/spi/foresee.c        | 4 ++--
 drivers/mtd/nand/spi/gigadevice.c     | 4 ++--
 drivers/mtd/nand/spi/macronix.c       | 4 ++--
 drivers/mtd/nand/spi/micron.c         | 4 ++--
 drivers/mtd/nand/spi/paragon.c        | 4 ++--
 drivers/mtd/nand/spi/skyhigh.c        | 4 ++--
 drivers/mtd/nand/spi/toshiba.c        | 4 ++--
 drivers/mtd/nand/spi/winbond.c        | 4 ++--
 drivers/mtd/nand/spi/xtx.c            | 4 ++--
 include/linux/mtd/spinand.h           | 2 +-
 13 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index 437e935aefab57f80876e0eb84a9c37d11211864..2ee498230ec1be23d77d975b2a4cc972f0f6e258 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -25,11 +25,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int am_get_eccsize(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index cf51cc6ae66d3d35a4e912472fef80f7a8e3eeb9..2b4df1d917ac8581f30079356b98eeba06da9687 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -19,11 +19,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 64dd54181c8feb48a531a203e1b6437db490363a..3e5ed066a16483f8ddf38f750e6fc1f9b7c1fb27 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -19,11 +19,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /*
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index dba8ea5142eef8a109d66f3262f264b8a16680b2..7c61644bfb109d2960a8b3065f98f348bd23e162 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -18,11 +18,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 44ef38cddc900e86c1a7a52a7c7fb68c42d82a43..cb1d316fc4d8326ac79a32919d4c41260d8f1b59 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -56,11 +56,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int gd5fxgq4xa_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 577437107ec5fc1d8771dc7899731c88bd3e55b6..c32366663ce33fe92885bf9c44969012c8582747 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -32,11 +32,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 56bbd7e7843faeb34cc8fb3ec16aa2dc98196ebb..a2770f9a8a14f985f380e3daad656363b60423c7 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -37,11 +37,11 @@ static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /* Micron  MT29F2G01AAAED Device */
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index eaddb12d6e9a15365470c1a695a55c009794daca..4670bac41245e1f357727d2855c2249bb420cac4 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -30,11 +30,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index 3b9b83d499a2f86c0bd9387d1d94bedd0eccc108..51d61785df61cdc987c1c330f7fa50f4389855e9 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -25,11 +25,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index cb1157fb34e3c9365d0cb47e1f37d8b745aa975e..4c6923047aeb84fa59369aced6d30ad6e9b6350d 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -21,11 +21,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_x4_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_x4_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /*
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index adc20b4f28adb339ce81c5c1de5d28cfa3c36b31..861fb8d59760c83c3fa31879cb6ff027e7dc92ff 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -45,11 +45,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 931b85e82ac5811dc2ce668270157a73ab9b5474..37336d5958a95377aa40bcbf81ebdda4907e2385 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -31,11 +31,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index b564825d13b711b7a8403d8cf1f3af178c68847f..148e2cddeed4fad6b71e74e3a343b5409814b177 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -182,7 +182,7 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 1))
 
-#define SPINAND_PROG_LOAD_X4(reset, addr, buf, len)			\
+#define SPINAND_PROG_LOAD_1S_1S_4S_OP(reset, addr, buf, len)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x32 : 0x34, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\

-- 
2.48.1


