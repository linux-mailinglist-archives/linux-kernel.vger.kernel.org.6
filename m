Return-Path: <linux-kernel+bounces-304423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C5961FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE672860B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F85156677;
	Wed, 28 Aug 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="ZPU3Ofuh"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272B13210D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827046; cv=none; b=KfjNSlxO628Hj5aPnMNQGDTdBLefbVP2YuMDDvET9vXUUwxkRK6DzG9TYry98aOdXRWcImv8yYWZfvePkNWp8rmMFyUCGW+5gv/Phv9NYwJGG3RU17SNIYKY0se+SiTsC0WlnnYLOvqGcDBfn8Ikzy2J+2CqYjczWHIvp14LK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827046; c=relaxed/simple;
	bh=hqyXZ1VwQMY8LFqgBp1NCNyzd6DlCC0HFuzL4h3ppb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uMPs1eT0YyPuE3QKsqzdYA0DCyl53SKXK0NMqP9lZSVL8FdhMJC9G8LAdeBwD2GmWdvyAXj9Zps2U9wG5yXzdiDI8hv7SZ3CJHsSvj2t4cIKTphv/cXixYIeYybYOwDicqiPXISedvIm6X9b4jUM24Pj6hxShCqpEtFd7vA2c8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=ZPU3Ofuh; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A33ED14832EF;
	Wed, 28 Aug 2024 08:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724827035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pwGPCTW5GTwNDQJjy9zJrdb9wJJS09zfm0iMot8uEVY=;
	b=ZPU3OfuhyYGnT0zIEHewtPdHoUXHVR7EcmNyZZZ1DNFSeteFXlfNFywVFjy3NQswHYS6Sw
	I3RAr94B+uYAEGhGdKoETeyXbOHHrLiswQUZUYJznuoS9o8au9TGv5lepZIF12IcMmVtC2
	wD1U0UrVXQlBlMa7ihwtUcDJoPaIKHeBEdYvElEj14KxG3gm1dZgvKyv3GZhKzufCL0N0A
	aEzWIjVog4Wl4syAe2ThOai0vigb314cwpTpb51L9nUq8U5hOqTGEloc5RFBcLgC3dAd9Y
	K2eNJsL53A4oYxzBFncjefwZCibeSSQBI9PGsB+s3A5gblbt4EJ8yCvkusfKGw==
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] mtd: rawnand: atmel: Add message on DMA usage
Date: Wed, 28 Aug 2024 08:37:06 +0200
Message-Id: <20240828063707.73869-1-ada@thorsis.com>
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
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---

Notes:
    v3:
    - adapted commit message prefix
    - collected tags
    
    v2:
    - make info message conditional (thanks Miquel)
    - Link: https://lore.kernel.org/linux-mtd/20240821142006.645306-1-ada@thorsis.com/
    
    v1:
    - Link: https://lore.kernel.org/linux-mtd/20240821120517.330868-1-ada@thorsis.com/

 drivers/mtd/nand/raw/atmel/nand-controller.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dc75d50d52e8..f9ccfd02e804 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2049,7 +2049,10 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		dma_cap_set(DMA_MEMCPY, mask);
 
 		nc->dmac = dma_request_channel(mask, NULL, NULL);
-		if (!nc->dmac)
+		if (nc->dmac)
+			dev_info(nc->dev, "using %s for DMA transfers\n",
+				 dma_chan_name(nc->dmac));
+		else
 			dev_err(nc->dev, "Failed to request DMA channel\n");
 	}
 

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2


