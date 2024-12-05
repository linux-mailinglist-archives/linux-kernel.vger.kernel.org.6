Return-Path: <linux-kernel+bounces-432508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B99E4C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAA916A6F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2A191461;
	Thu,  5 Dec 2024 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IT6g/kwR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC917E015
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366033; cv=none; b=Qmer6sgEigfA9vJPjBhbkxcaFekkntIM87oI4fyhhedEjWTPVG7RZM7EiIYy3euc4E42iW+XbQXnKQGPkoYBFE+zild/FMsYOVuHcTPfPk2vyGibvD5zaSwPq4KTZUokcqCyJj7rY0mqptGk4uh94Lj57jdjhj2iQ5R8fp0lfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366033; c=relaxed/simple;
	bh=Isf6HQyXFroCVtEkXPHNWq7TOYXp0bv2O62+fk4lkgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wo9TgQcjgGKAU5iEW+ZSj90Iua+YEIE8HUZ0g7WmY2YIWGt2f93LbwPtOcJrBadz1nNCIhoerjCOWtlofcusE7FAxHtmJ/TtnFDS/CLl/XlZ60qEkLgzX3HOha0nmlStyNqv7JBIRhtMRiSikDFwv+LJ+H9cWO0uHHwtkt6zVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IT6g/kwR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a766b475so4085255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733366030; x=1733970830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0WueZqrue3ZzQaNIzfW+kCCT49wLDNKQcnxj9X3ods=;
        b=IT6g/kwRqP8YJTaqgoS/xqV+pFTufJ4suwULhsgu5kmLHpXvx4/pCncg9A1h0Aatgr
         TdBXCIAsNZf1CwWvAz1OXICZAr490IMPwcAYoVQCNrAiB7GGIedRT8AQ+3k0YxpyNADY
         HUbM0S23CtHstNqZtaQ0h10kVFYaxzabhX14ZF2KpDz+r3mZy+nLU937T0jnKbE2xieo
         F6N1tVNJMAoulZTyyxJmaHBIRmxMvt++RBRB9vHpb+1lXJOyc8UNAxDfefssa3buAXvr
         9G7BXK1NV+2EgaPZ2UM33wILfMynJXMrqcoFlA1WYjrtY9KwJSVfjgbFS/esF+VFXQTw
         jjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733366030; x=1733970830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0WueZqrue3ZzQaNIzfW+kCCT49wLDNKQcnxj9X3ods=;
        b=H7/kq1Qoo2J1Xg2QEO6ksAACzb4H+QIgB8FmgrC4Csc5xpwLEusZnpjDjY1XBUS9Vo
         DDhwthMDuANWq5F9u159m+olgV/KqVMZX55j6sfBLnTy4D6A88fDkHGw88LfDXZQdPAZ
         rwcfMRjs2UU9h+X939+CdyNndzZwY1WzAppmj72raTT6OVe03ofsCOgFTn5UF5upeLF4
         EKLVjWO18gOCg/92ZzeSVijWtelMWGrzDudOT2pf2lHJ/LphquXbsL/VAa20V+6fmIAT
         PwKb1ySgvUcalFVC5qaTIFopz8+2tzi2EGEZUNTZkHw53WWUwzZ8PI7UE9SfXXga7xZX
         kTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyCPWxjsT52qwQyyAq7v8xhKk0ITUkYuAXVUtsNpQ1ULwNpIpUhsk9dedAoUegtSEK1BdQbTz7sqR4Y3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdqhUEyXMt+/06BSXtFxZgpR7oa1hm7jFS+9EyddUf7yBO5zj
	t4w6oz1AmMPjMOVxxpPtmrI8eJShER0jaUFbXvOz0Fth8DxheQC7aUz7JqWZ0kA=
X-Gm-Gg: ASbGncsFB7D9uFo5BeDalU+Tb424hF9DGdVv7Rwo6bXbpuTwPOamLaecOY57B+j+AB/
	iUFJ8PkNMkGLtX2UllDfFBXopxZO/BbSJq8xJqRGf/O0lcT3qngD9xsRzXmP1QoPmWxi1YxVpN2
	zhfOZhhax6jQzchsCq0zp+GIYnIkBML4amJhVwPcDY8TlPUh/LaqwdmxBj5z6DPaje3T6YRE2mR
	/CAawDmLFi5SwRGRJhG5PqSzcQwQGFYjSBbvU/T1qFJqMpKdCDhmU8Jz404klqaSWzs
X-Google-Smtp-Source: AGHT+IFy7VrnCoXus3t9ExkXEj7SDNYfG18p3P3BcNevba3EvsBVM2z1mEoPokrxMXPtnVvCqvzv1w==
X-Received: by 2002:a05:600c:34c4:b0:434:a8ef:442f with SMTP id 5b1f17b1804b1-434d0a23e6emr68510235e9.32.1733366029773;
        Wed, 04 Dec 2024 18:33:49 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273440sm44444325e9.18.2024.12.04.18.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:33:49 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] ASoC: qcom: sdm845: add handling of secondary MI2S clock
Date: Thu,  5 Dec 2024 02:33:43 +0000
Message-ID: <20241205023344.2232529-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205023344.2232529-1-alexey.klimov@linaro.org>
References: <20241205023344.2232529-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add handling of clock related to secondary MI2S_RX in startup, shutdown
and hw params routines. The handing of MI2S_TX and SEC_MI2S clock is
already there so this requires only placing SECONDARY_MI2S_RX in the
correct switch-case choices.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sdm845.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index a479d7e5b7fb..fcc7df75346f 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -215,6 +215,7 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 		ret = sdm845_slim_snd_hw_params(substream, params);
 		break;
 	case QUATERNARY_MI2S_RX:
+	case SECONDARY_MI2S_RX:
 		break;
 	default:
 		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
@@ -356,6 +357,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
+	case SECONDARY_MI2S_RX:
 	case SECONDARY_MI2S_TX:
 		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		if (++(data->sec_mi2s_clk_count) == 1) {
@@ -371,8 +373,6 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 			Q6AFE_LPASS_CLK_ID_QUAD_MI2S_IBIT,
 			MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
-
-
 		break;
 
 	case QUATERNARY_TDM_RX_0:
@@ -441,6 +441,7 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 		}
 		break;
 
+	case SECONDARY_MI2S_RX:
 	case SECONDARY_MI2S_TX:
 		if (--(data->sec_mi2s_clk_count) == 0) {
 			snd_soc_dai_set_sysclk(cpu_dai,
-- 
2.45.2


