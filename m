Return-Path: <linux-kernel+bounces-224614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824049124CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3457E1F22385
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A3174ED2;
	Fri, 21 Jun 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNOtTTRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2077495E5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971789; cv=none; b=OVFMiLH5afkg9Hy/sKMxgOG+XKQlCzS5Urr93AlNnZuURKLwT5frl2HeI6fZhPEKdvxTT9xkB9zUl0hdAYK5s3fhHooOTHDkxKSwwaPqV7WCE6HvknkadlQ23Y2CLKed/5FzRSRKudDZ7x5vEslVLXNsYWw3AtyxNH2O37Ghupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971789; c=relaxed/simple;
	bh=wMuaz9BDxJLFVN7qWbG997fw4//1Q5akSsaDTLrpVEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mizdKR9B5Ed2Qe1MuvZUDs1JrbRRBPit23Ed1JNzQxkL2oskwk93os6Z753w4BQoq+HHxMSOhfi2VkPZnUTOROzZFzFs5V9vFjs3CKMaG3xnblwWNjsWNR/1JnJhz54B7sYpcuyP1KilAK8P4L7I2mlRYWjDYf7gIgJkHPcmxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNOtTTRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA15C2BBFC;
	Fri, 21 Jun 2024 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718971788;
	bh=wMuaz9BDxJLFVN7qWbG997fw4//1Q5akSsaDTLrpVEw=;
	h=From:To:Cc:Subject:Date:From;
	b=HNOtTTRF0I3LzUwqWoj28stx4qfPA0jX2uJmg4YHPUAv33N4dlDV1OgBbCj17qx0r
	 5WOtcuf1XKAveAWM1GMbbQgLwRjg1nXowscH4zcYo3kn1Veh59gsLyeuTBJh3bfysf
	 uSnp3Ex7PZ4PHGaWYi6K46/6KClB70nGfVxA0om0Qr/W8Llylyt3K3ZVBNbMI5wGse
	 /ey8LpfEZ5rExS0YKwEmAyDPZDH/M5KchMAkGu4rIeZhgtKCvQPQEmzc32wYiAOcaS
	 21ioY6QOVhZYoY/UMSHOI7XHlTnUIh3/PEI+VnOw6KjdaGH4B1aQjpRKZJXvu/Ak+U
	 y0u6xcEjwATlQ==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Esben Haabendal <esben@geanix.com>,
	Hartmut Birr <e9hack@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
Date: Fri, 21 Jun 2024 14:09:29 +0200
Message-Id: <20240621120929.2670185-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
removed the flags for non-SFDP devices. It was assumed that it wasn't in
use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
again.

We add the additional flags for dual and quad read because they have
been reported to work properly by Hartmut using both older and newer
versions of this flash, the similar flashes with 64Mbit and 256Mbit
already have these flags and because it will (luckily) trigger our
legacy SFDP parsing, so newer versions with SFDP support will still get
the parameters from the SFDP tables.

Reported-by: Hartmut Birr <e9hack@gmail.com>
Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
As mentioned this is for fixing the regression and a proper fix will
make use of the TRY_SFDP (or whatever it will be named) mechanism.
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ca67bf2c46c3..6b6dec6f8faf 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x18),
 		.name = "w25q128",
+		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x19),
 		.name = "w25q256",
-- 
2.39.2


