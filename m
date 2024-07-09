Return-Path: <linux-kernel+bounces-245451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCA92B2AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D401D1C21922
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD7154BFF;
	Tue,  9 Jul 2024 08:54:37 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B7154BE4;
	Tue,  9 Jul 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515276; cv=none; b=TQ6iCIMgvSc5K4iwmEYuRO2Ln2hCOK4EGyvaxaenYyTNeblXGQlYM54rPWizkN1AxFr+ZJnrLdCc5vlYeEsAWKlpeNJup9cojp8azVDzt4iIq45Ynz9iX8PXnnb3LXsbm5T2dQVIXp3U3YYl+advB7R6fddkTkJANUmBzb3McrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515276; c=relaxed/simple;
	bh=cIiVSr1iYUHf8WjtaedoJtges/tulpFdO61UlfbtPr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btLxcKnW/MbM/Fu2WLBCmGNDwGWKieAQ5tUyo6LDyP7ajLqDOKc6WDIOigSoQZIDmndPDhSzRioTLer+ZuCbYdDXBDgj2+Jm5fq70dzrthXhJlyJXhzm8KO/5/LJ6Z8iik0/kXRn8+lcJMgEXo8sfi2VorY9Y6EUulDFYN8GZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADX3cmr+oxmTj1oAg--.4166S2;
	Tue, 09 Jul 2024 16:54:03 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	kuninori.morimoto.gx@renesas.com,
	jernej.skrabec@gmail.com,
	nfraprado@collabora.com,
	robh@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: mediatek: mt8192: remove redundant null pointer check before of_node_put
Date: Tue,  9 Jul 2024 16:51:31 +0800
Message-Id: <20240709085131.1436128-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADX3cmr+oxmTj1oAg--.4166S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW3Kr15GF17uFyDXFW8WFg_yoWfurg_J3
	WkK3Z7ur1UGr48Crsrtr98CFs7ZayakF1xZF1YqwnxGry7Gr15A3Z8trnrur45ZrWvy3W5
	ArsxZwn2yFZYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbrcTPUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

of_node_put() has taken the null pointer check into account. So it is safe
to remove the duplicated check before of_node_put().

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 8b323fb19925..db00704e206d 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1108,9 +1108,7 @@ static int mt8192_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 err_headset_codec:
 	of_node_put(speaker_codec);
 err_speaker_codec:
-	if (hdmi_codec)
-		of_node_put(hdmi_codec);
-
+	of_node_put(hdmi_codec);
 	return ret;
 }
 
-- 
2.25.1


