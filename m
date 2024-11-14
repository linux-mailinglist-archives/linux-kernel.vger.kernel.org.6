Return-Path: <linux-kernel+bounces-409697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5F9C9035
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736FE1F28E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67397188713;
	Thu, 14 Nov 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y4HGyCmz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B140849;
	Thu, 14 Nov 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603243; cv=none; b=hmMwTxiWrF1C5GnDukB/CozkiwS/KyuRwrloCgybk+nfOwVdpk46vcX81dV3s9OD6nfwERaEwlD6DPxvBLVGPi/dTNM8m47hjOzry7/J754VoqmbV2Ji+WOan1s2O2ayPuxJ6yIDMnP+3IgCjw7EPeGh+JKEqMwt9dQu7NrEa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603243; c=relaxed/simple;
	bh=QM920k9aNzl1SRVOF+Mb8kMbSJzQ15iqDnuxfL7aWDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNfnhBMTbHs93ePdDwBxxG6QNELjlCIwmYWPF0Y4es4MpWjRfyWA+FIKYt/wTiBzo1Xw7VjQ9asU10c1skzB61y76SgrM80SR2SF3TgeqvupGT6/drOPhVxHJkGLkpWhAwdC6eNY+wnZJhln5eVkRL+oemF3hk8TqJfNtj6o5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y4HGyCmz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AEGrZTe070288;
	Thu, 14 Nov 2024 10:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731603215;
	bh=ljGXTXoD4990Ah9Pen2t1Ipd5y/qyu3l9S5U7tIzAro=;
	h=From:To:CC:Subject:Date;
	b=Y4HGyCmzy8cvBefhq9HTJiupT6d8IRIuZvqBtq67y4ir1LgzGfkzgfNGrz56N5dsT
	 97zcHGyFxrTznbyebQZo5iKpBuRWBhKxtnlWaYfPuAv/AaAh9z+BL7dgq3UThzQPZ+
	 S6wzpjclHPM193LwvMwRRBTTUOhv3WJxxRcoscGk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AEGrZsE023505
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 10:53:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Nov 2024 10:53:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Nov 2024 10:53:35 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AEGrYOh059681;
	Thu, 14 Nov 2024 10:53:35 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in cpsw_mac_syscon node
Date: Thu, 14 Nov 2024 22:23:31 +0530
Message-ID: <20241114165331.1279065-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Ethernet boot requires CPSW node to be present starting from R5 SPL stage.
Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon to enable
this node during SPL stage along with later boot stages so that CPSW port
will get static MAC address.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on linux-next tagged next-20241114.

Link to v2:
https://lore.kernel.org/r/20241011110207.600678-1-c-vankar@ti.com/

Changes from v2 to v3:
- Updated commit message as per Vignesh's suggestion.
- Collected Reviewed-by tag from Siddharth Vadapalli.

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 6957b3e44c82..bf12e25ad3fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -315,6 +315,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
 	};
 };
 
+&cpsw_mac_syscon {
+	bootph-all;
+};
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	bootph-pre-ram;
-- 
2.34.1


