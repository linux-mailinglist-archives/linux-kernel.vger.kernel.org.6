Return-Path: <linux-kernel+bounces-379298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151D9ADC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022AB2825B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C71ABEC7;
	Thu, 24 Oct 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mWCpdugv"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A918A957;
	Thu, 24 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752667; cv=none; b=T7qqGh1RvNdftkRSwIzyTBCGcnH2HabJyD5nYuYZhAHoQK6ar7VIAa95FrxU3cDA99iL2eHV0OqVvcSS3PzGsLtgpPtkuLzOCLoPTPrvWoEVhadQwNRdycxJK7dVX9VsoOXXHOPMfOrt1g2PpZ/JOIDBqlvCS0LPwuESvdATg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752667; c=relaxed/simple;
	bh=m7Nnpt7+Em+YtnTakZ342bSNZd7YHvDXCOvkkROzWC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIx9r0dmak94DNNFM8yM+aXdF+zNeoivd3nEbDHv34zSuPJBRDhfNRy3gOdbtXK/oLbEjO5k7LFry+3jIoyU8iVSDaj9wQHRe7ii8GWgPfYBxudTvtkCczVkRMAxH9vWVgfDz8HZDEhKvW2aQs6fNeFPJhwXIUMqWzH6F/imbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mWCpdugv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C1E1CA0DC8;
	Thu, 24 Oct 2024 08:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=VwFiDc1hiKzfuZAf7wDn
	7BLFZ2hIohDQzw55SHVWscI=; b=mWCpdugvEpYYvgldU8BpaCNf4axJdxj1yq/p
	7jYKrw5cSCxznoGf7hD/Wd4HL1SfqPjs8flitKDu4FDTuZ553uiFZ8qIILvZxOUy
	fSSH1ToY1djtUW3AyfFhxIcShhJY+gJEs3g/Zn4H1Z981rFLFntLbu2VUmgvYq27
	km+g56AD4clkYaoJh0DejslAKoH0xBxWBeZwfRcWXjFq8bhcHODJ5Au2dpWzSpuO
	B4lYH3XNXIe7vFVcQKTIh44wlCYr/5zMS9X5m/jNPXo/pWRcP3/HWdTi2jgFDCCG
	RUZgbePj3oyobtKYSailSZ94lGQUrXN9uHGFGRLLY3KeB3tNSAK8aaWMD1kRRxwS
	Ea9TiA8XqIcyquHcyxkFO3Ty7PzKXoIpUIOe9z2OnfuGfI9kjWb1OgOLG+MOC7v9
	Fkw32oDqN8HXehubHnFuhQKIrsF94zZp5rMfA4wbyGAnFuDBd3VIf++8QC+qOnCm
	5aw7Y8S9KKoS3vjcQVd2AemuVsF/0uokFeQSRofmBOadoeuGz0cLdkeMGu8IzNil
	VwX9BXwb8flw4Zh5ggbEvuMryvuOqpGn1kUe5IIzYDspfOs6okUFTgKKUuaR3T4J
	5L4m1W/wlm7UkgZnjD2+Fy2Ps7Ss/g2faks4PtbXcT3kxDHIB6w8KAmDDww/4ZDX
	/wgnhII=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH 09/10] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date: Thu, 24 Oct 2024 08:49:30 +0200
Message-ID: <20241024064931.1144605-10-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752656;VERSION=7978;MC=4016601128;ID=153597;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677065

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
index 290efe026ceb..e4b41bc93852 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
@@ -336,5 +336,19 @@ uart2: serial@1c25800 {
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



