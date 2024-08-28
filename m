Return-Path: <linux-kernel+bounces-305089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5432962958
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B1285E92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73E186E2C;
	Wed, 28 Aug 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baOf/6Mg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD4186E2A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853244; cv=none; b=d2iqVP4LNNSdATzD5zciWtAbTc+CfA+SS1eTGEKwbWV81o1yeD/h2FuNSctEZj1wqISJzFiYvBvl03ZOnWrq6KJBOjlQruSbX/c+LFkqMkkyqraqi2RiXFAwL+wF5KjPSeq4Wnzos6UNVKune+Gl9KnsNNZxf+ANH3OkgeAkdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853244; c=relaxed/simple;
	bh=W2qT+nbE+KGIf64JgDj7bPJT7KbQfb1ZNolRePACrmA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iHNU0FUxiUJucKdIZlfJzCr4vQkhCN+tzXzVXj5pRb+sOwyLbTULIeMoQqkYMBtqJVycA8eBegkp0KBRGNEEV0mbr0saqESEqMeF2MxB00FPQzDJm5xF7TrEm3bzgWj+4K5FINPV61TGnCuSehI7xDlKmTR4K56U1u7cxeD35Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baOf/6Mg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37196786139so4189268f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724853241; x=1725458041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsWzKaC8r3z3iwI7ze5w6BhtUaD0ABZEzQQaTYtnZn4=;
        b=baOf/6Mg+kD7G0aCUyCgQM+zacpsd251ivYlZcXwiVfcAb/Wz9DumkFHSvnfmUPOz/
         SkCjQF9J27Oy/Pbz7E6zRr6S2sEdXmlmOt0SFXG49lcgGnxTLVze7SRrmHfVsF/Onfdh
         2JOTSPQh2JYWWaqvaHo6B2LnfAOu4jnyWXmtyiALVBkuF5asMBi77FRf/3z/dXvTnyfB
         LSBDOlKV/ig2tjMJkhZki+WdIzTc8SU0SoqqXzxiOSbQsv7AsuaYTvW16ryTktJONDJb
         aBVG7YiNEQslN9vPcb21HtOG8PR/ZijV+/hyC2O3EpuW5YT3RFQ9yKQlb8DDuZxNjtis
         PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853241; x=1725458041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsWzKaC8r3z3iwI7ze5w6BhtUaD0ABZEzQQaTYtnZn4=;
        b=Wah1VliCiIwRl0xb2NKA7NQAcyk/Zob/4cqAgb42jvuy/ToHRbhme0Rwn2I8fLVZ4F
         PXdgAALCUkxJCH5RIqysfdqrUgDwtTovX0HB+dv5HPTzgVRGA4BhNRbqDyginw4qpQTH
         o+eVvF73jbD2/xyfXSfLcDW3oN70zIiJPEbp7FmaI468LpWHaAKOPBIXgkTF1bYLx5n9
         NY9KofKDO/Evg9tN4mziRvwwtvGw4Jj4iepQC3jb2nm4FPZXX1PW1Mup1aEzjVpYyCXl
         ARSXAbSVWBqkiSpTuGb6lYIVy3K8vF20r6lvamCt4K4JO/5lKo50fkSVJMcdFNDyEFLP
         KVvA==
X-Forwarded-Encrypted: i=1; AJvYcCUtE6Nw1jshOzOALlg8ExmOA2clYqDT0BJUAhKJp5SwcFl8MU5y7UoRzmM5Ii+rjvfmg447Ql2IpfAXQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6Hb5aWFDwNBI4xi+HrrLj2KYrBI17EAfpwHA1L8885XFZs8B
	zrM0S8ILE0kkiyD9VrwREoXqI6u/ZX0mxBVonFOmSl2OQIbEjbZGjcvRQmYHOTM=
X-Google-Smtp-Source: AGHT+IGYNhcSsHhA50Pc1ZE3GvXf2OgkY55sS2VidB4C2ZkfpkxCDxWyLcO8SIagveLtAqlTErYVvQ==
X-Received: by 2002:a5d:6111:0:b0:371:a844:d331 with SMTP id ffacd0b85a97d-373118fc172mr10240865f8f.62.1724853240598;
        Wed, 28 Aug 2024 06:54:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c44asm15613395f8f.34.2024.08.28.06.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:54:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] ASoC: dt-bindings: amlogic-sound-cards: document
 clocks property
