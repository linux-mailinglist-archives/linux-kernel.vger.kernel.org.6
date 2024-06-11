Return-Path: <linux-kernel+bounces-210102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B581903F52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375BFB231C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667012E7F;
	Tue, 11 Jun 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="giY8PTxh"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4A12E48;
	Tue, 11 Jun 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117889; cv=none; b=ujwGIR/9MNsLYWoHEeYmSrRPDTsIcbvVfJ5MjDQN0TddceGMuLezY5vqCbaubcReTUJn06M6CBKsvf7v0FcZrAxGmeN6WzSgJB97+QlK4L7neMtOxHbQai0EroCqd4dvAVXBU7zTeUS7zn8duTQT5Oa2vI/swF9Wxu8vBDjeNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117889; c=relaxed/simple;
	bh=ZJ8VbXXP3AnC9ZNMxMjSv7o2Xkso7k3k+k/EYi1Nzb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hxa0KRClaD3cuo+bpCXrJyuHS276btnoMwGp7q4FFCYhqEIACbDOzo3o1+Z3GISN2KOZfW0nQEOeE92xYQK/a9VExToslxGuYD3DzUCz6IkhtVAB1PjziVtS/X/ZIBIj6Nev780W6KsA8OkjyUpnxC57MVSkEiV/7inyPQxyoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=giY8PTxh; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B4nj4Q024536;
	Tue, 11 Jun 2024 09:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=oYYo0l6rNzLFOjdE
	5P7hh94k5PnFvUYyGvEk2R4YEGk=; b=giY8PTxhW5cDjDTp3G41gB1EAx3SaAUp
	1z0cb4eOk+V1z6xdt7FSpxluVBmcp3SQWqRPFlC8kYp8Oae+Mn4tcM+B0yBzz9AU
	50mMXvEQ3mEPA3uJaoK53OyN5XKuSHQSUAhhMqq8LbRurBkVk0Urfq6RD3T4QMMF
	TxlkmeUJMLwrvqo9M6ssDUoMxaCH6mrLV2HRiNnlkxPLBDRrxi1lV4Q+sMVcKjfb
	7H7JfANQFYmom/BPirkLv6O/ESQxQ+eFuqnJpvzGG2kr0p9Nlyeo5btkm3yXNwbf
	xAZSIVv7REiWIk5MJgJp+NuwjS2x9XdQqhOPDHloIyf6uSiy6E6qMw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhtyr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:58:00 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 15:57:46 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 11 Jun 2024 15:57:46 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0FF41820244;
	Tue, 11 Jun 2024 14:57:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI is hooked up
Date: Tue, 11 Jun 2024 15:57:46 +0100
Message-ID: <20240611145746.1454663-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TnZIrOfp0w8piWcQDKrmvTq4zw0Qm3Pv
X-Proofpoint-ORIG-GUID: TnZIrOfp0w8piWcQDKrmvTq4zw0Qm3Pv
X-Proofpoint-Spam-Reason: safe

If the ASP1 DAI is hooked up by the machine driver the ASP TX mixer
sources should be initialized to disconnected.

The silicon default is for the mixer source registers to default to
a collection of monitoring sources. The problem with this is that it
causes the DAPM graph to initialize with the capture path connected
to a valid source widget, even though nothing setup a path. When the
ASP DAI is connected as a codec-to-codec link this will cause the other
codec to power-up even though nothing is using it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: dfd2ffb37399 ("ASoC: cs35l56: Prevent overwriting firmware ASP config")
---
 sound/soc/codecs/cs35l56-shared.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 8af89a263594..30497152e02a 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -215,6 +215,10 @@ static const struct reg_sequence cs35l56_asp1_defaults[] = {
 	REG_SEQ0(CS35L56_ASP1_FRAME_CONTROL5,	0x00020100),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL1,	0x00000018),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL5,	0x00000018),
+	REG_SEQ0(CS35L56_ASP1TX1_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX2_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX3_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX4_INPUT,		0x00000000),
 };
 
 /*
-- 
2.39.2


