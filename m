Return-Path: <linux-kernel+bounces-295291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18295995C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116F5282B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD3207ED8;
	Wed, 21 Aug 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="icT5KKbj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F5207EB8;
	Wed, 21 Aug 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233942; cv=none; b=X4MusNdLe7PktqMID/R2rxDb27WB8pC98KXLWYp/I9eSoZEZvsvlbWcFa/WOT1dXkpw35ap56+OWoLQrKD5p0PXWu3nBckoEPX68Sg/xl8oqpWcnwaULb3RiHewFUdgwxzIV5ZnfeDPYxpBB1Y7EBTruD0dIFS/sGXXVF6GlTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233942; c=relaxed/simple;
	bh=Np4NuP18Od32MCH1YGY3XkBhkdPg8QIunizgl13XxeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocHIiw7Tf5UmfaghWRjfznLBQlCfqVxZl9G97c2NE+5zIXymW/n+tRP83h9DwOabSgf4d95z2oXXaJHI+uvBgeIR2Xz6/mgJNw/+kEWRmWTXUP7kRwtTDlbjamDXf+IJb2yoiKxRW+a/9vQF9aXhE0usuSKb36ewlMFyQ+wbOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=icT5KKbj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L9qFml016913;
	Wed, 21 Aug 2024 04:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724233935;
	bh=5hLAVqIFYabAL4Z7c5tf+r9EZkCV+JSFC/3XR2qH4Ng=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=icT5KKbjZNpeHPXaasyteQ0GymwqfSTuvKh+qFwQPRiIuT64i4WhURPbBhcZUTQhC
	 10I72OW69w6RcecW1SCJKLV1i1nGzkAUrAEa+rIWXZHlM7guErIPdq3gPPi+VU/5KX
	 SSSaRbffHI42hPRl4PRqLBUTTf6zTpa7F/Ctb7ns=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L9qFDI023524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 04:52:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 04:52:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 04:52:15 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q1n4066254;
	Wed, 21 Aug 2024 04:52:12 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-j721s2-main: Switch MAIN R5F clusters to Split-mode
Date: Wed, 21 Aug 2024 15:21:59 +0530
Message-ID: <20240821095200.3050878-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821095200.3050878-1-b-padhi@ti.com>
References: <20240821095200.3050878-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J721S2 SoCs have two R5F clusters in the MAIN domain, and both of these
are configured for LockStep mode at the moment. Switch both of these R5F
clusters to Split mode by default to maximize the number of R5F cores.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9..9bb0dc1c5791 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1837,7 +1837,7 @@ dss_ports: ports {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
@@ -1877,7 +1877,7 @@ main_r5fss0_core1: r5f@5d00000 {
 
 	main_r5fss1: r5fss@5e00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
-- 
2.34.1


