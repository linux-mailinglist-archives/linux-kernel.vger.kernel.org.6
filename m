Return-Path: <linux-kernel+bounces-272096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89F9456FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B26A1C22ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8022615;
	Fri,  2 Aug 2024 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BbNlBZh+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92F8836;
	Fri,  2 Aug 2024 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572767; cv=none; b=V+NVcsF+MmvoHs875I7qqs6DMaORKLlNJM3zHQDNfq/M2rbPXNOQtyD74TKkmsSDFYo2PKXCsj78hN93RdKtuMnPUe0NcYuV0CQvsMSacL3hybXOybsNlgFtYtTQuxfX2CdbHGG+zBxHxjfCcDnBf9/2LkqOmMBsWj7fH9CT5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572767; c=relaxed/simple;
	bh=IEHyvri3mDuKLh94AzkeCD1wbcnaO9X8mblf5QTTZTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nq95r1Yu8XHf3cIzgeCY0oefOSZ/QADPvPFM37D2K+3tH3uZfZaEyshYEXzdj1mQofGGuV9DDeQ8dksF7DOy4AXC9BpTXhy2+vajsyQZ5uScQ0YpTXDBBBh8mP9tq+sFsWDYb5OUrvpmolXhXP1Vp6cTmyDtQp/y8DpqN0c9d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BbNlBZh+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572763;
	bh=H+XJZd6Qz1b0F/2H37PFytvDYtgyyZJ1Vc0HJaY31DY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BbNlBZh+tnuelh737EZYd6gRQe+RmPTzXJbPmew8G+nQ8ZBZgnhzzVMxwspI7O/c3
	 +oKR+vWzUH9+iWXhqc4VIt35N73ngi5G+6EaJ2sMof02dYYtXjH5Z141LdLSFuehhU
	 bm6PQmeZiC3796vFmfToFIaVrbvP18WCFJZ65AiRtkkcs4lF80ZHXzGRzPe7ayYDYP
	 SVPLqV/HoXmGo7tCi/6G5qG2G2CQFypplAY0zpaMrjSfaJlxalA+mpacL8vOb9jurR
	 RdbwE9dXS2imcbssljJC3A73j4jokkKeGfbjVD7B21iJVKkXag6BmPbHjPDgpLFG5/
	 LuVz2jzclmCEg==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CAC4166CBD;
	Fri,  2 Aug 2024 12:26:02 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:18 +0930
Subject: [PATCH 1/7] ARM: dts: aspeed: Fix coprocessor interrupt controller
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-1-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

Squash schema warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: copro-interrupt-controller@1e6c2000: $nodename:0: 'copro-interrupt-controller@1e6c2000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index c669ec202085..267a0c8e828b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -122,7 +122,7 @@ vic: interrupt-controller@1e6c0080 {
 			reg = <0x1e6c0080 0x80>;
 		};
 
-		cvic: copro-interrupt-controller@1e6c2000 {
+		cvic: interrupt-controller@1e6c2000 {
 			compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
 			valid-sources = <0x7fffffff>;
 			reg = <0x1e6c2000 0x80>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 6e05cbcce49c..4d805cf344a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -139,7 +139,7 @@ vic: interrupt-controller@1e6c0080 {
 			reg = <0x1e6c0080 0x80>;
 		};
 
-		cvic: copro-interrupt-controller@1e6c2000 {
+		cvic: interrupt-controller@1e6c2000 {
 			compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
 			valid-sources = <0xffffffff>;
 			copro-sw-interrupts = <1>;

-- 
2.39.2


