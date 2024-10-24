Return-Path: <linux-kernel+bounces-379293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4D9ADC95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0388A1F24EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCB18B485;
	Thu, 24 Oct 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ppn5uSTq"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBA175D2A;
	Thu, 24 Oct 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752663; cv=none; b=KnezRHvFnEJs8n5gYu8pAdJQi9UvlVuVN9qVQ2fmrwiXO8fFPP/OnuuZZH2dqj4uUoadKlnoPX9pqm3mtBsRymh+kxu/jKSMjij+O9xTcl7vETH1l76anxFACpBFK4slH9lmJvJuJ+RS8LeQwaD9k/99IQH/JTGxl0QJB4ZkEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752663; c=relaxed/simple;
	bh=SJueQp6lPujB75PnUumwluBypQomER8qJPFdS9KBnIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfMTN7XfmYjNi80Rqmi5ZwP4UomCP8XciwFw7fgdRaPrkq1kFHBH8epErduUgK5AY+cisMU3Q1sFD3mCvr3rURB5h1y9sWXM3u/5ez5L9zNHyUl+7CcXGCa2Yqg0tH/r9n9/jxvcXEKG7AfM3mBz1GmFxmIXtkU9B7g1E0OunM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ppn5uSTq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6A1C1A0331;
	Thu, 24 Oct 2024 08:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BHxLpcd00RCNuoL+3gZt
	kx3PEVczJbIGTkP8X80KDFs=; b=Ppn5uSTqhIfPq47Aot1cM9sjLOrZvMBPOzhk
	WuY8Q9rCjde2sx0xNdZMVS1Ogz1Nn3sZKln1ujzqPN/BjW03UQhk3eOLZSlKF3Nx
	ko6tEai58F7FbY900TItjTYxTcbubbF5YQVWvusV0JhpXxarW/V8y48OnA7Cjr2R
	WaE4EIQ8OXgoJuhmQ8SQmlS66UzdiiwXk0xc244KpdaAmEjxIkumQ0ZPhuoIlaRe
	AUnypPT/9XVWYJRve+p+9It8TXcvUkr2XsRfudL6Ir9dFj9clHxh8XMriZ/FfOgG
	XIVvynWGL6pa9+UEePUPpIZRPM4rJmcCH4ZgXDPGzNUe/Sl2Ez5s7l+At8hnobBt
	rpq/maYl4BcqQtZ5bKoP5F5cxSdhitBWbgyA3zLbDFVlTL6q2i/no1Qo7KmhXFwH
	mvcdekul+HBCGGhfuNLirPwY1JJZwcpx3p2B89SYYg82I2Wp5idDReHoVXGu+1lD
	1SBw5pCHOoaPICeiOPok0XnoSCk9ORnYo22LwXvY5N7ruVkOjchAtBNi8KgQbRMX
	WY06Ico2tOCAw+Phv+8x7dQdZ0nBmCYgtsn6In23OfPNVhRwjzJr1Z+tJyjVsL4O
	Tw/i/zjZogd5+A+4unvOyn9cbEjirXbcCY68yLEX4MTEzxCok5t/PgAEkS27UAag
	saJ7LLw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH 05/10] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Thu, 24 Oct 2024 08:49:26 +0200
Message-ID: <20241024064931.1144605-6-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752652;VERSION=7978;MC=3265296183;ID=135552;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677065

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has DMA support. Enable it under device
tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
index 3c61d59ab5f8..290efe026ceb 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
 #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+#include <dt-bindings/dma/sun4i-a10.h>
 
 / {
 	#address-cells = <1>;
@@ -159,6 +160,15 @@ usbphy: phy@1c13400 {
 			status = "disabled";
 		};
 
+		dma: dma-controller@1c02000 {
+			compatible = "allwinner,suniv-f1c100s-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <18>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <2>;
+		};
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,suniv-f1c100s-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.34.1



