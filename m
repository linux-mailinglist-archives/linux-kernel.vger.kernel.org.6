Return-Path: <linux-kernel+bounces-278051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E294AA24
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8348B2B2FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5C79DC5;
	Wed,  7 Aug 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W4KPw2mj"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C261FC4;
	Wed,  7 Aug 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040964; cv=none; b=r1M1+1CURjEQnTh1nnypPkruqtqCJf0wERP/zMC9Z2q73F0VXT63aop3kXeeo/LacE+pD6kXojSo5tkJDESmrXqxh7bN4cwNQRCegOBOanxxPl0ANaRLTjUAYQ0X+JVwqVT/vRrs+nUa4+sX/tY904+sd/7bI3jxMyqBV5Tx3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040964; c=relaxed/simple;
	bh=JSlmQu0sMhUSvnb2vx7Z4vXQuFMmDuKF1NXJ4GjBvLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGZJ9T5T3B8UDQHlV4I1XFYK831gjwps3TaX1vqoos1ODStwCAgtuArrn9Y+w5pRd+N9K5ryMhpby9xbFW0cKB9Hr8dZ8/o3/fLu8DYCZ7M8n+aDOCW2hf5TIvy2YIRxIBL2vQvGeLEDSwLhZ/AZAjtm+KmP/njvAUj2+aEgyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W4KPw2mj; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772aVhV001596;
	Wed, 7 Aug 2024 09:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=p0oTbEs7cI+w0AoN
	8oY3G9EIxazKWWurXI38qc2APK0=; b=W4KPw2mj/rKY27c8FmcSANFBkztmg6oQ
	5hfMx1XKDsoTJv3agqLXbW20tnvomZWHu+u0jF4dT+rhLd6Fk/NIgx6GIR80Um6M
	4LjbuwRx6/95/vBV+5D2KIAMYUZ7d/yoRFZJX3OW8yVAGp5rq29Kfad0v6qzQv9u
	fFuDIWIE8s8xePS3mf4pv1+Kq1mv7IqLgzSMMzIOjahERzXo/KxIY9003RJpEA2C
	xD0cT5HRQp73g93kDjC8VkZ5iKzTEhpNqi01HYd98atTja/61ydWHpd6Ic9fhBYV
	D+zixzV88U18unmEmKJoW89C5GVfupMh4ErCQWVb/2mwev6DTWcoYQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40shxx4hvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:27:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 15:27:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 7 Aug 2024 15:27:18 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D875C820244;
	Wed,  7 Aug 2024 14:27:17 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Use regmap_read_bypassed() to wake the device
Date: Wed, 7 Aug 2024 14:27:15 +0000
Message-ID: <20240807142715.47077-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -z6U3q9v758xXAD3PAczDtYAJn0qULY_
X-Proofpoint-ORIG-GUID: -z6U3q9v758xXAD3PAczDtYAJn0qULY_
X-Proofpoint-Spam-Reason: safe

Now that regmap_read_bypassed() has been added to the kernel it is
preferable to wake the device with a read rather than a write as the
utility function can be called at a time before the device has been
identified.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e7e8d617da94..91b3c1c8575c 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -450,32 +450,23 @@ static const struct reg_sequence cs35l56_hibernate_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE),
 };
 
-static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_WAKEUP),
-};
-
 static void cs35l56_issue_wake_event(struct cs35l56_base *cs35l56_base)
 {
+	unsigned int val;
+
 	/*
 	 * Dummy transactions to trigger I2C/SPI auto-wake. Issue two
 	 * transactions to meet the minimum required time from the rising edge
 	 * to the last falling edge of wake.
 	 *
-	 * It uses bypassed write because we must wake the chip before
+	 * It uses bypassed read because we must wake the chip before
 	 * disabling regmap cache-only.
-	 *
-	 * This can NAK on I2C which will terminate the write sequence so the
-	 * single-write sequence is issued twice.
 	 */
-	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-					cs35l56_hibernate_wake_seq,
-					ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+	regmap_read_bypassed(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
 
 	usleep_range(CS35L56_WAKE_HOLD_TIME_US, 2 * CS35L56_WAKE_HOLD_TIME_US);
 
-	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-					cs35l56_hibernate_wake_seq,
-					ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+	regmap_read_bypassed(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
 
 	cs35l56_wait_control_port_ready();
 }
-- 
2.43.0


