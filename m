Return-Path: <linux-kernel+bounces-267694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD798941471
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E77E2837D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796331A2578;
	Tue, 30 Jul 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j8swvWuM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103351974FE;
	Tue, 30 Jul 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350042; cv=none; b=N7qqdUlfpZn45f7s1j7dHKo2uUw2rDIA/4vEwjydOpTIFuCGEWwIhiEdP3OR9t3EKBAgXMp9btAM197QQl2O3Xwb2/aALum+NP9nY24azDePHtO7AX6avUt38zWV9jD9KS1kkjbpQnBRtIlpOYblb/1bOZV2+pkZKyFPe2i7HWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350042; c=relaxed/simple;
	bh=QntFGt347xXrOS+YXm75fiIXVZq1DpgEZhigVB4Ofqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqprjiKShvCB65UahgNfEUJ0FqSIc4uYvPviBUR9t2l4ClwOFC4wWgj2RRrxmaSVU/ffnq1dIGIoNolgqTBPBmATYkjXNoh2/wGXCbT8ZDjvlCRQDs5WwQdluZ9Rh36rYdKHqwb1YnurT4tyACfpTQiVK8920jFkrCmZdRblWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j8swvWuM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXsBw071998;
	Tue, 30 Jul 2024 09:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722350034;
	bh=V7yVmENLwTwAaEZDAC7DlgO6gkCfyJeBQoy5yswINZM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=j8swvWuMIXDkvj+3bFhfRtxuV50okjwABv9QKhCLMb2a7CwgffimIWwjTcOoBdjCI
	 k21IWlDbkx95l/SIHTzSiV5JacxDTGhT5XpZuj0AceFOS81+iVBxp5U42AQIleWzWp
	 JEPhqc2B3xShzsvmwYsbRLAGcBgDzxz8Epucy3AU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UEXsLo002830
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:33:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:33:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 09:33:53 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXrlt113107;
	Tue, 30 Jul 2024 09:33:53 -0500
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
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
Date: Tue, 30 Jul 2024 09:33:22 -0500
Message-ID: <20240730143324.114146-2-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143324.114146-1-j-mcarthur@ti.com>
References: <20240730143324.114146-1-j-mcarthur@ti.com>
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
properties") introduced pinmux range definition for gpio-ranges,
however missed introducing the range description for the mcu_gpio0
node. As a result, automatic mapping of GPIO to pin control for mcu
gpios is broken. Fix this by introducing the proper ranges.

Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index e65db6ce02bf..c0bdbd00dc23 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -146,6 +146,9 @@ mcu_gpio0: gpio@4201000 {
 		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
+		gpio-ranges = <&mcu_pmx0 0 0 21>, <&mcu_pmx0 21 23 1>,
+			      <&mcu_pmx0 22 32 2>;
+		ti,ngpio = <24>;
 	};
 
 	mcu_rti0: watchdog@4880000 {
-- 
2.34.1


