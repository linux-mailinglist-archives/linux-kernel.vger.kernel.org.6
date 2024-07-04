Return-Path: <linux-kernel+bounces-240847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F30792739D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633992888DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEA1AB905;
	Thu,  4 Jul 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yq7PxuYn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406751AB53B;
	Thu,  4 Jul 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087451; cv=none; b=T34UC7BIZ9xTNjLEHXfa8G7w+U1rDs8A66vzh9EaKL2WOkNEr4bAIYxlkXcHAbK31iwAB3uLiwbPwN2oh72XbQ5xWBhKtt80uw3AzqAQOyvN3v+cg1526bxaLJOQ2HOI/7Tc7o9BQnnMyDjeQ56G08Yexd+IvsVLaJxhf/RhIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087451; c=relaxed/simple;
	bh=CnI8zsL1B2KNm8BxxoM+w5xQG/PoOWS7Ui7Lg4rgs6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blchH07Ki+gduIo9L0o0CII58CFakB9NXj5QVJ5nZ3pJ5MCvsMe1//hOEaeM+chcip9sf7Ixz/yLRo4Sl77NGmv35tocr3lPn4n+QvVQjLMdI3nub55kHSAQITdSj9A1+GE9g0JeofWr57LM5BZEsAn+F4tLFcyx/Ih0BYq3yEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yq7PxuYn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 464A41bF043155;
	Thu, 4 Jul 2024 05:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720087441;
	bh=HxdYmcuDyWAEPxPrp5DlPVzNjdezLeNiB4mviQo5a+0=;
	h=From:To:CC:Subject:Date;
	b=yq7PxuYncZ46Ge+MLExvJd1t0DhyF3OJPuxTqywEGtLCmAUa5TLTzjr/lPZzvLt/v
	 Wyr0IJE+BhAKPuUdSP94kLpCAI6Cjldi1RtCIkV7xldz+wbapopQ0V+hK1pbFI2SjA
	 h8uTsrpKGjbpbesRIoLhw9zRpKD80w5XLjxwa7pU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 464A41dH013721
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:04:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 05:04:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 05:04:01 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 464A3vTF121762;
	Thu, 4 Jul 2024 05:03:58 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e: Add bootph-all to chipid
Date: Thu, 4 Jul 2024 15:33:56 +0530
Message-ID: <20240704100356.1078195-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add bootph-all property to the chipid node so that it is available at
bootloader stage for obtaining the SoC ID and revision.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
	- correct $subject prefix (Vignesh)

 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 9349ae07c046..c2417ef614cf 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -57,6 +57,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
-- 
2.34.1


