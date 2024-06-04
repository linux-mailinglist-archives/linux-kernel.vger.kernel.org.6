Return-Path: <linux-kernel+bounces-200372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCEA8FAF12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA641F21B79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33821442F7;
	Tue,  4 Jun 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J+0XZxd8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11111442F5;
	Tue,  4 Jun 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494115; cv=none; b=uxcSQbMJ56cxLALjMpamtqUkoau/nR9bUNLXXT89VoH1NWuHMb5hpp5rv6Cw1uK/evwb7n6He9Af98OAlfOWCnqllaLRrIQDV01xD21SRbsYbmxSu4wwAcT5v5QS9LLWpXx9pmZZzY5cLM7hLq49Da4T4d6Rl2dz3Xq4bQAm4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494115; c=relaxed/simple;
	bh=Jcazw0obWZLKwsKNQPAwAyUpJ5Qb7Zl8JnvzyVbTM5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Mccq8RX+1dP83NEwlh3zCGWNjgiTSyOEePRS7t1mONGurqxSw9ZmbQZqh65r0xjs+4qtM/6K/LJbWFqMRCASLNh6+5qRIixNbXdutE8c6uzNoaeIfo5Bb1tVycJyoH6LPZPPd/j/l5fRtTzxYtEj5dRkaVDR/4MPih/xgqD1Rqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J+0XZxd8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fXWg086565;
	Tue, 4 Jun 2024 04:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494093;
	bh=Dykuaq6u5rhPJ2hQIAQdWCCQT3gOqxMhs6+qY9jR+g8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=J+0XZxd87vc0vmrQqdeJcnnP/kYnoqTuLIDfqKtEywsuZ1sKhJ8wlkOmLNfgT5ePE
	 a5mD6jbH1eYlUG04w3kD3Gk8qmewCVfBdPItPaSMyxsiYIJPpHzXzm1/pI+hn6JYK+
	 ciWOLSl11KOHwMZJ4umANp8/Uw4M+lrsO6Tg/BZA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fXMD075091
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:33 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fWbJ011812;
	Tue, 4 Jun 2024 04:41:33 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:06 +0530
Subject: [PATCH 5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-5-03ebe25f47db@ti.com>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
In-Reply-To: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Jcazw0obWZLKwsKNQPAwAyUpJ5Qb7Zl8JnvzyVbTM5Q=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuFBnmgF6XgUvMxwX8CmnmodY05M3d/r50q5U
 bahY+lRLM2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hQQAKCRBD3pH5JJpx
 RcAbD/wLMWqsXEFUeJxbB05Ko6KUHRdW8lmRJX/lNrT1Oi5fFuF0JojUUn0ZpX5btoqCuaTOq7P
 GbyVDGU9lfoqYf7Xk62FngwQ0Nd525PwwENk+gKfUiFII3tGWHn551beyaCkHc6bu1sicPI1Wmr
 d+/aFeQhtlRhlNPqZL4AqJvaao3A7Krbx2Mb6NRRaTE52afYEPypDOZD8Lu/Gc+VQuMfo+15JbB
 VJO7h2qMnqLe78/kqfUXe8GlbbSYaJqP6Xf60vWmh8Mql00y2ytFIW4Xv1lHQoPNHZuMqdaBTyl
 JQjgJ67ezrZ70kS0tvNUXrtwrJv7s7wNsy1Cbwubm4KHOMzODSUAuGW+nFUZIeYOxkgvaN5LquA
 068uBPcq7KG17UI2J6kR9Zi8/2c/z6r55ek922CFex95ROSYRZW/Q9VcJ2OM8KH2d4yiTTu28OZ
 43LEQcO102VthtrwsDHkjeE9gzvo95VQkQpx8cYWcjWg4T2O0ru02fMK4m96VtogLHKNGGOtM4M
 7ofXpP3Q4c/EKyg66wCJjZOYWGYa9+ujxdmMNBYzeRY0ymPs1qv+hq12kBK5mwG6fz0s5wv2tQ9
 396lWOTSgnaqlcquxxvfRDuKN5OkPeZ2i2FPjKcG8f0p8D8pAupMSPvGDKtM0G/l0mufbGmXhA4
 LZl/sLfU0dRZOgA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 2038c5e04639..27e5220e1dc7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1364,8 +1364,8 @@ &mcasp0 {
 	       0 0 0 0
 	>;
 	tdm-slots = <2>;
-	rx-num-evt = <32>;
-	tx-num-evt = <32>;
+	rx-num-evt = <0>;
+	tx-num-evt = <0>;
 	#sound-dai-cells = <0>;
 	status = "disabled";
 };
@@ -1382,8 +1382,8 @@ &mcasp1 {
 	       0 0 0 0
 	>;
 	tdm-slots = <2>;
-	rx-num-evt = <32>;
-	tx-num-evt = <32>;
+	rx-num-evt = <0>;
+	tx-num-evt = <0>;
 	#sound-dai-cells = <0>;
 	status = "disabled";
 };

-- 
2.43.0


