Return-Path: <linux-kernel+bounces-365043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD099DCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64828B2203A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5B16EB56;
	Tue, 15 Oct 2024 03:17:57 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBB535DC;
	Tue, 15 Oct 2024 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962277; cv=none; b=SStLI3TkCSKCWozHjGuRkQkOZRIYYi0JRVl8TCpSJQJny6Mh5dzJAiFMwG2dIDQ1QfSuom4X2lDvhv/t46bgSS077WwC6IYuyWQ8+5wJ9y3MlkBEhUJeOinmOQCDEuLlvXodc8DGxV9x3PAyiwLKmAPoQG7IIrSy8VMgncrNGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962277; c=relaxed/simple;
	bh=IvNl+e/jdFX3O2ee93w1EJwzsWmALvajjo/0IM8HNZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O9+fgMqP6FxOxTJ1fky13lKzEz02bJjzInq16dY1eNxtGpJ59c46WOOy8vSIduAhQqXjvU2YG/+rMklg0mQmaCgKzqdTUZmoN0GRxm0LTZxdn1jWqwNxlnvZK7slcxK2sfTTKGE0nXPKnrxrVaGkXpDCXIIl9Kc3aie8tw3s/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5670dded8cd5-1ece4;
	Tue, 15 Oct 2024 11:17:45 +0800 (CST)
X-RM-TRANSID:2ee5670dded8cd5-1ece4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1670dded8074-e5d74;
	Tue, 15 Oct 2024 11:17:45 +0800 (CST)
X-RM-TRANSID:2ee1670dded8074-e5d74
From: Liu Jing <liujing@cmss.chinamobile.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fix code redundancy in sound/soc/soc-core.c
Date: Tue, 15 Oct 2024 11:17:42 +0800
Message-Id: <20241015031742.5144-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the snd_soc_register_dai function, the logic for assigning the value of dai->id can be simplified
using the conditional operator (also known as the ternary operator).

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 sound/soc/soc-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 20248a29d167..cbe2be64e1c3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2663,10 +2663,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 		dai->name = fmt_single_name(dev, &dai->id);
 	} else {
 		dai->name = fmt_multiple_name(dev, dai_drv);
-		if (dai_drv->id)
-			dai->id = dai_drv->id;
-		else
-			dai->id = component->num_dai;
+		dai->id = dai_drv->id ? dai_drv->id : component->num_dai;
 	}
 	if (!dai->name)
 		return NULL;
-- 
2.27.0




