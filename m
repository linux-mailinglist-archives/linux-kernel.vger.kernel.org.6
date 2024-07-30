Return-Path: <linux-kernel+bounces-266901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C794093E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7029C1C22C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06175190074;
	Tue, 30 Jul 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XN1YuqZY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB20168481;
	Tue, 30 Jul 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323650; cv=none; b=L8EDYUL2ACeelu7j3Nvj3aFO5u2S+EssUyTXUg3Uiq4eYn2Uk57RWSH3m/ndiaqWDbP9kt10jsw7IbCar7eG66GST+C3Bi0oTvkRMHTmC5SkNz8bVSBAVRKcgPPrCg7eo0oMoQi9KD1McKOM/w/nTlgJE1i+EcZp2FtMiPRccFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323650; c=relaxed/simple;
	bh=4Kkl+1AkH7JOl0gxoPYhZ/99OZ8Em+eXsrGTuhU548Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N9BqAeLZgEKjrLzrhaZ8Wy0G5LZs7/vwuIv6c6fdHGZj49Z4gXFuywR4cntK2Jugqq5fdN5Bz2j9HcdUUy1gy+h0VF6zx6Ng4dPeCJiIxdE0ibgCox7rM+pm9VNgFHEPkaonBXMDsph2csyPiMujPGQxAFfv7Mffd01S6HRwsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XN1YuqZY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U7E1Vx122855;
	Tue, 30 Jul 2024 02:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722323641;
	bh=KhF2/vb0geD5wEF5wJd9hBLf2UN80rmKqxnhLmaQwR0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=XN1YuqZYWyZxoR0GWveqmAAdQt/OgjqxPrp2vH28bfSyxcmWFRr0AeV99CXtH/YwX
	 jLu10NAMo8Gd6VhdgnNHV8HCm9LFWn5lNC7mF4ILtweNxfsAosD+oj7HorET/Lx9vl
	 senHSVY6cSxpcqCKl2OwoCH7ErQm1c8kfoLVeoqA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U7E1PV098598
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 02:14:01 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 02:14:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 02:14:00 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U7DqUW078253;
	Tue, 30 Jul 2024 02:13:57 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 30 Jul 2024 12:43:47 +0530
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for J742S2 SoCs
 and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-b4-upstream-j742s2-v2-1-6aedf892156c@ti.com>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
In-Reply-To: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323632; l=807;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4Kkl+1AkH7JOl0gxoPYhZ/99OZ8Em+eXsrGTuhU548Y=;
 b=iUGSspn1gXG6xxf5kGf7WY6G9Fa1RV7xVsLSIRWwmAD3GpYOdS9Jt2HezUfdJkNZwOgBxwfQx
 5YCZSIIfMlpBLv9Ocs+1WFivC9zMI0q2I13sbyT7vW3C1t1ok8Q+kxz
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 4d9c5fbb4c26..074d6dc6092f 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -143,6 +143,12 @@ properties:
               - ti,j722s-evm
           - const: ti,j722s
 
+      - description: K3 J742S2 SoC
+        items:
+          - enum:
+              - ti,j742s2-evm
+          - const: ti,j742s2
+
       - description: K3 J784s4 SoC
         items:
           - enum:

-- 
2.45.1


