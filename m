Return-Path: <linux-kernel+bounces-552363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C8A5790E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCEA171894
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC51A2399;
	Sat,  8 Mar 2025 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuB2/1+U"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C01B425C;
	Sat,  8 Mar 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420263; cv=none; b=AeTRsoX11YOIZP2os9n100cOEXtb7ATTh8BIradDrbEioBKYK86xNOwVCWwCmVvUhTLj+F8mhD1h3B2x2EHY/NAJGS0WjmxnJdqdRtF6sNSbhyvGRJ5lY7zU2yiIbwo9KlUXeATam2x6oXw4b2P1QGoTaok8OY4/naws9o8z0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420263; c=relaxed/simple;
	bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFC9muVIb2NcnF6ph2KF7HlHk7wZewxSB0mI5ReUffpZRWDLntQmZWlcha7DT5r7LtoReHyWzmw5jRBXyoqoTRHpwUTScX/L48CMBHFOzPxhIrH1+gmaSNXoZ/VOQ5vqhEbyn3oKvf64NvJfsya7FRGwZ/IsqGlKEcod6VXjdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuB2/1+U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaedd529ba1so311473266b.1;
        Fri, 07 Mar 2025 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420260; x=1742025060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=TuB2/1+UTXUTnTepWshJ19WMZozFhuvXSwzEmzvkpo7E+aymgraz4ZfhiOoN5vgC7m
         gtidjo3mBx0aIR3KmYa/Mo35BUhFFLAKq7yqPfhRkq3tlRz1DlZylXFjaVxdFHQWCg6z
         TAIKkgr6EbdezYwXMzQ7t2eCuY1Zw/tM3A9cbTVETirpV9pqANclqF0IWRjLuy1DHvTq
         xAf3l6W8ft8F/HJqxS3IvItCjgnezlczztXQGF1U6wVZ1RdbyBcxAV9DhEebzooMx0nN
         +lmTRl4C321s+3Uo4UmEoOlu+dxh4Ges8fcKY//EnJSedVyZwF1APtbfS3Iz+EFik+Gp
         KPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420260; x=1742025060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=luvoo2vnv8QZzSlGdNo0a3yE3+ue8EEx0Gqt9N2z4UTJGLN/LSZTB7VkJezU6Cri+k
         UPNltwMwLzbJ42cPamzVZ/tMAJ/9lBNYydNV7MOHyfFmf0zswrlGeJqa07CiwZj+Zehi
         g1QLv1GIIEQHmrjjpvl4Dms5M7DavfKxv5kmUGUcA/MWiLIKUb5nfXTsT33ov1lXl/Rz
         MCk5WNIpGYshEyPhQIPbaa2CRlDtbD+WxF1G9MOV4Q8T3Q0lF2VGYP/Wfvv1w5b9o3FD
         i0t+4ScnRyW8qsOXQnuPpgiko2UjklTV5e++kmtbjnfmPl0TcddEvymbEkptGyTD81Ku
         LmoA==
X-Forwarded-Encrypted: i=1; AJvYcCVlTv7x64dX3s/SLuYA+/QuV0GvLLLGsdGJZPB4efoksg7DvgLXD4b/YqaZbprO7A3TmEhSKFTRwEcc@vger.kernel.org, AJvYcCXK2DwBFEdCiOF7UOnwUakE9PMFKlXVwz5m7MzuPcVUGchW0NXJUl+v0UfykvYscEnYCQ+U6EejrMtbgD8j@vger.kernel.org, AJvYcCXKxknLDRWT43GKQ8hFG6KaH4jZ8nq5wgYOY8/xL2GiJRnKYJg2I6zkbC5rhykka6BdEekNks1ZOTF5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iQrKXu9eO27f0rqLG2XRISZA7VMzJiyznqznHO3sVkuRGcMV
	VIOoEeZ3E5xV7TKotL+lxo79/E8+THirGMmbnwZiAJ6B90oRgHLI
X-Gm-Gg: ASbGncuOAkeRHQrwSL6GOEEnaJpJGmHYfTl88cKexBa6mEz5/j4XHKUVnSxDMLkhr87
	sqOfAbYjlhJlwUbCchBbLpoug3WaVo6ujlWdTKEZN3Y5rzD4VCmzM4NcHmOpx0ZC8HOwOJx4wt1
	bKite8IAc7KvgtJz1irfMtfrLLZvIec/88T+xq8kMWVwYnt72Wu4NHrZGj2VPPcxGI0NBssvpkU
	qij1ZK3RgejCNsQva08/ZxzoTZrECaabexj2RC0KmmSTML9HwLOrbZtU7X2slD6e7Ngjv5ym0oL
	f8aPjVwRYh6JZJ8R0nj07jdcHDJiHu2w6Wy/xaTgV1EdJW0HWWps0ugWBplffA2sA8oQlDQb09p
	29YXrS53lQiUkxymZJw==
X-Google-Smtp-Source: AGHT+IGpzlej2+Z3SXODAEzFJm8VdCZDsdM7lfDewREwNsE0MaBEO6TMznf73Bfd6qCYOF6NnQCOog==
X-Received: by 2002:a05:6402:34c7:b0:5e5:ba77:6f24 with SMTP id 4fb4d7f45d1cf-5e5e22d4c66mr15989484a12.16.1741420259465;
        Fri, 07 Mar 2025 23:50:59 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:59 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:47 +0100
Subject: [PATCH v3 9/9] ARM: dts: bcm11351: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-9-d6fb5bfc3b67@gmail.com>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
In-Reply-To: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=2485;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
 b=S+ne26yjaEAziJt6Hen4F5vs7TSLH7eYElTQDr9fk1DZftrPd+kqW3L5pMCzrsr7+4mX6a+sn
 7X4Fa9Wk3wgAlInT+5Ko+cdi5XYnJ27HGfnFrlL3Q8a41p3JG+Xn7BS
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Following changes in the clock driver, add matching bus clocks for
existing peripheral clocks. Replace the usb_otg_ahb fixed clock with
the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 arch/arm/boot/dts/broadcom/bcm11351.dtsi | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
index 53857e572080d752732c512ed27f942756d59c46..fac5cf5a46bd9a4b7e09a2e65c3e807d1b4ef960 100644
--- a/arch/arm/boot/dts/broadcom/bcm11351.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
@@ -233,7 +233,9 @@ aon_ccu: aon_ccu@35002000 {
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer",
 					     "pmu_bsc",
-					     "pmu_bsc_var";
+					     "pmu_bsc_var",
+					     "hub_timer_apb",
+					     "pmu_bsc_apb";
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -246,7 +248,14 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio4",
 					     "usb_ic",
 					     "hsic2_48m",
-					     "hsic2_12m";
+					     "hsic2_12m",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_ic_ahb",
+					     "hsic2_ahb",
+					     "usb_otg_ahb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -262,7 +271,17 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "pwm";
+					     "pwm",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "uartb4_apb",
+					     "ssp0_apb",
+					     "ssp2_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "pwm_apb";
 		};
 
 		ref_1m_clk: ref_1m {
@@ -325,12 +344,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-			#clock-cells = <0>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -396,7 +409,7 @@ usbotg: usb@3f120000 {
 		compatible = "snps,dwc2";
 		reg = <0x3f120000 0x10000>;
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&usb_otg_ahb_clk>;
+		clocks = <&master_ccu BCM281XX_MASTER_CCU_USB_OTG_AHB>;
 		clock-names = "otg";
 		phys = <&usbphy>;
 		phy-names = "usb2-phy";

-- 
2.48.1


