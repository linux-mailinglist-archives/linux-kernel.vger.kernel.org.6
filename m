Return-Path: <linux-kernel+bounces-559148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A48A5F012
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D48F19C13D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CED264F8A;
	Thu, 13 Mar 2025 09:58:19 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825E263C8A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859899; cv=none; b=p84HaHevcdXvCob/Iaw+EhrCFuo6e0vp3llu/HSUgW7PdqEsEmqPbVK1Anw8bewA380o7jNuCrhSr4DjlS5Oz5E8BjXXE2OMItG2kxDSNSIIeVTLKAOCEYR9wTSHi9rLGfmLv6Zdu/yg9f8OfYWXlKfkhs8gZnNaSm2NMKPjkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859899; c=relaxed/simple;
	bh=Hq9CSFW4OLk9g/ymdHCTxYNqoYjVud9AM9/SURafbNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C64gYIq20HZfUwjCUubGRyklWxOV9rxRvO2RCwk9qwstrJDWH81o4p4JfjnYQKZ5Oqnt2AgfTgM85ChKZ8gEKebGNwiSmA+Zwjtx4dqgI6pJnjTrXSRi8NG+Uky1qbc8w0MC4JqjmNlydtMAYJADXwK/pRggPxDPmFOvTU5+QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8a3dbc2fff111efa216b1d71e6e1362-20250313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3de06487-e397-4f0a-86da-1bab374ecafa,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:2d9882719783582ce917f1dc80192fb1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8a3dbc2fff111efa216b1d71e6e1362-20250313
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 656145711; Thu, 13 Mar 2025 17:58:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 234BFE008902;
	Thu, 13 Mar 2025 17:58:05 +0800 (CST)
X-ns-mid: postfix-67D2AC2C-8975662165
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0D53AE008901;
	Thu, 13 Mar 2025 17:58:03 +0800 (CST)
From: Zhang Heng <zhangheng@kylinos.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	han.xu@nxp.com,
	hs@denx.de,
	david@protonic.nl,
	jre@pengutronix.de
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Zhang Heng <zhangheng@kylinos.cn>
Subject: [PATCH 2/2] mtd: mchp48l640: Use str_enable_disable() in mchp48l640_write_prepare()
Date: Thu, 13 Mar 2025 17:57:56 +0800
Message-ID: <20250313095756.945890-2-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313095756.945890-1-zhangheng@kylinos.cn>
References: <20250313095756.945890-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove hard-coded strings by using the str_enable_disable() helper
function.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/mtd/devices/mchp48l640.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp4=
8l640.c
index 7584d0ba9396..4af9208f9690 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -23,6 +23,7 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
+#include <linux/string_choices.h>
=20
 struct mchp48_caps {
 	unsigned int size;
@@ -128,11 +129,11 @@ static int mchp48l640_write_prepare(struct mchp48l6=
40_flash *flash, bool enable)
 	mutex_unlock(&flash->lock);
=20
 	if (ret)
-		dev_err(&flash->spi->dev, "write %sable failed ret: %d",
-			(enable ? "en" : "dis"), ret);
+		dev_err(&flash->spi->dev, "write %s failed ret: %d",
+			str_enable_disable(enable), ret);
=20
-	dev_dbg(&flash->spi->dev, "write %sable success ret: %d",
-		(enable ? "en" : "dis"), ret);
+	dev_dbg(&flash->spi->dev, "write %s success ret: %d",
+		str_enable_disable(enable), ret);
 	if (enable)
 		return mchp48l640_waitforbit(flash, MCHP48L640_STATUS_WEL, true);
=20
--=20
2.47.1


