Return-Path: <linux-kernel+bounces-320340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA397090D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC5DB20EB1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1417BEB8;
	Sun,  8 Sep 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="N+v60XUr"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16653176AC2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816769; cv=none; b=GC3ehKAsFZWalzL9ZMu/sRvKnmkYIf7VlBkdCuTFmmELc2QbBgAN5aaD9ZhbtiBTpXPpxsdN/JDx7fBdIaXbg9TbWZ/z15U+bgUVN0VJkHbbXzK7f35vuKB/RvPHETv/fe/LFEnoy6CQusXM7NN9NUr2q0fmP2u7GbMGXhqYXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816769; c=relaxed/simple;
	bh=YFhEhD2DDFAzOc5YRN506WbRhSuqs9WezZihnyy8brI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb8HSlWqLSzRKOzVcxjrGUB35iTglx2TWCeUGx0ljcFrOSkW/8WX/HudPD7qB4m/R7Uj5AW9PWeIDiq59TrFJD9QLOra3PjJ7U8SBB5fgfP5wT0x8jHCST4Q9c4/O+S5I0nSEtJqnlCdqQZdiZSZ0OkaaxaF8mwrshW9/9jBvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=N+v60XUr; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202409081732385721de8df104bb2df8
        for <linux-kernel@vger.kernel.org>;
        Sun, 08 Sep 2024 19:32:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lEToRIXgwmYCaLisxjDuneMdvn7veaPhbgDLaE9G4uY=;
 b=N+v60XUriN3aJGy7SlRKEFOA88hMd7ufyfiUb2eil8kQ6N/jzpswkaZjHVZGyKZeHNafZN
 CLKxn3YAXPFEfjvpCr976eUl6amZPD1ep8Nmo+LWYF3HIcBAc6/BHwqyA+qX2R7ESCgGlTMs
 SMJLN6r6H3BRSufWAs2WdlKp1gOMB1q2u2vhkZp4z/JH4hJnUg4Vm8Umv09ON3XwLIRaFm1t
 ZL4tISanLWu49NKACGo51hkJ6Xp6uMbPaU7BB2Uls2R0uM7XsGeFcjwa6LLv0V3SuzwnsKjr
 UX8XWBLGum9IScSxWk+vx0BInajTRT3Q4lxjjhHw5v5TIa1DqcWM8chg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v5 5/7] arm64: dts: ti: k3-am65-main: Add PVU nodes
Date: Sun,  8 Sep 2024 19:32:31 +0200
Message-ID: <e84ad0a23701c7fa5abb0fa7af0d07f0880787c7.1725816753.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725816753.git.jan.kiszka@siemens.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Add nodes for the two PVUs of the AM65. Keep them disabled, though,
because the board has to additionally define DMA pools and the devices
to be isolated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ba43325c0eec..2582dad68dff 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -841,6 +841,26 @@ main_cpts_mux: refclk-mux {
 				assigned-clock-parents = <&k3_clks 118 5>;
 			};
 		};
+
+		ti_pvu0: iommu@30f80000 {
+			compatible = "ti,am654-pvu";
+			reg = <0 0x30f80000 0 0x1000>,
+			<0 0x36000000 0 0x100000>;
+			reg-names = "cfg", "tlbif";
+			interrupts-extended = <&intr_main_navss 390>;
+			interrupt-names = "pvu";
+			status = "disabled";
+		};
+
+		ti_pvu1: iommu@30f81000 {
+			compatible = "ti,am654-pvu";
+			reg = <0 0x30f81000 0 0x1000>,
+			<0 0x36100000 0 0x100000>;
+			reg-names = "cfg", "tlbif";
+			interrupts-extended = <&intr_main_navss 389>;
+			interrupt-names = "pvu";
+			status = "disabled";
+		};
 	};
 
 	main_gpio0: gpio@600000 {
-- 
2.43.0


