Return-Path: <linux-kernel+bounces-316686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9996D2C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FC1F21BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809BF196DB1;
	Thu,  5 Sep 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gvMHtEYb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC5194ACB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527252; cv=none; b=FJhyzKWmeAU3zF1w6nrIbmAWG/1hJ9NjNVTjJrR144IoavFlbojKM8bnrNGaSxwHMBPq9DRk871ApVdpIGyKh3qf2GWaHKyL+QSoSuQNnHSrEy2MPVM935ja4U3Nkd4B6ulMBpXM+G9tJiYGisg0nLKbaW3hf/Gys6uAokHwqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527252; c=relaxed/simple;
	bh=dBxURWX7KTFMbN81hRO4g326ngzL/XDCE/FYjWt5HIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+w7p501jNtxnl5lWxYqPewc3L1K3lPiWvUoahUgrfC3qV09rOe7oOcnG9iYF8M+25JZM26raBScSYDVmFGnhX4VoeKns56BCZZHuEm25RpvydDHRGodOkvVP9XpAVrNqwgPe0/Eyz7GxZZ9RUDrs0rhQnYYtWCVy92ZvuRp8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gvMHtEYb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f64e82aeacso6291251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527249; x=1726132049; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUeCTdJ3sls71eS4ZZNr+/ElSpCCJujDvm6Vi2xmmfY=;
        b=gvMHtEYbOMb9EJP3aS9BCUVfaKH8oq2HMNQm4WdLRefUszI1vPchXhfBxsL3M/dVTA
         Bir7zNmGlpJdzpBatYoIFfQbjL0pXXtJqePe88w0AUVOqlta9rZaLlU3dQgYH+g337o2
         JPum4zzuBQawTYGO3shaOxIF8s3KI1L6OO4zltm8T/VfxVP8aQ3MAWaexNvIQlv0w3pB
         CXJT/uuxPVxyAegXpZx2GLujDV5FV6EGtHw0khxWNZe+Ry1hNQVSBk8xEloh4qtG8fiP
         bVHFjC9f4vwvE4F333w8kLnPXK86WKyWWCvP5+7Nxk6AMmESSeAANyLyexsuC+kQULL0
         uGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527249; x=1726132049;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUeCTdJ3sls71eS4ZZNr+/ElSpCCJujDvm6Vi2xmmfY=;
        b=QMiUhDhVIOzTCfxSQeFUaXJ1ixP9f+TlIA+oLE6XDsByMRuTLRza/DSjvIBfdxs9id
         a2KHlO8xlWLeCx/yJYxZQUjB068T7blC2lUd2Qu1sIAzj8+yHpOTogBGV+c+iyyKFGAQ
         pWV6RQ/SzuC/8E0MkQOombuzpt5N1QSV1JL5TXSz7EejuRuEdp324wgU+jjT41AwGuDl
         cz0PqAxdLSMCoFNdM3vCJl5HWnXCi7dvYD1kfrkkLWEqU5DsPNjhUO3H5/CIrgBlbMIB
         yBeeo+qwsNHEXThNog7s1lhFVYXJpgTNlLcbm8Bc+yC1Lp02YsnOqmSKgJeIqIlTqLuY
         i2Jw==
X-Gm-Message-State: AOJu0YyzpUSGWZ0Sxs9IicNuooDHo5UCRwS8DXZSFNOcxVH7OTeqtjpT
	TIXwozjouiE8NxubvDrxDiNPhErB+Sh333fZkegLF0eVbDRJ76fNAbIF+9PH8b4=
X-Google-Smtp-Source: AGHT+IGoXr8sDfb/qLgzQ05rmiOhT+IRh+Lq0NYQ+ICJw9s4N82Vl9TQQJyTL02pfA9YRbTstwBlcg==
X-Received: by 2002:a05:6512:228b:b0:535:6a83:86f9 with SMTP id 2adb3069b0e04-5356a838876mr2189726e87.60.1725527248520;
        Thu, 05 Sep 2024 02:07:28 -0700 (PDT)
Received: from [127.0.1.1] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-535406e5549sm2554188e87.0.2024.09.05.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:07:28 -0700 (PDT)
From: amergnat@baylibre.com
Subject: [PATCH v8 0/5] Add audio support for the MediaTek Genio 350-evk
 board
