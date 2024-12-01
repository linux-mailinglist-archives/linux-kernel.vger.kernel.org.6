Return-Path: <linux-kernel+bounces-426666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CB9DF665
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CE281AF6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA68A1D63CA;
	Sun,  1 Dec 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfO3K0O9"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F01D9A6F;
	Sun,  1 Dec 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068879; cv=none; b=up9PHiEyiWqLE7bBgHhdPy/ZMBqglRIohiVT3o6UIyPC/7K8j52IVsevv99uyFLDk93/5UMhGWmAoN1cmd1L4OSdp+B6/BSsNPhz+z1xaUPfyrJH1YaQPyPGl8kTn/bQ4Wlfu7jdw+Io1bPKfYjzvIBa3v0uXugdshMXMbcgw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068879; c=relaxed/simple;
	bh=GoyZyXEqfF0MIyt4eC2xiwAvvtm5CQNZc0qy3YmFLVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fthVpu8cAGSvDESGiRvfdGofpHZptCEMzKcbbN711k9lQfiPDchcSvp1pcdGMftt5KDUOJXIPaoBXJpagkvclQTPhPq0PEVfVNs0KqGOf161kOc3ixZhd8rbQjMfXnSze/e1AvFTrPW79jZ7kPNkQDmYJy2Vjn06S1NG4FBXpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfO3K0O9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fccc26ad01so174160a12.2;
        Sun, 01 Dec 2024 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068875; x=1733673675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3y6HF9C9Y6s2sECuzEiROWAIHUTWYj2XLstKbuvXUk=;
        b=OfO3K0O970XsZ39nZ0WJcUGi9H2ES1uCCKc6JXGOLVjIH26Mv+o93AXco4xpPGSSXs
         24H0Knx3WYrf31Z51mXlQqSJhpv7DhGFzo8vKZokq0373CijfOXPZyl82M5+C2brjcbD
         2uAS1c/WaKwZEKpLwHkS798C0G+k39ZMrrNtYNlD0/yaqZkHCEAtFW4NV70DHR+fNFxN
         JRNY2KxHr4RsV0eDSOgWcsL+1g5ZXFGc0rCBXGXKvMH4ulGX+GfcN+Z1CYqdjbfFlPoh
         bxbQE4lv+8HcnIqg7ognD41G0yWOYHuPdZjg2gv42CJqsXJ+u1yEwXyoYKOMqJuuC0JS
         hrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068875; x=1733673675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3y6HF9C9Y6s2sECuzEiROWAIHUTWYj2XLstKbuvXUk=;
        b=YSoiPBTpKpIYQTUBJHaO13//LI9x/GPyG9kChF3aFLasVn8NPnOIL/+QBdI0JulkA6
         T7s4+jyYyaqxNndh57EmAAqcdmiqRHQyktlLRDePkkmU4SVkYVwLf1+e3hIGSI5xon+0
         BCzloxRZVuFGnEspQiXMcj3gP8i4+eKOX8jA3fPlCze2GexdUBGp2F55dWudEkMGPAIw
         M1/5Fw0jJP1SPbPNws3j5DgzaDmiRU6WOwnSbHwV249CxLt0hY8QuCNeWTuCwZOswABf
         gkvKZpXzkVf9PSIY3rFKIr6eIYmI74nl8WsGwiD1O9QghxdgskkgaUdYss7Fnmx5FwZc
         P6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXCiIaXqVEeF4ylVPOV0ADZBvBREWttWIxEnAZ0+HGj0EceT9bWhC5CvpyUKaWzwSNXip6zGJLjdNiQ@vger.kernel.org, AJvYcCXuxr3Z+AiC/+QpOiuhyHIh6nbXfwXrpKotlzyt/Wy3Y1l8xDcSXrIOwFg7uCf+Kqwa/6Xar/sFQkWt0ARa@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRyCaHRYid6IrS95zL7YXiyvvmXS/4HTiYhD1rQZ6HLDSvg91
	wjdRMu+3iwAsk0A1SSc7sM/ITd1j222q6e+OJPIX2rmmiRhimUQ6
