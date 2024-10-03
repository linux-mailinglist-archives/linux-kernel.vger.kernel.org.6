Return-Path: <linux-kernel+bounces-349356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9698F4B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2223B21F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FCD1A7ADD;
	Thu,  3 Oct 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VKD2e4rz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46A1A7043;
	Thu,  3 Oct 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974890; cv=none; b=M6ZR6qjHwsXw8D+NiEmZFs45gL+xBD6EaB2Dm+7hUxleXKUSv2F1TW2QHeHMb7IDJdG9OyqNBhrDWDnMso5P0WaNkTG3jLrVDOi/VL2p6AK4rP1Iffx6QPvXwld6fAbwPKbzTGuwx609vEm2jJ5grWUHvvYgNS3j4QpRDxBq6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974890; c=relaxed/simple;
	bh=8jASYYoaxkhcRfzV8vhnqOX48NGySocFuCNn9+TL1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9HDSXUbvKgxlPdYLCo0cIxmF2r8NcsAKlub3X3weWN9gA1IR+iL++WZnK10Pbp2R8fGXAYJ8n3MKMWYyBeNN2dlvgb5LSGl4+Jy4Ww2fmBgp3vQFxcwti4EkyPC4EYpn2zK1uhTqzNcR1ch3nM/KLl0m9lZM+vA1g5A6IsQzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VKD2e4rz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493H1Jwb050024;
	Thu, 3 Oct 2024 12:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727974879;
	bh=5OXZ7TNWoedd0uvQusRZDSQMlO93fpQ7zDO/4wd4lFU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VKD2e4rz8TRNZD1Z4vJhzp9Fa1ADeRbaYZMfTUa9ECYD5MPApwwaYBK1ZVsySaT+R
	 2XmBvfmfkSq4xLlJzgezMhtCjzbNYWjsrPfQBOQeP7UWZxao7X0BpjeO5iUEi216TG
	 nuw4IWdtsexauPrALjTdsMHCdQUfR//CfboycM0k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493H1Jbn083229;
	Thu, 3 Oct 2024 12:01:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 12:01:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 12:01:18 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.173] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493H1IJc034882;
	Thu, 3 Oct 2024 12:01:18 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v12 3/5] arm64: dts: ti: k3-am64: Add M4F remoteproc node
Date: Thu, 3 Oct 2024 12:01:16 -0500
Message-ID: <20241003170118.24932-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003170118.24932-1-afd@ti.com>
References: <20241003170118.24932-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Hari Nagalla <hnagalla@ti.com>

The AM64x SoCs of the TI K3 family have a Cortex M4F core in the MCU
domain. This core can be used by non safety applications as a remote
processor. When used as a remote processor with virtio/rpmessage IPC,
two carveout reserved memory nodes are needed.

Disable by default as this node is not complete until mailbox data
is provided in the board level DT.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index ad4bed5d3f9eb..a243c981e8535 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -161,4 +161,17 @@ mcu_esm: esm@4100000 {
 		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
 		ti,esm-pins = <0>, <1>, <2>, <85>;
 	};
+
+	mcu_m4fss: m4fss@5000000 {
+		compatible = "ti,am64-m4fss";
+		reg = <0x00 0x5000000 0x00 0x30000>,
+		      <0x00 0x5040000 0x00 0x10000>;
+		reg-names = "iram", "dram";
+		resets = <&k3_reset 9 1>;
+		firmware-name = "am64-mcu-m4f0_0-fw";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <9>;
+		ti,sci-proc-ids = <0x18 0xff>;
+		status = "disabled";
+	};
 };
-- 
2.39.2