Date: Thu, 05 Sep 2024 11:06:57 +0200
Message-Id: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALF02WYC/3XOTWrDMBCG4asEratEo39n1XuUUkbSOBYkdpAT0
 xB898peFnv5CZ559WYjlUwjOx/erNCUxzz0dfiPA4sd9hfiOdXNpJBaSGk5PlMeeFZGcE0ACYX
 3ZAyrIOBIPBTsY7cQvFG59Pg4TfboeYlwWu1PvBL2z/si7oXa/Lvmv77r7vL4GMpr/c0Ey+tme
 AJe6y1CJARrXfsZ8HXNodAxDje2XJrkvpZVK6FV0l4lEmlDq32tqgYbgoyN09GYDa33ta5aeBm
 kBG+Tjhva7GtTNTmSxjap1R42tN3XturWGU0R0FmlN7Tb165qa8CnxigE/b89z/MfYa+yDU0CA
 AA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>, 
 Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=dBxURWX7KTFMbN81hRO4g326ngzL/XDCE/FYjWt5HIo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBm2XTOxzwz7ABWQj56AdCpLONjDkYNZ96e9sKRl/Rf
 w4JiwPmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZtl0zgAKCRArRkmdfjHURT/3D/
 0VlMEO+7VnEC9PokKnpBY6NRgS4pZwPpn2hO+jxxC+y5PI/8wJWWZU+dN4bK5lp2i44JkpeuIvHdNh
 tJAoyGO1hCBCS2HHuZrwgXF2LpROZ4oeBG+v3Lo693gBTqxCttoFLr/1iMHPsESqDLxK5rFJp7f0rG
 F4MkeFZF+Vz3biT3nyF5Nu9lq2Mjr9dSEUe85G8isJbIPvWQfilYdtr0Byfx/TdrI5SIkbqsth9Oci
 C8MoqypoBFPd3Z2kd0N7pxWTBTyXnJN6Rt/XQxIRCOQjUb1vmcJV52XAmEyzWhoPronkiO68s1fuai
 ivM6OW0tsFv+/+TLJ9SyARyyYU1pEdRpRj0noeE8Trs3t/O6SHFn3yoGyO4jTIBk1CMuTOH+697aeX
 X50E+xiGCTGxW/oREwxSrpMvUkur65jO6Kp7mJjf3b/AQ6ferLz+WqpoL62GFT7/wl1nhX/WGhGgs3
 uUx7xjPQB7zXDqQhymrqnyZR9uR5pqDI6kZ75bGhQdZS2ZUMTGD78nPoK+h2Afv3czew3/x088/jRE
 CCL0FCmwNapXFSxPMT9EeCzA7x6RZxQBEBDTa1WbBIrWs+0x6Pt/Pv+O+hqG+PlOjBqWkBtSPBu0wl
 oLU+mK0NM39Z/991TWdLhvsqBM21XP5qxfnf1HV0SHLNrmVOBZ/hSLA6iRLg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

This serie aim to add the following audio support for the Genio 350-evk:
- Playback
  - 2ch Headset Jack (Earphone)
  - 1ch Line-out Jack (Speaker)
  - 8ch HDMI Tx
- Capture
  - 1ch DMIC (On-board Digital Microphone)
  - 1ch AMIC (On-board Analogic Microphone)
  - 1ch Headset Jack (External Analogic Microphone)

Of course, HDMI playback need the MT8365 display patches [1] and a DTS
change documented in "mediatek,mt8365-mt6357.yaml".

Applied patch:
- mfd: mt6397-core: register mt6357 sound codec
- ASoC: dt-bindings: mediatek,mt8365-afe: Add audio afe document
- ASoC: dt-bindings: mediatek,mt8365-mt6357: Add audio sound card document
- dt-bindings: mfd: mediatek: Add codec property for MT6357 PMIC
- ASoC: mediatek: mt8365: Add common header
- ASoC: mediatek: mt8365: Add audio clock control support
- ASoC: mediatek: mt8365: Add I2S DAI support
- ASoC: mediatek: mt8365: Add ADDA DAI support
- ASoC: mediatek: mt8365: Add DMIC DAI support
- ASoC: mediatek: mt8365: Add PCM DAI support
- ASoc: mediatek: mt8365: Add a specific soundcard for EVK
- ASoC: mediatek: mt8365: Add the AFE driver support

Test passed:
- mixer-test log: [3]
- pcm-test log: [4]

