Return-Path: <linux-kernel+bounces-302007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36695F88C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B3284393
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94D198E9C;
	Mon, 26 Aug 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="B7mFFY1k"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97419580A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694978; cv=none; b=OMi7GJRwj10JrPnSbyy/mdvW6MobYFHX0tmn9oyZ1MuTJnZKHcCaInJqyNuJG5GraVWpxN5hssCnn278zeVle3ZZKJAGf0crfpOL9kacnd3HYlRXG06bRfs24KuV44v+I9I+mlqaBmX167ofAN15phTJoCGZpSHPBTIXq1qafSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694978; c=relaxed/simple;
	bh=2Fxy3wyOfsMl5sdn0mn+jCpfHnxjJ1MIT5PBmEDXiI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDpaKGN6vbVrZOxi8k2BBxWripl/Ulv32Onx8YONg0L0ak5VdNCM8p83npvgPQ5j0fxB3PfB6rFpa3QjCMej2Cwa4svKJ+QTRt/afcTYFiIzCMCNNOe8PL1XTU8XAZ/F5MixKRYNQMnAR+FuEhYygdnIwD3semkseIb7tZLBHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=B7mFFY1k; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240826175612742ebbd4f5fc867410
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 19:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=994WEgmSr6YSmkCGjFYWFV2N5vlQvq3ltUdhvovY9/Y=;
 b=B7mFFY1kPleNz1b3yLiXsmFVh5REX58dw4cmjx1c1TYsvOqKbkG+S30Ya5ntPtEkEsFSIh
 MtfGiubE7qD2KNymMQaYlPmx4KQ3WWbB/kCtzpwRVfv8hlao62/SrOZg41kudoGCFbfqg15W
 pgWj8I286/pDczzQ89YrQpzD2zwnZhmNCMijYChY6MOXQ1Y79UV1YgFehySeVr4382ZciN+P
 IKjioAM942km4+yhhwPbeKYoWCj7lfE9H+2oAaxIXQVnTl2II/j12sWdODAb9rdHrD1cAQtZ
 y92ionDvkrft0iBDJuc7LfVj2TatPmHPzmzortA7HUPu8yY3mNPTUFSw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH 3/5] arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
Date: Mon, 26 Aug 2024 19:56:07 +0200
Message-ID: <592bf31689620f4d9c8164fa0865bc3663d20ca0.1724694969.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724694969.git.jan.kiszka@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
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

Rewrap the long lines at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a8664b246795..c91969ddcf4d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -867,8 +867,13 @@ main_gpio1: gpio@601000 {
 
 	pcie0_rc: pcie@5500000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5500000 0x0 0x1000>,
+		      <0x0 0x5501000 0x0 0x1000>,
+		      <0x0 0x10000000 0x0 0x2000>,
+		      <0x0 0x5506000 0x0 0x1000>,
+		      <0x0 0x2900000 0x0 0x1000>,
+		      <0x0 0x2908000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -888,8 +893,13 @@ pcie0_rc: pcie@5500000 {
 
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5600000 0x0 0x1000>,
+		      <0x0 0x5601000 0x0 0x1000>,
+		      <0x0 0x18000000 0x0 0x2000>,
+		      <0x0 0x5606000 0x0 0x1000>,
+		      <0x0 0x2910000 0x0 0x1000>,
+		      <0x0 0x2918000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.43.0


