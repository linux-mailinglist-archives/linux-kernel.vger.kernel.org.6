Return-Path: <linux-kernel+bounces-429857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A69E27C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B978167775
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222071F8AE6;
	Tue,  3 Dec 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zVAqtSjP"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C51E3DD8;
	Tue,  3 Dec 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244046; cv=none; b=hfxKvenV4b/8Aqa+97hoh1oulidF6zKndnBX7E/D9bdYOFfcJ3w0wtt7m1OYSLmCKpRYsxK4pQA8EbuaM5R4xItjowvTIZIepYb0gUhn5Zicb6qBKjmZbwDiu8mxJus8W+fGWdo1tb4DNqyWLAsXShVpE1GTCL8cMptBL4cUhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244046; c=relaxed/simple;
	bh=oda6rss1hbVSU+HqWVOcypQWjsz9ajKF5JvreXNrCZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lGNUV7y0f4F4l9cS5BrS8ZeyBRMs+X9FBmD33qvNyDTRYKkUG4ZsfQhL3TfKioeMs4+TtTU3uXV5qmWCG8I2bm5MiyefM0kBmEeR+Y1MfiF2j6qgSkOeWGjJkLH/BoHACRBjePtNOpc9BZ3TRHFt2fu9PM8rS4gWjeyR+i0yZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zVAqtSjP; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3GeX8L1911581
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 10:40:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733244033;
	bh=NA5nU2Vd4Cr3takSlNTHL5m15aLLN71NSVIMs5qo4U0=;
	h=From:To:CC:Subject:Date;
	b=zVAqtSjPqmM7yBmQehi/Wpfg3wQHyk9CWsfhVAqRskCcs8OK5d4il3+7cUwMXHXXU
	 R4qOW7IzFihd79iIDfcFIqgLbM34F+jXE/iXPGRMqX/X0/JX6ZKPGE4Xsi/YhFFRxc
	 dKiE8kmLhy6lHHGMfmebGyPpK3qfVVMTi3k3ZMY0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3GeXHr051919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 10:40:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 10:40:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 10:40:32 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3GeWal035675;
	Tue, 3 Dec 2024 10:40:32 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am625-sk: Remove M4 mailbox node redefinition
Date: Tue, 3 Dec 2024 10:40:31 -0600
Message-ID: <20241203164031.20211-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This node is already defined in the included k3-am62x-sk-common.dtsi.
Remove this redefinition.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index ae81ebb39d02d..2fbfa37193457 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -219,13 +219,6 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
-&mailbox0_cluster0 {
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
 &fss {
 	bootph-all;
 };
-- 
2.39.2


