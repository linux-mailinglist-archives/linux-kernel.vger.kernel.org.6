Return-Path: <linux-kernel+bounces-414358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB59D2706
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2542BB28998
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DB1CEAAB;
	Tue, 19 Nov 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="imSx+Khd"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123E1CC170;
	Tue, 19 Nov 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023013; cv=none; b=gp0Hm/pwKUOmUv8U8WByemsR+XGoEDwLtl/nqK6qyS/iUxgovRnusQcBLILMEsziPll/2CAtkV31iGeckPfHRiX9BwVZNcuG5gp+SRoKN2XkvRIl6Kt4zudGk/Pb+hsavEbn2Lgoc6HNL3wsPveeVT7juQeXbWC1xSr7ln7ie/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023013; c=relaxed/simple;
	bh=b+L9qbqGVR11JrLNz1yjtill0U5wtaM7q9wIn2S8mnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmLM50KKnwhaGcLvzd5kTj2hReXRB4bRVgklwwdRIJfzlENEjdXDcoRw8wIlAipq23kCTeg0388oukedHrSrJSFvxzksZBrLFjQqPYzMJ/NAPztLR9BK2ug6L9rEG6x+plSkwVesNW9g8ABZjso42SfP+oMoUItbfoh68s8ro+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=imSx+Khd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m/2ZD36wJW8eluwjHkCBxTv9qiyzz866KACmcI1qvBI=; b=imSx+KhdtyMNcGkm3iyHvcyggu
	EMyEs4Jr8bF2o8lQtJU7npMjZB1euyc8RWkEbplSBlaQrgOQ+7XvxmyvwE2RU1/+k6UkRWsA4PHC7
	kisi8cYA1WCEP88uiw2mGPLs4SGCNN2FLbmWLoNfH7RrYPTGQ3p+bcWyvPLTsXVlgE6S7g9H+2C1d
	K9Yo8/Uh1RG1lu4K41gYl6yM8/PpOB4+jmpYrz411M7+utDHh0/yfwSlgM5H+2slnpAlBTJEJ8jh4
	Nx0sf5FRfWEO7DEWXN/VaLttUVw+bQdfJXHAX9FrkedFrxdhbLK6HydZIGmtPGGRlF0TcYeupOdOO
	IT56mhew==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tDOIp-0006z1-Gn; Tue, 19 Nov 2024 14:29:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	sebastian.reichel@collabora.com
Subject: [PATCH 5/5] arm64: dts: rockchip: add rk3576 otp node
Date: Tue, 19 Nov 2024 14:29:16 +0100
Message-ID: <20241119132916.1057797-6-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119132916.1057797-1-heiko@sntech.de>
References: <20241119132916.1057797-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the otp node to the rk3576 soc devicetree including the
individual fields we know about.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..c70c9dcfad82 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1149,6 +1149,45 @@ sdhci: mmc@2a330000 {
 			status = "disabled";
 		};
 
+		otp: otp@2a580000 {
+			compatible = "rockchip,rk3576-otp";
+			reg = <0x0 0x2a580000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
+				 <&cru CLK_OTP_PHY_G>;
+			clock-names = "otp", "apb_pclk", "phy";
+			resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>;
+			reset-names = "otp", "apb";
+
+			/* Data cells */
+			cpu_code: cpu-code@2 {
+				reg = <0x02 0x2>;
+			};
+			otp_cpu_version: cpu-version@5 {
+				reg = <0x05 0x1>;
+				bits = <3 3>;
+			};
+			otp_id: id@a {
+				reg = <0x0a 0x10>;
+			};
+			cpub_leakage: cpub-leakage@1e {
+				reg = <0x1e 0x1>;
+			};
+			cpul_leakage: cpul-leakage@1f {
+				reg = <0x1f 0x1>;
+			};
+			npu_leakage: npu-leakage@20 {
+				reg = <0x20 0x1>;
+			};
+			gpu_leakage: gpu-leakage@21 {
+				reg = <0x21 0x1>;
+			};
+			log_leakage: log-leakage@22 {
+				reg = <0x22 0x1>;
+			};
+		};
+
 		gic: interrupt-controller@2a701000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0x2a701000 0 0x10000>,
-- 
2.45.2


