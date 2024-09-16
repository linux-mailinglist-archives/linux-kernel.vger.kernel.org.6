Return-Path: <linux-kernel+bounces-330695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4697A2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A1BB23549
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDA156220;
	Mon, 16 Sep 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bvhUppNL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C2155322;
	Mon, 16 Sep 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492818; cv=none; b=rfs4GBrJbOeZ1BXmLnkI2fpQjGLti7CPaVpZ627HNde4a15BTqBv9Kvfyhah1C2IgHGdhCsR208ogzlkb188UNwaLWvNghhct4PLoaAw07jipx9rk0abx5Gc5vAdfg98QksWE8Bo5eYSlhc6GzGFzKdE2bOFnn92P30lbrdkJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492818; c=relaxed/simple;
	bh=LtyrK8rT+ddKnOKr4OAF9a6sJB7r1UWxYnOf39Qe6Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5IqTV96G7SfZT4L7FpE3xdqSswfv1sWOaBJW1tHWrqoW4aNqBMDMatjTU/+WjnjtlJlp2AkC+IedqF61z7M+efaTnT2WiBv2v2KhvEb34bqkFDeFcfYy30aZ/nl1gU8P142zvhhL3WZqbXaoIE/V52quOtZ9TTlS85dWyCExY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bvhUppNL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726492817; x=1758028817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LtyrK8rT+ddKnOKr4OAF9a6sJB7r1UWxYnOf39Qe6Bg=;
  b=bvhUppNLtxRVPqBDMp2I/l4lJ0AKouLzKT22cylL/gU/Y83av7/l1vTt
   YkPQGHIvyjfz6kRz3+QQWslGjZK7Gu1SkXBe/RRrayiMfYFVWlBew/e77
   NrUcUVPVVG9Rh0rSJqUz1IadFynrA/IzZXeJDWmhSmnPeV2av54KHh8zu
   ciakB/AF9mLXX0gHwbSKFyq2bW1eHqcmWrs6CrFrILkLi8BxZTxPaU8ox
   /x1FIEbnHCTSq79Hp0WFcbvVHnI+9+ewZYqrMnyU4EwE7d0qs0PBaGRrz
   VeFL1wIKoKqaLnXNTkAvQNntnDaxZEk62rp6WBcvAz+CTmCa/XAjM8gGF
   Q==;
X-CSE-ConnectionGUID: 50Z/Q3YNQtGxx5+pLOGVZA==
X-CSE-MsgGUID: UsZZD4kASkGvuL/uCyRMpQ==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="262829818"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 06:20:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 06:19:35 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 06:19:32 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH v2 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel limitation
Date: Mon, 16 Sep 2024 16:19:10 +0300
Message-ID: <20240916131910.22680-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916131910.22680-1-andrei.simion@microchip.com>
References: <20240916131910.22680-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Drop S24_LE format because it is not supported if more than 2 channels
(of TDM slots) are used. This limitation makes it impractical for use cases
requiring more than 2 TDM slots, leading to potential issues in
multi-channel configurations.

[andrei.simion@microchip.com: Reword the commit title and the commit
message. Add code comment to explain the removed code.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- add code comment to explain why S24_LE is dropped.
---
 sound/soc/atmel/atmel_ssc_dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7047f17fe7a8..89098f41679c 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -821,8 +821,9 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
 	return 0;
 }
 
+/* S24_LE is not supported if more than 2 channels (of TDM slots) are used. */
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
-			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+			   SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 	.startup	= atmel_ssc_startup,
-- 
2.34.1


