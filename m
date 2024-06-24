Return-Path: <linux-kernel+bounces-226713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 580589142A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E9CB23044
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2228DCB;
	Mon, 24 Jun 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="eSZh2DU2"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC341F5FD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210063; cv=none; b=aL1ZWejAsVzgw10opsAFva03EoscWeHbuMjZMF96v6dJvKT39nNWwaXIAHpIvDfPLVyzpWUSN789k+1zzTEa/1PWz/HZybehuMGjrOsKltxSlfbTDCXB1pJ+dGlvhH0bXZN0UMo8MxRhPk9iX/ttxspiP+3riQFP5ia59rR9h8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210063; c=relaxed/simple;
	bh=gOnnGFrCNHyAwTXnFy/ijI8fleOSIwfAMcn6FK04PNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD979AxycT1h2N6iXvA6lUe7ROB7nBwvwRFkxJ9raQbk6+D8vAe/MNcqAyGOkGPVqPD6emf2hF7xSl0Gxn+RVRUy1qJkE43IiGaGYgH7XlaAPYSbjS83zAFYsO1KFJsU+81gdgGYGc31Pmx/pJXEP4ce0G4h+Jd3uQsT4yeHJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=eSZh2DU2; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024062406205113683d90e87d1c3a84
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jun 2024 08:20:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2JW562zd7UF7vvqn05zomFnN4EhjrMfcocTZCV1+5wk=;
 b=eSZh2DU2fKJCWinpbsv3mr1tzr1+Xkca8G1bTEqZaIFbCsaKjuKCkzXkgrksCkF3Hv2JfN
 A1Iyw3go3F80ysc728AeHKx/zDg6ZO+5CcxhkviuCbSUv8CBay9vuCh0ze/glPcRb7jB6uEO
 TztYvkO7oQol76RrG1dtegUbWxPWQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j72xx-mcu-wakeup: add dedicated wakeup controller compatible
Date: Mon, 24 Jun 2024 08:20:47 +0200
Message-ID: <f868fb7c0f26c464468e2e574bc5aaacdef06e2a.1719210050.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719210050.git.jan.kiszka@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
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

Each syscon node must come with a dedicated/specific compatible, which
is also reported by dtbs_check:

  k3-j7200-common-proc-board.dtb: scm-conf@40f00000: compatible: ['syscon', 'simple-mfd'] is too short

Add one for the TI K3 AM654 MCU wakeup system controller used in J72xx
SoCs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index fccaabfb1348..3a78a3c1676d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -165,7 +165,7 @@ mcu_timer9: timer@40490000 {
 	};
 
 	mcu_conf: syscon@40f00000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x40f00000 0x00 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 9349ae07c046..d68e33d71eb3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -35,7 +35,7 @@ k3_reset: reset-controller {
 	};
 
 	mcu_conf: syscon@40f00000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0x0 0x40f00000 0x0 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 5ccb04c7c462..1edb71f4a1bb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -140,7 +140,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 	};
 
 	mcu_conf: syscon@40f00000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0x0 0x40f00000 0x0 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.43.0


