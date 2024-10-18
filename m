Return-Path: <linux-kernel+bounces-371347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A39A39E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE854285770
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A11E9083;
	Fri, 18 Oct 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="qjJc2l+G"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C1192B94
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243381; cv=none; b=hVQn3W0FZKNFKR1OTMwfKbh/vgZQkx1Q3iuIzwDCOFCX5xW6eCeC3qPKA7CmljK3jiP0McZiWwDy6gEHTXKZ62LLWH/jBing8BKR+WUttW1ERmMcWveBW9CmfvgJ3vlf0Z++nYUdOUH8TrNVr1A72EFsvP2+4BY3cYd2QtZ3e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243381; c=relaxed/simple;
	bh=rTqntKDVf0EfoOxPycYjN4EHhnzbh96V64uFLJzfjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxB+ZxfEGafM4cQ5Nl/QzuPMKct6tvuO1xIxwr48/5+oAx55cVe93saDdfbU84YL7QZux4mGHjxno/Ebd9/h0OjIWc3zivTTTzx6NFttF3o9RBZzi4ehXQ99vf+Yt6d3sxINi1U3Trr9n64tgSXt6f2Stpo86F2V2trX5SpJQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=qjJc2l+G; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729243376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yPWX9mnHF8dLFEMgA3FdWK9Mm/mngUWWAofNS10id9Q=;
	b=qjJc2l+GGaJm72JmtKwzwS0EMiB4dtw0Z5gmx6TAMjvGOe3JfcbjeYWnq9eqV9rW5JKIJu
	9PUauhgQI2LmVYgv9q7cfMLjGBGyFl0fxWKeNboGfYy0fpmChgblexG9rPd/OPB7T7afwF
	DwThEEDwt1ZRycE29hbuwKLR1DTC2ezg65mF1Hr0RDzAdhFmExlBc5Mk/mrTkDYpEuHR7O
	hlzJ5nzbM3d3tlciE8/f+5vmNTx7c9yMEL1sx7+JVFf4YfdRcIV20iHLHa7aBm69KN2f21
	o7at7raJoTd6SxldQBRrlTFSz0a7KqURvu2r11e/iSUUvu/KYgui4cIUCPLSFA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Samuel Holland <samuel@sholland.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes
Date: Fri, 18 Oct 2024 11:22:18 +0200
Message-ID: <20241018092237.6774-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The GPIO polarity of the 'shutdown-gpios' property needs to be
ACTIVE_HIGH or the Bluetooth device won't work.
This also matches what other devices with the same BT device have.

When changing from 'reset-gpios' to 'shutdown-gpios', I forgot to also
correct the GPIO polarity, so do that now.

Fixes: a3a625086192 ("arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index a477bd992b40..0131f2cdd312 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -688,7 +688,7 @@ bluetooth {
 		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
 		pinctrl-names = "default";
-		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
 		vbat-supply = <&vcc_wl>;
 		vddio-supply = <&vcca_1v8_pmu>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
index e9fa9bee995a..1e36f73840da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
@@ -404,7 +404,7 @@ bluetooth {
 		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
-		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
 		vbat-supply = <&vcc_3v3>;
 		vddio-supply = <&vcc_1v8>;
 	};
-- 
2.45.2


