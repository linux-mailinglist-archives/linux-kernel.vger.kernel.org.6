Return-Path: <linux-kernel+bounces-312561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75CC969834
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D4EB26C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C646E19CC33;
	Tue,  3 Sep 2024 09:03:29 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0271C7676;
	Tue,  3 Sep 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354209; cv=none; b=CwTHcA9B5ZfoxSWVsUeQNv7DQAf8BUAXhjnnlCe6nmiW7uCk46zVNtN8cXKmfLM70ZSfR3blc0cOgQYKIttN+oznEKYRfHSBI3MGmq2ViMXBX+E9HYAXYmc2u7084w3Cf2blmDAn3SVO/sDMBTfNTYg6e5L18WsBZjZBDaNQxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354209; c=relaxed/simple;
	bh=NzCeu5tuB4jMHUAOUePsBvLFXaF5uTY6HpeVJpCh+MI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GGKRbpUBkXel+EAcZXzpkjvhxWhUWPBVr1K6JBNEIvle0ITCCZ4xDcH3aMjyJ/AXfpfcRPfrBcsAYXYU00oEAmoWsf9y1RXvEF2Xt6MLZIIWCYFnfg7ZZ8bF9mwl5rw3UvJRcwS6MHngr61C2BZvfNfSQIwRB6PNP3WZ8gF3Vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266d6d0d1378-11380;
	Tue, 03 Sep 2024 17:03:16 +0800 (CST)
X-RM-TRANSID:2ee266d6d0d1378-11380
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d6d0cf4f1-d97ed;
	Tue, 03 Sep 2024 17:03:15 +0800 (CST)
X-RM-TRANSID:2ee766d6d0cf4f1-d97ed
From: tangbin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: loongson: remove unnecessary assignment in i2s_resume()
Date: Tue,  3 Sep 2024 17:03:01 +0800
Message-Id: <20240903090301.6192-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, the assignment ret is unnecessary,
thus remove it.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 sound/soc/loongson/loongson_i2s.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/loongson/loongson_i2s.c b/sound/soc/loongson/loongson_i2s.c
index d45228a3a..3b9786076 100644
--- a/sound/soc/loongson/loongson_i2s.c
+++ b/sound/soc/loongson/loongson_i2s.c
@@ -255,13 +255,10 @@ static int i2s_suspend(struct device *dev)
 static int i2s_resume(struct device *dev)
 {
 	struct loongson_i2s *i2s = dev_get_drvdata(dev);
-	int ret;
 
 	regcache_cache_only(i2s->regmap, false);
 	regcache_mark_dirty(i2s->regmap);
-	ret = regcache_sync(i2s->regmap);
-
-	return ret;
+	return regcache_sync(i2s->regmap);
 }
 
 const struct dev_pm_ops loongson_i2s_pm = {
-- 
2.33.0




