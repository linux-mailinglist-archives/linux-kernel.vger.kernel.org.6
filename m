Return-Path: <linux-kernel+bounces-550643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4191A5625D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAF176B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA481C84A2;
	Fri,  7 Mar 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAV8f2Y2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB01A3A8A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335230; cv=none; b=crwcsSpP67j/HhIMB1xZN8qijqhCY4aJKh1PIqm9Ks/zzc7rkDqKCsTDjsnW0NQUFz3QujAqM4byPNM8cCYb5iFnbgO6F/Q3bCTT57B9FJdhemR8du69GSV36jjR1Qz/aCfhStFttEdRYnQb8KBRVFPtXA+Ax1dgsaHMdWDrLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335230; c=relaxed/simple;
	bh=/4pBJcV9vwScMlIQ+csYLrBtIODZkNz7iKtnSIY+mZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Id752lomhg9R5j8bb61k3nZzyynTtMtmZyWmZCHy205arOs0yjRLHWvEmv7cc22iBIiiIWHOCyOdhF8sxnhSXg7AKK2Ihlg8XzKlUAwcC4Y4g/gDkB8zMyHK0ksz2ivzU9j/VgKXPTd9Uvmc3zTru6yOFf1bpUPQ2KPzCikr9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAV8f2Y2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394944f161so1643695e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335225; x=1741940025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWHK9yli0arAp4uGJvEOq4N98UZnlQVuehVV6E0itOc=;
        b=cAV8f2Y2iuvujrQ47DZZBx0OZ/nQFhOmhwVO3RpEFcIqokUQNiy9GFxWeFOUmubrsj
         QpRKGDAo8PFR9RIou7TaM+I1bkGXo1yHFdv4ipHhJpDySsb+dH7ktsmOVshv7bG3CiFA
         ePfgOL0VaRCOZbpYBRuW+OhztWRqh3rAjTKCyrC99T2XmjtWPpybsMpbuUltPT/Vs2bF
         wSeXhkk5vCmk1LsfqNaZblUGqia5/Fw6oIGA2GTumZ3AvI8k58thqBEeGw6ddyZ7vuMW
         lSHAI643TNpeDYurYYhHWZiZBiiasne98Puaouw+LvKkRXfMfcxldNWIFRyj1BaAeIqv
         Bnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335225; x=1741940025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWHK9yli0arAp4uGJvEOq4N98UZnlQVuehVV6E0itOc=;
        b=XIBlJ7cbxS9vQrm4CHcUnx/kdVLeHmN/eSDkTAVzfrEjUZkHYTauczpQQa9m/WnTEH
         EVI/m9Tqg9R8ZI/G0dwqTetLl/LRzDzFrds5MrochKcPLw6ANAbdleeHmbvU9SsSFwN7
         9nJfZvKRQg3oZEOQkSelCbc9i9WF8bNY5mm7iQCkr9W9mfVsxLDDIkWkrq1ib1gZPZvP
         8HI4nOxezJeA4+NeT0GDpjAyg0gmC2RCU4YirAoFkJWOlZ9HOcIR8H2Rz2+txT6BJLqu
         tdoope0xCuZGqbVQvZZVFdVsmIl0qAvUQBI59P/tKghZfmY3+Xwd/GO+enCRJw6wxJy5
         rZUw==
X-Forwarded-Encrypted: i=1; AJvYcCViiGukvoYKF3cZPBhluzsMyUcTHBOSxNBv6tYuXPTV83MR/v/KIoDbAanRwukH2oE5jVq45KrTDAHzKPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzhyftLn5yJyOHAeAgxMKhu4GjWDsTsW9ufb8caMrs8vnzvwD
	KLuKBKB0caHWxpICE+Qd9NzBiwdKgfz/ydDfZDOacTzQjyWp+JabzLFRPThYkqY=
X-Gm-Gg: ASbGnctQdlTmIfAyDilxIUNUYppcG5ro0f57YwRl3vTxw48U9CcUYCzGpcNZjdpcCY7
	nxvLPbOmktNAj1c/iem2mH6WxIowsI5QGFw0AVFJwV28bkkuSjNInar/WJZ8jjJmy6S5teH/rJF
	0J5332ymK0cqJwcngDxg5z8S3q5WPL9QDXgG/ExOjHJO++ZNfpaW8onDsTbX13GjdbiTMEdZ4+q
	h08qx9c7s0vFVLESclmHBs97RHWIyUijH3tK84MWPYW1njxtdf4ZPF0PWenQZDCro2OwQkHT8PY
	uuUoVwGy0HzZsswAAh3Be2DJo14z45IsintBfsXTDZxkE9ncP7D6DK3gidI=
X-Google-Smtp-Source: AGHT+IF4UvKX11yMkyXP1QJeL56hmM+u2mk3Z+n8AmkHahFOQAmYaNbSy5nTjDw60A7BEfx1RoKOQg==
X-Received: by 2002:a05:600c:1d9a:b0:43b:d547:6336 with SMTP id 5b1f17b1804b1-43c601da744mr6450845e9.8.1741335225207;
        Fri, 07 Mar 2025 00:13:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd91338cesm62267155e9.7.2025.03.07.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:13:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: soc: samsung: exynos-usi: Drop unnecessary status from example
Date: Fri,  7 Mar 2025 09:13:41 +0100
Message-ID: <20250307081341.35197-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device nodes in the examples are supposed to be enabled, so the schema
will be validated against them.  Keeping them disabled hides potential
errors.  Only one child of Samsung Exynos USI device node should be
enabled.  The node in the example already selected 'USI_MODE_UART', so
enable the serial node while keeping second - I2C - disabled.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index f711e23c0686..cb22637091e8 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -191,7 +191,6 @@ examples:
             interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cmu_peri 32>, <&cmu_peri 31>;
             clock-names = "uart", "clk_uart_baud0";
-            status = "disabled";
         };
 
         hsi2c_0: i2c@13820000 {
-- 
2.43.0


