Return-Path: <linux-kernel+bounces-549773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63FA55723
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A003B483E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DD271805;
	Thu,  6 Mar 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ULhzr1vT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5E2702C9;
	Thu,  6 Mar 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290785; cv=none; b=Sli1E1Fv91j1svC1kYNr8/Z5AJ52ITbkLdYxLVHx6aW3eG5VfDG3zosypwKEeTN14biUs4Hs6uU3gA3sbKyZb8jsZxK7Px48dZRXjICStICeF+3R0JYxe/lgmdDEZTAHUaU1jDJ+36cp4nRV+23wSokHn/67HKyPSdI+lml/ReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290785; c=relaxed/simple;
	bh=THLL9GRCC/mdZVhYAu4WvqtH//t83+D8LP8VEW2/MCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dvCEKA7uvDsDjSu3KYsM8C0IAWmD/0Yux96KpLyetMhj87Skv63dc+EcTHyAOelJYKPKMfkxaDX3sWY6uHTCcJu4hGLU0mGzooAKC+ggwK6xy7nWVtuhH43g5dSkuC5EsfeET0CoaKQzHbGn8iVArWH1YlEemsvy/aPZBYL3Q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ULhzr1vT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741290781;
	bh=THLL9GRCC/mdZVhYAu4WvqtH//t83+D8LP8VEW2/MCI=;
	h=From:Subject:Date:To:Cc:From;
	b=ULhzr1vTcKtMjk7jHA5AFs1TaLkRf2ZQ9IO4AWKWTgNhMGZNgAgOu5RCVNkm6MzvI
	 4MxSvsQkJv1GUtBmdHl2OCwTMe4bzhBT9omt3uU5NgugU2tKmOUsJMiDt+ZnofhhIr
	 2DvNL4Rrh68HatRAT3krS5gTbQwf6eLv32ldetMiR0KRafwebUWYMry5PeN8kGm0Hm
	 kMQRo36DjNg2rxrJ/OiD2hZ0f7horZVoh5KrGleizwqMP6/R4R9RwewcHNaF0/dK7B
	 sgHEYlqp+EgiFwmIczU4TEHJ+DiliEtT3+2lqT7yxjG1kQytDRE5W7C3pNbPLst3tM
	 8/YXfmLp/0pGA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B3F717E05F7;
	Thu,  6 Mar 2025 20:52:57 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 0/4] Allow retrieving accessory detection reference on
 MT8188
Date: Thu, 06 Mar 2025 16:52:14 -0300
Message-Id: <20250306-mt8188-accdet-v3-0-7828e835ff4b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO78yWcC/3XMSwrCMBSF4a3IHRvJs0ZH7kMc5HFrA20jSQlK6
 d5NOxEUh/+B882QMQXMcN7NkLCEHOJYQ+x34Doz3pEEXxs45YpyJskwaaY1Mc55nIj0aKzVSgn
 poX4eCdvw3LzrrXYX8hTTa+MLW9d/UmGEksZar6QWFbQXF/ve2JjMwcUBVq3wjyDoj8CrwI+tP
 DVOGvT4LSzL8gbrITv38AAAAA==
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
4 updates the MT8188-MT6359 sound driver to register the audio jack and
initialize the ACCDET driver for detection, if the property is present.

Patch 3 adds a stub to prevent a linker failure in case the
MT6359-ACCDET config is disabled.

Tested on the Genio 700 EVK board.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v3:
- Removed the config select for CONFIG_SND_SOC_MT6359_ACCDET
- Added patch 3 with stub for mt6359_accdet_enable_jack_detect()
- Fixed return checks for mediatek,accdet handling to check for non-null
  rather than !IS_ERR(), and added error messages
- Link to v2: https://lore.kernel.org/r/20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com

Changes in v2:
- Added CONFIG_SND_SOC_MT6359_ACCDET select in
  CONFIG_SND_SOC_MT8188_MT6359 to avoid build failure
- Clarified in mediatek,accdet dt-binding and commit description that
  the property should only be present if the accdet is actually used
- Link to v1: https://lore.kernel.org/r/20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com

---
Nícolas F. R. A. Prado (4):
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      ASoC: mediatek: common: Handle mediatek,accdet property
      ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect
      ASoC: mediatek: mt8188-mt6359: Add accdet headset jack detect support

 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |  8 ++++
 sound/soc/codecs/mt6359-accdet.h                   |  9 +++++
 sound/soc/mediatek/common/mtk-soc-card.h           |  1 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   | 19 +++++++++-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          | 43 ++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)
---
base-commit: 565351ae7e0cee80e9b5ed84452a5b13644ffc4d
change-id: 20250214-mt8188-accdet-4deabb85534d

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


