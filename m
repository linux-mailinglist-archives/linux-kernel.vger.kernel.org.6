Return-Path: <linux-kernel+bounces-308388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9AD965C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE611C22C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512D16F0E3;
	Fri, 30 Aug 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a5Pm0YTM"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40016EBF7;
	Fri, 30 Aug 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008838; cv=none; b=G6wBhrZxkj7hZriG7CChDI1txrhXr4oUDCXoVHYPn1h1jMYhywEWdVYx9PZyr7JATYBuOkDUY4Z6mSimVHFg8Wq7csfe90PrOFOdKhZ4nIJixgzZne3Bi1FhONBcFzIfOWF5qVru5h5ITIs6ec2Eoe9R4Aq9dMNcYZONSIecYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008838; c=relaxed/simple;
	bh=+LP/DEpXztM39akidcQnrRTsjr1MGtOlXaXVL27ajAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOXP1v6ArUDrVUgxJ6KMf7o/ALpNxf4+Arpwbua16mxBGnQWitAqhMR5dQqHtKulTG9EF88KwnJXzTMxmktWaMlEywoZNHz9+JJfHnUiRJ0J3iWSOjRG0Gs5dZvkyM4vhUYxMdYCKcnsZdpX/fLdigaUeMVx6CjtwTZlDZLRak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a5Pm0YTM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47U977ZU033834;
	Fri, 30 Aug 2024 04:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725008827;
	bh=ZMBFgcLlr1GEeDaMxYzRxEYPhkoPe7DjymWsFmll1hY=;
	h=From:To:CC:Subject:Date;
	b=a5Pm0YTMVmJRi2odAES/iZtpkv/jhuIsYrZHOkSTZKJooWjOmPqfe5Uw5FKD3XLSU
	 extMKK+O2/0QC/vmQAuGUQl4g8fT6hjvBgp2jVb8Oevky5fV/HlxZaV0cwhMS9eMNZ
	 tr59ZrLLmY7ryrc+J8hv9a85FtXOOr/If7l4OhI8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U977V3080372;
	Fri, 30 Aug 2024 04:07:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 04:07:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 04:07:06 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U973uc023126;
	Fri, 30 Aug 2024 04:07:04 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <p-mantena@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: Update OSPI partitions offsets
Date: Fri, 30 Aug 2024 14:37:02 +0530
Message-ID: <20240830090702.220402-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

OSPI NOR flash was partitioned with a size of 1 MB for the initial
bootloader ("ospi.tiboot3"). On the AM69-SK board, boot failures were
sometimes observed when the initial bootloader size exceeded 512 KB. To
address this, the initial bootloader image has been optimized to be
smaller than 512 KB.

Therefore, limit the first OSPI partition size to 512 KB and adjust the
remaining size across the subsequent partitions.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a1403..641236918379 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -1241,27 +1241,27 @@ partitions {
 
 			partition@0 {
 				label = "ospi.tiboot3";
-				reg = <0x0 0x100000>;
+				reg = <0x0 0x80000>;
 			};
 
-			partition@100000 {
+			partition@80000 {
 				label = "ospi.tispl";
-				reg = <0x100000 0x200000>;
+				reg = <0x80000 0x200000>;
 			};
 
-			partition@300000 {
+			partition@280000 {
 				label = "ospi.u-boot";
-				reg = <0x300000 0x400000>;
+				reg = <0x280000 0x400000>;
 			};
 
-			partition@700000 {
+			partition@680000 {
 				label = "ospi.env";
-				reg = <0x700000 0x40000>;
+				reg = <0x680000 0x40000>;
 			};
 
-			partition@740000 {
+			partition@6c0000 {
 				label = "ospi.env.backup";
-				reg = <0x740000 0x40000>;
+				reg = <0x6c0000 0x40000>;
 			};
 
 			partition@800000 {
-- 
2.34.1


