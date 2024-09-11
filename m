Return-Path: <linux-kernel+bounces-324900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F9975254
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C221F277A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459A19CC08;
	Wed, 11 Sep 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kru/eQBk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F1192B9F;
	Wed, 11 Sep 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057815; cv=none; b=D5fStNVL0yfa0FRLk8+fUiBeWkqZ2TPrFwoJ0yUBLmsMAk9JUmU48Ea/bOYbSHgLU2cmnETjuYe+0IkXeKcLYGoWbqVsW2cBR5wUGhigjAdQZI4aLoOchN1fvIyaUNZvA/OpWK9jnGliz4xRa2ASX5v44jIrz4YsJeu9ONCDfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057815; c=relaxed/simple;
	bh=TxWkOdseiNx1bafVcVq7iqdfmlO4X8zdBrM+WKyic7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSZsPDTr5Y9q50DPTM59JoTFUnMCVVo0mnWTpbxFv18WSJvVokkwR4ZFjyAGNwsrcE5DP/F6DvDwk7ufmPdq8BASsLOWRegaC+2BOe/ED14NQUFlW55lFfOl+YHO3dXdMhNvkh+Vf2DBRBK544B2didkRmZ1MgnysITubNv8/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kru/eQBk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726057813; x=1757593813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxWkOdseiNx1bafVcVq7iqdfmlO4X8zdBrM+WKyic7w=;
  b=Kru/eQBkePBS2sgtOSfuHlWurKFLZTri/MWt1p+TtoTNnTInlGWw1PY+
   p3XkKMOdNsByOgpBiJ1qEAlgIIXGDDT2dyU8JUR9kZuaa5leCMSSX+cxN
   F9zIOd3ihTKhFQdIxoESf+zyNFvgX5mKvQT+BRSWrmmuRxURJQGe43cAK
   Z3zTR/yCeBlZPVL63iMqeCrxd4S9wK6RFjPCWDCLIPvrIr1eWh3IHOY/u
   5n/lm/woD8R/O1jl8gyQRvyAJtCBd76zozUcXryckmfWyRjXF11KmPH62
   Cl4GVqnMSyKvYGWqBZ/PaSW+ZoypG95DB2Q4dou4vrdekoUZZHeqleM7D
   g==;
X-CSE-ConnectionGUID: TYXepcQqR+aekZWbFABIig==
X-CSE-MsgGUID: h6+wpwAeSbmE8OyH4DEEtQ==
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="31538368"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 05:30:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 05:29:20 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 05:29:17 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 2/3] ASoC: atmel: mchp-pdmc: Add snd_soc_dai_driver name
Date: Wed, 11 Sep 2024 15:29:08 +0300
Message-ID: <20240911122909.133399-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122909.133399-1-andrei.simion@microchip.com>
References: <20240911122909.133399-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Set snd_soc_dai_driver name to improve controller's display of the DAI
name.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 7a5585839c1d..d97d153ee375 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -777,6 +777,7 @@ static const struct snd_soc_dai_ops mchp_pdmc_dai_ops = {
 };
 
 static struct snd_soc_dai_driver mchp_pdmc_dai = {
+	.name	= "mchp-pdmc",
 	.capture = {
 		.stream_name	= "Capture",
 		.channels_min	= 1,
-- 
2.34.1


