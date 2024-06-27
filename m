Return-Path: <linux-kernel+bounces-232671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C391ACA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4022F282575
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36741993B2;
	Thu, 27 Jun 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TX3CfPQi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9C199E8D;
	Thu, 27 Jun 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505558; cv=none; b=SURYTXdBZ4H61BVh1XTnWIlW+9dSk2CtLKanhD6LlZb8TgVvXZZ5qpVx3PIJValvHtZTO4oIpSw2t2KwtL7+aOQbyjw2+xVjvYemE0W7wWtIGWjkgiVmXei9qepdSMbGYp6W+hOTxPZ+gfdACeejIPQJ18W8rkgUh97J/l1AY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505558; c=relaxed/simple;
	bh=fFGzJLnlLFiod6qKn2svmOTzSdxgbt/yubDWf7IDQ8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HshITqF3yH3IMcackgZesyD3xD3jugVVr9u6YCimABG3ohZObaZg7Q6FNyKiuLRKaq14iq9otvkaS8PTYA39X+7t6R0ITV2vCZNE053VOrEsLWNWmCaUc4wY/SvOpKwRaV8jDKn9I6QLnPSHMaPFGA2ASJoGCUQYrMGMszAD17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TX3CfPQi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfMr049645;
	Thu, 27 Jun 2024 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719505541;
	bh=zTVIbbXi0KpwSMhpFDWnmvkSkJwEPOm0jo+slsNFmgM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TX3CfPQiGNeXvCm38eyMwno21z2tm/z7YM+y9UIW+KLnzWjFhS135Q7yANbTXNigQ
	 +DBcXoiXRjDu6WWeikIgLcbz6j3m5mYH3pq8PimI2seomBv1PJo2pxd3U0Sn0fBsC/
	 /kK2bm/crHFa7YRtvg7R5Db4ssUeQBo0E4dNuqTE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGPfMI023116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 11:25:41 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:25:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:25:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfRF130220;
	Thu, 27 Jun 2024 11:25:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V2 1/3] arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
Date: Thu, 27 Jun 2024 11:25:37 -0500
Message-ID: <20240627162539.691223-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627162539.691223-1-nm@ti.com>
References: <20240627162539.691223-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Introduce a GPIO mux mode macro for easier readability. All K3 devices
use mux mode 7 to switch to GPIO mux and this allows the gpio-ranges to
be defined for pinctrl-single clearly.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 - Mux definition PIN_GPIO_RANGE_IOPAD instead of PIN_GPIO_MUX_MODE
 - Added documentation as well to clarify the usage.

V1: https://lore.kernel.org/linux-arm-kernel/20240618173123.2592074-2-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 4cd2df467d0b..22b8d73cfd32 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -38,6 +38,9 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+/* Default mux configuration for gpio-ranges to use with pinctrl */
+#define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
+
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.43.0