X-Gm-Gg: ASbGncsgP/oPhw+bpVozr6YsUBWpBfZyHjUEQCFh/mkrST/E729+RZSQNItSxVb81Dd
	ClkcNnvE8JZD7gATSQS7ZGGCwjOZgu4C9uEl5gBsjpgrnUanfJg7AI9FQAcP0F0HoGRnti3y1V2
	pWRn5ZW+a92vlnvyAko3yT7JBCbULk+pRhbuDmo40MwKnrajkO4tnruNn8ckWQYW0Vis/mlQ/VX
	6skxs1AqTvutj9KSJpTcbXH6S3vgacjygHsYD3TAw8N8FcgS24IzfdOfxCZ3RVlNA==
X-Google-Smtp-Source: AGHT+IFCuS5Yutv7jnKb4EcbiT9VQ+tJZltpTyezBIB5WIwN2wzvQMSSLxkfzFYboGeRHFezAOORiQ==
X-Received: by 2002:a17:90b:5388:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2ee5bc978b7mr13448280a91.4.1733068875217;
        Sun, 01 Dec 2024 08:01:15 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:01:13 -0800 (PST)
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
Subject: [PATCH v4 10/10] arm64: dts: apple: t8015: Add PMGR nodes
Date: Sun,  1 Dec 2024 23:56:47 +0800
Message-ID: <20241201155820.29259-11-towinchenmi@gmail.com>
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

This adds the two PMGR nodes and all known power state subnodes. Since
there are a large number of them, let's put them in a separate file to
include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-common.dtsi |   1 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi   | 931 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi        |  21 +
 3 files changed, 953 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/t8015-common.dtsi b/arch/arm64/boot/dts/apple/t8015-common.dtsi
