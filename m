Return-Path: <linux-kernel+bounces-330317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABE979C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5211C22BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926F1487D1;
	Mon, 16 Sep 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQbJrijO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D5142633
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474131; cv=none; b=Vi/RnPvDG+5IszH846Id+zCtNg/Kky2uuJX+ShAs2rIuimdjEqb79f0nzBuJcudHzJWspRhdtRnVrQ+hkIuHhzKKChzaNjcaf2gou+gGkNRdkvRWBLGC9+hN8nmh5UEYkrzefj8OG12UuXKA3+dZCOyarxsCtLKEoH3+jevYeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474131; c=relaxed/simple;
	bh=SZYBb5Gb2zyHYcoisQWNTlkCB+hwRbA2qHwkFS7i5yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tlxiq/JLT0DEmTrmSP48m0IEGhOF6bI+VBRKw6V2TKUUqBUUm7jT0AReyqiEALDqOvGTwas8hf6v/zKNYwJrv+bsW+JYj27MkYDi44lmGJ0hzWbzj6ni1C8qMSr/M+IGVx03zEw8NMzZVHcEV72qFFVLi8KXvy15rWEB3MzUIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQbJrijO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso33771575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474126; x=1727078926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjHvRnnGg0bWNf9pKNsnu85764WCsCk+dDWy1pJT+SY=;
        b=lQbJrijOPtqvRltr6osatgurDLf88DqSwQRG2PHgzKytIwwmNBDC9opesHM+EYw6vN
         TWl7rRUvJDWuALhdqq4MB1lAgP/7qFJYSkL53IuHDSQ/7foe0oRshnxxjr2KYVH5aSV+
         xOAubpmIwy6CTsKoCieitQyYf+/vpQFutQxC4KogjbXte+lFnGYS/zW1o81RAODrFBpz
         30ZaLcyENMv4pD+Nn1tV4TkDegtga4k61fg33jGraWk7834YZ8ehjmMKurReHHq85QwM
         EzudAlN7FpR6wiUsdLe+1Hcsh/fFew9X6Tws23EEJuwWGN391hBjWlm6ilawDScga3+Q
         G08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474126; x=1727078926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjHvRnnGg0bWNf9pKNsnu85764WCsCk+dDWy1pJT+SY=;
        b=OdLZQovqsECVP6xf77UjSFjixNCPniCAT+xgUsItZoiiHiTdZf9IYmRIZtgaW2SqCK
         qvmNhyK4vqKZEEZvy2mnbZ/HqOHDdEf6q09aOFVBO+r18e0669HrT93CCr7mQxBpfwjY
         THJ8PQkHs+srL0xcMkhKSIjt3z5bu5kuLFOQn023Wb/0i3653mluGLBGhC4Vh4ZFKEas
         mbD7WXRmVytuf5rNDSC0VH71j/1uBme7xGIO3ADyAvZNhwNzsCWR/ZjyFaoLq3vXmWNb
         07OTTC+qr8qV4/NRJcDJoHzPvIKwR+wprX9xhipj+HEoQPNxzKFZGrH7NIFcmQXmNyIP
         j6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUviNe9RtBo05pSyAV7dvtaFkKHNuIXcifg9oAz3b0smn2tP1Lde77ZDMaLgWqUo6SODSVvcaizjq2VKLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SeeJTVenvW8FXfRctS9tvDn4mNXFSSwhHAzFSopjNTNXBjMP
	blaF9JOZJ3UaJ5TwRcJQ/iTijC5v3N/LT7N9PN5uTKKZmj2/6RSU49Ka4SlIUIU=
X-Google-Smtp-Source: AGHT+IH5Z43MBwfJ0oR7s8OXfSkb8OAaelpuDzn1yKcbKhwrYc3YbODjgMPSI1wZr+LELZcpdF8/0Q==
X-Received: by 2002:a05:600c:3514:b0:42c:bae0:f059 with SMTP id 5b1f17b1804b1-42cdb531943mr102665445e9.5.1726474126306;
        Mon, 16 Sep 2024 01:08:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:33 +0200
