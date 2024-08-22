Return-Path: <linux-kernel+bounces-296998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9A95B1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8DB22126
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0146F183CAB;
	Thu, 22 Aug 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oLLeNgIQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CD183CA4;
	Thu, 22 Aug 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319011; cv=none; b=EPkqF2iMxAi3dIgE2a+iLRiMwbbc+Mxa/KOC3fA9BcAiL1zfmDpOzC825cF6s90SnIMZOG6eDSnoeMPzGZBi/Y5en/lT1SJcVqNhcvpnQ4fbveLOrrnxsqFP9gXfaR9p+tKt6WLxjtcCMj1p7KKEtVvnrkb8scOd81Wz+ZFPCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319011; c=relaxed/simple;
	bh=XsaC0Yllq7EKGOv5j0sgGtTzP9qHGKNCDqRHKFM2InQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTUprc92+AItaC0s/uVfG0sKd8Dket/OCnq31PyCf8JxDd9CQV4alThQWH3++bb/CApWC3+VvvK6wsnzRmsRBfYyoiA88HCKCIh4KM6NzR6D6MM6fMh6xG8HqGdytgUvoJr/mrZ4BuC4zaARGtgWeEBqwbMixhHcCql52IGJs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oLLeNgIQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M9TuOT048965;
	Thu, 22 Aug 2024 04:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724318996;
	bh=LXlBucHtW/siugsLpq9W5jRjw6XnoC69c+WZ3x/ngdo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oLLeNgIQus7doF8G37fcvd+mho14/uxfiSw8wBtsYGWjiBo8OMKwL1H5Sc9vM51W4
	 6RDH9a3asXCrAAn9O8Ii9718VMF5un/YSXP3DvreXwpl5q3eEnhYSr57Dd0txMK9M5
	 AtFYJeBd8puN5LMTf1U/fcWZX61Ppcib6mVvZ7go=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M9Tu5A009387
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 04:29:56 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 04:29:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 04:29:55 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M9TtPX044825;
	Thu, 22 Aug 2024 04:29:55 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <bb@ti.com>, <afd@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/4] arm64: dts: k3-am62a-main: Add C7xv device node
Date: Thu, 22 Aug 2024 04:29:52 -0500
Message-ID: <20240822092955.22037-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240822092955.22037-1-hnagalla@ti.com>
References: <20240822092955.22037-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jai Luthra <j-luthra@ti.com>

AM62A SoCs have a C7xv DSP subsystem with Analytics engine capability.
This subsystem is intended for deep learning purposes. Define the
device node for C7xv DSP.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 916fcf3cc57d..8546ed35529b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -1088,4 +1088,16 @@ vpu: video-codec@30210000 {
 		clocks = <&k3_clks 204 2>;
 		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
 	};
+
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00100000>;
+		reg-names = "l2sram";
+		resets = <&k3_reset 208 1>;
+		firmware-name = "am62a-c71_0-fw";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x04 0xff>;
+		status = "disabled";
+	};
 };
-- 
2.34.1


