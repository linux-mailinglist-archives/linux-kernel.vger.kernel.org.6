Return-Path: <linux-kernel+bounces-295461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D1959B38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECC21F21F84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE81D1312;
	Wed, 21 Aug 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="bO0SA43t"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B421514E2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241930; cv=none; b=YYjPye0BmV+8LkXm8jY9h8OkACaS1ZUGrZ37ACCMRuokCEK+orcan43tG6/0AvGY/c0idOAf+1gppVemKMYZ72zTvUFiHqZSUxLREQ8r4RsEwzSo4qvWLhJTv0mvGdksXdkWUKW8Gv5WSYj4JuCXm7pvhh1V+iKfsGbtiW9LLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241930; c=relaxed/simple;
	bh=6jLyPkO3hT7d4kPL+wiinzF9Sn4vUybD4fE1P1jdzZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sBJF7IU/w8mC1mM3TptJwpL0HSu0PS9dQZSJBteXtwgsUgo5SZzCKDFePzmp9MBr3SlQhnHhqMHWK+MFVdvK/F7cq9OouoQ3JOQuSFKm/VTNk6kmbquZtEDoM4Mripag67HOqg/0JQfbNS1Y2W2/kdv4Zn3HbRkzyKFKpIjrUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=bO0SA43t; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43CE11483DED;
	Wed, 21 Aug 2024 14:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724241925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Yd9f/abI0GPcRIqot7aIukn3A28N94HWzjWiU6z6HyE=;
	b=bO0SA43tlbA4YxhM/DGIJwpIOxdL6BjKB4NyYp10pzrBySjKTTIg5WubVeb5rFwLADXfLy
	t2lU8WT39x3w/T+twzAj5jQqSQMPrEEKoLDp3nFMnX5iCJmf425JAxJk9j9i2bdDIDhR51
	9YFrtz1fLR/z3VgEgbTWCpVLc0Pt8aEHnMU+7XCpX5oZS3veIn3u7PzoW76CP12qggehiW
	7fWA5Unb1K114xTGozac8axiE82Jfie5Vv0qtIdCHQyXewibxYQYaLA1ltxJSYjNzUdtVk
	YvQhjIXLvxpQ0cXJ+Bv5YteqOpOnUe4oCdHqfJyUSufFj9ScyoKK0dRl6JZleQ==
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: nand: raw: atmel: Add message on DMA usage
Date: Wed, 21 Aug 2024 14:05:16 +0200
Message-Id: <20240821120517.330868-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Like for other atmel drivers (serial, crypto, mmc, …), too.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dc75d50d52e8..9e6dea2cf140 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2051,6 +2051,8 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		nc->dmac = dma_request_channel(mask, NULL, NULL);
 		if (!nc->dmac)
 			dev_err(nc->dev, "Failed to request DMA channel\n");
+		dev_info(nc->dev, "using %s for DMA transfers\n",
+			 dma_chan_name(nc->dmac));
 	}
 
 	/* We do not retrieve the SMC syscon when parsing old DTs. */

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2


