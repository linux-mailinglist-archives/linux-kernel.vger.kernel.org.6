Return-Path: <linux-kernel+bounces-200383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E38908FAF30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A741F20F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDD1448D7;
	Tue,  4 Jun 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thGn6ET+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED21448C1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494404; cv=none; b=ttGDKqB4td+Yx7nf8gR0uHq3fH6JPLrYrvxts5ga6P1kWaMbQNKoEgCfqXLnxUKqczGghofExY33yL+/X0qQLsrkCZBKfrtrZKmXdpmzSptjuOrqLf6tsuh37y2we7iiZ2pDfFAu7c5O4CmP2D90qp2o1PpyhhnuguXWhyh2MHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494404; c=relaxed/simple;
	bh=7iOI2gyIz09ZExE7MThuktVMvBjq3HebuNyhlEujrSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW6HXP61Wq+68Rtd2qz98kvZ9nZahIxibsNL+g+u5tpBPnOCVGwzeuKKhL0mQO+cN4a5y5sHRq4RRXKrtqqcQNlj7RWDNC127xQGsxiq0NIlDn4HAXJaMx9yop9/i+NqrZg7LHib1z/vtljuEm0su3G1KATOXNkllT90n88k3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=thGn6ET+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso56507141fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717494401; x=1718099201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8w3PHphluD8h1jsOJr+esaBLa0WpV3tSQ0DXHRhrVg=;
        b=thGn6ET++oTRwFg7vwsIG2IXKFmWdbIbN8iWtbVd2O4Vc2bI+PMCLlBdUe+NWvfiNm
         G+48HEBwugK4RY0z28c8HMt4XdsPZor6G/qHgBhJIiXXVJvXJ0kzbYjkXO0+2zPpR6t2
         6DG9wIBB8MIBFSY2a+SjVogihuua1jVW44BFAUQ1+kvzFfnoyzkI2O0HSO1SH9cOZmei
         avbqsRMwNk4RmYeKwFzjrjVPSLcyJ+QhwAQ7IfZHq5dM0e0Tj/VBfsNc6wKIcvX4Y3qH
         gbj8uBwsbkD/utaf6ugJzE6wZmdpn5iYbWk5dZeDq33vNHp/aHXadA2UiFjeIVeXt7I1
         /3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717494401; x=1718099201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8w3PHphluD8h1jsOJr+esaBLa0WpV3tSQ0DXHRhrVg=;
        b=H/nnkZoBzJyBaWdnmRUk8iJDDZGVxbsIuHq8+MYT01dZZ5EFE9mLGVzLGIi6KlRM6i
         N1naznpnDazXFmR7Zx1jnLNUu/Hu+Yh5qsK+cfVdq9khO3ZPF3G8BK79+YXjwMc14j8w
         emXZbOqVaV7FGbQoi0VNDji7iOojfo/I83WuehBJ+as7C9WtzillsyCScrt++F3doFkt
         KYT7nIJisSiKs4F/OnOD2nqAvJXLgNoiRR8c+Zu9STnDNzRy4GVawXy+RuLD9gHKTB/N
         9A+/8wn5U2l3X8DjIzuZ3SX3nrzFMp1IJ8GHZxQEodZk9z05Hv29mPKGGexA82FETSMn
         fElw==
X-Forwarded-Encrypted: i=1; AJvYcCUrbTeK7hahnViBnTv8qsmc7ikfg7qIbQ9Qs2eQsaK/73erN63Kutqfb+/nfKNhybikyAeISuHiHLpO4cSg27ZndqQHKnvtENPDungH
X-Gm-Message-State: AOJu0YzP344vwCsKkpYAlgkk8L6blsNH1V7DT34IJFAdmq8p3bYyFSLF
	Gk4D6Z2i0fPD18cR0IP7IbR29uefNJajmZO5ad3fjQaTW232MEPno0YSlPfo6ZU=
X-Google-Smtp-Source: AGHT+IHmnuqj5RmW/dGeIKGHajzkpP8hr3o/H52znLirAojQLFtRIWcisscJHUffN4MHWiqHDEGJUw==
X-Received: by 2002:ac2:58d8:0:b0:52b:82d5:b361 with SMTP id 2adb3069b0e04-52b8959629amr8278360e87.37.1717494401183;
        Tue, 04 Jun 2024 02:46:41 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0649fb5sm10903837f8f.94.2024.06.04.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:46:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: x1e80100: Add USB DisplayPort plug support
Date: Tue,  4 Jun 2024 11:46:38 +0200
Message-ID: <20240604094638.97780-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for handling jack events of USB (DisplayPort).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
https://lore.kernel.org/all/20240422134354.89291-1-srinivas.kandagatla@linaro.org/
---
 sound/soc/qcom/x1e80100.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index d7e0bd03dffd..bc00722b7fdd 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -20,12 +20,32 @@ struct x1e80100_snd_data {
 	struct snd_soc_card *card;
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 	struct snd_soc_jack jack;
+	struct snd_soc_jack hdmi_jack[8];
 	bool jack_setup;
 };
 
 static int x1e80100_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_jack *hdmi_jack = NULL;
+	int hdmi_pcm_id = 0;
+
+	switch (cpu_dai->id) {
+	case DISPLAY_PORT_RX_0:
+		hdmi_pcm_id = 0;
+		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
+		break;
+	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
+		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
+		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
+		break;
+	default:
+		break;
+	}
+
+	if (hdmi_jack)
+		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
 
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
-- 
2.43.0


