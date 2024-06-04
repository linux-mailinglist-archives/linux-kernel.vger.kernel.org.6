Return-Path: <linux-kernel+bounces-200399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DEE8FAF88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F0A283847
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45131144D1F;
	Tue,  4 Jun 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H5+cpgZu"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEC1448E0;
	Tue,  4 Jun 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495461; cv=none; b=kTdyvAsgMXttx1kb7bTB48fFwS875gwUGUsSqiVofC4HHMlvho7Pzl6ozgZAwxwE5wzQIfjuywuLMIyKnet47ik5naRf9U+9lvqeCGkcN5xA0fOlhsuXYyUgkCAub6mz0cfPkbkITQ3NKEtYYNyYScuunvH27x3HKDvv+xj+DXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495461; c=relaxed/simple;
	bh=eMhqaoNHJ3tHzDi6VNuN8VlXihGxJv2kvkvNe0CppiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MUpEgAxOn2OjRhEOzvqWQ7WKYf1VXapX4kAOPL3lEGaa0NUmUgxYen3ANUltffV8M3LsSSdwkNXDh4PTVtKgIRFtpuZSJ585br65aqJxtSajYkVErGenGmFDT8iODw6+8Q6p8O3MSC5CgbtaWj8kBxhNfmO9SmeehFXJPUG+Phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H5+cpgZu; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 454A2FYQ119449;
	Tue, 4 Jun 2024 05:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717495335;
	bh=aiAJG9A2lXmBO3D4+H7SDy5jGWfjtvudxc1KcNRhPHk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=H5+cpgZuX9iIF8gQ29GBYHlxuEoSJBKpxwMw65IlghMRnwRtDt/2k6w29SR6SH6IJ
	 SDmZl4+ak9jmnAeUU1vPzchcCtRFhEioOD9xfH/CJNEErOtfJHzsOTlDvPZlBoYSA8
	 xOadELTDAisheXxjqbKZj3QnKSs5vM5OHm8GX9MU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 454A2FtQ030398
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 05:02:15 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 05:02:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 05:02:15 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 454A2E92130460;
	Tue, 4 Jun 2024 05:02:15 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:31:51 +0530
Subject: [PATCH 2/2] ASoC: ti: davinci-mcasp: Set min period size using
 FIFO config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-asoc_next-v1-2-e895c88e744d@ti.com>
References: <20240604-asoc_next-v1-0-e895c88e744d@ti.com>
In-Reply-To: <20240604-asoc_next-v1-0-e895c88e744d@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=eMhqaoNHJ3tHzDi6VNuN8VlXihGxJv2kvkvNe0CppiA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuYiUfBPv3bkEGL189j5N4WDta+evgx+wbTGN
 ls6nNkcMy2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7mIgAKCRBD3pH5JJpx
 RQcGEACl67P2gaXQhns4uPnJR7XAkyL6OS3dRQI2hPO7SoIm6YC7egACmjuxKB66aDznzzL7ZJ9
 bI0xTe08wlmTQe59AfOsg9TrlRS4X1/YToBjsZylpnehntLU2bgozZyoKOFFcePo6u9qMMFukHg
 T19ORJPmHgkgMJMwdSGsYXfi/Tp/kNbk47+OqEUFauOPm8omuppWRceZFgTt66k5N+KqL2cIwMq
 bGZvBGSxMgRT+3rt6VwWRhbGmKOjmWXp1Z+hsgMn40wX7nPOIibeg7TDW1/EkyCPIE5567wK2ZF
 mOkox9pDVgyheyzPNC7dDnPDtuaB5cl5xIHf7mWfOWNL/+1uZvFBd5CdFr0sY9slvz91LioUJ09
 f4W+2ctMUxd3FVcygAT4MtwwLzB2b+hYQuvayD3SS6O6HMbzQWv/mpkGyZ7efLqjTAyd5msOboK
 0BdW9wNbOhdiF0vSG79JH/jTNP6Pc/g+4eGJ5N3FKwsHJb0EVdXYlArTd5PEKx0SnbXZO6goGvW
 5xlkXLX8Xm4FYqmX3qFyIUIPIGN3bY2JOuNZVphHzH/z4U4AHtb4bLDcbtkZcYMKhyGw7oQpdfp
 iablLtsJXQYzJ1fHqzBjMYDnso6V4PQ/5dpNeHjoUadv68d4Lzap6zxirlewY23jjyttxTf0F6U
 QLKsgHoBfRThCiQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The minimum period size was enforced to 64 as older devices integrating
McASP with EDMA used an internal FIFO of 64 samples.

With UDMA based platforms this internal McASP FIFO is optional, as the
DMA engine internally does some buffering which is already accounted for
when registering the platform. So we should read the actual FIFO
configuration (txnumevt/rxnumevt) instead of hardcoding frames.min to
64.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 1e760c315521..2a53fb7e72eb 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -70,6 +70,7 @@ struct davinci_mcasp_context {
 struct davinci_mcasp_ruledata {
 	struct davinci_mcasp *mcasp;
 	int serializers;
+	u8 numevt;
 };
 
 struct davinci_mcasp {
@@ -1470,12 +1471,13 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 static int davinci_mcasp_hw_rule_min_periodsize(
 		struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
+	struct davinci_mcasp_ruledata *rd = rule->private;
 	struct snd_interval *period_size = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
 	struct snd_interval frames;
 
 	snd_interval_any(&frames);
-	frames.min = 64;
+	frames.min = rd->numevt;
 	frames.integer = 1;
 
 	return snd_interval_refine(period_size, &frames);
@@ -1516,6 +1518,9 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		if (mcasp->serial_dir[i] == dir)
 			max_channels++;
 	}
+	ruledata->numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+				   mcasp->txnumevt :
+				   mcasp->rxnumevt;
 	ruledata->serializers = max_channels;
 	ruledata->mcasp = mcasp;
 	max_channels *= tdm_slots;
@@ -1591,7 +1596,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_rule_add(substream->runtime, 0,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    davinci_mcasp_hw_rule_min_periodsize, ruledata,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 
 	return 0;

-- 
2.43.0


