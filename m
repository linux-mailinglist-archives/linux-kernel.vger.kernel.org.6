Return-Path: <linux-kernel+bounces-426659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2249DF657
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07D2B21AB6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AC1D63FB;
	Sun,  1 Dec 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6lmzTwJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0A1D7E3E;
	Sun,  1 Dec 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068854; cv=none; b=hX2PkZc1bVd2aiS7VVU9wQYlnwPrctMzQWjTMGkSM4MYVIScJ3UCB9cHLQICU1bIO8g9z/4ACJNL7ixbBOfeQaTEo1RY78g7u4ZahqX7fv8+iKl112V/yIYxCtNiTu6MekNezOWHTa8fyINqn9/nx7e3zG51c6Bb4OMn8Ss9Zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068854; c=relaxed/simple;
	bh=KfYtH6XnE/xoXbmpnxX78NsP9ZS2q4I4KSfx0ZLtPmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvuiLz/4TzI6U/gOAMgH+W+2E6F567CqPAs777VRLeBSMjbG6MRGkgXn4v8bRa9fTRhWuYvBwaxpBpS9Ru4JouXWkHB4lDjQMVACDnIKDyul3xHwrJd+/rzy/3X0ZxOIEHzqv6ixWosTHp/7+hNn7B7+5tQqxWX6Y/7+0d5H5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6lmzTwJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea39638194so2775779a91.2;
        Sun, 01 Dec 2024 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068851; x=1733673651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH5QIgVPS3TD2q2DuSlSpmZ54M+FLLSMdrG/ppsr8F0=;
        b=F6lmzTwJnvbTKtSZZtbd2r8a1vLCl/QugJa07FW4xeWOzoO1jkYkGr06w5bsJbCVxS
         NMZrKzmj/oHCagYZn8XBzHQyYFDiBHHZDXRppaVRHcSRmHZuLJZep2sxuGVVxcYmfVi+
         /cpIF3bOpqIC+1ci6/c6APZb2+FUtI2qTKPks/YLTTytFjPedkoNIfy11ffuh2vP4ism
         hr/kBoggy4QIuIO6s1aSoIy2Moor2DocP+hRJotgKaN0o4jP3z24sc4f5RCYdaWkqkMK
         ZtFcqTuvwrwAKI/mLl9iS2l7FHUc3rwPdge0sTTSaqMlU9EiFwaO1Wp0UChizUgtEaAH
         iUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068851; x=1733673651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH5QIgVPS3TD2q2DuSlSpmZ54M+FLLSMdrG/ppsr8F0=;
        b=liMwIsl6vZrImgz4bTOZ6gh3n5yuczkvFDLivIgPaiQvz1NcLBvvSXBoq+mKVIVLS8
         3F0nenI2FojjY3TIC65oSttvfluOS82LoDLXdEz3ca+OM68eYlz76lKvRACI3e7JPzhx
         pq326YFiu1DXOEV90ifSEoukCFLiMgOIbc6DCDZ+tKEEFH3qZcscujtm2VcdrDR4sjtV
         +C3hDkDfSxDG7cvAaEVmDXUVN3F7ZI6+k4ETElc9bJ7SfW/R3Shrixj1fKE/cdeNasU0
         Fv6RewCy3C8At5MFQA2k4TE+npmlA9oGqZTRY1w+jzwlWL2WN5MBcM1AJM9EiyiuUoFi
         OAXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYiJy9WuBK0LeQpDELgwQqJzS4jk4letl39Mc+M58DLmfvg2B8pr5fgnWPJ86vSORY4iAUHEy9s6rI@vger.kernel.org, AJvYcCV5cXGI4tDZbEqERCckNK4xRViqWBmKtgJigzwpIqAf/pcRGEROTJW/i4ynF7tlAhzpel9m7eXNK4vu8cc/@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI8o504E28k436vxwX8X6cJ9r01QyA+yndb54XP5eenvFskNH
	JVz+q17RPdGDCWAxlJjBOrGxfeixdwZ6z/G13fHOEHv+/6fbdZ8PTgTnzg==
X-Gm-Gg: ASbGncumzrW9fIkI17OWrbgqnem5A4UdobBgOLi4cOjAURG43Qkk900goaVmA4qm/wu
	p4YykX0p/TVUTuQ0HGqmRZYM+9uoncz4w+tNYd8xF1OlzhNHLGLoI4xxHyoCbcor/NNVcXM0b/D
	8GlDHij9D+Imk57ykQV3naDNfiPSpDLVSUXksqnrrOoeJ7JkX7rTTRCXSj42YVVw/pfWpHFF6RU
	GWixyr/16ogVbBcriR2AelbNMBaOnMUrtxbMHqJyTs5EmV23qWeTb4fiy6PKe5Yyg==
