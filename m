Return-Path: <linux-kernel+bounces-381551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE449B00C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3B283C76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881B1E378A;
	Fri, 25 Oct 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJWAvq/V"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB21AB6CC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854122; cv=none; b=WeHaDcvD/djMdwqlkAtc3uTQHcllxLLlzHMnOHhlV+KgRuV2HZk8ekpGE4slksE0MwioeSIDxjCo2XLsX/ZKKg8tMQ4xZhUYodjFVxu7unvJI81KYqt/lfC6HpoFioSfPMEClzxKoOK3E21saR3ofq21MzhlrsG07TGC4msChyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854122; c=relaxed/simple;
	bh=GfN5c4KXWA7OMKT8vdzQydgGP75aLjRMk24BcgGy+Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Smc+Ru4wlvzyzuZokuTgXlSC9MgLZNL6oCRj9b7FMl8KBZ3qjPU7QbTmq42jlcBh7URQOcyVc4uPGoWMCyCcDwiK91DkWL9+Iy282qUj5OBWPZ9l/nxVFJ8pDWPsM0izeFk2IlyZQkBofDtigz3FH77u3g4j0C7TITGoqIFQ17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJWAvq/V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so16644215ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729854120; x=1730458920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA1BaJSXIbyRxZAZxbUrwFqIYodfb+rWTCae1lhe5eI=;
        b=KJWAvq/VZUq7dTMvPkB6M3a8uv/mrn94aTODJ15NnHAhy6ZhLCcN2eMJNDY+qhCrm3
         LG0MHu9XbdtfDzq1ZsAgTGm/BFSZhR5UXLTSbCGJyAybeFdyhPveWmLHhcYNH5SjWsCW
         pqZoO9X3oTOhwAgxZHUswIlPq/FNdDcyFvs1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854120; x=1730458920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA1BaJSXIbyRxZAZxbUrwFqIYodfb+rWTCae1lhe5eI=;
        b=jQyoY9jxQ3KltsxNB9QL3Z0G+DMlkxLZChSfn5zIR4x6F8KpEXb0N5LtaZE5YTamkW
         6lEvKqgfi9UkHN3HpVb06TTw9t6J1ovMwVuALDkgUE1oggZUtbghmWOdwu7kYavvPGFy
         HWSqAYZEbT/ZHbxB0roG+4kkTYkYhgebmyiKXR8taP4AY6pwsUppxGVCdYHHuXGm05Y9
         9PF56xCWbiaLNMhc0oAxqrWkgDWVTlm7nKKVsJQ2uB06aCzLbHA8ezoguJNdtjdlZotJ
         g4bCRBl7vp9h2zfsUbuzs4qo0il9vyTgTG0m3BCgWfK69uj5iuhK/rHAX47iXWMzEXg+
         niAA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ot0NyjSNPuRK3ZAsj41E9svE+pkqTOmvJ9dD9K1zT/zHXOi8RAc/HKWQm67tSqLyM004AN9EeJ7NYIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lb9p66b172j5fz126tQrsVbkDoAYNqZG3d0+klPtUNsYSK6a
	XD+2XBaVV+zGf85lSEjK8IznksMS8PHnxaA08wlJdlj2dulAxmrSxBKDcrWWRg==
X-Google-Smtp-Source: AGHT+IFDbxd3tKIOspjDBLvAwaHXKqYcW5r6RFjmnpA/8c1Tgdp9G1tMOfUfj7tEG8JXbcnHkoILhQ==
X-Received: by 2002:a17:902:e74d:b0:20c:e005:2c27 with SMTP id d9443c01a7336-20fa9e9fd45mr131792775ad.42.1729854120044;
        Fri, 25 Oct 2024 04:02:00 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ebe1:dd63:343d:8a4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4472dsm7588595ad.13.2024.10.25.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:01:59 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Rob Herring <robh@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] Add device tree for MT8188-based Chromebook "Ciri"
Date: Fri, 25 Oct 2024 18:59:34 +0800
Message-ID: <20241025110111.1321704-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers,

This series introduces the device trees for Ciri, a MT8188-based
Chromebook, commercially known as the Lenovo Chromebook Duet (11", 9).

Ciri is a detachable device based on the ChromeOS Geralt reference
design, where Geralt is the codename for the MT8188 platform. Ciri has 8
SKUs to accommodate the combinations of second-source components,
including audio codecs, speaker amplifiers, and MIPI-DSI panels.

The Geralt design is not used in any actual products, so its device tree
is not included.

The device trees are taken from the ChromeOS downstream v6.1 kernel,
ported to the mainline kernel and with cleanups. This series aims to
provide a basic device tree with the enabled components and features.
Additional support will be added in the future after validation with
the mainline kernel.

This series has been tested on top of the next-20241018 branch.

Patch 1 adds entries for Ciri in the MediaTek DT binding.
Patch 2 adds the dtsi files for Geralt and Ciri, followed by 8 dts files
for all the available Ciri SKUs at this moment.

Note that there are some known dtbs_check warnings, depending on binding
fix or driver support:
- sound: Unevaluated 'xxx-dai-link' properties: sent patch[1]
- amplifier '#sound-dai-cells' and other errors: sent patch[1]
- dp-tx '#sound-dai-cells' error: sent patch[2]
- failed to match 'himax,hx83102j': depend on HX83102J support[3]

[1]:
https://lore.kernel.org/all/20241025104548.1220076-1-fshao@chromium.org/
[2]:
https://lore.kernel.org/all/20241025104310.1210946-1-fshao@chromium.org/
[3]:
https://lore.kernel.org/all/TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/

Regards,
Fei


Fei Shao (2):
  dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
  arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri

 .../devicetree/bindings/arm/mediatek.yaml     |   13 +
 arch/arm64/boot/dts/mediatek/Makefile         |    8 +
 .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   63 +
 .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   54 +
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   20 +
 .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   76 +
 .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   67 +
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   52 +
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  413 +++++
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1497 +++++++++++++++++
 12 files changed, 2317 insertions(+)
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
2.47.0.163.g1226f6d8fa-goog


