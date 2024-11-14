Return-Path: <linux-kernel+bounces-409117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB269C87E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BA9B2E05A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47C1F8918;
	Thu, 14 Nov 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aTWm2+xF"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70014B942;
	Thu, 14 Nov 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580296; cv=none; b=AuCmJBlhVQxmxGQpWHTCPL4TR4GeeXa2thSWhSy3G69u8HH0gf27aVeqOzl3MrNejlXbknchCOkgOY9HTZZHmspnsECQ/cA2i3d6K8/ENC9mJKsikGtHh5/SkHswyTWAFjqU/O6Ww8jjuB67QUcpSdxV7AozYv8z5RJ+mkHk3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580296; c=relaxed/simple;
	bh=qCoX3+VkQ38G13GdIqddjFmSup3UZnQ3D7vMWOypKBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iakHrL3ClM5P5d8jQ1fLXVm0cLhHT6YR3jZhPh9r8DhWcpJZ++ZWbSQk66M+s/BC0lkVolH8Tv+j7Dn3pubPh9JCLig4RYy38d0nC3FB9xKOEOMTVBWHjhic9iD4AqJZTYyC+/NJD/k47ON0n+YO5jdBWBbZEZCCow4vq4/5cV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aTWm2+xF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE7WL5J031759;
	Thu, 14 Nov 2024 11:30:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=hiPcXqx00CT+g9yrysVEHS
	Sc0YHvwdzRVZ4uugck4gw=; b=aTWm2+xFv7l+ln9kdScdK/yDueFjIDL1xRPZHD
	GS3/A4/V8xNXAyG/r0heQKeuNBCfGUNq57v60JLw101EXMMkdZPCl9JsgehOklXB
	psTiPiZuopKfb6OXmQ7OSqQMYgIzG1nG00XjmQ5RVqJZjToMFk4qH1ULqPF7X1mY
	e2XCeVGRhrTYzUZKg2Kqzkgcj7Iu7je0ph9s/6u83St8EBF4w2L4yq2ikGzRE0oA
	OFUUtleEBycQHTbINjEaUEAMl0OoVmyd0bMtumQO66cwF6qkMjE4A0n8qVR8pDvc
	lnvM4LFUmc6UavUW7L0GKeTmEkke+IOm1iDOj43JCzg5UVZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42sx1kyagx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 11:30:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3DC6D40047;
	Thu, 14 Nov 2024 11:29:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02C98245E7F;
	Thu, 14 Nov 2024 11:29:01 +0100 (CET)
Received: from localhost (10.252.20.241) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 14 Nov
 2024 11:29:00 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: stm32: dfsdm: change rate upper limits
Date: Thu, 14 Nov 2024 11:28:51 +0100
Message-ID: <20241114102851.2497942-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Increase rate upper limit to 192kHz to reflect the rate range actually
supported by the STM32 DFSDM peripheral.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 78bd817af839..c914d1c46850 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -142,7 +142,7 @@ static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
 			       SNDRV_PCM_FMTBIT_S32_LE,
 		    .rates = SNDRV_PCM_RATE_CONTINUOUS,
 		    .rate_min = 8000,
-		    .rate_max = 48000,
+		    .rate_max = 192000,
 		    },
 	.ops = &stm32_adfsdm_dai_ops,
 };
-- 
2.25.1


