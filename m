Return-Path: <linux-kernel+bounces-520477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C45A3AA54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63391884753
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887F1D61B7;
	Tue, 18 Feb 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oov72omc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B061CBA02;
	Tue, 18 Feb 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912090; cv=none; b=rnQMF9LcPKjN/nk9pVeli1ZvtszefRVf3vYUGlQ/xMRU2kIWwJG6842jORTYCd+j34UMrCGiZjEwjeekrJlBmiymEa1a+ybltlzHwMttUCYy8JjhtV0QxIrEVLE6Osf7Oiq52v2c05/FDk0TwZ8mo5Y9B4iu6/xKzctZMC/dTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912090; c=relaxed/simple;
	bh=vBUNOnqBjWLVeVhdw5eyFkY+aGATqfPN9HO6x7rP1xQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SGwZJ6A/NGzaRJLbOWYFlEdsE3tO09TUfwq0Au7OnncJFEsnPU5Svq804R6KKc6MW7jUv8gSlJgaoAZ997JTP6tiyrEWsn5QOTD/pxOo0n7HozreaC9UKr7raeA6uE7zkxHZbklLjq966fqyNLEvJEHrKWnyqHBXm+M/swhR6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oov72omc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912086;
	bh=vBUNOnqBjWLVeVhdw5eyFkY+aGATqfPN9HO6x7rP1xQ=;
	h=From:Subject:Date:To:Cc:From;
	b=Oov72omcTiL2NCLqUyV3GmRpH9qXVL5qb++fQxd+V3RpbhP0471n2V89tvSsscYL3
	 JwXtOrBPi+olWxGGKsp/A7yiWdZN0Gm5OTb1Pmp96imUQjMSQzEL9Q9ISZikWrg3Hz
	 p9sbhufnM4vN4o8rAJ6l77rF2Ma4w0uSYGG4hu7FF41BmXA50wzYzSK8ir9+UYQxF2
	 2XXLJNdJFNrqvQiN5DwO/N7AcFFbWQ1b96GAVCoZKjyj9eVMeZg030/4LnYmY4dQ9Z
	 XVigbWNBCMKABwx3jTsgUiekHp5FTit9Q4YTYdsnT57pPxuLP7AvXwdcIX/CeUptQ0
	 I3kXwAFhGMsWw==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 809A717E154A;
	Tue, 18 Feb 2025 21:54:42 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/6] Enable DMIC for Genio 700/510 EVK
Date: Tue, 18 Feb 2025 17:52:13 -0300
Message-Id: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP3ytGcC/x3MQQqAIBBA0avIrBNGI7OuEi1CJ5tFGgoRSHdPW
 r7F/xUKZaYCs6iQ6ebCKTaoToA7thhIsm8GjXpArawMFDmNiNKf7KR3hmjyDk1voTVXpp2f/7e
 s7/sBChFmqF8AAAA=
X-Change-ID: 20250218-genio700-dmic-dc6ee9dc0638
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

This series enables the dual digital microphones present on the Genio
700 and 510 EVK boards.

Patches 1 and 2 add some required clocks, patch 3 adds the DMIC DAI
driver for MT8188, patch 4 adds the DMIC routes for the MT8188 platform,
patch 5 adds the DMIC backend and widget to the mt8188-6359 machine
sound driver and patch 6 adds the audio routes for the DMIC to the
Devicetree.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (4):
      ASoC: mediatek: mt8188: Add audsys hires clocks
      ASoC: mediatek: mt8188: Add reference for dmic clocks
      ASoC: mediatek: mt8188-mt6359: Add DMIC
      arm64: dts: mediatek: mt8390-genio-common: Add routes for DMIC

parkeryang (2):
      ASoC: mediatek: mt8188: Add DMIC DAI driver
      ASoC: mediatek: mt8188: Support DMIC in AFE

 .../boot/dts/mediatek/mt8390-genio-common.dtsi     |   6 +-
 sound/soc/mediatek/mt8188/Makefile                 |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |   8 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h         |   8 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h      |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |  28 +-
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |   4 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h    |   4 +
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c        | 754 +++++++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |  14 +
 sound/soc/mediatek/mt8188/mt8188-reg.h             |  18 +-
 11 files changed, 839 insertions(+), 7 deletions(-)
---
base-commit: 253c82b3a2cec22bf9db65645f934fbe095899a3
change-id: 20250218-genio700-dmic-dc6ee9dc0638

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


