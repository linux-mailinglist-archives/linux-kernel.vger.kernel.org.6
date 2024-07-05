Return-Path: <linux-kernel+bounces-242239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FD7928544
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA371F24A06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB04146D45;
	Fri,  5 Jul 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="iJMPJMJf"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9A146598
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172355; cv=none; b=YlxrFni3OmLEa6BljIw8UdbMt4MlgRkD5Te3pYVs72BV4xv4+MugsqAFH/jnAwKJNIsWx0Q3rwW2f6db+R7z74IQB3Y4/5i2HdDuCbzQYxabufKP7mv+DWdq2/RhLauY0AVA//DqShVoyzivXMSKMzCnUHTR6fKPBj0a1mdscLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172355; c=relaxed/simple;
	bh=byX/P3UD0NcamULLWN/2MXb4nTdtaZmqtVANDlZ48f8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EM9+ruoEQyMydkgwh8l4neu0/z6Rz/lTHE28o1kpalzbtReFSqYRN09zF9HOCwX/CONZrJ1DO1h9GF5i7/Qd5lXqSTDIOHiJjbPwcOcc9wvByEa0+ICozGao3nvTKnbVaJZ4OrmzHTqs6AYtmFF7ave1AIUSJCjZwadFZMGwuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=iJMPJMJf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso1994163a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1720172351; x=1720777151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVl0/ov31Z5c7JuaCdhkQTngl8fcz1FLMuHeeKS/wH0=;
        b=iJMPJMJfAwvQbQUNOJjlSjrZoenhdTqCTd6GLOowIO5/VtUpKIXabasxS24tlKf7Zq
         hrbZ5BIVB1oPmsX0hsEhe+Dx/4zFPuvDwCWk5qJulF8nQ7CcOQjxKxne4T2Ms5oZl/Mk
         3SIriUK7Ez1Ko3AZx15zNyyq7MyY7qywmI6vmR51trr0GXFB0K7JonV3v9+2inMIQanh
         5X4w4/0d/mPoo0GeoJU/UM68OOyiF64twHShX7lU6Oi+67V2FGfmPQ55z4+AP97jEwDg
         gAYAiAbfKt+kBG9dLrV+L5+2JapOlbFG2qBDI8A28MktSHXyFaf+aGP7eYvvYG7D4iGB
         VxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172351; x=1720777151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVl0/ov31Z5c7JuaCdhkQTngl8fcz1FLMuHeeKS/wH0=;
        b=qBNLC4TIDrGURbCLM3+WncrvQJaifMGijTlMCBykxjzRyC1LRi63BWxVvpITIq87Eu
         AwcjQm74jG1o/Rnf4VtKOr/4aRx79pbDT2Wl4/NZFeg0YEi72ByzjpBNFGLqol8YfTNs
         i+yu2QasrqceD/RBTou7EcyEaStIXOm4ebXtX6ojF2ozQH11cTxvV5jwz3xLhOkf75mF
         0LOfOFUR/3s+S3/HqA6TKPZfMr8Skw6E/DVBrq+INfg+5jTzdANT697tuC6HBLuUr1nj
         AkstEa13f+hgbQfIt5vOKDAaQO7F8RaiF8ZK+vXxQMhuKQYr/EEu5JKWNMQou9arG+Y0
         3L+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSD3eihcQ8HfkY/yHSywUol41BBrueVgD+8tCTHiKyN7Ku/esVDxPA9oo8gwUZGif3aY9aB+9SSh8KyVFWbqL2xjpdM1iqczX8vA6e
X-Gm-Message-State: AOJu0YzRKdSGAYfHIBUg3SIjl+Y37eNdHWWAtmMPkW2xqL2G4rayF1om
	d5Jw+Yqdjcvg+tIdTMyo3BxltBbWreSb6MTfyvqu84KOHaXRIhKShsMJvgVMaug=
X-Google-Smtp-Source: AGHT+IG52PNgZ6gFh4V9z3FNGhD1C7ZKZqyP5zmMsOxHv5dSPkPU9BQP1vX/iw37RZINd5W4yPauFw==
X-Received: by 2002:a17:906:c147:b0:a77:daa9:408 with SMTP id a640c23a62f3a-a77daa90562mr27338266b.72.1720172351027;
        Fri, 05 Jul 2024 02:39:11 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77da0e33bfsm10823866b.59.2024.07.05.02.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:39:10 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: dan.carpenter@linaro.org
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks
Date: Fri,  5 Jul 2024 11:38:47 +0200
Message-Id: <20240705093851.18107-1-piotr.wojtaszczyk@timesys.com>
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

Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels
using DT entries")
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
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


