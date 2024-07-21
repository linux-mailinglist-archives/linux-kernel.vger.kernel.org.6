Return-Path: <linux-kernel+bounces-258232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53769938553
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AB81F21171
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696E16727B;
	Sun, 21 Jul 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NkdDUR54"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DC2907;
	Sun, 21 Jul 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721576426; cv=none; b=pEtK+vy0aSiD2f1eiksq7bkv4budoqPeCpzenfN6k9ISZBSa1jswh75ANXDq4KDjuTpN/6y/AtfK8pdYPN9PLB96iX4nvlK74gkpEglSPtMMghRJreA1zOpN3n9i0yWYLC5IwM4msTOUw6jjbUG05kkwmI/tZvnAdBJNV2BIKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721576426; c=relaxed/simple;
	bh=sCm+3ajUXc1cFZrI0mjG4sX5WmpX3phQ/BWF3fE4vKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vug+m2y0JgO4sASMamNfHYwd04AEtY2pdeIKExkcpf/KNjEqNNY6IUhSKz6ZsdDtR834yK8JzRNCi9LDTOuvulekLKIizH9ZK7ufEyyN/ng6ro5bN3UX0DuXnvbJpcmBH2zI6wxXp57GGygMdXum2najSp8NN/o/aperAjgcrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NkdDUR54; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from fedora.local (unknown [82.64.9.191])
	(Authenticated sender: jau@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 812E419F745;
	Sun, 21 Jul 2024 17:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721576421;
	bh=sCm+3ajUXc1cFZrI0mjG4sX5WmpX3phQ/BWF3fE4vKg=;
	h=From:Date:Subject:To:Cc:From;
	b=NkdDUR544zaqnQO6GHvHKE3DOopE7+7pGHOUMS7yiqkwsKmDNqnf5NAi9rvlIYP/9
	 0/Nn0G/vgkJhRksCSlHpLtyVcx9J8gMtfveX31eG/1lY0gVZlr4FNGQIvCfAOVFd+6
	 DVelVOsp4PR0xG0jsuuawUwkJfrQbSKirsCj2FJEB62Ado8c1sk5WWzeIzceLUCfOe
	 +wtgDBf30IoIYD1itFgUiQGI4cwvoSTgtn+cyVSjp5WcLHSe1/WYdf6QC/0NlmxUc1
	 AToEwh7Pl/k3oMs2jWAr/0MDUHck1Y3kkahmpqTx5pa8voY3ObntD0N2Gpvvjt4aZN
	 sbm19sHaQGwcQ==
From: Jerome Audu <jau@free.fr>
Date: Sun, 21 Jul 2024 17:40:02 +0200
Subject: [PATCH] ASoC: sti: add missing probe entry for player and reader
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr>
X-B4-Tracking: v=1; b=H4sIANErnWYC/x2MQQqAIBAAvyJ7bkFNEPpKdLBcay8aWhGIf086z
 sBMhUKZqcAkKmR6uHCKHdQgYDtc3AnZdwYttZFWKywXo7s9Jwz8ohqtCSGs2pCF3pyZuv5/89L
 aByeqMexfAAAA
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Audu <jau@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721576412; l=3557;
 i=jau@free.fr; s=20240721; h=from:subject:message-id;
 bh=sCm+3ajUXc1cFZrI0mjG4sX5WmpX3phQ/BWF3fE4vKg=;
 b=tQSvHV+QaJADU8qlO9HVimwakbjAkY3lV+9+i73x9xk3PistmuEWmIqgAJ/jHIqCp9saca/mY
 2bBJYNN6we6CzUDqz41VhIAnmWznGOA/VVAq5uneuL+QrlXDWsEQoKc
X-Developer-Key: i=jau@free.fr; a=ed25519;
 pk=CfXLqyNBjY9A4RDoxPChE7qFvTjVyy0rJNTfI4JQ0dI=

Restores the audio functionality that was broken
since Linux version 6.6.y by adding the missing probe
functions for the player and reader components.

Fixes: 9f625f5e6cf9 ("ASoC: sti: merge DAI call back functions into ops")
Signed-off-by: Jerome Audu <jau@free.fr>
---
Specifically, the probe function in `sound/soc/sti/sti_uniperif.c:415` is being replaced by another probe function located at `sound/soc/sti/sti_uniperif.c:453`, which should instead be derived from the player and reader components. My patch correctly reinserts the missing probe entries, restoring the intended functionality.

The patch modifies the following files:
- `sound/soc/sti/sti_uniperif.c`: Changes the visibility of `sti_uniperiph_dai_probe` to non-static.
- `sound/soc/sti/uniperif.h`: Adds the declaration of `sti_uniperiph_dai_probe`.
- `sound/soc/sti/uniperif_player.c`: Adds `probe` function to `uni_player_dai_ops`.
- `sound/soc/sti/uniperif_reader.c`: Adds `probe` function to `uni_reader_dai_ops`.

This ensures the correct `probe` functions are utilized, thus fixing the audio regression. 
---
 sound/soc/sti/sti_uniperif.c    | 2 +-
 sound/soc/sti/uniperif.h        | 1 +
 sound/soc/sti/uniperif_player.c | 1 +
 sound/soc/sti/uniperif_reader.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index ba824f14a39c..a7956e5a4ee5 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -352,7 +352,7 @@ static int sti_uniperiph_resume(struct snd_soc_component *component)
 	return ret;
 }
 
-static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
+int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2a5de328501c..74e51f0ff85c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1380,6 +1380,7 @@ int uni_reader_init(struct platform_device *pdev,
 		    struct uniperif *reader);
 
 /* common */
+int sti_uniperiph_dai_probe(struct snd_soc_dai *dai);
 int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt);
 
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index dd9013c47664..6d1ce030963c 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1038,6 +1038,7 @@ static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
 		.prepare = uni_player_prepare,
+		.probe = sti_uniperiph_dai_probe,
 		.trigger = uni_player_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 065c5f0d1f5f..05ea2b794eb9 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -401,6 +401,7 @@ static const struct snd_soc_dai_ops uni_reader_dai_ops = {
 		.startup = uni_reader_startup,
 		.shutdown = uni_reader_shutdown,
 		.prepare = uni_reader_prepare,
+		.probe = sti_uniperiph_dai_probe,
 		.trigger = uni_reader_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240721-sti-audio-fix-1374fffb24e7

Best regards,
-- 
Jerome Audu <jau@free.fr>


