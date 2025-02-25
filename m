Return-Path: <linux-kernel+bounces-531629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023CA442E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D060D3A53B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D7526B080;
	Tue, 25 Feb 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mieflFWp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B962673BC;
	Tue, 25 Feb 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494105; cv=none; b=nioc33AIN9I4GGKCgQlpPeHVlD634DnFqJuwX+BniKqti9Lofq48lbZiGYTn2F832lrbDJar8gIcb37sOoYSPvSF7NFuAGrtNDP9Rh7CRmuwhLn+r/oFftxOgVaG5OKyBcm/qXgoxcoMqAAxxpnY7OBG/U/8voW/L2pIXm+vKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494105; c=relaxed/simple;
	bh=rqlDudHnuYgq9wewNcojaTJbeYRPypypRFN8oxFuEys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PzTTpU+tgm7qmz00v8Z10XPdztl/TdqdUEJZt0GdqPCAv2S1GQBRSGQik9UIqSjXm6pFX0Htxqnt889J/NpWoF/nf2JoxsFqGDLe2JcoBWiIdX5HADJjdpfsJkyg0TmWRCOF0LKn71lvQNppIv36h8bsIwE+OkkLs85mTO+OXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mieflFWp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494101;
	bh=rqlDudHnuYgq9wewNcojaTJbeYRPypypRFN8oxFuEys=;
	h=From:Subject:Date:To:Cc:From;
	b=mieflFWpfr41xUm3kcgFxounly6rCgJ9vy95rvSTvxSxGuyZImksH2Ck3cNtX7Itg
	 I8MMTy/+7qkiMtnDKbUh92Jx5nZiGIvkJaG4O47Kz/+xYP9b60Hv6Epl32gbxmh069
	 ykIri/kV9y5eBIf/gTPgUXi0kl6LNz2x0ewG9Hrt1xPA14ODF9JmvbRlNoKOSKzGNA
	 8m8pr7l76ZkD41bpb+be72pfdIPs6QQcARVymDGVTG5Qaqgm29TitexDj9WuCw84h6
	 OeS+gMihRBIY9UIUtHZWN4oPXgR1N5oolrAk+O6zEv30kqX6XOgDOlLlcL0vMDzYZT
	 RKXODWXBcc6+Q==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F277B17E0DB7;
	Tue, 25 Feb 2025 15:34:56 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/8] Enable DMIC for Genio 700/510 EVK
Date: Tue, 25 Feb 2025 11:33:46 -0300
Message-Id: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMrUvWcC/3XMQQqDMBCF4avIrJsyRoy2q96juIiTUQfUSFJCi
 3j3pu67/B+8b4fIQTjCvdghcJIofs2hLwXQZNeRlbjcoFHXqMtWjbyKbxCVW4SUI8N8c4SmaiF
 /tsCDvE/v2eWeJL58+Jx8Kn/rPymVCpXpydSVswaH5kF+nm3vg72SX6A7juMLnKzYQK4AAAA=
X-Change-ID: 20250218-genio700-dmic-dc6ee9dc0638
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>, Zoran Zhan <zoran.zhan@mediatek.com>
X-Mailer: b4 0.14.2

This series enables the dual digital microphones present on the Genio
700 and 510 EVK boards.

Patches 1 and 2 add some required clocks, patch 3 changes volatility
handling of some registers to prevent issues, patch 3 adds the DMIC DAI
driver for MT8188 and updates the AFE with its routes, patch 4 adds the
DMIC backend and widget to the mt8188-6359 machine sound driver, patch 5
adds the audio routes for the DMIC to the Devicetree, patch 6 adds
DMIC_BE in the dt-binding and patch 6 assigns a wakeup-delay-ms to the
DMIC DAI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Reordered clocks in patches 1 & 2
- Split DMIC_GAINx_CUR volatile configuration into its own patch (3)
- Squashed patch "ASoC: mediatek: mt8188: Support DMIC in AFE" into
  "ASoC: mediatek: mt8188-mt6359: Add DMIC"
- Patch 4 ("ASoC: mediatek: mt8188: Add support for DMIC"):
  - Performed the many cleanups suggested on v1 for code style and
    removing redundancy
- Added patches 5 and 6 to add wakeup-delay-ms to the dmic
- Link to v1: https://lore.kernel.org/r/20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com

---
Nícolas F. R. A. Prado (7):
      ASoC: mediatek: mt8188: Add audsys hires clocks
      ASoC: mediatek: mt8188: Add reference for dmic clocks
      ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as non-volatile
      ASoC: mediatek: mt8188-mt6359: Add DMIC support
      arm64: dts: mediatek: mt8390-genio-common: Add routes for DMIC
      ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DMIC backend to dai-link
      arm64: dts: mediatek: mt8390-genio-common: Add delay codec for DMIC

parkeryang (1):
      ASoC: mediatek: mt8188: Add support for DMIC

 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |   1 +
 .../boot/dts/mediatek/mt8390-genio-common.dtsi     |  21 +-
 sound/soc/mediatek/mt8188/Makefile                 |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |   8 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h         |   8 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h      |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |  28 +-
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |   4 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h    |   4 +
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c        | 682 +++++++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |  14 +
 sound/soc/mediatek/mt8188/mt8188-reg.h             |  17 +-
 12 files changed, 782 insertions(+), 7 deletions(-)
---
base-commit: 253c82b3a2cec22bf9db65645f934fbe095899a3
change-id: 20250218-genio700-dmic-dc6ee9dc0638

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


