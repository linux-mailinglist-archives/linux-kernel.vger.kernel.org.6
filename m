Return-Path: <linux-kernel+bounces-375538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6679A971F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BD4B20DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB14B141987;
	Tue, 22 Oct 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1YqMyKX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F113B5AF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567902; cv=none; b=asTyi0GDj1CY5GWyf/LPsVOkCuChDYsg9NtgqRKpcic8NUQR+8yqQNL940FdsGv4FN4GqDdSxlUCniOVUH2MBmKO+WU/m957LK+0TKaRnQRtIXzUOAtc6ZB9j3OejxkwfwPsXV3ksGYwWr/KN6pF3iTxefNzves6dCJUc5/3POk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567902; c=relaxed/simple;
	bh=YK2LpZTHRnkiUqe2Z38KIFqo+pjFGj2BUeIv/Or6Qik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNeNOJChZFO1Ywo0a/B4ONBelP5jmGzYzjhqx/0LYthFWhCX5TCyJTUl1K+weBDmIcCsCzU6I6j5Phn/NX1IBCzO0KRiC9iSybl26rt6J2Dx6EoPSnkG5PoT1ykrJM0hJ5xVCJnhBrqy9FVkpzU9cfsKiWXeDpLNGBo8Y7eeXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1YqMyKX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431616c23b5so24898965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729567899; x=1730172699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBmJLCd2hzie+5dOl1H2qg4sljCq/9XPqPeLmC1hVMw=;
        b=O1YqMyKX1OC/UJybI0GowimkdzWIqSkZEkRsN9n0wRhJvpl79TgManq4pP3T57sEW+
         Cetc/ueriIzkHWjrIdHRkC1bItfP8IHr+M3qjk9cXYgj6I2mIjlgZIC2y/eQAfkF2U+v
         9zwRuqqPW6JoF0/PKNGgTv8HJUwvecFiJGuo8sXoRDF8nhmcgTGcmFBtdYD6s7ZFNDK+
         LpRcB8/+/XJgj9JgznIZjlo8leGF1tyRiqHzuywZv7eok1ghCdUnmMJlMUojgTBTQDZh
         o4B3cRhyA/f9B89hY9Km0JG/iFSWnuNKZHp6rMF8+9TsphCr9SYiYYuzuRXfPzGPOSoz
         QxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567899; x=1730172699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBmJLCd2hzie+5dOl1H2qg4sljCq/9XPqPeLmC1hVMw=;
        b=bhBBVTHkMDmtO3KucaF2EWJQ3oA3I5ebPk8VDSAudubEXnwHSB2GFKFSpuceiLgiio
         ZjgJ6YwOFuHWRxzvKqrsS6n+nUrKm3kGHX/cuCACRoIvxLyOmS0WimspMqZbxdc5u0h9
         /T+ZynykSlHf1YcupmwooSqBpwN4+NIVECpPwt9fPKbyyRpJhm6jc0wjpeHS2o/gDkwg
         Ibrx9HnixcE1sFXXlUe6tvxSqECwNjWFMVquCAqrOselhbqUIjciiqwAQkDlHy6QAxov
         5MacQchRLBc4uigarQ1erjxtLM2LKHFFjvXSP8Ml3s+X5cymot2jvqjKvUpKV4iBVcDg
         zWtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3dF/srwuHlxTG80DL80Wn3GTBa89EUu0KbjXkSkoFZMuI8sfeZzvGxB7oLmeDGuQ5eFk/ekUQxM0bJ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxEJPN0/kls0U8tpVVkQsjozhMeHK0j+zUEz3+JK+MYjEYGtx
	HOel4HaIvz4CkcoQJWO6P8Sj7jzR+pkjIhrmQKyGD0ym+SRWc5DzU+KuHMcG/mQ=
X-Google-Smtp-Source: AGHT+IHABLScA0LDuWfD4bvGZ+5nYu9oyL/Xebds/KjAusYXDNhqNs0Vq4qmdDufLIH74eB/okuOAw==
X-Received: by 2002:a05:600c:35c1:b0:431:4fbd:f571 with SMTP id 5b1f17b1804b1-4317be88087mr9335885e9.13.1729567898715;
        Mon, 21 Oct 2024 20:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm4768455e9.0.2024.10.21.20.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:31:37 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	quic_pkumpatl@quicinc.com,
	a39.skl@gmail.com,
	quic_mohs@quicinc.com
