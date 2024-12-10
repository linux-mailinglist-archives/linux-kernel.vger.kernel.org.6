Return-Path: <linux-kernel+bounces-440294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B89EBB63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FF3188151C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6D22FAD6;
	Tue, 10 Dec 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RlqrFQxI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C922CBCD;
	Tue, 10 Dec 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864394; cv=none; b=XzHAlMgYCQwFZ2G+JKjUGdz5wRkYspJWu4gbIulMRgu1gAEALGNEixVc+U5/dAqsOA4so4dNFVeLziqYa1R2Sv2vyFJpFtBZkANS2OC03v/glE4JNCF8bNd6mOZKfOOnh1PWfRnIA2fjCkTjV/jyJOQUXIVaugGZllE/l77msfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864394; c=relaxed/simple;
	bh=b36A/MI7Uhq9p9qgB4xCpkTfp69Q7QXfrz3GkeZCAeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DkhyMsGUprvpXsP48uK4kOvT5W+Av5cDZA8Xjn0NZEWSH8K/WQhU8i+Uhd4ZNhOxVRH1SimLSy7KEvFMnFMIxaVBG79CpOnniWKLg25al/VyOud2DIcOK+N4gv4Qi/BGwFI/tLqDwpNH+rGb6enA7vV/2WzGc+3xxdeQeBdhfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RlqrFQxI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxWpO093332;
	Tue, 10 Dec 2024 14:59:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733864372;
	bh=3/c4szv2hbJGkO3LPAuOYMXLi58zyh4ZiQjA5EfGs3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=RlqrFQxIKO6yRheKH84SmHqlxDEzXbBuKhh4pOj9bp5V/yLEt0m8QPFe/4YXL2pCn
	 f7F9TJbvdAtQSRU+xRtfnSl/yZDSxv1CT3RvliDpfvJXT9YJXsnXRNki8/TrtYRDoB
	 EcNy429PCKNyNT1BBUHay1KTBzTaDuFkf1/o5VwQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxWIU043829;
	Tue, 10 Dec 2024 14:59:32 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 14:59:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 14:59:31 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxVq9042179;
	Tue, 10 Dec 2024 14:59:31 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 10 Dec 2024 14:59:25 -0600
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62a: remove duplicate GICR reg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241210-am62-gic-fixup-v1-2-758b4d5b4a0a@ti.com>
References: <20241210-am62-gic-fixup-v1-0-758b4d5b4a0a@ti.com>
In-Reply-To: <20241210-am62-gic-fixup-v1-0-758b4d5b4a0a@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bin Liu <b-liu@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=bb@ti.com;
 h=from:subject:message-id; bh=b36A/MI7Uhq9p9qgB4xCpkTfp69Q7QXfrz3GkeZCAeQ=;
 b=owNCWmg5MUFZJlNZBhFKfAAAan////d/n/8239uN7f3/d7YfeZ2+e7fx7N7l/9tPtpbY1++wA
 RsYGKDQDQAaADQAADTQaBtQ0aAAAAAA0AAAA9RoDQyNqA9T1BoPRqPU/TVEAANNPUANAAANNMRo
 Gj0hoAHqAAGg9T1NDTTQBpoA9TymEGgDR6gNBp6QeSNAhoYjTEyNDRiGmgaA0GjENAMgADQBkNN
 DIGCDRgTTQ0MmgyMTQGgaGjRphACBXBbsKDPmwQgMJ1REyS4QZiaCFSG3sS7X27o0bIQkOA1Inz
 ayxv59QQB5GTxhSdCPl/wyYq40F8Gk5UXyeIagtWP1s5w5IcswBRJLwwVfgu54ivDCEgPubLVPa
 2M7MrdnbcBhkakIGJOUOPvG/3aAUjjEyDK0A4BTcWZ6lVUO2cV8jXXuAyga07zXZw4WZFZ54r40
 WFqLGJ99voTLRioUVQsJkqTD9l6PGEIbwufwlGK6ZxWnNT9UuG9qbAodFAJgEFq9XnQKCC39IQq
 bcnY3aXuk1piy0xkqidPfHgIcKhwK05eJf5/YZ+2Xm06DV7MB0y4qfLbxntST9LGR8xZQgrEr7M
 RsnuLBhz0CL66kynLlhWG4uclIRgCjfwIbrZ2haan/EQbqLX5oQ3isF2alVIBeUw5DskgSSpoR8
 g4LmT/i7kinChIAwilPgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The GIC Redistributor control range is mapped twice. Remove the extra
entry from the reg range.

Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index a93e2cd7b8c74..a1daba7b1fad5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -18,7 +18,6 @@ gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
 		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
-		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
 		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
 		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
 		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */

-- 
2.47.1


