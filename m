Return-Path: <linux-kernel+bounces-200369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 211838FAF0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CCAB218AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE51448E2;
	Tue,  4 Jun 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yIIy8lfi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4882D98;
	Tue,  4 Jun 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494099; cv=none; b=l8KB+WkfOGaBmyx1o+zn6Wn8hdCiyOd+eNPMPtB5KClQE80663QTm2ztSa5o84fvZG4bopGWF5JNTBTpg9j1biBAT39Hb5SL49lfUk3ur5xIy9qJ3ZV0Rz3H29BZgL6dAINfFfkzHjHYfJrW3saQ/8uRS4Y/27Poy91Eo7iKCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494099; c=relaxed/simple;
	bh=337N93AnulaVgid+t4I886dBjQ1GexdHK2dRBbkN7x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L0YO7BpTcFrvX0bgaeQ07+klh03gRLBLKqNQZy0XwmpbTEn7vFiltSBUC4EKiQ8cskbwNShXwSJ3hWbZkpxOH/tTysCrLSVdjzqh5q+mljXd7BbNmGmJVplpT1nvZEzh18OWswumjCt7L/gV0ooLO7hnC05XzFVcV0UuPUrn9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yIIy8lfi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fTL2069650;
	Tue, 4 Jun 2024 04:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494089;
	bh=wR6OTiy1ktPRJj0kwiNcAmwXiqsNuqx+KtctIa8vjEw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=yIIy8lfiwA2P1Nvit6SHFmMpisAxjJBXESX/OHg6L+3OToTH+MMBuNtNJWiVYOQ3R
	 E2rAM1aQvFm+FEbjX/bDzQ7TeIMM3GcwZBmqQPzzWUoSKKepZ9rxEaG21uwCbQmC3e
	 YrnLAJLZ8yp/o/NU513GoPK4RcnN2Jj0FOZlytj8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fTDG017887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:28 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fSZX096435;
	Tue, 4 Jun 2024 04:41:28 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:03 +0530
Subject: [PATCH 2/7] arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-2-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=337N93AnulaVgid+t4I886dBjQ1GexdHK2dRBbkN7x4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuE+w+k30Hrjw2aooKMP2xR+x4UOpNaZ4XsEy
 JpHzVKhtsWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hPgAKCRBD3pH5JJpx
 RUaKD/9F1n6wnjn1uzNIWlgl6BUS4A+c4kgPZgCCVzEMRxHV1EYYfNnovecbYCnYBA+nQRKzlpv
 JGkX6ESmBw91gtvgJcGsTx0UalY2tlq+V3pxquLH0KKDOvtAvXfjX7PUhIE0Va7wjO7uMULSq9o
 vweDs4SOBzZE2O9fUL9wIzp/jGj705mzyijYr4DyXLXp5Jv6xNOMwf6eQl3geZ6r0atqR6BR6Av
 mdJN/F9gO3XdMn76H4jY3nRBLkyUhZV3Iwclfkckh+pWuVuBBC9wpqOiXIBD5L9rf3oyVvPHE88
 3h+rVC+DFXEmNTdmwcq0NJLK95spZ0DboV1GLE3xxIYAqXkkMIKx8pgnA5GblHd/u7vMVOoEB+o
 Z/8GohfcjoPiswL+/qtDXwQLviMWiE5++9bcwRIqP87Yi+Z+Vmjsf9VeBG6w3y8gtERf56dXwqM
 szqXtAkgkik3Gr3em3rdAf59jGsDU77YdIE9cSjE3UxSV7nsiC+nM75kQcoO7ZxebzHKCyXkJD1
 KL3LXPZW0m1RipWpbA3rBQWsFZnIOMJ5/DEQ+pCz5b+NdOMSL99xgbHJS5eiR52VyWMRQ2Rq8E0
 WPrbN8rLsrt7FTH91u8YvCyV3QQ1PUlNT/H8+1WvTUVYOOM2hjPNyv88WsGUbYmBfER288l6qD9
 QFK1a+JR37HOLVQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: 4a2c5dddf9e9 ("arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index fa43cd0b631e..b042599b529d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -701,8 +701,8 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
 };
 
 &dss {

-- 
2.43.0


