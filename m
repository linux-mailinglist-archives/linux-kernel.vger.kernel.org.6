Return-Path: <linux-kernel+bounces-213499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30319907618
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A491C21A90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE13149DF7;
	Thu, 13 Jun 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LS85mebG"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD91494D5;
	Thu, 13 Jun 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291357; cv=none; b=DlK6yLX9WvsFIzYKebAQ8o/r1eIMrO1eOwc97EuKN90PyXQPZLgwjs8OsTtuyrYezoKbV4I5L9/CENEPFV4EDnEJY10TShuNnh00RFuN9wTCh0Wb0UcYzc6d7zPEuRgI21+zdDNzaD+oQG+giFeGnQrsrrc6OtSQM29I7aQUqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291357; c=relaxed/simple;
	bh=AItEJV3f/irbeMaAtG/BznIdWe8pOiuM2AA7s21Sr6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iil+Lc/LtMe8Y+xsslQNuL8rh7UDB2kIULax7kaSKPo3OxKZvlGf0ftFjdTGsppB+8vGvwDEMNPY+SSgT7gzvdCQqh7pqFUqILRh8iZwAN0Jy0K5L9GROAjeANUXVfT9xBwa+1TIQkLjQpUJ/jtgCBHI5bx7UqDqkLsi1QTqITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LS85mebG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DF98Es079901;
	Thu, 13 Jun 2024 10:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718291348;
	bh=sE4cl2s/d+Mn4dSnjIpEm+GQgW8R9GDKh3dxva06fOo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LS85mebGUxLPVee16wBkHLpVJr8MsEbDeuC83aMuf7NuLxLN9nem0JXQv2meFNMTK
	 Y5Dm9xWDL4OefUqj2tT77y0B6eOa0KZZVbeRF59yDsdZ50Pm5VqPOVyUfK2xjfeCGZ
	 hUgDl7LU8sMnw0r6W2w+X2W9jeTq9G4FE0F7Pw0s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DF98WH012968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 10:09:08 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 10:09:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 10:09:08 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DF97HO007811;
	Thu, 13 Jun 2024 10:09:08 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
Date: Thu, 13 Jun 2024 20:39:02 +0530
Message-ID: <20240613150902.2173582-4-devarsht@ti.com>
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

From: Brandon Brnich <b-brnich@ti.com>

AM62p has different multimedia components such as Camera, Display, H264
Video Codec which uses CMA for buffer allocations. We require 576MiB for 12
channel decode-to-encode 720x480@30FPS use case.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index fb980d46e304..5ef74d9f8eea 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -48,6 +48,13 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x24000000>;
+			linux,cma-default;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			no-map;
-- 
2.39.1


