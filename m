Return-Path: <linux-kernel+bounces-439645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569109EB224
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DD9167406
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E51A9B30;
	Tue, 10 Dec 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dTmqX/2y"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7F5474C;
	Tue, 10 Dec 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838400; cv=none; b=n4bB2kkl+mD6I23oPLo/Rt3FAt01CwyAfnw7vHzVWsa+uQB9YYWpmM/Wam9fSP6tXRlKzliBeEDJXcdq4jZqTgzcqZP+FTQ04kDwwRyqSVIesgMprEFTb7XUdds/+NzdDMGkMRPKHcJ1C0bdDUdn4FdjcPKjXV/W+oDUVxHr2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838400; c=relaxed/simple;
	bh=K8BKEsPwZfVtQ1cYfoZqbIL5ZMAioRFKM4YuvfrG6Oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdXxfdyFMs1aKN7PKBoNqsnfAJp51n1Z0qwOBOwa8E8+mTuDGgQ2jXZ2KvwhWvy4ql8DzQKGKwq6RvAs5n2OiVUnBnhwdAWBzASJloULHpXTh5O+hAZRJGkIYEvLpA2xiPPJXOPzI/8tyxsVOIE96zcx4wmxzexTtnhC9wQUSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dTmqX/2y; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9RBJK019832;
	Tue, 10 Dec 2024 14:46:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1xH1hRPovKqSjZCOM05XbpqMkFeQvHRRRSV7ye98WJk=; b=dTmqX/2yxaM92omG
	amKHH4saqd8K5qM4vp/lGUry64V4q/DRMPl+mNuHYTE8MD7kHlpEOVM1caVEuX9Z
	bCDKVZL/VUGkeTKhxOK3UZtsdiJda16fu4xu3EIBY15nU4oVGvv8U8Rq73WosxOo
	rxNXI05hylGaahES/Tdo7IN96WdWLan5mIYtddR3KaUPth47Sr55DS1rvSvjiz1b
	2RQyOEU+i+oSGM9NhBCWUanTiO8gBNkGe1+wlL+tFj+IpiW58W70hCXNxTjYGbKd
	5NC2kBY/lVWT+W3efjEVWWEyhu2oKhYecbi6qbrqhGGONqF52ivxKX0mXm1Xuj0l
	DkZfPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43cek1vwnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:46:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4593740053;
	Tue, 10 Dec 2024 14:45:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9283C2591FE;
	Tue, 10 Dec 2024 14:45:10 +0100 (CET)
Received: from localhost (10.252.12.81) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 14:45:10 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: hdmi-codec: allow to refine formats actually supported
Date: Tue, 10 Dec 2024 14:42:54 +0100
Message-ID: <20241210134254.2967524-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
References: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Currently the hdmi-codec driver registers all the formats that are
allowed on the I2S bus. Add i2s_formats field to codec data, to allow
the hdmi codec client to refine the list of the audio I2S formats
actually supported.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 5e1a9eafd10f..a65da989dab1 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -122,6 +122,7 @@ struct hdmi_codec_ops {
 /* HDMI codec initalization data */
 struct hdmi_codec_pdata {
 	const struct hdmi_codec_ops *ops;
+	u64 i2s_formats;
 	uint i2s:1;
 	uint no_i2s_playback:1;
 	uint no_i2s_capture:1;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d9df29a26f4f..3f9dfdbc693e 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -1077,6 +1077,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->i2s) {
 		daidrv[i] = hdmi_i2s_dai;
 		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
+		if (hcd->i2s_formats) {
+			daidrv[i].playback.formats = hcd->i2s_formats;
+			daidrv[i].capture.formats = hcd->i2s_formats;
+		}
 		if (hcd->no_i2s_playback)
 			memset(&daidrv[i].playback, 0,
 			       sizeof(daidrv[i].playback));
-- 
2.25.1


