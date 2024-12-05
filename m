Return-Path: <linux-kernel+bounces-433019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DF9E52F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABAF164BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D371D95B3;
	Thu,  5 Dec 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kcg7KMJb"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF231DAC81;
	Thu,  5 Dec 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395867; cv=none; b=A/CH9JwkkLR51U4K48MxYBByJo1LfXVi4b/pX8+yTai5mTGcu9YyHKsbZtqQ/pBlOKv7KLVmk0J6l87mjY+RtGA1GHY5wn52FORALbvlkm3oOEaEfSkYFYgZmyT2GPlsCe80K4XpXw7/EvoKkUHS/Q7Nk2+eps+0syl/P8xdqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395867; c=relaxed/simple;
	bh=T1pU/ZNurOOJOF6gXMC/hxxVq6AHIC4AFrnNYuQI4sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHL6B8Elyey+YJX9dz5B3muLNxV2ODwVRgc2ZCeaWVGHXIkDc+uHkR7jLkaV2bHibXNgoU/x9wm5dTl5yQlXvA6O1UW4jOKFEixIpSjrEpfmPexkgjMwFA7F1kpUFRtXtsZ2M1k1wmAXpp2SyIKDcNCTc/lanzz/dvCanOfADn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kcg7KMJb; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5AonFC1747659
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Dec 2024 04:50:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733395849;
	bh=VxBfAidCZEpZfBvPJ7kpXgJ70sPB6hVOSGyHqW1x/Zo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Kcg7KMJb6dL89WRcBzF7/wTLAV7RkjSYi91u7pbT22PV+Ca0s2rfI0p3DgjL7d1I2
	 LIYb6jXGII054DjUgydrwGX7hEQHIUK1g1mUVuEPEzJK88oaKsiDQRFKN3yEEaq3a3
	 vvvSHUdm6WUu5Wh8GGcT/mGeFTKacbBvctX9fqEA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5Aonnf022871;
	Thu, 5 Dec 2024 04:50:49 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 04:50:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 04:50:49 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5AofJr110686;
	Thu, 5 Dec 2024 04:50:46 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 1/4] arm64: dts: ti: Makefile: Fix typo "k3-j7200-evm-pcie1-ep.dtbo"
Date: Thu, 5 Dec 2024 16:20:33 +0530
Message-ID: <20241205105041.749576-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205105041.749576-1-s-vadapalli@ti.com>
References: <20241205105041.749576-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The list of "dtbs" should contain the resultant "dtb" formed by applying
the "dtbo" overlay on the base "dtb", rather than the "dtbo" itself.

Hence, change "k3-j7200-evm-pcie1-ep.dtbo" to "k3-j7200-evm-pcie1-ep.dtb"
in the list of "dtbs".

Fixes: f43ec89bbc83 ("arm64: dts: ti: k3-j7200-evm: Add overlay for PCIE1 Endpoint Mode")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch has been newly introduced in this series.

 arch/arm64/boot/dts/ti/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index f71360f14f23..379bfa4425d4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -230,7 +230,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
 	k3-am69-sk-csi2-dual-imx219.dtb \
-	k3-j7200-evm-pcie1-ep.dtbo \
+	k3-j7200-evm-pcie1-ep.dtb \
 	k3-j721e-common-proc-board-infotainment.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
-- 
2.43.0


