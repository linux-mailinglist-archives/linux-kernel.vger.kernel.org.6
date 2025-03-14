Return-Path: <linux-kernel+bounces-561915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774DA6188A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B2B460858
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8351204F99;
	Fri, 14 Mar 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQk1h7zb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9720204C15
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974521; cv=none; b=qpz9kMIxYVMHd15fhS9odiXs/r04e5zC4pH1tBS0Qpq9cLyt65/2honM3AV0P4hbFw4qaDpGSlEZZ+JrhB42Akyd0t3buNBaLbHd50egyeqqorxaKywBtjEHQ9b9STjiDlGHOPNWXDcUjg22RxwDEDXGN93hvNv/WpgpSISNSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974521; c=relaxed/simple;
	bh=GTv0VCH3s0WKdgoZHW+Neb05F5hHPFrcMTNWEHTQEPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fejA436yjhlgstptj4uX20N2vFTKiS3acV+V5YLw/f+uac5ZspnqsWc7IUmfN4kgUl+oqL8V6B2sHsVxMqt/ph0t7b4O/c6uFw5SP4ommkZdQO9DBValZQbmAsfXJQEYduLZKU/M9XL2IsqtuLU3yd3rCE1hGZjgKt3TptmR7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQk1h7zb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390fdaf2897so2132958f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974517; x=1742579317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmD5vNzSSLCYtQiI6TARd80NsNkLFJqSnN180ML5a34=;
        b=FQk1h7zbG/In83KeSzc7kav2fg+TJmkzb9qqyGOf1JQkubfTfBTtfKNg7dCmKjpXu0
         PCDyBEQNDXzn+tisQNBydCsHL83TvzatS1OqrPXXLTjnqPLSbKrPnxiVIXVzpMfiGX+P
         M396vjnoecIevnUsUNYRJKRoYmFaJ1QRpF04b69AyFAPJ8/N5AUE833NBesTyEYkVB+a
         cxqekdPkdL1xGKO/a7PXK7q1wasPnO9H9ALe5nlagHWbzWSyg7LiKFOXw9RC+eqMrFtV
         OkJLN815O8ad/b3Y6ZfJgXE9C0ghNnONUf+2XrZry05hCqvR1IPEofHm2eMLq1q5x4ng
         G1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974517; x=1742579317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmD5vNzSSLCYtQiI6TARd80NsNkLFJqSnN180ML5a34=;
        b=POfdbGVZv0p+6BuOjXaJJb3pxyYcIzv49t3TZl0LjLgMJL6Su//2QFwhFGpICVtNFa
         ZEc9KUQdQTA2JaxFNwDrAmSKlNZZF2+fFtc7y0QDIdkaT9COk9l/xapz1R6MMo3Gqha3
         1noh7yse6tuPHeMccCJDDb4FgfqZUgFYda29q6JYBX9ycFBbbhYMis16k6E8IJrpLsFX
         9foj0tN7LyNaqwwRm3IxHPsaq2aea7+uMSyqRlLhX7TnkrCZJ9r3J2kLDFYo3QDDkHpy
         qr9JvjjChkElBiG72jpUzHrwImni9XzWaf0Q1XpgiSNIZkb5OSluhzgKcPMHHmYXuflt
         4s4g==
X-Forwarded-Encrypted: i=1; AJvYcCWq5MH49gcuRWqKwp2M08uHRM6sC18OXi9tz4+6oRlc4an3/PMWMUaug5Zj920N7+DBuk2V7xxV+JnQnYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3T87Q7tS+CkbTp1Yc7VMY+xSgLYRcoSklNnv978ZSAuZxrWW0
	vXZej5uhFlL7PbHf5oegWwTyqT8ZZwlJra/Q37RIxVsyM2v5bji54n9LL4R5jNA=
X-Gm-Gg: ASbGncsyzxiR16UQqB4+s0ox6z2xBozl3hgG6Eot3puj++d/vt6p0r8xc/bvjrL1Mcw
	v2xK4EvHKxzYQAYAL3MhM6Rg2Z7aGbNYjUb+J1RQydIKfJbZhMCjNFnzw/KrROQuDqYwdiGEXhB
	5MjLwDg2lOwrmBJLqmSqsNEDRxljJSXkfVRjx6awjRJH9SMSXcuhKe06gbZfMMSKWyOsMsnZTJd
	FEi9OipUsujk2G2StcrtmCwxurP9WQ2YCNLTyS7sp/9g0i8/0nsnGWLb3fIbGlfqqhJckFOZFAJ
	zwdqNt+jv9MqIGjxr0X/m9xnNdW5nhNdcpSgmKJWYD26bCWJ7dIxQNg0wjJP01MdR+8qFw==
X-Google-Smtp-Source: AGHT+IEDC3mTs5ZEgnH5M13Yv5WSovrEtsi3f3jqP63eSIlzIlegYCTCHHMMtUO2OfGOcqcPh6kT9w==
X-Received: by 2002:a5d:64c2:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-397202a1acemr4508526f8f.37.1741974516847;
        Fri, 14 Mar 2025 10:48:36 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:35 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/5] ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
Date: Fri, 14 Mar 2025 17:47:58 +0000
Message-Id: <20250314174800.10142-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
References: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

With the existing code, the buffer position is only reset in pointer
callback, which leaves the possiblity of it going over the size of
buffer size and reporting incorrect position to userspace.

Without this patch, its possible to see errors like:
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 9d8e8e37c6de..90cb24947f31 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -64,7 +64,6 @@ struct q6apm_dai_rtd {
 	phys_addr_t phys;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
-	unsigned int pos;       /* Buffer position */
 	unsigned int periods;
 	unsigned int bytes_sent;
 	unsigned int bytes_received;
@@ -124,23 +123,16 @@ static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
-	unsigned long flags;
 
 	switch (opcode) {
 	case APM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6APM_STREAM_RUNNING)
 			q6apm_read(prtd->graph);
@@ -247,7 +239,6 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
-	prtd->pos = 0;
 	/* rate and channels are sent to audio driver */
 	ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
 	if (ret < 0) {
@@ -445,16 +436,12 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	snd_pcm_uframes_t ptr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&prtd->lock, flags);
-	if (prtd->pos == prtd->pcm_size)
-		prtd->pos = 0;
-
-	ptr =  bytes_to_frames(runtime, prtd->pos);
-	spin_unlock_irqrestore(&prtd->lock, flags);
+	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) * runtime->period_size;
+	if (ptr)
+		return ptr - 1;
 
-	return ptr;
+	return 0;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
@@ -669,8 +656,6 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
 	prtd->bits_per_sample = 16;
 
-	prtd->pos = 0;
-
 	if (prtd->next_track != true) {
 		memcpy(&prtd->codec, codec, sizeof(*codec));
 
-- 
2.39.5


