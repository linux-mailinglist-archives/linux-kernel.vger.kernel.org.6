Return-Path: <linux-kernel+bounces-213497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26578907613
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F9F28307A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4CD1494B2;
	Thu, 13 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T0BVL1PL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D21474A8;
	Thu, 13 Jun 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291354; cv=none; b=WW/Ycrx/X8KRg/NLQFOTy+BJ4DpEVwDnL23EG4FtU2OWxCabTK75+PXKMiPdSQN+zgkT13z9FdPDr5OShZ2s+9K+sSc68mue9lkWQ80nLZP9SbO2XoFl2zyXVXK2LlGAfNlzPjnvt9B1q6VLEMnPmNCdHwe2NJeabZ3bBcUxg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291354; c=relaxed/simple;
	bh=5yUqq95OEzg8Vg07j3JEbfDJgM9RTXqe4IOXvDeb6BE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBopqKJg9lP9S8gzSpYcF7LDFlh92cSm723n18y1daIikNTRyAQakX/nVcbaiftAIXYMKbCPzmW8Zcfv4RjTyZ91IcW9IN/vwXMoEiVujn8lnIpDxZh7dcb7o5CvGWaKJSno4ESYknu+M3BQVzpDk1cx3YyfMV9WpyKYGPEYMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T0BVL1PL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DF95dq130716;
	Thu, 13 Jun 2024 10:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718291345;
	bh=+JRL1+N5yaYXTkwzYeHn0V3MvWD0ajIJEVtzSMxbctA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=T0BVL1PLhIXhdS9vMsWMg5hZJlZZwW+BBCaDWaUi8CE7X5kjO07RY434+Alb534Ry
	 T5G7vfLHkmwGZZf96FB+ua8eLnURmiE5cdV8ki/Mh07ueWXqRl63J+EqQ4oT2X6tHQ
	 X+v6VQu2NtyPMOPhWvnVq5lqUKo7aSWw4X6z/m+M=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DF95hs029220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 10:09:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 10:09:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 10:09:05 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DF94Eh020670;
	Thu, 13 Jun 2024 10:09:05 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
Date: Thu, 13 Jun 2024 20:39:00 +0530
Message-ID: <20240613150902.2173582-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240613150902.2173582-1-devarsht@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Reserve 128MiB of global CMA which is also marked as re-usable
so that OS can also use the same if peripheral drivers are not using the
same.

AM62x supports multimedia components such as GPU, dual Display and Camera.
Assuming the worst-case scenario where all 3 are run in parallel below
is the calculation :

1) OV5640 camera sensor supports 1920x1080 resolution
-> 1920 width x 1080 height x 2 bytesperpixel x 8 buffers
   (default in yavta) : 32MiB

2) 1920x1200 Microtips LVDS panel supported
-> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
   16 MiB

3) 1920x1080 HDMI display supported
-> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
   15.82 MiB which is ~16 MiB

4) IMG GPU shares with display allocated buffers while rendering
   but in case some dedicated operation viz color conversion,
   keeping same window of ~16 MiB for GPU too.

Total is 80 MiB and adding 32 MiB for other peripherals and extra
16 MiB to keep as buffer for fragmentation thus rounding total to 128
MiB.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index f4948b937627..52231bfe60fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -48,6 +48,14 @@ ramoops@9ca00000 {
 			pmsg-size = <0x8000>;
 		};
 
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x8000000>;
+			linux,cma-default;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
-- 
2.39.1


