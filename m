Return-Path: <linux-kernel+bounces-539893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B8A4AA6D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B441894AE6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E011DB14C;
	Sat,  1 Mar 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jRXEa/KY"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EB1CB332;
	Sat,  1 Mar 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740826139; cv=none; b=jdAPjnvR8Zt+JKogbyx3Z1k5IyInxNIbNQRRjHepyQHZx8a6khozOn963tFtW1/WWmQy4xOMeaPigTYh9Wgq/jpA4MDsY1pDOZqLq9HOF7M7CRcJa1XNa+Zcw+3yMo6hVVsCUhUuLK83tTPaLQLuFLfXbd2hSZ4ULFLIlPJI/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740826139; c=relaxed/simple;
	bh=oH6NiGwxSjELVuqZw+4pyix8JS63OndzJmq8Erv5Xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXowfhYy+/0a3XLzb4jZTtkFgfsZN4YcPbVHvW0dmtRawBKPapBFygr4g6CJCswc00gqTkyMeDxm2k0fF4pgh117TmUXCA70AllYZy2mO2UQtEaYhelZikKkH2TOWBTP3S22p7b5IrvHVZkK1LoywYQ3p06FA5fWaNMZVECMNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jRXEa/KY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6472025F03;
	Sat,  1 Mar 2025 11:48:56 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwfR_2k6Scbh; Sat,  1 Mar 2025 11:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740826135; bh=oH6NiGwxSjELVuqZw+4pyix8JS63OndzJmq8Erv5Xlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRXEa/KYzSTYx6difv4h7k7TYQziMtP99ob/mIgs3ma1mfrJ7aSoypYDqA+ilUxxZ
	 2il0efJ4ux/87uqcqlb2WXSXx1uIdIz9znZYAsQahMh8hU1hSgNskNs79oznvgmMjG
	 md3sBfksXF8cX5pUiapK8RGREeIX7IsfAUJOkojtLBQyYW9HIQzhydTPdnZraW+azD
	 8j6/PM7ezUFXx61dDHExCsZqk21VCsx7hUXTFMi6hA0up1Nz/Vh8ygfVZn5ZXwGhjz
	 fVbSynlyzYu12pMgt8+0c5tiX+YgHTNW6LjZqNa2Gn/t+D3TjOVkPIj2hG3u3NyVtq
	 V+Q0uQDWRohBQ==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on Radxa E20C
Date: Sat,  1 Mar 2025 10:48:35 +0000
Message-ID: <20250301104835.36439-1-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SD-card is available on Radxa E20C board.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index d2cdb63d4a9d..473065aa4228 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -12,6 +12,10 @@ / {
 	model = "Radxa E20C";
 	compatible = "radxa,e20c", "rockchip,rk3528";
 
+	aliases {
+		mmc0 = &sdmmc;
+	};
+
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
@@ -20,3 +24,13 @@ chosen {
 &uart0 {
 	status = "okay";
 };
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	rockchip,default-sample-phase = <90>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
-- 
2.48.1


