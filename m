Return-Path: <linux-kernel+bounces-527948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD778A4118D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4570E3AA98E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA523A9A5;
	Sun, 23 Feb 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lmnsaeOC"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514323A99B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342512; cv=none; b=XUuGAexOB8LoD2PwfRak7+SU1s89c+p5WdsJRYhyAuRsR8wxtF9i+NalGQINczlMGngljra6SI6LQPlRIdU5VnboSm25osXYtdYANN3guBLOyDla2PeqD3OnnWeatXAfdA5Xjz3AZR1QI4ATeMdjONm9OUs6rvDlu05wlbAzXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342512; c=relaxed/simple;
	bh=ZsyIOeqWzbiuVffyIlUl3buQFn2ktrEOdiAIjlUKOYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyjUp7ICOLAj9csUUtBsV62YvxJWgb4jg+xta4zYnWMjD7rj2UrN8pyntKWBc282p/fBSVDyA8BSDUxYKLR4VHeyGivUb4eTI134luSlPJRrYgNMm6L85HyaAKjjnUevq6Z3ETA5NJNnEARCUwFLM9wZ1lbM2JF518RdUubVXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lmnsaeOC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740342508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+zTJ3hkU+s+DVpC9GLX4g3ZeOAZuzC6afimUtBs/oto=;
	b=lmnsaeOC9S8BAtthK/cic5Jq9HPDXa7zl2UuyMUWHwgbLUPq7Cs05LchrCjy2DEn+6dRch
	LEfwgj8nAy2sRTzEzDjvqVQRFs9KyO+6XM07cqypLKtDxuaocjVK85fEZNZS14V+kfK3l5
	9r3CN++W2BpuMHOKh2M1vd1M7PQeyYo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herve Codina <herve.codina@bootlin.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: fsl_qmc_audio: Remove unnecessary bool conversions
Date: Sun, 23 Feb 2025 21:27:41 +0100
Message-ID: <20250223202741.1916-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove unnecessary bool conversions and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/fsl/fsl_qmc_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index e257b8adafe0..b2979290c973 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -892,7 +892,7 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 		qmc_soc_dai_driver->playback.channels_max = count > 1 ? count : nb_tx_ts;
 	}
 	qmc_soc_dai_driver->playback.formats = qmc_audio_formats(nb_tx_ts,
-								 count > 1 ? true : false);
+								 count > 1);
 
 	qmc_soc_dai_driver->capture.channels_min = 0;
 	qmc_soc_dai_driver->capture.channels_max = 0;
@@ -901,7 +901,7 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 		qmc_soc_dai_driver->capture.channels_max = count > 1 ? count : nb_rx_ts;
 	}
 	qmc_soc_dai_driver->capture.formats = qmc_audio_formats(nb_rx_ts,
-								count > 1 ? true : false);
+								count > 1);
 
 	qmc_soc_dai_driver->playback.rates = snd_pcm_rate_to_rate_bit(tx_fs_rate);
 	qmc_soc_dai_driver->playback.rate_min = tx_fs_rate;
-- 
2.48.1


