Return-Path: <linux-kernel+bounces-301845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A495F666
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B80CB20D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CC19753F;
	Mon, 26 Aug 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Swr0yxlD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29642195803;
	Mon, 26 Aug 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689383; cv=none; b=sKDIlQGIxPpu82zsTJRSnWcSuhBGLcZ9EjD8TiehbGUtooOqtJQLaTfAJ7ETaVvr1OtGPe5riDsD14i6ToFxoeGbZF+wdyv0CpX57kPRO8JgYRmvGUrnG5CSTikjPsMMu5JxHP7pO75wLlG208YPEY/IvpETuPcLyKWX2XOE1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689383; c=relaxed/simple;
	bh=Idzr54+U6Nk4C1GRcIfjwExNlnHLbbZFU0ddodsemNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0tnrb58y8hv3U/i6hTUnMPpvHNpkbCUgBYFdjEPms1afugThu4NlOGQbMtU9VgQR2A4ykkO+NUlrrLk5N0irmlQOv5K38TZQKk4r7CjQA/01/3c6Y91wqSiQ2S4uzfRZC0HWeNMyApPc1IW2TWgd4QGImAfVGty9WxlWb34Xak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Swr0yxlD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMrso058739;
	Mon, 26 Aug 2024 11:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724689373;
	bh=8m51kk9BkZvntlbPtX7KSuqzIII3tUDnH8qrqEz5B80=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Swr0yxlDAU+kUPxLQZMExdNt4R3jwTD0+hFwyxBzrUOEA0Jx6avS0vu3QI/LASTy1
	 qDEL1Q65pvNahmAZ3X9G/cj+/GUYxcbEjkIEzioKepa0oAN33m0YtJ6Fi9OV/v8/0P
	 GCuix/uEXEREtCv5RmWwcnWHcyLibZJnLpk7Ro5Q=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGMrRK019101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:22:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:22:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:22:52 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGMqU0058691;
	Mon, 26 Aug 2024 11:22:52 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <s-jain1@ti.com>, <r-donadkar@ti.com>, <devarsht@ti.com>,
        <praneeth@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62a : Add E5010 JPEG Encoder
Date: Mon, 26 Aug 2024 21:52:49 +0530
Message-ID: <20240826162250.380005-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826162250.380005-1-devarsht@ti.com>
References: <20240826162250.380005-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
present in AM62A SoC [1], supporting baseline encoding of semiplanar based
YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
supported from 64x64 to 8kx8k.

E5010 JPEG Encoder IP is present in main domain, so this also adds address
range for core and mmu regions of E5010 IP in cbass_main node.

Link: https://www.ti.com/lit/pdf/spruj16 [1]
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 916fcf3cc57d..63fd4030df79 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -1088,4 +1088,14 @@ vpu: video-codec@30210000 {
 		clocks = <&k3_clks 204 2>;
 		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
 	};
+
+	e5010: jpeg-encoder@fd20000 {
+		compatible = "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc";
+		reg = <0x00 0xfd20000 0x00 0x100>,
+		      <0x00 0xfd20200 0x00 0x200>;
+		reg-names = "core", "mmu";
+		clocks = <&k3_clks 201 0>;
+		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index b1b884600293..4d79b3e9486a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -61,6 +61,8 @@ cbass_main: bus@f0000 {
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
 			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x0fd20000 0x00 0x0fd20000 0x00 0x00000100>, /* JPEGENC0_CORE */
+			 <0x00 0x0fd20200 0x00 0x0fd20200 0x00 0x00000200>, /* JPEGENC0_CORE_MMU */
 			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
-- 
2.39.1


