Return-Path: <linux-kernel+bounces-271854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EF9453F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BE42835B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB614B949;
	Thu,  1 Aug 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lMTZA3xe"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F313E04C;
	Thu,  1 Aug 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546331; cv=none; b=Q168aPr1TLdP0lOCfVjoGC/e1cT3OkGGM7cJU2vBKpRjhVM+ffFxU++50SJLSTLDGDZjPNVPp/HmaqK121lpPhfGOJfm10nmYCu1d/pn9mts5fYrNZ3WiBzdERYCmwiqhyx7+Bs4mXjbshwCV6tKr5n4bDASQeaat3Sa+uomIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546331; c=relaxed/simple;
	bh=Ekuta/pBbRFxhkFHJZ42JoT5WTBifV1idhQ4xWbw2x0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0deRPosEDxYFehQ7KitIJxG8aHB8MG7U6qzmnGeJ5TZF5ugwIr4vAnio9qhNBPYsU8WVY4LutbZpPHckHeafz4I9xfc4mGW0DI2REN/Sj1fET7gngDQV/94kGnRG2eVX0eA2V3Uxahnc5A6wnHylnPqypD1CG3kSubQ5gwkCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lMTZA3xe; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471L5Mh6004120;
	Thu, 1 Aug 2024 16:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722546322;
	bh=pJN6qnHF/4DT1uXdge7zSy+X4d2EnY1ksPhBHlo/BJU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lMTZA3xejJyDSSiEVc0DPWK22/9/tMisic6b0FeezcpvY+MVtr884lvwPEc+HpehW
	 imnynBPJxfGFL62SvRCouukeE2gUWWPjKRKKLV6JPX1efOVDUV3B4WeXhck7r8wP5s
	 vlrJrho68dbUBS/5yGTfh3maTOP4YC0TBaUooPBc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471L5MsW104991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 16:05:22 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 16:05:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 16:05:21 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471L5LdR059853;
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
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
Date: Thu, 1 Aug 2024 16:04:13 -0500
Message-ID: <20240801210414.715306-3-j-mcarthur@ti.com>
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
missed a hole within gpio-range for main_pmx0. As a result, automatic
mapping of GPIO to pin control for gpios within the main_pmx0 domain is
broken. Fix this by correcting the gpio-range.

Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
Changes since v1:
* None

v1: https://lore.kernel.org/linux-arm-kernel/20240730143324.114146-3-j-mcarthur@ti.com/

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 57383bd2eaeb..0ce9721b4176 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -45,7 +45,8 @@ &inta_main_dmss {
 &main_pmx0 {
 	pinctrl-single,gpio-range =
 		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
-		<&main_pmx0_range 33 92 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 38 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 72 22 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 137 5 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 143 3 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 149 2 PIN_GPIO_RANGE_IOPAD>;
-- 
2.34.1


