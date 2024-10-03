Return-Path: <linux-kernel+bounces-348993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904C98EF15
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3871C2237E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C587170A2E;
	Thu,  3 Oct 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PPUl49i+"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C30145B24;
	Thu,  3 Oct 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958034; cv=none; b=WtPuKm2zOaqzczCWKqsjcTsydLXIisT+qUEt8hSQmEM+x2HD0YHRHLGpxfFmnXG6fEs1/pzAQ53nh5+QON5oBzJXqwdwdKI2dNxPBa7yZ7oYEW8a4AiHWiCeQPCKb/RDZuQyTCT/wElWtr9C6rXZDDE3jAv8HbQ9sTdT4gWHUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958034; c=relaxed/simple;
	bh=mXo/Y+0M6ZvpsQyuy5w66zUhARgNZ+kp7VwSuWRG4tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmg0DnXZGOOiuM7qZv4KwmJCf+LUOjkb8rluDd2n+3VSZMPuTOJu8aXXE9LgOJUfXPqanvXxQtOUNxynpS8XmvZ3PXfn2Bjt/i581XNIIgilew0g4kP8YWtRSFAj6lnmfiJzH6KSz884Cx2WLSQCo7wnog8M4ZfglAjU2czD7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PPUl49i+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BAF6CFF806;
	Thu,  3 Oct 2024 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727958026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=raONT/HDAF820rUPmdb9npjFE1C+hNrjJMaVhiZEuHE=;
	b=PPUl49i+7NL/QVvzTkv5oQjcPgshOGCSDxQagvw3DTLFvBv82BV+k54uuDBe9nbRcNXo2d
	hisqysF1sOJjfB89Oc06laVvprUi+zQ79MssBxBh5mQ95tYjNmTXtSRI2LSGiwE2oDhkW/
	kdxFYqYpzmsONGgzRKnNrlR5ybMbODq+1SpX1BcnXyG3QXee8h7Gy39CnJei4w4rKCveu7
	B2ND3URuDcfprMIGXuInRg80a4qcyDX+lCy9a08x5h9ZpiMe4+s5xk6QFAE50luGV2nr91
	jIkuY4AWaqvKiAjfZjvQKYJY83t53WvcWSXZqpyzERxATdI67lRGvzX9s5IIcQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] ASoC: fsl: fsl_qmc_audio: Remove the logging when parsing channels
Date: Thu,  3 Oct 2024 14:20:15 +0200
Message-ID: <20241003122015.677681-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On each channel parsing, a log message is issued. This log message is
not needed and become annoying when many channels are used (up to 64
channel supported).

Simply remove this unneeded log message.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 8668abd35208..e257b8adafe0 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -838,8 +838,6 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 				qmc_dai->id, i, ret);
 			return ret;
 		}
-		dev_info(qmc_audio->dev, "dai %d QMC channel %d mode %d, nb_tx_ts %u, nb_rx_ts %u\n",
-			 qmc_dai->id, i, info.mode, info.nb_tx_ts, info.nb_rx_ts);
 
 		if (info.mode != QMC_TRANSPARENT) {
 			dev_err(qmc_audio->dev, "dai %d QMC chan %d mode %d is not QMC_TRANSPARENT\n",
-- 
2.46.1