index 69258a33ea50..498f58fb9715 100644
--- a/arch/arm64/boot/dts/apple/t8015-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-common.dtsi
@@ -24,6 +24,7 @@ chosen {
 		framebuffer0: framebuffer@0 {
 			compatible = "apple,simple-framebuffer", "simple-framebuffer";
 			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp0_be &ps_mipi_dsi &ps_disp0_hilo &ps_disp0_ppp>;
 			/* Format properties will be added by loader */
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
new file mode 100644
index 000000000000..e238c2d2732f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8015 "A11" SoC
+ *
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@80000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@80008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu2: power-controller@80010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu2";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu3: power-controller@80018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu3";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu4: power-controller@80020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu4";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu5: power-controller@80028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu5";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpm: power-controller@80040 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_sio_busif: power-controller@80158 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio_p: power-controller@80160 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sbr: power-controller@80100 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_aic: power-controller@80108 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@80110 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@80118 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms: power-controller@80120 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pcie_ref: power-controller@80148 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_mca0: power-controller@80170 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@80178 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@80180 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@80188 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@80190 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@801a0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@801a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@801b0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@801b8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@801c0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@801c8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@801d0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@801d8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@801e0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@801e8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@801f0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@801f8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@80168 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsicphy: power-controller@80128 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsicphy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_ispsens0: power-controller@80130 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@80138 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ispsens2: power-controller@80140 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens2";
+	};
+
+	ps_mca5: power-controller@80198 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_usb: power-controller@80270 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctlreg: power-controller@80278 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctlreg";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@80280 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_usb2host1: power-controller@80290 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_rtmux: power-controller@802b0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rtmux";
+	};
+
+	ps_media: power-controller@802f0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_jpg: power-controller@802f8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0_fe: power-controller@802b8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_fe";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_disp0_be: power-controller@802c0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_be";
+		power-domains = <&ps_disp0_fe>;
+	};
+
+	ps_disp0_gp: power-controller@802c8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp";
+		power-domains = <&ps_disp0_be>;
+		status = "disabled";
+	};
+
+	ps_uart3: power-controller@80200 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@80208 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@80210 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@80218 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart7: power-controller@80220 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart8: power-controller@80228 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_hfd0: power-controller@80238 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hfd0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mcc: power-controller@80248 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory cache controller */
+	};
+
+	ps_dcs0: power-controller@80250 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs1: power-controller@80258 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs2: power-controller@80260 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs3: power-controller@80268 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_usb2host0_ohci: power-controller@80288 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usb2dev: power-controller@80298 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2dev";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_smx: power-controller@802a0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@802a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_mipi_dsi: power-controller@802d8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_dp: power-controller@802e0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0_be>;
+	};
+
+	ps_dpa: power-controller@80230 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa";
+	};
+
+	ps_disp0_be_2x: power-controller@802d0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_be_2x";
+		power-domains = <&ps_disp0_be>;
+	};
+
+	ps_isp_sys: power-controller@80350 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_msr: power-controller@80300 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc_sys: power-controller@80398 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pmp: power-controller@80308 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+	};
+
+	ps_pms_sram: power-controller@80310 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_pcie: power-controller@80318 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie";
+	};
+
+	ps_pcie_aux: power-controller@80320 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_aux";
+	};
+
+	ps_vdec0: power-controller@80388 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec0";
+		power-domains = <&ps_media>;
+	};
+
+	ps_gfx: power-controller@80338 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_ans2: power-controller@80328 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans2";
+		apple,always-on;
+	};
+
+	ps_pcie_direct: power-controller@80330 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_direct";
+		apple,always-on;
+	};
+
+	ps_avd_sys: power-controller@803a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x803a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+		power-domains = <&ps_media>;
+	};
+
+	ps_sep: power-controller@80400 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on */
+	};
+
+	ps_disp0_gp0: power-controller@80830 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80830 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp0";
+		power-domains = <&ps_disp0_gp>;
+		status = "disabled";
+	};
+
+	ps_disp0_gp1: power-controller@80838 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80838 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp1";
+		status = "disabled";
+	};
+
+	ps_disp0_ppp: power-controller@80840 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80840 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_ppp";
+	};
+
+	ps_disp0_hilo: power-controller@80848 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80848 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_hilo";
+	};
+
+	ps_isp_rsts0: power-controller@84000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_rsts0";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_rsts1: power-controller@84008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_rsts1";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_vis: power-controller@84010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_vis";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_be: power-controller@84018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_be";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_pearl: power-controller@84020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_pearl";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_dprx: power-controller@84028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dprx";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_cnv: power-controller@84030 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_cnv";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_venc_dma: power-controller@88000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+	};
+
+	ps_venc_pipe4: power-controller@88010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+	};
+
+	ps_venc_pipe5: power-controller@88018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+	};
+
+	ps_venc_me0: power-controller@88020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+	};
+
+	ps_venc_me1: power-controller@88028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+	};
+};
+
+&pmgr_mini {
+	ps_aop_base: power-controller@80008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_base";
+		power-domains = <&ps_aop_cpu &ps_aop_filter>;
+		apple,always-on; /* Always on processor */
+	};
+
+	ps_debug: power-controller@80050 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_aop_cpu: power-controller@80020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_cpu";
+	};
+
+	ps_aop_filter: power-controller@80000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_filter";
+	};
+
+	ps_spmi: power-controller@80058 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spmi";
+		apple,always-on; /* System Power Management Interface */
+	};
+
+	ps_smc_i2cm1: power-controller@800a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x800a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_i2cm1";
+	};
+
+	ps_smc_fabric: power-controller@80030 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_fabric";
+	};
+
+	ps_smc_cpu: power-controller@80140 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_cpu";
+		power-domains = <&ps_smc_fabric &ps_smc_i2cm1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 8828d830e5be..fbff3a6c0ba4 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -119,6 +119,7 @@ serial0: serial@22e600000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
@@ -127,11 +128,21 @@ aic: interrupt-controller@232100000 {
 			reg = <0x2 0x32100000 0x0 0x8000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
+		};
+
+		pmgr: power-management@232000000 {
+			compatible = "apple,t8015-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x32000000 0 0x8c000>;
 		};
 
 		pinctrl_ap: pinctrl@233100000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x33100000 0x0 0x1000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -188,6 +199,14 @@ pinctrl_nub: pinctrl@2351f0000 {
 				     <AIC_IRQ 170 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmgr_mini: power-management@235200000 {
+			compatible = "apple,t8015-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x35200000 0 0x84000>;
+		};
+
 		wdt: watchdog@2352b0000 {
 			compatible = "apple,t8015-wdt", "apple,wdt";
 			reg = <0x2 0x352b0000 0x0 0x4000>;
@@ -232,3 +251,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "t8015-pmgr.dtsi"
-- 
2.47.1


