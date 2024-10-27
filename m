Return-Path: <linux-kernel+bounces-383513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCE9B1CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23991C20C34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E8824BD;
	Sun, 27 Oct 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="baGeHQDq"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D133482CD;
	Sun, 27 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020864; cv=none; b=IqTWqCzlQlfa2DW4d3NznO/j3bsGToj9k+sv5LHKW//CfU2E2XyR3bFbfw5Oh3MCOGFX2iQm48qGxXv06uAgQFF78MjIm0uN1ffhBGGpojV5NLJtfwwmJir6Cr9ZjpQcmYNUAo/vC2vuLo9PGzZgADA/bcHGZ3cJU+uKhpgJ8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020864; c=relaxed/simple;
	bh=wsuI6gv0q9tfLPXfBuW2/25U08FQF/pHMaCA7KwDTmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUsJfayMeENfA1SD5NygR6C4RqUBWWgjb8y1rw523eIL02vhQ/5sKMireADc/iDMVtV5joTSWGum7lBQPZLeuRDxNC0l4uRbn1xi+4nGKws7PYJZRMYUL36dYiAtYN4s23F5SWlzz0JVoliUPDQhyJ0LI2KwJQU+q/Dkc8RfFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=baGeHQDq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CF9EBA0727;
	Sun, 27 Oct 2024 10:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gF4/ZNsAK1S1Q0ruvMfp
	DSairoKQHeLYMeqLyk6oG4w=; b=baGeHQDqsgDrw8XDXtru/hqaB85GLzQs+pxG
	DPh83UmEIplzNPbhvy9rAJjQZClXMkJz4AV0sCK+Hqu9jTjcqIjCIcktaxFbxvIA
	nMvvr6Qvz7hZexsPpUGN+cWpICUCRdvOChtNdArZ6RA+a6pfPjA4t1Lgl1ZNqchi
	mrShydZPbVNj/g1XRCpMKM3fudN9/Gxoa/ojZoGBs8tSjrHPhclFyb1wkhZhfIpu
	onECeRHPUFo+l2q7hOagQfQLJavsT4qpYIlVJfq3KVNAvxrNgqqLqdFQt3EGsGZ5
	jQfPgLPE1QKv77L0BD6shshgdvtwprTIpZ0lvybyYkpxw7sgOTfpqkzh7fhkx0aO
	cSA7BpxILhz0ovY282GRBIzAL+VWXpiUyX0aIgZUx/+iJC9RanqKSG8zuIFJt+2/
	nYgSwQ/ydBm9XGt2KSEpGfnuqiq3l8x8hE/Lq7MFXM1dhyP4da81Prr8kTmALnV4
	zCrUxNQ0LqynZi/lgHa1JY9wzYhX8kSd8aULucKR3uoKCcnoaNapY9ON4QzasuqX
	+GxWd4arWZnIf+Iu+AJeQCYt/UsGUPNDyikdyYfzFpgYx88xtzizhhk6LPgxH+Mg
	cPTcZxQv4JGhIksWoqBK/pZkueM9GZIGSEPltyNHpJ25uVHLq8baaCLZBlZoeMhA
	eVX1gHI=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 05/10] ARM: dts: suniv: f1c100s: Add support for DMA
Date: Sun, 27 Oct 2024 10:14:36 +0100
Message-ID: <20241027091440.1913863-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027091440.1913863-1-csokas.bence@prolan.hu>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730020859;VERSION=7978;MC=281948352;ID=156041;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677D65

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



