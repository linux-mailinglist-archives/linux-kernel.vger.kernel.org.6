Return-Path: <linux-kernel+bounces-217188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E790ACA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E1B23E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD381946DB;
	Mon, 17 Jun 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dmJNxc9E"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022753AD;
	Mon, 17 Jun 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622766; cv=none; b=geD///BmbbA3KsIIswCmBqhdi1/R8TaeZNkwZqHub3vlfxaFgPNTCUF3SqcS2O/tMZixH6hB6DzhKBrhht2XJ991sbGbI4l0Xkac5+kGLAKMVu7HR4hls3Ty9U2to+k+HAbUpQPVsg2j36BRNyQ8OInfx87uZgXw1Y+WiAlycoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622766; c=relaxed/simple;
	bh=/q1tmGRlV2b94HWtvWzP/RQIoEDOOCF6WdK86KGM5kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dxfBmkfNvHjWjktCFnzi+z+VGZbLTycnxvxAHVwVWVZ495VflKBc13H+yMdCQIeWRLztldbEz6JXhB7wlF9dcvJ4HQByOtfaxGWRfcrVx0ShpEstopiTjx1NCQwQJMH+d2oQa5JGfvoXewg+gfiFOXJlqp89grxZh+4QT1qvoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dmJNxc9E; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HAMafd108445;
	Mon, 17 Jun 2024 05:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718619756;
	bh=BELgjrJN+w9ID7lAyyjagN60DA04mZRsSAuLmcMGPok=;
	h=From:Date:Subject:To:CC;
	b=dmJNxc9E2I8a1ykhfp2pyDeZURjntkNiGgDfFidBzN/K6lwB3+BLk+xSDqoCaRdFH
	 6fBBg0zlHJtUdh1Khno1Idi0nhFYrwSUtaeBDyyG5Qd38Y8eaiW6O3n+1TLA+bkODT
	 wnNOodVzhTEnJfWMCni1J7rxIDD161twfYxfwbrI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HAMaMC014661
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 05:22:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 05:22:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 05:22:35 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HAMZG7062219;
	Mon, 17 Jun 2024 05:22:35 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Mon, 17 Jun 2024 15:52:10 +0530
Subject: [PATCH] arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-crytpo-am62a-v1-1-ddb719aed71b@ti.com>
X-B4-Tracking: v=1; b=H4sIAFEOcGYC/x2NQQqDQAwAvyI5N+BuZRf6ldJDsk1rDq6SSLGIf
 +/a4zAMs4OLqTjcuh1MPuo61wbh0kEZqb4F9dkYYh+HPoWMxb7rMiNNKRIyJ84hDddSMrSEyQX
 ZqJbxjCbyVewUi8lLt//n/jiOHwN2oBJ3AAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718619754; l=1194;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=/q1tmGRlV2b94HWtvWzP/RQIoEDOOCF6WdK86KGM5kw=;
 b=TNVi2y7uh3tYafIIJ1Yi8dgneltwOXnWXnzGfis/4VTTSW2okYU913sE2frv+4N+8DE8Gh0Ho
 GbkVPJPOvsqBE25wlpzZ+HS2K3j++7x0lFit5KAIfDjUbWm6lIoudGD
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the node for sa3ul crypto accelerator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index ce4a2f105630..298d0c91fc0a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -216,6 +216,18 @@ k3_reset: reset-controller {
 		};
 	};
 
+	crypto: crypto@40900000 {
+		compatible = "ti,am62-sa3ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+
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


