Return-Path: <linux-kernel+bounces-516669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4495A37598
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DD0170692
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA1194A53;
	Sun, 16 Feb 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0T6ZE3O"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D319DF4F;
	Sun, 16 Feb 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722378; cv=none; b=jyC3Wt+dVDsvysn1cNCVpCSs1NFPQK4tobO6xzXEbIT1VmD7Hgy0dTlNXglHq68reqw4hjg+SQii81WI5mIf8ofKRCfd7lWSLnHBncSeSrOEbaP3DPg5GP7FzNyjGD5eC8FZe2AYWY7NGGBkbnY73NGuMx7sxywKl+OcdBTlndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722378; c=relaxed/simple;
	bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgounfrGB8WqA5SOmbXGFf6tQ3G5pNjQ/3+Nq6JCYHk5E+uV4o6zC+NxQZZjCL2B41OhkdPYz6cd/rnIPy46bIy908UuYQrRHXDYeM3mkKWlXY+4u+Pl5eRt3oJ/WCuYwiW3QmOT6C2jpN5htt7a42jSJI7ypulJD20Pl7cBzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0T6ZE3O; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so553159766b.2;
        Sun, 16 Feb 2025 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722375; x=1740327175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=h0T6ZE3OOMAg7rRtSkJYlNXeASPPmZyC3bhFeeE5tZqVp6sPa0RAAZ2b103B95o+gY
         EOZX9v8yrnRAUjKbKKBSc18D8L/3avrzfoIzxlcv8XbBtIEPPNQQ4bzvJPPFdmZiblb0
         DW+r/liX2gIdxq6KpbUIw7l409m7bZtTN1kkMqSGjrkA3zmJxofcEhxwHgoTG81j05y1
         UTpmZ3Ls0aFSUgl+Y0nraV40FX/o80vSVSPkCuMsjgZGTvbG8Tq8DDfLFq0bbxbeLhXC
         cOg5LbixO+QPJE1pPhQEEJO7M5iw+pdUR5Nklv9445FJBsbowFv/4yF7ig5E2MN+slG/
         H41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722375; x=1740327175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=Z4d5zn4QiKiLsbyrXeQNPt7FqxRU22eltjjHqcsKJxQXpQMaz3xaMK6Oo2w6vU1WT3
         /lZ0ra9/H0TR4R3y7Q/NW8Jn/WH1LkBrPrEObNlUoaRCINPx5KWvYUcQW/ie7/jj3oNp
         +/kOL2qQzhFDomQUKnrHxtUDgxwPS1lVmj8ZxV4+AosCJdeQd2xWKzZj79uuKZ9CEW9e
         8X353CtTzKwZ6DxNIBH5GLViaQFaZtA4+RVZFRdyf+0mHwv5n/bF/ol87LLinyfpAn7C
         f5VCAET1IY3rpoNwMYlZAN1GqtOOZZnXDMKhD294+wW+r0eenr9SCayHx57XnHRN5vud
         dx2g==
X-Forwarded-Encrypted: i=1; AJvYcCUnAmrjdLN5vj3y1/qeEV8on3aK3pVn516DHnq72O9+63IxKnU5J5CQdnwYatvrbWPQ0zP2ScTrOdSr@vger.kernel.org, AJvYcCWt44jivuqkhQVFEVNomtMT3MTOubVyLdVykkDU67fqrIy9QC3ZYgn/472s4EO97FipwI+EShNaf9o/@vger.kernel.org, AJvYcCXO7RR0v3Exfs5XUfSYKZtQkKEZQGgsiF1lUuY1b0ac0CzMFdNIrOyBj6sDE0myaoXT/qbKmJ+FLjoyDtQK@vger.kernel.org
X-Gm-Message-State: AOJu0YziFOXamk7O4VuVhTqfuj/x+s82Jy3RIdD7BVtKAkJMoDDKxREq
	46HJ1z3QynEESPkyhDk+n6/vhTD3Nob4bJJ8d9uherKMEeWJd/zD
X-Gm-Gg: ASbGncuGls7g59fKCqKkVhUE5YP9Sdec0H7hK7F6FOcMG/V5WP7z7fHq420H1gZz2wc
	xzbYsmgzTroEQ4oABep2fna3M+NUxkR0/kwIKFRUKG8Wom7HdZHds2+9oesfHeRkNDxZVZiZeLj
	vNqcpJ+w/YfpmoZc6HR8GooirWAhS74XTTvhPRW0ucOJy0Hppl1g67x0BEfug5pCg+hC7gPoy0L
	ZJvz4PVoGvrafqjajAdYuHqG72E8qqOTKD5IRpMZb40QR5eAAOCj+pS79nHCYw5AkbLcX/cCHY3
	ySavpR8FR7qBEqTQYfIVOQRV24pCwRbpdgxsLA99wUx5bzCBL8qehGbptuW5HA==
X-Google-Smtp-Source: AGHT+IGwqKTsDH+xi82LwqocuW2doDAlH+8VSSlBb3bcZjbMekpE+N/zdNvrmDQSLIBrJw2oOy+DMA==
X-Received: by 2002:a17:906:7312:b0:ab7:e811:de86 with SMTP id a640c23a62f3a-abb70a95817mr720099266b.13.1739722374775;
        Sun, 16 Feb 2025 08:12:54 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm148463466b.161.2025.02.16.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:12:54 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Feb 2025 17:12:40 +0100
Subject: [PATCH RFC 5/5] ARM: dts: bcm2166x-common: Add matching bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-kona-bus-clock-v1-5-e8779d77a6f2@gmail.com>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
In-Reply-To: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739722366; l=2369;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
 b=WNxAo1QV7U6quOYCZ7/pRwvxwBviYdRpUrHiRTkzcgkUIgnh1nv+Uwn7xsTlo9Iu1PU8hKfx0
 zRarsHo1uAEBf5o8Nd2VlRhCqUBXn9FcqI5LbJT5fxRr+0oQbGOf+a7
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


