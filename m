Return-Path: <linux-kernel+bounces-269609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141189434CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465831C23444
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E21BF31E;
	Wed, 31 Jul 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EC7JD7TI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D71BD50F;
	Wed, 31 Jul 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445869; cv=none; b=R5s13FiQU2QCRL9eQcqbc/kRid8s3h/VqD663vqNo69FuGhxI73ujjAzgAjj07R3ZrgiVha1w9Hp3gyZtc4yvFMclh196b3If8JvXFACoV4THDA91VReuYkCp6eoceOr6bLjeFuhGXjngaoRdLsxQCjNIYnrC9+Lf9jFQiI1fH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445869; c=relaxed/simple;
	bh=OfqMQxCSWE27UlsNpnjdXgQIat1JVMciWYIFyaHChes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tt02BCS1XzoDQow/Nxaa8a7yzkgrT9iy5lLiD1XIxPD3HWu5pctzDuu3FVPqszPL17VacbAZSohm4lHVIKvr6+8uBWzHMzRLBSmqvaVH5YY1iVP/k/e/8ytiubOuhp2rPcx6c8UEMp4pwDm+jMzqQUvHRu7coKXkMHiRz9RcrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EC7JD7TI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHB2KI117340;
	Wed, 31 Jul 2024 12:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445862;
	bh=5x0WjPy3waX9hOSHXkRlMB+bk26nCzu1WtvsRQOSaAg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=EC7JD7TIWkK3ISLCBkiYTF92bkTDowAZ7+h5FDGbhXAanF4p5hExltfS+eg7fL8Eh
	 EcyrnKxR3BNLxaN8Mq+FQ+FvmbZfI7JLalVRaphW6l3d2z9FX/3UEQFdxA2gcPJ1KR
	 gGAtyhUa2p0QKqSCI0q45EZPzXxp8HgSnfva+o+c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHB2t2082551
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:11:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:11:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:11:01 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgU036362;
	Wed, 31 Jul 2024 12:10:58 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:33 +0530
Subject: [PATCH v3 7/9] dt-bindings: arm: ti: Add bindings for J742S2 SoCs
 and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-7-da7fe3aa9e90@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
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
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=871;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=OfqMQxCSWE27UlsNpnjdXgQIat1JVMciWYIFyaHChes=;
 b=TbppVw5loyyoXXIxse0DPMZZXlblNsDSWK8dZ+mLeAUiDj0MY+JB7XpTgjeMkPKSkviXe/d+r
 Uu5iU9JAOLGAotNasrCUt5OYDM1KuyCG+Q406zWSET8fX5Wzrx8uxwG
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


