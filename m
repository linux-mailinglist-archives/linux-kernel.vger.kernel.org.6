Return-Path: <linux-kernel+bounces-551352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A038A56B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D3C1898DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3872222C2;
	Fri,  7 Mar 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EjgnWCKO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E923221DBA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360139; cv=none; b=MeX4QxSXNbfTu4nV0nbSbxVoByOB3V3DBc3Wd8AgUfY0q9YeChvaBPcyoQehLyezZbHapDgjj9b6173itrhYjHTVmb/ihYBqqcKKDKwBgXaisWxppuGGKtaJrQ7T4AKlRlfG+t2y18xpynma2fSZuIzERF2mxTfXTC1m5whn93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360139; c=relaxed/simple;
	bh=fQWkSayVIUUtsIwFfKM8AukfADug7zHZFNoTbLiP8jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LciUf/dLoOnvBKwbzpClJ36rQ6uv4S2UjnPFc5SbTHEdS9YkHutHEjJ70PISzPo5UeOGCk7C2q80smI8Dm9pJCKkLwiyjGKWj8bcas6uaeMtbKa8IJg+Ok65hBN9Sw0uYDXIaDCteqdOzomPM/M2W08p7MgE2A/eXqJ8Fv8n794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EjgnWCKO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 309F84430E;
	Fri,  7 Mar 2025 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsAcuJOu7/lWVEH8aUBxgETw4MYWZ072uSOVdJKydWQ=;
	b=EjgnWCKOvcKmEm5sEc5LjeK5s0O+6ydsozM24Obus0PBzC9VK6jzZnNGIQCPfgwmnQi6Ui
	FloIWtZc5knad+dpIZZcLpYld1ah0Bw3Z5r5eclpQYVoGcByRo4AoGw5CTPHLJJvU27vU8
	cEIt+gag5Cj8/Sp4UAiM+jqwihblrx2FM0e/kTQwu3BHqWDnAo1cG9ZEyjWNNWvOnflhi7
	ZWU7/dEqozPLpSjD7reR61RQgcKwFaXpI0tyeWdV1V+HEZHGlukW/HxpFQvot/lQ11nYsU
	pssM8k8GfqpETtSvkt+GSf0itr8/Ix+KFoRtxNllrgcljMGFTWyEt2IDfQS0Dg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:37 +0100
Subject: [PATCH 18/21] mtd: spinand: winbond: Add octal read support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-18-45c1e074ad74@bootlin.com>
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

Describe the octal read from cache operations (1S_1S_8S, 1S_8S_8S and
1S_1D_8D_OP) supported by the W35N01JW chip.

There is no observable improvement between the two octal SDR modes,
which anyway offered a great read speed improvement compared to single
mode.

flash_speed test results ran on the TI AM62A7 LP SK using a 25MHz SPI bus:

* Single mode:
eraseblock read speed is  2346 KiB/s
page       read speed is  2342 KiB/s

* Octal modes:
eraseblock read speed is 10801 KiB/s
page       read speed is 10711 KiB/s

However, testing on the cadence qspi controller driver did not allow
mixed modes (where SDR and DTR cycles are mixed in the same operation),
thus 1S-1D-8D mode could not be tested and is provided for reference (it
is anyway skipped on platforms not supporting this).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 9b0369a077efadac8bd6be632f15b822d42a7227..4b1bfc15588ad3ffc8f2cb7615db6c14d0b62903 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -24,6 +24,9 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 16, NULL, 0, 86 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 1, NULL, 0, 133 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 

-- 
2.48.1


