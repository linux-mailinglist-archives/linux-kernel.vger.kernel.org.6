Return-Path: <linux-kernel+bounces-219351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD67390CD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836B11F22C37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB379149DEE;
	Tue, 18 Jun 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TZ/Dpies"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B31586CB;
	Tue, 18 Jun 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714500; cv=none; b=WxQS2OMOspZET3JBIMt4NBQdvaEYMHaSdDQUIMmV98K9dNn+j9o+MmNg+mE91AEhF00kVkSvM8yIpjUN8w4huWn67bhU17aA8V+BNseIvRx4D1/iwOZSDtooZThdkKelUzLSObzp6kXRPoHG20HEUOWYCi+9WDsVYaWVHO9gKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714500; c=relaxed/simple;
	bh=cFiJw4HI0EqviMG50wxBbVTKnh+MB/rEBCj4norM1lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sZrVcrBXBW8abSbwJkU2XGXuI3MaBqUhtD52tPcsza6V1p74v6uU4MensL1uR80I+X3i58pFWlGZGYuidtx6g/mtSXJ6lNQV0ViSg8NUahrhrRQT6Yuq3aEOTjcFjAUyaggz4oJlxyR6TdfLN1ZxbtMj+of9WZB71XCg8kj6RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TZ/Dpies; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ICfPL6091833;
	Tue, 18 Jun 2024 07:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718714485;
	bh=dLDjoDfQuPoFFBdhtf2P+bCl26B8J4TnpGDN58KjHMc=;
	h=From:Date:Subject:To:CC;
	b=TZ/DpiescYp6w0AJXNX962/j+DW5xpX7X/meXBHxOk+lejXCLKRQKRdVzoHrCRGYs
	 KARfQ89jpFTtSsXL+gYqWhzZ9MB4ZTs8SHInlselLkZo5w1dwUoPnJxUiTMMy9LN/n
	 EvY/VuISj7vRhk1Atyc+ov5M1IuwopuAtXIUlBSE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ICfP8w122490
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 07:41:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 07:41:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 07:41:25 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ICfORZ024773;
	Tue, 18 Jun 2024 07:41:25 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Tue, 18 Jun 2024 18:11:13 +0530
Subject: [PATCH v2] arm64: dts: ti: k3-am62a-main: Enable crypto
 accelerator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-crytpo-am62a-v2-1-dc7a14f2635b@ti.com>
X-B4-Tracking: v=1; b=H4sIAGiAcWYC/3WNQQ6CMBBFr0Jm7RhaSRtdeQ/DYtqO0gWUTBsiI
 dzdwt7l+z8vb4PMEjnDo9lAeIk5pqmCvjTgB5o+jDFUBt3qrjXKope1zAlpNJrQOeOsMt3Newt
 VcZQZndDkh0MaKReW45iF3/F7dl595SHmkmQ9s4s61j+FRaHCEGrlThyscs8Srz6N0O/7/gN8N
 ocBvgAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718714484; l=1244;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=cFiJw4HI0EqviMG50wxBbVTKnh+MB/rEBCj4norM1lA=;
 b=FPqxIN1a/zrvHkDny25Js7SwPqlxR1Votkn+cRZvP20kKM1UEDJCBD+xowlp+zVadHI/CUP4Q
 75IjW9SJ5RrDz8Z1jwZZC2mni2w6P7d+cLg8pOFn89XSmH0CyTS9ShX
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the node for sa3ul crypto accelerator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v2:
- Removed unwanted properties as per Krzysztof's comments.
- Link to v1: https://lore.kernel.org/r/20240617-crytpo-am62a-v1-1-ddb719aed71b@ti.com
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index ce4a2f105630..08b3aea1d30f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -216,6 +216,14 @@ k3_reset: reset-controller {
 		};
 	};
 
+	crypto: crypto@40900000 {
+		compatible = "ti,am62-sa3ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
+		       <&main_pktdma 0x7507 0>;
+		dma-names = "tx", "rx1", "rx2";
+	};
+
 	secure_proxy_sa3: mailbox@43600000 {
 		compatible = "ti,am654-secure-proxy";
 		#mbox-cells = <1>;

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-crytpo-am62a-bb6b71643cc7

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>


