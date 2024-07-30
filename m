Return-Path: <linux-kernel+bounces-267310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE7940FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0534F1F24BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456619E7D0;
	Tue, 30 Jul 2024 10:43:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5719D063;
	Tue, 30 Jul 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336186; cv=none; b=u7ora6TEQbAZ+LMFOdk4tDT+QqXIn4Za1WObLIM2fBp+9cJlQ7SAV9fK5URpEVZ2eC5HdjqslOyJ0OH2Cyra6YLAMJZFeJcVCtv8MBMS6UYmfcdyMwt+k3yM73eeoWN7z+fjwYiwD6Ci3ShXG2QatTwluZ9UBzn3lbL/TrHrWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336186; c=relaxed/simple;
	bh=yt6TEgrfn0/tkBWZBheWFpaehYINa8K9TEr07/GyOQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMl6hFB9r6PWKAfOIt2PfUVgWbLCtUeM5t/OCjW+sDUOd84ntFN9aev+FornZNh+T3mqGak+RWe/rt8J9sxJoTDskZAxJw83CJoKfoHTaqLZWqKU/TD4WVqqiENUA8Mhd0kY/GrbuQ7vpcEi2UUTKYRrb9u7uJ0AevoETCXqrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC76E1007;
	Tue, 30 Jul 2024 03:43:28 -0700 (PDT)
Received: from e127725.manchester.arm.com (e127725.arm.com [10.32.102.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F333F766;
	Tue, 30 Jul 2024 03:43:00 -0700 (PDT)
From: Debbie Martin <Debbie.Martin@arm.com>
To: liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: arm: Add stdout-path
Date: Tue, 30 Jul 2024 11:37:58 +0100
Message-Id: <20240730103758.907950-1-Debbie.Martin@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add stdout-path to the Arm devicetrees to specify the primary console.
This means that distributions can boot without the need for
platform-specific command line parameters i.e. they can use earlycon
with no parameters and no console argument is needed at all.

Signed-off-by: Debbie Martin <Debbie.Martin@arm.com>
---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi | 4 +++-
 arch/arm64/boot/dts/arm/fvp-base-revc.dts  | 4 +++-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 93f1e7c026b8..083be35495b3 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -18,7 +18,9 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	chosen { };
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 
 	aliases {
 		serial0 = &v2m_serial0;
diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 85f1c15cc65d..19973ab4ea6b 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -24,7 +24,9 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	chosen { };
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 
 	aliases {
 		serial0 = &v2m_serial0;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index afdf954206f1..7f7226711d4b 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -23,7 +23,9 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	chosen { };
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 
 	aliases {
 		serial0 = &v2m_serial0;
-- 
2.25.1


