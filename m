Return-Path: <linux-kernel+bounces-288594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1F953C28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612A51C22FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD415852F;
	Thu, 15 Aug 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RUxwmu2u"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A509158A04;
	Thu, 15 Aug 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754935; cv=none; b=EcC5eYAgZG2ya9lux5PYtpyJ6UNsoOHUWzSz6Sb2UCywTjD9Fx9DtyJgpn073xUEwYCVbvwN0kJvg9VDktBn8XWXtYgcceYJHlvFyoe6mENrD8+50OMuKe/0gmc+/FwwIEW1tMPTpPK2LSjhNVfaEt216JjTYFncM1K/VARv5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754935; c=relaxed/simple;
	bh=d0wTHdmHEFfjSnuR5VuGP3w3UxItyPovIqj44hQy0gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP5Nwxc0DPeKJFmM0RDjxr1KatLv94TMxZU/QmT8k6aNxZlvpinNcZm3QCi2OdH7/24ZYgvTpQgoSXrVoIhtsZBE0GAHt+JDTWibr4H8YjRwGs5SSB+LJjrKlwe+IEE3eZ+gsByGQ1QL6YdSVcG4j8O2jZe45RT+EYJ1FyVJ8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RUxwmu2u; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmbo2122618;
	Thu, 15 Aug 2024 15:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754917;
	bh=s5WroGaJI7WteHisR14jDLOQDp6ct83IZO0PXUdOnq0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RUxwmu2u4QD7eMgb5uOVzss1TTOU00jtPfhXln0e+jPqa/t8Z77SFRmpH1nLIAJQr
	 0n1lTOnMhpq5CNHAjbZbo9OlV5li/caz6hPiiQ7i4QV1GCgc25PYXK2wio2PMO63I7
	 gGCVPFP3ei0+6lDaoBz6w0MchL+1Q5sJVOr10GrI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmb0H059144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNv052918;
	Thu, 15 Aug 2024 15:48:37 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Santhosh Kumar K <s-k6@ti.com>,
        Judith Mendez <jm@ti.com>
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
Date: Thu, 15 Aug 2024 15:48:30 -0500
Message-ID: <20240815204833.452132-4-jm@ti.com>
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

From: Santhosh Kumar K <s-k6@ti.com>

Remove 'reserved' status for MCU ESM node. Watchdog
reset is propagated through ESM0 to MCU ESM to reset
the CPU, so enable MCU ESM to reset the CPU with
watchdog timeout.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
[Judith: Fix commit message]
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- No change
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


