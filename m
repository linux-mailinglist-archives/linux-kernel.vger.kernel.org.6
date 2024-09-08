Return-Path: <linux-kernel+bounces-320204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C497077D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CAF1C20F36
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305C1649A8;
	Sun,  8 Sep 2024 12:41:49 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0071531F4;
	Sun,  8 Sep 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799309; cv=none; b=hfZdADSu5daHyiNfG7m676ZfLEbnLfwgBGX4GMOF8ieJGhcTJIiciIjobeAsz5sVt5Y2ZTibturm7YkiD+XcqrjYlZCKXnB3CiZZCSf50R3zPm2Xw1FkR9mzuehXTKamBbSOH+lopMlatMtemjYhUFaF61iTtdnVaYjeytFthQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799309; c=relaxed/simple;
	bh=5E/Oj4hrHfo3SnHgf0xLEcui4/pppyRLwTfkkuzdjkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msdq1R7g/pTx4OHyhBrHaqneRnOKcJ5MDnKut1K0diREdMFOfI2oViv0AF8j7I1cssggeRUHMu3a06nVx5cYE5yry8HmEkQ1dHbn3dF3PfBQF21YSQ+Effl0eQSdthfiDTM7au2y05dO1UcP1Xp2kA0jrly6L9H+rtTGktUSMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566dd9b7e002-03005;
	Sun, 08 Sep 2024 20:41:36 +0800 (CST)
X-RM-TRANSID:2ee566dd9b7e002-03005
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.102.139 (unknown[223.64.113.255])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66dd9b75ec5-0de13;
	Sun, 08 Sep 2024 20:41:35 +0800 (CST)
X-RM-TRANSID:2eea66dd9b75ec5-0de13
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: soc-ac97: Fix the incorrect description
Date: Sun,  8 Sep 2024 20:41:23 +0800
Message-Id: <20240908124124.1971-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function snd_soc_alloc_ac97_component &
snd_soc_new_ac97_component, the error return is
ERR_PTR, so fix the incorrect description.

Fixes: 47e039413cac ("ASoC: soc-ac97: Return correct error codes")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/soc-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 4e4fe29ad..079e4ff5a 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -168,7 +168,7 @@ static void snd_soc_ac97_free_gpio(struct snd_ac97 *ac97)
  * it. The caller is responsible to either call device_add(&ac97->dev) to
  * register the device, or to call put_device(&ac97->dev) to free the device.
  *
- * Returns: A snd_ac97 device or a PTR_ERR in case of an error.
+ * Returns: A snd_ac97 device or an ERR_PTR in case of an error.
  */
 struct snd_ac97 *snd_soc_alloc_ac97_component(struct snd_soc_component *component)
 {
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(snd_soc_alloc_ac97_component);
  * the device and check if it matches the expected ID. If it doesn't match an
  * error will be returned and device will not be registered.
  *
- * Returns: A PTR_ERR() on failure or a valid snd_ac97 struct on success.
+ * Returns: An ERR_PTR on failure or a valid snd_ac97 struct on success.
  */
 struct snd_ac97 *snd_soc_new_ac97_component(struct snd_soc_component *component,
 	unsigned int id, unsigned int id_mask)
-- 
2.33.0




