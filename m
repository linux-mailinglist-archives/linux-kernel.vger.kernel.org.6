Return-Path: <linux-kernel+bounces-419382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291D9D6D26
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747F8B21187
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFE186E26;
	Sun, 24 Nov 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2BTaB8K"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36C14287
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732438762; cv=none; b=KkVixydoqaLV194zBN/MRHjG5ZZRMiPIEYW2txyZIJqWO6tyD1fdIS9gO/D+JePeT1n2h413XjGyuVeK0659TVj7B4orYQskuxXiMWN41FAunXkdKQTJHbIxOxsTAeQdZWSEl0KIBbvRpeLqVfigkOCuX2nAS44bJpSaaoVxSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732438762; c=relaxed/simple;
	bh=YLV9lN4WZZU4RfbhuYed4kCtgqOCfoY6/K0MGXxuvgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQsi0okgHfoLSo/t6/G/5e1HeIdwpdCLGwybLHUUpy4PsI2isNliXBKpoo7erxDEA9F4oeLmGn/AK8l9JdVw5R+2v0RIKT5fgY/98NO3ZuL3xXsyEdBUSYC4fSUQTvd5lJBWouDtgWxHlN8TrchPoY+aAqcSjfCD1HFSvF3qzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O2BTaB8K; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so2976265a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732438758; x=1733043558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EF6KAe0aJXErRNe2gIgSW1j08V4k2/044lY06SL09oI=;
        b=O2BTaB8KfSVvS6G0CE0CzrTt4jhYJibvmWork81xuHaA7z3nCqDFcjNGKu+Sr6IJ2W
         7f37Kmgm5XtPVIPC1e8hc/weWPef7lfjEKm8mvxwtC2xWqt7MdMDtFW2ul5D7K3cF2ic
         Tihi0OS7FWW3hLRhNtjZpS1H+o19/Nup4wGa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732438758; x=1733043558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF6KAe0aJXErRNe2gIgSW1j08V4k2/044lY06SL09oI=;
        b=BnXeqmebufMwA6qg0mpMkX0ysd3QkW+aMBhEBut9b2qKcwFyIXxYfkr1mmlAVXuK0t
         8sTo5sqHWmY0HMqkFQVxKjYhjjozPtmlJt+B2zAR5Oug52ALRS6Ynn7cCNV5hkXKCyDg
         3UTowfr00wPBTXfXUwEallAkFbX9Xq7W+i5mlvk9NJWa+/2fizZGMDNfgxN92DTO8Nb8
         QWSSW4nD6EcBBcMzVpsZw8w0MHBhHp1xNWFPzH8X2uuZR5SSgwtUUvho+u05tXP6MdXO
         ImvvrrQCwHR7cLRfSFitVA1OK4/mrlPqII6m+4lWWr1ObaUTUCiHRo1DrLIrwpXLmzoE
         ecBg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+5Igc8u7uKn963A/CLmxCnugmAtGWNsRktj/RdmW6YJKK1QanKj9Hsc0EGECMBpBn2fGWwjJrpvazmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0V4ghMCzJ8OwUzLhHytUqgCXIximrWG7i2Y3xKiEejIUz+0pq
	l5SFEK7cA/kTy44OmSiR8dpDErlBAL5SzGsxwVVH2C6gqmFF/ncF8upzPh3ICQ==
X-Gm-Gg: ASbGncsgFgM/fadjKUTafSrqOKhaAXhVVCJ7n3mb3A7tGgfWuSmTpqW+cikFxXLXCkC
	hf/njDY8gxfPKoKKa0z/Bh/Tgy350twsSQHhuKOn5kEDqE82F6b9IxAlNdkg9HYxhNWjO9CtK4D
	XFm2HkBUvp6HW3tRTVXtBc/8Inlt9/7Jx0QXv6Frez3Wg0Lhljatbsc76tHneaJOg7gcw9t8AaY
	AQYNyW5OL/xM/ry7lmxJw3ND7f4EFqPA5j6jIxYjcjUARpCd44j3XvF6SONEpt6lZzNCg==
