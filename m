Return-Path: <linux-kernel+bounces-545631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D53A4EF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF18A188F723
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5837259CB9;
	Tue,  4 Mar 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iWVWc1gj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC61E3DF4;
	Tue,  4 Mar 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124160; cv=none; b=Ddq+kc7pO3kQ7v4QXKk6f0e3a6Xa4wN0V7EYh9SN5gIaCeW57azDwz1qSiZGvbczq0A3olW/pjWs0OFJBzgTM9+qGTq6vuaqnEuL9sj78zFNDab3tIiYp/wv/+Q0OLExjaqHJc6BYzglYWrWIKPPhZV7kdDU2RGN68LWOu9BbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124160; c=relaxed/simple;
	bh=6Bc7g4mKArhcl6kXe95ybV+LNzHSc7Zsr7451OcuWLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q96wume7lqs/UHgdlXJp/gbRqJSQUH2mbKuBauc7H6SDvCkkPjoctMlehgw9+XF7IomDCiXHImk8gW7vS4eA+xUlVAyhebnHcSCw+klLJybojXJy1YFgWA4lXwlEfPEHsIkNwH7SeWcA1RQXT2w2cJC7pdqY+auDeC0iw2StOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iWVWc1gj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741124156;
	bh=6Bc7g4mKArhcl6kXe95ybV+LNzHSc7Zsr7451OcuWLY=;
	h=From:Subject:Date:To:Cc:From;
	b=iWVWc1gj0oidP3d8c6SPfKkJ2A5uSWUUU9U095jDfR+GjEzusAcOqGNJhjLGXbeg3
	 /NKOt7hJ9awU/+/Rt3budT5uf8iNdUF8sob0ppjb/4/WwcR4iYsB0MUlAYGsNLp1W0
	 P7/vG+suixChc5YWbKaYMI4cp44iFUiZ3q0iiU3e22O7iJNnfr7e9DV6wKSkNUQibq
	 daXaAZPYLOJGlUIluYVXRq8f5l5N2vV4/OSv65j0a8W8QIqr1rdjgmuVMCKG0tE7Uc
	 y31yE9tI1KDYOd69NBp/j0CAWVBFEWgzRX9fZgzwepaJA2z/KbLNhWj1Xh5lM3VnFh
	 iCacrWb4vDlsA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 46EFE17E088C;
	Tue,  4 Mar 2025 22:35:52 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/3] Allow retrieving accessory detection reference on
 MT8188
Date: Tue, 04 Mar 2025 18:35:35 -0300
Message-Id: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACdyx2cC/3XMSw7CIBSF4a00dywGKBjiyH2YDnhc7U3aYoAQT
 cPexc4d/ic53w4ZE2GG67BDwkqZ4tZDngbws92eyCj0Bsml5lIothYjjGHW+4CFqYDWOaP1qAL
 0zyvhg96Hd596z5RLTJ+Dr+K3/pOqYJxdnAtambGD7ubjslgXkz37uMLUWvsCB8HLMa4AAAA=
X-Change-ID: 20250214-mt8188-accdet-4deabb85534d
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Zoran Zhan <zoran.zhan@mediatek.com>
X-Mailer: b4 0.14.2

This series enables the MT8188-MT6359 sound driver to retrieve the
MT6359 ACCDET sound component from a mediatek,accdet DT property, which
allows detecting jack insertion/removal.

Patch 1 describes the new property in the binding. Patch 2 implements
the sound component retrieval in the common MTK soundcard driver. Patch
3 updates the MT8188-MT6359 sound driver to register the audio jack and
initialize the ACCDET driver for detection, if the property is present.

Tested on the Genio 700 EVK board.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Added CONFIG_SND_SOC_MT6359_ACCDET select in
  CONFIG_SND_SOC_MT8188_MT6359 to avoid build failure
- Clarified in mediatek,accdet dt-binding and commit description that
  the property should only be present if the accdet is actually used
- Link to v1: https://lore.kernel.org/r/20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com

---
Nícolas F. R. A. Prado (3):
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      ASoC: mediatek: common: Handle mediatek,accdet property
      ASoC: mediatek: mt8188-mt6359: Add accdet headset jack detect support

 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |  8 ++++
 sound/soc/mediatek/Kconfig                         |  1 +
 sound/soc/mediatek/common/mtk-soc-card.h           |  1 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   | 15 +++++++-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          | 43 ++++++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250214-mt8188-accdet-4deabb85534d

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


