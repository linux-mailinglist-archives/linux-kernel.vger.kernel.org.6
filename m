Return-Path: <linux-kernel+bounces-354300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C393993B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67281F22A07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5919308E;
	Mon,  7 Oct 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="CXFkQmkg"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1691925A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345501; cv=none; b=YZ2XLbbxknjgTvE8QVss6mZ85lCsy2rEwPyZhfhUmJT4FOJwhlWwhdVAFvLiGzAToVwcuyiEdD3aPO5sOcZ4Ii4pLAzzYIGD11HDmKUhdFP/sBzwZNMzVarXo45xCO9mrkI2kf1C6AFWpG8dkTA6vvs4nyNH/wyK+3N7BLeNOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345501; c=relaxed/simple;
	bh=2H5IR/qIGLs8u9dBURGCbFaUfuvrnD2OVTq2XdDUbt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jy3t4peAvW6Wn28/jeN9dkzIP8mjBQoaUBDFdE/yOh4vdFSYo8LYULoWkwFc3GM3RroJNbKucY+hXZ4/EycEeK9oCuc+2VNhN0IMnLM6p+4REPQNSpIonVR3BWpVBtWaL1jkvLwmIFD+cr2Tpp4Hkcy533Ouw/XswR5rZuqMyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=CXFkQmkg; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ad8a7c63so502157385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728345498; x=1728950298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqS3Wd6VO/CBP7azwUKnJ/dYiC5Cl3RJfl/ueyntYK8=;
        b=CXFkQmkg5nsVt8REcT5FjeFUPHqFMHjnNpGj6aDpKJXYocOufw5+O2e/uRbHkNaLRS
         7LyC6558gtbTurVg3C+mq8Cu1CqCpjBb6ceujC9e96yk37GwI1t3Y6W70Z3SrYR6tr3I
         DC1NuCiNA5r7dwtTxxqiQA/URLAVDPB8p9a278943TO2I94jYWUqcYQDBGt6Y2Ebjg8C
         eCsUPChVFIahlMD7Eri+AEsjJPd63b16Mmgud6Q9/y1yniV7LP2w+0bYO3cEX1ub7yH2
         chTqUy6lW63Iqe2yNvcRp4y2qIglKP6067fAEtexwB0+OUIbjCJak+2yM51LN8bPrm59
         +9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728345498; x=1728950298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqS3Wd6VO/CBP7azwUKnJ/dYiC5Cl3RJfl/ueyntYK8=;
        b=kciAE7rPZHN45/LkcTvHfpVgcLfYgSPrp2eeFewWRWtRpzBIEYKQe7nL6SB3VhvGTc
         4XiBt4eTMoCS5T0iUS33V7hKxfBkFuL3j05aoWRsqJzQBKhbcDEpzA/ITdsDmpJ2lrM9
         um7+7OgaYYC73esHHve5QCjkYYG0YkF8y8+qcBT4BTFExtRslM2S2BcG2pZH8a1ePg/O
         AWaQji8tpIgIksK2Dutd0ayjUARKYM6fO8DHxlpl/dfEoXRrK+yUe8zJ5cox6xJ8NVnN
         h4OFU1RVAkPkM/sw5Im5mJsXU43mCSW4+v0O7s83e9taDc3AOrBW7nWZpZKEoT5/3ATO
         ndyg==
X-Forwarded-Encrypted: i=1; AJvYcCVz0kTKUpSIo0TTbFPWSUUE/uPk3NzXgtwUdXumtewl/3p/iuCG5Ry3Yv9KDTv36xSteXUF77ayCiwnNdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhYQe9tiy6yvHVYGKjlPwMCl184Qnxhgwn86+pWDZhofWzbfa
	A4xxz9DCwpEjp8brwB3FlRrqgTDRf1VmZU2tj3nQiCLVn3QVg/hlWf2wymvwoeU=
X-Google-Smtp-Source: AGHT+IE13yA8WspYNMljzyW9GkMAtPmwobjLtcEu5tAo4EuOuiegVnRe8GiuZbDxB1gkpTFhnIWocg==
X-Received: by 2002:a05:620a:4611:b0:7a9:a8c5:d492 with SMTP id af79cd13be357-7ae6f44ccb2mr2140783185a.34.1728345498500;
        Mon, 07 Oct 2024 16:58:18 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561e610sm303906985a.21.2024.10.07.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:58:18 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: codecs: wcd938x: fix wcd938x_get_swr_port
Date: Mon,  7 Oct 2024 19:54:09 -0400
Message-ID: <20241007235418.2257-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Controls can share the same "portidx" value (e.g. HPHL and HPHR), this
leads to wcd938x_get_swr_port returning incorrect state. For example,
when trying to enable both HPHL/HPHR with amixer: after enabling HPHL,
HPHR will appear enabled and amixer skips writing to the control.

This could be fixed by indexing with "ch_idx" instead, but lets just get
rid of port_enable[] and check the ch_mask value of the port instead.

Fixes: e8ba1e05bdc0 ("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 sound/soc/codecs/wcd938x.c | 9 ++++++---
 sound/soc/codecs/wcd938x.h | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f2a4f3262bdbc..12c991beeca52 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1854,14 +1854,19 @@ static int wcd938x_get_swr_port(struct snd_kcontrol *kcontrol,
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(comp);
 	struct wcd938x_sdw_priv *wcd;
 	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	struct sdw_port_config *port_config;
 	int dai_id = mixer->shift;
 	int portidx, ch_idx = mixer->reg;
 
 
 	wcd = wcd938x->sdw_priv[dai_id];
 	portidx = wcd->ch_info[ch_idx].port_num;
+	port_config = &wcd->port_config[portidx - 1];
 
-	ucontrol->value.integer.value[0] = wcd->port_enable[portidx];
+	if (port_config->ch_mask & wcd->ch_info[ch_idx].ch_mask)
+		ucontrol->value.integer.value[0] = true;
+	else
+		ucontrol->value.integer.value[0] = false;
 
 	return 0;
 }
@@ -1887,8 +1892,6 @@ static int wcd938x_set_swr_port(struct snd_kcontrol *kcontrol,
 	else
 		enable = false;
 
-	wcd->port_enable[portidx] = enable;
-
 	wcd938x_connect_port(wcd, portidx, ch_idx, enable);
 
 	return 1;
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index fb6a0e4ef3377..d4f400c50115c 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -650,7 +650,6 @@ struct wcd938x_sdw_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
 	const struct wcd938x_sdw_ch_info *ch_info;
-	bool port_enable[WCD938X_MAX_SWR_CH_IDS];
 	int active_ports;
 	bool is_tx;
 	struct wcd938x_priv *wcd938x;
-- 
2.45.1


