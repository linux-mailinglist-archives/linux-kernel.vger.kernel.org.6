Return-Path: <linux-kernel+bounces-515169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519BA36133
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B227A5A71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC49266EE3;
	Fri, 14 Feb 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JJHA0bKo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAF4D8C8;
	Fri, 14 Feb 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546112; cv=none; b=Qpv430EByG9SDltxEKkhURiBls+7GD7E016kUDlpVMa43noU895cPHXwZBsXwjsj70cpvAZCfo2CPNFLD487yl6xZ+J1bX+pRPgnA6z6R13oqKJnug8/hvSkTk71h5FuXzDXNp0ndJe4YPMFhtlUbnXQqtgCdxS1kWzE/Mbos9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546112; c=relaxed/simple;
	bh=1cUFcziT3zrnD+e35Cx7WF4WHOMgoKt3qtHlcGUUGnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ssHh46KLy8GXYV80mxkA27BIcP0jiz36pgd0Ae450kz/7Db31DQ1ErOQaaPVfv/Lkc4ip9FDB9K1OXP5d+dARm5S7hZuKibOBisLXB51uieOvvBTdj4zA5y4yn2LJ72qsKEWfKWsVdMnGnXhV+Obsao8b94XAhgLSxeOD6Wf9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JJHA0bKo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739546101;
	bh=1cUFcziT3zrnD+e35Cx7WF4WHOMgoKt3qtHlcGUUGnQ=;
	h=From:Subject:Date:To:Cc:From;
	b=JJHA0bKog9zGlUr7gL/WMoMeolufzIwP8ZGvn3AUoqgFT8um3Kdoa9j8QFsDRjMv+
	 OZOdXFEVUXsb1m9dadA+4DPzH9VsDVweFx3105N9PZLNL2VXChq+5UW0KrF2hpGQYD
	 Beql8elsN8f72k8rCxqPg9EMfJd/tc0o6MakV94fFXXw+3GS+bpwb/stOvUOoxE/Ky
	 VuMJIj+Amfbog5LIixjVRWOBV8FVn8so4LHO9pavtbDpACjFqxX4KHuqjxXOFdniGD
	 Dxne1f81sthen5pOSWhKOoBpahrI7K5u+xOd63jc7A9DTwCs5c1ZnMIlpVjE5ZNgKg
	 T7guYNRz4tWFw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B46C317E0ECF;
	Fri, 14 Feb 2025 16:14:57 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/3] Allow retrieving accessory detection reference on
 MT8188
Date: Fri, 14 Feb 2025 12:14:28 -0300
Message-Id: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANRdr2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MT3dwSC0MLC93E5OSU1BJdk5TUxKQkC1NTY5MUJaCegqLUtMwKsHn
 RsbW1ANH1iY9fAAAA
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
Nícolas F. R. A. Prado (3):
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,accdet
      ASoC: mediatek: common: Handle mediatek,accdet property
      ASoC: mediatek: mt8188-mt6359: Add headset jack detect support

 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |  6 +++
 sound/soc/mediatek/common/mtk-soc-card.h           |  1 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   | 15 +++++++-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          | 43 ++++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)
---
base-commit: 7a6b5c348058d075ce0b20710f027a055d33a71d
change-id: 20250214-mt8188-accdet-4deabb85534d

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


