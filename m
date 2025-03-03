Return-Path: <linux-kernel+bounces-542400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7760CA4C94D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBBA17E597
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D413239597;
	Mon,  3 Mar 2025 17:00:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA1239570;
	Mon,  3 Mar 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021223; cv=none; b=IJEivTlKj2GOpBN7r6dsG5Q4aJX2t1tgCP7s4D2FDv0iBG4X3JaR+67BKB16NdMTi2y76RQvePZuZ0iSMcvHj8T+s73cfftya8FXoikCx0mc0xPLSN1+YlPB4uiC+1M+PkQUs1eoaAPaTw//sODRdLSGyB4QrWab7K+5tWPkaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021223; c=relaxed/simple;
	bh=fGmoaUhJ6s4D50XCy7yH/YCCOfr0FJRHN2mzmglh2cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCvfOx7nX7d2/Mg9HEhAJf15yFHihaDeY82CnG7E7pbf4LGHDSXht6dx/vvv+g+MiDMyzSX9ZuHS01kZCGCHJavBAT1WJ5xx+v4HucMmV+YZXyo8kf8c9sQfW6H/TpxtZ91qxd/DNUDEYVT19Tpe3sEj5fgvqN1BzRV82mePo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DA57106F;
	Mon,  3 Mar 2025 09:00:35 -0800 (PST)
Received: from e129527.arm.com (unknown [10.57.67.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344C03F673;
	Mon,  3 Mar 2025 09:00:19 -0800 (PST)
From: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
To: sudeep.holla@arm.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hugues.kambampiana@arm.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v2] arm64: dts: corstone1000: Add definitions for secondary CPU cores
Date: Mon,  3 Mar 2025 17:00:12 +0000
Message-Id: <20250303170012.469576-1-hugues.kambampiana@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8XSIx75B4mtcV48@bogus>
References: <Z8XSIx75B4mtcV48@bogus>
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

Only FVP platform will have SMP support and hence the secondary cpu definitions
are not added to corstone1000.dtsi.

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
 

