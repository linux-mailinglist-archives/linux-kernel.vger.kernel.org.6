Return-Path: <linux-kernel+bounces-272100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F094570B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE58282D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6853389;
	Fri,  2 Aug 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AN+C2fvK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783C3E49D;
	Fri,  2 Aug 2024 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572770; cv=none; b=UuN0f2QQMDp5ukofC8wyNr0R8GWlkE/0goYTsWR+FZ2nktYNnirwzi/vIOlUcSPY5K2a7vqqQouhV0d/iVMeZIeOiRoDgr8WWR387yx4SfTNKsJvDNxX9pvfBU6zVu4hy+BVekMXKIC2dFl7CmhKwRKMiiIR4DDdddliRG8+0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572770; c=relaxed/simple;
	bh=mCCyxv4F7Wm9NZcvL/2iPPp6PIMjKHAKWxNfMXTWsJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gizuwAhd4fP4T1FCPq/MwMX976cny3PlwlaDy78QT2OCHi8lKr++eiDq5CNgbxzGxcqskfaW8oHfdI/fVpmCR3Inj8tr3axPic0UzK4VJ8CJLc7gCQpbSPCY/YTC+oheAlQQ9lYqjNQ0mwtw6n7nEmih31Nr6pjORayzl5NibwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AN+C2fvK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572767;
	bh=vpxoEpHBuhmIeNKLI9W2DF35VDetA88m7ofJVzrN7Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AN+C2fvK/Qy1SRVKJ+RLxPoaLE25plXPKLTeI3Q8m5qK2vFb7/KbHU1R294rv+//C
	 RJnWD30fMRQ6O2oDiLTrGgFGg1q8Ik6WXMoCEMKx1Bv05chv4uUEkZeo47ZjILQbaQ
	 kjjR60yiE+RMOpX1t17JRcl0pxuraFSahoZMEzUnQMEliq5Ry3TERJRE943t9AmDvn
	 +r/3x1ybUSTBzwnr/G2aEDRI1Nr9yut+KUfMly1egpzFu8Nqr4tHIepiR1kTVIZiTb
	 s1EGUfeUagPOLpLbouuNEiQrHeHS5RryytVsbNOdei4XCZPIPrU9QzlMvMJSxf6UqA
	 BQWR4cAPyqEEQ==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8058D66E0C;
	Fri,  2 Aug 2024 12:26:06 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:23 +0930
Subject: [PATCH 6/7] ARM: dts: aspeed-g6: Use generic 'ethernet' for
 ftgmac100 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-6-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ftgmac@1e670000: $nodename:0: 'ftgmac@1e670000' does not match '^ethernet(@.*)?$'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 6505eebf91af..ae8aa54508b2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -231,7 +231,7 @@ mdio3: mdio@1e650018 {
 			resets = <&syscon ASPEED_RESET_MII>;
 		};
 
-		mac0: ftgmac@1e660000 {
+		mac0: ethernet@1e660000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			#address-cells = <1>;
@@ -241,7 +241,7 @@ mac0: ftgmac@1e660000 {
 			status = "disabled";
 		};
 
-		mac1: ftgmac@1e680000 {
+		mac1: ethernet@1e680000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			#address-cells = <1>;
@@ -251,7 +251,7 @@ mac1: ftgmac@1e680000 {
 			status = "disabled";
 		};
 
-		mac2: ftgmac@1e670000 {
+		mac2: ethernet@1e670000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
 			#address-cells = <1>;
@@ -261,7 +261,7 @@ mac2: ftgmac@1e670000 {
 			status = "disabled";
 		};
 
-		mac3: ftgmac@1e690000 {
+		mac3: ethernet@1e690000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
 			#address-cells = <1>;

-- 
2.39.2


