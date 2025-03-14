Return-Path: <linux-kernel+bounces-561581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A0A613B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C87AA7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3F202987;
	Fri, 14 Mar 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtR/nbu4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C9200BAA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962808; cv=none; b=YM3hMdkXARmAm+iwFZ6RIAgf751Z5drGJgLvgSaU+X73dE/Lju9nTSRWljHNy+CadJJhK9s/jLBCDik7w7FGMyaJJde9PakBVbBB9E5kibEgPpkP3gWj0Vlb52yFMqcgSMlDnNdeY6++4ifEvH1sG6PJquXf73Is5WBlmJfQexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962808; c=relaxed/simple;
	bh=/LrrjZsf1j7u5P5XbpBRADHJ1z3hQDnG5asCYJAEi6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoBMIc9r4KegrSYA/n/6u+hw4e+OUDwplliETcKt5DbIrfPDvei5QmVwGs8oqG/B+MCtSCC7e/KsgOALS4Fyy6wPGnTaTbbgyE7MrDnodRWe93mxmBVqGvX5TmJYfbJPPcq/8BQdypifGHBXcV7BCrkkBYgy5OGoYTBcxTdPiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtR/nbu4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f403edb4eso1230470f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741962805; x=1742567605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFTzpqhJXhYVh1FwE3WUgch0eP/UhlF6Ae6PLQps0b8=;
        b=LtR/nbu4hwNy8hFvF3CRpJFtL+tFExuaBN0e2cQBkgVeAe276ZkhluQIVo8z3kBW2w
         aOr9kpANZa6lgbgMndUqiFRz/cE6Xtn8naP26oJoErxLr4iVvUPwFW3EHjyRqIAriSWg
         xUx6M5YGwoZxbLBNoBsPGqwBTambFdd9Vl9txE3X9WlygRIDpN4eyhRTCOCt1ysU5lgv
         LB/13OsHZP9Mdw4ak9M5aypIEJwbMqd8Fq/IEVPMf/DE+W8F7lcDLUGnC+uViYJK/8Vw
         RbpqJR8C0IM3281Nu7yKUYSDmLuUxhx43RjJCzVQLXq+xSUrzlIq8jDP2lqRdkZniybc
         HD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962805; x=1742567605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFTzpqhJXhYVh1FwE3WUgch0eP/UhlF6Ae6PLQps0b8=;
        b=CmhvZl6vMuMkOzvoRuQhqB4Upa3gQ5I0Q6vjmOrB/8rmesIb7hWGmcbPpRVbeKGhxE
         nkoXkMm0WzzCkPKqgK+q1iQP9Jd68Ft2jfOfEeXQA+Yl1VuML/fynTTd3Fwyv9ITt2LG
         aPSZ/vkwFLNg32f7dO3zqIyV7DImRV3y75xrZFaZeSGzk3Rpr9EzIicavthvK3tKqYuI
         2voHk6er7wf+f3rcee+vItbX0PsC17uLSejGHwtDmKxLsFylVCX05IdFQZg/SgrSn/FL
         aBEOme4x1+6nz9wrwkSm3IZPgj8pyWZKIyoKn7vUDteHC7W7C6EhR3K4r941FxxSOmKa
         8QEg==
X-Forwarded-Encrypted: i=1; AJvYcCUXtLi4ewTrvIfFmcdoRNHiEtqEruMeTSvRRgBIGkKKbga1c6xKllS81YtrkbOgUrBkiosu9TvdtDKoMQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2NyYG07RSe8zHNDIQ9LrhzoVycQkXcFeitUfT29EVCvhvSPd
	iL04v4AUAmFaVik553eV+oWlJzcQdBbckkfzcwm2c8GaJZOe6H1U559AnRCtBgM=
