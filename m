Return-Path: <linux-kernel+bounces-519311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C58A39B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3201893EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9FB2417EA;
	Tue, 18 Feb 2025 11:49:42 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BE23F29D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879382; cv=none; b=kuaBsuPwzrQzMyzDo10Z5H5JDG/zvSZwbeBe0UyHOPLtEcPMAiRsn41/vv3DDvny3kVmPJ6K62M5ju2nO+JQYAVphL1i4bhXcyEnvA0dVb5CTefQTRIxo1DowbfaKYGBgR1iYKLNPgitnSjh1fsxhKvopwzaOvi26A45+ouJryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879382; c=relaxed/simple;
	bh=Njmh6w0VHxoSuWfvFkvMfNbSLEezZKnKOjqp+SRdGL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDmih3Uu8Le3nGfC7S5x1QxBUoQXFxfDaro1QUfXSS2TyCCiBpTWUs2xXvjRyql3LDHbyvss25QR6/mhpyEuymgy0GxizpBJctKVM/CnxhXskh8EKYPgfhl/bBUPISSDSjOYcZFHR+10QnWbpDp4K7FlQ546KrrEOG2k/oQWeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVj3NHhz4mn;
	Tue, 18 Feb 2025 12:49:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVh6mK1zkLh;
	Tue, 18 Feb 2025 12:49:32 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:19 +0100
Subject: [PATCH 8/9] arm64: dts: rockchip: enable I2C3 in Haikou
 carrierboard, not Ringneck DTSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-8-5c44d1dd8658@cherry.de>
References: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
In-Reply-To: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

PX30 Ringneck only exposes I2C3 as LVDS_BLC_CLK/DAT on Q7 golden fingers
but nothing is on that bus on the SoM itself. Therefore, let's enable
the I2C3 bus where it makes sense, in the Haikou carrierboard DTS.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 2 ++
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi       | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index e4517f47d519cc08ec9ee705a6f51a740687f6df..16996cc6b8b62fb4f87ab5cff7e86ba751af1794 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -154,6 +154,8 @@ sgtl5000: codec@a {
 };
 
 &i2c3 {
+	status = "okay";
+
 	eeprom@50 {
 		reg = <0x50>;
 		compatible = "atmel,24c01";
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index ae050cc6cd050f730fb8fd7e3971a166d234d408..c166a9e3cc1c30bba3ab9b6a5ce3e1f67566ee8c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -325,10 +325,6 @@ rtc_twi: rtc@6f {
 	};
 };
 
-&i2c3 {
-	status = "okay";
-};
-
 &i2s0_8ch {
 	rockchip,trcm-sync-tx-only;
 

-- 
2.48.1


