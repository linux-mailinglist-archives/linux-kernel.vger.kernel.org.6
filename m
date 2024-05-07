Return-Path: <linux-kernel+bounces-171257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E88BE1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242861F215BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015D15B120;
	Tue,  7 May 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mI6M8Yvs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D53158DD4;
	Tue,  7 May 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084541; cv=none; b=NQYLJqaCjAsyLocE/8nLFXqKCJZZlOf4E4U9TFjOPidpo4HyWlYrOy9GWWDIKJT9YiA0u2nKQx5vnuW2RM1slbXZBqUFkKa6mHIvVsO4JR2kRiKUgb5Of4JH7jejje77yXk8kFjtbGga3yP5UqB8McZFgjpxTPC7Z1J6SQJKKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084541; c=relaxed/simple;
	bh=TBQJkp0cSO4wK8acG0VnKtXJX+J7TdjIHkOssuvBkVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEU0VNfDI/iiLNY41Z53KVAAN2pMjhmvHZURfOtIDb4hEdK98ImFztdXd/tVTJAKj0C0mn6DgN75WxJf8nChKcCUEhIB2KpPAKBTJfwzQMcbjWP3TFVcbtLrGqXlAilJku2Wr2xn+SkSYY1YQlZO5NG73BHfvB3AGJIYk5NUDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mI6M8Yvs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CM7GP005768;
	Tue, 7 May 2024 07:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084527;
	bh=T/RkWX9FF1gd05lbbr3DFlqsKgFxiCWHWrytrtgwAfk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mI6M8YvsLYG+CCP9TJCrqai4a0a2BLZT9KcNzRWTr7UTnkK0bm95euKiuVq/g5eHt
	 +TEAovYa+7gcwyIh/6HVu4PUnLawuPH+LJHb7fBLNGZYXXV7vWo+cWxljlzaCgN6pn
	 9QjGB5EJEhCWgGPLTtmIcOCSt7j9QYJeGkIJsd5o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CM7n5077373
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:07 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDO038074;
	Tue, 7 May 2024 07:22:03 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/5] regulator: dt-bindings: Unify compatible
Date: Tue, 7 May 2024 17:51:54 +0530
Message-ID: <20240507122158.3739291-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507122158.3739291-1-n-francis@ti.com>
References: <20240507122158.3739291-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TPS62870/1/2/3 devices have different output currents (6A/9A/12A/15A) of
the TPS6287x family. The I2C addresses are the same between them. There
is no need for different compatibles for each for these devices so drop
them and add a unified "ti,tps6287x" compatible.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../devicetree/bindings/regulator/ti,tps62870.yaml         | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
index 386989544dac..2998773db990 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
@@ -15,10 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
-      - ti,tps62870
-      - ti,tps62871
-      - ti,tps62872
-      - ti,tps62873
+      - ti,tps6287x
 
   reg:
     maxItems: 1
@@ -40,7 +37,7 @@ examples:
       #size-cells = <0>;
 
       regulator@41 {
-        compatible = "ti,tps62873";
+        compatible = "ti,tps6287x";
         reg = <0x41>;
         regulator-name = "+0.75V";
         regulator-min-microvolt = <400000>;
-- 
2.34.1


