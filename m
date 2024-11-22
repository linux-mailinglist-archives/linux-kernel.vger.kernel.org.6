Return-Path: <linux-kernel+bounces-418465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077E9D61F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C651614E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118E1DF99C;
	Fri, 22 Nov 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="jkstMUKR"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4D1DF255;
	Fri, 22 Nov 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292229; cv=none; b=lXTCVlKc/N1MkbTVQWjZ/eUg5x+aBzDg8jsSNrX3B3kl6MpiuqvxVbTpp9GNW0AHbYjMkjJqNb9wUQ0iA4XidNbGKtloevBVyBLAQjZjjSg1w6rov85yxxmw2wRzxK6vBYZR5+xPy3T4kj7rw4s0sk25JpS5h3+6CN89XtE26DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292229; c=relaxed/simple;
	bh=wsuI6gv0q9tfLPXfBuW2/25U08FQF/pHMaCA7KwDTmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOl9c5gaNne3qfvtD/LcwiK7LTR0VyobK9qiwT6uGV0BUjUqANHaG8O3nks0+Z8ahPNXECJ6QLLPL/NMXMehx6xZqzRduCnVkBbRrIVja+alDYdZfTe1lGYx7HPXxoR6PhD99/TNnAH2kgTc4Nfwu8LSvbE+9HHKke4PZ5NM7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=jkstMUKR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DB85FA07F6;
	Fri, 22 Nov 2024 17:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gF4/ZNsAK1S1Q0ruvMfp
	DSairoKQHeLYMeqLyk6oG4w=; b=jkstMUKR6uP9DJG117rIpSBtSfT4RLi0NXnq
	/Vl8cprilhGgoNsUfeR9+nrhZN9z2NlnGa7xuBQxQfgXdMoGNbckO7anFVRet/h1
	IpkJA5uKUbT1yCBI2R2XXpK38j9BAf+Kll6xE66cnj5Z1T2QRYuIYJ1dkO6TdwpB
	yaXfFbdd0NBxVTjah31vRmx8UO2oD8USLlshascmomVYnJ4uJ0KmK5UEbcEGt4zZ
	tnK2hr1WmaRVs1+nBCksqRKQ0RpvE9EPCZ5U+TcicVidv6ZxWwrtwrK4q6+oFTJY
	3GSq+XCHVY0GncrHk0ke6SJGcUcq3pcMa3VXaV/L20rjDHP5IDJ1yHYck6VZUmo0
	LAto7wBWezQcj4h4lbNmj6kbVs3KEhOPA0x2uvmloMnwq2TuwkpAp2wAVAFdA5+t
	OeIOhNR8mnJ36lVvrKp6kxUztClesvgnk4NL3I6x+kVPc+NG37r/isQsvyCNEYuP
	cRT7HjVMkUp9h44sALoI+lpiLfdC2PIqAB8ubNc7ALG2R5/P2/OT2GS0S3rHWyXf
	7uWMhf5psGMeURL0CUXixityrHB88pj70mIjbMN1YM6Ilb2dhFfj0omtZ8oNQv44
	RvyKKrFf7SsYsbbY8Wj+16bShONC65u7S7yHtwZNH7qaK+zhpbW+6wMUBeIALm1a
	LtjZ+oo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 5/5] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Fri, 22 Nov 2024 17:11:32 +0100
Message-ID: <20241122161128.2619172-6-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122161128.2619172-1-csokas.bence@prolan.hu>
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732292224;VERSION=7980;MC=130815470;ID=75612;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607263

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



