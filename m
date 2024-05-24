Return-Path: <linux-kernel+bounces-188525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD758CE30C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF771F22695
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26405129E8D;
	Fri, 24 May 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o9K/sm+c"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421E86258;
	Fri, 24 May 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541796; cv=none; b=sGprOlJLh2JqY5BeWDE4mgqHgQAyHg/yZ/ip/c66ngitMkgEf2nMBukfq59+Bw0J9Iy+pU3+M2k7tCOUYy1uGFuT/C/42GYmK0EJ6Z/S/pKUohkN6AcRwvqNpBt7gM/+52u9Xj13O2sbz8F4MVpIfj6xKL6uLvkvJpUz4F9Cjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541796; c=relaxed/simple;
	bh=ZEkiHwNOlsfy4htBj9ZfOQHV3lzMq7iGW24tV6UpUBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPsc54+vgHvxW/hAloDH3fynCigumNA0IPljxxPisy7mm+DJ2bCSfqEtRg5tRbCW+Nij06BJzvuk4Tjk8DKkdXfMmzkaP1WuWKqzn77p7CSfR1nuPqPLvzSQTikB5Wd8a281mpzrkonbG/py69jfyNzz7RrWjH6TfA0e3KOiYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o9K/sm+c; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95b2k030062;
	Fri, 24 May 2024 04:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541537;
	bh=Z8B5k+nZj+2a2vy8rYVWPdVR3IYXooserkVvffMpIZU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o9K/sm+c6Yn9dHpyxKBt7uXCyXHXpTKAeAc1FXXco5fjzU6mrppSfTyhLAFYEX7wx
	 SLBIuzv/83IZXGdkBeHE3QQnQI1aZq6gciLo2usFS3OcE7f7OS49bQViuwQjpvKLBO
	 ILljYom4vbgZFqlNwCPyuLNXrjnQbipdx46d0X/I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95bPh095723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:37 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:37 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7J017455;
	Fri, 24 May 2024 04:05:33 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 4/7] arm64: dts: ti: k3-serdes: Add Serdes1 lane-muxing macros for J722S
Date: Fri, 24 May 2024 14:35:11 +0530
Message-ID: <20240524090514.152727-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524090514.152727-1-s-vadapalli@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The Serdes1 instance of the Serdes on J722S SoC is a single lane Serdes
that is muxed across PCIe and CPSW. Define the lane-muxing macros to be
used as the idle state values.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Current patch is v1. No changelog.

 arch/arm64/boot/dts/ti/k3-serdes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
index e6a036a4e70b..ef3606068140 100644
--- a/arch/arm64/boot/dts/ti/k3-serdes.h
+++ b/arch/arm64/boot/dts/ti/k3-serdes.h
@@ -206,4 +206,7 @@
 #define J722S_SERDES0_LANE0_USB			0x0
 #define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
 
+#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
+#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
+
 #endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.40.1


