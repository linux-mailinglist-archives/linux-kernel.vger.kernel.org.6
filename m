Return-Path: <linux-kernel+bounces-360676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD7999DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FB61C21EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C37209F56;
	Fri, 11 Oct 2024 07:31:43 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4C20966D;
	Fri, 11 Oct 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631903; cv=none; b=snVyiTIjdf9PcIsFx03zJt7kA8dUeLOB5pZb5KTqiyuHR9G95RRL7f86vtrS5ZURyriiIb8SlW9qtNgwmdwkgHL4aF1ZbwplO7nZXikCcVrW/l5FdBXLvOvttN82UBCNeeXSWOXHfMgVFuT8c6QRV2ZjLJj/AjryeV9XMgL4DAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631903; c=relaxed/simple;
	bh=/OtMQHfjegFCEo7NwRpRk7DyXxCeDZBvJBS6n3PmWBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBTzRVRwg2cai3supWpJoQog/BuiMRXVgbkpAJExS/jWU1+qc43MAiv0YgQHGEJHQBZsosdpcFNE/MC5ufkc8MgHAKQ8OPCH633L/pJcwDdBSkVsijsh3UZqK+iYro2Qo/Lm4p2wCad/XxEScRbpXxM2qC+qKsQojaUPo153AMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66708d455a62-ce329;
	Fri, 11 Oct 2024 15:31:35 +0800 (CST)
X-RM-TRANSID:2ee66708d455a62-ce329
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66708d44e1b0-ab629;
	Fri, 11 Oct 2024 15:31:35 +0800 (CST)
X-RM-TRANSID:2ee66708d44e1b0-ab629
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: codecs: Fix error check in es8323_i2c_probe
Date: Fri, 11 Oct 2024 15:31:15 +0800
Message-Id: <20241011073115.2384-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function es8323_i2c_probe(), devm_kzalloc() could
possibly return NULL pointer, so IS_ERR() is wrong check
in this place, thus fix it.

Fixes: b97391a604b9 ("ASoC: codecs: Add support for ES8323")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/es8323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index c09bd92b2..6f4fa36ea 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -743,7 +743,7 @@ static int es8323_i2c_probe(struct i2c_client *i2c_client)
 	struct device *dev = &i2c_client->dev;
 
 	es8323 = devm_kzalloc(dev, sizeof(*es8323), GFP_KERNEL);
-	if (IS_ERR(es8323))
+	if (!es8323)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c_client, es8323);
-- 
2.33.0




