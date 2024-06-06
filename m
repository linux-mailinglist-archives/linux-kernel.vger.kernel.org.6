Return-Path: <linux-kernel+bounces-203796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBED8FE097
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE406B23B62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0413C67A;
	Thu,  6 Jun 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z0hmQjTb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A513AA48;
	Thu,  6 Jun 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661365; cv=none; b=kPh1lEYhBAru4YbalpVjslahbpxig4tYhWOwm14gafWzADnmiXCaNkqzSRhKy/Hab5aLgZnnQraMSZc2cNKKEDpkcQ6Z1L6tnsfKJk6n/5t+RUl+/s6GlXOGrIRg4e03pYSDkmWCLVbazHBbWSmwOAFYj5jzilLUzHhjcnOpHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661365; c=relaxed/simple;
	bh=Z6ZtYF+tacCS3Y3EPDaR/YMRNAcpL5ZpT7z7LxkeYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L657IEPryUZJY26hay41K7F1aJm0l78buT5Hx+SAqMk1Uic9+L0FWc9xNCl2HSeQLMaPGFz1KRicYxvTLLxqswoGCGxeAZ6oQsc5T2Q6GIegJ1s92BaPOO339SX7ZQOh0Vxz2q9AJs4hRqVjaNZb4Fsp45gMy3BgXmDlvlBqlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z0hmQjTb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45689EhJ089374;
	Thu, 6 Jun 2024 03:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717661354;
	bh=JYEt+lP+P6A015ogkke7INZphgtN1Cox1YrIcjuzjPY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Z0hmQjTbDlEeyVkNDq2FAdMxiMlkkGpVeKXXkvbK3IoY2J+ZA7dUFa1+D4FQ7m2Py
	 IJ+1xwnKC6/7ETHClPrGBZM8sCryGNvNzS/Jtz/UAIT2ngFn8n8E67oHpIwHzvR7y1
	 5J7fuPw42Vtuy1G33WTgDoFlQyX7PcLkjWq45qBw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45689EHT033635
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:09:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 03:09:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 03:09:13 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45689CiY072642;
	Thu, 6 Jun 2024 03:09:13 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 6 Jun 2024 13:37:41 +0530
Subject: [PATCH v2 2/7] arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-mcasp_fifo_drop-v2-2-8c317dabdd0a@ti.com>
References: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
In-Reply-To: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
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
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: 4a2c5dddf9e9 ("arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index fa43cd0b631e..e026f65738b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -701,8 +701,6 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
 };
 
 &dss {

-- 
2.43.0


