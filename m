Return-Path: <linux-kernel+bounces-285602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B199951037
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28032285232
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41971AD417;
	Tue, 13 Aug 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KUWdkp4H"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD01AC43C;
	Tue, 13 Aug 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590210; cv=none; b=XDAYvJiReXEqxIDYlji2p3n+3tg9wxUOfBPdMLcJrjAW3s2gEnuRimDwbB0agmmYvxGi6l4nPaCQy1FTUbplu/v7SRTdM38GRgjU6lNQH1Y4lwQI24HH7zCD7FLUiR2i7n9LTJ/cAPWdvl/vNJxN1AQ+AbOnGFLjVEAuIguhppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590210; c=relaxed/simple;
	bh=jFYMiveEhlERAC/Ss98LtS135WYLrYzY/ySsW3grWdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j600iM0tgeolcM9pNDsjLVUAS6eOmZDhozWa1f3xLjO9FpOTBfWMD+hfEyOoLpJedV0VSR/U0KBrZmyucEGMokqrtG8XNZoDC3lvssHP6Goq0f7kePK6+7lIP/u6S13a/oCF+cSD3oPSUclldq74CGyBIM5O7lvlYPwqPwgVC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KUWdkp4H; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3M5n034184;
	Tue, 13 Aug 2024 18:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590203;
	bh=U6AQWAkAinGfDjcxHFWVcyMVmecIW1bUa4PtMAbFpA4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KUWdkp4HTjKZTRZtGYOPMpVMU3ltgFn47XdTdg0envCTy0AoV0mB2ttenjgnQ2N6N
	 PuZ8UMN48BDPJKjT9vl3birT7UX7AQo7YW0oYIanqqMvPicF7AVOoioF9ulLXMPPDd
	 xmk7vJOnxs033/wLGOkluXiJnKlAoGNe2D7oj8ng=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3M8d033313
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Kho026425;
	Tue, 13 Aug 2024 18:03:22 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Santhosh
 Kumar K <s-k6@ti.com>, Judith Mendez <jm@ti.com>
Subject: [PATCH v2 3/6] arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
Date: Tue, 13 Aug 2024 18:03:09 -0500
Message-ID: <20240813230312.3289428-4-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813230312.3289428-1-jm@ti.com>
References: <20240813230312.3289428-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Santhosh Kumar K <s-k6@ti.com>

Remove 'reserved' status for MCU ESM node. Watchdog
reset is propagated through ESM0 to MCU ESM to reset
the CPU, so enable MCU ESM to reset the CPU with
watchdog timeout.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
[Judith: Fix commit message]
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Fix commit mesage
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index 49dda340752aa..625d353b97600 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -29,7 +29,6 @@ mcu_esm: esm@4100000 {
 		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0, wrti0 */
 		ti,esm-pins = <0>, <1>, <2>, <85>, <86>;
 		bootph-pre-ram;
-		status = "reserved";
 	};
 
 	/*
-- 
2.46.0


