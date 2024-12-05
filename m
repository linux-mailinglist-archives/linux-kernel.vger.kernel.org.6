Return-Path: <linux-kernel+bounces-433208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992CF9E5526
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79643166E56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40A217F47;
	Thu,  5 Dec 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rw5SYxew"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBE217F3E;
	Thu,  5 Dec 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400911; cv=none; b=KovlJ+R6Hxspozn4Y8mUO6P8BZ77Li4T9cjExvPhU4WmhosrsdhNqcBKk/WAptFAuNup/bPrqPT2M/lMjGp/cBR5mRfrAmpSkacqARxwmgi3T8b5T42lRh6Ht9Ci4Umq1Dq2sHxBlcgFxgpZ5rKhwDTgk5uunSXeSjERQNyERfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400911; c=relaxed/simple;
	bh=SOT2XbAmTovuMmADv2M5zsZ8pRjumedPkWS8520ru+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cDvsY4YqtmFubxp2lpAYWysuYaNKBsIQvYwWNXM/iQxgl4WkTVh22rxBfUCs5QR6mGNpnQVhdrhJybp21+JfUceNpTCCA5u+n+5em7l6JxZMrJIwGKANZAEIRjerLVreuItuOwT5Co/ZWNlx7fkjrglHL7zeDHQs1/4bMOzLflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rw5SYxew; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733400908;
	bh=SOT2XbAmTovuMmADv2M5zsZ8pRjumedPkWS8520ru+c=;
	h=From:Subject:Date:To:Cc:From;
	b=Rw5SYxew0a3AzM1MXPFTKjaur2JoIFireNzPSAT3mOvo7grIQ4XZezYewB3T5P0jI
	 fJZun3YpgG2N1uZ0fGV7O+43P+cSFf0s5jCAFjeAVtjOBK7STvEEKhqjkiXDov1AXL
	 IAdJ8G1AXHdfwiJOHj6JXvuP8MFwwaHD9e/xCXowr5y2/s/Js5myhLjZ4uGH/5+ADK
	 g89Xa+9+Giu41dpsqyZMr+lRBuRcOg0Pnjiq08me+1g0ecmQMVL/zhtHmW2pSVE4MH
	 LvcWLsTT34CucBMoSixvYRHhpr+/XU+BE0F+82pnIv/RRnHdL8ZuFt1Bstr29NBr8Y
	 CEEsyqsbcTOJA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 29C1217E363B;
	Thu,  5 Dec 2024 13:15:03 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/5] Enable audio output for Genio 700 EVK board
Date: Thu, 05 Dec 2024 09:13:53 -0300
Message-Id: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAGZUWcC/x3MPQqAMAxA4atIZgNpERSvIg7VppqlLf0RQby7x
 fEb3nsgcxLOMHcPJL4kS/ANqu9gP40/GMU2gyY9KE0DHuwljERoqpWAoZZYC7rNTE7zZqwiaG1
 M7OT+v8v6vh+jq/a2ZwAAAA==
X-Change-ID: 20241204-genio700-audio-output-fba8f2ebad10
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

This series enables audio output support for the Genio 700 EVK board.
Patches 1-4 do the required binding and DT changes, and patch 5
describes the audio DT nodes to get audio output working on the two
audio jacks, Earphone and Speaker, present on the board.

The standalone fix in [1] is required in addition to this series in
order to get the sound card probing.

[1] https://lore.kernel.org/all/20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (5):
      arm64: dts: mt6359: Add #sound-dai-cells property
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add compatible for mt8390 evk
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DSP properties
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Allow DL_SRC/UL_SRC dai-links
      arm64: dts: mediatek: mt8390-genio-700-evk: Add sound output support

 .../bindings/sound/mediatek,mt8188-mt6359.yaml     | 26 ++++++++---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |  1 +
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 50 ++++++++++++++++++++++
 3 files changed, 72 insertions(+), 5 deletions(-)
---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241204-genio700-audio-output-fba8f2ebad10

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


