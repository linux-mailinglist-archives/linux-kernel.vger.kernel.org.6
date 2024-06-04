Return-Path: <linux-kernel+bounces-201252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8C8FBBD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4259286AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BC14A60E;
	Tue,  4 Jun 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYDl6NND"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046614A4FC;
	Tue,  4 Jun 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526923; cv=none; b=t4WiKuPB14HkF20Mfasdzoq2uoC122fMLvAKisq3N9BcW8ONpzMeFA5EDF45soaMntWyX+IU6YlLc5uipmEjbLR5EhxqcHq1iLIb0dxMh9fQmvxArObUrJPN/YnaH9xJyvAqbdtASnE5kNF2kt8DD+CayNSs+m5RS3JW69qJayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526923; c=relaxed/simple;
	bh=rb1t3bO33sJM24NYQ16VoUzU0MNaG6KSdzSrX+GNr8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnWI+rllQFkh9YNqstmq4l+5fG9VnXXFc1NQcSfNbmfEhwrp67kKod9Yy7XqmXH+sWD0GEwzMan4erRxYXC9dok490Qgv8f7D1EKtanYao+w+a+bMHGIgoYExYuNAtWzZNkM7Dh1vhTVYIW7O9oOt2F2Bf1ZPWVxQImszUjaSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYDl6NND; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b8b638437so1609282e87.3;
        Tue, 04 Jun 2024 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717526920; x=1718131720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhU1SbvM7znKVct1eWXWAILOVj0SRCPHV7V811HpayA=;
        b=lYDl6NNDQ0JGEhY5hGpra3rdHpSjFgdvs1SGgwcXvvzWv7Nym44bpSOfQqg1LNP3up
         irunm1w+LESoQdfZGrK+eKSSc7aqE8Lae34FD6o9kYyjTiH+zKcwSQwwPCs83toA/5kO
         PeCdiG1uLc5CoLLnyoNAAOwr7ZNUgeWSdrhRF1CKwEQroFHtDm6kYUotlr9Z2HVFLL1M
         /vlLibC63aoPliCQD5dFKn7+JnHNjTkh1ipib1HX9k3OzG02gpw+YGa3FTd6Fd/X2oL1
         Vpj2HiALiH9e1DZsgDSzqvlJqeHnD+aYoUDfgEZ/+vD0wnxVYxXbI+EOwrgKmbEslIcW
         Lh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717526920; x=1718131720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhU1SbvM7znKVct1eWXWAILOVj0SRCPHV7V811HpayA=;
        b=Xzow538ohuy+ijx2wYFwh3R9KJ2g1m6wZjIlfVk7Q3cHalEo2JhmFj1de3jEWL0u2/
         SYKHQaCyrFcWg9TqldIT6U/S0NeP384DqkpMZzr9B+//rKW88Xs1nVNqRfomNuxaRuvG
         YvMVUT3EOnup2KL9y2ypJj4FVfclRt5NQy+J9BGTnPlbtTc+hYibHfVJAC37VTo9UgAw
         aYePhFYvJCQKx001fNtNWr2/dS1ujShGXOCPU1BTzGg+4/CxTo+r+LYsA6qyHuyBib59
         Lw9u9OW3g+D3v1zZwv0Rj9fFlD3e0D3jtKw7XrlJR1zrgLdFRjPNY/WHxX6G0L8jV64i
         /E2w==
X-Forwarded-Encrypted: i=1; AJvYcCWn/6kqxUGQX4cH+XAs/geXQp9UlhH9DQFdhtYvE4TJMpZWPQgj7HRWHsquP78XLA4bGwkpxMQcjpfBjATCAKsrszOLUniz1AsXTSFsH49zAfJQwyTTETJ3u6Haa8pjpYpjFWwbRdse9qM=
X-Gm-Message-State: AOJu0YzVGgHgi+03gOS6KcdYWphaIVlq56wB0pSKY/cq71fFhXEisLxl
	E8Bha4N9qZZTAODXSyYE1lAj8iUjuu1rx9F6oGhUfqfdXUuZrJ6R
X-Google-Smtp-Source: AGHT+IFEJ8hqG5xCrTQKvzSoryOtPIc1PkC8aaNWtW7orx0ghMl5wbgtdEJ/5xVPTPWB8vdw9HCNQw==
X-Received: by 2002:ac2:4e89:0:b0:52a:fbcc:b358 with SMTP id 2adb3069b0e04-52bab4cbd6amr226548e87.13.1717526919443;
        Tue, 04 Jun 2024 11:48:39 -0700 (PDT)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9ea5271fsm452903e87.252.2024.06.04.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 11:48:38 -0700 (PDT)
From: Alibek Omarov <a1ba.omarov@gmail.com>
To: luca.ceresoli@bootlin.com,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Alibek Omarov <a1ba.omarov@gmail.com>,
	linux-rockchip@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk
Date: Tue,  4 Jun 2024 21:47:52 +0300
Message-Id: <20240604184752.697313-1-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TRCM mode is enabled, I2S RX and TX clocks are synchronized through
selected clock source. Without this fix BCLK and LRCK might get parented
to an uninitialized MCLK and the DAI will receive data at wrong pace.

However, unlike in original i2s-tdm driver, there is no need to manually
synchronize mclk_rx and mclk_tx, as only one gets used anyway.

Tested on a board with RK3568 SoC and Silergy SY24145S codec with enabled and
disabled TRCM mode.

Fixes: 9e2ab4b18ebd ("ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates")
Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 9fa020ef7eab..ee517d7b5b7b 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -655,8 +655,17 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	if (i2s_tdm->is_master_mode) {
-		struct clk *mclk = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-			i2s_tdm->mclk_tx : i2s_tdm->mclk_rx;
+		struct clk *mclk;
+
+		if (i2s_tdm->clk_trcm == TRCM_TX) {
+			mclk = i2s_tdm->mclk_tx;
+		} else if (i2s_tdm->clk_trcm == TRCM_RX) {
+			mclk = i2s_tdm->mclk_rx;
+		} else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			mclk = i2s_tdm->mclk_tx;
+		} else {
+			mclk = i2s_tdm->mclk_rx;
+		}
 
 		err = clk_set_rate(mclk, DEFAULT_MCLK_FS * params_rate(params));
 		if (err)
-- 
2.34.1


