Return-Path: <linux-kernel+bounces-260105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0793A31C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE11F1C22C25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF35156993;
	Tue, 23 Jul 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvHnG7iD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926E13B599
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745975; cv=none; b=h+4b9+91RKBlxfoZ/nv+4i5mdcuI5IBlJVuvnZ9bY4MsbbVWVh0QGv5Es87Kayc2UKhwXAfPQE3Ry379f3wzRpBTEYSlV2pM9j2xCaqNMyO73dnE5488Hrsx8aLxgDF+Zl5cktqCrO096tcw1pPk8g5S27CD1fdQpIjtYRm8hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745975; c=relaxed/simple;
	bh=f4nFfrVFsoZlAw2TqgkIjPVPxb5PG9oafUyuaGzF2hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vw7NdgKq5w7E/iBl4ahDYBkhqtliAUc6bS8U+TKJdc7Ki3t/IBjW0hYdYN9Q9BH0nOUz2xCNrO7L0oDFEENLUVl+gDHEzNh9TbXBlgvcv/05p2pHx19tLUdhNDFcTSZXligK0gH9rRWyApENqioiJ8nljAcVC8X5vVO9gnsGf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvHnG7iD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso4758656a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745971; x=1722350771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGhe5Ex1bPFfV1vlOFlhgJUy/23nt8E3XkBUwt2fp5w=;
        b=dvHnG7iDG0W79pgxSUvSrwTmGOtdbod+NXVXJ27rz1cMklfqe9tTvFOl3jZJ86g0ym
         GwQFmJL7s09OO1xc+qlaEwVFvWZaKkvnvT/W4Kmbl9lnqWW+q0KBqXdMTevvwxGpFBHL
         N56SDcYAC4a3WwSoEVGt7Y21QE6AelrfgRO6PE3RaOh7wTA7NaresmHAFC1zmzkKfN9L
         PA34EeWE28N//UtzTvsrVSLn16GxlZtmwthGLKAgD05iSoJUxqCq92iacjEj9tR0aQoc
         T2XJti/S/n+ryjzMHXCQ0rf0bqI6lPv1XlbQYPaMi8xcHrdEyCqAgg46Cp/eigfyY5Gr
         Sq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745971; x=1722350771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGhe5Ex1bPFfV1vlOFlhgJUy/23nt8E3XkBUwt2fp5w=;
        b=lddBmubrcXWvlF/9x07/kUCPYuiiOAYymiuGnNlTQqq9kK5pg+Tq+6c35S8qOhAF2L
         QsHW/HjD24gnrlovzrlj8vkn9VSUPxQGxqRRwjaWTnhhlEeW43Ks4Xg9JWANTdeEbpgu
         4PNOrBkje+XaT/L8y4NyGC6ApCa1F+8i2bNcCVcM/wpqtecUqQxOzL8G+YAqco8URWNc
         iHsMn+NRi3hwMLpCyPF3mKIiep/iAjN7arb7aCvJTToPGCXaQ/3BIbRluIqCMsBAAusL
         gWMDcoI+C3HpcSR2exBCn19dIz35AkD0naM7RoG5sXKVYM1Ny9pryu2TAlWdCOLunwrC
         P71A==
X-Forwarded-Encrypted: i=1; AJvYcCUM61gDAtj/n/4Hemlh0DoSYUPvxNyvkpr0ES4Si5X8cnpvfnntSkmZ4KrK7v+wOI4rj9zouxnM8+9tY5vz9ZGjBLc9l/KQ0wWV1BSf
X-Gm-Message-State: AOJu0YzMBaLAop1BgqTbHulxXv2aIsJMMgRXmenM1nf9X3pzmfS2FTzk
	6xIVH1/UpbqHBxKIS2IgwBE5qzLfsvAtus4OlvExhXoa/4oqksFLTLGjTGOPLn0=
X-Google-Smtp-Source: AGHT+IE6FPRxaRZAelP7XYoRe2kh2fF3fU2NbulOmAczM715i/eTYrmwCoGSdVXZHnXFZX+KM1NhGg==
X-Received: by 2002:a50:a6ce:0:b0:57d:2659:9141 with SMTP id 4fb4d7f45d1cf-5a47b0e7da1mr5752175a12.24.1721745971395;
        Tue, 23 Jul 2024 07:46:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f88a5sm7592422a12.77.2024.07.23.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: lpass-wsa-macro: Do not hard-code dai in VI mixer
Date: Tue, 23 Jul 2024 16:46:07 +0200
Message-ID: <20240723144607.123240-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wsa_macro_vi_feed_mixer_put() callback for setting VI feedback mixer
value could be used for different DAIs (planned in the future CPS DAI),
so make the code a bit more generic by using DAI ID from widget->shift,
instead of hard-coding it.  The get() callback already follows such
convention.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 8351f0974e6a..4158657914fb 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2296,36 +2296,37 @@ static int wsa_macro_vi_feed_mixer_put(struct snd_kcontrol *kcontrol,
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	u32 enable = ucontrol->value.integer.value[0];
 	u32 spk_tx_id = mixer->shift;
+	u32 dai_id = widget->shift;
 
 	if (enable) {
 		if (spk_tx_id == WSA_MACRO_TX0 &&
 			!test_bit(WSA_MACRO_TX0,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+				&wsa->active_ch_mask[dai_id])) {
 			set_bit(WSA_MACRO_TX0,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI]);
-			wsa->active_ch_cnt[WSA_MACRO_AIF_VI]++;
+				&wsa->active_ch_mask[dai_id]);
+			wsa->active_ch_cnt[dai_id]++;
 		}
 		if (spk_tx_id == WSA_MACRO_TX1 &&
 			!test_bit(WSA_MACRO_TX1,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+				&wsa->active_ch_mask[dai_id])) {
 			set_bit(WSA_MACRO_TX1,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI]);
-			wsa->active_ch_cnt[WSA_MACRO_AIF_VI]++;
+				&wsa->active_ch_mask[dai_id]);
+			wsa->active_ch_cnt[dai_id]++;
 		}
 	} else {
 		if (spk_tx_id == WSA_MACRO_TX0 &&
 			test_bit(WSA_MACRO_TX0,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+				&wsa->active_ch_mask[dai_id])) {
 			clear_bit(WSA_MACRO_TX0,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI]);
-			wsa->active_ch_cnt[WSA_MACRO_AIF_VI]--;
+				&wsa->active_ch_mask[dai_id]);
+			wsa->active_ch_cnt[dai_id]--;
 		}
 		if (spk_tx_id == WSA_MACRO_TX1 &&
 			test_bit(WSA_MACRO_TX1,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+				&wsa->active_ch_mask[dai_id])) {
 			clear_bit(WSA_MACRO_TX1,
-				&wsa->active_ch_mask[WSA_MACRO_AIF_VI]);
-			wsa->active_ch_cnt[WSA_MACRO_AIF_VI]--;
+				&wsa->active_ch_mask[dai_id]);
+			wsa->active_ch_cnt[dai_id]--;
 		}
 	}
 	snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, enable, NULL);
-- 
2.43.0


