Return-Path: <linux-kernel+bounces-336741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFE984014
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C4A2840FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DA14A639;
	Tue, 24 Sep 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TcVn2Sdm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27A1C32;
	Tue, 24 Sep 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165606; cv=none; b=BPeLv2r0TLFLzBh1wU295bVK0XmjwVdIOxXpMc4tYPAjlt5GZfE5+ilEuVm+oWtY7AMPMb2kKw0zMlPqrGSpmMcesNWuOjWJJEw2ABLc7Y7/mI1//qoQhDtKtA7zFEGLvRAdjy4Tjdo8as4jV3Z0AQFGQNuk61MnrDKEBVbLw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165606; c=relaxed/simple;
	bh=GZc63eXCJHLz2doVRvuGzvZovQYn0B8xHq46bwGnFE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HV52QFDCIlb3orTrSZZFwnqCjTm64WqywK1wo4l57kSHaKEEjvdKnICBrmMUz9naMkBPB3pm2hyLdu9QSbK5pLMT9eearxkjwqY/prMN5iHtSJ6YKo2MHj/9yUZKL3RTLmQKSzXfKPL7uxlD8wsU5pBxJ5DQ2rXFYXI9WZlcduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TcVn2Sdm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727165604; x=1758701604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GZc63eXCJHLz2doVRvuGzvZovQYn0B8xHq46bwGnFE4=;
  b=TcVn2SdmNHc8IRo7qJzJSxzCexNSOr3dF1keIJ24Szlo4bi805OlUQK8
   w4tagHycUFzZPQJ4acIb0FERp/MN+gOtHiTCEK/n5vQAuhKR0pKOF5ukT
   uBzpMmrCkWlksR/yHbStJ68mnqGAfGZmqJG7r27PtJA7grvzT/Lezmxoe
   gjL6N0virqaU5yqCGVO8N81eM5yjllzTL+UmLE8cfSe7qAYa/v8z+Jhck
   p8TyyUtJE/JEwtNTnIXrBvb79El3cqcZpTeJ69FsbMGPregqM8B7fYEtn
   FnInUGqg/PFsx4AyHIqevJ9265Z8AXpBfpPK6UDkQinYYrufr6ufDAoLf
   g==;
X-CSE-ConnectionGUID: az7ICeymT/y/jLAHNtXqzg==
X-CSE-MsgGUID: qObPW9fWTl6T45AWPAfa/g==
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="32031723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2024 01:13:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 24 Sep 2024 01:12:59 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 24 Sep 2024 01:12:57 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH] ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized
Date: Tue, 24 Sep 2024 11:12:38 +0300
Message-ID: <20240924081237.50046-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the driver to prevent alsa-restore.service from failing when
reading data from /var/lib/alsa/asound.state at boot. Ensure that the
restoration of ALSA mixer configurations is skipped if substream->runtime
is NULL.

Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 939cd44ebc8a..06dc3c48e7e8 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -302,6 +302,9 @@ static int mchp_pdmc_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	if (!substream)
 		return -ENODEV;
 
+	if (!substream->runtime)
+		return 0; /* just for avoiding error from alsactl restore */
+
 	map = mchp_pdmc_chmap_get(substream, info);
 	if (!map)
 		return -EINVAL;

base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
-- 
2.34.1


