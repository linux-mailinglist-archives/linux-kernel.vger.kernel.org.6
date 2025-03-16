Return-Path: <linux-kernel+bounces-563108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D6A63710
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D497816BA21
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A01F582A;
	Sun, 16 Mar 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJj4u4ei"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D061E1E1B;
	Sun, 16 Mar 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151410; cv=none; b=Q8+Y95CDx8az19YcDfREpe4JyBJi7mgAmu2ocUbKrGfo58fXKUSA/wYhYqAS1MzLDRjtFEscOkignNn2Mo4XaC9yDjr3RXvT8/51Svs5iH6spglbuYhWH+B0Lx48vavsEgS1GQu57LYJKoWAsFITd5Zgcxxfg0nLCseSgpq5m7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151410; c=relaxed/simple;
	bh=tglxEmuWGw4akNornBWLCQKajr6P9iy15vqg5vSmx9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5YEdLRHk4l5t+58WGpTPtlkFX6v3D9LXyOkFQ0w01/olwN1SHeQ/juc98C0+bYp6/sIw4DfhIKEyJRDKsj8uzfMleIQuviGsSgO5GLPv9S1Z6QlWnGikJOpeuEDy9CiQusif3ZZEAGNyJRSSy2rY+BiuKgKen+uxnGYZSC48zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJj4u4ei; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so7330295e9.2;
        Sun, 16 Mar 2025 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151407; x=1742756207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoyZXAvqNe6CuejKxIry7Yi6oQs7DU4ZtubzPJeO22A=;
        b=HJj4u4einht2O5h68aZkeVQTeCV5QNmTGBNpLaTBj5katU8nOvxquz6JxqeTAq/l/B
         JKajJP4YoXUjuSrdNXhSyph+yA0/h7yvMXcvuBhAgJXle8i3TxU+NBSvMJWksthaZ/+I
         JbD8cJUOIEYUtHSKeVci0F+mxrNk3i+PkD+InXZSs/bzKqvoSf+YWrOrwHq7hhdJVIZZ
         A1RelgA9smsaFu112+AyfA7HrTS1CcnO9aQlulyQX/y7FL/Io/8bqusw450MgFXAbrnA
         9iPTUYJqXVjQR92A/CK2/no9CdHXSzNtRHlP1SBFOPvnyGFe9CJc+tDs2hy19mEWNpDV
         MiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151407; x=1742756207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoyZXAvqNe6CuejKxIry7Yi6oQs7DU4ZtubzPJeO22A=;
        b=SicrOym8BWAlbRLpmhVfiKyi2iwYtlvWO8LezuOytu7oSG+8pEByOXcuVZkeF6+olv
         mglXAl1J1NUEjtftxLgUy5mNg13kRrrvc3+laeVtAIJzP+v36P9QJW2j69w5M7QUxdfo
         cxqSg3aDCkhvLvTGJJjlJdlMEZr7NbOjQxOYJZJMdkslUKGlaLELvtoB95WQrqCw7vhM
         QAF49JnC62J5U1Q0+UUKKUvOc6Hh2Y4zQGMIE8WKNr6TMd5SXaWis4dQxqNhYySC70Z7
         e0LkfxICg6cudLM8DtvjjzypfWv+WUs1E2lUsGE2lrQLVLL+csKi6IdClCheFDUlxUqS
         Qufw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9HdABLlfGKkwLYJwis5chKvaOCpkphit3RjrtLfomLzANRmdcwHQLtLQLIYvOLIfTRap4p66bc37ccx1@vger.kernel.org, AJvYcCUd7ijNUFBQGRiI2QgyBCWE9WQqt36F+EdEDa/4dPVG6zwE6xuqDx/vv1/DlI0Q2MjmwMhh9TDyttEQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3jqKdJQQ7rW7o8gsVOipTisaYmSVg6MSefIRmC2QeScBKEzx
	l7I2zUliiEn46vox00uzogTJHiDzvo5RB+rdj9cgZymUkZdogU3W
X-Gm-Gg: ASbGncu32sJquTJMIM2oNJfxMZ6mwZdPs+YdQIEP95YhC6s/+yCBA9934CTHg6G49lC
	GN6GpiDb7BrlK2iEa/uK10LMMq9ncxaXjKZT1d6wRp+776N5rqjCD8oBUJW7sxSGh24Dsona+7T
	iTbiFmbcGioTIhq5SBdNuIaaej9GyvUocWFIc7EA1a+nG897bYS6DzRY/yx5u/18PljEdzTUVXa
	rw97IdXksAJ0F0T9o2WWfcqK605C/Ks2+hT1q3EjGNm0E5rq07rF3Bd5jXC8Ohoeu1dyCD4+KAx
	IKMEP0gJN75zXFQSpvlN1yhlekONDskM5QFlPe8G1LUuf88BR3bTBb43WY6BOiAvISoT
X-Google-Smtp-Source: AGHT+IFMni+9tePO5dcXTTurbNOrImHaypczvIJOW+fllny49duz6UAc34isNuZiUTsLUl0JT/kiSg==
X-Received: by 2002:a05:600c:1553:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-43d264bfeb9mr56204255e9.29.1742151406643;
        Sun, 16 Mar 2025 11:56:46 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:46 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/7] arm64: dts: sophgo: Add initial SG2000 SoC device tree
Date: Sun, 16 Mar 2025 19:56:33 +0100
Message-ID: <20250316185640.3750873-4-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree for the SG2000 SoC by SOPHGO (from ARM64 PoV).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
- PSCI node and enable-method
v4:
v3:
v2:
- relocated "memory" node according to DT coding style;
- moved GIC node into "soc";
- referring "soc" by label;

 arch/arm64/boot/dts/sophgo/sg2000.dtsi | 81 ++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi

diff --git a/arch/arm64/boot/dts/sophgo/sg2000.dtsi b/arch/arm64/boot/dts/sophgo/sg2000.dtsi
new file mode 100644
index 000000000000..7051007ec7ea
--- /dev/null
+++ b/arch/arm64/boot/dts/sophgo/sg2000.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#define SOC_PERIPHERAL_IRQ(nr)		GIC_SPI (nr)
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <riscv/sophgo/cv18xx.dtsi>
+#include <riscv/sophgo/cv181x.dtsi>
+
+/ {
+	compatible = "sophgo,sg2000";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x20000>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;	/* 512MiB */
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2", "arm,psci";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		always-on;
+		clock-frequency = <25000000>;
+	};
+};
+
+&soc {
+	gic: interrupt-controller@1f01000 {
+		compatible = "arm,cortex-a15-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x01f01000 0x1000>,
+		      <0x01f02000 0x2000>;
+	};
+
+	pinctrl: pinctrl@3001000 {
+		compatible = "sophgo,sg2000-pinctrl";
+		reg = <0x03001000 0x1000>,
+		      <0x05027000 0x1000>;
+		reg-names = "sys", "rtc";
+	};
+};
+
+&clk {
+	compatible = "sophgo,sg2000-clk";
+};
-- 
2.48.1


