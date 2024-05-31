Return-Path: <linux-kernel+bounces-196620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D528D5EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF57287456
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454D1422C8;
	Fri, 31 May 2024 09:47:10 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60931353FE
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148830; cv=none; b=AEV8aDFGlDAip+yUj2bpalx1c5EYP54wX+ZjMSW4TSpO2DWovB3ilaewCL4AzpTANqiptAWQgbJNdAFO9v9ELZjqNl6dKgE0BA1bsKubDGYYjZpcdEj2Tgbq0Pjj/GXItA8fioKOU3tRG/qo+3fvQ7R/lWr9/FMGRwJ6XZ6g9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148830; c=relaxed/simple;
	bh=SC275hQjH9VkQy1y5Rrs3/LU4ycdUMdkK1Iho1g3uNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5pGGAG2LJPy88jgSACULRiWRY/aL2YK1dESWsTKFwjBYPeZ2Y7LQpV0xV+8oPfNZ/WM01GRXdS+1/BVhVy7X/Nk7GlTr8r7FxBNj+YBTPv1tXCw2anyxOJj1R3aEnL6sZVOay+duJ8thjMbIPkUecQ664a+MpIpTJhLDUFE+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id ba956cf2-1f32-11ef-aafc-005056bdd08f;
	Fri, 31 May 2024 12:47:01 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] spi: Do not rely on the SG table and respective API implementations
Date: Fri, 31 May 2024 12:44:33 +0300
Message-ID: <20240531094658.1598969-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we use global non-constant SG list to cover DMA unmmaped
part of unidirection transfer. This is heavily relies on the internal
implementation of the SG table and respective APIs. Instead, and
to be pair with the DMA mapped part of the transfer, use SG table
allocation for a single entry without any mapping done on top. This
also will be symmetrical to the respective sg_free_table() call.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 43cd3e5bccbe..da978ee262d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,11 +1220,6 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
-/* Dummy SG for unidirect transfers */
-static struct scatterlist dummy_sg = {
-	.page_link = SG_END,
-};
-
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1261,25 +1256,26 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						(void *)xfer->tx_buf,
 						xfer->len, DMA_TO_DEVICE,
 						attrs);
-			if (ret != 0)
-				return ret;
 		} else {
-			xfer->tx_sg.sgl = &dummy_sg;
+			/* Allocate dummy SG table for unidirect transfers */
+			ret = sg_alloc_table(&xfer->tx_sg, 1, GFP_KERNEL);
 		}
+		if (ret)
+			return ret;
 
 		if (xfer->rx_buf != NULL) {
 			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
 						xfer->rx_buf, xfer->len,
 						DMA_FROM_DEVICE, attrs);
-			if (ret != 0) {
-				spi_unmap_buf_attrs(ctlr, tx_dev,
-						&xfer->tx_sg, DMA_TO_DEVICE,
-						attrs);
-
-				return ret;
-			}
 		} else {
-			xfer->rx_sg.sgl = &dummy_sg;
+			/* Allocate dummy SG table for unidirect transfers */
+			ret = sg_alloc_table(&xfer->rx_sg, 1, GFP_KERNEL);
+		}
+		if (ret) {
+			spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+					    DMA_TO_DEVICE, attrs);
+
+			return ret;
 		}
 	}
 	/* No transfer has been mapped, bail out with success */
-- 
2.45.1


