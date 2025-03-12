Return-Path: <linux-kernel+bounces-557190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4E5A5D4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69177A7855
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB5199FAC;
	Wed, 12 Mar 2025 03:29:21 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0E23BE;
	Wed, 12 Mar 2025 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750161; cv=none; b=FqGx4Z9HEN8P4pHcj15yl+xa937KUvrlDKoUZTswqdmvQrPx4CljoI5zafnVCMOOqojfXRPzow87lvqyEQmoB2jxq4fEd3SzgDV2uVAblxolPs8zoZHdnWU1Pt/T3HDhhQWxLb8+FSuF7yY3sns1dZJdjFl2vKfCSbJN8Fghits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750161; c=relaxed/simple;
	bh=FWUM3NZREWQG7qU9wIHHRLfUg9oBKuw38aCsIKy8mN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqSVtGPBTBwRxkBabQA9Won1TpC7Fw/SaclbnYyy85m4jsPV2tANEiY3rvBOOUe1pIpak9SB8+RnePrgvDuUSQfzeXw2cJ8xINxuFwNTcS4EbY4Z5caQEA990v+bFQ1trvC1sbw7y2FFFnjZxJh3KRfdrP3M4cBIRtlHlWF2kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAHDm6C_9BnRipvFA--.20421S2;
	Wed, 12 Mar 2025 11:29:06 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: mt8365: remove unnecessary NULL check before clk_disable_unprepare()
Date: Wed, 12 Mar 2025 11:26:00 +0800
Message-Id: <20250312032600.1235158-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHDm6C_9BnRipvFA--.20421S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyrKrWkZry7tFykJw4kCrg_yoWfXrg_Xw
	4kKFnrWa4kGrnakw15Ga1qvFs3ZayUZFyrX34FyF1DJry5Gr45CrnFvw13uws5Jr4vkF1U
	Xrn8ZF4xCr4fAjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRpBDUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-clk.c b/sound/soc/mediatek/mt8365/mt8365-afe-clk.c
index 8a0af2ea8546..7078c01ba19b 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-clk.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-clk.c
@@ -49,8 +49,7 @@ int mt8365_afe_init_audio_clk(struct mtk_base_afe *afe)
 
 void mt8365_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk)
 {
-	if (clk)
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 }
 
 int mt8365_afe_set_clk_rate(struct mtk_base_afe *afe, struct clk *clk,
-- 
2.25.1


