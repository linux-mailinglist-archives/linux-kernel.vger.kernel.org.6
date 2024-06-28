Return-Path: <linux-kernel+bounces-233557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C65691B96F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BDD1F225AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0D145334;
	Fri, 28 Jun 2024 08:06:48 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F54436A;
	Fri, 28 Jun 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562008; cv=none; b=P2AOPqd+TZdb3kjW4MZi9R4pPJxn3vGxFcTJFkYgRgUH6kEtRzVApVHq0jyeH4HuWzSuIh3Y2D4Gzu9VbUozUZVBRXcB/PtyFdFOmREt+vprmcxx4CwGa/7V92Ax8JGwVtkBWkGrINGNQlzGr8JPa8zdaEnAwSqHbozlrKBEiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562008; c=relaxed/simple;
	bh=1pPNyQf9RfZV5+5tCsb2gmDUywlRx2DwWpQE1OstHtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AYImCxqApzzhZ8CuZv+ueBq4orGWE11Z23Gagd62ONJ4MOsrQ8gZYdjFFuEvIRVeDzsfKDlGJyaqABP4yG6f7bQoG3bKkuwCuEeh0BV3Dmx86iPxazDvgtnnCc3G+A3qY/a2VFlDxvzPS0HZkN722f62ay3AblXhQIXx9fWtRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX3eX0bn5mLEZaAA--.20555S2;
	Fri, 28 Jun 2024 16:06:13 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	m.felsch@pengutronix.de,
	trblinux@gmail.com,
	javier@osg.samsung.com,
	afaerber@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: max98088: Check for clk_prepare_enable() error
Date: Fri, 28 Jun 2024 16:05:34 +0800
Message-Id: <20240628080534.843815-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3eX0bn5mLEZaAA--.20555S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XrW5WFykGryUJrW8XF45Awb_yoW8JrW5pr
	s7trZ8ArW5X3yruan8t395ur1fJryfCa4fCrW2k34UZr13Ar1xWr1rKr9FvF4kXr18Crsx
	Wr12qFs8ZF1qg3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUe2NtDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_prepare_enable() may fail, so we should better check its return
value and propagate it in the case of error.

Fixes: 62a7fc32a628 ("ASoC: max98088: Add master clock handling")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/codecs/max98088.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 8b56ee550c09..8b0645c63462 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1318,6 +1318,7 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
                                   enum snd_soc_bias_level level)
 {
 	struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1333,10 +1334,13 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 		 */
 		if (!IS_ERR(max98088->mclk)) {
 			if (snd_soc_component_get_bias_level(component) ==
-			    SND_SOC_BIAS_ON)
+			    SND_SOC_BIAS_ON) {
 				clk_disable_unprepare(max98088->mclk);
-			else
-				clk_prepare_enable(max98088->mclk);
+			} else {
+				ret = clk_prepare_enable(max98088->mclk);
+				if (ret)
+					return ret;
+			}
 		}
 		break;
 
-- 
2.25.1


