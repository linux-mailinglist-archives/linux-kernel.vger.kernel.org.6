Return-Path: <linux-kernel+bounces-525638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4EA3F2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD93B213B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C495207E04;
	Fri, 21 Feb 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DZhea9b4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C81E5706
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135853; cv=none; b=O2KRqkflXkX3PkEHLBwzc0xYsdcrU6I/mcDSac8TD2foZUItkj6nHz8EEqzOkOO79VjsT8tEhj5OJgoSR0v6Ct4Z0gzlAYI/l737kcGgifJWjdixKbwvxc3cA+RnBA9RJLsZGkLweJ0TBFlsPOollUU5o/HQX9NgN/uqxgEfy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135853; c=relaxed/simple;
	bh=RCnNhgw75I/wEW2JWpngXCKAxqIVcEwXxTd7/ahkD3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d7jsdlGAHStkxb/Q3G2z80piGFXOT8Eu5NL75MkWnRb/lBxSiH+7hHBePNHGbgkBOFRKucULOClWHE6OK247YxPrn+vkShEs0BqO9E2FY9oMRnfFv78XXHt5cDvWQOk0Uab+pq61Qlv5yG+lSf+tGVQ3Wlm5HbGW7KcvCc2I7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DZhea9b4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740135849;
	bh=RCnNhgw75I/wEW2JWpngXCKAxqIVcEwXxTd7/ahkD3Q=;
	h=From:Date:Subject:To:Cc:From;
	b=DZhea9b4fkr8gbhixEfwqn6OlEv6qNZu0rW2pu+Kqx+ThaqfXU0cmkDBJrAfFkqVb
	 aHb0AstOTFgzh5g/Ch+DiO9m7Ils+0F2qIIEz4pUyaAsKlMHTH2DP3mVKBty5tiLAU
	 151ZbRyu4AhIddUjcaB2smqtU/i3Ve3X/P+wflspqQA5ZbpGZJN92lOoLr21Itzo+c
	 W5WhkqGvnoBAQKXtWnlLPfSjZD79Wulcty0dUuwM+l28qEPNmBm87CchGV3ZBfCDrA
	 8Z4A93cVUY9p44vkArcOR/HSCbgPjVBFDk7DlDloGmgcAfS9SRbzMzUl2utClmNf2r
	 cE+g11KjuyyXw==
Received: from yukiji.home (lfbn-tou-1-1147-231.w90-76.abo.wanadoo.fr [90.76.208.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB6E017E02BE;
	Fri, 21 Feb 2025 12:04:08 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 21 Feb 2025 12:04:02 +0100
Subject: [PATCH] soc: mediatek: mtk-socinfo: Avoid using machine attribute
 in SoC detection log
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mtk-socinfo-fix-print-v1-1-20500f30ef66@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKFduGcC/zWNwQrCMBBEfyXs2YWYUJD+ivTQxI0ukk1NohRK/
 93F4vHNMG82aFSZGoxmg0ofblxE4XwyEB+z3An5pgzOusE6ZzH3J7YSWVLBxCsulaUjXXzywdN
 gQwDdLpW0/Hmv08GVXm/V9yOEMDfCWHLmPhqhteP/AqZ9/wIYnOWumAAAAA==
X-Change-ID: 20250220-mtk-socinfo-fix-print-e83f3b3e50bb
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Fei Shao <fshao@chromium.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740135848; l=1637;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=RCnNhgw75I/wEW2JWpngXCKAxqIVcEwXxTd7/ahkD3Q=;
 b=RekhF+VTRj/NNwFMjsJNiXVDNcX0IETBIKOwOKIFzwREB2y/iLivfFzlt/glLTGYP7+5tgcGH
 E3wiP8tO2XEBeM21mk/eX31XadTZyDtkw8hNyGXGVJ9ttDoTT0PG8YZ
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The recently introduced SoC attribute info rework avoided modifying the
machine attribut but still used it in the log message on successful SoC
matching. It leads to print a confusing log about a board-related info
(read from devicetree) and not about the matched SoC:
```
mtk-socinfo mtk-socinfo.0.auto: MediaTek MediaTek Genio-510 EVK SoC
  detected
```

So, fix the dev_info format to display SoC family and name attribute
instead.
```
mtk-socinfo mtk-socinfo.0.auto: MediaTek Genio 510 (MT8370) SoC detected.
```

Fixes: da77c2d3d06c ("soc: mediatek: mtk-socinfo: Restructure SoC attribute information")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index a15d8f854cefa90883377b47bbc16a7072ee21cd..ac7bb0cbff2df5e1c4033646cd3b644e67ee7f69 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -87,7 +87,7 @@ static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
 	if (IS_ERR(mtk_socinfop->soc_dev))
 		return PTR_ERR(mtk_socinfop->soc_dev);
 
-	dev_info(mtk_socinfop->dev, "%s %s SoC detected.\n", soc_manufacturer, attrs->machine);
+	dev_info(mtk_socinfop->dev, "%s (%s) SoC detected.\n", attrs->family, attrs->soc_id);
 	return 0;
 }
 

---
base-commit: 964b0ceed00032fa0fa841fd61e5f315880a2d36
change-id: 20250220-mtk-socinfo-fix-print-e83f3b3e50bb

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


