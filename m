Return-Path: <linux-kernel+bounces-195509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F58D4DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366661F21A09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013B017C206;
	Thu, 30 May 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="y2/YJ0oD"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440817623B;
	Thu, 30 May 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079019; cv=none; b=W9Ut/MtcXewg7OvEiM8YlmhAHPRkHrWh+U2TrgIsttpx1e7+DFvW2E6h+hO0hpvcASa7Ea6tDhYaGcWdn0mn78pKTl5YNvzUyGh1adSlzJ4ZtM5w3cewsCUJbNvy+K+oPKWM1TSPuEo3ildLoPGXR9XZkCs+aUK8xs5Tq4bbvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079019; c=relaxed/simple;
	bh=rBAOffgbAamuOBpZB11BYdUzR1zoLfsWLjuxRiZ8a18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y4qOHI+7+za6xU0eGBZsv6tzc3KpdQeYtGM4waIZGWEBiuMFqxeU/e0ienxTAbqvn6w8nuwp875us1wN2w9qw7kkEDlejhLV04OsM/Cg1IJEobvkw/Di+YzMR4PwY0ZkH+sW3q5AccylDSJLxdE1n4efMtSJozlGtJWGyym0L6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=y2/YJ0oD; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=UfJam6jJgDMUma9IbeP8W8ZatgiZnuZGFX5AOvEBySE=; b=y2
	/YJ0oD1wUGuKD56sIIayH+NUovPwjWC3mPtP+WiTkr+H19FZEiBziqt1EdwIZnop6iefk4S/XIUgX
	Q54tzMHCKbxF2v2Y8N5TAMQGvcuRNfkl3+e7zI/N/w0GFlLVRKRQwOClgWtAWTDCsWKAn6bMcpMp0
	V12vmiSH+1s+8LGO+PieKfKxwb1rZdCcyPBtsJEIL1uVxPVCmwKo9+DEmY+k28JvtxmgBZgjR0ZDh
	xTzgZjBsPdS086bq/KAKMNyNFtAVpF1R32C9wAsknGTO15ZY7Rsoy7cWC8hjqw9jJpH1fCMvsB7+T
	zRO8/s0XIdLR40vMLh7+TSw2jpJ4l1Nw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sCggm-00093J-WC; Thu, 30 May 2024 16:23:33 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sCggm-0005k0-2k;
	Thu, 30 May 2024 16:23:32 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 30 May 2024 16:22:54 +0200
Subject: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com>
X-B4-Tracking: v=1; b=H4sIAL2LWGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2MD3cSiXN2cYkMDI8NE3cJU3ZSSYl0DS2NjC0NDQwNzS2MloMaCotS
 0zAqwodGxtbUAO1PuXGQAAAA=
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717079012; l=2068;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=rBAOffgbAamuOBpZB11BYdUzR1zoLfsWLjuxRiZ8a18=;
 b=WCcqt0yhrq70I9kt82LvvpMG/EdU+MMZfi1yBiNY+PAZ1A6eQZ1sV2l5g+U3Kf3cNvy4N4aSP
 ihYoGuQTUwrBdz7jC+8TQSw9o4qPjGDIfPxggukd7NU/9MBByRs2oeI
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27291/Thu May 30 10:29:52 2024)

The LS1021A contains a QUICC Engine Block, so add a node to device
tree describing that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index e86998ca77d6..ff7be69acdd5 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -460,6 +460,57 @@ gpio3: gpio@2330000 {
 			#interrupt-cells = <2>;
 		};
 
+		uqe: uqe@2400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe", "simple-bus";
+			ranges = <0x0 0x0 0x2400000 0x40000>;
+			reg = <0x0 0x2400000 0x0 0x480>;
+			brg-frequency = <150000000>;
+			bus-frequency = <300000000>;
+
+			fsl,qe-num-riscs = <1>;
+			fsl,qe-num-snums = <28>;
+
+			qeic: qeic@80 {
+				compatible = "fsl,qe-ic";
+				reg = <0x80 0x80>;
+				#address-cells = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+					      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			ucc@2000 {
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+			};
+
+			ucc@2200 {
+				cell-index = <3>;
+				reg = <0x2200 0x200>;
+				interrupts = <34>;
+				interrupt-parent = <&qeic>;
+			};
+
+			muram@10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x10000 0x6000>;
+
+				data-only@0 {
+					compatible = "fsl,qe-muram-data",
+					"fsl,cpm-muram-data";
+					reg = <0x0 0x6000>;
+				};
+			};
+		};
+
 		lpuart0: serial@2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240530-arm-ls1021a-qe-dts-093381110793

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


