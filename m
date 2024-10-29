Return-Path: <linux-kernel+bounces-386649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C149B4656
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8421C2237A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF020409B;
	Tue, 29 Oct 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YILfGrWY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBE1DED5A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196154; cv=none; b=p4vBlteYb3oKoozCvnGHYL1D0UcJcZCy11uuXZd+LWz38A8wsWdfUNlwxXxyFcIBTI2T0rJYnK2G9n+69BgsBIz0dnqPmB3JkLZQ6lNo/f3YnaCwH/zZRke6zz8XZ6uMDNFcW0vrRzgaY0/MkXbL/lwN/lCnjYH+9If+YiiKPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196154; c=relaxed/simple;
	bh=V9yrLlvpjMhAOtTUuzUbS/PuBDjwNV+agqaeXIEXbGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAMVlbh5imJ82sVh2xZrHyP9vPIduRBFdw0RA5aa1nVQAPzeWSkjSm4o5q60FlTnXwIjej2nx/mjS9gpCDbVDFeZja33JsxPf40TEn+5YaWq6GLxdkvEiCI/7PrNtDZrmdV8kmqbBvM4Sgt7rwmY49cKjFThf44Kr9Gl5eM7KeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YILfGrWY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20caccadbeeso56687955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730196151; x=1730800951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dP0KAMyVWS6Yj9qu9bHMDh95jkCq6kFe5y2/InwDUyI=;
        b=YILfGrWY7CaTHRKCIRw5iDpaRqxT0fAn2HQ59GqNawfk/lOIz4lBD7RUcGIrGt6W4g
         bj/nEROdOS5UCy+rQFPY566tNNFFg6pvrUSlD9YxqklHX95BqgmxC97Ymm/F49wza42d
         34TqaH1mXPKoIgrQOCnMXoE+7WwSuPOirLiQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730196151; x=1730800951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP0KAMyVWS6Yj9qu9bHMDh95jkCq6kFe5y2/InwDUyI=;
        b=DYj40gdM/re0A3+WUUe0deDQk559VDkmrBw3yFwTwSTnEURHvs2qSQ7o7RrA/IQm9v
         XRuPEpiodMrBF/oEysx3QDlnzIDMD1zDmzX+RVU/DxbsaULcoXnfbrV4SSc+8dMAdthp
         l9mafcZBzl/BcJPoKcCYkI2acx2vI4JW+W3pqfGWfjsARUbnKJLklYgiQI6KldQ6jJrU
         9oE3YS2S78Sx0K8JwAX5iAs/cIilyi0W2lIH0rWIXvFtF6txd7jJi/hyVLQZ5mdMHvCe
         i5phYh5x8RYiIct3AFNux1HQGUvbqS5kwUOoIMlE896C+xGFQ2q/10xNHUI49C84eQzm
         +JeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYyELBXRliJ5cf4ncgKUu0qja6K2b+asINRYelWAt78cGrsVAOUYbTTEserH8J0+6GGMj2sxEsmpaYaQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvsKqx3PuVUoN71chp8VWtL2sOFY/AZXryBgbUwnQy0hnDTZK
	G8/7nbzkyspcBXEPWKjfumDneeHY9TMXh1QXfSLgvfTBXIqFlEhZBJqOOuvMgg==
X-Google-Smtp-Source: AGHT+IEVCUvA4kLgKRzZ3vDr/KBHeqsWpmQJtKxeUYRTf/PK4hHx+6K7t3YF7nEmIdBRHb+IdCV2Zw==
X-Received: by 2002:a17:902:c411:b0:202:28b1:9f34 with SMTP id d9443c01a7336-210c6d3c766mr153604875ad.56.1730196150884;
        Tue, 29 Oct 2024 03:02:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1fef:f494:7cba:476])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04532csm62785665ad.254.2024.10.29.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:02:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset line polarity
Date: Tue, 29 Oct 2024 18:02:25 +0800
Message-ID: <20241029100226.660263-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset line of the IT6505 bridge chip is active low, not active high.
It was incorrectly inverted in the device tree as the implementation at
the time incorrectly inverted the polarity in its driver, due to a prior
device having an inline inverting level shifter.

Fix the polarity now while the external display pipeline is incomplete,
thereby avoiding any impact to running systems.

A matching fix for the driver should be included if this change is
backported.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The matching driver change can be found at

    https://lore.kernel.org/all/20241029095411.657616-1-wenst@chromium.org/

 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index e3b58641f2c9..43c83620e479 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -422,7 +422,7 @@ it6505dptx: dp-bridge@5c {
 		#sound-dai-cells = <0>;
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
-		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 177 GPIO_ACTIVE_LOW>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.47.0.163.g1226f6d8fa-goog


