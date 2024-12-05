Return-Path: <linux-kernel+bounces-432406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDC9E4A48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E311881215
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC8208A0;
	Thu,  5 Dec 2024 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Hg8o7GWS"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EA4C70;
	Thu,  5 Dec 2024 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357007; cv=none; b=c1dVoAe7V87PeymOtK6IPYx24E3NG2XVBR6yknXbny3R/nGBDSF1RNqs2BnZJmS66KxrcP0n4RIBBfLj5HmfMiT6pKm1KiKZ4bbtDiXgTxnQwMyKHGlIi4DCFytDzaD8kmoM0eDpVnMvhYBL5g/SfrfA1EIYQ1jgNaDKaQwiBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357007; c=relaxed/simple;
	bh=o8uExKqB5qYo54a2nVBhqm5tJs6jO0jYNm2MbZM9eVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dghscYnYsv6e0K9RteLbEEWfRHjpET3WGTbqBbyQy+BtbAPF7iJkpghosUZn9wWHYEio2oCKVC3N23QsMhs7hSl4qHLRgDkBMUYta1HazNQr2zHX40heYifmFC+Ty//y7DDNrZFJGdsgDOQSt3oIchSO4RmHfQcyeR0sPi/2qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Hg8o7GWS; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id F00E3A0EF3;
	Thu,  5 Dec 2024 01:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZZCQu8PNGzbUydOutitt
	bytVy0ecwKj8suiZ8x5X5G4=; b=Hg8o7GWSUJguKoIGhZzqH0h2rQ+BFrmb7szp
	2qdUmyk0Lju44v+ZBLP5M52a5BnKklhi3S5uEMhpmc8xUn82nXv4vIuZv9GI5oQ6
	XKMnLlISbfmr3m4XFDP5HDP9gw6FQfZfwLcCCAP+1rMtkSfSSI1OZUoNmXF6NiXI
	YiFFL7mhd0HeYCmkGa0+/BXdvuW6zwjTTqp+plE/f7Tk+tKRxLw4fBEpo8kV3ydP
	oo65XQSclw5gAExUbwWTtFPSBmL7Zle8EKz6vj7iLM4GzTe8yfKWUyxFnSEQQjp1
	MycRpklAlleP3jCvH6rmKRgn7ICDHVXQn1FoLCzRo4KdJJ2h4TuYIntasdu7HRee
	a5oaZH8Oc1jg7GSaQJeIajT7lUrjKHRgfeSYk28jOo9kYi0ym1qd89RlBLqaVZWk
	YV/Xc5LglZJlr21gzoSheOpqqD1MrJ+bzDMFhvR9jAqAQTwwggeOaVSvViYFV4Vp
	SV0/LGBeFPTlaKPbaShmrB9vyfvGpIZDp9J7GjMIGNaRLGU/Er12Oxg/E42xMmMQ
	DBhily29JlITUOJuJN78yGYk/dJtKmias7C1dvYY55jbi+qWm915qrfqsZhTuT3G
	h/BwRTHBMEOHvy7SmMd+mhbaLO3iyuRiBs/vxVTYg0p1dPA7muNPDkjRFn9btpI1
	+tycfYg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/3] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date: Thu, 5 Dec 2024 01:01:38 +0100
Message-ID: <20241205000137.187450-4-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733357003;VERSION=7982;MC=1494516499;ID=169669;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855627561

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Activate it
for Lichee Pi Nano board.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Moved and fixed conflict ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
index 43896723a994..472ded0aafcf 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
@@ -62,6 +62,14 @@ &uart0 {
 	status = "okay";
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC", "Mic";
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.34.1



