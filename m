Return-Path: <linux-kernel+bounces-519312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792BDA39B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B9D1748D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0652417FB;
	Tue, 18 Feb 2025 11:49:43 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A23F276
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879382; cv=none; b=KKXCXUazBbsH2p7SNj0Oulu93orBF5E+TQ3VnuSiZ+UR4JBa6Nl7pRBva+0wqROIyPkXcchDa1O55Z/m2Mfb03mIwO53Rva/yjMsaDG/+pnzhXTWMSjlLlkQTVEdLZJo3hffv2hzkYf1y6dgADywq4UK9LfM6CK8DwFFH25hRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879382; c=relaxed/simple;
	bh=FwLf1UZIk5/GTxe6EOa/ADZNOT5qm/PDTJRgM6wvFCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9p0eaz9DPyyyRhKakxcLs3XDIOjMWbd9VO//kyegFzflkozNNd/SeQXV4HR3WyXX4z9YZo2Vltjh7zhnaL+5zZy30Q9/x+RdcBCyUHt+PbOvKzhCcXx4/UnnUV/V5CwdARHyhGLNCGoT1s2t8pJFAIgHxMZ1fq4rDDteq5SGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVh2r7vz4CR;
	Tue, 18 Feb 2025 12:49:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVg6HY7zkRX;
	Tue, 18 Feb 2025 12:49:31 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:17 +0100
Subject: [PATCH 6/9] arm64: dts: rockchip: add EEPROM found on RK3399 Puma
 Haikou
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-6-5c44d1dd8658@cherry.de>
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

The Haikou carrierboard has an EEPROM on LVDS_BLC_CLK/DAT which are
signals that can carry either I2C or be used as HPD for eDP0/1.

Only eDP0 is routed from RK3399 Puma SoM but only exposed on Haikou
through the Video Connector, a fake PCIe connector. So to be able to use
eDP one would need to use a Device Tree overlay. Therefore, let's
default to having an EEPROM in Haikou carrierboard DTS.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index df8a8ec582ecc6830ef11be372f204057759d1f3..bea146d0d3f02afaf5e406d61d9a8ab7476fa8df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -185,6 +185,16 @@ sgtl5000: codec@a {
 	};
 };
 
+&i2c7 {
+	eeprom@50 {
+		reg = <0x50>;
+		compatible = "atmel,24c01";
+		pagesize = <8>;
+		size = <128>;
+		vcc-supply = <&vcc3v3_baseboard>;
+	};
+};
+
 &i2s0 {
 	status = "okay";
 };

-- 
2.48.1


