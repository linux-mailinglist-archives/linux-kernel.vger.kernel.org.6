Return-Path: <linux-kernel+bounces-542080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6925A4C581
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F147A054C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE71A08AF;
	Mon,  3 Mar 2025 15:37:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A523F36F;
	Mon,  3 Mar 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016273; cv=none; b=AX+HVmzxQdc15g1Fr4yEd2QUs6fi6FFyANlHyaDgUrasDFchBGAb8poKUGXmyRcUbMbylkIJqFfaJ1Og8TelPtUDQyACCu8wMmFUU+JKCcgLFhyzbmuNbs65d8fQPFXtPcDDYHLSbQUcoS1Elnn7n8qllJv1TPigyCsA2K7/Ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016273; c=relaxed/simple;
	bh=ZudowNZEK9JeVL1QV0s4QYj1IGj4nJAcdTPtImYRZ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPzojKwmYFbl8ZAQXIpDR+KJ+ud1SL9UJRc0QJVMgWK8sLtQvAjqvsJpfwpvhf/tieKNJ+SUba6w5rNOK9A3icgo3esSCM6Es08uhAgOBnfFDYtpkl4trQt5Jj/EY+iqNWtxCm//o1xg9wJB8DlqJsiOMEYW8nRJnsr9gp0ubvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E16B106F;
	Mon,  3 Mar 2025 07:38:04 -0800 (PST)
Received: from e129527.arm.com (unknown [10.57.67.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4151E3F5A1;
	Mon,  3 Mar 2025 07:37:48 -0800 (PST)
From: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
To: liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Subject: [PATCH] arm64: dts: corstone1000: Add definitions for secondary CPU cores
Date: Mon,  3 Mar 2025 15:37:44 +0000
Message-Id: <20250303153744.376419-1-hugues.kambampiana@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `cpu1`, `cpu2` and `cpu3` nodes to the Corstone1000 device tree to
enable support for secondary CPU cores.

This update facilitates symmetric multiprocessing (SMP) support on
the Corstone1000 Fixed Virtual Platform (FVP), allowing the
secondary cores to be properly initialised and utilised.

Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
---
 arch/arm64/boot/dts/arm/corstone1000-fvp.dts | 24 ++++++++++++++++++++
 arch/arm64/boot/dts/arm/corstone1000.dtsi    |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
index abd013562995..df9700302b8d 100644
--- a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
+++ b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
@@ -49,3 +49,27 @@ sdmmc1: mmc@50000000 {
 		clock-names = "smclk", "apb_pclk";
 	};
 };
+
+&cpus {
+	cpu1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+	cpu2: cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x2>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+	cpu3: cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x3>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
index bb9b96fb5314..b4364c61901c 100644
--- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
+++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
@@ -21,7 +21,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 

