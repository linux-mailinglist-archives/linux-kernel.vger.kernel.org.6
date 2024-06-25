Return-Path: <linux-kernel+bounces-229326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E9916E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6352F1C22881
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6017624C;
	Tue, 25 Jun 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LZInIOVC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED014A0BD;
	Tue, 25 Jun 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333944; cv=none; b=KHKi4S/pT5JzmhqXsP7+qWKblojJosnMNQBB3CT/B9GCHPPgUoEQ9ZpQ1NVZAqbS4FXbjGN8fTOAhTDJdVBxn2BLdo1KHEvysJYHuGQxSTqhHeZzaqrFclN52NXiHXofC/pHZ2cJ9YFdGv9tjJT/FSTIxz8TkhWzDavzXXAhwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333944; c=relaxed/simple;
	bh=7VGktBMjJm1F5kEgu+eG49j808xdoQRCUeH3bPSDE7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SugREmfGzraqX577v50R70p0r6PLQx+o2h+fl9n70Dog8ximI2XKnYoJK3Ji7v7o91sphVpplRutxLVsw4DTuI6nZAGfJp02S1IIXynM11nBRemR127slaw8InJgiD8u8BveEY/QooUY/chzRdrVQLBHdMKJ1r3iIY4amKuHxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LZInIOVC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PGjUI9090365;
	Tue, 25 Jun 2024 11:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719333930;
	bh=zRGQG9Rb1rfkIII9wIB5nbTnoIp5bbocCt59dd6DS6I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LZInIOVC03jUSm7g4lh8jxk8O33kRn53rYsPoBP2jMxoOMxmkuiXyfdeqx/yvqzPY
	 OdmlDB6UVPTlRZzgIXcolAIl6+Yae2tzxYwrk86TqCDlvg9vWvtkL2k+BUvj4nuwgA
	 dP/JZOA/Gtk5iU2j1cw+Uyc8nNS8ojtgT48OX24A=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PGjUQu021183
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 11:45:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 11:45:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 11:45:29 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PGjTcP048951;
	Tue, 25 Jun 2024 11:45:29 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add simple-mfd compatible to SerDes control nodes
Date: Tue, 25 Jun 2024 11:45:28 -0500
Message-ID: <20240625164528.183107-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625164528.183107-1-afd@ti.com>
References: <20240625164528.183107-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The SerDes control nodes contain both a clock and clock mux, this is
a simple MFD. Add this to the compatible string list.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: da795dc4f2a0 ("arm64: dts: ti: k3-am65: Move SerDes mux nodes under the control node")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1af3dedde1f67..06ed74197f893 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -478,7 +478,7 @@ scm_conf: scm-conf@100000 {
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
 		serdes0_clk: clock@4080 {
-			compatible = "ti,am654-serdes-ctrl", "syscon";
+			compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
 			reg = <0x4080 0x4>;
 
 			serdes0_mux: mux-controller {
@@ -489,7 +489,7 @@ serdes0_mux: mux-controller {
 		};
 
 		serdes1_clk: clock@4090 {
-			compatible = "ti,am654-serdes-ctrl", "syscon";
+			compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
 			reg = <0x4090 0x4>;
 
 			serdes1_mux: mux-controller {
-- 
2.39.2


