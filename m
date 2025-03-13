Return-Path: <linux-kernel+bounces-559147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6784A5F011
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159F816AC75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251726462C;
	Thu, 13 Mar 2025 09:58:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0301D8A10
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859898; cv=none; b=E19zXqHMSBJGDzUQvOyza2yPDOeMZnG6nq9E9fSgXN2OjftMwjNlybHXKz2EPen5MF0S6De38hcmPOwz3irlHpVtA2xz1OGlaq90xP58YiYs3+XXEC8fYoLeN/Bpb9cgOwunsmmb1Zp0h7vwVKjhC4n/xsEiOwRGoU3PPUKwJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859898; c=relaxed/simple;
	bh=/c5MAp6L886OYk2fj4O2XrUIjpykoT6Bi36NGjY9unE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nesr+mY/GtXUkxEPiq6c+uPnthNAG3//ZQGM2DIUt7M6+D4QIqKUyFS9EftR16rT5GP7XNCYO9tDgUaygDq1c+BpisSR9YkBRqdqIsbh8fD1qsyRiFzGcY8TINWZyyGGnMq+hohk82/reS5BPsD4Ppdoyshhwe11tdyLSNDEMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6f5324efff111efa216b1d71e6e1362-20250313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e2b2fb55-5bd7-4a50-bc8f-f02c2a35492d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:39939feb8854b0a194969a4e76a66e63,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a6f5324efff111efa216b1d71e6e1362-20250313
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1315595742; Thu, 13 Mar 2025 17:58:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4C2B0E008902;
	Thu, 13 Mar 2025 17:58:02 +0800 (CST)
X-ns-mid: postfix-67D2AC2A-121602164
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8E0A8E008901;
	Thu, 13 Mar 2025 17:57:59 +0800 (CST)
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
Subject: [PATCH 1/2] mtd: rawnand: gpmi: Use str_enabled_disabled() in gpmi_nand_attach_chip()
Date: Thu, 13 Mar 2025 17:57:55 +0800
Message-ID: <20250313095756.945890-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nan=
d/raw/gpmi-nand/gpmi-nand.c
index d76802944453..f4e68008ea03 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/dma/mxs-dma.h>
+#include <linux/string_choices.h>
 #include "gpmi-nand.h"
 #include "gpmi-regs.h"
 #include "bch-regs.h"
@@ -2319,8 +2320,8 @@ static int gpmi_nand_attach_chip(struct nand_chip *=
chip)
 					  "fsl,no-blockmark-swap"))
 			this->swap_block_mark =3D false;
 	}
-	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
-		this->swap_block_mark ? "en" : "dis");
+	dev_dbg(this->dev, "Blockmark swapping %s\n",
+		str_enabled_disabled(this->swap_block_mark));
=20
 	ret =3D gpmi_init_last(this);
 	if (ret)
--=20
2.47.1


