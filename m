Return-Path: <linux-kernel+bounces-405799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C29C5718
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5021F21D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C081CD21D;
	Tue, 12 Nov 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ok+9MoXS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CC51AFB35;
	Tue, 12 Nov 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412647; cv=none; b=rhgeg+Dc1pMcqY3emgzG0s9D5bCI4q+9pI6XuDF90FuOGGwPpcJsmpis/2jie+6EcwuLQoGb3/EQbWqmPr2OtH0tNTijQrF0UfuFNJtTN0ZLXQ+N+S657p6KFfEWLX8VVruZH/W+j8+DGMup5P+pQ4UZVuGcI57ZmmrXBZljfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412647; c=relaxed/simple;
	bh=xS52C3BHzAzR6R+q4CaOUGQBb6/cg76UPpzj87DhpSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4f4poU0Swy2b3knZ4izZcKGfy1R0tA8HiJkQ40Hcc63Ul/gT9JgHY0hSkeYFsvzuztUmHKRkUKMSjbGmTbg2vrUgMqBTqAyGhQTwKwmGeYefRayqBLc7kfGCHCn2Zi0jwHA+ILep+1bQ/Vp5eYDqtDNzvPTFiGgsUUV+khA5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ok+9MoXS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ACBv1rU2669700
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 05:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731412622;
	bh=x39qJZiDk7Rcvu2YVAqB/TtapZ8KFsFMLViv0bVAnOw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ok+9MoXSU13GDmvZ+s6KaOJbgaFcU/MRMz63VkU6/NuQFoNi/ugOx9xI9YunGzQsZ
	 PHuERkgBs1L1LWwvzsad8uTbVUo5HjOAMjYqFODIedPmLyitV3JU1gC+LP6ui6SGrS
	 /PqK34NBUXCL1z5GGF6LoXCmNDcegzf8sDl9132E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ACBv1G2016256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Nov 2024 05:57:01 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 05:57:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 05:57:01 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACBuo5U116685;
	Tue, 12 Nov 2024 05:56:58 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62x-sk-common: Support SoC wakeup using USB1 wakeup
Date: Tue, 12 Nov 2024 17:26:50 +0530
Message-ID: <20241112115650.988943-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241112115650.988943-1-s-vadapalli@ti.com>
References: <20241112115650.988943-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

After the SoC has entered the Deep Sleep mode, USB1 can be used to wakeup
the SoC based on USB events triggered by USB devices. This requires that
the pin corresponding to the Type-A connector remains pulled up even after
the SoC has entered the Deep Sleep mode. Hence, enable Deep Sleep pullup /
pulldown selection for the USB1_DRVVBUS pin and set its Deep Sleep state to
PULL_UP.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 6957b3e44c82..8b6316454639 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -256,7 +256,7 @@ AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19/V15) RGMII1_TX_CTL */
 
 	main_usb1_pins_default: main-usb1-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
+			AM62X_IOPAD(0x0258, PIN_OUTPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (F18/E16) USB1_DRVVBUS */
 		>;
 	};
 
-- 
2.40.1


