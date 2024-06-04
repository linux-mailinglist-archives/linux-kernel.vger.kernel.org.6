Return-Path: <linux-kernel+bounces-200370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F318FAF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C321C20C41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC35144D27;
	Tue,  4 Jun 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZOHN3lDs"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1C1448DD;
	Tue,  4 Jun 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494101; cv=none; b=eO25WlE/a7hNiswm96tMEU4zvnZVDFH9A/LQ2jdWkjPj5k2cgBtMWq9ak/E8A/ODHVi4Zuboplmruoc5gxG81wZr96XGfw2rtoqrebUpbYI6p5ECZ0RepkSszFx+4fTRuqyM7TIqQslUW8rishBYgWrVfnduMRMFOguM2HbtKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494101; c=relaxed/simple;
	bh=4zMrHLhH2LoHm4YdhPTkKeewukfUWo0E6UOikyJNDoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FNIP5dQomP9iE2zoJbAFxP76JkomBxq3woZ5zv1ABLx2jLfE4w8s+VPBiingt7f5y5k8Khk93+xwhNatkQQUsKHVmfpZ0LgoOEC8cdbqtEJe1p2FFdERCKa89WDgum0X4s+bVODU2+fuq4RTB+blLeqGOdcQ8oTwkUTGkrn2sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZOHN3lDs; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fUSY102130;
	Tue, 4 Jun 2024 04:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494090;
	bh=vXp2RCvq5esQ3zfoYyr+zC2zPRz5pKQaBCxOq/oI/VY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=ZOHN3lDsnfKddc72x0B8c7rKdBro+yjI1fhn/FwB9zLQjTBcuzGw8nuf8GlMwfGzu
	 bus/NIXNWIUXnlyoet807rw5qFRUDbHcOex5WR2q1+/evi0QK9886Rig53uv5rq2XC
	 yWoBodnetITsl8ypketQlEZh7SyEkK6wh6d/PxVY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fUJ5024835
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:30 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:30 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fT0q096467;
	Tue, 4 Jun 2024 04:41:30 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:04 +0530
Subject: [PATCH 3/7] arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-3-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=4zMrHLhH2LoHm4YdhPTkKeewukfUWo0E6UOikyJNDoY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuE/6skW1BVIIsaiHXuG7QGfI70SOalrHvLu5
 ppFrFa/qySJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hPwAKCRBD3pH5JJpx
 Ra1kEACEjv3gHUuqG69YRrVOTxyrb+uFqRLh0d15iHrsMMwg0Uc/z+20lsRzcExHxsby4BKMKTv
 II82/4yK8sXheQK4yZMfG8xEkN+ED4COkfH8qohLHl1kcFm+t66ySH8eUtWKTHffXcskfzmQ6LQ
 lTy7IMTLIQK5PoxPCSzbed0YiFC2wYMH5tUswsQZfVoLTpnrfSwPr5+zcRZ/a4O9f+zrn2H9/SJ
 8FSR2LTXq+lWfe4B6SFwAwQKcmRrgiW9t0OWZHWM7L8jNaOp0iLT+GExcWpq+KI904p2xu0fJs1
 tLVEIr36M+UBXZfCoevF9VlrHiZUHLPgONcV9EVajDJFSt0wdoCWkkyrXqQ+E1BZHsLrqnII+EI
 FD3z6PWwAQQuY784mVSZWi0bK/sCCzXZ+ds796yWi3+J4aUGkP1PeULfSzU7AvP/pYQJCRPzhfC
 7mm4FDEYAIHO1DpFMIFvuluCu2/VP4QDfk2WlR4+E6efJVLxZx6VQdyLNy0hQfStceVNF6NN2cx
 eIX36nXsD/cdPecvvtYrZ1HcUUnWJktHpOWmgxthkfO7oKQi+oW8QtBBwjAblXsWJ5Vbo8BsExj
 qLWFpvvmHUz8yX8AUACXK2Mk9UqJ+kH5fX2KErAA6L0Br3LEKhKS2zzQKjnFuKTb7apLyDwXLUn
 ijALC53xbeZvZnQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 6e7234659111..2aaf7d490c77 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -549,8 +549,8 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
 };
 
 &fss {

-- 
2.43.0


