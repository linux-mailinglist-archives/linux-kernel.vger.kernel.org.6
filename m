Return-Path: <linux-kernel+bounces-551341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08615A56B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68C73AC1B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2721D5A5;
	Fri,  7 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HCjC0rE+"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC421D3C3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360124; cv=none; b=ieiVZavXe5A9/t54Ggo9GzvLd1Kg9tZ/MI0z49Eo0EYgmizWKyxpHGUxrj2rFSQqGuSgwkfUc/fnTshCzoNCz2zhaG5JeqPxrUnMvbsS19/rtKfNWpTNG2uJzV/BAzc4XpfcZJm/Fi4QXBUCQrqmTKw8iuWj9PU3e6Y3tEZb2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360124; c=relaxed/simple;
	bh=XhyDiPvD73tWZ7CwXXX8hGculDGmcBTnnHB3Ck/RksE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEjLQnLJzUnW9hLs3xjSPmqzZwf13zs3SeJ4npz3Mi/qEsv5MmzTAiz5yb2MU1++qRisWvGA3pW3II55gdgqECq3dc0h0vsWvDn2TIqpXAQnZCobYHNlRO2V1A4x24WyYJQdoBS+DSTeM2UZkuZgOpthIuO3K76gRtMMLs1ikO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HCjC0rE+; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FB10442CC;
	Fri,  7 Mar 2025 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI5CSDKtAW5FHbHyI0s5xXENpgx+dqL0tr4GhQKl70U=;
	b=HCjC0rE+kXItC8WyEf+JQtGp2+m2TIZt1ukwB39PgFHMdZGkPRZNQCZSWzE+a6BgLLF89y
	Ba1cWAdAVoKZ/MUlQtFoZWEm795j2s3q0y1KZUeRPhfc9hSnL52cIeC7GF6HJnnOUmagX6
	c/31xdvRVRNegWPSVg0T99a1exiZwPsCKBX3ACX+GknVXXj9tv/MNa4nrNlBLU1R5Hhba/
	0rEvMWD4zp/EoNuw0YwEROQrMcpCBbYAYGTduECP6UbViU2qtEeDqnbOrHTANfL51Sb3WX
	RBqAbihJPpBK7jxvg6lgJDj41UgWXPu2A4b6L5PwQqGfcIiz6E5SnWW2bb+6Fg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:26 +0100
Subject: [PATCH 07/21] mtd: spinand: Use more specific naming for the
 (single) read from cache ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-7-45c1e074ad74@bootlin.com>
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
topology in the (single) read from cache macro names.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c |  4 ++--
 drivers/mtd/nand/spi/ato.c            |  4 ++--
 drivers/mtd/nand/spi/esmt.c           |  4 ++--
 drivers/mtd/nand/spi/foresee.c        |  4 ++--
 drivers/mtd/nand/spi/gigadevice.c     | 16 ++++++++--------
 drivers/mtd/nand/spi/macronix.c       |  4 ++--
 drivers/mtd/nand/spi/micron.c         |  8 ++++----
 drivers/mtd/nand/spi/paragon.c        |  4 ++--
 drivers/mtd/nand/spi/skyhigh.c        |  4 ++--
 drivers/mtd/nand/spi/toshiba.c        |  4 ++--
 drivers/mtd/nand/spi/winbond.c        | 10 +++++-----
 drivers/mtd/nand/spi/xtx.c            |  4 ++--
 include/linux/mtd/spinand.h           | 12 ++++++------
 13 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index 6046c73f8424e9fb338ec3a1d35dc6fe30a2e1bc..723c740308d26e901fd3d9a402ddd48e8e69060f 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -21,8 +21,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index bb5298911137f08c1793d244b33dddf1971e2fed..9026a14aca07ce011af151eb6dfe56797e0e70c0 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -15,8 +15,8 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 323a20901fc9fcc252b8317d9434aabf5e30a495..aad751f95269b3f501aff01753c4bf0ff9484fbe 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -15,8 +15,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index ecd5f6bffa33423abddf750b34b823a640fa2c23..8a9725ea29bac5901d67304db95ed5573bd7fa40 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -14,8 +14,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 73a483227831518a480dc34de17efdaa398b5627..76856f1de8fefc6404345e363b2c873cc3c02e52 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -28,32 +28,32 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP_3A(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(0, 0, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3dc4d63d6832d0213387f335fd233f1c4306bfff..59bd476a29f03967a3f5a814872f9a6039b0a585 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -28,8 +28,8 @@ struct macronix_priv {
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 6ec20fad837bc534cfa0bc7cc629622a7dfab5da..d7dbd22db1a3f8457c8947f4044dd8442dc475cb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -33,8 +33,8 @@ static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
@@ -48,8 +48,8 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 static SPINAND_OP_VARIANTS(x4_read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x1_write_cache_variants,
 			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 6e7cc6995380c00ae40fe362f711a490ff463130..ae3527d6d5fa358be482eb8cf0ba4e1e2304e441 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -26,8 +26,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index 961df0d74984a8dc8484ac5d7323d172012058e5..ffbedb8d92f659967f6aa0c80d5b0aa7d088929c 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -21,8 +21,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index a600aa771519fa04a1caafb8c8e636eab10359c4..bc5adadf6084f48ff482d6846be1c6d2e9157e85 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -17,8 +17,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_x4_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 5816b489b57b0070ddeda745cf17c04efc5080cd..8379a1d12dd563e573c6d37cf099759088176da4 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -32,17 +32,17 @@ static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X2_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 3f539ca0de861c082217701607f96c2a6b7c5378..a0003f52ae8f52ab00374fedc457476136a78568 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -27,8 +27,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 882b635228860f45e52d516421c1fc3b2c723b9b..9465fae82ceef773f729ab04661b30464df6b45b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,32 +62,32 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len, ...) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(addr, ndummy, buf, len, ...) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
 		   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(addr, ndummy, buf, len) \
-	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),			\
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 			 SPI_MEM_OP_ADDR(2, addr, 1),			\
 			 SPI_MEM_OP_DUMMY(ndummy, 1),			\
 			 SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP_3A(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(addr, ndummy, buf, len, freq) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),				\
 		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
 		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\

-- 
2.48.1


