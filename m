Return-Path: <linux-kernel+bounces-258525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19693892C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0461DB20D96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F101BDC3;
	Mon, 22 Jul 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cUtu6ZQy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89844610C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631222; cv=none; b=jHpaPPhxxuaxcvfGPacGz2ZKDve5l0UERh1T1YPkLWz8utHI42dxJ6uCWHqIR2PTP29YawtKptZ88dIeMD+DAax2UZp6hMrFp6Q/3Z1YiSY3JzxZsz+CKoZfcJEgMygSBNng1Qp6gDlRqsXLwb0Wphtlv6z8hiaGVz90oJeN5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631222; c=relaxed/simple;
	bh=DNv4ZvpOlWpDysr5DKYpSpPIgYpHmJC889rcRBRLbU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ka+FFajBV2klE+sBt3Di2otPYeiqxTcPswnGRVbSaJaZyPA3KyYhaOjukpZY7neQwuToy7Tv2TtFKVYG1V2P0f0+wrYNcpuEmY4PCz3ngDkyl1/OuYAYjhjgXygJaZsUEz6IRiudDYOCTOCG6zZUdS0bX8nnO3M1L1QAeCdFjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cUtu6ZQy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso322028266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721631218; x=1722236018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsrM127hygYKA5jk1G0EVcptPCJlWj0AZyBnpIgIvho=;
        b=cUtu6ZQy4oqocrBO/0CHA225Jcg3Z9JuvjwHExPekyUtXiuQaeEYATt/jFqq8Ghgz6
         oOZDeOomBm+b1hLtwmSydZgmUK8TyPGLWKA5OsebHYMzmsPNHFj0ZinGhkiJHUzlmHLO
         1CYByhMN0fOw7sglB0GROnfx4BlgL1MdYkErbDRZOmHqNi+xjL6MsATMl5IJVuLvpIfy
         NsbtEOkaVejV8TG0JRBrciGIGriv5Q9HY79q6PDa3yOrTnx9scm8bxiX85UKjuT0gN0Q
         qy2dcQLoB4qSjZgEgGywHFrTjDOFzW6Wuk9Q0fgbt6Qe9XlQ0bev+H1mrJ4c8dGcPTO4
         lO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631218; x=1722236018;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsrM127hygYKA5jk1G0EVcptPCJlWj0AZyBnpIgIvho=;
        b=tYQr4Y77JPtShGHOWaSmp8TuAsPBq9hjA7RgdWtFJ0sFbpy07b6v1VGggRgPfOsXSl
         k6TqHLDvm8Rk+zUfOQ1yJT2t855WHTmYcDQCooNp9pEf9sA6VMTgsZF0sqyzQFgCUCpu
         wtUCN7JpJ/1Io2BOIdlJXIfiC2B1QbvWUclSM1MDNCEaXyV6Z1TK2piJKWibJC7OvUr8
         OVWKCxl/YbR4hilr91m/jkrojoZXS8dlQW3+hnscqPlKXoIa+zlNVnO/HXgAtWFl4JJA
         5tjg8Pc0/XehLmvJrIDj4NqIbJ9axlMwfhnKUwlvFUOYri6GQywtJ/Rrr853lhV9xZj3
         sYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWOZIKlJGx9f4/ROgmhLNeyPSJ6xsNYayMQi567QcNXzhjR358Bg5SJw9tM5S/dcCbbCtvhxoEBb1x484amN49bjc6KPIgPu6aQ96Ab
X-Gm-Message-State: AOJu0YyCXFqcyL9fsKeseMCBZ7fo8zraFkqn+cUIOJECs4NTCIWtJXHO
	0uzVsmdBuBRBDMSLKoPE3EM2OUYiz+CZJ6BQlELGrqP/uqyltf3Avk4PymvG5ic=
X-Google-Smtp-Source: AGHT+IH3U3WRnoemJHGFKrE09/s6jiFcFzPvzOfWrRW2m3vaQHFJvKOZl0vjwbNGOkeCjY76dXDxjA==
X-Received: by 2002:a17:907:7d86:b0:a75:35d3:e917 with SMTP id a640c23a62f3a-a7a4c010585mr381555766b.21.1721631217476;
        Sun, 21 Jul 2024 23:53:37 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a69c1f56a0sm1982126a12.64.2024.07.21.23.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:53:37 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 00/16] Add audio support for the MediaTek Genio 350-evk
 board
