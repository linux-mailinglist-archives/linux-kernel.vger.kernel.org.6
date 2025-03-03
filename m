Return-Path: <linux-kernel+bounces-542709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E78A4CCBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F82167B86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D823BF90;
	Mon,  3 Mar 2025 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCYXysjQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCE23A9A3;
	Mon,  3 Mar 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033687; cv=none; b=aRqNQHyZ5wT59TXlir+umRjK+aTuvcuPH+LgmVitGd0XNrghstHMhz7d3Or+IZDKDM37tZfHcUp/Yf2rRJ++zS3Zr+CifE8TdPGUkiXHz9XxX56plwKgCYDgfXKxUvlU4Hi0sg3BkeVVKsgbpxuBBD3Dxxmv3lMdqgxGjj5ooKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033687; c=relaxed/simple;
	bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJSjaPHuLyLGjM3nfRZhpGuKQFUhuzXGEaXxFlxdro9Cw+do0kg19tCwJDdWP0jUDZtC7n+HGwuRXqpF5SfN/SrXjh/7E51sn1I+tVNRXx/ASXIRNYFNT1aWZVXG+Snq92Feh9/Yfr3YpYoo5+toaCZ8hEb2t+Jm/tToUszrs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCYXysjQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf3d64849dso407657166b.3;
        Mon, 03 Mar 2025 12:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033684; x=1741638484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=DCYXysjQCRTQ7y5wKcyJBOwiBZqq+SDx7PFQ1AM5sbWGNV1u2vBUch3TqZ7znHO3Hh
         Dw6oH6roex857Ng55mlgcl4GGlQJGUvYifOqmmuWAhacxtuYGT/+20rKvxwb1Dt7gIbt
         ExcyakJRBfZ4wlBjXF+dXlYIn/RhSln0CkW/efUNjvCpN9wjvLwBC2N1dNcLDJpwRlev
         wdByqFRXLaIODeO4UKmArQ08C3sjw5Q2joWiWg+ZfBXMW34HeL5GpdspB41xTsLz4kqK
         AjORdMEe+IWQJs/PwikqEsNGJKeGdzPc1WDHdHT84bP9bdMy17LaZQkvLJMI+XN47vvz
         bOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033684; x=1741638484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=ZLB+//g9+orUUUNBGkwwAo/ozka4hqcs7P8DgLFJuGE8Zo/XSyPea/QFvvMrukIg0n
         5+u9B2yzXx65Il4yKf+8Mt5ZowOzaVN0pgG7Au6Y+pFM0B3/86xsjxCIvfIJbAn+FFNe
         U+MqRL4TkZM67/eQRBjSPULl7ob4zPOsyQ7wFXTr60NQuQv02lokHvQ/h5E2HGBByre8
         9IT7vlA2Uc/HUEtn04JOYx3f4VnuMpHxT0+8uzZgFKgVGe6sUtxkwJXT6UuC0TdgvAff
         uusDSV2bT+pFVJWcf9hYYio0kGmQr3yyS8EggN+RvKq7hQkAkPoaY2i8vfMaFb9ePF6h
         M4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUXTwQiFn37WEUhvX/t7CWTn7dMxPFVTWIgIUBOTk/Eaxkhn9IJPmT7dPIDacsj6KufIS2yQZ7jNgEf@vger.kernel.org, AJvYcCX3YQdAgF/WlkHFCIA3tb1uzoMsZ1Wq4gJu24Y3GpNw4dILMB/dSVGPtesbGIf+jYzr1ekvDDsvbPjp@vger.kernel.org, AJvYcCXyScv4EiWwqhKobCD5BmDB/bYdmnv9Tzu9tcFE1T5tUkAI7JGyEDSoeUHVUeTntglBAGJMTJ9Yv9Uze/0I@vger.kernel.org
X-Gm-Message-State: AOJu0YywPu5yuXO4XhEuwHwODnt5bSJzbz+dMVHhDTFTbER6SlT8UUOU
	+HJSDV/x1n01unFpBtAilcyM3N/pJ1ft6Cx0HtwAVxmWdIyicYb9
X-Gm-Gg: ASbGncsZCBbFbsWUIKrqKbhDeIQH96HJbfx2G23F+FJuLR3GRAfib6jkG0DoEgdxOTB
	aDvzKoTL1EcGNms4Rn6gNgfnQbyerdcsWILgChkMvvbXMkZbTReI7phtc7npSJInkBzKH6Xnz/t
	zDb+3BvNqKlbk+rkknHCK3L2+qBLDlWgFLF+2mnpZ+tr2QYszUtVgviGS/sJ5gHFT5jVAgqtI57
	mytVaRSWGSic9P34EeYfH08jlta00G+iECpAJUDDt6/2uUDl50ackJJMTwjWzK6bhv9+Sz0QQTl
	pp9M2eoOSMMci4jt7x6F8xAYipAks4JfT7ILemLThybhCPz+g3IGPM8YlAKwCWNsapMFjuGgpYE
	cHSGXv84iZg0qAc8=
X-Google-Smtp-Source: AGHT+IHmgfTl+JT1LdQ7tmYayp3tTmg3vOw1BKoMq/OPWkP20+6xUSJrrbxqgzwTvMFl0OSbJMPzeg==
X-Received: by 2002:a05:6402:234e:b0:5de:a6a8:5ec6 with SMTP id 4fb4d7f45d1cf-5e4d6ad8686mr43033685a12.10.1741033683155;
        Mon, 03 Mar 2025 12:28:03 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:28:02 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:54 +0100
Subject: [PATCH v2 6/7] ARM: dts: bcm2166x-common: Add matching bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-6-a363c6a6b798@gmail.com>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
In-Reply-To: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033671; l=2369;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
 b=Odv2sLANh2d6ka+DjfsY7HCNmYuW6Je8IjqyY51c+cI/mr5IqiJ1/SHf7CMGM/tPjm8h6dx7+
 gTXCK9e1T4sATVwTnhRl6IdjponjiiAW0i0MFfOgdpDZ5Q63YLEgVFI
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Following changes in the clock driver, add bus clocks for timer, SDIO,
BSC and UART to the DTS clock output names. Replace the usb_otg_ahb
fixed clock with the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index 87180b7fd695e65b52c52743e6315cbcca385fba..ab6ad8c6d326171a6da1762ecd839bd82e9da482 100644
--- a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -143,7 +143,7 @@ usbotg: usb@e20000 {
 			compatible = "snps,dwc2";
 			reg = <0x00e20000 0x10000>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_otg_ahb_clk>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_USB_OTG_AHB>;
 			clock-names = "otg";
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
@@ -248,12 +248,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -301,7 +295,8 @@ aon_ccu: aon_ccu@35002000 {
 			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
+			clock-output-names = "hub_timer",
+					     "hub_timer_apb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -314,7 +309,15 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "bsc4";
+					     "bsc4",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "bsc4_apb";
+
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -328,7 +331,12 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio1_sleep",
 					     "sdio2_sleep",
 					     "sdio3_sleep",
-					     "sdio4_sleep";
+					     "sdio4_sleep",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_otg_ahb";
 		};
 	};
 };

-- 
2.48.1


