Return-Path: <linux-kernel+bounces-543930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F49A4DB92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A27D3B24E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB861FF7D7;
	Tue,  4 Mar 2025 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUi78mJH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6091FF1B0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085876; cv=none; b=Ud7eEdzvxgT+9ekVvkMciNEZozgiFlNq9l5VU5aCd589C18Aw13OzZzdeoZEtjIQ+f2Od15ZfcVxcyOUYWh+YPkB1BByXdJNBkWo7AUJfv+DC9O7UGW1n8vhbTrEDmknWtYN6FOvvH6OENUO99NrabefpvmkMlJxKQue2LA0BE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085876; c=relaxed/simple;
	bh=1xefXhqlbqpAB2oQqLsGbrSi7RBtCPYZ7ZpO6A4CBvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uvpq8+xWSR65WbdcPMbN32rIOueovPd5cB66M5XZ9+5Jnasxydwr/f7E62oUg6eRfHT7muWB9iZcKOBHacjtB/UStudIUFmzm4bRy1XQ6up5Z4LvzyBFhfK4KhEU0kpeLt2BzDabq9VR8bAEuOz1EU8pVH1ZT/vEnv1kC68Ms/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUi78mJH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso2000683a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085873; x=1741690673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKxN+N8VR/L9rUJdIcbrBDE8Zwzij3KzY6U7lQgd2vE=;
        b=bUi78mJHtQDzhRT1SYzXepDMqL+rrb8RdnzLz32WBu96YGR6YV2YEhpA+Zafb0Z7NT
         JC0LWnJF5Y3oZ2JtQigO3nQOmiR1QmGTfNoO3ll4X3XCO0g5U6bLeMA1pyU3G2H3pmRm
         VhMjkMXQBcJMj4pE/2WyFCPyDeeGQzbDp+bIhADaZqPDfijm3Jd4IJQbSZPEbR8Qmgzb
         NgS92SIaUiNqFTvw720DDMJHKFh92RBSiP8z5YCMggC7zeR4H6/BlyZt+6MT8oEiwuNt
         R0KPyevhLH3JyG/Pc86jDL75DfJVTwGIB6x0R2Qomi+pYmG4Vldu2Qj+CYoUYcifryEO
         gT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085873; x=1741690673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKxN+N8VR/L9rUJdIcbrBDE8Zwzij3KzY6U7lQgd2vE=;
        b=S8FkVgg+1QeMmAexSirdG8goG4y8W0KznMtbFrKNK/KarkCC4lcv18JdAih5ugQ02P
         VgVs9pigAkxJKMCkAafYV8UahrJiUpM2+g+vpG0PX48F/yH92+V2mCb8Y5HFHn5+BlJa
         GutNehB0MNK5kgZYVyqzJZBY/uouImk+EQXsAMTzSw1GBQKrBGo51MeI2jnmu5SggP/0
         qM0LS+x877sumsNx6/kZ/UOZuySpAl19lFp44A/lGBE2DjID3pkuSosnUZs6pRPcs6eM
         kreSFlOzmXV54/XbuORA5E3Pq1h0V8aMEBo1mt3fPUUTheXqjLGAZzPYsjj/3gHICyjq
         lZrA==
X-Forwarded-Encrypted: i=1; AJvYcCXYTtgWjliErtbRbLjnGpAv9MaXo23ZSWnFy0P2gl84ctB49huRiFawvxRluCwv/YKqTvrcYsXpEm3VRsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PrWcfCupZo+f+zmJAXu40lV6t+sWkXNzLEWHbfchF7zoUppU
	0ERoDO4hz+OBJnr8IzhpK8jJQUDX15J34LydN+LBWZZVtKKhNB2pwR8t/xaxQfadPqmpNlDN7h6
	w
X-Gm-Gg: ASbGncvSQaZKtHfOPj1ADvash+nK4kzjRI9RoQokW6XdXYGXRj2axOSgReD0RZy6ndr
	AY9BVMNDdjPOZrxu0hkPNibkiZ0Mvk9GUo/YbX+kjiLlykTMKex8KX8Sh/N6YaYx72tA07OQ+1z
	DPFpHV7DExgAeJaNQWapvwJgYVzpNB4QE1ZikOXGcTnm9qqePsVhUxux0iVhbipbLs4BR4VgGgW
	LdPhnB6LIy/CPP9SkVmCKH9e5KiaLpoeqEhD/rJviTJiDrArmQ1YSWAM99G6ohVLCh8pCt3VGYS
	L6l+o34ESzKJwAFvfAp0a/c+yjZk3D2yuQd/zVGpeVkBiO+T+IO+IjwEtWg81D8/uyXq8A==
X-Google-Smtp-Source: AGHT+IE8Sal8KqA+qz4oZKZeTHOuVTnUfodH7MUUB6Y+bnPf6oi5PL4NudtJEqpBolNDyCLsfe6DJw==
X-Received: by 2002:a05:6402:4585:b0:5e5:310d:256e with SMTP id 4fb4d7f45d1cf-5e584efa4c3mr2476157a12.14.1741085872947;
        Tue, 04 Mar 2025 02:57:52 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a5acdsm8002966a12.77.2025.03.04.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:57:52 -0800 (PST)
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
Subject: [PATCH v3 2/6] ASoC: q6apm: add q6apm_get_hw_pointer helper
Date: Tue,  4 Mar 2025 10:57:19 +0000
Message-Id: <20250304105723.10579-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
References: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
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
2.39.5


