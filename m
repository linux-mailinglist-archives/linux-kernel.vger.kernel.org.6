Return-Path: <linux-kernel+bounces-222423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC66910147
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB5284AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD11AAE1E;
	Thu, 20 Jun 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e0O0Vqeu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7B1A8C19;
	Thu, 20 Jun 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878628; cv=none; b=hmQfSBlsfuq0FLJVsEWhtaN3nqQdFI0A9Ij0OKacCGCgybsU3PuVBwLIMlbA6+vJ2qO8cppRQ6b5exaJTOa3FUU0hhCKhF1SZAwqa97QZFKWLAvY4VzzHSyQrtQB6KYIqb19aDbrO/yiPcDA0F+O0GPtyr3DxGJn0L0qPqiQU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878628; c=relaxed/simple;
	bh=5/xHxmoCi6QI9LdIQBj0+iaTN+SgQB2ZeW/Ik0I59PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md39R8hBqboRUEqhWcgYnLlFgQ9NMxmF7DKrthoQVIFuW8G7g+mN3Y/1tbth14cvA2UIfIh7cvYlTJvbctzUuXfry1pvVltuyq9Dz72ZUduKMofiJfLGzWgdxUMDfYNpyMXHNRM8NfkLiws7Vss0VeBiq33nf/dInM4NpJIhozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e0O0Vqeu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878625;
	bh=5/xHxmoCi6QI9LdIQBj0+iaTN+SgQB2ZeW/Ik0I59PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0O0VqeuzYslp1aUxg/9cFnisu00u+IzNyVfwcQZhRfJWcyf/4njYTb6reh1R7zR5
	 y6HIBpL0SSlYcWjXBdSU8O0zcCz7ww++qLzS2KWRWQCYTd7t5oLaZs3qX/c10nBI7S
	 ITdeI4jDg89jdJK+jp7QDkKs0krWRDXw4Qgc4VYORDHp799aCfpPcrjk9gWaD1BUEn
	 p4k3eehOasHDUVxktjeyGAxqgGYA7EurfPaJ6NrKNMVkJwYCNq8bX7BS1b7FUtO00i
	 CYru2O03U9TwN15rwyBzkPXg/qzISY8MEY9GvqeJ05kv/FgSqXACfIbcCrNDQpec69
	 W3nUYwheeuE7w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D8F9B3780698;
	Thu, 20 Jun 2024 10:17:04 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/2] arm: dts: mediatek: Declare drive-strength numerically
Date: Thu, 20 Jun 2024 12:16:56 +0200
Message-ID: <20240620101656.1096374-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com>
References: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devicetrees, the drive-strength property gets assigned a
MTK_DRIVE_(x)_mA definition, which matches with (x).

For example, MTK_DRIVE_8mA equals to 8 and MTK_DRIVE_30mA equals
to 30.

Also keeping in mind that the drive-strength property is, by
(binding) definition, taking a number in milliamperes unit,
change all devicetrees to avoid the usage of any MTK_DRIVE_(x)
definition.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm/boot/dts/mediatek/mt2701-evb.dts |  2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi    | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701-evb.dts b/arch/arm/boot/dts/mediatek/mt2701-evb.dts
index 9c7325f18933..4c76366aa938 100644
--- a/arch/arm/boot/dts/mediatek/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mediatek/mt2701-evb.dts
@@ -231,7 +231,7 @@ pins1 {
 				 <MT2701_PIN_238_EXT_SDIO1__FUNC_EXT_SDIO1>,
 				 <MT2701_PIN_237_EXT_SDIO2__FUNC_EXT_SDIO2>,
 				 <MT2701_PIN_236_EXT_SDIO3__FUNC_EXT_SDIO3>;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-up;
 		};
 	};
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index f0b4a09004b3..814586abc297 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -1143,13 +1143,13 @@ pins-cmd-dat {
 				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
 				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <2>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-clk {
 			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <2>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
 		};
 
@@ -1167,14 +1167,14 @@ pins-cmd-dat {
 				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
 				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-clk {
 			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
 			bias-pull-down;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 		};
 
 		pins-wp {
@@ -1197,13 +1197,13 @@ pins-cmd-dat {
 				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
 				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-clk {
 			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
@@ -1211,7 +1211,7 @@ pins-clk {
 	nand_pins_default: nanddefault {
 		pins-ale {
 			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -1226,13 +1226,13 @@ pins-dat {
 				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
 				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up;
 		};
 
 		pins-we {
 			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
-- 
2.45.2


