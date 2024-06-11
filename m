Return-Path: <linux-kernel+bounces-209867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE38903C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDF1F25CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF317C7DB;
	Tue, 11 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UOVolnY7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A717C7A9;
	Tue, 11 Jun 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109423; cv=none; b=rpgfeJdA57jvVcCvtQDggR1rVytg8DAVtX/1LHV0RohfXcPD1NvdgucxZo/1cFgG5eEU++qW8ggvW87NsKRD+277ps+9U9/BQ2omrN2uAKTbJMsUE9BViQQUSapEqm/3t7UEMJEkzje1rCLD25EW+GYqyEs185qbqjMoKTD7m4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109423; c=relaxed/simple;
	bh=8jD5Mvn4JnvcGDrCagOrGGZetRPfvF4h/uJysM7SORY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dHpgaiYEj/PuZOwN1hYCyrn7KMA6f5coXWkfEzmPEAtwXinUmLM61Y4fexq9fnP5Mq9e4o5GsMk62jQgi2JKcmJwqvXn8wppMGkGayspnEHC3M+1fOxmGElCHEPilm6mJIAQcL3YPqpXepSgjyUi1A1mzYzoRDiGyU81TNIAy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UOVolnY7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BCaa6a088100;
	Tue, 11 Jun 2024 07:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718109396;
	bh=Xi+lXeC9oOPY560HM6ndHndJe00tZZ8g5JUpqfg8mMc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=UOVolnY7O4t53trTs4QTtefjTo6wP3vqPGib4PgyPlWj8IeWuogyvRFXv90TmBdxt
	 CbJhXk6Qm63Sy+GCb2d5tsxn+/oNZGO5Xl3UABgBR5imCpyvLfI8PBYrdwqu2WVzgw
	 k8CQRQN4lRnO6Kd2QdU6HbmfL2DKT6v7nSe5ItCA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BCaamY116897
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 07:36:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 07:36:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 07:36:35 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BCaZcw105946;
	Tue, 11 Jun 2024 07:36:35 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 11 Jun 2024 18:02:56 +0530
Subject: [PATCH v3 2/2] ASoC: ti: davinci-mcasp: Set min period size using
 FIFO config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-asoc_next-v3-2-fcfd84b12164@ti.com>
References: <20240611-asoc_next-v3-0-fcfd84b12164@ti.com>
In-Reply-To: <20240611-asoc_next-v3-0-fcfd84b12164@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Devarsh Thakkar <devarsht@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai
 Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=8jD5Mvn4JnvcGDrCagOrGGZetRPfvF4h/uJysM7SORY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmaETOYhZakNd8NUjZCV3kKA2TKaPzDcRwgvD8M
 qVxONW06W+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZmhEzgAKCRBD3pH5JJpx
 RSG8D/9sFwAIG62LqXVjYS9r25876+BBOXvMsmJ49kxUk+X5EKAsXm97vxjtGIlIP+88MUuc7CT
 tPKRTE+PH4RSEfGbtL7SsmRg40kUTtXMzu2aUSKF3TE1MbHYqfWX4HnxArhiHv7EL175L84kU+F
 xkHcHo5VBOA+xAvWXA/jxQdY4tLUeLDJJbe5h4d+tjr1jx04melwPcwMgt8kjOSa79xPr23VhJV
 2E6lUKdotTaonOA0ZLWuNx5vFcSehwG5zj/9lbGLzo+o5texet91cetc856dpwV5iZ7JLVIUvh8
 qVLOpNRL4kwt4zP4Ym7Sx5Or2Pg3P+DGbQ7z6tiZwR1mqWIKvIutfpeRaOByaduLu8n0jB5+/n3
 JsYMUoEH2WHlhWS6nNDu3zb7RpWoyUSP+bz1796Jyxr0j8Szf/7Lwl/2W9OnGNURwP1xmadY+TI
 IrrR20e3oM+SmgPICEV1o1P9GcodfaHr+ALuhWagi41WbQv5AxjkrXepNkpviZNnPm6S8D86j0E
 0R8ymjNggQcg6pI56GTUtqPPCI1BYTVMQOgQyP2GjV/hSTXbsbaCIwsk0HXqOr6kPRklmo/GPvp
 LcsbmBe0cRjRBBvQ1IuJWpXp9tfCEiI0nk0iPdIkz2mvr9qbLQ3MooLbJETU9TUTAAwn1xFdAzq
 ZgXHztXo8cnQtcA==
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

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 1e760c315521..2b1ed91a736c 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1472,10 +1472,11 @@ static int davinci_mcasp_hw_rule_min_periodsize(
 {
 	struct snd_interval *period_size = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	u8 numevt = *((u8 *)rule->private);
 	struct snd_interval frames;
 
 	snd_interval_any(&frames);
-	frames.min = 64;
+	frames.min = numevt;
 	frames.integer = 1;
 
 	return snd_interval_refine(period_size, &frames);
@@ -1490,6 +1491,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	u32 max_channels = 0;
 	int i, dir, ret;
 	int tdm_slots = mcasp->tdm_slots;
+	u8 *numevt;
 
 	/* Do not allow more then one stream per direction */
 	if (mcasp->substreams[substream->stream])
@@ -1589,9 +1591,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			 &mcasp->txnumevt :
+			 &mcasp->rxnumevt;
 	snd_pcm_hw_rule_add(substream->runtime, 0,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    davinci_mcasp_hw_rule_min_periodsize, numevt,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 
 	return 0;

-- 
2.43.0


