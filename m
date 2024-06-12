Return-Path: <linux-kernel+bounces-211771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673BA905698
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614161C233B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DF17FAD1;
	Wed, 12 Jun 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AAn8KeD6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72217FAAF;
	Wed, 12 Jun 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205206; cv=none; b=cAgzokO2ZANe6+EcR4B8vNTTZObvop4vGuxN2386jq+Nsbwqjxi6V+RpgE2omYiLnkTl8izhGYCNPANnvp4bfGXoVAvZouRprtF8kreciTJN88AE5nqtKF/0piOSFrQX03F00p/gvgoflXU1SZSKWsG6Egxl1PG80jCA7jraBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205206; c=relaxed/simple;
	bh=SOZHiLM+G/7L5afY6e4at6d44fRoz61klXhfjWczShs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdXmBSFHGLMY8T4aJZX7gejW85K6uq296PIDVDhYG0ERa/mM1BBgC54q4L+huw6sZ2kRWp3XOUSwm0G/nOBS5amd0IbvNo6cYUCiZLv+u3slhAzUwl1ekYv5sEk06GfWqsTUz6TsyDS/+l3jvhje5LPA6r4O2lZEg4B2ewF8SOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AAn8KeD6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CFDLEG011645;
	Wed, 12 Jun 2024 10:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718205201;
	bh=N6MlggpYNt5xaAVX8rDqE37RzNBe2/Ag9CB9y6lQOW4=;
	h=From:To:CC:Subject:Date;
	b=AAn8KeD67lrBHjY+v3v8ex+dYP31mREioBLO8tqTAs7lS2Og/Nag1Ez2RjV4V484n
	 zKnSfOwh+95javow70mSrAKngyZLrsv+WRa6nRmsyTf0EtMiHUi60UH6cE5HEoWZJm
	 gjS8GE1fADdM+Ltpcenh+LBV0ryCU+YKJZqbsUz4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CFDLWx013547
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:13:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 10:13:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 10:13:20 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CFDKD3104005;
	Wed, 12 Jun 2024 10:13:20 -0500
From: Andrew Davis <afd@ti.com>
To: Daniel Tang <dt.tangr@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/2] ARM: dts: nspire: Add unit name addresses to memory nodes
Date: Wed, 12 Jun 2024 10:13:13 -0500
Message-ID: <20240612151314.27967-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fixes the following DTB check warning:

> node has a reg or ranges property, but no unit name

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire/nspire-classic.dtsi | 2 +-
 arch/arm/boot/dts/nspire/nspire-cx.dts       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nspire/nspire-classic.dtsi b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
index a6e9cbf51524d..0ee53d3ecd542 100644
--- a/arch/arm/boot/dts/nspire/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
@@ -55,7 +55,7 @@ &vbus_reg {
 };
 
 / {
-	memory {
+	memory@10000000 {
 		device_type = "memory";
 		reg = <0x10000000 0x2000000>; /* 32 MB */
 	};
diff --git a/arch/arm/boot/dts/nspire/nspire-cx.dts b/arch/arm/boot/dts/nspire/nspire-cx.dts
index 29f0181e5b385..debeff0ec010f 100644
--- a/arch/arm/boot/dts/nspire/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire/nspire-cx.dts
@@ -122,7 +122,7 @@ / {
 	model = "TI-NSPIRE CX";
 	compatible = "ti,nspire-cx";
 
-	memory {
+	memory@10000000 {
 		device_type = "memory";
 		reg = <0x10000000 0x4000000>; /* 64 MB */
 	};
-- 
2.39.2


