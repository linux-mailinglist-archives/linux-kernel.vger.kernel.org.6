Return-Path: <linux-kernel+bounces-276963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC596949A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794DD284A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDF171E6E;
	Tue,  6 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mae3DXWY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995416B3BC;
	Tue,  6 Aug 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980774; cv=none; b=hKNBrPZisg4rLtPYtbiOp8SmuZpUoiSwBNbv42LZ+v6pmg0mX/a+qtbp2XzjgQ+d9A8IMe82UZN/IEPXzVpmfZBWnSE9Lm4WfxUCEWdvrZ6ozHN/NIUoV4QgqhTmApzyUIXGpq13I4vK5wfs2hM1amQE5mwKlljpG0yI4echpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980774; c=relaxed/simple;
	bh=ODh5FjWe1JqdkpwwaU/GHEAy6y/w4RhSQ0+B1+2KEQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOouRiMb9+PpRJ4vKESTUADS8ijSn+W9aal183hw7ygz41woSpn3eJ7Dh+aL/fmkFtLS8zH16GnCq2IobQto8nW/D2q8sUuMGVZxBLFpwtEpJjZQOayHjjnJC5+giGiTBqxBz/o4zkjFQCSAFzIXmOffD4sPHSzHcNSKutGfGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mae3DXWY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5q8124337;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=LyEbO1uoOEu8xNfXsExJEWUpZXeTCDFFEcwSVkSTzEw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Mae3DXWYbtgQvM5uq0MJ+1AEoUPupK8pxGHmjeHjrlm8oLed3+t2OkPSTwAVQz6Kn
	 bLsAUO1x9APhliZBqeDxS9yxH20TSOlTQb4HaO9wUliKDzvbuqdOMwnTrZ6iii+veF
	 G3OUeY+Tihex3AE5XOf9PghMIqo+Q2EtZZTVOlJU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk5NX127333
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qu100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 5/5] arm64: dts: ti: k3-am6*: Fix comment in watchdog nodes
Date: Tue, 6 Aug 2024 16:46:04 -0500
Message-ID: <20240806214605.3379881-6-jm@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806214605.3379881-1-jm@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The am62ax and am62p devices have an MCU R5F and not an
M4F, the following comment is not correct:

/* Tightly coupled to M4F */

so fix the comment in watchdog nodes.

There is no functional change.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi              | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index cea0e1d4caaa0..a5a33491b51bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -146,7 +146,7 @@ mcu_rti0: watchdog@4880000 {
 		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 131 0>;
 		assigned-clock-parents = <&k3_clks 131 2>;
-		/* Tightly coupled to M4F */
+		/* Tightly coupled to R5F */
 		status = "reserved";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index d913e6319bad8..d5a498479cba2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -154,7 +154,7 @@ mcu_rti0: watchdog@4880000 {
 		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 131 0>;
 		assigned-clock-parents = <&k3_clks 131 2>;
-		/* Tightly coupled to M4F */
+		/* Tightly coupled to R5F */
 		status = "reserved";
 	};
 
-- 
2.45.2