[1]: https://lore.kernel.org/all/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com/
[2]: https://lore.kernel.org/all/20240313110147.1267793-1-angelogioacchino.delregno@collabora.com/
[3]: https://pastebin.com/pc43AVrT
[4]: https://pastebin.com/cCtGhDpg
[5]: https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/sound/for-next/add-i350-audio-support

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v8:
- Rebase to "sound/for-next" branch
- Fix build issue by removing extra argument into dev_err_probe function.
- Link to v7: https://lore.kernel.org/r/20240226-audio-i350-v7-0-6518d953a141@baylibre.com

Changes in v7:
- Rebase to "sound/for-6.11" branch.
- Move audio-codec properties to the parent node
- Remove gain values change at init to keep HW default values.
- Remove spurious function by inlining them directly.
- Use standard adaptators for regmap.
- Use "ARRAY_SIZE()" instead of defined value.
- Remove unused variable which breaks an x86 allmodconfig build.
- Link to v6: https://lore.kernel.org/r/20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com

Changes in v6:
- Remove spurious defines
- all files: replace "Mediatek" by "MediaTek"
- dts: replace "pins" by "clk-dat-pins"
- dts: drive-strength: use integer instead of define
- Link to v5: https://lore.kernel.org/r/20240226-audio-i350-v5-0-e7e2569df481@baylibre.com

Changes in v5:
- Rebase to "next-20240523" branch.
- bindings: power supply property moved to the parent node
- Replace "SoC" by "ASoC" in the patch title (5/16)
- Move and rename DAI I2S's defines
- Improve code readability and cleanup
- Link to v4: https://lore.kernel.org/r/20240226-audio-i350-v4-0-082b22186d4c@baylibre.com

Changes in v4:
- Rebase to "next-20240422" branch.
- Re-pass dt_binding_check, functionnal tests, mixer test and pcm test.
- Remove copyright changes.
- Move mt6357 audio codec documention from mt6357.yaml
  to mediatek,mt6357.yaml
- Fix broken indentation in mt8365-evk.dts
- Remove empty node.
- Add more dai link name according to the HW capability.
- Remove spurious property (mediatek,topckgen)
  from mediatek,mt8365-afe.yaml
- Rename "afe" to "audio-controller" in the documentation.
- Link to v3: https://lore.kernel.org/r/20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com

Changes in v3:
- Re-order documentation commit to fix dt_binding_check error.
- Remove $ref and add "mediatek," prefix to vaud28-supply property.
- Link to v2: https://lore.kernel.org/r/20240226-audio-i350-v2-0-3043d483de0d@baylibre.com

Changes in v2:
- Documentation fixed:
  - Remove spurious description.
  - Change property order to fit with dts coding style rules.
  - micbias property: use microvolt value instead of index.
  - mediatek,i2s-shared-clock property removed.
  - mediatek,dmic-iir-on property removed.
  - mediatek,dmic-irr-mode property removed.
  - Change dmic-two-wire-mode => dmic-mode to be aligned with another SoC
  - Remove the spurious 2nd reg of the afe.
- Manage IIR filter feature using audio controls.
- Fix audio controls to pass mixer-test and pcm-test.
- Refactor some const name according to feedbacks.
- Rework the codec to remove spurious driver data.
- Use the new common MTK probe functions for AFE PCM and sound card.
- Rework pinctrl probe in the soundcard driver.
- Remove spurious "const" variables in all files.
- Link to v1: https://lore.kernel.org/r/20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com

---
Alexandre Mergnat (4):
      ASoC: mediatek: Add MT8365 support
      arm64: defconfig: enable mt8365 sound
      arm64: dts: mediatek: add afe support for mt8365 SoC
      arm64: dts: mediatek: add audio support for mt8365-evk

Nicolas Belin (1):
      ASoC: codecs: add MT6357 support

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts |   86 ++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi    |   43 +-
 arch/arm64/configs/defconfig                |    2 +
 sound/soc/codecs/Kconfig                    |    7 +
 sound/soc/codecs/Makefile                   |    2 +
 sound/soc/codecs/mt6357.c                   | 1855 +++++++++++++++++++++++++++
 sound/soc/codecs/mt6357.h                   |  660 ++++++++++
 sound/soc/mediatek/Kconfig                  |   20 +
 sound/soc/mediatek/Makefile                 |    1 +
 sound/soc/mediatek/mt8365/Makefile          |   15 +
 10 files changed, 2689 insertions(+), 2 deletions(-)
---
base-commit: 097a44db5747403b19d05a9664e8ec6adba27e3b
change-id: 20240226-audio-i350-4e11da088e55

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


