Return-Path: <linux-kernel+bounces-266902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C8D940940
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998B71F246A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65508191484;
	Tue, 30 Jul 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olSJzM9d"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724D19005E;
	Tue, 30 Jul 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323652; cv=none; b=u2ADHtYV9amtF+HzI0uGxomc9E40zTGo4i5nPv5bnjYmyJ9YiHglxyTmTK9kTYb5ULG5+rP7q/2fQmNE4AbELwVdSSI/VKgiH/BzI1uekxnhNEpMu0sKjKv4/zhMIB4wd2suHeoT7kcjlVNvRgYAYQhXGMDbSTGwjV43DgOp2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323652; c=relaxed/simple;
	bh=2BeYiH9Du57uXthlw4RzNfbkZ8uRe8Xaj2TdAdZnU3g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Sc1HwRQbNqsWZhQTdSG7DhP2j9ntFH3wON0/pkcMRhk4bH9T2vIc8+hXgbnTNs4MScfQ2Jsw6atPV8kJ9VHV0K3JcxA7bOzI7fq3ZONRzvjWdIiDmpajPekfK9Kl/FwRWVJWbT/MKziN4miBtn+Vi4LtWDoR8Mlwb+HgW4WsxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=olSJzM9d; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U7DvNS071063;
	Tue, 30 Jul 2024 02:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722323637;
	bh=VuE5Ic37ykfR0wG6KkUPLsIJPMf8rMcZmWQZTXc4JkQ=;
	h=From:Subject:Date:To:CC;
	b=olSJzM9dytZfxas7x/jnC4hnA5iBN9bvB0KxTx7Xf8uqmwmDnr9kTUs5IgM2mk8S/
	 5gGngT+Z6rrRcdMsvVSXehJMf0M+ec8JyhMT03d0nLDE4KbfSGSeZPGvdxoJBbsgDF
	 mWGEQeRv+x9qe2DIanBZZ4aSeGcoHieb4013IS7A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U7DvpX122293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 02:13:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 02:13:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 02:13:57 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U7DqUV078253;
	Tue, 30 Jul 2024 02:13:53 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/3] Introduce J742S2 SoC and EVM
Date: Tue, 30 Jul 2024 12:43:46 +0530
Message-ID: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqSqGYC/22NSw6CQBAFr0J6bZvpzvBzxT0MCxgbaRM+mUGiI
 dzdEbcuq5JXb4MgXiXAJdnAy6pBpzECnxJwfTPeBfUWGdiwNRkbbC0+57B4aQZ85JYDY942Wcq
 mpDQ1EIezl05fR/RaR+41LJN/Hx8rfe0vlxP9y62EhEVbiiVHRVdStejZTQPU+75/AKFm98axA
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323632; l=1435;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=2BeYiH9Du57uXthlw4RzNfbkZ8uRe8Xaj2TdAdZnU3g=;
 b=sQRGaRiYnpsldzTQfPG/tr4yMGk/Kw4viJbrTCSyncdtr7qIlb0FIVAU1GkAg2gK9BeIsTkeC
 s2eb4GGuWniDa9kJsJvT0p+mDUKvqswRLnyEK6PFsQ01m/nDlpJmIKE
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
* Krzysztof
- Add missing compatibles
- Improve commit message

* Rob
- Split SoC and EVM support
  - In EVM support separate out common stuff from j784s4 and j742s2

- Fix the number of VPUs, TRM conveys 2 VPUs
- Link to v1: https://lore.kernel.org/r/20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com

---
Manorit Chawdhry (3):
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board

 Documentation/devicetree/bindings/arm/ti/k3.yaml |    6 +
 arch/arm64/boot/dts/ti/Makefile                  |    3 +
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts         |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi       |   44 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi            |   26 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm-common.dtsi | 1436 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 1441 +---------------------
 7 files changed, 1551 insertions(+), 1431 deletions(-)
---
base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


