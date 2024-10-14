Return-Path: <linux-kernel+bounces-363401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1699C1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DDC1C24609
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA91547E4;
	Mon, 14 Oct 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3ygCD24"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94415252D;
	Mon, 14 Oct 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891954; cv=none; b=RyAPoQbnFPvGvcjkIHUsw3K1uhCNH61xq5yGFzRF/plEDK27DF3TRBFfvo6iBEyaWLBwPC9fgjmXH4iCTVreYg1H/u5+CfrNAWsTVc3z4r0792DLzai0fZcGY9lr0uT/5m58FPsRAqsK3KDvPUDMfAzmy41uJofegiXKex5WmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891954; c=relaxed/simple;
	bh=NTi5AOG7Ycfat7NIsi6EzOR8kOqucsBWWSBqFEcFHeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRIj/hSSoBLucbIy2e5VEVV875EhSNPWOJyI9MzSn/ZqPcivMAPncCGz3i8HZnmO9jBsBIIMU3ArFsn6kEEorXXVRsFxVYVxEBfmxR0GXgXlTHGr4WyKt+doe7+itVZ+MiN67Gq5RNBMw39l49f0Ta7SSXYIMTO+5rmrHUIJ8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s3ygCD24; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jeww081105;
	Mon, 14 Oct 2024 02:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728891940;
	bh=pblTvLzcBrU0P0UpeGmpVZAX2MKmE81/Kyw59oboS0k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=s3ygCD24VVsB9de943BwIyjmNZ5+sJgqZ2C3M56pjQGDEZdIXuw1iaTgwdjOgUiTl
	 6aUHi31y84RKLnGteQlX1A+W01oJj7DcvwXxH0QIzEJC91BrRhj3h8bED5BD8QdifA
	 kdPafZ6n4A7TcowiAy6UVd5622eKOg/tyxkRxHY4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E7jerx017542
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 02:45:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 02:45:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 02:45:40 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jenV011855;
	Mon, 14 Oct 2024 02:45:40 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49E7jdNJ025347;
	Mon, 14 Oct 2024 02:45:40 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am64: Add ti,pa-stats property
Date: Mon, 14 Oct 2024 13:15:27 +0530
Message-ID: <20241014074527.1121613-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014074527.1121613-1-danishanwar@ti.com>
References: <20241014074527.1121613-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add ti,pa-stats phandles to k3-am64x-evm.dts. This is a phandle to
PA_STATS syscon regmap and will be used to dump IET related statistics
for ICSSG Driver

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 97ca16f00cd2..3e9361ba2cb9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -253,6 +253,7 @@ icssg1_eth: icssg1-eth {
 		ti,mii-g-rt = <&icssg1_mii_g_rt>;
 		ti,mii-rt = <&icssg1_mii_rt>;
 		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
+		ti,pa-stats = <&icssg1_pa_stats>;
 		interrupt-parent = <&icssg1_intc>;
 		interrupts = <24 0 2>, <25 1 3>;
 		interrupt-names = "tx_ts0", "tx_ts1";
-- 
2.34.1


