Return-Path: <linux-kernel+bounces-391996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086E9B8E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DB31C20C47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6019CC26;
	Fri,  1 Nov 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n+rGkGc6"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA619925B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455073; cv=none; b=As8gNXtmGJksHxHRCDJwGe04EdR4JYsR5CW7oHmmbyK0v15kf3QtXjyQSGaItixwWzv658+DYZWdu92qxNaw0RW6T6UUrjJb5ZGVxBQJFQQiWdg7wOIaV08DYvoKDawyEfLsUE5HRXT1QYJtEWXGQeEu/Qc6U7mswYtq/tiYgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455073; c=relaxed/simple;
	bh=9vzGrsVvgREwZzqZVmo/G/4tjM4k1gZZ+XTtE75S2Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRrtWkXp9YqWSarcuvZQrzyr++pepfop4BDhGUfvl8WxmVtGUo15hYFVLJhcFx8wv4PKtSPfu6940SQDpFA3Rr2RyCkpUlA2EDMXi3eDa4uaE4R4aohXE+o0BOCxQh3K+1fj2NIsD5NFTfSOS4QkaVWkyBkZ9fz1oGbUysiMytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n+rGkGc6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso2534313a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730455069; x=1731059869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQzVdoqdvqgLOFlu8gMxMsd1xizkEdv4aj8iXiXRzjU=;
        b=n+rGkGc637y6e0GNhWQc/89NJe+yfbBpnf2g2WBStJP3iItMcm7ZYC2dqg4GHrBehf
         4fLIOcQQLmLHObghcHFFHZ5wBAT6U0bYffyfqx0L/YQJ2ygjqXtfG6nw7tA991f+QgUg
         dHfGW+AZ5SGheECcKwn6xTJrle5AHkG7vJS+QTVKfkFyUeBlyjRu/iUfUNx8pA9PG8By
         Gv/bR8Ppv82n9aMAdkwj54usEURj6RJ+3bjGNCUnws53ZJtYUKmL7oq/qJ8sS1ntwD5M
         RZf0pZSZRc8gGe6O6zXpnNvL4URdliE6rYun77m0TeXg9nDu2e7K/QFT3avoJYBswubV
         Zr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455069; x=1731059869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQzVdoqdvqgLOFlu8gMxMsd1xizkEdv4aj8iXiXRzjU=;
        b=OOU/bKKfryeiXqswLjvKWZlNFU6qIiK6rLG3VWxOTh4DHGezNeNUW5u88HxgG5bCb+
         /mSJghuo3sVg0kxhUPjYHsbGzPl/ubLWaolrTSohe2L59DEUYgE0y/V6jr/SkgStTOWl
         cot9TLyaACuW621qULR14RI3QzdruK7ttYLPLeikZzLCA7rhrArTcW+oIQpQsdp+9kus
         PtZPFvc9+5VTS0k00rSmiP2iiBA2gyLMJAW1Aj7izvYygzl+aCQe2zpov1Jsfj0QnnVS
         0Fv/XTfga4dojssrbs6MlfgPm2ijQh58pm9qfQkQKvvLSNCCPz6JZPcOFvqwMPyPm8U9
         dgWA==
X-Forwarded-Encrypted: i=1; AJvYcCWU1kHfAG6xVyr6umOdOa74F5ZMUeKuoAj7VIohRL91iPdJtkhhdm9kU30sft+NQMaJG6x/Ue1/WVcyde0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlFF7Qey0Q+OHGDtO0Nj5Ja1VhwOsb36hk8zf0ixSFqPeDFY7
	oaag8E+fHrDsweVZA5IY7qEpOI4MzxFMYjkG6DSSVge9JKS3MLbP0MfII7lvHfs=
X-Google-Smtp-Source: AGHT+IGfg1jB9Gr5SknKQmj654bdZhqMhBEbjNXW8PNX7wmtbus6/mYgJoy7Q69k4vfLF7Q0z4tBwQ==
X-Received: by 2002:a05:6402:4307:b0:5ce:af01:6317 with SMTP id 4fb4d7f45d1cf-5ceaf016b07mr3408111a12.15.1730455068835;
        Fri, 01 Nov 2024 02:57:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d87sm1364136a12.76.2024.11.01.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:57:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 5/9] arm64: dts: renesas: r9a08g045: Add VBATTB node
Date: Fri,  1 Nov 2024 11:57:16 +0200
Message-Id: <20241101095720.2247815-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the DT node for the VBATTB IP along with DT bindings for the clock
it provides.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- dropped the status = "disabled"; for the vbattb-xtal node

Changes in v4:
- used clock-controller for the vbattb node name
- move the node near scif0 for ordering
- set the vbattb_xtal status as disabled to avoid having it exported
  in linux with frequency = 0 in boards that don't use it
- collected tags

Changes in v3:
- dropped the child nodes of vbattb; along with this dropped ranges,
  interrupt-names, #address-cells, #size-cells
- added vbattb_xtal as input clock for vbattb

Changes in v2:
- update compatibles
- updated clocks and clock-names for clock-controller node
- removed the power domain from the clock-controller as this is
  controlled by parent node in v2
  
  
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 067a26a66c24..a1d5084b074a 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -72,6 +72,18 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		vbattb: clock-controller@1005c000 {
+			compatible = "renesas,r9a08g045-vbattb";
+			reg = <0 0x1005c000 0 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+			clock-names = "bclk", "rtx";
+			#clock-cells = <1>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@10090000 {
 			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
 			reg = <0 0x10090000 0 0x400>;
@@ -425,4 +437,11 @@ timer {
 		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys",
 				  "hyp-virt";
 	};
+
+	vbattb_xtal: vbattb-xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
 };
-- 
2.39.2


