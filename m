Return-Path: <linux-kernel+bounces-324054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80566974751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A77284849
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9E10A0E;
	Wed, 11 Sep 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HJ2PN/Id"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9168C147;
	Wed, 11 Sep 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014275; cv=none; b=GC5sS2GwqIAb62kJWfTI8j3KAxPOPIj2bOaR3f+GSC/R/kByDEi1g5S7H8Rl9nMlgaNrFdt4Ocvy8XG0mMsWPPvIc800U9WS5Wvf4BwnGkmWg4KyiVHXUD0eDpxzeXRf/6NCMmdCRr6Yaui8yuJ0VBqG+f0GKXm6sGL8e08O8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014275; c=relaxed/simple;
	bh=auWz33wVk2T4+Fh0mK2SlMGrzt3l84Ywwdr3nZFaRCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uzl2T3a4SIUFtfSydC5Ib+CNLJwGwHHiAjNYLmFHFQPTsLhZTUAP/U423x6N5KreSG7IORF8kHgHDYZcx9rK+ZQNc7kB/jznCFtQmMzkHGcqBSHCMHve4N2dwySxmjrVm/61Bb1swGG+n3OyMUTDmq3SY87JgEJ3EWPBgWeCM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HJ2PN/Id; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kwoHg
	HGCKF3DSrT9N1RW+DeyibROwQHKLdIupTJJ14M=; b=HJ2PN/IdwIO8NPvwZ5lsQ
	Y0Bfpb2Dk+rHKPaAt5CU+hKrLff+mb+0B4i8yS4ymC9egc5MQ80D85WNk0JdjKlE
	+N0bQoZtRdQS4ogQWgJgL8LC1t9xEmNhvbcVFip/xo7Du8HNnKpl6WwtYmnOmbsx
	Q9WMAA+Ohd8fwK6wTXzqA4=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wD3n4714uBmgx9WCw--.6962S2;
	Wed, 11 Sep 2024 08:23:17 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: amergnat@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	matthias.bgg@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data" issue
Date: Wed, 11 Sep 2024 08:15:17 +0800
Message-Id: <20240911001516.47268-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n4714uBmgx9WCw--.6962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw45AF1fAr47WrW8uFyDWrg_yoW8JF4xpF
	s5K397Cr9xWr1jkr47CF1Uta9FkryfZFy7WFW7G347Xa45uw4Uu3WvyFZ0yFWvqr92kan8
	KrW2gFy7uFs5AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvPfLUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxlXamVOGP6WDAAAsc

The "i2s_data" might not be initialized before using it.
Set it to NULL by default and also check if it is valid.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 3482d8f8b4e7..3a8a5d975a04 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -465,7 +465,7 @@ void mt8365_afe_set_i2s_out_enable(struct mtk_base_afe *afe, bool enable)
 	int i;
 	unsigned long flags;
 	struct mt8365_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_afe_i2s_priv *i2s_data;
+	struct mtk_afe_i2s_priv *i2s_data = NULL;
 
 	for (i = 0; i < DAI_I2S_NUM; i++) {
 		if (mt8365_i2s_priv[i].adda_link)
@@ -474,6 +474,11 @@ void mt8365_afe_set_i2s_out_enable(struct mtk_base_afe *afe, bool enable)
 
 	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
 
+	if (!i2s_data) {
+		spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+		return;
+	}
+
 	if (enable) {
 		i2s_data->i2s_out_on_ref_cnt++;
 		if (i2s_data->i2s_out_on_ref_cnt == 1)
-- 
2.39.2


