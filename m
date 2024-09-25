Return-Path: <linux-kernel+bounces-338331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE7A985686
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B31C21636
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5F175568;
	Wed, 25 Sep 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b="ztcrrgG9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FA15A856
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257208; cv=none; b=Sk0zh376JShANQ1LNTF/Oyls28pAQ+Mdr52axvk8/wucYiExEaHHG2B74AFRNM5tP2Yh32BBc8L1c8Xle5hipQLXQJ+OuLZTs5osUDt9AEJv5kCRtWq5lXs+c9HlYW5UyEuFwBG9BYWYgiVbeV96u0Ed0KhventmqGc4OKxbkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257208; c=relaxed/simple;
	bh=HoHWhkKjPsscPX7OXwSPeS6ZpkBqZyV0Xy7Ph24Hs9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sbew7fRokPqowk+BhxFQsPN0VBKIU7Q0Bj9rkdl5AhfE5l6hB2fM0Dqdrs6flcgQXv5HEb77N0OJM6XXEVt2wfTc54O6VZmASBhMpq0da3ncDKhiaP0KT13OiziRWTat5gKvSpTQ8+X18xANLNR18aiZOmx7nwffYEw2D9yWSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b=ztcrrgG9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20aff65aa37so4564455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1727257204; x=1727862004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hVeQm3M9Kb5BEWPHPjrFASpqXLbXMnOU9Rk2NX8DNc=;
        b=ztcrrgG9GOCX5Qb3kiKcppvkbjG5pzcawKBmH0Ha5k6i8oaE5MjF2JhaBXnBzopFeG
         FjMPB3dU09x17MfnH8w+SXricwexg40cijrCTiiV9PL1qiyb7kVfe5o0Xy1FLQSZRgTq
         R5fUtpImVNn76BGNv9AnUit21TmLXYQi+TVGtcIBmzL8dtZlFgebd1tRtiLYeRV4VOs5
         3190iEH03UpHo9oHloES6/DhEAclmNQJ5DqNmxyCTvyeCMe1jUwHZwuP0rM3wWU95fkA
         saOtikiT2yj7M7SCuObT2r5vk56vGDGCx8Z5hVLkalMN/9MHdgld4IGgq6hqm7j/St31
         2OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257204; x=1727862004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hVeQm3M9Kb5BEWPHPjrFASpqXLbXMnOU9Rk2NX8DNc=;
        b=Xc6vIr4lagCRyBo0L59XPTAkcxbc4Uf+OPj2qhQRmz3ak60dBrvB8YQi+8+AaXVqpk
         fp4W+vUUhJHQiV/8KwgZV42oZD5P0Fwj+xWgu93aYEptJj1W8+N+thO9y/0WgG2SjAjD
         8MUQ1K6xM6yFbKT5NQInGE+fLQ6gq21MPnLOSHQyhjfX/p77W7IjzcELBZdFqWDfEktq
         pWXtcjp5x6PHgy6poJXWsGkB5s4d8HAdolW4OqrSU7L8a3XBb3Fua+hls0CN4IOfhC10
         yuYrwzFejSYja89BkDQqsO97BRJP2c4M2QPZ8hHkO+a40bNjBGa2KA32oUXS8ij+Nrgo
         34JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2g+YAklVHU5UE6zPQ2bpgn+ok85cuG8kNTI5a4TH5SNf6TAkfD/kOk+sgsL8rMNTBft313Gh089bxPBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpjdEJXMhkxJo5gySwNVsTjFG7zaAu5FAIrqn4NluT00kGIJx
	Z+GdrZdLOaro9lvhx3CGJj+hdOAYGJVMo18joxxQaNhjpIV4VC+icGnsXU2zB9TNqMscKzaeysO
	OCNbb0g==
X-Google-Smtp-Source: AGHT+IEcO5h5KcZFuc3iAGK66yGyxhN/Om1kVIyoX9CJW9qNJjpCSqoZx1payz3X0gYgWX71SgJidw==
X-Received: by 2002:a17:902:f68b:b0:206:ba7c:9f2e with SMTP id d9443c01a7336-20afc46b986mr28767005ad.25.1727257204439;
        Wed, 25 Sep 2024 02:40:04 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:a147:cceb:deb3:ec96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20afb021af7sm10037905ad.168.2024.09.25.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:40:03 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	"William A. Kennington III" <william@wkennington.com>
Subject: [PATCH] ARM: dts: nuvoton: Add UDC nodes
Date: Wed, 25 Sep 2024 02:39:56 -0700
Message-ID: <20240925093956.2449119-1-william@wkennington.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver support was already added but we are missing the nodes in our
common devicetree. This enables npcm7xx platforms to enable the udc
nodes and expose USB devices endpoints.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 71 +++++++++++++++++++
 .../arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi | 65 +++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..358b52894ac0 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -99,6 +99,11 @@ rst: rst@801000 {
 		};
 	};
 
+	udc0_phy: usb-phy {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
 	ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -179,6 +184,72 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		udc5: udc@f0835000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0xf0835000 0x1000
+			       0xfffd2800 0x800>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc6: udc@f0836000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0xf0836000 0x1000
+			       0xfffd3000 0x800>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc7: udc@f0837000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0xf0837000 0x1000
+			       0xfffd3800 0x800>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc8: udc@f0838000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0xf0838000 0x1000
+			       0xfffd4000 0x800>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc9: udc@f0839000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0xf0839000 0x1000
+			       0xfffd4800 0x800>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			nuvoton,sysgcr = <&gcr>;
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
index 30eed40b89b5..00615e7d1462 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
@@ -58,5 +58,70 @@ gmac1: eth@f0804000 {
 					&rg2mdio_pins>;
 			status = "disabled";
 		};
+
+		udc0:udc@f0830000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0x0 0xf0830000 0x0 0x1000
+			       0x0 0xfffeb000 0x0 0x800>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc1:udc@f0831000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0x0 0xf0831000 0x0 0x1000
+			       0x0 0xfffeb800 0x0 0x800>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc2:udc@f0832000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0x0 0xf0832000 0x0 0x1000
+			       0x0 0xfffec000 0x0 0x800>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc3:udc@f0833000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0x0 0xf0833000 0x0 0x1000
+			       0x0 0xfffec800 0x0 0x800>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
+
+		udc4:udc@f0834000 {
+			compatible = "nuvoton,npcm750-udc";
+			reg = <0x0 0xf0834000 0x0 0x1000
+			       0x0 0xfffed000 0x0 0x800>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk NPCM7XX_CLK_SU>;
+			clock-names = "clk_usb_bridge";
+			phys = <&udc0_phy>;
+			phy_type = "utmi_wide";
+			dr_mode = "peripheral";
+			status = "disabled";
+		};
 	};
 };
-- 
2.46.0.792.g87dc391469-goog


