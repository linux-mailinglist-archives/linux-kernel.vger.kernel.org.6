Return-Path: <linux-kernel+bounces-547814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7BA50DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D874718806DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E525D8E3;
	Wed,  5 Mar 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="TTuqd9IK"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308325C703
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210894; cv=none; b=R34ddZsA1HuIbuw3A5aRhipohzxZW0nnFvsrGwbq+a323ACP3tipTsgVGweN7Jxg09U2uLHVS5wZDqcXn9XUKtMFOecE0CTSAFaUp05K4RPQ4qDaKktESYZK3utEFIoE3pMW78oOnVtelJWrrpChUFW57P4ql48fGAcFOrE5Quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210894; c=relaxed/simple;
	bh=AxGs09u9uiYIh+oWxF1FpvlD+37fADLwbDK5t4aJ9kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtNOv1zl+pOFcuWH/uoE1Mkfk9NhbAkV/KYHXgRrr91Km5ZBi90npUyTm526b+E0k+fkjD7VJa2ckLGaekF9XnisoABWNQ0NVTjhHryHJUgagznmi3h6tfrZmhpG/BlMN9qBHaxv3x49CEUg1EKOl7hIpoJxC9ggdQxqmfE3+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=TTuqd9IK; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741210884; bh=8GR+8LG9MFmxH5Armmscokt9RPhzC4Bl9BML33zsBE4=;
 b=TTuqd9IKskAa8dCaAy0iW1RYXWz9gvUh7rJrrunBwDjz1hpQl6UXSvLruAFJqV9OTtlu4q9LQ
 D9x99nm7vQpBc3eiY+8SeFVYwdrAtQ6kUgua39eiPogXjn+goBHh/PB7rZ55NhIn/iRNQTGt6+t
 TXh9zBWWS1kVwHQ3W8pUUD7dACBh78e39uPlgLXbDqLUZiFHvHwRr5TsRB7nxetkDlEZy0q1ZF1
 igcqzQ9sFvhz3FTgXYZf5ubljILn3nNff1oAq2jHz1fqIClV9/vq5sOR8v2rYHt561p6DdnOkjI
 xaf3lLALDm+E5dkAyF6e0+t1CBcuhdPxtLIUyTmNQPdg==
X-Forward-Email-ID: 67c8c50188fb7bbab4530f5a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add SDHCI controller for RK3528
Date: Wed,  5 Mar 2025 21:41:03 +0000
Message-ID: <20250305214108.1327208-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305214108.1327208-1-jonas@kwiboo.se>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDHCI controller in Rockchip RK3528 is similar to the one included
in RK3588.

Add device tree node for the SDHCI controller in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 363023314e9c..c1a71ea81e03 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -286,6 +286,30 @@ saradc: adc@ffae0000 {
 			#io-channel-cells = <1>;
 		};
 
+		sdhci: mmc@ffbf0000 {
+			compatible = "rockchip,rk3528-dwcmshc",
+				     "rockchip,rk3588-dwcmshc";
+			reg = <0x0 0xffbf0000 0x0 0x10000>;
+			assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>,
+					  <&cru CCLK_SRC_EMMC>;
+			assigned-clock-rates = <200000000>, <24000000>,
+					       <200000000>;
+			clocks = <&cru CCLK_SRC_EMMC>, <&cru HCLK_EMMC>,
+				 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
+				 <&cru TCLK_EMMC>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
+				    <&emmc_strb>;
+			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
+				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
+				 <&cru SRST_T_EMMC>;
+			reset-names = "core", "bus", "axi", "block", "timer";
+			status = "disabled";
+		};
+
 		sdio0: mmc@ffc10000 {
 			compatible = "rockchip,rk3528-dw-mshc",
 				     "rockchip,rk3288-dw-mshc";
-- 
2.48.1


