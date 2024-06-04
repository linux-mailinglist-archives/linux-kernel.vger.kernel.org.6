Return-Path: <linux-kernel+bounces-200374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA08FAF17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A2D285349
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAD61459F9;
	Tue,  4 Jun 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sb2AxVIq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B21459E0;
	Tue,  4 Jun 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494120; cv=none; b=bDTqnbz3jbC/B656/82V5ZNaI9f1ZpoAFBt4KHZmc4tljAihGRotFuZswwDe9THP9FRu8yl5hPAcXGk0NTQTDgw/5qluE891op+dwiZJHIf2iMYdYfyl/KTQPz/AqmMvGwJBTibbIlOLJEC7oajI0ciKeS01r6UQw2WgRzruw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494120; c=relaxed/simple;
	bh=4rolmuJywtA0nXiMzdaaC4yGO3ohzYuqIv5e1oCvaYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j2AAe+039k7TJmuc0oRf1KSD3SUJdbk4YS4ffFZt9llpwDtgLY7IHgPYN5CCoPDYP8KYCzbZMvx555RzZouxcLCAMZfBw/Ql2meT2mAKt8XOiurYf/ynJP83/hRb/ogKRqSlihD5bBoSQfnQnFpJUvGOzqv7Ezj20oCEog8qtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sb2AxVIq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fZs8086575;
	Tue, 4 Jun 2024 04:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494095;
	bh=9KNkRQA/HZK5dQIOIPJx88REWuE8drN2RxmNzWzrk+w=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Sb2AxVIq7mhF0z2ttwrrh0ojaGETSALDFcijZvAWfwADieDQU82JD8l4oKzgx04ot
	 mEyLo9D8KSm5UVNi9Mea1+gbu1gkdKXkQqECqKQYb7iB144L2OXIqz3/3znMu+VtLm
	 pFZWEWQeaZ1+6075g9ZBT35Gx+11RBsL4zOqqgnM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fZvT024879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:34 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fYTH011834;
	Tue, 4 Jun 2024 04:41:34 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:07 +0530
Subject: [PATCH 6/7] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP
 AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-6-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=4rolmuJywtA0nXiMzdaaC4yGO3ohzYuqIv5e1oCvaYk=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuFCs5kIwx0KdcvQtPyboJ9x82UWJmxva16zt
 xA90sSLQj6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hQgAKCRBD3pH5JJpx
 Rdv+D/9wolSIhdAoEuwOe6ESqhJTPbajW+0IdUazn9soshFxlUkdh2kAg2sUp/3Xf69+tQ7K0ZL
 u4odWMNNXwOPf9NFS0Vl/s9V1AwTc4Mun1s91EtjAMVcY/jH2mG6xY9bnnm/aIGwe0I+7FB+CAX
 CzB0zfT81QsYE127YdHaF0/IJkrcWEDUmmGT/2/ydbbPwvUU3abjHSErOQqjfZr4rmZjb7Y3swQ
 SlIqQcNSQei3b5jzm1IDdof0W6zaVYCMyBZtBaSt2H40rTrNxN97F9L29fr71EZOqdJiZoqBvRx
 9mgfUraQl2dqR5/D20DYweJCICVxelip+l4H7vMdaXeSE/ksIzo7hw6R52Iq8smUJ1/xbo3h6dT
 32zPKT6AtY2FIIxoNZ0SoO+XH2+SpkDfjpa78h25zEasqA9hMMJQ23j3fxqGSy0Jy3qDmhOKdgm
 1fefOGZwMs6+bnmNGu8bt8jLAnL4DF3Yu3MekIfvDqgw4nm4+MlwDP6JLczKwtY6y3ZjhKaIvTG
 oREC+qNRBeTjcI/63sWJ8KufAwq+1qsLtj/B2coWBqRBRU0o+dsDu3rSD+TNyc/K4iUOXeqQDe5
 mZ2C3CYJ62T1+mC93ET0wuThRLgIHMxxMwFklyKPyyfZ5HO6MkNggicU/rqJCyTiOCIgWqyNgLG
 KVfMsAHS/pE/j2g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 50d2573c840e..77c86ba3849f 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -441,8 +441,8 @@ &mcasp2 {
 			0 0 0 0
 			0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
 	status = "okay";
 };
 

-- 
2.43.0


