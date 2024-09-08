Return-Path: <linux-kernel+bounces-320243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D979707EC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D392281DE6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1916FF41;
	Sun,  8 Sep 2024 14:03:16 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6629CF7;
	Sun,  8 Sep 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804196; cv=none; b=TlB6k25nnkQopR+Y9zrNWbgAGO8bAvMXAa33QYA7Onr0deHi8+UfnKsdnzzL9kRVnwKQFoXm/04JffC7AS8UUOR1Med0HlDzf2L25dJ9tfEK3rrKaU9cNQQ7XYmi4CSRA1iQ0YN2y/A154aGic9nzi1zoCf7VznzeU+gT1qd714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804196; c=relaxed/simple;
	bh=/zUV+wsffSBMJF3ubql0/xykGgvQ/PvnMyt4eWIMoIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYeaU9reu/eNvwaysHysNnYQLby6BmngP3gDEZhpvnFafrhqIHFlJHVAI7VGbiud/JMlywz3EiSECMwJmDqcnRrt56KcyVt0vzjz+3HiF5moBqGRCECxsuTJq+JKODhH6eEOCix8lJqM0Iar5qNJQ7zZYQ3MZ2OdBZwptMS04O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466ddae9c65a-d3f4f;
	Sun, 08 Sep 2024 22:03:10 +0800 (CST)
X-RM-TRANSID:2ee466ddae9c65a-d3f4f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.102.140 (unknown[223.64.113.255])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366ddae956e3-13b16;
	Sun, 08 Sep 2024 22:03:10 +0800 (CST)
X-RM-TRANSID:2ee366ddae956e3-13b16
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: topology: Fix redundant logical jump
Date: Sun,  8 Sep 2024 22:02:59 +0800
Message-Id: <20240908140259.3859-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function soc_tplg_dai_config, the logical jump
of 'goto err' is redundant, so remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/soc-topology.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index af5d42b57..af3158cdc 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1894,7 +1894,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 		caps = &d->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
 		ret = set_stream_info(tplg, stream, caps);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	if (d->capture) {
@@ -1902,7 +1902,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 		caps = &d->caps[SND_SOC_TPLG_STREAM_CAPTURE];
 		ret = set_stream_info(tplg, stream, caps);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	if (d->flag_mask)
@@ -1914,13 +1914,10 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
 	if (ret < 0) {
 		dev_err(tplg->dev, "ASoC: DAI loading failed\n");
-		goto err;
+		return ret;
 	}
 
 	return 0;
-
-err:
-	return ret;
 }
 
 /* load physical DAI elements */
-- 
2.33.0




