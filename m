Return-Path: <linux-kernel+bounces-407264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554519C6B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173DE2835C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890E18A95E;
	Wed, 13 Nov 2024 08:58:06 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BB188708;
	Wed, 13 Nov 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488285; cv=none; b=Q5LhAplHV5PW/+CCRLx3hHINLiK9cG0AY808PeEbl0OCSbt/qckw+wg2mCAsDiil77RErgklk600pbLXJVYNeKYq8ZJyTLD57h9HAG1uuiiVLaar/nk/LDpWG4I/4RC2ePcnGBcEosAGenf2PvbVz3AK4FBQux3a32wJqHOxMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488285; c=relaxed/simple;
	bh=oF8JfNn6/008ufAIsN7C5qnm81Vbp9kIwRvDxBxalwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roXlmxbsR0pmBJsVZPrwLshFuDF28uKpB2hHDCZzBac1Mj//cd9EFaNKV9xrLUZLyb0DAN/NqI7isz7r3t/LR1UxxwyP+tB+xKoG+S1T6JVRAs3m62LXEmcj09mf3qfEKWWYSaLHEZrfBEIiMNLQ5GKM9UBq7P58DyDGv8MS1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee967346a16fe5-1dffa;
	Wed, 13 Nov 2024 16:57:58 +0800 (CST)
X-RM-TRANSID:2ee967346a16fe5-1dffa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee167346a1455e-82c5d;
	Wed, 13 Nov 2024 16:57:58 +0800 (CST)
X-RM-TRANSID:2ee167346a1455e-82c5d
From: liujing <liujing@cmss.chinamobile.com>
To: david.rhodes@cirrus.com
Cc: rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ASoC: cs35l45:Increase the error checking returned by the function.
Date: Wed, 13 Nov 2024 16:57:56 +0800
Message-Id: <20241113085756.2636-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cs35l45_dsp_init(), it is necessary to check
the return value of the wm_halo_init function.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index fa1d9d9151f9..c045c7c05947 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -1365,7 +1365,10 @@ static int cs35l45_dsp_init(struct cs35l45_private *cs35l45)
 	dsp->cs_dsp.lock_regions = 0xFFFFFFFF;
 
 	ret = wm_halo_init(dsp);
-
+	if (ret) {
+		dev_err(cs35l45->dev, "wm_halo_init failed: %d\n", ret);
+		return ret;
+	}
 	regmap_multi_reg_write(cs35l45->regmap, cs35l45_fs_errata_patch,
 						   ARRAY_SIZE(cs35l45_fs_errata_patch));
 
-- 
2.27.0