Date: Wed, 28 Aug 2024 15:53:53 +0200
Message-Id: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPErz2YC/6WOQQ6CMBREr2K69pu2VhRX3sOwqO2n/ARa0g9EQ
 7i7lSu4mrzJZGZWwZgJWdwPq8i4EFOKBfTxIFxnY0AgX1hoqY2slIEpjeTADn0KReeRp4x2gBd
 FTzEwtPRGBjt7SsDRg7PZg3aV0c75oihK9Zhxz5XmZ1O4I55S/uwvFvVz/xxcFEio28vV1yjV7
 WwePUWb0ynlIJpt275XTao2+QAAAA==
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5950;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=W2qT+nbE+KGIf64JgDj7bPJT7KbQfb1ZNolRePACrmA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmzyv1/ZMuhoHR5pewIyF5Gq+f8UGw7T/m3E0Pig6d
 v47cuCGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZs8r9QAKCRB33NvayMhJ0fnGD/
 wLvs8Egp00XPNWKHBIC7q7bcXodhwunPgAOFqpH1cksGb0adPigFWPnTjhBvqwGGGhOJgriDhoRAGb
 1woPAgTxo96yPq4y/rOUeYrDphxqx1JrATxTausbPL90AyGRCD0kUMfk/RrnLy69k5xWohubgGA7fD
 nT+qmhS1Krsub6kIvmu6KMX6AJctbDhBXDxCBY/hEIkmVWSoTlA9uBYBYQw0PVSP5+QuaIwEGAlA3+
 ka0JH8r1kSa4pLYwgrulUHpSS4xtUX49o+krg25UcEbWwr4fVcebHkCILobKPdcs1W1zbK7Okl0c4u
 XrJzhrUcnK6wWuPaLy/NGi1l9+eFP4wSYm+v2t32Q2OzTZruBpI90pTUCpmoAd9RU/zAKctieznRQg
 U8Ss+nck4wPHvbUN84+uY+6mny4pnIfE30uezrObARDrMwHc9Hdl9XDX+kPXGK9zyOXNSAkgpXQmws
 TL4VoO5Hnr7I7SzygZhESUanUjzbwAAVFu3ujUkgUfUworJRpTejrKHjip2S3BUjE1TWq7kkGflz4F
 gMCH9XdPE/ix4Osjkw1SIs/vONUpn5MsV83r5SoaeYX5SFz71RtFuk+RmhioViGTCg66piwhgE1J7H
 AuQTT9amtEy4KQ4/kHU5kwamsatOXJulV86VZ9vNbOpLdsv63fmrqMCDvzVA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Following an off-list discution with Jerome about fixing the following
DTBs check errors:
    sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
        from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
    sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
        from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
    sound: 'anyOf' conditional failed, one must be fixed:
        'clocks' is a required property
        '#clock-cells' is a required property
        from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

It has been agreed documenting the clock in the sound card is a better solution
than moving them to a random clock controller or consumer node which is not
related to the actual meaning of those root frequencies.

The patchset adds the clocks proprty to the bindings and finally adds the
properties to the DT files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- drop clock-names in bindings & commit messages
- fix new boards
- drop RFS
- Link to v1: https://lore.kernel.org/r/20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org

---
Neil Armstrong (3):
      ASoC: dt-bindings: amlogic,axg-sound-card: document clocks property
      ASoC: dt-bindings: amlogic,gx-sound-card: document clocks property
      arm64: dts: amlogic: add clock and clock-names to sound cards

 .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml          | 7 +++++++
 Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts                    | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts      | 4 ++++
 .../arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi               | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts         | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts             | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi             | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts             | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts                    | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts                    | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts             | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts       | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts         | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts    | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts       | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts             | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi        | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts          | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts          | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts             | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts                  | 4 ++++
 52 files changed, 217 insertions(+)
---
base-commit: cb2361c78068ec47c3a6222d71f664b67665550e
change-id: 20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-2c642ccd2c6e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


