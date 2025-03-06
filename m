Return-Path: <linux-kernel+bounces-549566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C818A553F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5F2189B97F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B627C857;
	Thu,  6 Mar 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="gnbmC2kM";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="iM7ureVS"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14326D5B6;
	Thu,  6 Mar 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284014; cv=none; b=bBHTBHIaRXzT4kVIGOOfHdnBWp9445+S2Ptlu/Z/uXch6ECpWFMnSJTLwWYf2TAhj8tjZKbAcvsaqpeqYoqlxJuhzOqhTdwIElfvuB2V62oJ7YO2NG8PW9QTkxBYnHkxuTkVKMWPbyHG4CqmWb04opA4H1JaMsoRcLn2rigT9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284014; c=relaxed/simple;
	bh=JPr5THma9S5EoKLt/y71Ozii0SHYauExya2FtBG0v2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw/cJdvtwWOUSrsNva0iNbpAs9+VpPESuaLdQM9kKnkDWLxEt6czul4ZSiRMf7sYEkbE+FYMgcPsAhb2XXdF8BHbC1YNGje9g4T1kXh+nXrSk4XIl/7lxPVFImveUFSvXy4bQViXD1OrBBMKUDdDStX9yfjmGztcpolOxWL+H0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=gnbmC2kM; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=iM7ureVS; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id D6BE5EC59F2;
	Thu, 06 Mar 2025 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741284012; bh=JPr5THma9S5EoKLt/y71Ozii0SHYauExya2FtBG0v2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnbmC2kMymAn7C0iu8thUpB82K7QC/5WbbLZzrKwvGPlUxc96W/0AuYeSv3O8ZSZ5
	 KrutYX98iNSc0bUq0hF5i8y90d6baNdPMjZ9vDjPOF7vFLZbPI1nKTDPgva2cov4qd
	 Jo6EsSH/YMlPDTJulTHbyL9AI+vPRellq+tNbmuCOrZH5co059HxnoT+giVo6hInqy
	 zD1Uv2VjN9SZht2EyBwm+Vl2eufM5Pj5SLT16+WUiDBvNwYKENcdQG6zUrDoW0sjgq
	 W6y1pC24nPmQgrpjH4Noiy1XUHn+zlocctj9ugpSJAqNIL1qJFBOqBQ7hR57PCDddl
	 85YI7cNb7g26g==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kxjIPGOlARPg; Thu,  6 Mar 2025 10:00:11 -0800 (PST)
Received: from localhost.localdomain (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id B3236EC59F5;
	Thu, 06 Mar 2025 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741284011; bh=JPr5THma9S5EoKLt/y71Ozii0SHYauExya2FtBG0v2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM7ureVSa/S+7YUL3tB5xtVqkBhMyJqfdx9HDE0dvLZU4RHu/Jvph1InoCn00+FoF
	 swBVcrDvNcWdDR/1ML4rc5lCMtlXUxaTn+pdFHUr+tmtriZgHSxTVdTZdrl/V4vxYh
	 wIoAGDF9WuaCc0kyFFUa8CdAB1OjoaA8NbBc/GQYUjNjMDm87pxeaG8k1E19NWgqaP
	 It1BZZBizokamqsTNNlwZ37jdJGRMbLSMhb62FPRnL8vlh9aE3QAaKJIsffzsVFqkw
	 4dn4mImqEAaqnjdHtsEN+Dd1j6CunU0fU6djssw/H130M3VZLGURr1e+Oz52DwwSIg
	 X/+D3MS841SPg==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 5/5] riscv: dts: spacemit: Add clock tree for Spacemit K1
Date: Thu,  6 Mar 2025 17:57:51 +0000
Message-ID: <20250306175750.22480-7-heylenay@4d2.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306175750.22480-2-heylenay@4d2.org>
References: <20250306175750.22480-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PLL and system controllers that're capable of generating
clock signals in the devicetree.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c670ebf8fa12..09a9100986b1 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/spacemit,k1-ccu.h>
+
 /dts-v1/;
 / {
 	#address-cells = <2>;
@@ -306,6 +308,40 @@ cluster1_l2_cache: l2-cache1 {
 		};
 	};
 
+	clocks {
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		ranges;
+
+		vctcxo_1m: clock-1m {
+			compatible = "fixed-clock";
+			clock-frequency = <1000000>;
+			clock-output-names = "vctcxo_1m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_24m: clock-24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "vctcxo_24m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_3m: clock-3m {
+			compatible = "fixed-clock";
+			clock-frequency = <3000000>;
+			clock-output-names = "vctcxo_3m";
+			#clock-cells = <0>;
+		};
+
+		osc_32k: clock-32k {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			clock-output-names = "osc_32k";
+			#clock-cells = <0>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -314,6 +350,17 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		syscon_apbc: system-control@d4015000 {
+			compatible = "spacemit,k1-syscon-apbc";
+			reg = <0x0 0xd4015000 0x0 0x1000>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@d4017000 {
 			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017000 0x0 0x100>;
@@ -409,6 +456,38 @@ pinctrl: pinctrl@d401e000 {
 			reg = <0x0 0xd401e000 0x0 0x400>;
 		};
 
+		syscon_mpmu: system-controller@d4050000 {
+			compatible = "spacemit,k1-syscon-mpmu";
+			reg = <0x0 0xd4050000 0x0 0x209c>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		pll: system-control@d4090000 {
+			compatible = "spacemit,k1-pll";
+			reg = <0x0 0xd4090000 0x0 0x1000>;
+			clocks = <&vctcxo_24m>;
+			spacemit,mpmu = <&syscon_mpmu>;
+			#clock-cells = <1>;
+		};
+
+		syscon_apmu: system-control@d4282800 {
+			compatible = "spacemit,k1-syscon-apmu";
+			reg = <0x0 0xd4282800 0x0 0x400>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		plic: interrupt-controller@e0000000 {
 			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xe0000000 0x0 0x4000000>;
-- 
2.48.1