Date: Mon, 22 Jul 2024 08:53:29 +0200
Message-Id: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkBnmYC/3XOTW7CMBAF4Ksgr2uwx7+w6j0qVI3tCbEECXIgA
 qHcvU6WVbJ8I33vzYcNVDIN7LT7sEJjHnLf1eC+diy22F2I51QzAwFaAFiOz5R7npURXJOUCYX
 3ZAyrIOBAPBTsYjsTvFG5dPg4jHbveYnysNjfeCXsnvdZ3As1+bXM/5xrbvPw6Mt7+WaU83V1e
 JS8rjcoI6G01jXfAd/XHArtY39jc9MI2xqqVkKrpL1KJNKKVttaVS1tCBCPTkdjVrTe1rpq4SE
 ASG+TjivabGtTNTkCY4+p0V6uaLutbdWNM5qiRGeV/qenafoDdocqZg8CAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6557; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DNv4ZvpOlWpDysr5DKYpSpPIgYpHmJC889rcRBRLbU4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmngHwuwh7qZXwmjfRanNAgIDu5pCRf+Ul4LZePbfm
 8dUzdaCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZp4B8AAKCRArRkmdfjHURc+4EA
 CSeLRrWoEwL/hb7EReC/RrFi6zoHoKx4fGN5zO+WUatY02PYIwyeDNaq3hsVFEveyZCPcHjkMxHid6
 WfsYNbgu7XqOXh/gQOHTzmDWV1BtVfp0d/aQbqIUWeDrWnRVBPAs9oj2Ny2fE3RE/2+5I9UMpaNtQA
 KpC9tKpfmRCaXQrwFZF+4DXyOw9FjjacQ4tX0r0b7eNJaeikAXVjMCwY4fmwrz/567bdN8PKvroI2m
 jvNfbVLtgeMt7MLAkqeOReL3lV/X3UWMXebEiC7JHx/YOswBYG4vmgyWhJWYJbP3+VwTIe+qTbiau+
 n5RMDRnSuTTOwJrFOktXSLCLgpAgV0CSgVjg4x2Y+r7W5iTy7Fzs0exv/UZrqvGlpH/SlM1v0lMnKh
 DOd6wLYs0VkFnTSHgmfO/C6xziqUkWTt15EVFxh45M3qCIkkZzsWpoAYZzJ2o0kdgcefU6HHe3Tor8
 giFMQg0CQaQu8usz+ht0EU5lLT0m0QWcMlR1dnCnjbdcyl2kGJGg1Ck/9q5oREGxqr9f4xViGWzU8V
 qxJD7bj/Ju8zPmyiik34RV0/puZ6gJu+JY/wYzOi9pMdfjNmpM4u24eBLmhFgl1qOqwbpkx/OxcHt7
 pbjFJibpzcjYJh9xZcB9dDfatqqdMJJ0XXGaCHY8f13aROFNahnoIQCO3v1A==
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
Alexandre Mergnat (14):
      ASoC: dt-bindings: mediatek,mt8365-afe: Add audio afe document
      ASoC: dt-bindings: mediatek,mt8365-mt6357: Add audio sound card document
      dt-bindings: mfd: mediatek: Add codec property for MT6357 PMIC
      ASoC: mediatek: mt8365: Add common header
      ASoC: mediatek: mt8365: Add audio clock control support
      ASoC: mediatek: mt8365: Add I2S DAI support
      ASoC: mediatek: mt8365: Add ADDA DAI support
      ASoC: mediatek: mt8365: Add DMIC DAI support
      ASoC: mediatek: mt8365: Add PCM DAI support
      ASoC: mediatek: mt8365: Add the AFE driver support
      ASoC: mediatek: Add MT8365 support
      arm64: defconfig: enable mt8365 sound
      arm64: dts: mediatek: add afe support for mt8365 SoC
      arm64: dts: mediatek: add audio support for mt8365-evk

Nicolas Belin (2):
      ASoc: mediatek: mt8365: Add a specific soundcard for EVK
      ASoC: codecs: add MT6357 support

 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |   21 +
 .../bindings/sound/mediatek,mt8365-afe.yaml        |  130 ++
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     |  107 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |   86 +
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           |   43 +-
 arch/arm64/configs/defconfig                       |    2 +
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6357.c                          | 1855 ++++++++++++++++
 sound/soc/codecs/mt6357.h                          |  660 ++++++
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8365/Makefile                 |   15 +
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c         |  421 ++++
 sound/soc/mediatek/mt8365/mt8365-afe-clk.h         |   32 +
 sound/soc/mediatek/mt8365/mt8365-afe-common.h      |  449 ++++
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         | 2275 ++++++++++++++++++++
 sound/soc/mediatek/mt8365/mt8365-dai-adda.c        |  311 +++
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c        |  340 +++
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |  850 ++++++++
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c         |  293 +++
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |  345 +++
 sound/soc/mediatek/mt8365/mt8365-reg.h             |  991 +++++++++
 23 files changed, 9254 insertions(+), 2 deletions(-)
---
base-commit: f2038c12e8133bf4c6bd4d1127a23310d55d9e21
change-id: 20240226-audio-i350-4e11da088e55

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


