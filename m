Return-Path: <linux-kernel+bounces-295901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF195A2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA151C20952
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2315351C;
	Wed, 21 Aug 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QaK1R72E"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362814EC40;
	Wed, 21 Aug 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257434; cv=none; b=gEcDk+Lx9PuheN75t7kN5oL/+o/cZoyCbggTiJ5uoklsPD5yPSB1tjaPQ2i2BjOCACwpXS3hnysEeMhDIaCKhlRTNxqs8OU2LNlPn7SJZPgqJvKPjpdIw9nYUQ/KDGjrd1QoF5+SqhCecHQfrRNIRGhBFkSztvq6qzixy4qw35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257434; c=relaxed/simple;
	bh=IlgkOfpLZsfSmC8n4JB5NUpLF2eEk10khOF05+WBkrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdgno5EkCo5OoN7iixCTnt6PQbltDG+kACPhFvDcOpCru77MKjepconb6YMFD62ga3UYwHfiE79TylozZc2GA0GdEyM0zr8l+4HxtqN51ISuKHhkzMy0bBywUXte0+vYZ5q5+oRkXsnb9cxk03SallJ2G1GmReMNrA52PNC+lxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QaK1R72E; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LGNdip088431;
	Wed, 21 Aug 2024 11:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724257419;
	bh=jsZ1nCYqkvtBVkMO3DjpIi65wQsggpKqsk3sXyMKhJE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QaK1R72E2CbtOeSVrZUTmhpHxxByKG8yKvQCPjAvtoVQDisvwcqJ+jnLlhiiwkUXB
	 vSCLBqqPFDQv09CuJ4MJvff9t120w2UzQNdO2hjhbODnK+rcoisgRlPwwsGHSehaRB
	 exNLUblKekZAopULKsSE21WuxmbuT9NIa3I1k91I=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LGNdol018783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 11:23:39 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 11:23:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 11:23:39 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LGNcGa086814;
	Wed, 21 Aug 2024 11:23:39 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am65: Add simple-mfd compatible to SerDes control nodes
Date: Wed, 21 Aug 2024 11:23:37 -0500
Message-ID: <20240821162337.33774-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821162337.33774-1-afd@ti.com>
References: <20240821162337.33774-1-afd@ti.com>
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
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes for v2:
 - Added tags
 - Rebased on v6.11-rc4

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


