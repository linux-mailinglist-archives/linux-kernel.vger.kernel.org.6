Return-Path: <linux-kernel+bounces-207784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204B901C13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1037F1C21C00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAD4436A;
	Mon, 10 Jun 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj89g7jA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0393F9FB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005703; cv=none; b=Rf71tdTR0jTO1wxtPDeTmfU4mUYhMcNev/1gWTVGlX/uhynq2Xyz5jXd9LdaYzNgLFy+5XkJT3fHM4zoPY+qmqmc5Kbar27ry6dPdaJq35XeBRySX2WG4h13hXPV2UbdFJdGs7dW0+56JpSWxuvQMtsA85dhvKTMSmIY9nhBr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005703; c=relaxed/simple;
	bh=2qRE8JlGLZ2v3Gb/BpOQHXVYxdux+LqVifqY0jGju70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/8CxYLpLKeIhaVJxRhVuXoz3bMoxcOtjMDVexUHRw50QqL1kZYGhQwfBQectCyExpdPYsWCAEoyEJVMAlGuay2HdL0lEqcXivj3BMoYpxJKYJf2LiSe8BParK75tIlc1f9aMT1TzC3al245QLJyeFRVXM7L+EFiW3cDMa0uCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj89g7jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397D1C2BBFC;
	Mon, 10 Jun 2024 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718005702;
	bh=2qRE8JlGLZ2v3Gb/BpOQHXVYxdux+LqVifqY0jGju70=;
	h=From:To:Cc:Subject:Date:From;
	b=mj89g7jA6W9wPM/LUrs7z1lITBOBj9JdkJyn5HmVzF7a0YuXsYtYjSF3WsiyerHUw
	 R7hkyoVeRAjW9EDb9x22cAXRab275h2U8ZXVgTzu5Mid8+ZOauy6NnHQedcCcMroiW
	 uG+TofcmkVzClfUkFZorMnVk5Apig6fT4ZUxrYCUimC5dhQJYPomMgc3TJvZZDNFpN
	 QV/hQpBDdSS2P4xRlfb6ydgRwi1NYOuFEc2wmhIbCp1EQRV3fggutfYAWA0JONyBpZ
	 WNqg+jpckVETcv9IGdBlIbM73kWAqMG7DVXxuf8bc4pExIkfn53w7hjHTGV7R/TbU+
	 7Ee8JLVxzvhQw==
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
	e9hack <e9hack@gmail.com>
Subject: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
Date: Mon, 10 Jun 2024 09:48:09 +0200
Message-Id: <20240610074809.2180535-1-mwalle@kernel.org>
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
use anymore. This turned out to be wrong. Add the no_sfdp_flags as
well as the size again.

Reported-by: e9hack <e9hack@gmail.com>
Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Hartmut, Linus, could you please test it on your boards? Also, do
you have a real name we should put in the Reported-by tag?

This will also need a manual backport to the stable kernels due to
the new syntax. But that should be straight forward.
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


