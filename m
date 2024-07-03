Return-Path: <linux-kernel+bounces-239170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268E925777
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C285B2366B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165614265A;
	Wed,  3 Jul 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="V9VrI4AN"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F2140E2E;
	Wed,  3 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000535; cv=none; b=AYOt7G0Q8zKn8pPtfpQyPrx21k+u97IGvI+zdMjiRZ1sxkViLqmbG3/EetKGRxNBakuNWstB06pDRHcAWp1HeCixbU7iHeVfESLt1s8Y0evO9e5Tm4xgUjGPIZEYcmlIpN4yGcyy9zk3pw5qm9WiVPQ02Y4r8xLXlI44tKJyPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000535; c=relaxed/simple;
	bh=esBEZWhMiBRliaM1qYn3jnE+yA8P72YVy85h047u40c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFxoFABEcgkIOw8Mb4iV1coIdgOj3wBmCG5Efu2/anRPK47MBtxrpUSfHF2Yn1q6pwvwCMYK7Bpn+XXKM72LM2jfos1qp2hzfG2x2IcZnyqObkb3J4KpybPEGg9vGyRLsWJFNiICZcSIKslVzWd9ODsSkoCiy3kjfBNmJwYWOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=V9VrI4AN; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637xDTR029630;
	Wed, 3 Jul 2024 04:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RmlRDYIfTUKyUgfRgzYWrwMdS4KjZ1LZo4J4TljIXaY=; b=
	V9VrI4ANN3cLU6Ih6QiWqyyLuUyZ0krQoI9XQT9ssf46/R91mfDIzsFYzbroB9j1
	KttzOIpalgxE9pkxC11y6H44zruL6H76QK2UBLQZcoln++K7BMejoTHLs5I/DCTf
	35r96sh19IFciYdh+L+PhcOFMJFwbweeVa6G5JMHgOx6Q9w1fiB+SE0aEExVD7wS
	+N2pSh6ZuXiQoXvZJduHjYPpHQGEjIc3byor3NcguI3rSNMge9U1mMraAwmgmy9K
	A++US4AJUzlEmy3TZjrA2AHy9s8mwAGTD0EQGdWuws8jN6EZ0nevEPHzICZaO0w0
	4L5ZVdK7QJDIp5SJm4STcg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxcq1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 04:55:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 10:55:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 10:55:18 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 02BA282024D;
	Wed,  3 Jul 2024 09:55:18 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: cs35l56: Use header defines for Speaker Volume control definition
Date: Wed, 3 Jul 2024 10:55:16 +0100
Message-ID: <20240703095517.208077-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703095517.208077-1-rf@opensource.cirrus.com>
References: <20240703095517.208077-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JuavNmVy9FjEPBFVai9Kd07yRzthcEcE
X-Proofpoint-ORIG-GUID: JuavNmVy9FjEPBFVai9Kd07yRzthcEcE
X-Proofpoint-Spam-Reason: safe

The "Speaker Volume" control was being defined using four hardcoded magic
numbers. There are #defines in the cs35l56.h header for these numbers, so
change the code to use the defined constants.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 7cac9812f5b5..84c34f5b1a51 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -71,7 +71,11 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
 	SOC_SINGLE_S_EXT_TLV("Speaker Volume",
 			     CS35L56_MAIN_RENDER_USER_VOLUME,
-			     6, -400, 400, 9, 0,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MIN,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MAX,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT,
+			     0,
 			     cs35l56_dspwait_get_volsw,
 			     cs35l56_dspwait_put_volsw,
 			     vol_tlv),
-- 
2.39.2


