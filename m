Return-Path: <linux-kernel+bounces-432404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D229E4A44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C571656EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39FA63CB;
	Thu,  5 Dec 2024 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Loe0OhO7"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC68391;
	Thu,  5 Dec 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357005; cv=none; b=YNyLmC2kaCr5VFan2yyQjOkuCgIb/VkXCVTx71EZrA6xLy2Zryw4BIOTV9FVF+5EM4LcGBX72Ti9NYB8aE/ABOwMn/slMDOyVRrRskewkT3r87uNpjny87+mIMngHPvQcDexETs8lE2vhVcp1XjfRiYZMS17Jac73jK0cJ0I+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357005; c=relaxed/simple;
	bh=wsuI6gv0q9tfLPXfBuW2/25U08FQF/pHMaCA7KwDTmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmS3ia39vwb4XtvgiyZji2YteeMx7BhWUEgYEOW9Zy6YrR/kAA7eR+cJ0RiBFgYEJCwb/RB9ULp2LLd2s/CSrXmgHw2dKH5lPf5Dmtjl17P7t/rznExycJnXcIIsicgED+KtA0oh4rN4enFTh6qynCXxxTqp5e+FAHoWqBVQm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Loe0OhO7; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 61CF9A0E4F;
	Thu,  5 Dec 2024 01:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gF4/ZNsAK1S1Q0ruvMfp
	DSairoKQHeLYMeqLyk6oG4w=; b=Loe0OhO78keO1ZI0hJt2c3d7dv9aMV2/f/bW
	j6wlV07/b511+kMrUTxWjj8E6ngQB3w96JzFExXs/a3Yq4IJOX8Ux8EaMQyZGNRv
	g+k9PEj3Fa2JLXwlsVXnvUBXFp6/X4EleyuQA198Mi1Y6Bhs2KpjYho0O9N21wGN
	DRTYazKDQmI2uZhVmy2wzkjS3jnI8As5MSka0rb6gpEowm1ybO9wpjdU6JUZgfpc
	++f4+QbZNV0YywfPkFSZuPwAJFb39vGUJvXTsVlZPyXetxaU2ZB4RTWHM4LfYof1
	e44+fYyF2cZjsbggTtRVyEYpE7XzTZrr4+pB34d/UDK86n4GbciicH+iDxIo7LS7
	xWLZREHF4df37jTM0ALS788iBbv9uEA4y3KBxuZIqzxry+AitY9OYTetwm7OMWoC
	ZtlRn9C64p56MwydVX1t/xXzGp1Vg6KZmX9UqjFb1Pq2Puo+Kmgw/g5oopZoQtVZ
	wpufLej3/yn1NriJp/uOUDNBzI/yRdM0CR7dLcNY/uV6utWy7MxbL/HL2hMr/5rn
	xcvWzSYKAwiJCKIvtfTgj8f70tEEKIeAdj0D+6NukwOzO+YdKi1uEIrMms4NP0tX
	29j80spxhvoHQDEe/ySCGYFTEhdwv3oe6+UpqVji3+L1aL9Du2qVClkFlahAW3BP
	a7iQfl4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/3] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Thu, 5 Dec 2024 01:01:36 +0100
Message-ID: <20241205000137.187450-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205000137.187450-1-csokas.bence@prolan.hu>
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733357000;VERSION=7982;MC=2619784077;ID=169667;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855627561

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



