Return-Path: <linux-kernel+bounces-390504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073359B7AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F001C22994
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DAE19DF4A;
	Thu, 31 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="MH8FEco4"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196D19CCF9;
	Thu, 31 Oct 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378195; cv=none; b=J6+IeSHcKnPqjMa5m7urwW3OeMgVmcRsBC3Tx+/sIA5m1poEWH3JXI/YKD5fuuzZshu6z6wrCUQXUWqIwiZRwwjpFK7E7E55aHtBCo3bCQVf1hN/l83jr3i27yq+eKTfQLeb72CsCGlaEt4ICka5Jn/POA7h/0ksLF4B652J/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378195; c=relaxed/simple;
	bh=wsuI6gv0q9tfLPXfBuW2/25U08FQF/pHMaCA7KwDTmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTGw65rHRsm68WMhpsAr/jWHlcGpJ2jKKp89+ftZYsFHzpepUUSO3QGDBmYU1umzCdpL995Q8YocfFQzq2Uaqc6zEwqCJMGGVi3KEcxGEjOqeWPdBf6M1eH+U1X+Auhrgwd3vS606v/y/d3wKuYcgO5Fp/KdoMMngcpQkv6G80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=MH8FEco4; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DBD25A0FE4;
	Thu, 31 Oct 2024 13:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gF4/ZNsAK1S1Q0ruvMfp
	DSairoKQHeLYMeqLyk6oG4w=; b=MH8FEco4BXaLfFVoFsYXNA9B07e3gVVpr7RI
	b/zFa6vttuWsYqOON5l5UB8Ch0bybpmhMaeWAuXTRSaYuetIWK/+n5Hce/lrYb8P
	NFRKW3wPTp08EmAI2zJg3OIJCz8HoGMbUfQqAyWZAiV1TAqDVerfLnIdX3BSxEQG
	JRpbXH+L7YKEI4DcOy9SjQ0nzkf6YwbfWjxTmy/9Ur44LU2cJqnU3CIllZUMHcXF
	nujleHyZgACIlWcIkf8vNYGISwrhPpekc0ETV5kl1Q1AZGU72rTuU4ZXOB9tOdFK
	B/0L1fd5Q9xjuvsildoaibvQAfcIDPasp2XjJeX+qcJL5R9o24cUfi4P0eM0yyeq
	wjT2XcnkoeA7bbismv1NBS1ooS0rJkUTMFsgowXT1DFq2sbeKEzOPRc8Lytsihon
	jxGri+c/Uu9EW7XWf0ezLioYbEfsWyZamxCNjv15nir/ZTteqoAPa7wJ7ywA91Uq
	eppKgyDAQ6dmjXsh0ceDyEo1SrRvHuGswtJTKw2tacZf6igQsy0teII2KPhrvkG9
	M/4Y+EBTfVwABFYVa5Q95s12q5ybYQTQ0SVMo768G6lR0ItTTTgqCaGJ6r5QgZij
	i1wqOvKOo9Ju5KUPGK2BJgM8KwsKWAfzrQUi1XBBSvyxFy9XITxHkhpHgxpWvDZM
	ZHNUORU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 05/10] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Thu, 31 Oct 2024 13:35:31 +0100
Message-ID: <20241031123538.2582675-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378191;VERSION=7979;MC=4244629093;ID=207185;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

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



