Return-Path: <linux-kernel+bounces-323915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E82974528
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40331C254E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F231ABEC4;
	Tue, 10 Sep 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+nMxCdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5B1AB530;
	Tue, 10 Sep 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005551; cv=none; b=E4i8VTQS/RQgmcxT/oWPtzAzryIiZGbx7MA5eru+ZpXGOs21EIatTFJQGdJvEHtkkNe483SDc97I+n2et/T5N559wjtmcR1LaRNAFFOKI+xRobZ7HVTTXd3i6XdgQVJl73oqwGHnllRLWes/wBtgCcrW9jMACLgOaJ1/dsCJoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005551; c=relaxed/simple;
	bh=7AFvbcy3UjqEHFil4fdBdZNCaMatS/8Gq0uXJoP2qFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETQoCsH40+ZLTQKprOLLA43jm6Kjv7f/WBfO2R574OceA+Kefl8gFHAcc5VJkyMrbOgFilsHQ80rHkr1GyfXE91B+3wFTRWeOQjomjpj5Uxs/36PMvFDWzwQ3+YgkdS7iXyQxEkpH4chKCh/dR9vCDsxn9HhH9ALxQjcca1Uefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+nMxCdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D5C4CECC;
	Tue, 10 Sep 2024 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005551;
	bh=7AFvbcy3UjqEHFil4fdBdZNCaMatS/8Gq0uXJoP2qFE=;
	h=From:To:Cc:Subject:Date:From;
	b=J+nMxCdK+K5MtMcUKJRG+itpwP4ZWd4Y9D/2K7dyxdfmOO1I/gAOmiVcY6pvUnE6H
	 48CvmZO/CUpILGaQxyw4eKayK5ID6pDAbh1F7T57NlDvH9fD8e1wkl74QV3m07PTl/
	 f6jkfiXM3WHjUEeWAz1rsmfecCzVyTrqpX2v4y66VRFQafGgTVEMiwqSgBCVB7U3z9
	 Y/3X93YuK0S3T0jO+ROlKZpdc+Nz83lNQBpsKvE+VODjdv2czeuq2DrAYrTO4za4nn
	 Ner/Obz/rYtz4fiOSavBB8mkEtdaU8vYDDQHSRVjNHpFsBNtnbVm3oV5yR/7J0Nz9w
	 3O4H/9SolprRg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nuvoton: Fix at24 EEPROM node names
Date: Tue, 10 Sep 2024 16:59:05 -0500
Message-ID: <20240910215905.823337-1-robh@kernel.org>
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
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts           | 6 +++---
 .../arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
index 9f64c85e1c20..c3501786d600 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
@@ -661,7 +661,7 @@ &i2c5 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	mb_fru@50 {
+	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
@@ -704,7 +704,7 @@ max31725@5d {
 				reg = <0x5d>;
 				status = "okay";
 			};
-			fan_fru@51 {
+			eeprom@51 {
 				compatible = "atmel,24c64";
 				reg = <0x51>;
 			};
@@ -714,7 +714,7 @@ i2c5_hsbp_fru_3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-			hsbp_fru@52 {
+			eeprom@52 {
 				compatible = "atmel,24c64";
 				reg = <0x52>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
index 087f4ac43187..f67ede148209 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
@@ -824,7 +824,7 @@ tmp75@4a {
 		reg = <0x4a>;
 		status = "okay";
 	};
-	m24128_fru@51 {
+	eeprom@51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
 		pagesize = <64>;
-- 
2.45.2