Subject: [PATCH v2 04/11] ARM: dts: amlogic: meson6: remove support for
 ATV1200 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-4-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SZYBb5Gb2zyHYcoisQWNTlkCB+hwRbA2qHwkFS7i5yY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eFFhvUQki0w6tRrd2l1gzQUlpb/3hbDUG3jH5I
 LTX5UfyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhQAKCRB33NvayMhJ0Z+ND/
 0SAfO8+X1qM06OGjhuFtpf/fP4LVyI2nXl/PtDn9Yyvv3J1PqnGG19c1lPIFfSrWpOuAY8RuzIGTKm
 JHo5YW/leThE8feMOl/C57ZRuoZ0Dvzfx9KS4CRsGHT71F2NGU/4WbyjTqv22uDtjjpB/5LRKfYy/U
 EwxlVDzfuHEvvpfvqwsz9izCcQ9T2oVztqAVQyGN/KEvvB3r+yKkmpxtgB8xQCX1kl9g7BFJSH8ngD
 E+baT62i8S/eeVYauQDsZpicoQADtbCtKzTZ7IBjmwQ41bDupbphVPu7IHPyKQ4CJdAE8ntkKT0g3Y
 hv47sthPAbNh3Aa+KYtC/TsnOvL8cPCPzV5kCjvASdLl7bJ7qpZwr3leGJhuuoAwSSOLj8+WrDEbtj
 Gtts4thLz0SC4hHiaSlwM5xvpEzWpMk5+LhPgwu6FWOR3KucxHPZfdJnpbjGq+m85Zl6C6RDBFHv6T
 epGCF0fpKx5hqgsxy3kpKzA6mwLdlaSs5b3Yi5YxtgWaCG8XtLZu9Oe/rxNTEQE9XOd5WvAIBHJW+R
 mrDj+C1XB2kKOrWY1/nFOMAMpHoD/Q6AQIHDuZSsBm4RUrJIDM790RVSsxbdgTTVe2d+ZaRr3VV78U
 Hsx/mYQMAk/QwFS3oI5o+2e4lkM2II3cESODCmLTbBVwbFXc/+T+QgNs6RBw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The meson6 atv1200 has a lot of dtbs check errors, but since
no active contributor have any boards with Meson6 SoC, plus
no upstream GPIO, pinctrl, clock, MMC... for that SoC either,
let's start decommissioning Meson6 support by removing the Device
Tree files first then remove the MACH_MESON6 in a second time.

If someone is interested in Meson6 support they should bring it back
along with a few more patches for upstream support of further
peripherals.

Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/Makefile           |  2 -
 arch/arm/boot/dts/amlogic/meson6-atv1200.dts | 33 -------------
 arch/arm/boot/dts/amlogic/meson6.dtsi        | 73 ----------------------------
 3 files changed, 108 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/Makefile b/arch/arm/boot/dts/amlogic/Makefile
index a84310780ea3..504c533b1173 100644
--- a/arch/arm/boot/dts/amlogic/Makefile
+++ b/arch/arm/boot/dts/amlogic/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_MACH_MESON6) += \
-	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
 	meson8-minix-neo-x8.dtb \
 	meson8b-ec100.dtb \
diff --git a/arch/arm/boot/dts/amlogic/meson6-atv1200.dts b/arch/arm/boot/dts/amlogic/meson6-atv1200.dts
deleted file mode 100644
index 98e1c94c0261..000000000000
--- a/arch/arm/boot/dts/amlogic/meson6-atv1200.dts
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2014 Carlo Caione <carlo@caione.org>
- */
-
-/dts-v1/;
-#include "meson6.dtsi"
-
-/ {
-	model = "Geniatech ATV1200";
-	compatible = "geniatech,atv1200", "amlogic,meson6";
-
-	aliases {
-		serial0 = &uart_AO;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
-	};
-};
-
-&uart_AO {
-	status = "okay";
-};
-
-&ethmac {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/amlogic/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
deleted file mode 100644
index 1c4ea7266f66..000000000000
--- a/arch/arm/boot/dts/amlogic/meson6.dtsi
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2014 Carlo Caione <carlo@caione.org>
- */
-
-#include "meson.dtsi"
-
-/ {
-	model = "Amlogic Meson6 SoC";
-	compatible = "amlogic,meson6";
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@200 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			reg = <0x200>;
-		};
-
-		cpu@201 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			reg = <0x201>;
-		};
-	};
-
-	apb2: bus@d0000000 {
-		compatible = "simple-bus";
-		reg = <0xd0000000 0x40000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0xd0000000 0x40000>;
-	};
-
-	clk81: clk81 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <200000000>;
-	};
-}; /* end of / */
-
-&efuse {
-	status = "disabled";
-};
-
-&timer_abcde {
-	clocks = <&xtal>, <&clk81>;
-	clock-names = "xtal", "pclk";
-};
-
-&uart_AO {
-	clocks = <&xtal>, <&clk81>, <&clk81>;
-	clock-names = "xtal", "pclk", "baud";
-};
-
-&uart_A {
-	clocks = <&xtal>, <&clk81>, <&clk81>;
-	clock-names = "xtal", "pclk", "baud";
-};
-
-&uart_B {
-	clocks = <&xtal>, <&clk81>, <&clk81>;
-	clock-names = "xtal", "pclk", "baud";
-};
-
-&uart_C {
-	clocks = <&xtal>, <&clk81>, <&clk81>;
-	clock-names = "xtal", "pclk", "baud";
-};

-- 
2.34.1


