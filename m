Return-Path: <linux-kernel+bounces-366580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59D99F74F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB401F25191
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088721B3953;
	Tue, 15 Oct 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O9b57Osi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD61F80D0;
	Tue, 15 Oct 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020562; cv=none; b=H2O4toc9HtqBcfGDeG9WEERm1x8ygtRJt48M1/Z67GINtUQz6dfmWUMXrFdknEMqHHfLpDz6X/U/FicDpVoc7We3BcjvvUFWacGweTJHAdLSXsw7AMjjFfDMqJEDBtKj46+wyglgF1WIZTPwNBxWc5j1YkekZHa7zKAFo9ORATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020562; c=relaxed/simple;
	bh=T4QxYgvxCjcejnbOwMByRaNGZltIDpS2NRTCBzbkFXE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WRiFpT88TRjs17AfJju+vGnQq/5tIFPJA7VFAjvGDNJ2+orlh/xxbSCHxSAYzCzhIeSjDGP37/RyBAsM8SSBeityCygkWf6YAo+KSe6U2JULmYVlcmTHVtl2JxPZXwoNMlURPt4ZYK20ruZ4r3vK1mcQKSLtwiEDDGTPvbdo0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=O9b57Osi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso9944911fa.1;
        Tue, 15 Oct 2024 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729020557; x=1729625357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffK46DaQHiPwkYw7K81WBqFGG+/9qPysfgZJJ0kG6Pg=;
        b=O9b57OsiKaU7FkXKgI92amkz1ihyi2pXXoD9QTvHXp5gbngYrqhaz/2c/5EFPeuw/U
         tYmrYwEqWP1ke1FqIDE9OrczXfxvZknw69IpxK6R/pSyBs2YruhLIQ75GHXpqRNZPzEB
         V3FuMOM3uZ7Zp5JRjkm9wSfBGm2YMerHpvHifAHVvmqPxIi5uceM0+DWyH9nQ3651ij3
         1veTfgLM1viMbxV4ojnkCllDCnsnger2HpL7v+o9dK7NhiowFKWbgesZeibQMyGGxVWN
         0q/aY6x/GoF8c2yAcfC4bVVyBzX7j5qyqhhewO8eUM5OCUOasW2lcc0/bfxDE0pbYVdr
         ONYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020557; x=1729625357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffK46DaQHiPwkYw7K81WBqFGG+/9qPysfgZJJ0kG6Pg=;
        b=E2lJntDK2+Y6D6UbUZSHfllkElrPjbHkCB8QUpdHJRGgBMChRQF87rzGGyOFMp+9Se
         CBtKTZSApsIXxDQMiHTZwIlVEVQ2TXr6A+hLs21xxM/O6N3iCdh6UrITrCwvHMkFUxTw
         ae05IDADMCqUn+mFxvOPVGoFj8CDD3Nc/I+QM31OfPRZ+OOH0ildG/Qj6ONrvR4hcZw1
         BZaVmDrDWveFG5O8nTIq04M9FSOgMBhIdLBcd/Ax7ppjDIsh+edciffj4f1Ybg04gvmw
         10AuNo/UGs0Xqia/uDkLYw2jEL5qtkToR42OZyP73is6ddOLZizm7MMugILJ59PNtW4F
         lNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWesQCdvdfe6+i4nnwc3Ts7+zPqOwIYr5cVbr0vw99+F/qqUrIIIQ0dv+vFRC5+O+dhQ5Me5ggQEGUD4uZA@vger.kernel.org, AJvYcCXgnTG6kJgtoUr2T1o5vChyP7+86ikkYiTKZHrNcxW+zRy+WZBIr4ep6eud3XxV9o9TSrG2BubEiEZ8@vger.kernel.org
X-Gm-Message-State: AOJu0YyGc+qDlVLjgJeuQVzx/L/A8YPTRV/tF215z8UNFkbRzT4hb+jr
	OB9JOnmkjOuxBlAAFQW4yRAaUQBZmlQLJNsT53R+QYVqbAQU55V2
X-Google-Smtp-Source: AGHT+IFbrG8/Thtvhxtu7bnxzwkT21F5l1gDv6pnVsJtlEKHnm6G/4UsP/zlXdJL/d/sZR3je+Ka+Q==
X-Received: by 2002:a2e:a542:0:b0:2fb:6169:c42d with SMTP id 38308e7fff4ca-2fb61bc0be8mr11584851fa.41.1729020556456;
        Tue, 15 Oct 2024 12:29:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:43a9:8917:3db1:25e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f857bsm983917a12.21.2024.10.15.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:29:15 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Tim Lunn <tim@feathertop.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	Jing Luo <jing@jing.rocks>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
Date: Tue, 15 Oct 2024 21:28:35 +0200
Message-ID: <20241015192905.28969-1-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the Xunlong Orange Pi 5 device tree binding with an enum for
the Orange Pi 5b, which is implemented before the device tree.

How does this board differ from the original Orange Pi 5?
  - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
    slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
    for the WiFi.
  - The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
    "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
    hooked to BT_WAKE_HOST.
  - builtin eMMC storage
  - no SPI NOR flash (u-boot, preboot etc. initiates
      from within the eMMC
      storage)
  - ap6275p Wifi module (like the Orange Pi 5 Plus)
  - builtin BlueTooth module

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c22..62bb6587da8f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1051,7 +1051,9 @@ properties:
 
       - description: Xunlong Orange Pi 5
         items:
-          - const: xunlong,orangepi-5
+          - enum:
+              - xunlong,orangepi-5
+              - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
       - description: Zkmagic A95X Z2
-- 
2.46.1


