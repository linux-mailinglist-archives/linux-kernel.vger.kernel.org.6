Return-Path: <linux-kernel+bounces-308586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD6965F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA261F28E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158481917F1;
	Fri, 30 Aug 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HUsFWtlW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36317D375;
	Fri, 30 Aug 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013711; cv=none; b=Yk1zy8cOMdtbfACns1DoKV4WafkhOHU/w9eATmlLhyWInE3OqxPEqOU6tYnvRAUzLbbgigTbrX2AB7I0fndGXYcFM9VcSHi8C/xcLTDx3rWusG7K6h1NGqYbWR1OqoY46QOu6F+IjOBnlnfElmPKNNpxc54qpBNy7KF5TN4hk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013711; c=relaxed/simple;
	bh=NdghgHFvzG1MpM+aBjKDpQN039vumSxfcn1T406Z3ZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkqGq6Z1miXqF3JgDJmqTuiiL9O+Nrer+YPs+YX5BRnSmMm6ibdrVOcoiI/maCiLMVHkanOHpSeI2SuQEfRYBOiIPUSTH2j9XQb9yb8XOnNi+r0PJt8YRbUdFe3tHbkm/F6I5zXjkIwq2+d1JOlbq1uABJyJyHN0d0V336fLR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HUsFWtlW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UASOge059515;
	Fri, 30 Aug 2024 05:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725013704;
	bh=4v0txenOCN9l16vss+K3ILdyxnDp9LZiJ22Nj2+eVKk=;
	h=From:To:CC:Subject:Date;
	b=HUsFWtlWEt364cr1auK9RSqtpMrY20HC4yx7y+KpVoydxHu6Xzt5MIs5WHHSATjPr
	 bJQR/psPmerA7cfytTndZNDbJSSacOT/IVy+mrj8xqkQjH+tKjQh8sleBM+uhOCdMA
	 BqEUCj5BiOzI/h0nUw7cgcWn5o+d577LmtUnkvDY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UASOjC012538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:28:24 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:28:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:28:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UASNC0111661;
	Fri, 30 Aug 2024 05:28:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721s2-evm-gesi-exp-board: Rename gpio-hog node name
Date: Fri, 30 Aug 2024 05:28:22 -0500
Message-ID: <20240830102822.3970269-1-nm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the gpio hog node name to p15-hog to match up with gpio-hog
convention. This fixes dtbs_check warning:
p15: $nodename:0: 'p15' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

This seemed to trivial to add fixes tag, so skipped.

 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
index 1be28283c7d9..8583178fa1f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
@@ -48,7 +48,7 @@ J721S2_IOPAD(0x09c, PIN_OUTPUT, 6) /* (T24) MCASP0_AXR11.RGMII1_TX_CTL */
 };
 
 &exp1 {
-	p15 {
+	p15-hog {
 		/* P15 - EXP_MUX2 */
 		gpio-hog;
 		gpios = <13 GPIO_ACTIVE_HIGH>;

base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
-- 
2.46.0


