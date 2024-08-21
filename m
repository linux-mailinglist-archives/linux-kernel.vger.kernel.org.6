Return-Path: <linux-kernel+bounces-295290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E985959959
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08591F23016
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0E207EC3;
	Wed, 21 Aug 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mCVJR1pZ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B6207EB7;
	Wed, 21 Aug 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233941; cv=none; b=oHNN58O4bhIYQRvR38/ACM6lhASpgtlDdF10L5vdT65yWiTLCyKr4OduF1ogiLEgYxVfdWYA4OR4cDoEhO2o3Zv5DDeUnq4kiHNFe9Nn2rzy4xX3LZK6btQFi6pb03oLhmilXIPhOtBq2yvdoo4HZ2lsN8XtNr91lmWH0FE71iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233941; c=relaxed/simple;
	bh=AKR/1dqdfJqYn0INYYx/7sMj6Fc0uqhrkL2RuEJoTYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vf8cqjAcFSbswbxJ+2CPqk2YfavnpXdb7xJVc/3yEIVzY+CiWkjlBhcFxVBf8FA+xbTNnTthAWlBy3VYwi11Og7moSEouiV3IFFeCXOgavGAyk8iKG6l9PmeGa8ss/mkyOyfFpj3dRYIEJV6VYi6xyKlaTqJdbAgIWvVl0rbVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mCVJR1pZ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q8wh016892;
	Wed, 21 Aug 2024 04:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724233928;
	bh=wOzWWIoQH8LUPJgI4R5//0UAG69T6dlSWyT7bC9RVtM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mCVJR1pZ7eLVACb3Hfck4Y9c29u42UUt0AH5pZceyGpsKUj080CMUzepJQnaZsyEL
	 4DTyH48YEYjqrg9BQdzmwm+Zy//UdKapQ95YwUNc4MO2CzIKBOzXycJPlHNGM1xce8
	 ZegrA5517piwsoiZrNkhvwA9hNhwj2znKs8/3eZ8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L9q88D023485
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 04:52:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 04:52:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 04:52:08 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q1n2066254;
	Wed, 21 Aug 2024 04:52:05 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
Date: Wed, 21 Aug 2024 15:21:57 +0530
Message-ID: <20240821095200.3050878-2-b-padhi@ti.com>
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

From: Suman Anna <s-anna@ti.com>

J7200 SoCs have one R5F cluster in the MAIN domain, and it is configured
for LockStep mode at the moment. Switch the MAIN R5F cluster to Split
mode by default to maximize the number of R5F cores.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
[ Commit message cleanup ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..a369fa35612d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1486,7 +1486,7 @@ main_timer19: timer@2530000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
-- 
2.34.1


