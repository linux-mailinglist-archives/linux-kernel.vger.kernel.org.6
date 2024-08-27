Return-Path: <linux-kernel+bounces-303286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0A960A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1A1C22B30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F81A7077;
	Tue, 27 Aug 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i6uXeeKL"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857601A0B1D;
	Tue, 27 Aug 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761703; cv=none; b=GkUcURzgrlxwKgucqErvDaNo9LGbNFfQ2fhNjsVCYqBd5YkJRWmFux1T4Gs01OQXnCAFP5p4JYkdk49iA3FzAVGX/Z4DEWHFHcGWwLuor2os7Xihavi5U0fPIrM0QA6zy4lqkZqHnm2bdq6vBaziFRc6pbG/7lxV4SLM+HVZ81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761703; c=relaxed/simple;
	bh=oLlTW2bh8VJAWJfDthgoq2uvZctY02SJcHJtrpkYkO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km39GUIql95Uz8KGlDaTQpHnCbdrx+rYpOXOosY7JkFiz1FxHin8ow0OdnEi253bSD3JYc59ypyL9C6702vneqrJXEAhhTSAaJYsPE3iyDoxxXycZkAdOrlYNWChvs6+YGeUh2FSzuqrlbdDYSOAoAOHyoX9LkTHNR6JFVjsI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i6uXeeKL; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9SHYe022518;
	Tue, 27 Aug 2024 14:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oFevO1WzCe1lndyKIcqDqzd48GJyNyJUl83cjIp11to=; b=i6uXeeKLWRxy94In
	EvMRbtS/PUzxXmyA8022fgQ8d7s5d1gfAy/FRZ4M+2lPl1YlQEHExNwkP6dKGYhm
	qmJ0AodA8U97w41Rx32k1lgLiTw9DdmbhYcQmyczpENdKstI8IXPOV3xIr3L3sdv
	hOEe/vd0j20FDIDxwZ96pWuXDmWp5Z6jCYWzRmMJYkOQKW+ZXw9Ua/Mfi6ipTQXA
	mGbRAvPbhe0V+3omfMYbHSNs5IPLWsQTj1pgtfizRLPjh/0Z+8mFvrkl2+IP0WEh
	wnyKAKVy+mYhnT906DRR2iXh0rtEuyIjBqGitu9P6CsuLwO85/nCjDiMkkmloJpr
	3LOe+A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419c6u0tk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 14:28:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6ABC94002D;
	Tue, 27 Aug 2024 14:28:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD6EA263345;
	Tue, 27 Aug 2024 14:27:11 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 14:27:11 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH 5/5] arm64: dts: st: Enable COMBOPHY on the stm32mp257f-ev1 board
Date: Tue, 27 Aug 2024 14:24:59 +0200
Message-ID: <20240827122459.1102889-6-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827122459.1102889-1-christian.bruel@foss.st.com>
References: <20240827122459.1102889-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01

Enable the COMBOPHY with external pad clock on stm32mp257f-ev1
board, to be used for the PCIe clock provider.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 214191a8322b..bcf84d533cb2 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -27,6 +27,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		pad_clk: pad-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0>;
@@ -50,6 +58,12 @@ &arm_wdt {
 	status = "okay";
 };
 
+&combophy {
+	clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>, <&pad_clk>;
+	clock-names = "apb", "ker", "pad";
+	status = "okay";
+};
+
 &ethernet2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth2_rgmii_pins_a>;
-- 
2.34.1


