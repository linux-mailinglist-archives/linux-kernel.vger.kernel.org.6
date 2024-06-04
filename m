Return-Path: <linux-kernel+bounces-200706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E68FB3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F872893CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24011474BF;
	Tue,  4 Jun 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l6mpYBvh"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1EB146A9F;
	Tue,  4 Jun 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507742; cv=none; b=LL0im7fUPOjXM5JrXVgZGqH3tLSCCPzyDBKkqXnfWRPa3GqEJ9tHjU6nBOFC3xk+I1YYOG64eKdmJxH+70++r8D7Mpb+FelhDzVJSQm9rm7uZOj714O1u2IucaztrKDkmPQe2ZFKF8mLvg/bT4uR+hv0mZRY5DIJhTx2sEhcv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507742; c=relaxed/simple;
	bh=0KwW1lP/Fqd8gjgjRDUsphqXkDbnWeiSvjLBafUfRGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1Qzg2IuYi6HJp02rNClLQTw0bFq4A/slj49n536oCbd1jJCbuK+5NX46OKLiQLGTgweUKoe8KG56QMGtnHnbHFtPURuytg5h0Rxn8SpHubJH7bDKKoo5dpQoImx3vo39ODAgVQSWH5CV+yPqN57okbYwvDAU72xuOYMTChg31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l6mpYBvh; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45460IGT000510;
	Tue, 4 Jun 2024 08:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=rKo8sesOPIoJBk+m
	TspMtgIGKL1blFi2gZP4ywVyU1Y=; b=l6mpYBvhEd4IgDu3okT36y5zKwqs4LFM
	QX3ExZLC35wbjlwIfSf4Rhu91Pj53GNgAXLej7SVVuW/f1u0JpIwiqUMVr7YNEgu
	IYOL/JSc0NTRIi0q1Zp/QLW59S5NDqoRQIEghi1DcQxyaF9kbwO0ZhBYG3acl3+p
	ndCR3qKmsRdKxrzd/M/q9pCmKciMn8REwZbNmEbMx//irOPfYYYsqs87DKK1x/5T
	Ny1mKB6XSYQ5VG+NpgerWoP/ifjCpuwgnirythrqYniIaoUHy16WtSk//czUm/u6
	wPfAv1tdnmG+zhGHSTJIYWJmAaV4SnZP8x6HHijSoGGzH3ROJZtVIA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yg11xtn63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 08:28:46 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 14:28:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 4 Jun 2024 14:28:44 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E886A820249;
	Tue,  4 Jun 2024 13:28:43 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l43: Increase default type detect time and button delay
Date: Tue, 4 Jun 2024 14:28:43 +0100
Message-ID: <20240604132843.3309114-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AN8n7csA4cJcXIBdG4ezxSesYiOW-B9u
X-Proofpoint-ORIG-GUID: AN8n7csA4cJcXIBdG4ezxSesYiOW-B9u
X-Proofpoint-Spam-Reason: safe

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Some problematic headsets have been discovered, to help with correctly
identifying these, the detect time must be increased. Also improve the
reliability of the impedance value from the button detect by slightly
increasing the button detect delay.

Fixes: 686b8f711b99 ("ASoC: cs42l43: Lower default type detect time")
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43-jack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 901b9dbcf585..d9ab003e166b 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -121,7 +121,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 		priv->buttons[3] = 735;
 	}
 
-	ret = cs42l43_find_index(priv, "cirrus,detect-us", 1000, &priv->detect_us,
+	ret = cs42l43_find_index(priv, "cirrus,detect-us", 50000, &priv->detect_us,
 				 cs42l43_accdet_us, ARRAY_SIZE(cs42l43_accdet_us));
 	if (ret < 0)
 		goto error;
@@ -433,7 +433,7 @@ irqreturn_t cs42l43_button_press(int irq, void *data)
 
 	// Wait for 2 full cycles of comb filter to ensure good reading
 	queue_delayed_work(system_wq, &priv->button_press_work,
-			   msecs_to_jiffies(10));
+			   msecs_to_jiffies(20));
 
 	return IRQ_HANDLED;
 }
-- 
2.39.2


