Return-Path: <linux-kernel+bounces-255124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F411B933C70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E80282F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84917F4FD;
	Wed, 17 Jul 2024 11:40:57 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D817F393;
	Wed, 17 Jul 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216457; cv=none; b=leAgW6emrm3GHDh34WF4eIoEw0OYJCCVNltQWseHKqM0FfgkZBkyjq3jiPyA+kunQXbSeoKJBxunhBbsvR9UH6moQCkv9gEmLgOVQFs9tzbNlm2Ybb2wmp+r5dsodK2GtpAavhsEnEyM3gk1XFV+KuaJPwTQoopfpd1TaGJAQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216457; c=relaxed/simple;
	bh=ho8OPqqYPohVofGeDvC/odMwqog0UDIQct1irdyzR3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehi+d4lhLfAo64vgH0n2z2w9Q+yjyvYVyT1TR+szQ6L+whyp5TGzvHXLPJuRwoVMZWkiMCbJSbyX5gYch3oOmlrxqbYcDYWsduoCz99qRNFVAbUYLNvNm963veObc01xNZECJWxCzNatIrAZdEhTnHK+9SCWhkB656vQ0vHjyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAD310yqrZdmQhreAw--.1010S2;
	Wed, 17 Jul 2024 19:40:36 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	jernej.skrabec@gmail.com,
	claudiu.beznea@tuxon.dev,
	robh@kernel.org,
	make24@iscas.ac.cn,
	kuninori.morimoto.gx@renesas.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak4642: Return of_clk_add_provider to transfer the error
Date: Wed, 17 Jul 2024 19:40:24 +0800
Message-Id: <20240717114024.3441163-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD310yqrZdmQhreAw--.1010S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur48tFW3Cr1fZr4DArW7CFg_yoW8JFyxpF
	n5Cr95tay3Jry8uF1rAr18W3WYkayv9F4rAa4rKwn29r13Jryj9w13AFyYqF4fZFy8CrWf
	XF4jyFWrCa1rAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Return of_clk_add_provider() in order to transfer the error if it fails due
to insufficient memory allocation or failure to set clock defaults.

Fixes: 171a0138ab75 ("ASoC: ak4642: enable to use MCKO as fixed rate output pin on DT")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 sound/soc/codecs/ak4642.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index fe035d2fc913..2f1b295bca98 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -609,6 +609,7 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 	const char *clk_name = np->name;
 	const char *parent_clk_name = NULL;
 	u32 rate;
+	int ret;
 
 	if (of_property_read_u32(np, "clock-frequency", &rate))
 		return NULL;
@@ -619,8 +620,11 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 	of_property_read_string(np, "clock-output-names", &clk_name);
 
 	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name, 0, rate);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (!IS_ERR(clk)) {
+		ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return clk;
 }
-- 
2.25.1


