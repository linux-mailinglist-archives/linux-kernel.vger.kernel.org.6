Return-Path: <linux-kernel+bounces-200371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3138FAF10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6243C1F220BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F6145322;
	Tue,  4 Jun 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ILLOBiVs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCD1448DD;
	Tue,  4 Jun 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494107; cv=none; b=HOo5Zj426nck9INQ4g24xRfJD4vhl1ooqCUnWjZzcvDZGM+N4UjC5F/r41QAu28DDEEjZCuCmRMV5hkhmJ97j3U7QbNT0URfo93x6t+kFoRk86Yqo/0/+0jzVCN164bRnTTMkD9P3nGaDHzw1KfxZX1Ak8mbzP47GI8epBNOZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494107; c=relaxed/simple;
	bh=5Is0yddajOPaJJk52Hdu+rt0g50Q4Ula+4kChQDeTQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gB35oGpfbZqQ7v7cqr1s6Wd6Th8CUB34YdJAE9SCVgSM1doUeMcWCToYUnBkhNmH5pbYkowuF3a6gedL1WEXvBcRN3N3z5jGyFRImMSK6V/v9NEmOtvqnG41co+ibs2SXG+HVbcMXf3TeDFvRXoF0tdtq2Kl6714QnVJg7YD4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ILLOBiVs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549faPT069672;
	Tue, 4 Jun 2024 04:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494096;
	bh=IEsB6wi8UzpSLuomzX+sFoDGZGJkBWTnpg8kWtmrd7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=ILLOBiVsec93PH1xa9szfEhaJiFQ8IvB+PSqCRcn5q95ON6HcRCqGIIHMkl0ylM9c
	 3FYz43ho3KpQ0ns1Q5srasG6KdxYaLfqeP9JvgSn/bZrF0G4DeqeZgj7Mmc5XXuMAH
	 psLtC4rGFia5O/KKy/28+uEQnzCiFLAdZBKUdyKo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549faJS120225
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:36 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:36 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fZEV011865;
	Tue, 4 Jun 2024 04:41:36 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:08 +0530
Subject: [PATCH 7/7] arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-7-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=5Is0yddajOPaJJk52Hdu+rt0g50Q4Ula+4kChQDeTQE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuFDpzzutBfFbiypbikrf1LAIxmT1vAnADWAg
 shXGttbt92JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hQwAKCRBD3pH5JJpx
 RadpEACRXdFVegwXA+rZFHmlZ7gZZEKuwW/emV8Uj9vxZ40qxQxv2gaC7pmUVALFSqP9smRV3hx
 jNW/EvSg4DWnSADLt29fJsL7Me0vdXkYTjQgoJxNZ6oY6CPXZBlZYIC96q6KXi+l2aEEeJpdq0U
 05g3dOxnXJ+mUHycZRBxvkduGWud58PXEal6f/UeXApyhMB+LFYXtG2YxIMO5J/kRnrsSu3g/pX
 J3YCylUZPwpXsO+S2yVSTFVJyrHkcYnG9TpEp6u8GKqNldu4NPYK/v26een5gztOnylsHuWhOMo
 9yvbhbePFEP3usAa7xULmxn1KeyhmEcx6hvOXDMzooQL0pIEm4Yk1mabX7+lIsQuadj8/wqHlLo
 fk+yIq1adxOQ8Wogb4dn4zvlHT4uvT0c5ch5UaMhCOgftaHCzK40+c/OomI0D1e1mOe+qDBwRfj
 Xbl2wBk7K6TWmtBdxdrjCMmTKY65Bx8epxC2MB3XKmGvksjuLAAfkuGEpaN06e1n23EMP0S49Bf
 Rw8qxZDIwutM7lASpN8Z+8dI0Ri6bucHJy8GFXTgtoS58p8kzFkDCW27z8KVm8HLhoijjjPog0g
 7qhI5/d4es5EW6nWn+e4Xsvl2yQEagWrYjrFQpBkqmNMmhYP4OwH6RbZ+mfp4Cew2z5PkEDHcgP
 0ZCrfSIQEtM3H1Q==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On SK-AM62P, McASP1 uses two pins for communicating with the codec over
I2S protocol. One of these pins (AXR0) is used for audio playback (TX)
so the direction of the pin should be OUTPUT.

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 2aaf7d490c77..aa45a6fa6e0b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -207,7 +207,7 @@ main_mcasp1_pins_default: main-mcasp1-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
 			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
-			AM62PX_IOPAD(0x008c, PIN_INPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
 			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
 		>;
 	};

-- 
2.43.0


