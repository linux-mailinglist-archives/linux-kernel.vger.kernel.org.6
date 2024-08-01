Return-Path: <linux-kernel+bounces-271853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DB9453F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0750B21C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB614B945;
	Thu,  1 Aug 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ESZ8yS8w"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B951EB4AF;
	Thu,  1 Aug 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546331; cv=none; b=j4mrlYAEw/nkU6lAygt7WJ12m+Ip8cc5vX9Y1iNIa10TSWCe+zD8uo84SrkwRom5GyvfRpjuSn1pyiAdZBGrfUzvKpNGXxVNhzCiZV+LVAj6vzAIIOfVPqFU5MGqQqevq4cX4KO0UF5hukoygh8KoFhj/k2mftgoVWYPjb3r+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546331; c=relaxed/simple;
	bh=g7Bnuk8Wjkp634pvnkFzLhNdTB3IOoB1XO3CU3lIn7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpCb6/qAKF4KTVJ9H3lmplky6KPbLpvzXnACaNT6fNJ87PxRjn07SMXN3MqpyJEbR4oFiXlyMVf2BhscIDzhO5bsri3HULBnuG357VEX+sSyJ85wEcDmugskD1tsx/G2IPOdoUyw+UB2zrtgkERslUOSSZlsiXSzEBLzUZFaLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ESZ8yS8w; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471L5M8r004128;
	Thu, 1 Aug 2024 16:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722546322;
	bh=b9JCIu3vgzvuuyB9FzIys0ajlrvriJvHjMYfrzigbIk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ESZ8yS8whmtpe6hP8Gr/u2M4gBludrynyk+G6t6IUuOCVIzFlz6K52ZuzBpDgSbjw
	 g1i61NCphUKZ7Sh4BauR0XINBGSfmoZauTc7tqgB/KIYSq2A/YlL2lQ2Kf13axu4u8
	 ZmRC9aPXUreDVNJSiR+5NiULh12pmMN/5qg5BP3E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471L5MK2002329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 16:05:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 16:05:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 16:05:22 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471L5L5r105779;
	Thu, 1 Aug 2024 16:05:21 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Jared
 McArthur <j-mcarthur@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
Date: Thu, 1 Aug 2024 16:04:12 -0500
Message-ID: <20240801210414.715306-2-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801210414.715306-1-j-mcarthur@ti.com>
References: <20240801210414.715306-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges
properties") introduced pinmux range definition for gpio-ranges, however
missed introducing the range description for the mcu_gpio node. As a
result, automatic mapping of GPIO to pin control for mcu gpios is
broken. Fix this by introducing the proper ranges.

Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
Changes since v1:
* dropped redundant ti,ngpio

v1: https://lore.kernel.org/linux-arm-kernel/20240730143324.114146-2-j-mcarthur@ti.com/

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index e65db6ce02bf..df7945156397 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -146,6 +146,8 @@ mcu_gpio0: gpio@4201000 {
 		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
+		gpio-ranges = <&mcu_pmx0 0 0 21>, <&mcu_pmx0 21 23 1>,
+			      <&mcu_pmx0 22 32 2>;
 	};
 
 	mcu_rti0: watchdog@4880000 {
-- 
2.34.1


