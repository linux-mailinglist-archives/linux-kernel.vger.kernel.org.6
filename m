Return-Path: <linux-kernel+bounces-271855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407329453F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5D2B22528
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84114B96A;
	Thu,  1 Aug 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iIZ+sRgI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445414883C;
	Thu,  1 Aug 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546332; cv=none; b=JzIkqER6qPxnn2qv2aDgWOBr30HPrFe0fOUEM7EKCS0/yAo9XREPPpwR1zuSEf9TS2EZo/KPGsuXBSuwkTF8IpIP8Kd95tFhpAztZweDmPLPu7AgOYhijvNNa1Y7SloWsJvDAz5PbRHN/+6+/dxvv5NbvMLvuRFA4m10aeopBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546332; c=relaxed/simple;
	bh=qF3gkFUI/OArfrpnNmw6KfTS25RnCgsCufjt33ajSuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/GO3ImQaPwYDONBhHx0rzPGi2gSaDZXXQPEDxfQSj0Yhwa4mamoKvpWhrx3+PZIM3B/8Amh2RIbVtfOrZ94uDjwlyF62suMsq081j6EyZX4tu3Rb+RQGsxwD9nV9wmQ0pwLXElh2p848+mC6vBtHKrv0dfO1RhqdNCwPrEKFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iIZ+sRgI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471L5M32035091;
	Thu, 1 Aug 2024 16:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722546322;
	bh=GHkPqlPN6e55ynFogOss7TeSkMCf1tr7ys3Dm61ZRok=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iIZ+sRgI6DomHKf+IojFLMmJgqSBLDViuRHrDFEy8CZOnG6684CdVmyycX61nJpzA
	 0iwv4eZEGWIv3fhesbRcfxX1hx49M+myKhluYDNdOJIptzYJIHf73AFdEcdJ7Z/XKs
	 ecD4bvw1UMK+OyMvUvme8hiQVZoWM6bUfxIn7zY8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471L5MAn002326
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 16:05:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 16:05:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 16:05:21 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471L5L6F059856;
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
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0
Date: Thu, 1 Aug 2024 16:04:14 -0500
Message-ID: <20240801210414.715306-4-j-mcarthur@ti.com>
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

Commit 5e5c50964e2e ("arm64: dts: ti: k3-j722s: Add gpio-ranges
properties") introduced pinmux range definition for gpio-ranges, however
missed a hole within gpio-range for main_pmx0. As a result, automatic
mapping of GPIO to pin control for gpios within the main_pmx0 domain is
broken. Fix this by correcting the gpio-range.

Fixes: 5e5c50964e2e ("arm64: dts: ti: k3-j722s: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
Changes since v1:
* None

v1: https://lore.kernel.org/linux-arm-kernel/20240730143324.114146-4-j-mcarthur@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index c797980528ec..dde4bd5c6645 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -193,7 +193,8 @@ &inta_main_dmss {
 &main_pmx0 {
 	pinctrl-single,gpio-range =
 		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
-		<&main_pmx0_range 33 55 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 38 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 72 17 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 101 25 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 137 5 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 143 3 PIN_GPIO_RANGE_IOPAD>,
-- 
2.34.1


