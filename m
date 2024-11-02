Return-Path: <linux-kernel+bounces-393255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F89B9E53
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEE428305B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182D116B75C;
	Sat,  2 Nov 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Aax1zlUo"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382E1662E8;
	Sat,  2 Nov 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540198; cv=none; b=dyxLhQYMFboNTI3aY0MQ0M7ShLR9iwRU562s6cOtjrQPAnS0uoNhKZSbaDZwjEx38uQzuY6GiY29IH7v3smAuBnZTm38Z4pDbmLsT3AwPGMrSIUgFx0Y5fv1EtBp/LhRT/OWnr5LNt3L6S10N2VyucyrleI3sqKqnXmcf8vPLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540198; c=relaxed/simple;
	bh=wsuI6gv0q9tfLPXfBuW2/25U08FQF/pHMaCA7KwDTmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEUjkRs7BJEzLcVC3E0ZtiUt+AXsQuQKUJGtqhYgL4PAiNaXrt3HM80shTrg/p3t0qirSnsDM5duOUgdRm+56xPseJPjmhJvpUNEpIZ/JzCo9H2otGStNyduSQZpn0our/gMQBWkzPA/0AQ1CW9pyv+QocPGDgfsxDeprPMByfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Aax1zlUo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7A705A0B13;
	Sat,  2 Nov 2024 10:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gF4/ZNsAK1S1Q0ruvMfp
	DSairoKQHeLYMeqLyk6oG4w=; b=Aax1zlUo5IrrmsA+XX6SDjcSAQkEwxNfJ56L
	bP827L6qd0N+lU0F5auKJy/y3r5mZN+yB8OM3FGnQwnBWbBgx30u4qQenmu/e8do
	KI+x4C2dEG0LgWQR0ZepfZ0HEMpofPMxUTwqM/u/DLkTWR8G4LYa0DJkb5BJ1ujZ
	nCyihq97aBo8krJxLY07urhZpC+cBs/fvuBO+fkjubUKxF5bedhD0GkPqOaGA3vE
	I8C4XM5K9m6z5M1jZ64rj5rxK9iMgScs7a8KoRb4A09jrljj3PsR9bPnfS+Wrqs8
	aj+eQiVadv+8VtYBGZ6Y4kRS4IPuC1ZQimbiY5os6RBfjQ/Cdx/u+7LGmIpXeeZa
	MQ+L3qrXJWPN3oWMCfiHEf3glekwftBK+nZUfBwbdqsN8dSCuo7iYEnVbpF4Bi1W
	Wuuv203zZ5unzZHmMNW0b3RiY/4D+kzPTIoDC/niBxbWYWzIwSmXqQoC4kCvFnU9
	PWhlUFiH6X1Q+Un6lvPdw6QTZ+PbR6QQxaY/6U+aX9nypR0Wgb1h/i1kiqzlSX2E
	v+vv2vM5GMPLXS9ziIxrP9HuSibFpg30wxNvbsVdlopGqJB3OotTwoFxADI6fsik
	AIGWhhYiBbFn55Tlj1660kE84yjLMC0vzVh4rzsodga+YkgZbuNEFoL8uoyPzn2L
	BAgiwrg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 5/5] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Sat, 2 Nov 2024 10:31:44 +0100
Message-ID: <20241102093140.2625230-6-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102093140.2625230-1-csokas.bence@prolan.hu>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730540194;VERSION=7979;MC=2738325872;ID=220022;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has DMA support. Enable it under device
tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
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