X-Google-Smtp-Source: AGHT+IFXc7VvlP/3gYWKOjTV8+v6xQUtU+qQkhGAveyBwDGTGonrlWWpAiyBkTbiDpTB33S9/XAxUg==
X-Received: by 2002:a05:6a21:778f:b0:1e0:b51b:ac22 with SMTP id adf61e73a8af0-1e0b51bad66mr4211481637.30.1732438758063;
        Sun, 24 Nov 2024 00:59:18 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:f699:9cb9:f928:9a14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc4c28sm4465890a12.3.2024.11.24.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:59:17 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] Add device tree for MT8188-based Chromebook "Ciri"
Date: Sun, 24 Nov 2024 16:52:36 +0800
Message-ID: <20241124085739.290556-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the v3 series to introduce the device trees for Ciri. Please
refer to [v1] and [v2] cover letter for the detail introduction of Ciri
if needed.

Note that there are patches for some known dtbs_check warnings:
- sound: Unevaluated 'mediatek,adsp' property
  https://lore.kernel.org/all/20241105091246.3944946-1-fshao@chromium.org/

- amplifier: '#sound-dai-cells' does not match any of the regexes
  https://lore.kernel.org/all/20241105091513.3963102-1-fshao@chromium.org/

- dp-tx: '#sound-dai-cells' does not match any of the regexes
  https://lore.kernel.org/all/20241105090207.3892242-1-fshao@chromium.org/

- audio-codec: 'interrupts-extended' does not match any of the regexes
  https://lore.kernel.org/all/20241105091910.3984381-1-fshao@chromium.org/

- pmic: 'compatible' is a required property; 'adc', 'mt6359codec',
  'mt6359rtc' do not match any of the regexes
  https://lore.kernel.org/all/20241004030148.13366-2-macpaul.lin@mediatek.com/

- power-controller: Unevaluated properties are not allowed
  ('power-domain@31', 'power-domain@32' were unexpected)
  https://lore.kernel.org/all/20241001113052.3124869-2-fshao@chromium.org/

- mailbox: 'clock-names' is a required property
  https://lore.kernel.org/all/20240911104327.123602-1-angelogioacchino.delregno@collabora.com/

- jpeg-decoder: iommus: [[141, 685], [141, 686], [141, 690], [141, 691],
  [141, 692], [141, 693]] is too long
  https://lore.kernel.org/all/20241001113052.3124869-4-fshao@chromium.org/

- amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
    >> ti,tas2781 binding specifies that ti,tas2563 register range is
       0x4c-0x4f. The DT follows what the binding literally suggests.
       I tried changing the binding locally but didn't help.

[v1]:
https://lore.kernel.org/all/20241025110111.1321704-1-fshao@chromium.org/
[v2]:
https://lore.kernel.org/all/20241105093222.4055774-1-fshao@chromium.org/

Regards,
Fei

Changes in v3:
- Multiple DT changes, refer to Patch 2/2 for all details

Changes in v2:
- remove invalid or undocumented properties
    e.g. mediatek,dai-link, maxim,dsm_param_name etc.
- remove touchscreen as the driver is not yet accepted in upstream
- update sound DAI link node name to match the binding
- add missing pinctrls in audio codec nodes

Fei Shao (2):
  dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
  arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri

 .../devicetree/bindings/arm/mediatek.yaml     |   13 +
 arch/arm64/boot/dts/mediatek/Makefile         |    8 +
 .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   32 +
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   59 +
 .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   59 +
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   32 +
 .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   48 +
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   72 +
 .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   72 +
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   48 +
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  316 +++++
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1156 +++++++++++++++++
 12 files changed, 1915 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi

-- 
2.47.0.371.ga323438b13-goog


