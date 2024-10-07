Return-Path: <linux-kernel+bounces-353171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F29929A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D21F22CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D131D2B10;
	Mon,  7 Oct 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="nMEVYHon"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1D1D271C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298707; cv=none; b=KN0aj1wed0mM6UInHp1EPd9ANtQX97lpGU8TkjKqmWHkzdKk1UM4DLCXqtqvv1oWZkXPyQSwnzv0Lowc1EOPu/aKQEd/J0mbK9M+05hZxLML563Q3OLH8tLTurYI/jmzl3doOVUR6aBClGRChYr4T8Q7XzHIrQEvmgOLVR/l9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298707; c=relaxed/simple;
	bh=Xz8rrzW9RQSs0xm7MWtFUS5xcDGeS2FtrRHnUwpjATE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnKblaZrj7ccqby6WnYC4gpwqyvlu+VCPxb7UgzmwdZmdNdC6OAqkoEbSioNgpGNBsoRCqjFRirBoK2rGem5bj56KAtuSw5P/2UChVeycSS8T1Yq7Yqy8/IbwlPhcjUF1RyelATbPtmpeYQNNsD5hf5OaySKOT1OGkDiTx42ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=nMEVYHon; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728298703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adjafrSjr5X2oPPo4wCvTKycMj7Ej8xSRiHmdu4QNQs=;
	b=nMEVYHonL5IHRk7j2bInifSp0vGx16KKw9TworikV4G+nGzCAdaufVz1IvwlzYbSqCh/I2
	106Gm77pvbeMrwLyT5h9x8AXIfIwpXl8ijKBuUAw79nTor6WByAbABsidYDMzDf97YiYkW
	wMdAzMGzZD5VN3l9rdMQiQS0R+hAA8oEthR3ZS0eNSRET9kV8otLquNs1X/hbZfWgqm6Ky
	DgWBWGqUnW+ciqXOOTs4jJQT3GflqN4GcdoSG8gQu+Yz6ShbDBO8XKr/k4iE09+0+O2Xzg
	f4uY3FbzrzGVCrEBcJY0dABH/O95Yy17NStx9cVZY/DxBSmzNwiJuHVB5DrzsA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: Fix reset-gpios prop on brcm BT nodes
Date: Mon,  7 Oct 2024 12:28:19 +0200
Message-ID: <20241007105657.6203-6-didi.debian@cknow.org>
In-Reply-To: <20241007105657.6203-2-didi.debian@cknow.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Except for some compatibles, the "brcm,bluetooth.yaml" binding doesn't
allow the 'reset-gpios' property, so replace the invalid ones with the
'shutdown-gpios' property.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 7381bb751852..100a2774bbb5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -686,9 +686,9 @@ bluetooth {
 		clock-names = "lpo";
 		device-wakeup-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
 		pinctrl-names = "default";
+		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 		vbat-supply = <&vcc_wl>;
 		vddio-supply = <&vcca_1v8_pmu>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
index d09e6542e236..3e0cbfff96d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
@@ -402,9 +402,9 @@ bluetooth {
 		clock-names = "lpo";
 		device-wakeup-gpios = <&gpio2 RK_PB2 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
+		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
 		vbat-supply = <&vcc_3v3>;
 		vddio-supply = <&vcc_1v8>;
 	};
-- 
2.45.2


