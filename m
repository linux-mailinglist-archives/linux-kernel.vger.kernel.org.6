Return-Path: <linux-kernel+bounces-419063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04679D690E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA861614AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA719AD70;
	Sat, 23 Nov 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hvTMn4Ay"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE918B467;
	Sat, 23 Nov 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365798; cv=none; b=sQXGwTtTI5YKEC7NzjMS55UhhhogEPigq/VALA7VunOoSVmlu4mtkDrXQ/i1Bh67ehFKAyyjQqRQryN99py8KVab78+WvfCOQTn6dzNQIPjw8aT3p2CYyxF+MRKl+cZZ9IfE2i1gk7YXRkeT4njyHekTzuGSm1kQE/HiWk6WPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365798; c=relaxed/simple;
	bh=0o/ybvqRAO1jcLDhUulxUGR1EZG2ZJoOQyCVO2qLE3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gguWyXdtrYzZVSNGzMPl0IMLsDw5BqqFI+JYaGOpIfTRzEX9y0y+dxneGX42HScnmpN+eahq3Gf/pdt99OZrS/WjfHht/fWoi2+W1ZB+UqINb88bZlNwaowL/4CqbH8vdPa7Qiedw0/lHEAPQWqYp2/fmp7ph1UVTizXJ6jSQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hvTMn4Ay; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5A2BEA0302;
	Sat, 23 Nov 2024 13:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=cA+YRD2zmFxMTLKWh4kf
	ww4HyhrJ9ewfYpcfpxYsh5M=; b=hvTMn4AyHZBgNJn4dKnz1G0TgQhVx0rLX1Ob
	rPR7qN+iyZCA5KYnIj33T3HXi8EQzKPgFBxSTwcOtwYqPJI+srq+w3KsWvCmEbfN
	UoJpLhxXU5xmhvJQIOxsZNZ6IqKd/pu2o2kw1XSAQInnLMvcnvYjzT38+evVqRCi
	dng3JR6Xs+Vt8MunbkXNN5ey25Yyr7tzKw5EGgYUcOzhWBCxIC0nt1sl5qD8goGO
	RqcKP8jiL9YaijhMe4Ou53R/WlbrXwWZ+5ntDNOtVhOGnkoBKJABFyVwPD/fH2JK
	MoxxBWp5Dh+wRVn2pXuz8/YgXu78ibR6/AxUZLDs6xR2pUBCA4kYoM9Pv18JnAQD
	UQ+pGPBfSsbmAEKiuTSmD83jxmbw56VJh1mJ5YGRN7vaDyz3S3ZPIVe1grAVnpic
	IMhquDXdZ8J6QU+s2N80r34iP46Bl/oHVnYCpDBX42eWI04mZfLuvLGG0OADrFca
	iXBB74DmQishEL9PRyoPBzSvJQMdK2dXEMlhpGe/+u6Ep51J2EwV1KQxtCkmz3FW
	lhUrZWf1IONyOLVeNq/yO775oHgMwnws7odgV24URpufb3mA1Da/QWlDB4a5JPqr
	4jS234v9n0krbF1e+Mq9h9wpjQIbhC3PS3X9pI6Ohqu4IsCwOSJGgy4I10IhV6E6
	MsVRuJ4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 4/5] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date: Sat, 23 Nov 2024 13:39:04 +0100
Message-ID: <20241123123900.2656837-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732365794;VERSION=7980;MC=3913615124;ID=80956;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560726B

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
index 3c61d59ab5f8..6f7a5db8f09b 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
@@ -326,5 +326,19 @@ uart2: serial@1c25800 {
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
+
+		codec: codec@1c23c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,suniv-f1c100s-codec";
+			reg = <0x01c23c00 0x400>;
+			interrupts = <21>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 12>,
+			       <&dma SUN4I_DMA_NORMAL 12>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_CODEC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1



