Return-Path: <linux-kernel+bounces-302819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A9B9603C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491011C21268
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F36137747;
	Tue, 27 Aug 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U9/UPpVF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459F1F943
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745644; cv=none; b=DckXu2NMPK/HN0SHcotWZmNO6uNNyWfT1UiJvkN0etL0mYKREYcpKt/uQNPpyy/Lv7FrJbhI7ui8kAPEi2mExuVa2eOm/HQKUHwEZ2Zf8+DzaOOukwkBSrq71EAHyqbXGzDc64ffbQoeMwaTIsyewA2tM4H0HZfY+y6q5p0hZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745644; c=relaxed/simple;
	bh=hP6xUUa2oypmOMyj+WTzvd+qZlZbWwm7By1A8lxAYBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SM6CBzMMX/5Va8ZMwJMTnzQxdSWzDN91pvb6+N8qLtfK+fD60OXD1V+yZvQ4u9FBT3T4n59FAp3arMX8PVB3p/9/yAu7HkPfbisL945Nh6JXHrPdYzP5xzadddF8/0V5TKjwje1vX+iSL8PodJQ2SzuLoTGATdVLkvJYN/3pvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U9/UPpVF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R80buB116462;
	Tue, 27 Aug 2024 03:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724745637;
	bh=Qw/ani1+z04T/bnLHYREODngcUczjgr9jZVAQ1X+g7E=;
	h=From:To:CC:Subject:Date;
	b=U9/UPpVFa38Wra3WSqHWTMCYbRcSenwyfrdY/mAYfOjKW1qM6vJoSVQ+RcyWHwWG3
	 /YyLbvU61E0nDWNKlEfRfDFaYEKpMBBqsKFVZCjE44AThU1yjm5Q/2fiPYzEPL9afM
	 ImWqaYTzbDmN/FpiqFHtyqwkEAlITNKRkGRiEeRI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R80b3c017733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 03:00:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 03:00:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 03:00:37 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R80WK5117203;
	Tue, 27 Aug 2024 03:00:33 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@vger.kernel.org>,
        Kevin
 Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Bryan Brattlof
	<bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan
	<vibhore@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
Date: Tue, 27 Aug 2024 13:30:07 +0530
Message-ID: <20240827080007.2097276-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add another entry in the wkup_conf for the syscon node, and then use
that for the syscon in opp-table.

Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
be addressed similar to how other child-nodes in wkup_conf are implemented
in the same file.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Based on the discussion we had on [0] for AM62P/A devices setting OPP,
Here we fix the AM625's opp-table using the syscon region in wkup_conf.

Build tested on top of linux-next.

Cc: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>

---

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 5 +++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index e0afafd532a5..3aff8af549a5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -22,6 +22,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index c3d1db47dc9f..c249883a8a8d 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -108,7 +108,7 @@ cpu3: cpu@3 {
 	a53_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		opp-shared;
-		syscon = <&wkup_conf>;
+		syscon = <&opp_efuse_table>;
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;

base-commit: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
-- 
2.34.1


