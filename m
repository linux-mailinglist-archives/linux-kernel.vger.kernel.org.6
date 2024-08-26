Return-Path: <linux-kernel+bounces-301954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4A95F7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556D12823A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2219A2A2;
	Mon, 26 Aug 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="otH6byq0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351419A297;
	Mon, 26 Aug 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692949; cv=none; b=QF+2sQ5BYbM1j03JQrcRxeSx7NGtetBpNZ9gLp2kaIGEzRu0yFlq2FrY+BLF6/IXG88VBSGdy5GjeYgR17yl1g0tY2Q5sp+cwHLQit1OANsobu5J3lGjHF8KrhPeepu1YnQHp3EmQhXabh7Mkrd8TUvH8rSOlULcLp/wySIm5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692949; c=relaxed/simple;
	bh=bpOlassBoRg3W4gbLK1G5G0YGPD63Zsyvt4g9z263Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z6GMmETnF6e+7N4HGlYAJbG+Q4jac5KAVCoSsa3+BW84AOX13uvXtdserWBIVyMtk0pfcgSQniPU5YK+nt0TyjKxPsMuC1wMJNVV/dWGcg/UdB7Cd9BRZP0+VPEAXsgk6afG98sxZJe4dB1q+58GgQhWaWaWgZw4F61/NNqlqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=otH6byq0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMC1E094914;
	Mon, 26 Aug 2024 12:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724692932;
	bh=/GbKinL0/RqB9zbP+apeHK9jvdDZ5VkCm+UQxHXIvEw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=otH6byq0//+j9ubVuafTT07Udfcte19xGfkbR4UHvpSajCt/n4xcsewcMjRJ5NsZo
	 c1c4cpw5W/jjKodLoxmdLLRCs66OS+D0qRUG5Qek3C69GLRm2/nMiqYv7ufGv04xIs
	 H9gEoBj07wz1AGKjixIdYPQ0ZR4r+1OZW6Uhhj1g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QHMBFs007851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 12:22:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 12:22:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 12:22:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMB0i123213;
	Mon, 26 Aug 2024 12:22:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Aug 2024 12:22:10 -0500
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-opp-v3-4-0934f8309e13@ti.com>
References: <20240826-opp-v3-0-0934f8309e13@ti.com>
In-Reply-To: <20240826-opp-v3-0-0934f8309e13@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=bb@ti.com;
 h=from:subject:message-id; bh=bpOlassBoRg3W4gbLK1G5G0YGPD63Zsyvt4g9z263Eo=;
 b=owNCWmg5MUFZJlNZxCdgMgAAaH///37/vj//3Tf3z1fsdS33z6pvaN/+Odvv149/jB3cwc6wA
 RtlB2oAekA0BpoNGjR6QGQANNDQBpoDR6gDQANGhkNGj0gaBoND0mINBtCY0xQ5AGg0GQZDQNMI
 A0yNomJoMmmjIGmjQyBkMhiNGBNAANBow1AMTIaaZGIhkyYgaGgNAaPUYmTEGRkNNGhiBiaYQaY
 gDIABtCBkGRpiaZA0MIAZBgOHcyiHXlROfJTC5KLGLrAAS4PSIOPLAz0zIdySGdgBNh6UckgAtR
 7+gTLmnZcTCu74R9Sy840F6XeALnybi9+ENp5t79cRMsnHrbcy3IcwRum9rN/UB0LKtASJGRwUL
 UMrRumkyuB0pNNxFXVnMVLNRovrt8dRn4dcR2sCqEg03GQNT6ryYnIaOHkUCSs216AvUBfQqJ2X
 3GjPZC3vMWPEUAiHuhQhw2mfBlc4q0apZD07AH76EPDtvqvYjyUfiWKX/Aig04KXR8X1ISHbMU+
 dG9p37c48IETmnG7QCXCkdXci4S8OCKce8oTa25JZGbDJCjDDlKudF2zxYQ26+F+/E8me8RgQ+8
 tIPDGbg2lfsX6GjVgJnFsTRDAK5abRJTJ0A4OmcglWbGlWDtXWZyhJxXb0F6kLEPiDYBMITJN/b
 GK/xdyRThQkMQnYDIA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM62Px reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
6.6 of the SoC's data sheet[0] . Append the 1.4Ghz entry to the OPP
table to enable this frequency

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index ff65955551a32..ab5d7a5fc6118 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -128,6 +128,15 @@ led-0 {
 		};
 	};
 
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	tlv320_mclk: clk-0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";

-- 
2.46.0


