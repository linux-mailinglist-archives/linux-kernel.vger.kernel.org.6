Return-Path: <linux-kernel+bounces-308682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D736966048
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DD81F22E00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7B19149F;
	Fri, 30 Aug 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pDrSHi7k"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BB17B513;
	Fri, 30 Aug 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016215; cv=none; b=a/9JgKMYyYBlrcayx8Bj0erK75bUE1dTTm2wFI93bMoQXZ14smWHeIXw5U+/MWLPtnplXU9XnCENh2T4Tp4yMzU49TWOs+oY6a6CD7pGMgiDR6SF92991PjXbS8uE74BfCOLvFSo2zI6cOgh4EnEzXTcImdI/4idvoczRrIhI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016215; c=relaxed/simple;
	bh=OHjj/tAnC+Y1kEF7BAvFkb85Nzu3wodRArUS0GgIzBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ts1H0XuCb+7JOSI6tzvApiDIW8DMT7X8+GZlndbydHfChz070mdmWFNSto50nmO/6RrC6nEYUa/SPwS1VDGgpWYf+MAkCgcSeJj7i4dHDr7HfSgtoRbxNL4oY6VZLiGOJeSxq5YmG1jI8b/jlKlQq7V7QV3x7PFcJSnL7M0NSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pDrSHi7k; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UBA65w107414;
	Fri, 30 Aug 2024 06:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725016206;
	bh=72miJdY/rcxK+EO0xK2JkDsYQAQxFOzf72LiKDXqYOc=;
	h=From:To:CC:Subject:Date;
	b=pDrSHi7kJgfq8IjazJAKCuZwH04gGqwU2eeZq42q1E+FRumbne3k8qyp9eRpM+zON
	 E+bK/AfsS0A2SrZkdDvD/71ZvPXPIg17tVjO83plit6H0SmD0xkku5ztNU4jt1+bpD
	 GyZJIomK8xuaKL9vKYHPDvfXhRPd82v0oRWkOmfw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBA6xZ019080;
	Fri, 30 Aug 2024 06:10:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 06:10:06 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 06:10:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBA6gB105986;
	Fri, 30 Aug 2024 06:10:06 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47UBA5VI025882;
	Fri, 30 Aug 2024 06:10:06 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        MD
 Danish Anwar <danishanwar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas
Date: Fri, 30 Aug 2024 16:40:00 +0530
Message-ID: <20240830111000.232028-1-danishanwar@ti.com>
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

ICSSG doesn't use mgmnt rsp dmas. But these are added in the dmas for
icssg1-eth and icssg0-eth node.

These mgmnt rsp dmas result in below dtbs_check warnings.

/workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg1-eth: dmas: [[39, 49664], [39, 49665], [39, 49666], [39, 49667], [39, 49668], [39, 49669], [39, 49670], [39, 49671], [39, 16896], [39, 16897], [39, 16898], [39, 16899]] is too long
	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
/workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg0-eth: dmas: [[39, 49408], [39, 49409], [39, 49410], [39, 49411], [39, 49412], [39, 49413], [39, 49414], [39, 49415], [39, 16640], [39, 16641], [39, 16642], [39, 16643]] is too long
	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#

Fix these warnings by removing mgmnt rsp dmas from icssg1-eth and
icssg0-eth nodes.

Fixes: a4d5bc3214eb ("arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 97f7eb34b99a..b0ce2cb2fdc8 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -59,9 +59,7 @@ icssg0_eth: icssg0-eth {
 		       <&main_udmap 0xc107>, /* egress slice 1 */
 
 		       <&main_udmap 0x4100>, /* ingress slice 0 */
-		       <&main_udmap 0x4101>, /* ingress slice 1 */
-		       <&main_udmap 0x4102>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4103>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4101>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";
@@ -127,9 +125,7 @@ icssg1_eth: icssg1-eth {
 		       <&main_udmap 0xc207>, /* egress slice 1 */
 
 		       <&main_udmap 0x4200>, /* ingress slice 0 */
-		       <&main_udmap 0x4201>, /* ingress slice 1 */
-		       <&main_udmap 0x4202>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4203>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4201>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";

base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
-- 
2.34.1


