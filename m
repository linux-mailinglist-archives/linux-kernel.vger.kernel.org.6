Return-Path: <linux-kernel+bounces-213180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DBA906F51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AFDB28C46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940DE1465BA;
	Thu, 13 Jun 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1csXwly"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAA1465AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280800; cv=none; b=cw1wj+aYvVWLvsmXtti8X4A2QafGzuw8oYYUWMjuzKkLovJlKgCqI3Cz243onolmXhI9T7XYl3YlPZEGXzQ0zOrJTqRv2gbdlIqnTi0L9iFyOQO5qjlSh0M5Q9Yx7VUfHQRCpDQenyuuu9sz9UeE3DxW/pWaoTqs+iROOLjWN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280800; c=relaxed/simple;
	bh=1yK9eI1MQbvCCxjWD8QAM9mmf5vjMBn5EqEjdIFsiv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QOFxvv2+iPMWYHVATIiV139bF0H+mlca5B5sEbgtEd7eRnBXzm/5OJRdlgkZcI/sE1Tc/MTOa63M/IMQiTHrPEYJOvlYwGXwJUxtpcfYfQ7K2vpEMSSj1oEtdRgLzAQj+RYL2xnmMNHkC0DtDASjYXF6YExEVWpDc/wwejs8bYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D1csXwly; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f253a06caso120498566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718280797; x=1718885597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXbNy8kHfEp0b79ontwosVP2eSf4cO0jv7KHuOVa8LI=;
        b=D1csXwly7pP8tkXQOw4mcFUV3gYh5cbUb62Dl1TlKMrD7LBgKbcDcoWEDHk7Wsg2I5
         Syco5/IFU3uTCwVZh0pIGwjjpXZn0kTNf5q2Sm/8aIiPVV3h6b/0rRPsxCdVZKWL3zE5
         KAoiNuJjRtoYqkiXrzyxohOKqkUW9jyQzpcUn8Ni2jX3v3g7g6ySZdFWXswsMgE87RK5
         a36egJh7mvmE4UHsXLbVYIa/0QhI0Vf0YCve8AQKiCydGJAxIQRg30ItmkdDI2tKdQ8b
         dRLKZ/S8u2LVno6S+kFzMqIQJlcGpW85zqvW4jpleGF0OTd7LqtQPGT+j1s0HWsppuWe
         jhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280797; x=1718885597;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXbNy8kHfEp0b79ontwosVP2eSf4cO0jv7KHuOVa8LI=;
        b=rnox6G8KPTBDI4nBzTPgTtay4p2bWOPvXgEaqYeijSQVt1Fk27iFWl0NCmW41U0HAh
         tXDjnIuVLaYMlf37f3bzJM1DUJH8rnpBsja0PO+a7wVW6c6aLno1mgG8wvRJdtMX2Lvp
         88Ez9JYPyUW/quU7gYDm6OLkV05kiL2e/09EyIK4Z1EOMQtOW1c828EqtU9FbacW8cXe
         1bg/brTU1BGESfgI7zhLilOcaK7CvleoMrxwqqFoWO4hy56wZr+hMfWI7u3gASDDhUUf
         oPtAbmS1ijwhKc3Ga9Ro5zqEingfaj15fwq2adcHB5zSi01j47p8o1zip20+3AMKRGcI
         Skuw==
X-Forwarded-Encrypted: i=1; AJvYcCWPL2UcNecNHLU8zHUN47JBut3fq2f7VgfgdfT1jPS90LyXydRGVadKqhQ78d+FQJIgv5UvB5gCJul8mfc1/Oewsort0+4hHnzHdOIN
X-Gm-Message-State: AOJu0YyFa9RT4+fzBzjDiPZtj0HOdbUZgsQit9IGNLu+cHpi7O7vnF4B
	vsRonpsbASwTodPeqhmWOukSgquKokuNg8AnKlKeSrSDxGDLwNCkY+p41KERRok=
X-Google-Smtp-Source: AGHT+IFabj44+6/AUOqc3ytd5ytWDpFi1xvXmXHvZaxmZgT9uxNGhLzwBao1fjRJml9g9YwbWcn8Ew==
X-Received: by 2002:a17:906:fe0b:b0:a6f:4f26:fe80 with SMTP id a640c23a62f3a-a6f4f270012mr298512566b.41.1718280797113;
        Thu, 13 Jun 2024 05:13:17 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f985dfsm65535166b.192.2024.06.13.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:13:16 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 13 Jun 2024 13:13:05 +0100
