Return-Path: <linux-kernel+bounces-557198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E0A5D4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395DC3B31F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA41AF4E9;
	Wed, 12 Mar 2025 03:44:40 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF538FA3;
	Wed, 12 Mar 2025 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741751079; cv=none; b=c+rF6bzPxPWUa2DHGATJMUf9JoMPYn+kJ43wliiV9qyLEgDLlguYcUF5p3kApC/VomfYDoSybzPq1Ig358FaTWwvV6hiU6N59SQv4B+zYMn/3gMJNQmKHl42cuuKfbs8ltQ3n2adPx3X6GQoFJ/G6dOU+dzxr5nhlcubT5SPOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741751079; c=relaxed/simple;
	bh=r26RzrmcyIwwfK5053nO2QqbJbt9GQSCfmm9ooy8Vig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rl2nevKmtWhQ3Bi9bYfZVx8Cyro81LjGR/OjXgYIK4VbAaZRqTcDUV5dpwddjY0y0xWpSIjrF37UHRzYN9QGLjsitgw7IsUIvfMxho7IaaHZC+0ml5ZBImyclcnHDJDZemuwpDzZritKXkFwEa1/m9DpAgtPzR93Yw/y1PYJAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAD3_dEdA9FnDwlwFA--.17058S2;
	Wed, 12 Mar 2025 11:44:29 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: tlv320adc3xxx: remove unnecessary NULL check before clk_disable_unprepare()
Date: Wed, 12 Mar 2025 11:43:37 +0800
Message-Id: <20250312034337.1235378-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3_dEdA9FnDwlwFA--.17058S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyrKrWkZry7try8Gw17Jrb_yoWfJwb_Jr
	4kWrWvgFs8uFnIy34jqF45AF4vgw4kZF4DJw1Iyr48A34UXws5Zw4DAw1ru3WDA3yrJ3W3
	trnFvryrJr1IvjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjM5l5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for adc3xxx->mclk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/codecs/tlv320adc3xxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index 1a50ff675244..191e067ed1c9 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1493,8 +1493,7 @@ static void adc3xxx_i2c_remove(struct i2c_client *client)
 {
 	struct adc3xxx *adc3xxx = i2c_get_clientdata(client);
 
-	if (adc3xxx->mclk)
-		clk_disable_unprepare(adc3xxx->mclk);
+	clk_disable_unprepare(adc3xxx->mclk);
 	adc3xxx_free_gpio(adc3xxx);
 	snd_soc_unregister_component(&client->dev);
 }
-- 
2.25.1


