Return-Path: <linux-kernel+bounces-377482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F249ABF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9954E1C21228
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839E14F9EB;
	Wed, 23 Oct 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gpgZ4m4Y"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4414F9EE;
	Wed, 23 Oct 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666676; cv=none; b=nd97iyZoQ4fDnVANEMv9wWJbLzwy+bytgh/qMfzASfQE3aLCU14SFD1eBAx2RjchxXjYMQc6mnLEnO4N5ABOsW0DJRFDai/73IiiAuPg13tl5i+Dot2fdcAGtCrWUjG1mwukGVETueIIaNcfGC7On4JMjw0jxwVytVuqmlnoGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666676; c=relaxed/simple;
	bh=/Coo0U9uL2C7A0CVAS1yhyVpTodVMH6Z95XOj8p/pP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jTNkTfi+7vfJbfIjf0OAFm955BuPWHeq7g7f2b9OuDVlACk48/VY3uRafuceL/X2KjoCK1Er2OGIICHBki92iUcZsDzeISy+CiAyKDwYaZ3lQi6of9+95/ZSEg2QP0wpCxlpcSxf8UVWoMyG0R+7xLV/BUayVKPUhOf7dYGp4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gpgZ4m4Y; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vodh056487;
	Wed, 23 Oct 2024 01:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666670;
	bh=25/YgKBtYffppw1Naa78m0QJhpdofMuEBNg6vhKOlN0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=gpgZ4m4YQXJWi6tT0f/jcHyednmyZYaxfHnqLwuDGhBSeIHqn4XlYNanIi6E2KuzK
	 VqHBIp/MNAqMxi8HeWun3cSr2ulxkDmkLNM2q+tj3QOYYwsveLWd2OUCC3e66dl53S
	 41jF5qGEThGVANfu7CJipeVcfwVpEh+Zf6Ja3ufA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6voBo006074
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:57:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:49 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUQ129058;
	Wed, 23 Oct 2024 01:57:45 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:17 +0530
Subject: [PATCH v5 03/12] arm64: dts: ti: k3-j784s4: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-3-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=1672;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=/Coo0U9uL2C7A0CVAS1yhyVpTodVMH6Z95XOj8p/pP4=;
 b=jetovDRRJ/ChlmxUdczGBNJYapvUmAXMPLIugmrq08j1vMZj7aNeSKuYWdd7QBkCUAUujS1JT
 ySoeYIkz18YBeIsTUY+aNC1k9AwqRiH/iNp8BRs0kpcuk99wFHW/4RF
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The following nodes are being used in the bootloaders. Adds bootph-*
properties to the leaf nodes to enable bootloaders to utilise them.

Following adds bootph-* to
- secure_proxy_sa3/secure_proxy_main mboxes for communication with
  System Controller
- wkup_vtm for enabling Adaptive voltage scaling(AVS) support

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index 46bc2a3e4aea..9638130caece 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -57,6 +57,8 @@ secure_proxy_sa3: mailbox@43600000 {
 		reg = <0x00 0x43600000 0x00 0x10000>,
 		      <0x00 0x44880000 0x00 0x20000>,
 		      <0x00 0x44860000 0x00 0x20000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -512,6 +514,8 @@ secure_proxy_mcu: mailbox@2a480000 {
 		reg = <0x00 0x2a480000 0x00 0x80000>,
 		      <0x00 0x2a380000 0x00 0x80000>,
 		      <0x00 0x2a400000 0x00 0x80000>;
+		bootph-pre-ram;
+
 		/*
 		 * Marked Disabled:
 		 * Node is incomplete as it is meant for bootloaders and
@@ -629,6 +633,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		      <0x00 0x42050000 0x00 0x350>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
+		bootph-pre-ram;
 	};
 
 	tscadc0: tscadc@40200000 {

-- 
2.46.0


