Return-Path: <linux-kernel+bounces-324919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3697529F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EA91C26649
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39477187336;
	Wed, 11 Sep 2024 12:38:06 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03142154C0B;
	Wed, 11 Sep 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058285; cv=none; b=nSWMG2A7FAGAXunU5OyDdWlIAuZKx607zxKhBbdsj34aU3LK6f7+rIsVteQOw/DRUTiA4mtbUZMxR2uwNVoDCrlcnIkri/cX+VN2Jns8iiBvE1+fYF8Pwqf0SAhueReqIs3RmqUfGeMgKHc9qyC+4/Ekh7pQchO6qIpLoricSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058285; c=relaxed/simple;
	bh=/ZReZPWOoxjjHH1YQ4ZtFsvN34/KSmLe/hRg2Y9bMLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ttv492lu6Cbxxa6d7xs4UGfHVe5zlx5+rIMVc10aQgrjVH6yIb8wsiLFby41s16/JCLWgYITfkkN5bgpTreP2a6myvXoYqQXjRyRHs/uCCTwkGh3NDHf1lUISC//Noe9N3keA3x3ewTG1X678Ecg8b9mjHbPPrJXoniPsPEWjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866e18f25e2d-5ae61;
	Wed, 11 Sep 2024 20:38:00 +0800 (CST)
X-RM-TRANSID:2ee866e18f25e2d-5ae61
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166e18f20e9f-cca1b;
	Wed, 11 Sep 2024 20:38:00 +0800 (CST)
X-RM-TRANSID:2ee166e18f20e9f-cca1b
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mediatek: Remove redundant error message
Date: Wed, 11 Sep 2024 20:37:51 +0800
Message-Id: <20240911123751.2078-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function mt7986_afe_pcm_dev_probe, when get irq
failed, the function platform_get_irq() logs an error
message, so remove redundant one here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
index d400bea0e..7db090414 100644
--- a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
@@ -529,10 +529,9 @@ static int mt7986_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id < 0) {
-		ret = irq_id;
-		return dev_err_probe(dev, ret, "No irq found\n");
-	}
+	if (irq_id < 0)
+		return irq_id;
+
 	ret = devm_request_irq(dev, irq_id, mt7986_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret)
-- 
2.33.0




