Return-Path: <linux-kernel+bounces-220820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EE90E7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE660B2167A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF61824A0;
	Wed, 19 Jun 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BiA+21h4"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E7823A9;
	Wed, 19 Jun 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791073; cv=none; b=Sm0t9UMmWkurdnt9wy4/+3BEGk/DHIUZEDKG0qvC53crKg9JzFMW0dUT1Ay5Hid5X2ZMTCJhm0xdy9xPSTOTnTmqu1NZxr4syf7wnZGRPrGCDxD8FOBlh6BQqSBmF/FP7hSqwhYxLA6AW6bQEjeZ3A/gMZaNyk3zYlOMMWBrWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791073; c=relaxed/simple;
	bh=rHOqKYEiPSXAMGvwVWs307CPQ62xR0Vyd/69BfHqJzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=d/IzxjUvGKZC8j3gKKoiqPeiXOFtMbd93z7vUkB9EaofW3sxduNXRQEE9p4cueSib05V1xLUSl7cAU4Oc9zaAcVuXx0SGW8Qv2DobKtXaoMQDtcoJni6EASitc1aDkh0JG6zRQSZmIV5Vgjsfhmnw768HODruhUmCUWiqiPNJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BiA+21h4; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J9vkEC075908;
	Wed, 19 Jun 2024 04:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718791066;
	bh=JgaQd2I/XrcTw6RtsvCXBKivjaKkKYMU5kwdUIU5ofg=;
	h=From:Date:Subject:To:CC;
	b=BiA+21h40EENvd8LVCAgTe6Qh3c8wPqitETNylEYLf7DzNkHWGhNyrJARCg6ywaSm
	 V9k9etWm5DQZwmsuFfcXZfplzi7yQSwxxr8ok8BE1m1klYFWHdwC8eU6Z4BsNfAOiM
	 z/17pyq3/1Unat+u/hMPnr4a7MX+0JbJLMFflWek=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J9vkve053530
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 04:57:46 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 04:57:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 04:57:45 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J9vit6106634;
	Wed, 19 Jun 2024 04:57:45 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Wed, 19 Jun 2024 15:27:25 +0530
Subject: [PATCH] arm64: dts: ti: k3-am62*-main: Remove unwanted properties
 from crypto
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-remove-ranges-v1-1-35d68147e9bf@ti.com>
X-B4-Tracking: v=1; b=H4sIAISrcmYC/x2NwQqDQAwFf0VybkC3rdj+SvGQ3T5rDmpJRATx3
 7vb4zAMc5DDFE7P6iDDpq7LnKG5VJRGmT9gfWemUIdb3TYdG6ZlA1txzpKuUdIdYXiAchPFwTH
 LNJZqEl9hRXwNg+7/0as/zx/wIZE3eAAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718791063; l=1733;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=rHOqKYEiPSXAMGvwVWs307CPQ62xR0Vyd/69BfHqJzw=;
 b=QqF2LAdVV7SZjhsfnrpfyU3R/Kk2VYvol8DEwkn/MmrBEBAS+iF/F8gzU0oXET5hFmqGX3MX1
 jB9nggz/RNmDxtOMRaSZi+ukMNZ3Ib8yDFklznoUS+Tud1F3xAswVtO
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As there is no child node in crypto node, remove the properties
that are not needed.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 4 ----
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 0f2722c4bcc3..00776a9987c1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -207,10 +207,6 @@ k3_reset: reset-controller {
 	crypto: crypto@40900000 {
 		compatible = "ti,am62-sa3ul";
 		reg = <0x00 0x40900000 0x00 0x1200>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
-
 		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
 		       <&main_pktdma 0x7507 0>;
 		dma-names = "tx", "rx1", "rx2";
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index eed06506f617..c1c74ce40f76 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -227,10 +227,6 @@ k3_reset: reset-controller {
 	crypto: crypto@40900000 {
 		compatible = "ti,am62-sa3ul";
 		reg = <0x00 0x40900000 0x00 0x1200>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
-
 		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
 		       <&main_pktdma 0x7507 0>;
 		dma-names = "tx", "rx1", "rx2";

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240618-remove-ranges-ac3bac5e2f9e

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>


