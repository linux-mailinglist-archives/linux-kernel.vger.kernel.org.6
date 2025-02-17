Return-Path: <linux-kernel+bounces-517411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B4A38063
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D513B7A452E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A030101FF;
	Mon, 17 Feb 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="th7plpvS"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031715C0;
	Mon, 17 Feb 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788727; cv=none; b=ut6f1dRu/8Mla3+SfOV1v13UZkGTQ44lh3l0kCObbMcNF8wrKDrc7jOAkZVYwk+mSl1mMkIKbdP1q3Iu/J+BpbY+6HlDcHGhbRhX7MiWh5TUQThbqZggWsoh/TUgXQHQG7faHVWIIWeifZwWzWFyDPxfNr8YHlk2+a45YSTxdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788727; c=relaxed/simple;
	bh=wbUe4GKVlpXeQll898aCi86dsk8T74monqyicKRWj1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XEagCjd54Gj7XyRFijIxjjpJ5+kmOJwnMRlVCERkh//H9G0J6I1pEIQfbv1XU5z1UQcx1p0r47esepVCitBSyvQh2XnvuZ1ddh0dOVEyoyvZ17vcIp5KumhPMiEgOve70lJaNSdgDMgubEurAEwHr6NopG1FOFuDKkB5M8TZ6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=th7plpvS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAcWYH1338030
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 04:38:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739788712;
	bh=RnkB0lMKqmJYB0j8S/qL/mNwpGucnwjbOHxfTNKAOoc=;
	h=From:To:CC:Subject:Date;
	b=th7plpvSE7vmNp+XTc40HVTUwIjW7i57yob23ziU650u/Hw+0R1+TPeFzdQ+Hor9N
	 3V5h+0vnwjUXsjUtzleYUePUY2DbJnV5NWciEzN+/xysY2otd3OLcCaofyD+Ey2tDn
	 dSUFdWwNVA6JPyLbxXiJaPuvxV+54oMq4aNZe5Mc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAcWln042498
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 04:38:32 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 04:38:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 04:38:31 -0600
Received: from ubuntu.myguest.virtualbox.org ([10.249.128.48])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HAcRh7023531;
	Mon, 17 Feb 2025 04:38:28 -0600
From: Keerthy <j-keerthy@ti.com>
To: <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>, <krzk+dt@kernel.org>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size
Date: Mon, 17 Feb 2025 16:08:14 +0530
Message-ID: <20250217103814.2657-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Currently we get the warning:

"GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
overlapping address"

As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 83bbf94b58d1..3b72fca158ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -193,7 +193,7 @@
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
 		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
 		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
 		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
-- 
2.17.1


