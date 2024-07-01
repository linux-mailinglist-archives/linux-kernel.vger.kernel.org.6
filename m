Return-Path: <linux-kernel+bounces-236056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB791DCF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34DDB22EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D913D503;
	Mon,  1 Jul 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XnjaO90D"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BA664C6;
	Mon,  1 Jul 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830707; cv=none; b=QGkSKayF6+J3V6fyxEwc8l5fOQrJ3SPancD4xZOJcUYNZ3ZI6+Vs2RQXhwC3WkMrYXgqHk9csD5K3LqdQEOeI6MTm88yi3HAS6KISJiKU9pVhTJXFfO0q7CufMkhmU1WyjrkC3jsVxR/Fnlfnf21cKjhL1ayCwVLao4biMuo7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830707; c=relaxed/simple;
	bh=ppEZyCTx1x2jsfAV7x0LVq3kr0YNd/emoX6Wqo/kXEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOX40c9L7xMfv5BwOtIodLcctED0NvW4gPjhhsiqmbzwO4XVzL1q1YK8R9q1CzyJjoNl2Odgl4ewGHHhwx7TTZkq9lGz3beJHNmb2/nLzzoc7ojQAX6MqFoWTNdV52x97oeaFCUpt4O4azP16lvx38TcK2/PeQm/yAirhYDgo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XnjaO90D; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617Qrbw017780;
	Mon, 1 Jul 2024 05:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=C+UjOWKJZYKMEfALDrZ+CB3Ep15T+UKAiEh3PiEiuPE=; b=
	XnjaO90DzsozqsnbdHdj2veq7GbDsxn4wl8zFHf87kAXTd4dqTuVv2W2UW5fiLNY
	52LnxgCKIZH4OgYDef/uJD8RhHZJKyJvihuMy0Ea/JO9T/ktxDAgkmPc0sNdjS+6
	qwK2O1J2Q125r0daOw2cT9UnkrJ5OzGk45ydI9DacFc4jtgw8StUpO81MRd3CRf+
	Lcdmeww/odxH358wrTjfGLQJCFNLa4XswhyKGbt87qarZoWmvhNWwOs2j95hovYu
	eJn2Yxu2MLkhBzjwp+tgBWflRnFyhWW5GKflN3qrR/zr9J16TRVAdItgKngkZlpq
	cCDoZ0JKazzDg9wBQXPdpg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxa3x0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 05:44:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 11:44:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 1 Jul 2024 11:44:44 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B0ADA820258;
	Mon,  1 Jul 2024 10:44:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: cs35l56: Remove redundant clearing of clk_stop_mode1
Date: Mon, 1 Jul 2024 11:44:44 +0100
Message-ID: <20240701104444.172556-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701104444.172556-1-rf@opensource.cirrus.com>
References: <20240701104444.172556-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OMfk5AMUV-k6fHEnPsjv3Rw03SaLFLGM
X-Proofpoint-ORIG-GUID: OMfk5AMUV-k6fHEnPsjv3Rw03SaLFLGM
X-Proofpoint-Spam-Reason: safe

struct sdw_slave_prop is zero-initialized by the SoundWire core so there
is no need to clear clk_stop_mode1 to false. Removing this also avoids
having an unnecessary build dependency on a struct member.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 8862107105ae..fc03bb7ecae1 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -271,7 +271,6 @@ static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
 	prop->source_ports = BIT(CS35L56_SDW1_CAPTURE_PORT);
 	prop->sink_ports = BIT(CS35L56_SDW1_PLAYBACK_PORT);
 	prop->paging_support = true;
-	prop->clk_stop_mode1 = false;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY | SDW_SCP_INT1_IMPL_DEF;
 
-- 
2.39.2


