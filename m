Return-Path: <linux-kernel+bounces-400870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE239C1374
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B1283796
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674AB67A;
	Fri,  8 Nov 2024 01:16:38 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435181BD9EE;
	Fri,  8 Nov 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028597; cv=none; b=h/BLGt2HQhQz135i4kpoyBAe/hCAUcA7F7oK8XeJvji5ZJ5z8g1SORKGtUOFvlWO853/1itaCOD4z2HyPka58ldZtR+wTK306lUAPiafGLcpDUDwCZ7+HfsGxLeBKcysQf3I8ukDb+99TeE60R4K3aKAmpnU8+MyaVbMSe+BGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028597; c=relaxed/simple;
	bh=Lz85XQdRDfqZ1fozUy+OlCnpPntlhJixHYqG1IomXsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eprc0MhcsjO8SIDCGJi5JlJl00ZViIuEzm7umNN4TNwcuhSrRKEI3EaMzTZBM6HUxAfGzFoZkpIdMbrthgsj83i3zqsu0rtXIPJlCZzxesV4adlcDk/Li+iKuCfmJijmVAkvTRsyaMoW+DJL6h6cNHyw40/thxEJCKlcpsNwI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9672d6668125-f2139;
	Fri, 08 Nov 2024 09:16:24 +0800 (CST)
X-RM-TRANSID:2ee9672d6668125-f2139
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea672d66627d0-7d7bb;
	Fri, 08 Nov 2024 09:16:24 +0800 (CST)
X-RM-TRANSID:2eea672d66627d0-7d7bb
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: kiseok.jo@irondevice.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: sma1307: Fix invalid logical judgement
Date: Fri,  8 Nov 2024 09:16:17 +0800
Message-Id: <20241108011617.2284-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function sma1307_dai_hw_params_amp, the variable
'ret' has not been assigned a value, so the logical judgement
is invalid, thus fix it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/sma1307.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 985a247b3..81638768a 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1191,7 +1191,6 @@ static int sma1307_dai_hw_params_amp(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct sma1307_priv *sma1307 = snd_soc_component_get_drvdata(component);
 	unsigned int bclk = 0;
-	int ret = 0;
 
 	if (sma1307->format == SND_SOC_DAIFMT_DSP_A)
 		bclk = params_rate(params) * sma1307->frame_size;
@@ -1336,8 +1335,6 @@ static int sma1307_dai_hw_params_amp(struct snd_pcm_substream *substream,
 			params_format(params));
 		return -EINVAL;
 	}
-	if (ret < 0)
-		return -EINVAL;
 
 	return 0;
 }
-- 
2.33.0




