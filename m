Return-Path: <linux-kernel+bounces-230492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6E917D98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34DF28520A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DD17B4EC;
	Wed, 26 Jun 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="slmuzacb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A55176AAA;
	Wed, 26 Jun 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397016; cv=none; b=kPw8qGDT2zWhfSadCizinzcn7WCxhT766L0GZ9ehw4vRXJeTZEL95fQcJdwR5P9wdBS75gBgDGHnGbYKBkjD1sulU9mhbkDHn0hIZ0qozmpeuS8YZrcAI0SlQ388IUqNg1t1IWJE5xLNg+efx8pBg63ETcqQnZXXfNKOAEEoRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397016; c=relaxed/simple;
	bh=LzuNCOUQ9whKlqoew9WHGEBnV6ZQgmziyMW/fn0bPy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D56r9O+Aqz+erdHIn4JoC0gknJ+/FF6kknDeth8MBZt4C8Lfil96M4aQ8hajizUNaOZ7HsKc8bRsBVdST7izy9r7cPhpgkDyoUHpSyVdu0YZVk8MHqLxquvstYhPvs5c37LkzVf4LPLeKZ9OUwMYm4bLRp4L4sk/LRyeUH+x/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=slmuzacb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGogo102915;
	Wed, 26 Jun 2024 05:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719397010;
	bh=0cF2pKdprLckfiVqSJAJnSYhv9Psf/lX2svMNJQUwcM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=slmuzacbXNmJg1x4kkfQY4CHNOP8/nOwwiSyeTr6RNPxBv5m9/hTye4xpHye/KFQ3
	 yohN4j3MKW7VDwsDVKCsAOWVJCJV119ptEnOvGhEVEN5JR8X6C0NTj9neEFQrPPDRg
	 HrfK3QOH6RZurS4V5vXwlO0zGcy/kN4khRi/Mr+o=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAGoRu128074
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:16:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:16:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:16:49 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGnod094595;
	Wed, 26 Jun 2024 05:16:49 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
Date: Wed, 26 Jun 2024 15:46:44 +0530
Message-ID: <20240626101645.36764-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626101645.36764-1-j-choudhary@ti.com>
References: <20240626101645.36764-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On J784S4 SoC, the AUDIO_REFCLK1 can be used as input to external
peripherals when configured through CTRL_MMR.
Add audio_refclk1 node which would be used as system clock for
audio codec PCM3168A.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 7e10be314684..f170f80f00c1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -121,6 +121,15 @@ ehrpwm_tbclk: clock-controller@4140 {
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk1: clock@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 34>;
+			assigned-clocks = <&k3_clks 157 34>;
+			assigned-clock-parents = <&k3_clks 157 63>;
+			#clock-cells = <0>;
+		};
 	};
 
 	main_ehrpwm0: pwm@3000000 {
-- 
2.25.1


