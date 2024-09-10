Return-Path: <linux-kernel+bounces-323918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B290C974539
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FBBB24E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250861ABECE;
	Tue, 10 Sep 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF2eL0nE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B841ABEAA;
	Tue, 10 Sep 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005575; cv=none; b=DGUIWKwn3OGrWMBrr5swqTnVUxqhpEslN+qXGF4TeD479d+N4z/ai7nlkyGIzihzB9Vsr5y9NqUPfw3bmUwE99Y/OohSrxGmfnuZwwxKeN7hdVm2cPF94pru0uBaSam8yXHmAJZV0P8g8DIxt8YTWYl9Xl+Ykg62h9f4Kr0aknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005575; c=relaxed/simple;
	bh=sHbmyeDsKsQ0beMtDxdRFghyuxHXTudSEs0ygX4hnS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjAPSgTi1DpnqQyh9jfm79zwHv7sKSUzi/xKpcuZLSYBFai6oQOusGKpCY0T1cpI76N4mFKPxstMHqCOZK+Et1Wq8UVx/jex+OIHv+EEvJUBYm31VkTrcGqNhwP/laOITOpJoaaQ2D5RrzT5BaeDMsiPkckiFHWqUosQOobBH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF2eL0nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD480C4CEC3;
	Tue, 10 Sep 2024 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005575;
	bh=sHbmyeDsKsQ0beMtDxdRFghyuxHXTudSEs0ygX4hnS4=;
	h=From:To:Cc:Subject:Date:From;
	b=sF2eL0nEPcvKbRNKhif6TOqup2fkjV1cIJPPEzEUANmqRGEenf/yIdtl/VgxMpZOJ
	 0dXMp3ee1ys0rLLGOxPOEckR21n8ccgly7d1Hbg6BapIDJaRC22HiPoccqbfzjEcpa
	 TM5HVatEYBrdiZiCnHYhh9efV6IA6RDCQM6GmEXmiUz2jG4AY76xc0qpAaeMXSg7WO
	 IbZInWXlRzgCP2uX40ajPNV6oQlelA2ZZnOmMFFM0bWu06Axv9pbl6C9xPlrfqO1Fa
	 uaU7a0PIBeD8udfJQbQ+hwDLgkm9vJMOo0S3RQou6/w7h8sz/1IQhFyxPIdgTpjbXu
	 QZxkB4EG5bc5Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Fix at24 EEPROM node names
Date: Tue, 10 Sep 2024 16:59:29 -0500
Message-ID: <20240910215929.823913-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts  | 8 ++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts | 6 +++---
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi     | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
index 983853eedaef..fd361cf073c2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
@@ -381,7 +381,7 @@ SMB_IPMB_3V3AUX_SCL: i2c@5 {
 			#size-cells = <0>;
 			reg = <5>;
 
-			U190_fru@51 {
+			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
 				pagesize = <32>;
@@ -460,7 +460,7 @@ &i2c3 {
 	status = "okay";
 
 	/* MB FRU (U173) @ 0xA2 */
-	mb_fru: mb_fru@51 {
+	mb_fru: eeprom@51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
 		pagesize = <32>;
@@ -472,7 +472,7 @@ FP_U1_tmp75@4a {
 		reg = <0x4a>;
 	};
 
-	FP_U4_fru@52 {
+	eeprom@52 {
 		compatible = "atmel,24c02";
 		reg = <0x52>;
 		pagesize = <16>;
@@ -593,7 +593,7 @@ &i2c14 {
 	status = "okay";
 
 	/* SCM FRU (U19) @ 0xA2 */
-	scm_fru: scm_fru@51 {
+	scm_fru: eeprom@51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
 		pagesize = <32>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
index b8f0b08018a3..98f3e0437704 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
@@ -154,7 +154,7 @@ i2c@7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-					at24@50 {
+					eeprom@50 {
 						compatible = "atmel,24c64";
 						reg = <0x50>;
 						pagesize = <32>;
@@ -196,7 +196,7 @@ i2c@7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-					at24@50 {
+					eeprom@50 {
 						compatible = "atmel,24c64";
 						reg = <0x50>;
 						pagesize = <32>;
@@ -205,7 +205,7 @@ at24@50 {
 					};
 				};
 			};
-			at24@50 {
+			eeprom@50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 				pagesize = <32>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
index 1a5b25b2ea29..16815eede710 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
@@ -291,7 +291,7 @@ &i2c11 {
 	/* SMB_BMC_MGMT_LVC3 */
 	status = "okay";
 
-	at24@50 {
+	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 		pagesize = <32>;
-- 
2.45.2


