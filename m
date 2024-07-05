Return-Path: <linux-kernel+bounces-242452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB53692883A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EA41F24E28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F5149C6A;
	Fri,  5 Jul 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="trWeqCj9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306AF146D45
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180310; cv=none; b=cdVGv5ZC20IEhSamsCgYR989ywwozTtECQfVXgTbviMTK+W4nnPGQ03XIaahs6g5Pi+Zj7KfiebsNQPdLLEkgVbJhboDnAW4QKxtE5XAoiw3hSprDDaqaoIzq5n433j6Y0UKB/suiiSjC0dndDjJC8Qw/5jzS9bWopJRGtamE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180310; c=relaxed/simple;
	bh=87QADRvjWpwITWkhJ6ZCRxkd06/1fowLe9WbEwgHq+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3bZs0BdcvizS0lcbkuL0FU9VPijpXep5OFenkqE2rhyUc06ij0gKNjckxagj/vnS9WmaXMGtfphoy5sdYtGmrMXGaWsdpoyDfikNlgmWGJdLmJRfzEvzggQh+4x13yOXqCTIDNaUZ1ZxHiumAqFgLI2LY7pa3Ub5vcPbvYqSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=trWeqCj9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1824922a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1720180306; x=1720785106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QojLwX8k68lmn9KlieWzohao5qbJAQQ4QJADw03ISo=;
        b=trWeqCj9K7y5dEAnrYDLyNztiU8Soo8sF0P3U/aGaXrHzYLs7smY+HwYtIrgvlifzs
         2MooXhSNWElAK81uJCSoCwEswq8RD/LUiK+t0/oW5Us9cV4ivFLdpS/zZeZSoXFGNdMM
         mB7dhXamkaDcUMLVoqm6xNyj2pt3jPxVB3+xKyqrlbayu7rKJboeNB8MOZTHYrQduuh4
         YuZktNt5yZZNCaISS/SOXkC0lUi4kPdIO+qC/fDBCVBGVd9Tv5v9cpqjO9bOQZeM+nlk
         7nt2JlnRouQmWaXiP619ZiKKa2C8/0Md+Q+E+ejaGkjLaSTLKg8GI1/ishgYbdwctzqN
         JpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180306; x=1720785106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QojLwX8k68lmn9KlieWzohao5qbJAQQ4QJADw03ISo=;
        b=AHYwEjkzzahm1vK5SxBtDm7LUzwwpI7ugd3Pw0bmYmLcHYaRBhKpDl3+pp7V2ihi5p
         S+UII57uHMxOoJeAgF/Ye0R0FXqLEi5Z1SMyIrrXOizrRyjYDv6beMCagAvbuODwCTsP
         FZYnRS9WWoSDvw5eU0f6VfRm9DjyI2Vj4TujF8wxYuz202a2DqmXhUNKUxYu0i8t51Ak
         NUHyn+8f0ZrvK9AQfvuWUbXP7X3MP7pv9K4QTdxVqMP5tPQjtZ0ZOQLk5ijfYYeGi7Pi
         XfBFAwK7XV8WeZZl0gYNf99VHcW/GN7YLwBOtZ53mjOL9BbR6Ac9cpovcD4c4JPqrNvc
         HxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRZyr/D9lRHm6BPwZ6s+BzN/AwNcCm1XcYKEzRYRf05o78HD6bVoU8/Y/UbGeVNKmu2zwXE+1ptnTAiGG/KK/KzAOp3PBIM+TCOI52
X-Gm-Message-State: AOJu0Yzhe2ZxdlIvS+WXYPUhAJfPyioYN0vH/NSOQRtdFRIWf4Wd+Yi5
	D0s4Op+uAXpgbgioccvSnalmAtZET5aoHHtdOqw4EhqT/AGTeCClrV76J8EGlPs=
X-Google-Smtp-Source: AGHT+IFHA1gnQKRQ18iPmWbS0NPjG9TbNdQHs95PiwC+5AeAhU74MhAe3PLIFlm88Q5NStc5UX6U7A==
X-Received: by 2002:a17:906:4751:b0:a74:e717:4259 with SMTP id a640c23a62f3a-a77ba48db88mr281324166b.41.1720180306439;
        Fri, 05 Jul 2024 04:51:46 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06531fsm674762866b.100.2024.07.05.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:51:46 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: miquel.raynal@bootlin.com
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v2] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks
Date: Fri,  5 Jul 2024 13:51:35 +0200
Message-Id: <20240705115139.126522-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_request_chan() returns error pointer in case of error, while
dma_request_channel() returns NULL in case of error therefore different
error checks are needed for the two.

Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels using DT entries")
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: stable@vger.kernel.org
---
Changes v2:
 - Corrected 'Fixes' tag
 - add Cc: stable 

 drivers/mtd/nand/raw/lpc32xx_mlc.c | 2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 92cebe871bb4..b9c3adc54c01 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -575,7 +575,7 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 3b7e3d259785..ade971e4cc3b 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -722,7 +722,7 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 	dma_cap_mask_t mask;
 
 	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
-	if (!host->dma_chan) {
+	if (IS_ERR(host->dma_chan)) {
 		/* fallback to request using platform data */
 		if (!host->pdata || !host->pdata->dma_filter) {
 			dev_err(mtd->dev.parent, "no DMA platform data\n");
-- 
2.25.1