Subject: [PATCH] ASoC: q6apm-lpass-dai: close graph on prepare errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFDiamYC/x3LQQ6DMAxE0asgr2uJBJrSXgWxMKkBL0ipjRAS4
 u4NXf4ZvQOMVdjgVRygvInJJ+VwtwLiRGlklHdu8KWvy+Aq/AZaZhxkZ8NAz9jUzd0/XAVZ9GS
 MvVKK02VmspX1Ohblv8hr253nD2nhM3d2AAAA
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: dmitry.baryshkov@linaro.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=1yK9eI1MQbvCCxjWD8QAM9mmf5vjMBn5EqEjdIFsiv8=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmauJbajWD5SFP302Qlyf+2BL5UONgysacwGM99
 PIDRaDoYVyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmriWwAKCRB6of1ZxzRV
 N9MBB/0ZfAaWAL/u+zAa+VrxVkvWJ9/5N7h4ERWABTmonxDvhxOdcMDe1kqqMax9yr1KI5YZzJ0
 p9Vl1Q5YVVATNzkCPaKZpOlHVJ5Zo40dNt+9gtiegZaM4NHj9uCiAtdRxdCyvSBkUCnLJnFRraP
 yylqeBw8Yv2FPVHzHtfhx4yMj9pzLtcTp7AN1Hn3DHzF4xxe+omC1syBWtAAcr8MaxAehTLxscp
 5XwuHxd5Z+PcbxWHhTOw/0WmMrt7/Zqxzr1O2zzHbzdXTsczNUoWpgBSCpgWISQu2pEhthogUmz
 oGJRMEWpuh3RxZsuf51owwT6sOkHgrDgvKZ7CQvGYLZSUXLV
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

There is an issue around with error handling and graph management with
the exising code, none of the error paths close the graph, which result in
leaving the loaded graph in dsp, however the driver thinks otherwise.

This can have a nasty side effect specially when we try to load the same
graph to dsp, dsp returns error which leaves the board with no sound and
requires restart.

Fix this by properly closing the graph when we hit errors between
open and close.

Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 68a38f63a2db..66b911b49e3f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -141,14 +141,17 @@ static void q6apm_lpass_dai_shutdown(struct snd_pcm_substream *substream, struct
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int rc;
 
-	if (!dai_data->is_port_started[dai->id])
-		return;
-	rc = q6apm_graph_stop(dai_data->graph[dai->id]);
-	if (rc < 0)
-		dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
+	if (dai_data->is_port_started[dai->id]) {
+		rc = q6apm_graph_stop(dai_data->graph[dai->id]);
+		dai_data->is_port_started[dai->id] = false;
+		if (rc < 0)
+			dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
+	}
 
-	q6apm_graph_close(dai_data->graph[dai->id]);
-	dai_data->is_port_started[dai->id] = false;
+	if (dai_data->graph[dai->id]) {
+		q6apm_graph_close(dai_data->graph[dai->id]);
+		dai_data->graph[dai->id] = NULL;
+	}
 }
 
 static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
@@ -163,8 +166,10 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 		q6apm_graph_stop(dai_data->graph[dai->id]);
 		dai_data->is_port_started[dai->id] = false;
 
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			q6apm_graph_close(dai_data->graph[dai->id]);
+			dai_data->graph[dai->id] = NULL;
+		}
 	}
 
 	/**
@@ -183,26 +188,29 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 
 	cfg->direction = substream->stream;
 	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id], cfg);
-
 	if (rc) {
 		dev_err(dai->dev, "Failed to set media format %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);
 	if (rc) {
 		dev_err(dai->dev, "Failed to prepare Graph %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	rc = q6apm_graph_start(dai_data->graph[dai->id]);
 	if (rc < 0) {
 		dev_err(dai->dev, "fail to start APM port %x\n", dai->id);
-		return rc;
+		goto err;
 	}
 	dai_data->is_port_started[dai->id] = true;
 
 	return 0;
+err:
+	q6apm_graph_close(dai_data->graph[dai->id]);
+	dai_data->graph[dai->id] = NULL;
+	return rc;
 }
 
 static int q6apm_lpass_dai_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240613-q6apm-fixes-6a9c84852713

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


