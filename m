Return-Path: <linux-kernel+bounces-551351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837EA56B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3672F3AAC9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E4221F2E;
	Fri,  7 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mr5nnchc"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506F221D86
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360137; cv=none; b=OZtptUW+Zkrdj0NieqeFSkUO7ih32MEOQrisfcb62Q7k9VQWZJ+kwETb2HxuygPgFHeXikGeZBKF1mSeT47eqyWToi3jeBDRRcrxyq4FllWqH3aawvdRPzD//DSxDTGuvcr6/1ptca5fi0XcHlxVgz1OS7tiou8ZdqefGOoUQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360137; c=relaxed/simple;
	bh=YYfHdTVfdIBHuLworKHcP0+uA91yBWCUkthGHhOZyLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VC8OHvFlN4yIVnn6WVLlOU6WIOH5zRtsEpkSDctdvg3R7g8cvlt+6csmom8jclvrZzp+FSpGkbQyFifBp1js/eiJyTpJlXPAE4/q3zRs82qVSW+M4NjaV0wHnktuieZ/SAnR+1zJdbw28TTdzXuDYFc7qxuHSmrZ/HfZOv377QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mr5nnchc; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 043E0442CC;
	Fri,  7 Mar 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WECXh7nIg9BOskWhhlhrtWyWNPsyuyZQXyUxS7Sign4=;
	b=mr5nnchc3NbjVs9RwXDUVRohjjTjUInH8uIoUiti8aWGJcLuQ6FHvwgvr4UTAjW3wPs9OV
	nRPgT2nk9NOLq9NqH9ENqpJOkCbHGvbbttH/gqdJ1PbJLFjff2ATGWUMrMsK+g+BlPGLJ5
	MON5tXUxj5zcdr6ZdKgYEqD4beA+b+RqA8jUKvZujNcmDdT/3nYyiVxAW0Bd226irYsPeo
	a+Ft+HYNkVmOeITJ0PthmpNmFH3WgATyWg4ZW+VKtfnj1C+0rmgpWqfl14h794M591t0Sk
	6pnCgdM6IR7mIGc256qxKCygvypf06D7wtYdOmJU7SYWaDrDRU9iilsGLXfGLw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Mar 2025 16:08:36 +0100
Subject: [PATCH 17/21] mtd: spinand: Define octal read from cache
 operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-17-45c1e074ad74@bootlin.com>
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

SPI NAND chips may support octal read from cache transfers. List the
opcodes by defining the relevant macros describing these operations.

Controllers supporting operations mixing SDR and DTR operations might even
leverage octal DTR data I/O transfers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 148e2cddeed4fad6b71e74e3a343b5409814b177..ed02fa891d946c71e73d349c605447cbea48ebf9 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -170,6 +170,27 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 8),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 8),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
 #define SPINAND_PROG_EXEC_1S_1S_0_OP(addr)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\

-- 
2.48.1


