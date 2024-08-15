Return-Path: <linux-kernel+bounces-288591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47612953C21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C021C21EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190F155759;
	Thu, 15 Aug 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c9vYpOEw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D11509B4;
	Thu, 15 Aug 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754930; cv=none; b=Xs3qZ4g/5he1yrBPr+ikYixPk3TgoaO+e4/39p4bP9/IFoo3iHajzty+xMIK7d06DdLmF1zgXPexsZcXuwv7wffsr704j9E3WVMjRIcFnsnrIwnxhqo3NIcDvnU1dcc68+ys1lyhbDBb/HR0klkbS3X07Kcyr5gTCLTuckt2Bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754930; c=relaxed/simple;
	bh=oofLex9rJdW6vnZOOwntax3i7fEbiuwRzCu5H1eKyLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mW6S/i7fShmh4W2EOAOhGWxGxdEe4AnF1LbUmj2I9FIEdrtZCnrcN65j6V+OwgPa+R+kXTUlaXtO3ENzh3jDuF//zy7ea2bzI6lygiDzZEawdU0KiLxPb6VAKyWFYtLjrnExbBvijHI4nv1FpHz3F9t7pZweyZma8frcHPCA89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c9vYpOEw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmcVa003241;
	Thu, 15 Aug 2024 15:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754918;
	bh=87JlDhGfQUoLEZskO1JKgmyxXqWPGSlk8GWSd1u5cLY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c9vYpOEwrn4VLf21aj1vbo6gXaGnupViMvHvSq56/p4XIwW4zOZxUhtS/zsuLLEvz
	 xR+WgXpXnwPfw1mdWu50tMFWvvnIrWLzCC86VZ5kDjg98avVZKD2ReRcPjz8QCT97G
	 s0ANSjFx24Ue+rgoq0iEDiAO2cQdN4dgCEW2+dPM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmcNS011977
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:38 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNw052918;
	Thu, 15 Aug 2024 15:48:38 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 4/6] arm64: dts: ti: k3-am62: Add comments to ESM nodes
Date: Thu, 15 Aug 2024 15:48:31 -0500
Message-ID: <20240815204833.452132-5-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
References: <20240815204833.452132-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add comments to describe what interrupt sources are routed to
ESM modules.

There is no functional change.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 328929c740dc0..5b92aef5b284b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -241,6 +241,7 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1, rti15, wrti0, rti2, rti3 */
 		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index e66d486ef1f21..bb43a411f59b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -19,6 +19,7 @@ mcu_esm: esm@4100000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
 		ti,esm-pins = <0>, <1>, <2>, <85>;
 	};
 
-- 
2.46.0


