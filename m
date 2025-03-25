Return-Path: <linux-kernel+bounces-574700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFFA6E8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9871896959
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795321A01B0;
	Tue, 25 Mar 2025 03:23:26 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E19EED3;
	Tue, 25 Mar 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742873006; cv=none; b=oxFjk60OBB0EqfK6+DRdANEDgXqjM4qBo1UOyCGVqoB7fuc+3pAB+MTH6vKT6p2b8VuGLqHZm5Qr5QX7ztEqt+ke5SCdmfpKCIMH25EiNx60YvSV/ylujoaJf5BhxxydSe8Kfv/5kbJMHnIHpDh4hNrgwQBCvh0ERwB9kLwtkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742873006; c=relaxed/simple;
	bh=rd9i8dgbnAd4pPlE/4TEkDG791nbj1ZneQCHyosD2mU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ay5KC32gFUPhj/I5uyu/svnONemcwSF6p8i8ZBeG1zfPssUPXAuMJDb7K+9H2jPQQpcXnmcuDh4S7PRw5C1oKU5SAtsoV5Tgk6pngpeh59Z5tnzogbMN/jDzBsyDOMXm/BV5giM3JdEec/B55BwWgobfHC8AoyKbhdzpHiK6dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABnowuVIeJnhWouAQ--.859S2;
	Tue, 25 Mar 2025 11:23:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	andy.shevchenko@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: sta32x: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Tue, 25 Mar 2025 11:22:26 +0800
Message-Id: <20250325032226.603963-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnowuVIeJnhWouAQ--.859S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFyrKrWkZrW7KF1fAryxXwb_yoW8JryUpF
	Z2yrZ5tF4xZFWY9Fn8Ar4vvF1UKFWYkFWxWF1UWwnrJr15GFn7Wr48Ar18ZF17JrWFgwnr
	ZrnFkw48Za1rK3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUedgADUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/codecs/sta32x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index bd8848ea1ec2..24d4b643917d 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -983,8 +983,7 @@ static int sta32x_probe(struct snd_soc_component *component)
 err_regulator_bulk_disable:
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 err_clk_disable_unprepare:
-	if (sta32x->xti_clk)
-		clk_disable_unprepare(sta32x->xti_clk);
+	clk_disable_unprepare(sta32x->xti_clk);
 	return ret;
 }
 
@@ -995,8 +994,7 @@ static void sta32x_remove(struct snd_soc_component *component)
 	sta32x_watchdog_stop(sta32x);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 
-	if (sta32x->xti_clk)
-		clk_disable_unprepare(sta32x->xti_clk);
+	clk_disable_unprepare(sta32x->xti_clk);
 }
 
 static const struct snd_soc_component_driver sta32x_component = {
-- 
2.25.1


