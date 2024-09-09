Return-Path: <linux-kernel+bounces-320933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADD971235
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1092839D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18871B1D65;
	Mon,  9 Sep 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fTyBBGoR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22691B1414;
	Mon,  9 Sep 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870969; cv=none; b=iy7CAN6yEfCWWy0hxETg902XklILknrBk1SmvgeJ6XhiZg3XWvCTSA1v593uMAAI1eMSxdocuFwGg7XVp3HeLvj71mB+7w/aehZj+ibGjr5Ll1u6gWKEHtn6oIpnQS0K6CJ+dFgFVN1etJ06qyCVhNMgXFwhazPPTu8guoT5cjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870969; c=relaxed/simple;
	bh=n/pIzbx0MgOH7Vt1ursNZ7uh5AqRZVYjSubczslHHrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8GmPVx50cKqfFbSvRJWNCBWe/S+ImFs26pNYoSikcNzfeYqyWKHy2PerDnLK2hiAzaJ8CVC6de0DBbf/SI1Nl5OhVVPD6XRNGSjCW/e7i439kSIRcecbewJHObfu5S2J9wF+Y/k+Z4Dqlz7b8xf0G6oOzISG/vgvy0e/ffeE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fTyBBGoR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870967; x=1757406967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/pIzbx0MgOH7Vt1ursNZ7uh5AqRZVYjSubczslHHrQ=;
  b=fTyBBGoRHREwoELIHcQQr/WG73RNt3tMSlwlb9ViaAhLat8BzQvy/fym
   O+tXThxhAJl06sCeN0S3vJqne+eCKb71oof5W2a1QtYuvpv+ppFl+tshW
   IdgDuceBEcOohP7ciXbKOXSvoDaN1SI8UXnQwSvPOM1zzboeuqC2pUjbZ
   MehMMlToTwwjsFb2wc2RjUTF5OsvQo/wdDdKlZtIDBNyMFUSu3C1qynBA
   LfcSWbeqD5CA0T0EGXwKiiaw6eRFiiilxKNw5yh6KvpsdwpjpG0zr26db
   Q5kqLwjDAT8o+msGyyndOPH6H34HAgeTO1psOUr8dCxCVeo+hsgz4g9/I
   w==;
X-CSE-ConnectionGUID: 3+qBZ8ypT7qJuXQunlVkIA==
X-CSE-MsgGUID: q5fUTtzfSs+p1sYbOgJ7MQ==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="198940348"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:36:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:35:45 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:35:41 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 1/2] ASoC: atmel: mchp-i2s-mcc: Remove interface name from stream_name
Date: Mon, 9 Sep 2024 11:35:29 +0300
Message-ID: <20240909083530.14695-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909083530.14695-1-andrei.simion@microchip.com>
References: <20240909083530.14695-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Remove the interface name from the stream_name. The interface name (and the
index of the interface) can be set in DT using the sound-name-prefix string
property.

[andrei.simion@microchip: Adjust the commit title]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 35a56b266b8d..f40508668ac5 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -936,14 +936,14 @@ static const struct snd_soc_dai_ops mchp_i2s_mcc_dai_ops = {
 
 static struct snd_soc_dai_driver mchp_i2s_mcc_dai = {
 	.playback = {
-		.stream_name = "I2SMCC-Playback",
+		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = MCHP_I2SMCC_RATES,
 		.formats = MCHP_I2SMCC_FORMATS,
 	},
 	.capture = {
-		.stream_name = "I2SMCC-Capture",
+		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = MCHP_I2SMCC_RATES,
-- 
2.34.1


