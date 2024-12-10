Return-Path: <linux-kernel+bounces-440040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851E9EB7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F87281FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7623F9F7;
	Tue, 10 Dec 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RxkgtaoU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30E23EBF5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850648; cv=none; b=q0NgbiMM+FdQCeLxe4ajoRZzsp0uMAjG5qwC+n6dTQdmnvUCmhMC7820bf6PHQeBzV4x74aHJ+iugpXc2ylugJ/DK9fDBWmzUZRxlauzAK1Ea44Dhc1FBDqY/zsOiq5UQ2Ue9r40xyKteAxWFjyB8dLh2p5ReliwAnzm5YSG3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850648; c=relaxed/simple;
	bh=JQNGPZYkGQRQ2sTS79lFZ6me2mcLImriGT7BK3n9sx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7nLpF8V/6+45Sa82IBq3GFYkDPSsHd438X/eTIhl6XdmeZNnSMj9LDkOxk2rhJAScNjpXd6zl30JfzOvXlf6O3uHMI4GcXpePBt8b9T011yZYIHPS0rAAvpTuz42hkWhsZXu702pDsVjKMlAN6QnaXwEgk/fVptJRfEjoyCqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RxkgtaoU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so7279184a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850645; x=1734455445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdorf6J6oUWOvTlM/ckHP3yguOeZKUZzy/Da078XD3Q=;
        b=RxkgtaoUMawCkOLuYSCT0LaqBXe0bXBvLgBy/pgjEtbXQNA8Vqy5k636ofhxNKac5Z
         euouPsNyepl84zZmi1DHJ57gUxsm4a4ZMnOXZnO5n9tTgpmC1IjGud8k5RQvqfer6dl6
         5BlooiNDCoggtL79AHgEC9LkU8fE7fo+U7sVSwvu8w2URX970dpGlgGJ1xW7RJOdAf2e
         c/m0Jd+uARwv2JQ7MTVqrHJDjU3lwWw1Z0wlgEZm+04vghaA3jzfQdhpI+ZkjHV01CA3
         ZqPWHBXF6RkDUQGeLYHOdYHrJUG6MIz9WwYtVRaMFWn8NPC0K6pyL2PSOL8iah+PegfE
         2IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850645; x=1734455445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdorf6J6oUWOvTlM/ckHP3yguOeZKUZzy/Da078XD3Q=;
        b=hz+CjK2HfKpKROnKTUcbkAuTCcPkrtzpwmNmMqRm6Gero/7+tJK4fGZIibgbFl3J3z
         mvYD3qtpGH2KUG6E6lY24dl9l3oBEFxG+rrxRZ0AbO13nkdRW7nrhFOLqsPTet9uZlzf
         gjWsbdVkRzck8dT37tvISfgJ+shvPCy3aIqsM4gTJIO3mVAeh5LJSVCfv8U6N3/LTRnC
         AJylf288rL5abWSr21PS3cIKA+1EyJQPZirIuoK/kkvGz7A3hEqKVIQwviftUnJ6BsXl
         RHJ8j5fJGU+pT1sHyQrYMEgHdDJLbFfNtSWwkfVAbWpeIkI/0Y/JhkdwnajphgWhy65i
         gpmw==
X-Forwarded-Encrypted: i=1; AJvYcCXdIBh5A+HoERVisaq/R4QjN+QvG8YFb1wU5aCEx54cZZwNTorWyLV3pVQQLPT1jiaVeCeTL/J3T+cQJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOCsDNU442uqTCVnj+R6yxtLvrR5hkjNF7wiwQCQnTn5I1oRl
	Xg2srHA2G1NXu/22fabCGXR5ggry2ROGaIQ3m9FbZgA3/uoCW3B/jOd8mdwV/uDGLhri0uHLqaW
	D
X-Gm-Gg: ASbGncucZR/jlmhyZqFIPqRht9PxZSpk+5WLcij8sUJwsNs98buKU+IzaufrsjPDmU1
	E1WlSKMn8LYPeYhloBB9dNWoWYqmw2aIzmWMw+VgdQEKJqusu53VKPoMn4UbHlH3CG20eI/BXl4
	dxlUYwnncneDr5K/CLF9oNIK5qFCfX6g0WdGEG2eK2WIt6SObClPXsQ7kBMtMiPYMVJixfi3VfO
	PTGLYbu2NzJ4M/qb9tULWrG6+qPL9E9HGAuKSjHHc/a29TXJgyH9mnZvaOdLP2a9+PeO/OeOPGj
	gvPhTSB4
X-Google-Smtp-Source: AGHT+IG0YYavl8GoEPcOWdjWdvPZujuBgG2HJ16HofI4S8uWOgmyS/RSRLDoRpiWfKoP6RlhHB13MA==
X-Received: by 2002:a05:6402:3493:b0:5d3:e9fd:9a15 with SMTP id 4fb4d7f45d1cf-5d3e9fd9b71mr12243945a12.32.1733850644830;
        Tue, 10 Dec 2024 09:10:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 17/24] ASoC: renesas: rz-ssi: Add suspend to RAM support
Date: Tue, 10 Dec 2024 19:09:46 +0200
Message-Id: <20241210170953.2936724-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The SSIF-2 IP is available on the Renesas RZ/G3S SoC. The Renesas RZ/G3S
SoC supports a power-saving mode where power to most of the SoC
components is turned off. Add suspend/resume support to the SSIF-2 driver
to support this power-saving mode.

On SNDRV_PCM_TRIGGER_SUSPEND trigger the SSI is stopped (the stream
user pointer is left untouched to avoid breaking user space and the dma
buffer pointer is set to zero), on SNDRV_PCM_TRIGGER_RESUME software reset
is issued for the SSIF-2 IP and the clocks are re-configured.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 46 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 486822d79458..d48e2e7356b6 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -782,6 +782,32 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	return -ENODEV;
 }
 
+static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
+{
+	int ret;
+
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture))
+		return 0;
+
+	ret = rz_ssi_swreset(ssi);
+	if (ret)
+		return ret;
+
+	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+				ssi->hw_params_cache.channels);
+}
+
+static void rz_ssi_streams_suspend(struct rz_ssi_priv *ssi)
+{
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture))
+		return;
+
+	ssi->playback.dma_buffer_pos = 0;
+	ssi->capture.dma_buffer_pos = 0;
+}
+
 static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
@@ -790,8 +816,16 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	int ret = 0, i, num_transfer = 1;
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = rz_ssi_trigger_resume(ssi);
+		if (ret)
+			return ret;
+
+		fallthrough;
+
 	case SNDRV_PCM_TRIGGER_START:
-		rz_ssi_stream_init(strm, substream);
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			rz_ssi_stream_init(strm, substream);
 
 		if (ssi->dma_rt) {
 			bool is_playback;
@@ -819,6 +853,12 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		ret = rz_ssi_start(ssi, strm);
 		break;
+
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		rz_ssi_stop(ssi, strm);
+		rz_ssi_streams_suspend(ssi);
+		break;
+
 	case SNDRV_PCM_TRIGGER_STOP:
 		rz_ssi_stop(ssi, strm);
 		rz_ssi_stream_quit(ssi, strm);
@@ -958,7 +998,8 @@ static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
 static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID	|
+				  SNDRV_PCM_INFO_RESUME,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -1201,6 +1242,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.39.2


