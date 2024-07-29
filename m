Return-Path: <linux-kernel+bounces-265169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0993ED87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E9281D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F18624A;
	Mon, 29 Jul 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fa5kOALX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A781219;
	Mon, 29 Jul 2024 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234869; cv=none; b=h3LqmD2esWuTYF3CZtoOiARd8jdjCy2qTcXGOKFmYOfYAGs8Z1jtCHrsF5ljMtHKd+jgB8EJcHiBweCcfZLMV4kFFB+Rlp74DMpIFkfPXX/U5dqQQLnooW2YG8S0FrR9ddjxlAHs59MjHFUK5pibLIHoqUJ1AqIg8XC7mte9weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234869; c=relaxed/simple;
	bh=173BkkWfPoWytLzjzquFuNNvQTqOrgx/sLMj0gHUsV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUuXBYFAes95wTyxFQpdk1EoALW4iNhokt12cnnLzD5UgGep9pjuBHdcF3Mws7aK6dnOGEJBrCKD9PhuIB1LRK4e9copufzp5wANMCFp3tDm2gsD05rkd8DenkHBrk93tGRQciFXpoR+fwZ2+4xtDh1VheraAwHMivpuby7hf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fa5kOALX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YFL3090243;
	Mon, 29 Jul 2024 01:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722234855;
	bh=H2XwplQ/spv3rja8Vu2RamSiRc9QFHxrtiHa0The5Ro=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fa5kOALXquaO0fU1J0YexZcuoB2zZigsw6pesbB57sqU7wwIs1vUPMCQaxLHBt1Rk
	 TMh+JydSuZ5PYZOwGrlauQzOUVbO+yjFAIlvdONBp/nzYJvc8cin5+uZ+78cjQLZb5
	 +SfKfpztHCTF+ypyRXxbzKdcAAli5jA6NaerznKA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T6YF22075911
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 01:34:15 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 01:34:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 01:34:15 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YErH078218;
	Mon, 29 Jul 2024 01:34:15 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200-som-p0: Update mux-controller node name
Date: Mon, 29 Jul 2024 12:04:11 +0530
Message-ID: <20240729063411.1570930-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729063411.1570930-1-b-kapoor@ti.com>
References: <20240729063411.1570930-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There are 2 mux-controller nodes in J7200 which are responsible for
transferring can signals to the can phy but same node names for both
the mux-controllers led to errors while setting up both mux-controllers
for can phys simultaneously.
Thus, update node names for these mux-controller.

Fixes: da23e8d1124b ("arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in main domain")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 21fe194a5766..89b68325e4e2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -84,13 +84,13 @@ rtos_ipc_memory_region: ipc-memories@a4000000 {
 		};
 	};
 
-	mux0: mux-controller {
+	mux0: mux-controller-0 {
 		compatible = "gpio-mux";
 		#mux-state-cells = <1>;
 		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
 	};
 
-	mux1: mux-controller {
+	mux1: mux-controller-1 {
 		compatible = "gpio-mux";
 		#mux-state-cells = <1>;
 		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


