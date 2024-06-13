Return-Path: <linux-kernel+bounces-213498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3C907617
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456AE285700
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E480149C7F;
	Thu, 13 Jun 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VRm0sqNo"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130011494C3;
	Thu, 13 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291356; cv=none; b=uZdPQFjMYTuXsAwC+RlzY7RqUMHnJKg6/V0i8uQ5JQWza8F3cfknVmiGffdKfiL3DvZmkQtdguofBlb9BRQ5o+zN9+a7hnpz1i9cfIAH4GFh4blgrSH3KYTDdIT26Yt3FHTnRfvltwbjjX6kW4yvB4f7N0wtqb0iP4O4It30Vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291356; c=relaxed/simple;
	bh=3mLOJ2my3NU/eiFRV7dchfiOohRvCmAOtTA2fOVBznM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kme2Qki8+TzwLxR29bPEMD4W3E8d/QRWt/yeZmOT1w4UHUzYwh2+gaAHVUTIobpYRtQeBg2L63ezTmAejYNMLViSju/3A3sZ48gRZHCmlV62BEEsiw4EE/2nY2BQYl45uXmD0vjoQdIp1IGH9y2oKgYV9xQuzN0/MluRr10pTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VRm0sqNo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DF97tc109712;
	Thu, 13 Jun 2024 10:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718291347;
	bh=z3xwUJd1/KvLc1DEmjhfHhBuoHwF+UuatILAA85VS3E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VRm0sqNobJDAspZjsO8gg/HB3346ZnoGS5LPi9ThRPojJq1ZTqbpJQaE1pkKnjILv
	 aSCBqTQJ74ETvUqYNsO5YvOc89xAAWw9k3VeywqNG5LRSVK0SzSPffgxnQBxvfaKmV
	 IAWmwIoYAyiisuHpm+o60pPrPVjfGk+qWYueAXJY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DF979t044626
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 10:09:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 10:09:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 10:09:07 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DF96ES020847;
	Thu, 13 Jun 2024 10:09:06 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
Date: Thu, 13 Jun 2024 20:39:01 +0530
Message-ID: <20240613150902.2173582-3-devarsht@ti.com>
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

Reserve 576MiB of CMA as global CMA pool starting after initial 1GiB of
DDR.

AM62ax has different multimedia components such as Camera, Display, H.264
VPU and JPEG Encoder which use CMA for buffer allocations.

The 12x 720x480 realtime VPU decode use-case requires 544MiB of CMA,
additional 32MiB is kept as buffer in case some other peripheral also
require it while VPU is running.

The reason to choose latter 1GiB is to not overlap with existing memory map
which is utilizing initial 1GiB for remoteproc firmwares as shared here
[1].

Also some drivers such as JPEG require 32bit addressing so not allocating
from higher DDR address.

Link: https://lore.kernel.org/all/20240605124859.3034-5-hnagalla@ti.com [1]
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index e026f65738b3..67faf46d7a35 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -40,6 +40,15 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x24000000>;
+			alloc-ranges = <0x00 0xc0000000 0x00 0x24000000>;
+			linux,cma-default;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
-- 
2.39.1