Cc: linux-sound@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] ASoC: codecs: wcd937x: relax the AUX PDM watchdog
Date: Tue, 22 Oct 2024 04:31:31 +0100
Message-ID: <20241022033132.787416-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022033132.787416-1-alexey.klimov@linaro.org>
References: <20241022033132.787416-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a system with wcd937x, rxmacro and Qualcomm audio DSP, which is pretty
common set of devices on Qualcomm platforms, and due to the order of how
DAPM widgets are powered on (they are sorted), there is a small time window
when wcd937x chip is online and expects the flow of incoming data but
rxmacro is not yet online. When wcd937x is programmed to receive data
via AUX port then its AUX PDM watchdog is enabled in
wcd937x_codec_enable_aux_pa(). If due to some reasons the rxmacro and
soundwire machinery are delayed to start streaming data, then there is
a chance for this AUX PDM watchdog to reset the wcd937x codec. Such event
is not logged as a message and only wcd937x IRQ counter is increased
however there could be a lot of other reasons for that IRQ.
There is a similar opportunity for such delay during DAPM widgets power
down sequence.

If wcd937x codec reset happens on the start of the playback, then there
will be no sound and if such reset happens at the end of a playback then
it may generate additional clicks and pops noises.

On qrb4210 RB2 board without any debugging bits the wcd937x resets are
sometimes observed at the end of a playback though not always.
With some debugging messages or with some tracing enabled the AUX PDM
watchdog resets the wcd937x codec at the start of a playback and there
is no sound output at all.

In this patch:
 - TIMEOUT_SEL bit in PDM_WD_CTL2 register is set to increase the watchdog
reset delay to 100ms which eliminates the AUX PDM watchdog IRQs on
qrb4210 RB2 board completely and decreases the number of unwanted clicks
noises;

 - HOLD_OFF bit postpones triggering such watchdog IRQ till wcd937x codec
reset which usually happens at the end of a playback. This allows to
actually output some sound in case of debugging.

Cc: Adam Skladowski <a39.skl@gmail.com>
Cc: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 10 ++++++++--
 sound/soc/codecs/wcd937x.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 0f0d2537d322..08fb13a334a4 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -715,12 +715,17 @@ static int wcd937x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
 	int hph_mode = wcd937x->hph_mode;
+	u8 val;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
+		val = WCD937X_DIGITAL_PDM_WD_CTL2_EN |
+		      WCD937X_DIGITAL_PDM_WD_CTL2_TIMEOUT_SEL |
+		      WCD937X_DIGITAL_PDM_WD_CTL2_HOLD_OFF;
 		snd_soc_component_update_bits(component,
 					      WCD937X_DIGITAL_PDM_WD_CTL2,
-					      BIT(0), BIT(0));
+					      WCD937X_DIGITAL_PDM_WD_CTL2_MASK,
+					      val);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		usleep_range(1000, 1010);
@@ -741,7 +746,8 @@ static int wcd937x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 					hph_mode);
 		snd_soc_component_update_bits(component,
 					      WCD937X_DIGITAL_PDM_WD_CTL2,
-					      BIT(0), 0x00);
+					      WCD937X_DIGITAL_PDM_WD_CTL2_MASK,
+					      0x00);
 		break;
 	}
 
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 35f3d48bd7dd..4afa48dcaf74 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -391,6 +391,10 @@
 #define WCD937X_DIGITAL_PDM_WD_CTL0		0x3465
 #define WCD937X_DIGITAL_PDM_WD_CTL1		0x3466
 #define WCD937X_DIGITAL_PDM_WD_CTL2		0x3467
+#define WCD937X_DIGITAL_PDM_WD_CTL2_HOLD_OFF	BIT(2)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_TIMEOUT_SEL	BIT(1)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_EN		BIT(0)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_MASK	GENMASK(2, 0)
 #define WCD937X_DIGITAL_INTR_MODE		0x346A
 #define WCD937X_DIGITAL_INTR_MASK_0		0x346B
 #define WCD937X_DIGITAL_INTR_MASK_1		0x346C
-- 
2.45.2


