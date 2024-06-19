Return-Path: <linux-kernel+bounces-221242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D690F0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E901F26D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A8922EED;
	Wed, 19 Jun 2024 14:33:46 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC01CD18;
	Wed, 19 Jun 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807626; cv=none; b=hLOarTnQ5G7wAdQ/pULTrmM3BEUn198UtKKg/esYjMIvt/kkxiuUHExCL0V4Ks8osOF82meuVIZZjC2Ka529I578vtSBQhnjbdSus1I/mN7FUzokGDPB+U9Xs6L9rVQGfT0Q8qHas8cPcLmYHwp9bJE6D4DfNovzKN8zigk+IgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807626; c=relaxed/simple;
	bh=FHoeYOO0rqWuQjykbGw6nHEWsET0aT9gakqCiFstsKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnMY8NJTXYUjvWQ2GISWOhmlBc/81li16hdwF+7WPtaEG5+H7Nl0+hcUk8m5i536y4iP/fWGioC1ZNCoVnoLePZ9luUPNB7koF7OuEIXDX6CeeHMwBV7gEfcMW9e9/X8uUbzL4VdHGAs26VqBNQ4aa1ie6ATKNiQAlG2W0GuNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id BC7B6102395;
	Wed, 19 Jun 2024 17:29:30 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id B605010237A;
	Wed, 19 Jun 2024 17:28:35 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 45JESYbd005890;
	Wed, 19 Jun 2024 17:28:34 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Takashi Iwai <tiwai@suse.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] ASoC: simple-card-utils: Fix error handling in simple_util_init_jack()
Date: Wed, 19 Jun 2024 17:24:32 +0300
Message-Id: <20240619142432.573338-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20240619 notchecked
X-AV-Checked: ClamAV using ClamSMTP

Currently, if snd_soc_card_jack_new_pins() or snd_soc_jack_add_gpios()
fails, the function continues execution without handling the error.
This can lead to unexpected behavior and potential crashes.

This patch fixes the problem by checking the return value 
of these functions.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 sound/soc/generic/simple-card-utils.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 81077d16d22f..5da0c13858ad 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -784,10 +784,14 @@ int simple_util_init_jack(struct snd_soc_card *card,
 		sjack->gpio.desc	= desc;
 		sjack->gpio.debounce_time = 150;
 
-		snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
+		error = snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
 					   &sjack->pin, 1);
+		if (error)
+			return error;
 
-		snd_soc_jack_add_gpios(&sjack->jack, 1, &sjack->gpio);
+		error = snd_soc_jack_add_gpios(&sjack->jack, 1, &sjack->gpio);
+		if (error)
+			return error;
 	}
 
 	return 0;
-- 
2.39.2


