Return-Path: <linux-kernel+bounces-557193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E4A5D4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E477AA5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AED199FAC;
	Wed, 12 Mar 2025 03:36:15 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620D78F44;
	Wed, 12 Mar 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750575; cv=none; b=fQEHrp8AMZJPZ413s9x4NQgvSJqhEva6dL074saSuEkFlKB6n207e4lunVFHy7/MJ2QFGkshwZTdT0qvEeyW8b05V9VdYCs223oZ3Wl/kPPT0LvDTCjayXLQCrFnLbvQA9H4Y+R6pjaBl9pifBEWUgZyUBB+LRSDUpoi319tqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750575; c=relaxed/simple;
	bh=OAgx2MfhXWi3VEby4hulS32luPNurXJaHZkZEegwr+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikagfb5OmpfsAThg3agIvEVpu2IKyZ00TNxe/LZ79ml7JoPxkmC4Jg9muf+hy9A47xVeM/S5CrMjRL4DjdS22+F7NIZqu0wmBK2Ur7v19omEhOgGfHFVaYC0qFb7E+NOUV4/tAbK3oyazy1ariDNm9fghHG5RcbMmncXPXdqnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABXX9MmAdFnHo9vFA--.26624S2;
	Wed, 12 Mar 2025 11:36:07 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: peter.ujfalusi@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: ti: davinci-i2s: remove unnecessary NULL check before clk_disable_unprepare()
Date: Wed, 12 Mar 2025 11:35:09 +0800
Message-Id: <20250312033509.1235268-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXX9MmAdFnHo9vFA--.26624S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyrKF1DtryUCFykZryrJFb_yoWkCrbE9w
	4DurWDWF4rur9avayDCryUAF1vqr1qvFs5uryFvF40qryUXw4Yy3y2vF13Zry5W3yxGF13
	Wr1qgr43Cr4S9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjM5l5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for dev->ext_clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/ti/davinci-i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index d682b98d6848..059967f0e632 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -892,8 +892,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 err_unregister_component:
 	snd_soc_unregister_component(&pdev->dev);
 err_disable_ext_clk:
-	if (dev->ext_clk)
-		clk_disable_unprepare(dev->ext_clk);
+	clk_disable_unprepare(dev->ext_clk);
 err_disable_clk:
 	clk_disable_unprepare(dev->clk);
 
@@ -908,8 +907,7 @@ static void davinci_i2s_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(dev->clk);
 
-	if (dev->ext_clk)
-		clk_disable_unprepare(dev->ext_clk);
+	clk_disable_unprepare(dev->ext_clk);
 }
 
 static const struct of_device_id davinci_i2s_match[] __maybe_unused = {
-- 
2.25.1


