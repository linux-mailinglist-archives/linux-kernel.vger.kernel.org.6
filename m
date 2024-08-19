Return-Path: <linux-kernel+bounces-291413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315D956240
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5727E1C2151B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EB155A21;
	Mon, 19 Aug 2024 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnR3cvO6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF414D28C;
	Mon, 19 Aug 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039818; cv=none; b=qhIbxRFiB0yR07WGGYuRfn2Royv2IDAdQO8f5NdKKFYMIkNW3crIy5z4qi6JhVcce88bPJZ2RJrCBlfOh8gLeMC7IvPdJnQTO8QGhGhYkNUx/jzNEl+Sy+qjKs8BP6F7Ryu0e9xpZEOWkOHc5eWbVca5pXK9oL1/uEZeA/alSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039818; c=relaxed/simple;
	bh=TZA1uRiI464LVpT4eMffB337cI8ih8IPC44aFYfbi7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TU9F/Gcp38I02ehllbtRnsoEvviXi8zUV+GuGgauAP068RO39ZHaFi6CX5WlTJUoEs3ZTHSDiFORkIC7YILQpIoZ8gWulduyMlhrnI0ot1mD9R0mQWydPK/0/hWZ46lyMtFqpKt9OjDWWcgbZX/0/P1LiA6k4YhhcsV1okJl2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnR3cvO6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc611a0f8cso28552295ad.2;
        Sun, 18 Aug 2024 20:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724039817; x=1724644617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7CqcOuZDb75sy7+rOEgJahiFqYT4oGOo9E7PnEA6vQ=;
        b=JnR3cvO6hx9cDWvHyWUCf6iLx5tlkYe5UrqZDRkQu0qCanD4QZt7aB3e1vEFLOg0OT
         ByfMAi2yTa0ULYvtRBfPU0AMUUQTDp4XRbjduQFZt2ImzWaL8bYHfbRs5DDmXyqFLl+n
         SnIBqjrwzdrJv/Sz4PM0/JBlOvkPvoTe5+PNfkhBJJHFl1ivqLca0UjeljiMO8kzcpkY
         VMwZ8TVWlsE2Gl7KpwYLzQRlFeXAHFimDm8Bm/qBbocmE3FOPIJZBX3ht4qzPdXje64/
         THhLWKlYobFvzm63+f86D/9tFYXa+ZEI1TvG1/x0sqV5gGYW41DPDPXJnek0viq+D4jN
         YRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039817; x=1724644617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7CqcOuZDb75sy7+rOEgJahiFqYT4oGOo9E7PnEA6vQ=;
        b=HGJ2VSqXFqqCKAVBA3d+daIaEDaKesv9pm4fBxIEoj6PVm9hA/JKOKbNEQ5a6LD1bE
         /sJRMwPglk7oSzwQEKdWXJZ8ynjdPT6TOz9VXC8NeHKAlOM2W5CY6DQb9QJ6Mqx8MU0g
         02zySVGToVkX5cKvplFkW188eGpmwj1Pg6JTFrNYvfNQv1XbKCvzM1yX4KgBolsZjsEU
         f+Fi96l5n4k9BGnbjUj2/b0XptYGidc71m6hpX6j2ryRbE4Ys4lljVhDUpxne0CJ399n
         bz/DePWfIh0+UTYU43ihrV4paDWYLg+U8EI6r90TIW37dUcHBf3wSAYFN0p5mZOBwLe4
         nmpA==
X-Forwarded-Encrypted: i=1; AJvYcCUrC8L0d1GQ/ZrD2uAkI/lUInOGVwmhSGVWGii4dl7hkOGuLbisCylcl8LZUpPmRimQlc3HsBW7IBxJLBsYQ4L5lQnWGkRQBmH8/lA/qlsiZnTeFifhFHk6seMmBlkynEV2SdMm8orxhw==
X-Gm-Message-State: AOJu0Yxo+JPLs/m51zlebrtbgI02NuX9MbTm4Eim+E1sGgZ+sloLc3Ww
	sV2kFXYCKvbUZNAGlKSD8KW4S1JDsQxWvYjx4iL572ktIK0A+KmPMO9YUg==
X-Google-Smtp-Source: AGHT+IHU3gTDF66CcveSfeiQQiYyefEN8k1+ovIorB/+adjVvyzhffeIf5B5McTX4Ndz9vCpa3LrFQ==
X-Received: by 2002:a17:902:db11:b0:202:4d18:9df7 with SMTP id d9443c01a7336-2024d18a21bmr10607375ad.33.1724039816578;
        Sun, 18 Aug 2024 20:56:56 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm55784435ad.124.2024.08.18.20.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:56:56 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	schung@nuvoton.com,
	ychuang3@nuvoton.com
Subject: [PATCH 2/3] arm64: dts: nuvoton: ma35d1: Add pinctrl and gpio nodes
Date: Mon, 19 Aug 2024 03:56:46 +0000
Message-Id: <20240819035647.306-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819035647.306-1-ychuang570808@gmail.com>
References: <20240819035647.306-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Added the pinctrl node and its subnodes, the gpioa through gpion
nodes, to the MA35D1 device tree.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi | 149 ++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index a6b34e3e8b10..e51b98f5bdce 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -95,6 +95,155 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		pinctrl: pinctrl@40040000 {
+			compatible = "nuvoton,ma35d1-pinctrl";
+			reg = <0x0 0x40040000 0x0 0xc00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nuvoton,sys = <&sys>;
+			ranges = <0x0 0x0 0x40040000 0x400>;
+
+			gpioa: gpio@0 {
+				reg = <0x0 0x40>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPA_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@40 {
+				reg = <0x40 0x40>;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPB_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@80 {
+				reg = <0x80 0x40>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPC_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@c0 {
+				reg = <0xc0 0x40>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPD_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@100 {
+				reg = <0x100 0x40>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPE_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@140 {
+				reg = <0x140 0x40>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPF_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@180 {
+				reg = <0x180 0x40>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPG_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@1c0 {
+				reg = <0x1c0 0x40>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPH_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@200 {
+				reg = <0x200 0x40>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPI_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@240 {
+				reg = <0x240 0x40>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPJ_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@280 {
+				reg = <0x280 0x40>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPK_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiol: gpio@2c0 {
+				reg = <0x2c0 0x40>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPL_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiom: gpio@300 {
+				reg = <0x300 0x40>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPM_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpion: gpio@340 {
+				reg = <0x340 0x40>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPN_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1


