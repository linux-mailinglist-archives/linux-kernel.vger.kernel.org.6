Return-Path: <linux-kernel+bounces-312440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA69696A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441E71F25377
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D2205E2E;
	Tue,  3 Sep 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c6/pQ53J"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5147201265;
	Tue,  3 Sep 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351177; cv=none; b=qVnPYVnH4YA6gIjk0hSY0+sU2VAEL80hEIKPZGGS+aNE5Vs8xXbdGNoGZ7nKczea6lBCy1MIMPVdN5e539QHN2S/QvbPTX92lhvPDsQ+AVxvq0s6v1HWaVB6qPgRUpNILQ/gpaqJ1h3wzRNMvsYYdcTC32qfs475yxAoWA+8tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351177; c=relaxed/simple;
	bh=4WftC8hv69+qtzdyshUfjUmPEF7vOdi0BEHrqZWIL08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i5VSOvVXxbvxhAg+iPIsk8xq+eoWoj+fVN1HZO+Cje09eFRUUzK1hJCFKrUL6BFvuRUlxVlkTSaXQcFOitAY9Q1pH+49yauvqNniejieAhgT2zaeBsACzQK9yazv2yOkAIc4+71EPqLUxhnMxekgXpF6XHqPtVqwu7C1ZboL84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c6/pQ53J; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838CiGu115341;
	Tue, 3 Sep 2024 03:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725351164;
	bh=jUG8LRWAqq4w/NuCY/4RwjcD3YU0lZjiRfWtfj7R6HI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=c6/pQ53JNTRKcOaCMQywkVkrFgGUrCr542uBj37V4DR+erHliGlLViXwmnCSnzzT1
	 fwOmPqdGwQE7nCwnTBD88DRpwq45GYxoAGlLjSkws6lO5tIorjZ0cPYRNUcsbu1sSY
	 Es/kXIX/ADJvbN0BCKPsoRlav2cHXAZgkybhkzBY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4838CiTR010416
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 03:12:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:12:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:12:43 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838CQoB062032;
	Tue, 3 Sep 2024 03:12:39 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 3 Sep 2024 13:42:21 +0530
Subject: [PATCH RESEND v6 3/5] dt-bindings: arm: ti: Add bindings for
 J742S2 SoCs and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240903-b4-upstream-j742s2-v6-3-49d980fed889@ti.com>
References: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
In-Reply-To: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
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
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725351146; l=948;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4WftC8hv69+qtzdyshUfjUmPEF7vOdi0BEHrqZWIL08=;
 b=FUJWxJ24SCigsW1E8amJzb5D7znrmXbp7KoQMURzw2kslN9l1IdylNfN2NL8GPgUORYuzljXl
 8iQ03x+tlgXBvwvDPHfxBpqTiCaLwAUWau/nF6LPRUtTRlkH5mtQ1F2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    v6: No change

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 5df99e361c21..b0be02f9d125 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -144,6 +144,12 @@ properties:
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
2.46.0