X-Gm-Gg: ASbGncvFxvvxLEV6GzrrkkI2qG+N75y1+BA44xMnT6fCchKx+xekwe7QjQAUVl4dXom
	7S8ahY5qu92fd6otUGk2Wy3bioYBMRBlKpVUbstQjMVS3Hb4cuDMdRMgVX896jmRLBPyWZKuESz
	MHe+lkJ1WBH4jZ2/HOMyGogXhTvdIrX6A3VSuug/sbRoee994OMMASeicHpY2VlUH8Rt2vhjd5l
	xSbFHi1R8ZFK/pqzfT3MKd2+adIG6uE85QQzH35W9iazaeCmJsdVaKJPuSiDvvnDJANOj8bXvCD
	YuMlHxTunGtKu/x0kLPwSqtPKrZSbYMQy7wJp9ZNh98aHdVu8zeu5XJO9XQGx21bdEY6Lw==
X-Google-Smtp-Source: AGHT+IHeVYGxOJDDlfj6XFCcAFIk+y7PwJ4y20IgMQAQHLR/ud0eLQcjKFi54dZxDg4z7NiRfEtE2g==
X-Received: by 2002:a05:6000:2ac:b0:390:e853:85bd with SMTP id ffacd0b85a97d-3971ffb22c0mr3946467f8f.48.1741962804718;
        Fri, 14 Mar 2025 07:33:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm5699168f8f.25.2025.03.14.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:33:23 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/5] ASoC: q6apm: add q6apm_get_hw_pointer helper
Date: Fri, 14 Mar 2025 14:32:17 +0000
Message-Id: <20250314143220.6215-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
References: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Implement an helper function in q6apm to be able to read the current
hardware pointer for both read and write buffers.

This should help q6apm-dai to get the hardware pointer consistently
without it doing manual calculation, which could go wrong in some race
conditions.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 18 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6apm.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2a2a5bd98110..ca57413cb784 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -494,6 +494,19 @@ int q6apm_read(struct q6apm_graph *graph)
 }
 EXPORT_SYMBOL_GPL(q6apm_read);
 
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir)
+{
+	struct audioreach_graph_data *data;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		data = &graph->rx_data;
+	else
+		data = &graph->tx_data;
+
+	return (int)atomic_read(&data->hw_ptr);
+}
+EXPORT_SYMBOL_GPL(q6apm_get_hw_pointer);
+
 static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 {
 	struct data_cmd_rsp_rd_sh_mem_ep_data_buffer_done_v2 *rd_done;
@@ -520,7 +533,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		done = data->payload;
 		phys = graph->rx_data.buf[token].phys;
 		mutex_unlock(&graph->lock);
-
+		/* token numbering starts at 0 */
+		atomic_set(&graph->rx_data.hw_ptr, token + 1);
 		if (lower_32_bits(phys) == done->buf_addr_lsw &&
 		    upper_32_bits(phys) == done->buf_addr_msw) {
 			graph->result.opcode = hdr->opcode;
@@ -553,6 +567,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		rd_done = data->payload;
 		phys = graph->tx_data.buf[hdr->token].phys;
 		mutex_unlock(&graph->lock);
+		/* token numbering starts at 0 */
+		atomic_set(&graph->tx_data.hw_ptr, hdr->token + 1);
 
 		if (upper_32_bits(phys) == rd_done->buf_addr_msw &&
 		    lower_32_bits(phys) == rd_done->buf_addr_lsw) {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index c248c8d2b1ab..7ce08b401e31 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -2,6 +2,7 @@
 #ifndef __Q6APM_H__
 #define __Q6APM_H__
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/kernel.h>
@@ -77,6 +78,7 @@ struct audioreach_graph_data {
 	uint32_t num_periods;
 	uint32_t dsp_buf;
 	uint32_t mem_map_handle;
+	atomic_t hw_ptr;
 };
 
 struct audioreach_graph {
@@ -150,4 +152,5 @@ int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph,
 int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir);
 #endif /* __APM_GRAPH_ */
-- 
2.39.2


