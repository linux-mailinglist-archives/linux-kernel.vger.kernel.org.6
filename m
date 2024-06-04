Return-Path: <linux-kernel+bounces-200373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C995B8FAF14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061DC1C21CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0B14534B;
	Tue,  4 Jun 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lMqzeHjG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D41442EF;
	Tue,  4 Jun 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494116; cv=none; b=WXvTpwHHGPiNRTtZmJ6F4k9XvpN5DBowHk2UgI+txXGHvWceXZwJaYsqVNKIRnLXs+wnJyFAowGKal/roDKmLo3endvGsfC7w2QHWVNsgYQGq6Zx+QyqAvHff+1FS9i/+tiCoc7BpuFIHtYTQ10YjCkd4kVrNlYntsM21MxFof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494116; c=relaxed/simple;
	bh=vhm9+/bOBnp1aAf/jXpVX2Lb9VjUWQ9rJ2dojj3h1Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CZZz1qrX/Hm11UtpfWCHh2Cl7xJyjjsJFnca65Ly3PFaPrtjVRk/6r3Xd7/zHyd0LPobT4wwYQNhbNS+kninYsa98ASm9+XNeGnsdU8pmfHNHdlWOn/swHlDNYJM64KCWpZ+M3YDPcasw9jL7IFfsVVn1FfoUTWPjwCksj+rJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lMqzeHjG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fWoF086556;
	Tue, 4 Jun 2024 04:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494092;
	bh=wyieTMQxPe1isfeGCTXfqMS/lybaTodWDsybguE1m8I=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=lMqzeHjGpwwR3mOFfY6+t3cktcW7T67KR4ZMCX89kGEaijJpIUQFZL4/nu5C3Wphq
	 ZgH1nRBW1A4ZV4Xvr6oE2VGLB2qlIQUUzXLsLW1m36DxNduycj9qrkgKqa3WZ/HH28
	 tQtw+3N/G2r90Azm5PKl/EOOjve1ly9fPJtCvXI4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fWoa017906
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:31 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fV1J096489;
	Tue, 4 Jun 2024 04:41:31 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:05 +0530
Subject: [PATCH 4/7] arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-4-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=vhm9+/bOBnp1aAf/jXpVX2Lb9VjUWQ9rJ2dojj3h1Pg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuFAnl+6TMILRCNnlR876GHy74okSJQ/Ko4Ud
 c/zbQVHxmaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hQAAKCRBD3pH5JJpx
 RTOoEAC75RJKdASBiNu133vh5cKTiMwkiohBCgubUvPw9mhGEACChJasoSmtJ+aJvt54jHKq4KT
 yzn3Hs6oNe27o1uEN4t9o1k1uY6XNnP13TUK5UD10etEuGSmz82R/JpJi1O3Wgv4wJx+xHAXUxQ
 Z7jYCcJ/5qwce6qcRUD0EyOaX34uMFKOcOv1Bzwx7O2C73XuLGv9LDD86SKG+keO6SvynkCSSre
 kJE5qG1OvWCWidMhP01bWCyhVYWfbQFbJs35pN4AsDxcHugVejvz7FpsCqPuO7qUtI9AV5LdGoy
 85hPRoddPCSMAwvenmpv9D/CAOLt93os6BgZD5EFPjN6STo5hTJnikoO40S7W5hTQJ3pClFUoxn
 VWJxQw0ytIrkdMhhtLstVkVo+tsopU9v5+zu0TNF5dyXtvNDQDvgpc5wgGpyPo5Ristja863zVC
 H4X+W+rKCahCtnNxeDTT+3/Cte0Z4T+vlxYFKvFLgyj68dZy5nLfI3dKpbqNMYa/CQKEmCaSKkn
 A/RPE5mqG3BIkT8bOUUvCN2SOf/87ig3mGEOTjoFDMaROUGOEEbFU5jyLQ/ctlZif2cCuS3RRNj
 sayfjPhLCKY4f6XMbKGdHEgOhJPZ8qKSJXVVYMaRSGdFwIPpBnuR8KSH4GOHGavMqhygge8QMIE
 NQGW6LC+WWil2CQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: 1f7226a5e52c ("arm64: dts: ti: k3-am625-beagleplay: Add HDMI support")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 18e3070a8683..c6d17332e6d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -924,6 +924,6 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
 };

-- 
2.43.0


