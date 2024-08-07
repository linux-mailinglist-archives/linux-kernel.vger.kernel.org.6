Return-Path: <linux-kernel+bounces-278049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DE94AA19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C2E1F240E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE8770E1;
	Wed,  7 Aug 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E/mWnsAr"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557461FC4;
	Wed,  7 Aug 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040937; cv=none; b=GY72AW1bYkTNo9oY61xYwdjgvqGa66NH3Wv1GVSjMpIaj1jcgAJ5xROZ7jJLVjXWrFWE8jBqIkHct1XevRxcEIptpIsHcJO2OaHRPQ2vp9QkVfxDvHtQPFtp6MGiZeigy2xw0W2oDTM6jwsODXpAvfBh6MXlqr/t/yaZnyggi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040937; c=relaxed/simple;
	bh=ID+csheWgrV/L9tCHnYLlCDfrNvBZjYjtTOC7Rt0xTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IT2SuoRUGPWZpdC6YIjBtumwQJ5KwxCOwmwCPzeep7ZFWNQJQ8qFviavkHdtjR2Ki0T6uKrZERwJGwxF9wBk3/CNoCWMhjU4Y5P2lz/RMPHNBT33uugfHIS727W0uPnek1aw7FBne3JE/878yO6hHdxQZ7L6oS6jIf3LWtStX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=E/mWnsAr; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476KWxKr015964;
	Wed, 7 Aug 2024 09:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=7SlY5M2cWRn7f4bQ
	m1GLdBjXOl2gTmwj2IkqR+fECm0=; b=E/mWnsArIjSb4GIW0eSFcZvB3rmVLZL/
	PoqsdCojlZcxVtTBMsmW1EycrIQh1Lj1E2FIyYy/59K33VqGtz9mO0zxE0tRPsHr
	hCk5vSKV1oM2zY3G28tCWa+h5UalYRmgC34z3HFFReJR8lKh9ZHS1AJEkp1nWGae
	LZlJUShGy02mpBfzr9seeVPpz/QWb4RibmdoHIkOM+9GBLHlaZGq350Z3Ri/5OW2
	uki8Tw+/Vbl/eHlQDJgWg8DzDHlo2ULAR4WeeznENTwJF7F9nZq4RZbBRCT0mj+8
	XXAH95jDxkZWGVEPIDTtM7tSNXXtWdaENSiQxsHRHTSTpxBrjSqGKw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40shxx4hv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:26:53 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 15:26:50 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 7 Aug 2024 15:26:50 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5DF16820244;
	Wed,  7 Aug 2024 14:26:50 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value
Date: Wed, 7 Aug 2024 14:26:48 +0000
Message-ID: <20240807142648.46932-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -cBW06uARo2rdTMF2WZkUb4OSveLC9DZ
X-Proofpoint-ORIG-GUID: -cBW06uARo2rdTMF2WZkUb4OSveLC9DZ
X-Proofpoint-Spam-Reason: safe

Device tuning files made with early revision tooling may contain
configuration that can unmask IRQ signals that are owned by the host.

Adding a safe default to the regmap patch ensures that the hardware
matches the driver expectations.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e7e8d617da94..bd74fef33d49 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -36,6 +36,7 @@ static const struct reg_sequence cs35l56_patch[] = {
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
 	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
+	{ CS35L56_IRQ1_MASK_18,			0x1f7df0ff },
 
 	/* These are not reset by a soft-reset, so patch to defaults. */
 	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
-- 
2.43.0


