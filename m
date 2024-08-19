Return-Path: <linux-kernel+bounces-291809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9D95673C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C49B2825ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B415D5A1;
	Mon, 19 Aug 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mp0/dAqw"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F4140E50;
	Mon, 19 Aug 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060403; cv=none; b=beEgSbBd11Sji8q4ttRhxseXCxHNKJOwTG4/i1vJQvr57rPFu32rVlCYy07QlM0/CNc30m6dqnRWnIfrj22Wsv7hTD8s40o9piH0iwz0rgKkRwl541c3qBcFnhBYSrYhusEBA91mDURL1CFy5xSrI41ZdzflrHUZ4Qjy9qAWY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060403; c=relaxed/simple;
	bh=0j89wBAI4Pmk8/+fqTPpNXqC3nyCPW266Wtvrp9BU60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uiz8OuRYJcAWaFz/wjWCJPQoyL8pXmSokyU4HRAzd6c8KA8q40On0z/d6J1T4XY4CDP3aDwA0anyokA5KzXuIw0Hm5HImsEziffAEVUrrbdti9AAhBh/zIuSSiy+y7YBZIZzO3OgDtFIzrG9TkY6pnR+NI+DBcQ4+aMFoi5zaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mp0/dAqw; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J9dqIb107710;
	Mon, 19 Aug 2024 04:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724060392;
	bh=3Cgu0tyd4ZrGR+iFkP4eYj1DHsmzwqLInte2b5mLOxE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=mp0/dAqwqvCqbqxoctorldpk+BnWl96i5zI6RtC16q1qLotFFKz3R11uXud55IFaL
	 tLG2YV32QvmvK1GktMmjBsA2woQh9LFjX6GDOwX1OgfpGHGC14sRBBqeCx+S5Wyzg6
	 sIs1qGBC78jlFhflAAs8qr+d2pIdDz+09sQFf+c4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J9dqYv015805
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 04:39:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 04:39:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 04:39:52 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J9daOF082967;
	Mon, 19 Aug 2024 04:39:48 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 19 Aug 2024 15:09:37 +0530
Subject: [PATCH v4 3/5] dt-bindings: arm: ti: Add bindings for J742S2 SoCs
 and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240819-b4-upstream-j742s2-v4-3-f2284f6f771d@ti.com>
References: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
In-Reply-To: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
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
        Manorit Chawdhry <m-chawdhry@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724060376; l=917;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0j89wBAI4Pmk8/+fqTPpNXqC3nyCPW266Wtvrp9BU60=;
 b=LTHRPzn+CrmJFMfJQUr1vI45jcAMWQEr9PoVZvS+HWFnvm8WnOPO4gYsHnrjE7MDnY+UTvjfw
 UPM+eMAcmiEAQqm2C8tRypXMv2XmgZHUoQ10rhDCACnTUFduZmsVS+/
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
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
2.46.0


