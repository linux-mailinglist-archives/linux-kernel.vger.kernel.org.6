Return-Path: <linux-kernel+bounces-222274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEDF90FF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E291C22F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9719DFA5;
	Thu, 20 Jun 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FFr+/Gbn"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495D19B3EC;
	Thu, 20 Jun 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873000; cv=none; b=FKVKk7dR9QFZNgNsnUR95lpFckjvoY3X3G71/1IbG2706Vjo+u1wdSaCS9XR7udEQ5QzfXviwa8uN3NBvjLfcKpOhGKLgFufmm3qeXB8hdNdQpMLA80gzH7J2yRTislsU9lQctwl5Or+Zjve8SVAuA2T1eLzhn/EjGgoV3cNrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873000; c=relaxed/simple;
	bh=tYtDaVenY5VhTlX/bH/FbzM2s8oP7yy7scmWE/99cFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VKI9cxQUHDwdD4542E0RLQZmYzraYpM3cOzQGP9BVWeCLlaAfZ8lS/CbzP1ZhSDQbZ88ALAuCdvvr00KVzgc+221Tr0G+RrrM69aux8PogGkUMsx08kW4wIQ27T/7zGCx+7FbYpVXfQLKgQ/bzh4Sa2PAaBfknq/H1+zW7w7+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FFr+/Gbn; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 330E420002;
	Thu, 20 Jun 2024 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bcqP/4Bzw72Fti9Nz8gpJCdKx5nEIN7PgHfX5LT8OWo=;
	b=FFr+/GbnH9ugA6vdC2XhsIiie53JB2O3yt0rQvNGeMUg6zk4l5chVUH9dQD0HK7vVqVyQW
	CJuKRnK1foti8pk66vu8/eMEweBo6Mfg7aFpaPg6Q7UNAoFLWYcXJJrPIy6KGZoiQ13O0C
	Ch/jW7WE6LMqOi+rGfas7LsauYvJIu9U4otaSfL+GR7UOi4jFDFySQlOzVHZuVODUSxQrr
	/DrAYd/jVD45bHbi+5InmQs1QYLxBU4EpbHUxCQkLD0nnlXdgsDFyZ1R95XQCDS2jRXRjA
	a7IdT/cUeRjXFX1TKmYiEO9MXrbI2P0i4maX4vQKgIJiLdJcuUTR3tM5Z6GYTQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 00/10] Add support for non-interleaved mode in qmc_audio
Date: Thu, 20 Jun 2024 10:42:47 +0200
Message-ID: <20240620084300.397853-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The qmc_audio driver supports only audio in interleaved mode.
Non-interleaved mode can be easily supported using several QMC channel
per DAI. In that case, data related to ch0 are sent to (received from)
the first QMC channel, data related to ch1 use the next QMC channel and
so on up to the last channel.

In terms of constraints and settings, the interleaved and
non-interleaved modes are slightly different.

In interleaved mode:
  - The sample size should fit in the number of time-slots available for
    the QMC channel.
  - The number of audio channels should fit in the number of time-slots
    (taking into account the sample size) available for the QMC channel.

In non-interleaved mode:
  - The number of audio channels is the number of available QMC
    channels.
  - Each QMC channel should have the same number of time-slots.
  - The sample size equals the number of time-slots of one QMC channel.

This series add support for the non-interleaved mode in the qmc_audio
driver and is composed of the following parts:
  - Patches 1 and 2: Fix some issues in the qmc_audio
  - Patches 3 to 6: Prepare qmc_audio for the non-interleaved mode
  - Patches 7 and 8: Extend the QMC driver API
  - Patches 9 and 10: The support for non-interleaved mode itself

Best regards,
Hervé

Herve Codina (10):
  ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
  ASoC: fsl: fsl_qmc_audio: Fix issues detected by checkpatch
  ASoC: fsl: fsl_qmc_audio: Split channel buffer and PCM pointer
    handling
  ASoC: fsl: fsl_qmc_audio: Identify the QMC channel involved in
    completion routines
  ASoC: fsl: fsl_qmc_audio: Introduce
    qmc_audio_pcm_{read,write}_submit()
  ASoC: fsl: fsl_qmc_audio: Introduce qmc_dai_constraints_interleaved()
  soc: fsl: cpm1: qmc: Introduce functions to get a channel from a
    phandle list
  soc: fsl: cpm1: qmc: Introduce qmc_chan_count_phandles()
  dt-bindings: sound: fsl,qmc-audio: Add support for multiple QMC
    channels per DAI
  ASoC: fsl: fsl_qmc_audio: Add support for non-interleaved mode.

 .../bindings/sound/fsl,qmc-audio.yaml         |  41 +-
 drivers/soc/fsl/qe/qmc.c                      |  32 +-
 include/soc/fsl/qe/qmc.h                      |  27 +-
 sound/soc/fsl/fsl_qmc_audio.c                 | 590 +++++++++++++-----
 4 files changed, 505 insertions(+), 185 deletions(-)

-- 
2.45.0