X-Google-Smtp-Source: AGHT+IF7ZfPAthXAsqLVOP9nJe0PtfgB1gTj/GA2KcYO6jzeUUbCOIiUsvepyYCyiIxQBagGmpv5sA==
X-Received: by 2002:a17:90a:fc4b:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2eeb0b0909fmr3062976a91.28.1733068850217;
        Sun, 01 Dec 2024 08:00:50 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:00:49 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 03/10] arm64: dts: apple: s5l8960x: Add PMGR node
Date: Sun,  1 Dec 2024 23:56:40 +0800
Message-ID: <20241201155820.29259-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201155820.29259-1-towinchenmi@gmail.com>
References: <20241201155820.29259-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the PMGR node and all known power state subnodes. Since there
are a large number of them, let's put them in a separate file to include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++++++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
 5 files changed, 635 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
index 0b16adf07f79..51c081923657 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
index 741c5a9f21dd..7d6e799c933a 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
index b27ef5680626..2ba846db2266 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
new file mode 100644
index 000000000000..da265f484307
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple S5L8960X "A7" SoC
+ *
+ * Copyright (c) 2024 Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@20000 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@20008 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_secuart0: power-controller@200f0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "secuart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_secuart1: power-controller@200f8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "secuart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_cpm: power-controller@20010 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_lio: power-controller@20018 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lio";
+		apple,always-on; /* Core device */
+	};
+
+	ps_iomux: power-controller@20020 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "iomux";
+		apple,always-on; /* Core device */
+	};
+
+	ps_aic: power-controller@20028 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_debug: power-controller@20030 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_dwi: power-controller@20038 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@20040 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_mca0: power-controller@20048 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@20050 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@20058 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@20060 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20060 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@20068 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20068 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@20070 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20070 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@20078 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20078 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@20080 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20080 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@20088 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20088 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@20090 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20090 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@20098 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20098 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@200a0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@200a8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@200b0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@200b8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@200c0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@200c8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart3: power-controller@200d0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@200d8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@200e0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@200e8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio_p: power-controller@20110 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+	};
+
+	ps_usb: power-controller@20158 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctrl: power-controller@20160 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctrl";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@20170 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host1: power-controller@20180 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_disp_busmux: power-controller@201a8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_busmux";
+	};
+
+	ps_media: power-controller@201d8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_isp: power-controller@201d0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp";
+	};
+
+	ps_msr: power-controller@201e0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_jpg: power-controller@201e8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0: power-controller@201b0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_aes0: power-controller@20100 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@20108 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsic0_phy: power-controller@20118 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic0_phy";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_hsic1_phy: power-controller@20120 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic1_phy";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_hsic2_phy: power-controller@20128 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic2_phy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_ispsens0: power-controller@20130 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@20138 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_mcc: power-controller@20140 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Core device */
+	};
+
+	ps_mcu: power-controller@20148 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcu";
+		apple,always-on; /* Core device */
+	};
+
+	ps_amp: power-controller@20150 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "amp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_usb2host0_ohci: power-controller@20168 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usb2host1_ohci: power-controller@20178 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1_ohci";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_usbotg: power-controller@20188 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbotg";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_smx: power-controller@20190 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@20198 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_cp: power-controller@201a0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_mipi_dsi: power-controller@201b8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_dp: power-controller@201c0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0>;
+	};
+
+	ps_disp1: power-controller@201c8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp1";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_vdec: power-controller@201f0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc: power-controller@201f8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc";
+		power-domains = <&ps_media>;
+	};
+
+	ps_ans: power-controller@20200 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+	};
+
+	ps_ans_dll: power-controller@20208 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans_dll";
+		power-domains = <&ps_ans>;
+	};
+
+	ps_gfx: power-controller@20218 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_sep: power-controller@20268 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		power-domains = <&ps_secuart1>, <&ps_secuart0>;
+		apple,always-on; /* Locked on */
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 0218ecac1d83..7705215fbdc7 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -62,9 +62,18 @@ serial0: serial@20a0a0000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
+		pmgr: power-management@20e000000 {
+			compatible = "apple,s5l8960x-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x24000>;
+		};
+
 		wdt: watchdog@20e027000 {
 			compatible = "apple,s5l8960x-wdt", "apple,wdt";
 			reg = <0x2 0x0e027000 0x0 0x1000>;
@@ -78,11 +87,13 @@ aic: interrupt-controller@20e100000 {
 			reg = <0x2 0x0e100000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
 		};
 
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,s5l8960x-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -111,3 +122,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "s5l8960x-pmgr.dtsi"
-- 
2.47.1


