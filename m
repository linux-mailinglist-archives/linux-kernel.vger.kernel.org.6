Return-Path: <linux-kernel+bounces-377608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364429AC12E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65DA1F20FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED908158553;
	Wed, 23 Oct 2024 08:12:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A29158536
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671170; cv=none; b=mOYdEGiviGEE79arc/ioxcXUeJfgz1MbmrgwXCMgqe0tClstcgga5tzSdQsPYZ8x6ggyZcM5k31SAZUyMr6N4y9s/4qTY57UJBqpNPVI2XZesTu/E2cktVDwSG5mH1IDSFXl6f5yk5ylnBAj553GYsTClmqwhItFmhLZQ8TeeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671170; c=relaxed/simple;
	bh=2dzT+4V3anUSTonFUQwRZ1afjSpm37Cgi2apV/tBjys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ4bVv3tEqMNxJbkDcARdkccLiM5ln+cQ6e39qKYXGnkmVptJYJt+2w06qtNBxbAcaSWYmSE7lrJ7HlnkwKgz+Zy8woBK0J8r44yXkEAt0uD+iMjBY6Xj5fl0dGkIlyYuMk1b+66ZFoVMwiAHLfXzl6ItcS9J1ytH3ifgRSHPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTv-0004YS-3D; Wed, 23 Oct 2024 10:12:39 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTu-0010Hj-1a;
	Wed, 23 Oct 2024 10:12:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTu-00FrPY-1L;
	Wed, 23 Oct 2024 10:12:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 23 Oct 2024 10:12:29 +0200
Subject: [PATCH 2/4] nvmem: imx-ocotp-ele: fix reading from non zero offset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-imx-ele-ocotp-fixes-v1-2-4adc00ce288f@pengutronix.de>
References: <20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de>
In-Reply-To: <20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729671158; l=1539;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=2dzT+4V3anUSTonFUQwRZ1afjSpm37Cgi2apV/tBjys=;
 b=7prRp4qpJxbkuHDdgv6wN7sAUBZi2LQrMBEj5MObAO9ROLxK4YxfqqK15Nt9mlum/gg4UFhCu
 x9OwzC/J5BXBsHmceLUppFjZ4wU4BUH6U7SBe97/Hifyru1EI+yZnsk
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In imx_ocotp_reg_read() the offset comes in as bytes and not as words.
This means we have to divide offset by 4 to get to the correct word
offset.

Also the incoming offset might not be word aligned. In order to read
from the OCOTP the driver aligns down the previous word boundary and
reads from there. This means we have to skip this alignment offset from
the temporary buffer when copying the data to the output buffer.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/nvmem/imx-ocotp-ele.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 2e186b7d3b040..b2d21a5f77bc1 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -71,12 +71,14 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 	u32 *buf;
 	void *p;
 	int i;
+	u8 skipbytes;
 
 	if (offset + bytes > priv->data->size)
 		bytes = priv->data->size - offset;
 
-	index = offset;
-	num_bytes = round_up(bytes, 4);
+	index = offset >> 2;
+	skipbytes = offset - (index << 2);
+	num_bytes = round_up(bytes + skipbytes, 4);
 	count = num_bytes >> 2;
 
 	p = kzalloc(num_bytes, GFP_KERNEL);
@@ -100,7 +102,7 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 			*buf++ = readl_relaxed(reg + (i << 2));
 	}
 
-	memcpy(val, (u8 *)p, bytes);
+	memcpy(val, ((u8 *)p) + skipbytes, bytes);
 
 	mutex_unlock(&priv->lock);
 

-- 
2.39.5


